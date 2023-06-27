// genere.pas include de compile.pas

procedure GetParamDerivee(operandGlb,operandDebut : Pelement;var degreDer,NbrePointDer : integer);
begin
   if operandGlb<>nil
      then begin
         degreDer := round(calcule(operandGlb));
         if (degreDer>3) or (degreDer<1)
            then degreder := degreDerivee;
      end
      else degreDer := degreDerivee;
   if operandDebut<>nil
      then begin
         NbrePointDer := round(calcule(operandDebut));
         if not odd(NbrePointder) then inc(NbrePointDer);
         if (NbrePointDer>MaxPointsDerivee) or
            (NbrepointDer<MinPointsDerivee) then
             NbrePointDer := NbrePointDerivee;
      end
      else NbrePointDer := NbrePointDerivee;
end;

Procedure CalculeCpx(F:Pelement;var Z : Tcomplexe);

Function calculFonctionGlb(F : Pelement) : Tcomplexe;
var freqLoc,rapportCyclique,t : double;
    Lpage,cGrandeur,nbreBits : integer;
begin with F^ do begin
    result := complexeUn;
    case CodeFglb of
         pythonVar,pythonConst : begin
            result.reel := varx.valeurCourante;
            result.imag := 0;
         end;
         fonctionPage : begin
             Lpage := round(OperandGlb.valeur);
             result.Reel := Grandeurs[cPage].valeur[Lpage];   //??
         end;
         grandeurPage : begin
             LPage := round(OperandGlb.valeur);
             cGrandeur := OperandGlb.varX.indexG;
             result.Reel := pages[LPage].valeurCourante[cGrandeur];
         end;
         cCreneau,cTriangle : begin
            t := calcule(OperandGlb);
            freqLoc := calcule(OperandDebut);
            if operandFin<>nil
              then begin
                 rapportCyclique := calcule(OperandFin);
                 if isNan(rapportCyclique) then rapportCyclique := 0.5;
              end
              else rapportCyclique := 0.5;
            case codeFglb of
                cCreneau : result.Reel := Creneau(t,freqLoc,rapportCyclique);
                cTriangle : result.reel := Triangle(t,freqLoc,rapportCyclique);
            end;
         end;
         cBitAlea : begin
            t := calcule(OperandGlb);
            freqLoc := calcule(OperandDebut); // en fait période !
            if operandFin<>nil
              then begin
                 rapportCyclique := calcule(OperandFin);
                 nbreBits := round(rapportCyclique);
                 if nbreBits<1 then nbreBits := 1;
                 if nbreBits>8 then nbreBits := 8;
              end
              else nbreBits := 1;
            result.reel := BitAleatoire(t,freqLoc,nbreBits);
         end;
         cBessel,cCnp,cPeigne : begin
            t := calcule(OperandGlb);
            freqLoc := calcule(OperandDebut);
            case codeFglb of
                cBessel : result.reel := BesselJ(freqLoc,t);
                cPeigne : result.reel := Peigne(freqLoc,t);
                cCnp : result.reel := Cnp(round(freqLoc),round(t));
            end;
         end;
     end; { case }
end end; // calculFonctionGlb

// Evalue la Valeur d'un arbre pointé par F
Var  X,Y : Tcomplexe;
     Xi,Yi : integer;
Begin // Noyau de Function calculeCpx 
  z.imag := 0;
  With F^ do Case TypeElement of
      Operateur: Begin
           calculeCpx(OperG,X);
           calculeCpx(OperD,Y);
           Case CodeOp of
                '+' : PlusCpx(X,Y,Z);
                '-','=' : MoinsCpx(X,Y,Z);
                '*' : MultCpx(X,Y,Z);
                '/' : DivCpx(X,Y,Z);
                '^' : PuissCpx(X,Y,Z);
                '<','>','O','X','A','M','N',infegal,supegal : begin
                      Xi := round(X.reel);
                      Yi := round(Y.reel);
                      case CodeOp of
                        '<' : if (X.reel<Y.reel)
                               then z.reel := 1
                               else z.reel := 0;
                        infegal : if (X.reel<=Y.reel)
                               then z.reel := 1
                               else z.reel := 0;
                        'O' : z.reel := Yi or Xi;
                        'A' : z.reel := Yi and Xi;
                        'N' : z.reel := not(Yi and Xi);
                        'X' : z.reel := Yi xor Xi;
                        'M' : z.reel := round(Xi) mod round(Yi);
                        '>' : if X.reel>Y.reel
                               then z.reel := 1
                               else z.reel := 0;
                        supegal : if X.reel>=Y.reel
                               then z.reel := 1
                               else z.reel := 0;
                        else z.reel := 0;
                     end;
                     end;
            end;{case codeOp}
       end;{operateur}
       Fonction : begin
          calculeCpx(Operand,z);
          case CodeF of
            absolue : begin
               z.reel := NormeCpx(z);
               z.imag := 0;
            end;
            racine : RacineCpx(z,z);
            oppose : begin
                z.reel := -z.reel;
                z.imag := -z.imag;
            end;
            inverse : DivCpx(complexeUn,z,z);
            carre : MultCpx(z,z,z);
            exponentielle : ExpCpx(z,z);
            reelle : z.imag := 0;
            imaginaire : z.reel := 0;
            argument : begin
               z.reel := argumentCpx(z);
               z.imag := 0;
            end
            else begin { calcul en réel }
                z.reel := AdresseF(z.reel);
                z.imag := 0;
            end;
          end;
      End;{Fonction}
      FonctionGlb : z := calculFonctionGlb(F);
      IfThenElse : begin
           calculeCpx(test,z);
           if z.reel>0
              then calculeCpx(positif,z)
              else calculeCpx(negatif,z)
      end;
      pieceWise : begin
           if PWtest=nil then z.reel := -1 else calculeCpx(PWtest,z);
           if z.reel>0
              then calculeCpx(PWthen,z)
              else calculeCpx(PWtestElse,z)
      end;
      Grandeur : begin
           z.reel := Pvar.valeurCourante;
           z.imag := Pvar.valeurCouranteIm;
      end;
      Incert : z.reel := Pvar.incertCourante;
      Nombre : z.reel := valeur;
      RacineMoinsUn : Z := ComplexeJ;
    End; // case typeElement
End; // function calculeCpx

   Procedure TuniteCalc.calcFonction(F : Pelement);
   Begin
     calcUnite(F^.Operand);
     case F^.codeF of
        reelle,imaginaire,absolue,oppose,entier,fractionnaire : ;
        inverse : InverseUnite;
        carre : PuissUnite('*',2);
        racine : PuissUnite('/',2);
        aleatoire : adaptable := correct;
        codeBruit : adaptable := correct;
        argument,arcsinus,arccosinus,arctangente : AssignAngle;
        else Assign(uniteNulle)
     end;
     uniteImposee := false;// ??
   end; // calcFonction

   Procedure TuniteCalc.calcFonctionGlb(F : Pelement);
   Begin with F^ do begin
        case codeFglb of
              pythonVar,pythonConst : ;
              minimum,maximum,moyenneAll,somme,ecartType,sommeFFT,moyenneFFT : calcUnite(F^.OperandGlb);
              filtrage,RetardCorr,enveloppe,position,origine,initial,moyenne,efficace,efficaceAll,
              harmonique,lissageGlissant,lissageCentre,PhaseContinue : calcGrandeur(varX);
              surface : AdUnite('+',varX,varY);
              //pente,derivee : AdUnite('-',varY,varX);
              pente,derivee : UniteDerivee(varX,varY,gLin,gLin);
              deriveeSeconde : begin
                  AdUnite('-',varY,varX);
                  AdUnite('-',self,varX);                  
              end;
              CodeCorrelation,definitionFiltre : recopieUnite(UniteNulle);
              frequence,FrequenceInstantanee : begin
                    assign(grandeurs[0]);
                    inverseUnite;
              end;
              phase : assignAngle;
              fonctionPage : ;
              integrale,integraleDefinie : begin
                  calcUnite(OperandGlb);
                  PlusUnite(varX);
              end;
              integraleMuette : calcUnite(OperandGlb);
              EquaDiff1 : begin
                  calcUnite(OperandGlb);
                  PlusUnite(grandeurs[0]);
              end;
              EquaDiff2 : begin
                  calcUnite(OperandGlb);
                  PlusUnite(grandeurs[0]);
                  PlusUnite(grandeurs[0]);
              end;
              else VerifUniteEgale(UniteNulle,self)
         end;
end end; // calcFonctionGlb

   Procedure TuniteCalc.calcGrandeur(F : TuniteCalc);
   Begin
        nomUnite := F.nomUnite;
        puissance := F.puissance;
        Dimension := F.dimension;
        DimensionPart := F.dimensionPart;
        Correct := F.correct;
        Adaptable := F.adaptable;
        UniteImposee := F.uniteImposee;
        UniteDonnee := F.uniteDonnee;
   end; // calcGrandeur

   procedure TuniteCalc.calcOperateur(F : Pelement);
   var U_G,U_D : TuniteCalc;
       n : integer;
   Begin with F^ do Begin
         u_g := TuniteCalc.create;
         u_d := TuniteCalc.create;
         try
         u_g.calcUnite(OperG);
         u_d.calcUnite(OperD);
         case codeOp of
              '+','-','=','#','@','<','>','O','X','A','M','N',infegal,supegal : begin
                   VerifUniteEgale(U_g,U_d);
                   if (operG^.typeElement=grandeur) and
                      (operG.Pvar.genreG in [ParamGlb,ParamNormal,ParamDiff1,ParamDiff2])
                   then begin
                       operG.Pvar.RecopieUnite(U_g);
                       operG.Pvar.uniteImposee := false;
                       operG.Pvar.uniteDonnee := false;
                       operG.Pvar.adaptable := false;
                   end;
                   if (operD^.typeElement=grandeur) and
                      (operD.Pvar.genreG in [ParamGlb,ParamNormal,ParamDiff1,ParamDiff2])
                   then begin
                       operD.Pvar.RecopieUnite(U_d);
                       operD.Pvar.uniteImposee := false;
                       operD.Pvar.uniteDonnee := false;
                       operD.Pvar.adaptable := false;
                   end;
              end;
              '*' : AdUnite('+',U_g,U_d);
              '/' : AdUnite('-',U_g,U_d);
              '&' : begin
                   VerifUniteEgale(u_g,u_d);
                   if correct then if angleEnDegre
                      then ReCopieUnite(UniteToleree[indexDegre])
                      else ReCopieUnite(UniteToleree[indexRadian]);
              end;
              '^' : if OperD^.typeElement=nombre
                 then begin
                       try
                       if isEntier(operD^.valeur,n)
                          then MulUnite('*',U_G,n)
                          else begin
                               try
                               if isEntier(1/operD^.valeur,n)
                                  then MulUnite('/',U_G,n)
                                  else setErreurUnite;
                               except
                                  setErreurUnite;
                               end;
                          end
                       except
                       setErreurUnite;
                       end
                  end
                  else setErreurUnite;
         end; // case CodeoP
      finally
      u_d.free;
      u_g.free;
      end;
end end; // calcOperateur

procedure TuniteCalc.calcIf(F : Pelement);
var u_p,u_n : TuniteCalc;
begin with F^ do begin
      u_p := TuniteCalc.create;
      u_n := TuniteCalc.create;
      try
      u_p.calcUnite(Positif);
      u_n.calcUnite(Negatif);
      VerifUniteEgale(u_p,u_n);
      finally
      u_n.free;
      u_p.free;
      end;
end end; // calcIf

Procedure TuniteCalc.CalcUnite(F : Pelement);
Begin
      if f=nil then exit;
      case f^.typeElement of
         operateur : calcOperateur(F);
         fonction  : calcFonction(F);
         fonctionGlb  : calcFonctionGlb(F);
         ifThenElse,PieceWise : calcIf(F);
         grandeur,GrandeurIndicee,incert,grandeurEuler : calcGrandeur(f^.Pvar);
         nombre : recopieUnite(UniteNulle);
      end;{case}
end; // calcUnite 

