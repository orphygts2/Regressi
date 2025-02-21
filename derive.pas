{ derive.pas include de compile.pas pour calcul des incertitudes }

type
  PderiveeIncert = ^TderiveeIncert;
  TderiveeIncert = record
      deriveX : Pelement;
      incertX : Pelement;
  end;
  TlisteDeriveeIncert = class(TList)
  protected
    function Get(Index : Integer) : PderiveeIncert;
    procedure Put(Index : Integer;Item : PderiveeIncert);
  public
    function Add(Item : PderiveeIncert) : Integer;
    property Items[Index : Integer] : PderiveeIncert read Get write Put; Default;
    procedure Clear;override;
  end;

function TlisteDeriveeIncert.Add(Item : PDeriveeIncert) : Integer;
begin
     result := inherited Add(Item)
end;

function TlisteDeriveeIncert.Get(Index : Integer) : PDeriveeIncert;
begin
  Result := PDeriveeIncert(inherited Get(Index))
end;

procedure TlisteDeriveeIncert.Put(Index : Integer;Item : PDeriveeIncert);
begin
  inherited Put(Index,Item)
end;

Procedure TListeDeriveeIncert.clear;
var i : Integer;
begin
  for i := 0 to pred(Count) do dispose(Items[i]);
  inherited Clear;
end;

Function GenIncertGrandeurIndicee(F : Pelement):Pelement;
Var P : Pelement;
Begin
  New(P);
  P^.TypeElement := IncertIndicee;
  P^.Pvariab := F^.Pvariab;
  P^.IndexLigne := copie(F^.IndexLigne);
  P^.Numero := F^.Numero;
  result := P
End; // GenIncertGrandeurIndicee

Function GenIncertGrandeur(F : Pelement):Pelement;
Var P : Pelement;
Begin
  New(P);
  P^.TypeElement := incert;
  P^.Pvar := F^.Pvar;
  result := P
End;// GenIncertGrandeur

Procedure deriveeIncert(F : Tfonction;var Fprime : Pelement);
// Majoration : fprime = somme abs(df/dx).incert(x)
// variance : fprime=sqrt( somme sqr(df/dx.incert(x)) }

Function derive(F : Pelement) : TlisteDeriveeIncert;

   Function deriveFonction(F : Pelement) : TlisteDeriveeIncert;
   var  tampon : Pelement; // (FoG)'=G'*(F'oG)  tampon = F'oG
        i : integer;
        derLoc : PderiveeIncert;
   Begin with F^ do begin
         case codeF of
              absolue : tampon := genFonction(signe,Copie(Operand));
              inverse : tampon := genFonctionSimpl(Oppose,
                genFonctionSimpl(inverse,
                     genFonctionSimpl(carre,copie(operand))));
              carre : tampon := genOperateur('*',genNombre(2),copie(operand));
          // 2*operand
              racine : tampon := genFonctionSimpl(Inverse,
                   genOperateur('*',
                   genNombre(2),
                   genFonctionSimpl(racine,copie(operand))));
                  // 1/(2*sqrt(operand))
             exponentielle : tampon := copie(F);
             codeBruit : begin
                result := TlisteDeriveeIncert.Create;
                new(derLoc);
                derLoc.deriveX := pointeurUn;
                derLoc.incertX := copie(operand);
                result.add(derLoc);
                exit;
             end; // renvoie tel quel
             lognep : tampon := genFonctionSimpl(inverse,copie(operand));
             logdec  : tampon := genOperateur('/',
                     genNombre(1/ln(10)),
                     copie(operand));
              sinus : tampon := genFonction(cosinus,copie(operand));
              cosinus : tampon := genFonction(oppose,
                              genFonction(sinus,copie(operand)));
              tangente : tampon := genOperateurSimpl('+',
                  pointeurUn,
                  genFonction(carre,
                     genFonction(tangente,copie(operand))));
            // tan(x)'=1+tan(x)^2
              arcTangente : tampon := genFonction(inverse,
                  genOperateurSimpl('+',
                     pointeurUn,
                     genFonction(carre,copie(operand))));
//              arcSinus,arcCosinus : tampon := nil;
              sinusCardinal : tampon := genFonction(dersincardinal,copie(operand));
              cosHyper : tampon := genFonction(sinHyper,copie(operand));
              sinHyper : tampon := genFonction(cosHyper,copie(operand));
              tanHyper : tampon := genFonction(inverse,
                        genFonction(carre,
                        genFonction(cosHyper,copie(operand))));
              else tampon := pointeurZero;
       end;
       if angleEnDegre then
             if (F^.codeF in [sinuscardinal,sinus,cosinus,tangente])
              then tampon := genOperateurSimpl('/',tampon,
                          genFonction(UtilisateurToRadian,pointeurUn))