Procedure AffecteUnite(F : Pelement;U : Tunite); // pour les paramètres

 Procedure aFonction(F : Pelement;U : Tunite);
         var Uloc : TuniteCalc;
 Begin with F^ do begin
     Uloc := TuniteCalc.Create;
     try
     Uloc.recopieUnite(U);
     Uloc.uniteDonnee := false;
     case codeF of
        reelle,imaginaire,absolue,oppose,entier,fractionnaire : ;
        inverse : Uloc.InverseUnite;
        carre : Uloc.PuissUnite('/',2);
        racine : Uloc.PuissUnite('*',2);
        sinus,cosinus,tangente : Uloc.AssignAngle;
        else Uloc.init;
     end;
     AffecteUnite(Operand,Uloc);
     finally
       Uloc.free;
     end;
 end end; // affecteFonction

 procedure aOperateur(F : Pelement;U : Tunite);
 var U1,U_g,U_d : TuniteCalc;
     n : integer;
 Begin with F^ do Begin
        U1 := TuniteCalc.create;
        U_g := TuniteCalc.create;
        U_d := TuniteCalc.create;
        try
        case codeOp of
        '+','-','=','#','@','<','>','O','X','A','M','N',infegal,supegal : begin
              affecteUnite(OperD,U);
              affecteUnite(OperG,U);
        end;
        '*' : begin
                 U_d.calcUnite(OperD);
                 U_g.calcUnite(OperG);
                 if U_d.correct and U_g.correct
                      then begin
                           if U_g.adaptable xor U_d.adaptable then begin
                                if U_g.adaptable
                                     then begin
                                       U1.recopieUnite(U);
                                       U1.uniteDonnee := false;
                                       U1.MoinsUnite(U_d);
     { TODO : prévoir U_d = seconde pour éviter S/s = F et autres}
                                       affecteUnite(OperG,U1);
                                     end
                                     else affecteUnite(OperG,U_g);
                                if U_d.adaptable
                                     then begin
                                       U1.recopieUnite(U);
                                       U1.uniteDonnee := false;
                                       U1.MoinsUnite(U_g);
                                       AffecteUnite(OperD,U1);
                                     end
                                    else affecteUnite(OperD,U_d);
                           end
                      end
                      else U1.setErreurUnite
        end;
        '/' : begin
          U_d.calcUnite(OperD);
          U_g.calcUnite(OperG);
          if U_g.correct and U_d.correct
             then begin
                 if U_g.adaptable xor U_d.adaptable then begin
                    if U_g.adaptable
                        then begin
                            U1.recopieUnite(U);
                            U1.uniteDonnee := false;
                            U1.PlusUnite(U_d);
                            affecteUnite(OperG,U1);
                        end
                        else affecteUnite(OperG,U_g);
                    if U_d.adaptable
                        then begin
                             U1.recopieUnite(U);
                             U1.uniteDonnee := false;
                             U1.AdUnite('-',U_g,U1);
                             affecteUnite(OperD,U1);
                        end
                        else affecteUnite(OperD,U_d);
                 end
             end
             else U1.setErreurUnite
        end;
        '^' : begin
              U1.recopieUnite(U);
              U1.uniteDonnee := false;
              if (OperD^.typeElement=nombre) and
                 isEntier(operD^.valeur,n)
                    then U1.PuissUnite('/',n)
                    else AffecteUnite(OperD,UniteNulle);
               AffecteUnite(OperG,U1);
        end;
        '&' : ;
        end;{case}
        finally
             U1.free;
             U_g.free;
             U_d.free;
        end;
 end end; // affecteOperateur

procedure aIf(F : Pelement;U : Tunite);
begin with F^ do begin
      affecteUnite(Positif,U);
      affecteUnite(Negatif,U);
end end;

Begin
if f=nil then exit;
with f^ do begin // affecteUnite
    case f^.typeElement of
       operateur : aOperateur(F,U);
       fonction  : aFonction(F,U);
       fonctionGlb : case CodeFglb of
            EquaDiff1 : affecteUnite(operandGlb,U);
            EquaDiff2 : affecteUnite(operandGlb,U);
            else // ne peut intervenir dans un modèle
       end;
       Nombre : ;
       ifThenElse,PieceWise : aIf(F,U);
       grandeur,grandeurIndicee,grandeurEuler : if Pvar.genreG in
              [ParamGlb,ParamNormal,ParamDiff1,ParamDiff2]
                   then begin
                       Pvar.RecopieUnite(U);
                       Pvar.uniteImposee := false;
                       Pvar.uniteDonnee := false;
// cas du celsius se transformant en kelvin  ?
                       Pvar.adaptable := false; {TODO verifier}
                       if uniteSIGlb then begin
                          Pvar.puissance := 0; // les calculs sont faits en SI
                          Pvar.coeffSI := 1;
                       end;
                   end;
       else ;
    end;// case
end end; // affecteUnite

Procedure tgrandeur.SetUnite;
var Uloc : TuniteCalc;
    index : integer;
begin
   case fonct.genreC of
       g_experimentale : if (length(nom)>1) and
                            (nom[length(nom)]='0') then begin
          index := indexNom(copy(nom,1,pred(length(nom))));
          if (index<>GrandeurInconnue) then
             recopieUnite(grandeurs[index]);
       end;
       g_forward :;
       g_texte :;
       else begin
          Uloc := TuniteCalc.create;
          try
          if fonct.genreC=g_diff2 then
             fonct.addrYp.adaptable := true;
          Uloc.calcUnite(fonct.calcul);
          puissance := Uloc.puissance;
          dimension := Uloc.dimension;
          dimensionPart := Uloc.dimensionPart;
          correct := Uloc.correct;
          adaptable := Uloc.adaptable;
          sansDim := Uloc.sansDim;
          if uniteSIglb
             then begin
                      puissance := 0;
                      uniteImposee := false;
                      nomUnite := NomAff(0);
                      coeffSI := 1; { TODO : coeffSI param }
             end
             else begin
                      uniteImposee := Uloc.uniteImposee;
                      if uniteImposee
                         then imposeNomUnite(Uloc.nomUnite)
                         else imposeNomUnite(NomAff(0));
                      adaptable := false;
             end;
          uniteDonnee := false;
          except
             Uloc.free;
             correct := false;
          end;
   end;
  end;
end; // setUnite

Procedure libereLoc(fff : Pelement);
begin
   if fff<>nil then With fff^ do
      Case TypeElement of
        Operateur : begin
             libereLoc(OperG);
             libereLoc(OperD);
             dispose(fff);
        end;
        Fonction  : begin
            libereLoc(Operand);
            dispose(fff);
        end;
        FonctionGlb  : begin
            libereLoc(OperandGlb);
            libereLoc(OperandDer);
            libereLoc(OperandDebut);
            libereLoc(OperandFin);
            dispose(fff);
        end;
        IfThenElse,PieceWise : begin
            libereLoc(Positif);
            libereLoc(Negatif);
            libereLoc(Test);
            dispose(fff);
        end;
        Nombre : if (fff<>PointeurZero) and
                    (fff<>PointeurUn) and
                    (fff<>PointeurDeux) and
                    (fff<>PointeurPi)
            then dispose(fff);
        BoucleFor : begin
               libereLoc(Istart);
               libereLoc(Iend);
               dispose(fff);
        end;
        Grandeur,GrandeurIndicee,incert,grandeurEuler : dispose(fff);
        else ;
       end; // case typeElement
end; // libereLoc

Procedure libere(var expr : Pelement);
begin
   libereLoc(expr);
   expr := nil;
end;

Destructor tGrandeur.destroy;
begin
     fonct.free;
     incertCalcA.free;
     incertCalcB.free;
     inherited destroy
end;

Destructor tFonction.destroy;
begin
     libere(calcul);
     inherited destroy
end;

Constructor tGrandeur.Create;
begin
        inherited create;
        nom := '';
        valeurCourante := Nan;
        incertCourante := 0;
        valeurCouranteIm := 0;
        incertCalcA := Tfonction.create;
        incertCalcB := Tfonction.create;
        fonct := Tfonction.create;
        fonct.expression := '';
        genreG := Variable;
        fonct.genreC := g_experimentale;
        AffSignif := false;
        GenreMecanique := gm_position;
        isCurseur := false;        
        nomVarPosition := '';
        varInit := nil;
end;

Procedure tGrandeur.Init(const n : string;const u :string;
          const e : String;Agenre : TgenreGrandeur);
begin
        inherited init;
      	nom := n;
        fonct.expression := e;
        fonct.addrY := self;
        genreG := Agenre;
      	if Length(u)>0 then NomUnite := u;
end;

Constructor Tfonction.Create;
begin
        calcul := nil;
        depend := [];
        expression := '';
        genreC := g_fonction;
        addrY := nil;
        addrYp := nil;
        isSysteme := false;
        contientCalculGlb := false;
end;

Destructor Tmodele.Destroy;
begin
   residuStat.free;
   residu := nil;
   inherited destroy;
   libere(fchi2);
end;

Constructor Tmodele.Create;
begin
   inherited create;
   indexX := grandeurInconnue;
   indexY := grandeurInconnue;
   indexYp := grandeurInconnue;
   implicite := false;
   genreParam := paramNormal;
   enTete := '';
   IsSinusoide := false;
   IsCosinus := false;
   VariableEgalAbscisse := false;
   residuStat := TcalculStatistiqueResidu.create;
   coeffSI := 1;
   fchi2 := nil;
end;

// Compilation

// Les procédures GenXXX génére un noeud de l'arbre Pelement correspondant
//  à XXX pour dériveeForm, Fonctor et transformeComplexe

Function GenNombre(ValNombre:double): Pelement;
Var  P : Pelement;
Begin
  if valNombre=0
     then GenNombre := PointeurZero
     else if valNombre=1
         then GenNombre := PointeurUn
         else if valNombre=2
         then GenNombre := PointeurDeux
         else begin
           New(P);
           P^.TypeElement := Nombre;
           P^.Valeur := ValNombre;
           GenNombre := P
        end;
End; // GenNombre

Function GenFonction(I:TCodeFonction;P1:Pelement):Pelement;
Var P : Pelement;
Begin
  New(P);
  P^.TypeElement := Fonction;
  P^.CodeF := I;
  P^.Operand := P1;
  P^.AdresseF := AdresseFonction[I];
  GenFonction := P
End;// GenFonction

Function GenVar(Avar : Tgrandeur):Pelement;
Var P : Pelement;
Begin
  New(P);
  P^.TypeElement := grandeur;
  P^.Pvar := Avar;
  result := P
End;{GenVar}

Function GenIncert(Avar : Tgrandeur):Pelement;
Var P : Pelement;
Begin
  New(P);
  P^.TypeElement := incert;
  P^.Pvar := Avar;
  result := P
End; // GenIncert

Function GenGrandeurIndicee(Avar:Tgrandeur;E,Pa:Pelement;N : double):Pelement;
Var P : Pelement;
Begin
  New(P);
  P^.TypeElement := GrandeurIndicee;
  P^.Pvariab := Avar;
  P^.IndexLigne := E;
  P^.IndexPage := Pa;
  P^.Numero := N;
  result := P
End; // GenGrandeurIndicee

Function GenGrandeurEuler(Avar:Tgrandeur;E:Pelement):Pelement;
Var P : Pelement;
Begin
  New(P);
  P^.TypeElement := GrandeurEuler;
  P^.PvariabE := Avar;
  P^.IndexLigneE := E;
  P^.indexMod := 0;
  result := P
End; // GenGrandeurEuler

Function GenFonctionGlb(I:TCodeFonctionGlb;P1,P2,P3:Pelement;
         Vx,Vy : Tgrandeur):Pelement;
Var P : Pelement;
Begin
  New(P);
  P^.TypeElement := FonctionGlb;
  P^.CodeFglb := I;
  P^.OperandGlb := P1;
  P^.OperandDer := nil;
  P^.OperandDebut := P2;
  P^.OperandFin := P3;
  P^.varX := Vx;
  P^.varY := Vy;
  P^.valeurGlb := 0;
  P^.typeGlb := variable;
  P^.valeurInitDer := 0;
  GenFonctionGlb := P;
End; // GenFonctionGlb

Function GenFonctionGlbBis(I:TCodeFonctionGlb;P1,P2,P3:Pelement;
         Vx,Vy : Tgrandeur;x1,x2 : double):Pelement;
Var P : Pelement;
Begin
  New(P);
  P^.TypeElement := FonctionGlb;
  P^.CodeFglb := I;
  P^.OperandGlb := P1;
  P^.OperandDer := nil;
  P^.OperandDebut := P2;
  P^.OperandFin := P3;
  P^.varX := Vx;
  P^.varY := Vy;
  P^.valeurGlb := x1;
  P^.valeurInitDer := x2;
  GenFonctionGlbBis := P;
End; // GenFonctionGlbBis

Function GenOperateur(C:Char;Pgauche,Pdroit:Pelement):Pelement;
Var P : Pelement;
    X,Y,Z : double;
Begin
  if (PDroit^.TypeElement=Operateur) and
     (charInSet(PDroit^.codeOp,['-','+','*','/','^'])) and
     (PDroit^.OperG.typeElement=nombre) and
     (PDroit^.OperD.typeElement=nombre) then begin
            X := PDroit^.OperG.valeur;
            Y := PDroit^.OperD.valeur;
            Case PDroit^.CodeOp of
               '+' : Z := X+Y;
               '-' : Z := X-Y;
               '*' : Z := X*Y;
               '/' : Z := X/Y;
               '^' : Z := power(X,Y);
               else Z := 0; // pour le compilateur
           end;{case codeOp}
       libereLoc(Pdroit);
       if (Z=1/2) and (c='^') then begin // racine
           result := GenFonction(racine,Pgauche);
           exit;
       end;
       Pdroit := GenNombre(Z);
  end; // Pdroit
  New(P);
  P^.TypeElement := Operateur;
  P^.CodeOp := C;
  P^.OperG := Pgauche;
  P^.OperD := Pdroit;
  GenOperateur := P
End; //GenOperateur

Function GenIF(t,p,n : Pelement) : Pelement;
var PP : Pelement;
begin
    New(PP);
    PP^.TypeElement := ifThenElse;
    PP^.test := t;
    PP^.positif := p;
    PP^.negatif := n;
    result := PP
end; // GenIF

Function GenPW(t,p,n : Pelement) : Pelement;
var PP : Pelement;
begin
    New(PP);
    PP^.TypeElement := PieceWise;
    PP^.PWtest := t;
    PP^.PWthen := p;
    PP^.PWtestElse := n;
    result := PP
end; // GenPW

Function GenOperateurSimpl(C:Char;P1,P2:Pelement):Pelement;
{Les simplifications sont indispensables pour éviter la prolifération des
branches, elles ne tiennent pas compte des formes indéterminées (utilisé par
dérivée et complexe) }
Begin
   case C of
       '+','@': Begin
            if p1=pointeurZero then Begin {x+0=x}
                    genOperateurSimpl := p2;
                    exit
                End;
            if p2=pointeurZero then Begin  {0+x=x}
                   genOperateurSimpl := p1;
                   exit
                End;
       End;
       '-','#': Begin
            if p1=pointeurZero then Begin  {0-x=-x}
                   if (p2=pointeurZero)
                      then genOperateurSimpl := p2
                      else genOperateurSimpl := genFonction(oppose,p2);
                   exit
                end;
            if p2=pointeurZero then Begin  {x-0=x}
                   genOperateurSimpl := p1;
                   exit
                end;
            end;
       '^': Begin
            if p2=pointeurZero then begin  {x^0=1}
                      genOperateurSimpl := pointeurUn;
                      libereLoc(p1);
                      exit
                   end;
	     if p2=pointeurUn then begin {x^1=x}
                       genOperateurSimpl := p1;
                       exit
                    end;
            if p1=pointeurZero then begin {0^x=0}
                     genOperateurSimpl := pointeurZero;
                     libereLoc(p2);
                     exit
                  end;
            if p1=pointeurUn then begin  {1^x=1}
                     genOperateurSimpl := pointeurUn;
                     libereLoc(p2);
                     exit
                  end;
       end;
       '*': Begin
            if p1=pointeurZero then begin {x*0=0}
                     genOperateurSimpl := pointeurZero;
                     libereLoc(p2);
                     exit
                  end;
            if p1=pointeurUn then begin {x*1=x}
                     genOperateurSimpl := p2;
                     exit
                  end;
            if p2=pointeurZero then begin  {0*x=0}
                     genOperateurSimpl := pointeurZero;
                     libereLoc(p1);
                     exit
                  end;
            if p2=pointeurUn then begin {1*x=x}
                     genOperateurSimpl := p1;
                     exit
                  end;
       end;
       '/': Begin
	    if p2=pointeurUn then begin  {x/1=x}
                    genOperateurSimpl := p1;
                    exit
                  end;
            if p1=pointeurZero then begin {0/x=0}
                     genOperateurSimpl := pointeurZero;
                     libereLoc(p2);
                     exit
                  end;
       end;
       '&': ;
  end;{case}
  genOperateurSimpl := genOperateur(C,p1,p2);
End; // genOperateurSimpl

Function genFonctionSimpl(newCode : TcodeFonction;P : Pelement) : Pelement;
begin with P^ do
   case typeElement of
     fonction : begin
   if (codeF=racine) and (newCode=carre)
   	then begin
   		genFonctionSimpl := P^.Operand;
   		dispose(P);
   		exit
   	 end;
    if (codeF=carre) and (newCode=racine)
    then begin
         codeF := absolue;
         AdresseF := AdresseFonction[absolue];
         genFonctionSimpl := P;
         exit
     end;
  end;
  nombre : begin
       if p=pointeurZero then begin
          if (newCode=racine) or (newCode=carre) or (newCode=oppose) or
             (newCode=absolue) or (newCode=sinus)
              then begin
                   genFonctionSimpl := PointeurZero;
                   exit;
              end;
          if (newCode=cosinus) or (newCode=exponentielle)
              then begin
                   genFonctionSimpl := PointeurUn;
                   exit;
              end;
       end;
       if (p=pointeurUn) and
          ( (newCode=racine) or (newCode=carre) or (newCode=absolue) or (newCode=inverse))
              then begin
                   genFonctionSimpl := PointeurUn;
                   exit;
              end;
       end;{nombre}
   end;{case}
   genFonctionSimpl := genFonction(newCode,P)
end; // genFonctionSimpl

Procedure GenJ;
var j : integer;
Begin
  New(pointeurJ);
  pointeurJ^.TypeElement := RacineMoinsUn;
  pointeurJ^.valeur := 0;
  New(pointeurZero);
  pointeurZero^.TypeElement := Nombre;
  pointeurZero^.valeur := 0;
  New(pointeurUn);
  pointeurUn^.TypeElement := Nombre;
  pointeurUn^.valeur := 1;
  New(pointeurDeux);
  pointeurDeux^.TypeElement := Nombre;
  pointeurDeux^.valeur := 2;
  New(pointeurPi);
  pointeurPi^.TypeElement := Nombre;
  pointeurPi^.valeur := Pi;
  for j := cFrequence to MaxMaxGrandeurs do begin
      Grandeurs[j] := tgrandeur.Create;
      Grandeurs[j].indexG := j;
  end;
  Grandeurs[cNombre] := tgrandeur.Create;
  Grandeurs[cNombre].indexG := cNombre;
  Grandeurs[cNombre].Init('Npoints','','Nombre de points',indiceBoucle);
  Grandeurs[cDeltat].Init(deltaMaj+'t','','',constante);
  GrandeurImmediate := Grandeurs[cImmediate];
  GrandeurImmediate.Init('','','',constanteGlb);
  Grandeurs[cFrequence].Init('f','Hz','Fréquence',variable);
  setLength(Grandeurs[cFrequence].Valeur,MaxMaxVecteur);
  Grandeurs[cIndice].Init('i','','Indice de ligne',variable);
  Grandeurs[cPage].Init('iPage','','Indice de page',constante);
  setLength(Grandeurs[cPage].Valeur,MaxPages+1);
  Grandeurs[cMuette].Init('i','','muette',constanteGlb);
End; // GenJ

Function Copie(P : PElement) : PElement;
begin
   if P=nil
     then copie := nil
     else With P^ do Case TypeElement of
          Operateur : Copie := genOperateur(codeOp,copie(OperG),copie(OperD));
          Fonction  : Copie := genFonction(codeF,copie(Operand));
          FonctionGlb : Copie := GenFonctionGlbBis(codeFglb,copie(OperandGlb),
                 copie(OperandDebut),copie(OperandFin),
                 Varx,Vary,valeurGlb,ValeurInitDer);
          IfThenElse,PieceWise : Copie :=  GenIf(copie(test),copie(positif),copie(negatif));
          Grandeur : Copie := GenVar(Pvar);
          Incert : Copie := GenIncert(Pvar);
          GrandeurIndicee : Copie := GenGrandeurIndicee(Pvariab,copie(IndexLigne),copie(indexPage),Numero);
          GrandeurEuler : Copie := GenGrandeurEuler(PvariabE,copie(IndexLigneE)); // ??
          Nombre : if (P=PointeurZero) or (P=PointeurUn) or
                      (P=PointeurDeux) or (P=PointeurPi)
                then copie := P
                else copie := genNombre(valeur);
          Else copie := P;
       end;{case}
end; // copie

procedure affecteVariableF(indice : integer);
var i : integer;
begin
  for i := 0 to pred(NbreVariab) do with grandeurs[indexVariab[i]] do begin
      if valeurA=nil
         then valeurCourante := valeur[indice]
         else valeurCourante := valeurA[indice];
      if uniteSIGlb and (puissance<>0) then        // **** (fonct.genreC=G_experimentale)
            valeurCourante := valeurCourante*coeffSI;
  end;
  grandeurs[cIndice].valeurCourante := indice;
  grandeurs[cFrequence].valeurCourante := grandeurs[cFrequence].valeur[indice];
end;

// Calcul
Function CalculeLoc(F:Pelement) : double;
// Evalue la Valeur d'un arbre pointé par F

Function AngleMod(X : double) : double;
var periode : double;
// Remet X dans [-pi,+pi[
begin
   if angleEnDegre
      then periode := 360
      else periode := 2*pi;
   AngleMod := X-periode*round(X/periode)
end;

Function calcIf(ff : Pelement): double;
var t : double;
begin with ff^ do begin
   t := calculeLoc(test);
   if t>0
        then calcIf := calculeLoc(positif)
        else calcIf := calculeLoc(negatif);
end end;

Function calcPW(ff : Pelement): double;
var t : double;
begin with ff^ do
   if PWtest=nil
      then result := calculeLoc(PWtestElse)
      else begin
         t := calculeLoc(PWtest);
         if t>0
           then result := calculeLoc(PWthen)
           else result := calcPW(PWtestElse);
      end;
end;

Function calculFonctionGlb(F : Pelement): double;

Function Solveur : double;
var
    PrecisionValeur : double;
Const
    PrecisionRelative = 1e-8;
    PrecisionAbsolue = 1e-15; // calcul de pH à 10-2 près à pH=13

// boucle de recherche par méthode gradient-Newton

Procedure ResoudEquation;
var
    J,Jprec,incY : double; { J = F(x)^2 }
    diverge,stable : boolean;
    valF,valFprime : double; // valeur de la fonction et de sa dérivée

procedure CalculF;
begin
   valF := calcule(f^.operandGlb);
   J := sqr(valF);
   Diverge := J>Jprec;
end;

procedure CalculJ;
begin
   CalculF;
   valFprime := calcule(f^.OperandDer);
   incY := valF/valFprime;
   Stable := J<=precisionValeur;
   Diverge := Diverge and (not Stable);
end;

const
    Maxi_i1 = 12; // time out
    Maxi_i2 = 5; // soit µ mini =(1/3)^5=0.4%
var
    i1,i2 : integer;
    mu : double;
begin // resoudEquation
    PrecisionValeur := abs(f^.varY.valeurCourante)*PrecisionRelative;
    if PrecisionValeur<PrecisionAbsolue then PrecisionValeur := PrecisionAbsolue;
    stable := false;
    Jprec := 0;
    i1 := 0;
    try;
    CalculJ;
    Repeat
       Jprec := J;
       f^.varY.valeurCourante := f^.varY.valeurCourante-incY;
       CalculF;
       if diverge then begin
          mu := 1;
          i2 := 0;
          repeat
             mu := mu/3;
             f^.varY.valeurCourante := f^.varY.valeurCourante+incY*mu;
             calculF;
             inc(i2);
          until (not diverge) or (i2>=Maxi_i2);
      end;
      calculJ;
      inc(i1);
   until stable or (i1>=Maxi_i1) or diverge;
   if (i1>=Maxi_i1) or diverge then
       f^.varY.valeurCourante := Nan;
   except
       f^.varY.valeurCourante := Nan;
   end;