//              (F^.codeF in [arcsinus,arccosinus,arctangente])
              else if (F^.codeF=arctangente) then
                     tampon := genOperateurSimpl('*',tampon,
                          genFonction(UtilisateurToRadian,pointeurUn));
        result := Derive(operand);
        for i := 0 to pred(result.count) do
            case codeF of
               oppose : result[i].deriveX := genFonctionSimpl(oppose,result[i].deriveX);
               sexaToDeci,entier,fractionnaire : ;  { on laisse tel quel }
               codeBruit : ;
               else if tampon=pointeurZero
                   then result[i].deriveX := pointeurZero
                   else result[i].deriveX := genOperateurSimpl('*',result[i].deriveX,copie(tampon));
              {g'*(f'og)}
            end;
        libere(tampon);
   end end;// deriveFonction

   function deriveOperateur(F : Pelement) : TlisteDeriveeIncert;
   var
      listeG,listeD : TlisteDeriveeIncert;
      derLoc : PderiveeIncert;
      i,j : integer;
      trouve : boolean;
   Begin with F^ do Begin
      if not charinset(codeOp,
     	 ['+','-','#','@','=','<','>','O','X','A','*','/','^']) then begin
         result := TlisteDeriveeIncert.Create;
         exit;
      end;
      listeG := Derive(OperG);
      listeD := Derive(OperD);
      for i := 0 to pred(listeG.count) do begin
          trouve := false;
          for j := i to pred(listeD.count) do begin
              trouve :=
                (listeD[j].incertX.typeElement=incert) and
                (listeG[i].incertX.typeElement=incert) and
                (listeD[j].incertX.Pvar=listeG[i].incertX.Pvar);
              if trouve then begin
                 if i<>j then listeD.Exchange(j,i);
                 break;
              end;
          end;
          if not trouve then begin
               new(derLoc);
               derLoc.deriveX := pointeurZero;
               derLoc.incertX := listeG[i].IncertX;
               j := listeD.add(derLoc);
               if j<>i then listeD.Exchange(j,i);
          end;
      end;
      for i := listeG.count to pred(listeD.count) do begin
           new(derLoc);
           derLoc.deriveX := pointeurZero;
           derLoc.incertX := listeD[i].IncertX;
           listeG.add(derLoc);
      end;
      for i := 0 to pred(listeG.count) do
      case codeOp of
     	      '+','-','#','@','=','<','>','O','X','A' :
                 listeG[i].deriveX := genOperateurSimpl(codeOp,listeG[i].deriveX,listeD[i].deriveX);
            '*' : listeG[i].deriveX := genOperateurSimpl('+',
                       genOperateurSimpl('*',copie(OperD),listeG[i].deriveX),
                       genOperateurSimpl('*',copie(OperG),listeD[i].deriveX));
     	      '/' : // (g/d)'=(g'*d-g*d')/(d^2)
                       listeG[i].deriveX := genOperateurSimpl('/',
     		                    genOperateurSimpl('-',
                               genOperateurSimpl('*',copie(OperD),listeG[i].deriveX),
                                  genOperateurSimpl('*',copie(OperG),listeD[i].deriveX)),
                            genFonctionSimpl(carre,copie(operD)));
            '^' : //(g^d)' := d'*ln(g)*g^d+d*g'*g^(d-1)
                         listeG[i].deriveX := genOperateurSimpl('+',
     				  genOperateurSimpl('*',
                            listeD[i].deriveX,
                            genOperateurSimpl('*',
                               genFonction(logNep,copie(operG)),
                               copie(F))),
                         genOperateurSimpl('*',
                            genOperateurSimpl('*',listeG[i].deriveX,copie(operD)),
     						 genOperateurSimpl('^',
     							          copie(OperG),
                                genOperateurSimpl('-',
                                  copie(OperD),
                                  pointeurUn))));
     	end;// case
      result := listeG;
      listeD.free;
      end end;// deriveOperateur

var derLoc : PderiveeIncert;
Begin // derive
     case f^.typeElement of
           operateur : result := deriveOperateur(F);
           fonction  : result := deriveFonction(F);
           fonctionGlb : if f^.codeFGlb in [Moyenne, MoyenneAll, Somme]
                 then result := derive(F^.operandGlb) // moyenne(f(x)), on dérive f(x)
                 else result := TlisteDeriveeIncert.Create;
	         Grandeur, GrandeurIndicee : begin
                 result := TlisteDeriveeIncert.Create;
                 new(derLoc);
                 derLoc.deriveX := pointeurUn;
                 if f^.typeElement=GrandeurIndicee
                    then derLoc.incertX := genIncertGrandeurIndicee(f)
                    else derLoc.incertX := genIncertGrandeur(f);
                 result.add(derLoc);
           end;
           else result := TlisteDeriveeIncert.Create;
     end;// case typeElement
end;// derive

var Aliste : TlisteDeriveeIncert;
    i : integer;
//    Lchaine : string;
begin
   libere(fprime);
   if (f.calcul=nil) then exit;
   if f.depend=[] then exit;
   Aliste := derive(f.calcul);
   fprime := pointeurZero;
   for i := 0 to pred(Aliste.count) do
       fprime := genOperateurSimpl('+',fprime,
                     genFonctionSimpl(carre,
                        genOperateurSimpl('*',
                           Aliste[i].incertX,Aliste[i].deriveX)));
   Aliste.free;
   fprime := genFonctionSimpl(racine,fprime);
   (*
   Lchaine := translateExp(fprime);
   AfficheErreur(LChaine,0);
   clipboard.astext := Lchaine;
   *)
end; // DeriveeIncert