end;// resoudEquation

const jmax = 4;
var Mini,Maxi : double;
    j,indiceCourant : integer;
    AvecMinMax : boolean;
    InitAleatoire : boolean;
begin // solveur
with f^,varY do begin
    if OperandFin<>nil
       then Maxi := calcule(OperandFin)
       else Maxi := Nan;
    if OperandDebut<>nil
       then Mini := calcule(OperandDebut)
       else Mini := Nan;
    AvecMinMax := false;
    InitAleatoire := false;
    if isNan(mini)
       then if isNan(valeurCourante)
            then if genreG=variable
                then begin
                     indiceCourant := round(grandeurs[cIndice].valeurCourante);
                     if indiceCourant>0
                        then valeurCourante := valeur[pred(indiceCourant)]
                        else initAleatoire := true
                end
                else initAleatoire := true
            else
       else if isNan(maxi)
            then valeurCourante := mini
            else begin
                 AvecMinMax := true;
                 valeurCourante := (mini+maxi)/2;
            end;
    if initAleatoire
       then begin
           j := 0;
           repeat
               valeurCourante := (2*random-1)*dix(j);
                  { entre +- 10^j }
               resoudEquation;
               inc(j);
           until (j=jmax) or not isNan(valeurCourante);
       end
       else resoudEquation;
    if avecMinMax then begin
       VerifMinMaxReal(mini,maxi);
       if valeurCourante<mini then valeurCourante := Nan;
       if valeurCourante>maxi then valeurCourante := Nan;
    end;
    solveur := valeurCourante;
end end;// solveur

Procedure constNum;
var i,debut,fin : integer;
    z,min,max : double;
    montant : boolean;
    t0,t1,t0Y : double;
    seuil : double;
    NbrePeriode : integer;

Procedure ChercheDebutFin;

Function ChercheFinPeriode(idebut : integer) : integer;
var i1 : integer;
begin with F^.varX do begin
   i1 := idebut;
   if montant
     then while (i1<nmesCourant) and (valeur[i1]>=seuil) do inc(i1)
       { front montant on repasse en-dessous < }
     else while (i1<nmesCourant) and (valeur[i1]<=seuil) do inc(i1);
       { front descendant, on repasse au-dessus > }
   if montant
      then while (i1<nmesCourant) and (valeur[i1]<seuil) do inc(i1)
        { front montant, en-dessus >= }
      else while (i1<nmesCourant) and (valeur[i1]>seuil) do inc(i1);
       { front descendant, en-dessous <= }
   result := i1;
end end; // ChercheUnePeriode

var i : integer;
    z : double;
    unePeriode : integer;
begin with F^ do begin
   min := varX.valeur[0];
   NbrePeriode := 1;
   max := min;
   for i := 0 to pred(nmesCourant) do begin
       z := varX.valeur[i];
       if z<min
          then min := z
          else if z>max then max := z;
   end;
   if isNan(seuil) then seuil := (max+min)/2;
   i := 0;
   montant := varX.valeur[0]<seuil;
   if montant
     then while (i<nmesCourant) and (varX.valeur[i]<seuil) do inc(i)
       { front montant, en-dessus >= }
     else while (i<nmesCourant) and (varX.valeur[i]>seuil) do inc(i);
       { front descendant, en-dessous <= }
   if i=0 { pile moy ! } then montant := varX.valeur[1]>seuil;
   debut := i;
   fin := chercheFinPeriode(debut);
   unePeriode := fin-debut;
   if codeFglb<>phase then
   while (fin<(nmesCourant-2*UnePeriode)) do begin
       fin := chercheFinPeriode(fin);
       inc(NbrePeriode);
   end;
   if (fin>=nmesCourant) then begin
      debut := 0;
      fin := pred(nmesCourant)
   end;
end end; // ChercheDebutFin

Procedure CherchePhase;
var i,debutY : integer;
    Lmaxi,Lmini,zeroY : double;
    ecartRelatif : double;
begin with F^ do begin
   Lmini := varY.valeur[0];
   Lmaxi := Lmini;
   for i := 1 to pred(nmesCourant) do begin
       z := varY.valeur[i];
       if z<min
          then min := z
          else if z>max then max := z;
   end;
   zeroY := (Lmaxi+Lmini)/2;
   i := 0;
   if montant
      then begin
          while (i<nmesCourant) and (varY.valeur[i]>=zeroY) do inc(i);
          { en dessous }
          while (i<nmesCourant) and (varY.valeur[i]<zeroY) do inc(i)
      end
      else begin
          while (i<nmesCourant) and (varY.valeur[i]<=zeroY) do inc(i);
          { au dessus }
          while (i<nmesCourant) and (varY.valeur[i]>zeroY) do inc(i);
      end;
   debutY := i;
   t0Y := grandeurs[0].valeur[debutY];
   try
   if debutY>0 then t0Y := t0Y -
       (grandeurs[0].valeur[debutY]-grandeurs[0].valeur[pred(debutY)])*
       (varY.valeur[debutY]-zeroY)/(varY.valeur[debutY]-varY.valeur[pred(debutY)]);
   ecartRelatif := (t0Y-t0)/(t1-t0);
   if ecartRelatif>0.5 then ecartRelatif := ecartRelatif-1;
   if ecartRelatif<-0.5 then ecartRelatif := ecartRelatif+1;
   if angleEnDegre
        then valeurGlb := ecartRelatif*360
        else valeurGlb := ecartRelatif*2*pi;
   except
      valeurGlb := Nan;
   end;
end end; // CherchePhase

Procedure CherchePosVal;
var i : integer;

Function ValeurEq : double;
begin
    affecteVariableE(i);
    result := calcule(F^.OperandGlb);
end;

var ecartRef,valeurPrec,valeurC : double;
begin with F^ do begin  // CherchePosVal
   valeurGlb := Nan;
   case round(valeurGlb) of
        posDown : begin
           i := 0;
           valeurC := valeurEq;
           repeat
                 valeurPrec := valeurC;
                 inc(i);
                 valeurC := valeurEq;
           until (i>=pred(nmesCourant)) or
                 ( (valeurC<valeurPrec) and
                   (valeurC*valeurPrec<=0) );
           if i<pred(nmesCourant)
              then valeurGlb := varX.valeur[i]
        end;
        posMin : begin
           valeurGlb := Nan;
           ecartRef := maxReal;
           for i := 0 to pred(nmesCourant) do
               if valeurEq<ecartRef then begin
                  valeurGlb := varX.valeur[i];
                  ecartRef := valeurEq;
               end;
        end;
        posMax : begin
           valeurGlb := Nan;
           ecartRef := -maxReal;
           for i := 0 to pred(nmesCourant) do
               if valeurEq>ecartRef then begin
                  valeurGlb := varX.valeur[i];
                  ecartRef := valeurEq;
               end;
        end;
        posUp : begin
           i := 0;
           valeurC := valeurEq;
           repeat
                 valeurPrec := valeurC;
                 inc(i);
                 valeurC := valeurEq;
           until (i>=pred(nmesCourant)) or
                 ( (valeurC>valeurPrec) and
                   (valeurC*valeurPrec<=0) );
           if i<pred(nmesCourant)
              then valeurGlb := varX.valeur[i]
        end;
        else begin
           i := 0;
           valeurC := valeurEq;
           repeat
                 valeurPrec := valeurC;
                 inc(i);
                 valeurC := valeurEq;
           until (i>=pred(nmesCourant)) or
                 (valeurC*valeurPrec<=0);
           if i<pred(nmesCourant)
              then begin
                 if abs(valeurPrec)<abs(valeurC) then dec(i);
                 valeurGlb := varX.valeur[i];
              end
        end;
   end;
   affecteVariableE(0);
end end; // CherchePosVal

var s2,s : double;
begin with F^ do begin
   if nmesCourant<2 then exit;
   debut := 0;
   fin := pred(nmesCourant);
   if (codeFglb in [frequence,phase]) and (operandFin<>nil)
      then seuil := calcule(OperandFin)
      else seuil := Nan;
   if codeFglb in [efficace,frequence,phase,moyenne] then chercheDebutFin;
   min := varX.valeur[debut];
   max := min;
   s2 := 0;
   s := 0;
   for i := debut to fin do begin
       z := varX.valeur[i];
       if z<min
          then min := z
          else if z>max then max := z;
       s2 := s2+sqr(z);
       s := s + z;
   end;
   if codeFglb in [frequence,phase] then begin
       t0 := grandeurs[0].valeur[debut];
       try
       if debut>0 then t0 := t0 -
           (t0-grandeurs[0].valeur[pred(debut)])*
           (varX.valeur[debut]-seuil)/(varX.valeur[debut]-varX.valeur[pred(debut)]);
       except
       end;
       t1 := grandeurs[0].valeur[fin];
       try
       if fin<pred(nmesCourant) then t1 := t1 -
           (t1-grandeurs[0].valeur[pred(fin)])*
           (varX.valeur[fin]-seuil)/(varX.valeur[fin]-varX.valeur[pred(fin)]);
       except
       end;
   end; // fréquence, phase
   case codeFglb of
        position : CherchePosVal;
        frequence : if t1>t0
            then valeurGlb := NbrePeriode/(t1-t0)
            else valeurGlb := Nan;
        phase : if varY<>nil
            then cherchePhase
            else valeurGlb := Nan;
        efficaceAll : valeurGlb := sqrt(s2/nmesCourant);
        efficace : begin
           valeurGlb := sqrt(s2/(fin-debut+1));
           if uniteSIGlb then valeurGlb := valeurGlb*varX.coeffSI;
        end;
        moyenne : begin
           valeurGlb := s/(fin-debut+1);
           if uniteSIGlb then valeurGlb := valeurGlb*varX.coeffSI;
        end;
        surface : begin
           valeurGlb := calculSurface(varX.valeur,varY.valeur,nmesCourant);
           if uniteSIGlb then valeurGlb := valeurGlb*varX.coeffSI*varY.coeffSI;
        end;
    end;
end end; // constNum

Procedure calculMoyenne;
var i,idebut,ifin : integer;
    z,min,max : double;
    s1,s2,valeurLoc : double;
begin with F^ do begin
   valeurGlb := Nan;
   if nmesCourant<2 then exit;
   min := maxReal;
   max := -maxReal;
   s2 := 0;
   s1 := 0;
   idebut := 0;
   if OperandDebut<>nil then begin
      valeurLoc := calculeLoc(operandDebut);
      while (idebut<(nmesCourant-2)) and
            (grandeurs[0].valeur[idebut]<valeurLoc)
            do inc(idebut);
   end;
   ifin := pred(nmesCourant);
   if OperandFin<>nil then begin
      valeurLoc := calculeLoc(operandFin);
      while (iFin>0) and
            (grandeurs[0].valeur[iFin]>valeurLoc)
            do dec(iFin);
      verifMinMaxInt(idebut,ifin);
   end;
   for i := idebut to ifin do begin
       affecteVariableE(i);
       z := calculeLoc(operandGlb);
       if z<min then min := z;
       if z>max then max := z;
       s2 := s2+sqr(z);
       s1 := s1+z;
   end;
   case codeFglb of
        maximum : valeurGlb := max;
        minimum : valeurGlb := min;
        moyenneAll : valeurGlb := s1/nmesCourant;
        somme : valeurGlb := s1;
        ecartType : valeurGlb := sqrt((s2-sqr(s1)/nmesCourant)/pred(nmesCourant));
    end;
    affecteVariableE(0);
end end; // CalculMoyenne

Procedure calculMoyenneFFT;
var i : integer;
    z,min,max : double;
    s1 : double;
begin with F^ do begin
   valeurGlb := Nan;
   if nbreFFTcourant<2 then exit;
   min := maxReal;
   max := -maxReal;
   s1 := 0;
   for i := 0 to pred(NbreFFTcourant div 2) do begin
       affecteVariableF(i);
       z := calculeLoc(operandGlb);
       if z<min then min := z;
       if z>max then max := z;
       s1 := s1+z;
   end;
   case codeFglb of
        maximum : valeurGlb := max;
        minimum : valeurGlb := min;
        moyenneFFT : valeurGlb := s1/nbreFFTcourant;
        sommeFFT : valeurGlb := s1;
    end;
    affecteVariableE(0);
end end; // CalculMoyenneFFT

Procedure constNumParam;
var i : TcodePage;
    valeurMin,valeurMax : double;
    min,max,s1,s2,z : double;
    varRef : tgrandeur;
begin with F^ do begin
   valeurGlb := Nan;
   if NbrePages=0 then exit;
   if NbreConst>0
      then VarRef := grandeurs[indexConst[0]]
      else VarRef := VarX;
   min := varX.valeurPage[1];
   valeurMin := varRef.valeurPage[1];
   max := min;
   valeurMax := valeurMin;
   s1 := 0;
   s2 := 0;
   for i := 1 to NbrePages do begin
       z := varX.valeurPage[i];
       if z<min
          then begin
              min := z;
              valeurMin := varRef.valeurPage[i];
          end
          else if z>max then begin
              max := z;
              valeurMax := varRef.valeurPage[i];
          end;
       s1 := s1+z;
       s2 := s2+sqr(z);
   end;
   case codeFglb of
        position : case round(valeurGlb) of
           posUp : valeurGlb := valeurMax;
           posDown : valeurGlb := valeurMin;
           posMax : valeurGlb := valeurMax;
           posMin : valeurGlb := valeurMin;
           else valeurGlb := valeurMax;
        end;
        efficace,efficaceAll : valeurGlb := sqrt(s2/NbrePages);
        moyenne : valeurGlb := s1/NbrePages;
        frequence : valeurGlb := Nan;
        phase : valeurGlb := Nan;
        surface : valeurGlb := Nan;
    end;
end end; // constNumParam

Procedure calculMoyenneParam;
var i : TcodePage;
    min,max,s1,s2,z : double;
begin with F^ do begin
   valeurGlb := Nan;
   if NbrePages=0 then exit;
   min := maxReal;
   max := -maxReal;
   s1 := 0;
   s2 := 0;
   for i := 1 to NbrePages do begin
       pages[i].affecteConstParam(false);
       z := calculeLoc(operandGlb);
       if z<min then min := z;
       if z>max then max := z;
       s1 := s1+z;
       s2 := s2+sqr(z);
   end;
   case codeFglb of
        maximum : valeurGlb := max;
        minimum : valeurGlb := min;
        moyenneAll : valeurGlb := s1/NbrePages;
        somme : valeurGlb := s1;
        ecartType : valeurGlb := sqrt((s2-sqr(s1)/NbrePages)/pred(NbrePages));
    end;
    pages[pageCourante].affecteConstParam(false);
end end;// calculMoyenneParam

Procedure calculPenteOrigine;
var i : integer;
    MoyX,moyY,sigmaX,p,o : double;
begin with F^ do begin
  moyX := 0;
  moyY := 0;
  sigmaX := 0;
  for i := 0 to pred(nmesCourant) do begin
      MoyX := moyX + varX.valeur[i];
      MoyY := moyY + varY.valeur[i];
      sigmaX := sigmaX+sqr(varX.valeur[i]);
  end;
  sigmaX := sqrt((sigmaX-sqr(moyX)/nmesCourant)/pred(nmesCourant));
  MoyX := moyX/nmesCourant;
  MoyY := moyY/nmesCourant;
  p := 0;
  for i := 0 to pred(nmesCourant) do
      p := p+(varX.valeur[i]-MoyX)*(varY.valeur[i]-MoyY);
  p := p/pred(nmesCourant)/sqr(sigmax);
  o := MoyY-p*MoyX;
  case codeFglb of
        pente : begin
           valeurGlb := p;
           if uniteSIGlb then valeurGlb := valeurGlb*varY.coeffSI/varX.coeffSI;
        end;
        origine : begin
           valeurGlb := o;
           if uniteSIGlb then valeurGlb := valeurGlb*varY.coeffSI;
        end;
  end;
end end; // calculPenteOrigine

Function CalcIntegraleMuette : double; // intégrale operandGlb / varMuette de a à b
const jmaxmax = 100;
var  j,jmax : integer;
     deltax,sigma,deltaSigma,Lsomme : double;
     a,b,x : double;
begin with F^ do begin
        try
        a := calculeLoc(operandDebut);
        b := calculeLoc(operandFin);
        deltax := (b-a)/2;
        Grandeurs[cMuette].valeurCourante := a;
        sigma := calculeLoc(operandGlb);
        Grandeurs[cMuette].valeurCourante := b;
        sigma := sigma+calculeLoc(operandGlb);
        Grandeurs[cMuette].valeurCourante := (a+b)/2;
        sigma := sigma+2*calculeLoc(operandGlb);
        Sigma := Deltax*sigma/2;
        jmax := 1;
        repeat
             jmax := 2*jmax;
             deltax := deltax/2;
             x := a+deltax;
             Lsomme := 0;
             for j := 1 to jmax do begin
                 Grandeurs[cMuette].valeurCourante := x;
                 Lsomme := Lsomme+calculeLoc(operandGlb);
                 x := x+2*deltax;
             end;
             Lsomme := Lsomme*deltax;
             DeltaSigma := abs(Lsomme-sigma/2);
             sigma := sigma/2+Lsomme;
        until (DeltaSigma<(sigma/1000)) or (jmax>jmaxmax);
        result := sigma;
        except
        result := Nan
        end;
end end; // CalcIntegraleMuette

Function CalcIntegraleDefinie : double;
var x,y,xprec,yprec : double;
    vecteurX : Tvecteur;

procedure calcPoint(i : integer);
begin
  affecteVariableE(i);
  xprec := x;
  yprec := y;
  y := calculeLoc(f^.operandGlb);
  x := vecteurX[i];
end;

// intégrale operandGlb / varx  de debut à fin
var  i,idebut,ifin : integer;
     a,b,Lsomme,Lsigne : double;
     coeff_x : double;
begin with F^ do begin
        Lsigne := 1;
        copyVecteur(vecteurX,varX.valeur);
        if uniteSIGlb and (varX.coeffSI<>1) then begin
           coeff_X := varX.coeffSI;
           for i := 0 to pred(nmesCourant) do
               vecteurX[i] := vecteurX[i]*coeff_X;
        end;
        try
        affecteVariableE(0);
        a := calculeLoc(operandDebut);
        b := calculeLoc(operandFin);
        idebut := 0;
        if a>b then begin
           swap(a,b);
           Lsigne := -1;
        end;
        while (idebut<(nmesCourant-1)) and (vecteurX[idebut]<a) do inc(idebut);
        ifin := pred(nmesCourant);
        while (ifin>1) and (vecteurX[ifin]>b) do dec(ifin);
        x := 0;y := 0;
      	if idebut>0 then begin
           calcPoint(idebut-1);
           calcPoint(idebut);
           Lsomme := (x-a)*(y+(y-yprec)/(x-xprec)*(a-x)/2);
        end
        else begin
           Lsomme := 0;
           calcPoint(idebut);
        end;
// vecteurX[idebut]>=a et vecteurX[ifin]<=b
      	for i := succ(idebut) to ifin do begin
      	   calcPoint(i);
           Lsomme := Lsomme+(x-xprec)*(y+yprec)/2;
     	end; // for i
      if ifin<pred(nmesCourant) then begin
           calcPoint(ifin+1);
           Lsomme := Lsomme+(b-xprec)*(yprec+(y-yprec)/(x-xprec)*(b-xprec)/2);
      end;
      result := Lsomme*Lsigne;
      except
          on E:exception do begin
             derniereErreur := E.message;
             result := nan;
          end;
      end;
   	  affecteVariableE(0);
      vecteurX := nil;
end end;// CalcIntegraleDefinie

var freqLoc,rapportCyclique,t : double;
    codePage : integer;
    indiceCourant : integer;
    degreDer,NbrePointDer : integer;
    j : integer;
    NbreBits : integer;
begin with F^ do begin // calculFonctionGlb
    indiceCourant := round(grandeurs[cIndice].valeurCourante);
    if indiceCourant=0 then Case CodeFglb of
         maximum,minimum,moyenneAll,somme,ecartType : if typeGlb=variable
               then calculMoyenne
               else calculMoyenneParam;
         moyenneFFT,sommeFFT : if typeGlb=variable
               then calculMoyenneFFT
               else calculMoyenneParam;
         initial : begin
            j := 0;
            while (j<nmesCourant) and isNan(varX.valeur[j]) do inc(j);
            if j=nmesCourant
               then valeurGlb := Nan
               else valeurGlb := varX.valeur[j];
         end;
         position,frequence,surface,phase,moyenne,efficace,efficaceAll : if varX.genreG=variable
                then constNum
                else constNumParam;
         pente,origine : calculPenteOrigine;
         equation,cPoisson,cGauss,cBinomial,cPhaseModulo,dGaussMean,
                  dGaussSigma,cCnp,cCreneau,cTriangle,cBitAlea,fonctionPage,
                  cBessel,cPeigne,derivee,deriveeSeconde : ;
         else ; // erFonctionGlbIsole
      // ne devrait pas arriver ici mais y arrive si L*diff() !
    end; // case codeFglb
    case CodeFglb of
         equation : CalculFonctionGlb := solveur;
         integraleMuette : CalculFonctionGlb := CalcIntegraleMuette;
         integraleDefinie : CalculFonctionGlb := CalcIntegraleDefinie;
      //   integrale fait dans GestVar
         fonctionPage : begin
             codePage := round(OperandGlb.valeur);
             calculFonctionGlb := Grandeurs[cPage].valeur[codePage];
         end;
         derivee : begin
             GetParamDerivee(operandGlb,operandDebut,degreDer,NbrePointDer);
             CalculFonctionGlb := DeriveePonctuelle(varX.valeur,varY.valeur,indiceCourant,nmesCourant,degreDer,NbrePointDer);
         end;
         deriveeSeconde : begin
            GetParamDerivee(operandGlb,operandDebut,degreDer,NbrePointDer);
            CalculFonctionGlb := DeriveeSecondePonctuelle(varX.valeur,varY.valeur,indiceCourant,nmesCourant,degreDer,NbrePointDer);
         end;
         cCreneau,cTriangle : begin
            t := calcule(OperandGlb);
            freqLoc := calcule(OperandDebut);
            if operandFin<>nil
               then begin
                  rapportCyclique := calcule(OperandFin);
                  if isNan(rapportCyclique) then rapportCyclique := 0.5;
               end
               else rapportCyclique := 0.5;
            case codeFglb of
                cCreneau : CalculFonctionGlb := Creneau(t,freqLoc,rapportCyclique);
                cTriangle : CalculFonctionGlb := Triangle(t,freqLoc,rapportCyclique);
                else CalculFonctionGlb := 0;// pour le compilateur
            end;
         end;
         cBitAlea : begin
            t := calcule(OperandGlb);
            freqLoc := calcule(OperandDebut); // en fait période !
            if operandFin<>nil
               then begin
                  rapportCyclique := calcule(OperandFin); // en fait nombre de bits
                  nbreBits := round(rapportCyclique);
                  if nbreBits<1 then nbreBits := 1;
                  if nbreBits>8 then nbreBits := 8;
               end
               else nbreBits := 1;
            CalculFonctionGlb := BitAleatoire(t,freqLoc,nbreBits);
         end;
         pythonVar,pythonConst : CalculFonctionGlb := varx.valeurCourante;
         cCnp,cGauss,dGaussMean,dGaussSigma,
              cPhaseModulo,cBinomial,cBessel,cPeigne : begin
            freqLoc := calcule(OperandGlb);
            rapportCyclique := calcule(OperandDebut);
            case codeFglb of
                cCnp : CalculFonctionGlb := Cnp(round(freqLoc),round(rapportCyclique));
                cGauss : CalculFonctionGlb := Gauss(varX.valeurCourante,freqLoc,rapportCyclique);
                cBinomial : CalculFonctionGlb := Binomial(varX.valeurCourante,round(freqLoc),round(rapportCyclique));
                dGaussMean : CalculFonctionGlb := derGaussMean(varX.valeurCourante,freqLoc,rapportCyclique);
                cPhaseModulo : CalculFonctionGlb := PhaseModulo(varX.valeurCourante,freqLoc,rapportCyclique);
                dGaussSigma : CalculFonctionGlb := derGaussSigma(varX.valeurCourante,freqLoc,rapportCyclique);
                cBessel : CalculFonctionGlb := BesselJ(rapportCyclique,freqLoc);
                cPeigne : CalculFonctionGlb := Peigne(rapportCyclique,freqLoc);
                else CalculFonctionGlb := 0; //  pour complaire au compilateur
            end;
         end;
         cPoisson : begin
            freqLoc := calcule(OperandGlb);
            CalculFonctionGlb := Poisson(varX.valeurCourante,freqLoc);
         end;
         else CalculFonctionGlb := valeurGlb;
     end;// case codeFglb
end end; // calculFonctionGlb

Var  X,Y : double;
     Xi,Yi : integer;
     indexC : TcodeGrandeur;
     indexP : TcodeParam;
     m : integer;
     lPage : integer;
Begin // Noyau de Function calculeLoc
  result := Nan;
  Case F.TypeElement of
       Operateur: Begin
            X := calculeLoc(F.OperG);
            if isNan(X) then exit;
            if isInfinite(X) then exit;
            Y := calculeLoc(F.OperD);
            if isNan(X) then exit;
            if isInfinite(X) then exit;
            Case F.CodeOp of
                 '+' : CalculeLoc := X+Y;
                 '-' : CalculeLoc := X-Y;
                 '=' : if X=Y
                        then CalculeLoc := 1
                        else CalculeLoc := -1;
                 '*' : CalculeLoc := X*Y;
                 '/' : CalculeLoc := X/Y;
                 '@' : CalculeLoc := angleMod(X+Y);
                 '#' : CalculeLoc := angleMod(X-Y);
                 '^' : CalculeLoc := Power(X,Y);
                 '&' : CalculeLoc := Atan2(X,Y);
                 '<','>','O','A','X','M','N',infegal,supegal : begin
                         Xi := round(X);
                         Yi := round(Y);
                         Case F.CodeOp of
                              '<' : if X<Y
                                  then calculeLoc := +1
                                  else calculeLoc := 0;
                              infegal : if X<=Y
                                  then calculeLoc := +1
                                  else calculeLoc := 0;
                              'O' : calculeLoc := Yi or Xi;
                              'A' : calculeLoc := Yi and Xi;
                              'X' : calculeLoc := Yi xor Xi;
                              'N' : calculeLoc := not(Yi and Xi);
                              'M' : calculeLoc := Xi mod Yi;
                              '>' : if X>Y
                                  then calculeLoc := +1
                                  else calculeLoc := 0;
                              supegal : if X>=Y
                                  then calculeLoc := +1
                                  else calculeLoc := 0;
                              else calculeLoc := 0
                          end;
                    end;
             end;// case codeOp
       end; // operateur
       Fonction: Begin
             X := calculeLoc(F.Operand);
             if isNan(X) then exit;
             if isInfinite(X) then exit;
             calculeLoc := F.AdresseF(X);
       End;
       FonctionGlb : calculeLoc := calculFonctionGlb(F);
       IfThenElse : calculeLoc := calcIf(F);
       PieceWise : calculeLoc := calcPW(F);
       grandeur : result := F.Pvar.valeurCourante;
       grandeurIndicee,IncertIndicee : begin
            if F.indexLigne<>nil then F.Numero := calculeLoc(F.indexLigne);
            if F.indexPage<>nil
               then lPage := round(calculeLoc(F.indexPage))
               else lPage := pageCourante;
            Xi := round(F.Numero);
            case F.Pvariab.genreG of
                 variable : if (Xi<0) or (Xi>=nmesCourant)
                     then if NonDefinieNulle
                          then calculeLoc := 0
                          else calculeLoc := Nan
                     else if F.TypeElement=grandeurIndicee
                        then if lPage=pageCourante
                           then calculeLoc := F.Pvariab.valeur[Xi]
                           else calculeLoc := pages[lPage].valeurVar[F.Pvariab.indexG,Xi]
                        else calculeLoc := F.Pvariab.valIncert[Xi];
                  constante : begin
                      indexC := F.Pvariab.indexG;
                      if (Xi<=0) or (Xi>NbrePages)
                         then calculeLoc := Nan
                         else if F.TypeElement=grandeurIndicee
                            then calculeLoc := pages[Xi].valeurConst[indexC]
                            else calculeLoc := pages[Xi].incertConst[indexC]
                  end;
                  paramNormal,paramDiff1,paramDiff2 : begin
                      indexC := F.Pvariab.indexG;
                      indexP := indexToParam(F.Pvariab.genreG,indexC);
                      if (Xi<=0) or (Xi>NbrePages)
                         then calculeLoc := Nan
                         else if F.TypeElement=grandeurIndicee
                            then calculeLoc := pages[Xi].valeurParam[F.Pvariab.genreG,indexP]
                            else calculeLoc := pages[Xi].incertParam[indexP]
                  end;
            end;
            if not(isNan(result)) and uniteSIGlb and (F.PVariab.fonct.genreC=G_experimentale) then
               result := result*F.PVariab.coeffSI;
        end;
       Nombre,RacineMoinsUn : CalculeLoc := F.valeur;
       Incert : calculeLoc := F.Pvar.incertCourante;
       grandeurEuler : if F.indexLigneE<>nil
          then begin
             if F.indexMod=0 then begin
                for m := 1 to NbreModele do
                    if fonctionTheorique[m].addrY=F.PvariabE then F.indexMod := m;
                if F.indexMod=0 then F.indexMod := -1; // pour ne pas recommencer
             end;
             if F.indexMod<=0
                then calculeLoc := Nan
                else begin
                    Xi := round(calculeLoc(F.indexLigneE));
                    if (Xi<0) or (Xi>high(fonctionTheorique[F.indexMod].valeurYeuler))
                       then calculeLoc := Nan
                       else calculeLoc := fonctionTheorique[F.indexMod].valeurYeuler[Xi];
                end;
          end
          else calculeLoc := F.PvariabE.valeurCourante
       else calculeLoc := Nan;
  End; // case F.typeElement
End; // function calculeLoc

procedure Tmodele.CherchePenteOrigine(var indexPente,indexOrigine : integer);

procedure chercheLoc(F : Pelement;carac : char);
var indexP : integer;
Begin
  Case F.TypeElement of
       Operateur: Begin
          chercheLoc(F.OperG,F.CodeOp);
          chercheLoc(F.OperD,F.CodeOp);
       end; // operateur
       grandeur : if F.Pvar.genreG=paramNormal then begin
          indexP := indexParamNom(F.Pvar.nom);
          case carac of
               '+' : indexOrigine := indexP;
               '*' : indexPente := indexP;
          end;
       end;
  End; // case F.typeElement
end;

Begin
    indexPente := 0;
    indexOrigine := 0;
    ChercheLoc(calcul,' ');
End; // CherchePenteOrigine

procedure affecteVariableE(indice : integer);
var i : integer;
begin
  for i := 0 to pred(NbreVariab) do with grandeurs[indexVariab[i]] do begin
      valeurCourante := valeur[indice];
      incertCourante := valIncert[indice];
  end;
  if uniteSIGlb then for i := 0 to pred(NbreVariab) do
  with grandeurs[indexVariab[i]] do
      if (puissance<>0) then begin   // ****  (fonct.genreC=G_experimentale)
             valeurCourante := valeurCourante*coeffSI;
             if not isNan(incertCourante) then
                incertCourante := incertCourante*coeffSI;
      end;
  grandeurs[cIndice].valeurCourante := indice;
  grandeurs[cIndice].incertCourante := 0;
end;

function calcule(f : Pelement) : double;
begin
   if f=nil
     then begin
//        calcule := Nan;
        raise EMathError.Create(erFonctionNil)
     end
     else begin
        try
        calcule := calculeLoc(f)
        except
        calcule := Nan
        end;
     end;
end;

// dérivée formelle

Procedure deriveeForm(F : Tfonction;xx : tgrandeur;var Fprime : Pelement;
   var dependDer : TsetGrandeur); // fprime=df/dxx

Function derive(F : Pelement ) : Pelement;

   Function GenArc(ff : Pelement) : Pelement;
   begin
        genArc := genFonction(inverse,
           genFonctionSimpl(racine,
                genOperateurSimpl('-',
                     pointeurUn,
                     genFonction(carre,ff))))
   end;

   Function deriveFonction(F : Pelement) : Pelement;
   var  tampon : Pelement ;  // (FoG)'=G'*(F'oG)  tampon = F'oG
   Begin with F^ do begin
      case codeF of
              absolue : tampon := genFonction(signe,Copie(Operand));
              oppose : begin
                 deriveFonction := genFonctionSimpl(Oppose,Derive(Operand));
                 exit;
              end;
              inverse : tampon := genFonctionSimpl(Oppose,
                genFonctionSimpl(inverse,
                     genFonctionSimpl(carre,copie(operand))));
              entier,fractionnaire : tampon := PointeurUn;
              carre : tampon := genOperateur('*',pointeurDeux,copie(operand)); // 2*operand
              racine : tampon := genFonctionSimpl(Inverse,
                 genOperateur('*',
                   pointeurDeux,
                   genFonctionSimpl(racine,copie(operand))));
                   {1/(2*operand)}
              exponentielle : tampon := copie(F);
              lognep : tampon := genFonctionSimpl(inverse,copie(operand));
              logdec  : tampon := genOperateur('/',
                       genNombre(1/ln(10)),
                       copie(operand));
              sinus : tampon := genFonction(cosinus,copie(operand));
              cosinus : tampon := genFonction(oppose,
                              genFonction(sinus,copie(operand)));
              tangente : tampon := genOperateurSimpl('+',
                  pointeurUn,
                  genFonction(tangente,copie(operand))); // tan(x)'=1+tan(x)^2
              arcTangente : tampon := genFonction(inverse,
                  genOperateurSimpl('+',
                     pointeurUn,
                     genFonction(carre,copie(operand))));
              arcSinus : tampon := genArc(copie(operand));
              arcCosinus : tampon := genFonction(oppose,genArc(copie(operand)));
              sinusCardinal : tampon := genFonction(dersincardinal,copie(operand));
              errorfunction : tampon := genOperateur('*',
                    copie(operand),
                    gennombre(2/sqrt(pi)));
              cosHyper : tampon := genFonction(sinHyper,copie(operand));
              sinHyper : tampon := genFonction(cosHyper,copie(operand));
              tanHyper : tampon := genFonction(inverse,
                        genFonction(carre,
                        genFonction(cosHyper,copie(operand))));
              ArgCosHyper : tampon := genFonction(inverse,
                           genFonction(racine,genOperateur('-',
                              genFonction(carre,copie(operand)),
                              pointeurUn)));
              ArgSinHyper : tampon := genFonction(inverse,
                    genFonction(racine,genOperateur('+',
                              pointeurUn,
                              genFonction(carre,copie(operand)))));
              ArgTanHyper : tampon := genFonction(inverse,
                        genFonction(racine,genOperateur('-',
                              pointeurUn,
                              genFonction(carre,copie(operand)))));
              sexaToDeci : tampon := pointeurUn;
              codeBruit : tampon := pointeurZero; // ??
              else tampon := pointeurZero;
       end;
       if angleEnDegre then
           if (F^.codeF in [sinuscardinal,sinus,cosinus,tangente])
              then tampon := genOperateurSimpl('/',tampon,
                          genFonction(UtilisateurToRadian,pointeurUn))
              else if (F^.codeF in [arcsinus,arccosinus,arctangente]) then
                    tampon := genOperateurSimpl('*',tampon,
                          genFonction(UtilisateurToRadian,pointeurUn));
        deriveFonction := genOperateurSimpl('*',Derive(operand),tampon); // g'*(f'og)
   end end; // deriveFonction

   Function deriveFonctionGlb(F : Pelement) : Pelement;
   Begin with f^ do
       case codeFGlb of
            EquaDiff1,Equadiff2,Equation : deriveFonctionGlb := derive(OperandGlb);
            Integrale : deriveFonctionGlb := copie(OperandGlb);
            IntegraleDefinie : deriveFonctionGlb := pointeurZero;
            IntegraleMuette : deriveFonctionGlb := pointeurZero;
            cBessel : deriveFonctionGlb := pointeurZero; // Jn'=1/2 (Jn-1-Jn+1)
            cPeigne : deriveFonctionGlb := pointeurZero;
            cBinomial : deriveFonctionGlb := pointeurZero;
            cGauss : begin
                  if operandGlb^.Pvar=xx then begin // moyenne
                     deriveFonctionGlb := genOperateurSimpl('*',Derive(operand),
                         GenFonctionGlb(dGaussMean,copie(operandGlb),copie(operandDebut),nil,varX,nil));
                     exit;
                  end;
                  if operandDebut^.Pvar=xx then begin // sigma
                     deriveFonctionGlb := genOperateurSimpl('*',Derive(operandDebut),
                     GenFonctionGlb(dGaussSigma,copie(operandGlb),copie(operandDebut),nil,varX,nil));
                     exit;
                  end;
                  if varX=xx then begin { x }
                     deriveFonctionGlb := pointeurZero;
                     exit;
                  end;
                  deriveFonctionGlb := pointeurZero;
            end;
            pythonVar,pythonConst : deriveFonctionGlb := pointeurZero;
            cPoisson : // Poisson(n,param)' = Poisson*(n/param-1)
            if operandGlb^.Pvar=xx
                then deriveFonctionGlb := genOperateur('*',
                   copie(F),
                   genOperateur('-',
                      genOperateur('/',
                            genVar(varX),
                            genVar(xx)),
                      pointeurUn))
                 else deriveFonctionGlb := pointeurZero;
            else deriveFonctionGlb := pointeurZero;
       end;
   end;

   function deriveOperateur(F : Pelement) : Pelement;
   var
      Derive_G,Derive_D : Pelement;
      Derive_atan,derive_gd : Pelement;
   Begin with F^ do Begin
      Derive_G := Derive(OperG);
      Derive_D := Derive(OperD);
      case codeOp of
           '+','-','#','@','=','<','>','O','X','A','M','N',infegal,supegal :
                 deriveOperateur := genOperateurSimpl(codeOp,Derive_G,Derive_D);
           '*' : deriveOperateur := genOperateurSimpl('+',
                       genOperateurSimpl('*',copie(OperD),Derive_G),
                       genOperateurSimpl('*',copie(OperG),Derive_D));
           '/' : //(g/d)'=(g'*d-g*d')/(d^2)
                       deriveOperateur := genOperateurSimpl('/',
                            genOperateurSimpl('-',
                            genOperateurSimpl('*',copie(OperD),Derive_G),
                            genOperateurSimpl('*',copie(OperG),Derive_D)),
                         genFonctionSimpl(carre,copie(operD)));
          '^' : //(g^d)' := d'*ln(g)*g^d+d*g'*g^(d-1)
                         deriveOperateur := genOperateurSimpl('+',
                           genOperateurSimpl('*',
                            Derive_D,
                            genOperateurSimpl('*',
                               genFonction(logNep,copie(operG)),
                               copie(F))),
                         genOperateurSimpl('*',
                            genOperateurSimpl('*',Derive_G,copie(operD)),
                            genOperateurSimpl('^',
                            copie(OperG),
                                genOperateurSimpl('-',
                                  copie(OperD),
                                  pointeurUn))));
               '&' : begin // atan2(g,d)' = arctan(g/d)' = (g'*d-g*d')*conversion/(d^2+g^2)
                    Derive_atan := genFonction(inverse,
                         genOperateur('+',
                             genFonctionSimpl(carre,copie(operG)),
                             genFonctionSimpl(carre,copie(operD))));
                 if angleEnDegre then
                    Derive_atan := genOperateur('*',
                     genNombre(RadToDeg(1)),
                         Derive_atan);
                 Derive_gd := genOperateurSimpl('-',
                             genOperateurSimpl('*',copie(OperD),Derive_G),
                             genOperateurSimpl('*',copie(OperG),Derive_D));
                 DeriveOperateur := genOperateurSimpl('*',Derive_gd,Derive_atan);
              end; // atan2
              else deriveOperateur := pointeurZero;
           end;{case}
      end end;// deriveOperateur

function DeriveIf(F : Pelement) : Pelement;
var p,n : Pelement;
begin with F^ do begin
    p := derive(Positif);
    n := derive(Negatif);
    result := genIf(copie(test),p,n);
end end; // DeriveIf

function DerivePW(F : Pelement) : Pelement;
var p,n : Pelement;
begin with F^ do begin
    if PWthen<>nil then p := derive(PWthen) else p := nil;
    n := derive(PWtestElse);
    result := genPW(copie(PWtest),p,n);
end end; // DerivePW

Begin // derive
     case f^.typeElement of
           operateur : Derive := deriveOperateur(F);
           fonction  : Derive := deriveFonction(F);
           fonctionGlb  : Derive := deriveFonctionGlb(F);
           ifThenElse : Derive := DeriveIf(F);
           pieceWise : Derive := DerivePW(F);
           Grandeur : if (f^.Pvar=xx)
              then Derive := pointeurUn
              else Derive := pointeurZero;
           GrandeurIndicee : if (f^.Pvar=xx) and (f^.indexLigne<>nil)
              then Derive := pointeurUn // cas x[i] - x[i-1]
              else Derive := pointeurZero;
                  // cas complexe à voir : z=x[0]+x[3]+x[5]
           else Derive := pointeurZero;
     end;{case}
end;// derive

Procedure chercheDepend(ff : Pelement);
begin
    if ff<>nil then with FF^ do case typeElement of
           operateur : begin
              chercheDepend(operG);
              chercheDepend(operD);
           end;
       fonction : chercheDepend(operand);
       fonctionGlb : if operandGlb<>nil then chercheDepend(operandGlb);
       ifThenElse,pieceWise : begin
           chercheDepend(positif);
           chercheDepend(negatif);
           chercheDepend(test);
       end;
       grandeur,grandeurIndicee,incert,grandeurEuler : include(dependDer,indexNom(Pvar.nom));
       else ;
    end; // case typeelement
end;// chercheDepend

begin // deriveeForm
   dependDer := [];
   libere(fprime);
   if (f.calcul<>nil) then begin
       fprime := derive(f.calcul);
       chercheDepend(fprime);
   end;
end; // DeriveeForm

Procedure Tfonction.genreFonction(var gf : TgenreGrandeur);
var isEuler,EulerPermis,EulerForce : boolean;
    indexG : integer;

Procedure genreFonctionLoc(El : Pelement;var genref : TgenreGrandeur);
var g1,g2,g3 : TgenreGrandeur;
    indexI : integer;
Begin
if El<>nil then with El^ do begin
    case typeElement of
        operateur : begin
           genreFonctionLoc(OperG,g1);
           genreFonctionLoc(OperD,g2);
           if (g1=Variable) or (g2=Variable)
                then genref := Variable
                   else if (g1=Constante) or (g2=Constante)
                   then genref := Constante
                   else genref := ConstanteGlb;
        end;
        fonction : genreFonctionLoc(Operand,genref);
        fonctionGlb : case codeFglb of
            integraleMuette : begin
                genreFonctionLoc(OperandGlb,g1);
                genreFonctionLoc(OperandDebut,g2);
                genreFonctionLoc(OperandFin,g3);
                if (g1=Variable) or (g2=Variable) or (g3=Variable)
                    then genref := Variable
                    else if (g1=Constante) or (g2=Constante) or (g3=Constante)
                         then genref := Constante
                         else genref := ConstanteGlb;
            end;
            integraleDefinie : genref := Constante;
            moyenneAll,maximum,minimum,ecarttype,somme,sommeFFT,moyenneFFT : begin
                 genreFonctionLoc(OperandGlb,g1);
                 typeGlb := g1;
                 case g1 of
                      ConstanteGlb : genref := ConstanteGlb; // ??
                      Constante : genref := ConstanteGlb;
                      Variable : genref := Constante;
                 end;
            end;
            pythonVar : genref := Variable;
            pythonConst : genref := Constante;
            cPoisson,cGauss,cBinomial,cPhaseModulo,
            dGaussMean,dGaussSigma,cBessel,cPeigne,
            Filtrage,DefinitionFiltre,RetardCorr,
            Enveloppe,Harmonique,CodeCorrelation,
            EquaDiff1,EquaDiff2,Derivee,DeriveeSeconde,cCNP,cCreneau,cTriangle,cBitAlea,
            LissageGlissant,LissageCentre,PhaseContinue,fonctionPage,FrequenceInstantanee : begin
               genref := Variable;
               contientCalculGlb := true;
            end;
            Integrale : begin
               genref := Variable;
               contientCalculGlb := true;
            end;
            equation : begin
               if varX.genreG in [Constante,ParamNormal,ParamDiff1,ParamDiff2]
                    then genref := Constante
                    else genref := Variable;
               contientCalculGlb := true;
            end
            else begin
                if varX.genreG in [Constante,ParamNormal,ParamDiff1,ParamDiff2]
                    then genref := ConstanteGlb
                    else genref := Constante;
                contientCalculGlb := true;
            end;
        end;
        ifThenElse,PieceWise : begin
             genreFonctionLoc(Test,g3);
             genreFonctionLoc(Positif,g1);
             genreFonctionLoc(Negatif,g2);
             if (g1=Variable) or (g2=Variable) or (g3=Variable)
                then genref := Variable
                else if (g1=Constante) or (g2=Constante) or (g3=Constante)
                  then genref := Constante
                  else genref := ConstanteGlb;
        end;
        Grandeur,incert : if Pvar.genreG=ParamGlb
                then genref := ConstanteGlb
                else if Pvar.genreG in [ParamNormal,ParamDiff1,ParamDiff2]
                    then genref := Constante
                    else genref := Pvar.genreG;
        GrandeurIndicee : case Pvar.genreG of
              variable : if indexLigne=nil
                   then genref := constante
                   else begin
                       genref := variable;
                       if EulerPermis and not EulerForce and
                          ((indexLigne.typeElement=grandeur) and
                           (indexLigne.Pvar=grandeurs[cIndice]))
                               then begin
                                  indexI := Pvariab.indexG;
                                  isEuler := (indexI>=indexG) or
                                      (indexG in grandeurs[indexI].fonct.depend) or
                                      EulerForce;
                                  EulerForce := isEuler;
                                  EulerPermis := EulerPermis or isEuler;
                               end;
                       if EulerPermis and
                          ((indexLigne.typeElement=operateur) and
                           (indexLigne.CodeOp='+'))
                               then begin
                                  EulerPermis := false; // t[i+1] des dérivées
                                  isEuler := false;
                               end;
                       if not isEuler and EulerPermis and
                          (indexLigne.typeElement=operateur) and
                          (indexLigne.CodeOp='-') then
                                isEuler := true; // t[i-1]
                                indexI := Pvar.indexG;
                                EulerForce := EulerForce or (indexI=indexG);
                   end;
              else genref := ConstanteGlb;
        end;
        GrandeurEuler :
            if PvariabE.genreG=ParamGlb
                then genref := ConstanteGlb
                else if PvariabE.genreG in [ParamNormal,ParamDiff1,ParamDiff2]
                    then genref := Constante
                    else genref := PvariabE.genreG;
        else genref := ConstanteGlb;
   end;{case}
end end; // genreFonctionLoc

var dependPossible : TsetGrandeur;
begin
  isEuler := false;
  EulerForce := false;
  indexG := addrY.indexG;
  EulerPermis := true;
  contientCalculGlb := false;
  if calcul<>nil
     then if calcul^.TypeElement=fonctionGlb
          then begin
             gf := Variable;
             genreC := g_fonction;
             case calcul^.codeFGlb of
                CodeCorrelation : genreC := g_correlation;
                filtrage : genreC := g_filtrage;
                definitionFiltre : genreC := g_DefinitionFiltre;
                enveloppe : genreC := g_enveloppe;
                RetardCorr : genreC := g_retardCorr;
                equaDiff1 : genreC := g_diff1;
                equaDiff2 : genreC := g_diff2;
                integrale : begin
                   genreC := g_integrale;
                   if calcul^.operandDebut=nil
                       then gf := Variable
                       else gf := Constante;
                end;
                pythonVar : genreC := g_pythonVar;
                pythonConst : genreC := g_pythonConst;
                derivee : genreC := g_derivee;
                deriveeSeconde : genreC := g_deriveeSeconde;
                lissageGlissant : genreC := g_lissageGlissant;
                LissageCentre : genreC := g_lissageCentre;
                FrequenceInstantanee : genreC := g_freqInst;
                RmsInstantanee : genreC := g_RmsInst;
                PhaseContinue : genreC := g_PhaseContinue;
                harmonique : genreC := g_harmonique;
                fonctionPage : genreC := g_experimentale;
                equation : begin
                    genreC := g_equation;
                    DeriveeForm(self,calcul^.varY,calcul^.operandDer,dependPossible);
                end;
                else genreFonctionLoc(calcul,gf)
             end; {case}
             isSysteme := isSysteme or (genreC in [g_diff1,g_diff2]);
          end
          else begin
             genreFonctionLoc(calcul,gf);
             if isEuler
                then begin
                   genreC := g_Euler;
                   isSysteme := true;
                end
                else genreC := g_fonction;
          end
     else if genreC=g_forward
          then gf := Variable
          else begin
             gf := ConstanteGlb;
             genreC := g_fonction;
          end
end; // genreFonction 

Procedure Tfonction.SetDependF;

Procedure SetDepend(El : Pelement);
Begin
if El<>nil then with El^ do
    case typeElement of
       operateur : begin
          setDepend(OperG);
          setDepend(OperD);
       end;
       fonction : setDepend(Operand);
       fonctionGlb : begin
          if varx<>nil then include(depend,indexNom(varx.nom));
          if vary<>nil then include(depend,indexNom(vary.nom));
          if codeFglb in [Equation,EquaDiff1,EquaDiff2,
              integrale,integraleMuette,integraleDefinie,filtrage,
              cCreneau,cTriangle,cBitAlea,cBessel,cCnp,cPeigne] then setDepend(OperandGlb);
          if (codeFglb in [Equation,cCreneau,cTriangle,cBitAlea,cBessel,cCnp,cPeigne]) and
             (OperandDebut<>nil) then setDepend(OperandDebut);
          if (codeFglb in [cCreneau,cTriangle,cBitAlea]) and
             (OperandFin<>nil) then setDepend(OperandFin);
       end;
       ifThenElse,pieceWise : begin
          setDepend(Positif);
          setDepend(Negatif);
          setDepend(Test);
       end;
       Grandeur,GrandeurIndicee,incert,grandeurEuler : include(depend,indexNom(Pvar.nom));
     end;
end;

begin
     if calcul<>nil then begin
         depend := [];
         setDepend(calcul);
     end;
end;// setDependF

Function ExisteJ(El : Pelement) : boolean;
Begin with El^ do
      case typeElement of
           operateur : result := existeJ(OperG) or existeJ(OperD);
           fonction : result := existeJ(Operand);
           RacineMoinsUn : result := true;
           else result := false;
     end;
end;

procedure Tpage.calculLigne(numeroLigne : integer);
// mise à jour d'une ligne après modif d'une valeur
var fx : integer;
begin
   affecteConstParam(false);
   affecteVariableE(numeroLigne);
   for fx := 0 to pred(NbreGrandeurs) do with Grandeurs[fx] do
       if (genreG=variable) then case fonct.genreC of
           g_fonction,g_equation : begin
              try
                 valeurCourante := calcule(fonct.calcul);
                 valeur[numeroLigne] := valeurCourante;
                 if uniteSIGlb and uniteImposee then
                    valeur[numeroLigne] := valeurCourante/coeffSI;
                 CalculIncertitudeFonct(valIncert[numeroLigne]);
                 incertCourante := valIncert[numeroLigne];
              except
                 valeur[numeroLigne] := Nan;
                 valeurCourante := Nan;
              end;
           end;
           g_experimentale : calculIncertitudeExp(IncertVar[fx,numeroLigne]);
           else IncertVar[fx,numeroLigne] := Nan
       end;
   modifiedP := true;
end; // calculLigne

Procedure construire2(dfdy,dfdyprime : Pelement;var dfdk : Pelement;k : TcodeGrandeur);
{  si y'' = f(x,y,y',k)  z=dy/dk obéit
   d2(z)/dx2=df/dy*z+df/dy'*dz/dx+df/dk (1)
   la procedure construit l'équation (1) et renvoie dans dfdk
   valeur initiale nulle sauf pour y0 : 1(traité dans modèle)
   valeur initiale dérivée nulle sauf pour y'0 : 1(traité dans modèle) }
begin
     dfdk := genFonctionGlb(equaDiff2,genOperateurSimpl('+',
          genOperateurSimpl('+',
             genOperateurSimpl('*',
                copie(dfdy),
                genVar(Parametres[ParamDiff1,k])),
             genOperateurSimpl('*',
                copie(dfdyprime),
                GenVar(Parametres[ParamDiff2,k]))),
             dfdk),nil,nil,nil,nil)
end;

Procedure construire1(dfdy : Pelement;var dfdk : Pelement;k : TcodeGrandeur);
{  si y' = f(x,y,k)  a=dy/dk obéit à
   d(a)/dx=df/dy*a+df/dk (1)
   la procedure construit (1) et renvoie dans dfdk
   valeur initiale nulle sauf pour y0 : 1 (traité dans modèle) }
begin
      dfdk := genFonctionGlb(equaDiff1,genOperateurSimpl('+',
             genOperateurSimpl('*',
                 copie(dfdy),
                 GenVar(Parametres[ParamDiff1,k])),
             dfdk),nil,nil,nil,nil)
end;

Procedure construireEquation(dfdy : Pelement;var dfdk : Pelement);
{  si f(x,y,k)=0  dy/dk=-(df/dk)/(df/dy) (1)
   la procedure construit (1) et renvoie dans dfdk }
begin
      dfdk := genFonctionSimpl(oppose,
            genOperateurSimpl('/',
            copie(dfdk),
            copie(dfdy)))
end;

Function Tfonction.ChercheDebutDepend : TcodeGrandeur;
var i : integer;
    zz : TcodeGrandeur;
begin
    result := grandeurInconnue;
    for i := 0 to pred(NbreGrandeurs) do
        if (i in depend) and (grandeurs[i].genreG=variable) then begin
            if grandeurs[i].fonct.genreC=g_experimentale
               then begin if i<result then result := i end
               else begin
                    zz := grandeurs[i].fonct.chercheDebutDepend;
                    if zz<result then result := zz;
               end;
        end;
end;

Procedure Tfonction.ChangementVariable(x : Tgrandeur);

procedure change(var ff : Pelement);
begin
    if ff<>nil then case FF^.typeElement of
           operateur : begin
              change(FF^.operG);
              change(FF^.operD);
           end;
           fonction : change(FF^.operand);
           fonctionGlb : if FF^.operandGlb<>nil then change(FF^.operandGlb);
           ifThenElse,pieceWise : begin
              change(FF^.positif);
              change(FF^.negatif);
              change(FF^.test);
           end;
           grandeur : if FF^.pvar=x then begin
               libere(ff);
               ff := copie(x.fonct.calcul);
           end;
           else ;
     end;// case typeElement
end;

begin
    change(calcul)
end; // ChangementVariable

Function TModele.expressionNumerique : string;

Function TranslateExp(F : Pelement) : string;

Function calculFonctionGlb(F : Pelement): string;
var freqLoc,rapportCyclique,anom,anomY : string;
begin with F^ do begin // calculFonctionGlb
    result := '';
    aNom := varX.nom;
    if operandGlb<>nil then freqLoc := translateExp(OperandGlb);
    if OperandDebut<>nil then rapportCyclique := translateExp(OperandDebut);
    case CodeFglb of
        derivee : begin
           aNomY := varY.nom;
           result := 'd('+anomY+')/d('+aNom+')';
        end;
        equation : result := freqLoc;
        cCreneau : result := 'Creneau('+freqLoc+','+rapportCyclique+')';
        cTriangle : result := 'Triangle('+freqLoc+','+rapportCyclique+')';
        cBitAlea : result := 'BitAleatoire('+freqLoc+')';
        cGauss : CalculFonctionGlb := 'Gauss('+freqLoc+','+rapportCyclique+')';
        cPhaseModulo : result := 'PhaseModulo('+anom+freqLoc+','+rapportCyclique+')';
        cPoisson : result := 'Poisson('+anom+','+freqLoc+')';
        cBessel : CalculFonctionGlb := 'BesselJ('+rapportCyclique+','+freqLoc+')';
   end; // case
end end; // calculFonctionGlb

Var X,Y : string;
    parX,parY : boolean; // parenthèse X Y
    i : TcodeGrandeur;
    C : char;
Begin // ExpressionNumerique
  result := '';
  With F^ do Case TypeElement of
       Operateur: Begin
            X := translateExp(OperG);
            parX := (Operg.TypeElement=Operateur) and
                    charInSet(OperG.CodeOp,['+','-']) and
                    charInSet(CodeOp,['*','^']);
            if parX then X := '('+X+')';
            Y := translateExp(OperD);
            parY := (OperD.TypeElement=Operateur) and
                    charInSet(OperD.CodeOp,['+','-']) and
                    (CodeOp='*');
            if parY then Y := '('+Y+')';
            Case CodeOp of
                 '+' : if Y[1]='-'
                     then result := X+' '+Y
                     else result := X+' + '+Y;
                 '-' : if Y[1]='-'
                     then result := X+' + '+copy(Y,2,length(Y))
                     else result := X+' '+CodeOp+' '+Y;
                 '<','>','=' : result := X+' '+CodeOp+' '+Y;
                 '*' : result := X+PointMedian+Y;
                 '/' : result := X+'/'+Y;
                 '^' : if length(Y)=1
                     then begin
                         C := Y[1];
                         if charinset(C,chiffre)
                            then result := X+chiffreExp[ord(C)-ord('0')]
                            else result := X+'^'+Y
                     end
                     else result := X+'^{'+Y+'}';
                 else result := '';
             end;{case codeOp}
             if (CodeOp='*') and
               (Operd.typeElement=grandeur) and
               (Operd.pvar.genreG=paramNormal) then begin
                   i := indexNom(operd.Pvar.nom);
                   i := indexToParam(paramNormal,i);
                   if ParamInverse[i] then result := X+'/'+Y;
            end;
       end;// operateur
       Fonction: Begin
           X := translateExp(Operand);
           case codeF of
                oppose : result := '-'+X;
                inverse : result := '1/'+X;
                carre : result := X+chiffreExp[2];
                else result := LowerCase(nomFonction[codeF])+'('+X+')';
           end;
       End; // Fonction
       FonctionGlb : result := calculFonctionGlb(F);
       grandeur : if Pvar.genreG=paramNormal then begin
              i := indexNom(Pvar.nom);
              i := indexToParam(paramNormal,i);
              result := pages[pageCourante].paramNum(i);
           end
           else result := Pvar.nom;
       incert : if Pvar.genreG=paramNormal then begin
              i := indexNom(Pvar.nom);
              i := indexToParam(paramNormal,i);
              result := pages[pageCourante].paramNum(i);
           end
           else result := 'u('+Pvar.nom+')';
       Nombre: if F=pointeurPi then result := piMin else result := floatToStrPoint(valeur);
       RacineMoinsUn : result := 'j';
       else result := '';
  End;{case}
end;

begin
   // +'('+grandeurs[indexX].nom+')
    result := grandeurs[indexY].nom+'='+translateExp(calcul)
End; //  ExpressionNumerique

procedure TGrandeur.CalculIncertitudeExp(var avaleur : double);

function calcIncLoc(z : PElement) : double;
begin
   try
   result := calcule(z)
   except
      on E:exception do begin
            derniereErreur := E.message;
            result := Nan;
      end;
   end
end;

var incA,incB : double;
begin
    if (IncertCalcA.expression='')
          then begin
               incA := 0;
               if (IncertCalcB.expression='')
                   then exit
                   else incB := calcIncLoc(IncertCalcB.calcul);
          end
          else begin
               incA := calcIncLoc(IncertCalcA.calcul);
               if (IncertCalcB.expression='')
                  then incB := 0
                  else incB := calcIncLoc(IncertCalcB.calcul);
          end;
    Avaleur := sqrt(sqr(incB)+sqr(incA));
end;

procedure TGrandeur.CalculIncertitudeFonct(var Avaleur : double);
begin
    if IncertCalcA.calcul<>nil
       then begin
            try
               Avaleur := calcule(IncertCalcA.calcul);
               if uniteSIGlb and uniteImposee then begin
                  Avaleur := Avaleur/coeffSI;
            end;
            except
                  on E:exception do begin
                     derniereErreur := E.message;
                     Avaleur := Nan;
                  end;
            end
       end
       else Avaleur := Nan
end;

// genere.pas pour compile.pas
