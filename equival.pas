// equival.pas = include graphker
var v11,ph11,v22,ph22 : double;
    vee,phee : double;

function TriEquivalence(Item1, Item2: Pointer): Integer;
var z : double;
begin
    z := Tequivalence(item1).ve-Tequivalence(item2).ve;
    if z<0
       then result := -1
       else if z>0
          then result := 1
          else result := 0
end;

Procedure TGrapheReg.GetEquivalence(x,y : integer;
     var Aequivalence : Tequivalence;var selectEq : TselectEquivalence);
const pourCent = 0.1;
      minPoint = 10;
      maxpente = 10;
var penteTest : double;
    i : integer;
begin
      selectEq := seNone;
      Aequivalence := nil;
      if (equivalences[pageCourante].count=0) or
         (LigneRappelCourante<>lrEquivalenceManuelle)
             then exit;
      for i := 0 to pred(equivalences[pageCourante].count) do begin
          with equivalences[pageCourante].items[i] do begin
              if (abs(x-x1i)+abs(y-y1i))<minPoint then selectEq := sePoint1;
              if (abs(x-x2i)+abs(y-y2i))<minPoint then selectEq := sePoint2;
              if (abs(x-vei)+abs(y-phei))<minPoint then selectEq := sePointEq;
              if abs(x-x2i)>maxPente then begin
                  penteTest := monde[mondeX].a*(y-y2i)/(x-x2i)/monde[MondepH].a;
                  if abs(pente-penteTest)<pourCent*abs(Pente) then selectEq := sePente2;
              end;
              if abs(x-x1i)>maxPente then begin
                    penteTest := monde[mondeX].a*(y-y1i)/(x-x1i)/monde[MondepH].a;
                    if abs(pente-penteTest)<pourCent*abs(pente) then selectEq := sePente1;
              end;
              if abs(x-vei)>maxPente then begin
                  penteTest := monde[mondeX].a*(y-phei)/(x-vei)/monde[MondepH].a;
                  if abs(pente-penteTest)<pourCent*abs(Pente) then selectEq := sePenteEq;
              end;
         end;
         if selectEq<>seNone then begin
            Aequivalence := equivalences[pageCourante].items[i];
            break;
         end;
      end;
end;

Function Tequivalence.Modif(x,y : integer;selectEq : TselectEquivalence) : boolean;

Procedure ModifpH;
begin
     Fgraphe.MondeRT(x2i,y2i,mondepH,x2,y2);
     Fgraphe.MondeRT(x1i,y1i,mondepH,x1,y1);
     ve := (StoechBecherGlb*x1+StoechBuretteGlb*x2)/(StoechBecherGlb+StoechBuretteGlb);
     pHe := (StoechBecherGlb*y1+StoechBuretteGlb*y2)/(StoechBecherGlb+StoechBuretteGlb);
     Fgraphe.windowXY(ve,pHe,mondepH,vei,phei);
end;

var xx,yy : double;
    dx,dy : integer;
begin with Fgraphe do begin
      case selectEq of
           sePoint2 : begin
               result  := (abs(x-x1i)+abs(y-y1i))>64;
               if result then begin
                  x2i := x;
                  y2i := y;
                  modifph;
               end;
           end;
           sePointEq : begin
               result := true;
               dx := x-vei;dy := y-phei;
               x1i := x1i+dx;x2i := x2i+dx;
               y1i := y1i+dy;y2i := y2i+dy;               
               modifph;
           end;
           sePoint1 : begin
               result := (abs(x-x2i)+abs(y-y2i))>64;
               if result then begin
                  x1i := x;
                  y1i := y;
                  modifph;
               end;
           end;
           sePente1 : begin
               result := (abs(x-x1i)>16) and (abs(y-y1i)>16);
               if result then begin
                  MondeRT(x,y,MondepH,xx,yy);
                  pente := (yy-y1)/(xx-x1);
               end;
           end;
           sePente2 : begin
               result := (abs(x-x2i)>16) and (abs(y-y2i)>16);
               if result then begin
                  MondeRT(x,y,MondepH,xx,yy);
                  pente := (yy-y2)/(xx-x2);
               end;
           end;
           sePenteEq : begin
               result := (abs(x-vei)>16) and (abs(y-phei)>16);
               if result then begin
                  MondeRT(x,y,MondepH,xx,yy);
                  pente := (yy-phe)/(xx-ve);
               end;
           end;
           else result := false;
     end;
end end;

procedure TgrapheReg.traceCourbeEquivalence(xvecteur,yvecteur : Tvecteur;N,N0 : integer);
var i,j : integer;
    xi,yi : integer;
    pointOK : boolean;
begin
     createPen(psSolid,1,couleurMethodeTangente);
     i := 0;
     repeat
        windowXY(xvecteur[i],yvecteur[i],mondeY,xi,yi);
        pointOK := (xi>0) and (yi>0);
        if not pointOK then inc(i);
     until pointOK or (i=(N-1));
     canvas.MoveTo(xi,yi);
     for j := i+1 to pred(N) do begin
        windowXY(xvecteur[j],yvecteur[j],mondeY,xi,yi);
        if (xi>0) and (yi>0) then canvas.LineTo(xi,yi);
     end;
     windowXY(xvecteur[N0],yvecteur[N0],mondeY,xi,yi);
     CreateSolidBrush(clRed);
     canvas.ellipse(xi - taillePointEq, yi - taillePointEq, xi + taillePointEq + 1, yi + taillePointEq + 1);
end;

Procedure TgrapheReg.TraceDroite(x,y,pente : double;
   xMin,yMin,xMax,Ymax : double;mondepH : TindiceMonde);

function Calcx(yy : double) : double;
var xx : double;
begin
      xx := x+(yy-y)/pente;
      if xx<xMin
        then xx := xMin
        else if xx>xMax then xx := xMax;
      result := xx;
end;

var
   x1d,x2d : double;
   x1i,y1i,x2i,y2i : Integer;
begin
    if xMin<monde[mondeX].mini then xMin := monde[mondeX].mini;
    if xMax>monde[mondeX].maxi then xMax := monde[mondeX].maxi;
    if yMin<monde[mondepH].mini then yMin := monde[mondepH].mini;
    if yMax>monde[mondepH].maxi then yMax := monde[mondepH].maxi;
    if pente=0
       then begin
          x1d := xMin;
          x2d := xMax;
       end
       else begin
         x1d := calcx(yMin);
         x2d := calcx(yMax);
    end;
    windowXY(x1d,y+pente*(x1d-x),MondepH,x1i,y1i);
    windowXY(x2d,y+pente*(x2d-x),MondepH,x2i,y2i);
    if (x1i<0) or (y1i<0) or (x2i<0) or (y2i<0) then exit;
    canvas.MoveTo(x1i,y1i);
    canvas.LineTo(x2i,y2i);
end;

Procedure Tequivalence.Draw;

procedure ChercheEquivalence(veAp,pheAp : double);

function ChercheEqui(i : integer) : boolean;
var v3,pH3,penteCourbe : double;
// intersection droite (veAp pHeAp pente) et (v3 ph3 penteCourbe)
begin
     penteCourbe :=
        (FGraphe.monde[MondeY].axe.valeur[succ(i)]-FGraphe.monde[mondeY].axe.valeur[i])/
        (FGraphe.monde[mondeX].axe.valeur[succ(i)]-FGraphe.monde[mondeX].axe.valeur[i]);
     v3 := FGraphe.monde[mondeX].axe.valeur[i];
     ph3 := Fgraphe.monde[mondeY].axe.valeur[i];
     ve := (pH3-penteCourbe*v3-pHeAp+pente*veAp)/(pente-penteCourbe);
     pHe := pH3+penteCourbe*(ve-v3);
     result := ((ve-Fgraphe.monde[mondeX].axe.valeur[succ(i)])*
               (ve-Fgraphe.monde[mondeX].axe.valeur[i])<=0) and
               ((phe-Fgraphe.monde[mondeY].axe.valeur[succ(i)])*
               (phe-Fgraphe.monde[mondeY].axe.valeur[i])<=0);
end; // ChercheEqui

var imax,i : integer;
    trouve : boolean;
begin  // ChercheEquivalence
     i := index1;
     imax := index2;
     if imax<i then swap(i,imax);
     repeat
        trouve := ChercheEqui(i);
// result si vee entre les deux points
        if not trouve then inc(i);
     until trouve or (i>iMax);
     if not trouve then begin
        ve := veAp;
        phe := pheAp;
     end;
end; // ChercheEquivalence

function AffineEquivalence : boolean;
var nbrePointDeriveeL,N2 : integer;
    xvecteur2,yvecteur2,derivee2 : Tvecteur;
    ecartGrand : boolean;
    N2modele : integer;

function chercheInflexion : boolean;
var i : integer;
    ecart,ecartRef : double;
    indexInflexion : integer;
    Neq : integer;
begin
      ecartRef := abs(ve-Fgraphe.monde[mondeX].axe.valeur[index1]);
      indexInflexion := (index1+index2) div 2;
      for i := index1+1 to index2 do begin
          ecart := abs(ve-Fgraphe.monde[mondeX].axe.valeur[i]);
          if ecart<ecartRef then begin
             indexInflexion := i;
             ecartRef := ecart;
          end;
      end;
      result := modeleInflexion(Fgraphe.monde[mondepH].axe.valeur,
                 Fgraphe.monde[mondeX].axe.valeur,
                 indexInflexion,yvecteur2,xvecteur2,ve,phe,pente);
      if result then begin
         Neq := 0;
         ecartRef := abs(yvecteur2[0]-phe);
         for i := 1 to pred(NbrePointDeriveeLisse) do begin
            ecart := abs(yvecteur2[i]-phe);
            if ecart<ecartRef then begin
               ecartRef := ecart;
               Neq := i;
            end;
         end;
         Fgraphe.traceCourbeEquivalence(xvecteur2,yvecteur2,NbrePointDeriveeLisse,Neq);
      end;
end;

procedure chercheApres(ii : integer);
var i : integer;
    ecart,ecartRef : double;
begin
      DeriveeLisse(Fgraphe.monde[mondeX].axe.valeur,
                 Fgraphe.monde[mondepH].axe.valeur,
                 nbrePointDeriveeL,
                 ii,xvecteur2,yvecteur2,derivee2);
       N2 := 0;
       ecartRef := abs(derivee2[0]-pente);
       for i := 1 to pred(NbrePointDeriveeLisse) do begin
          ecart := abs(derivee2[i]-pente);
          if ecart<ecartRef then begin
             ecartRef := ecart;
             N2 := i;
          end;
       end;
       ecartGrand := (ecartRef/abs(pente))>0.1;
end;

function chercheApresModele(ii : integer;penteModele : double) : boolean;
var i : integer;
    ecart,ecartRef : double;
begin
       N2modele := 0;
       ecartRef := abs(modeleApres.yder[0]-penteModele);
       for i := 1 to pred(NbrePointDeriveeLisse) do begin
          ecart := abs(modeleApres.yder[i]-penteModele);
          if ecart<ecartRef then begin
             ecartRef := ecart;
             N2modele := i;
          end;
       end;
       result := (ecartRef/abs(pente))<0.1;
end;

function modeliseEquivalenceAvant(index : integer) : boolean;
begin with modeleAvant do begin
   debut := index-(nbrePointDeriveeL div 2);
   fin := index+(nbrePointDeriveeL div 2);
   if pente<0 then signe := -1 else signe := 1;
   valeurParamE[2] := Fgraphe.monde[mondeX].axe.valeur[fin+1];
   valeurParamE[1] := Fgraphe.monde[mondepH].axe.valeur[index];
   valeurParamE[3] := 1;
   indexX := indexNom(Fgraphe.monde[mondeX].axe.nom);
   indexY := indexNom(Fgraphe.monde[mondepH].axe.nom);
   result := EffectueModeleNum;
end end;

function modeliseEquivalenceApres(index : integer) : boolean;
begin with modeleApres do begin
   debut := index-(nbrePointDeriveeL div 2);
   fin := index+(nbrePointDeriveeL div 2);
   if pente<0 then signe := -1 else signe := 1;
   valeurParamE[2] := Fgraphe.monde[mondeX].axe.valeur[debut-1];
   valeurParamE[1] := Fgraphe.monde[mondepH].axe.valeur[index];
   valeurParamE[3] := 1;
   indexX := indexNom(Fgraphe.monde[mondeX].axe.nom);
   indexY := indexNom(Fgraphe.monde[mondepH].axe.nom);
   result := EffectueModeleNum;
end end;

procedure chercheIntersection;
var veap,pheap : double;
    indexIntersection : integer;

function ChercheEqui(i : integer) : boolean;
var v3,pH3,penteCourbe : double;
// intersection droite (veAp pHeAp pente) et (v3 ph3 penteCourbe)
begin
     penteCourbe :=
        (FGraphe.monde[MondeY].axe.valeur[succ(i)]-FGraphe.monde[mondeY].axe.valeur[i])/
        (Fgraphe.monde[mondeX].axe.valeur[succ(i)]-FGraphe.monde[mondeX].axe.valeur[i]);
     v3 := FGraphe.monde[mondeX].axe.valeur[i];
     ph3 := Fgraphe.monde[mondeY].axe.valeur[i];
     ve := (pH3-penteCourbe*v3-pHeAp+pente*veAp)/(pente-penteCourbe);
     pHe := pH3+penteCourbe*(ve-v3);
     result := ((ve-Fgraphe.monde[mondeX].axe.valeur[succ(i)])*
               (ve-Fgraphe.monde[mondeX].axe.valeur[i])<=0) and
               ((phe-Fgraphe.monde[mondeY].axe.valeur[succ(i)])*
               (phe-Fgraphe.monde[mondeY].axe.valeur[i])<=0);
     if result then indexIntersection := i;
end; // ChercheEqui

var imax,i : integer;
    trouve : boolean;
    //xi1,yi1,xi2,yi2,
    xe,ye : integer;
begin  // ChercheIntersection
     i := index1;
     imax := index2;
     indexIntersection := 0;
     veAp := ve;
     pheAp := phe;
     if imax<i then swap(i,imax);
     repeat
        trouve := ChercheEqui(i);
// result si vee entre les deux points
        if not trouve then inc(i);
     until trouve or (i>iMax);
     if trouve then begin
     (*
        agraphe.WindowXY(agraphe.monde[mondeX].axe.valeur[indexIntersection],
                         agraphe.monde[mondepH].axe.valeur[indexIntersection],mondepH, xi1, yi1);
        agraphe.WindowXY(agraphe.monde[mondeX].axe.valeur[indexIntersection+1],
                         agraphe.monde[mondepH].axe.valeur[indexIntersection+1], mondepH, xi2, yi2);
        agraphe.Segment(xi1, yi1, xi2, yi2);
      *)
        Fgraphe.WindowXY(ve,phe, mondeY, xe, ye);
        CreateSolidBrush(clRed);
        Fgraphe.canvas.ellipse(xe - taillePointEq, ye - taillePointEq, xe + taillePointEq + 1, ye + taillePointEq + 1);
     end
     else begin
        ve := veAp;
        phe := pheAp;
     end;
end; // ChercheIntersection

var xvecteur1,yvecteur1,derivee1 : Tvecteur;
    index2Min : integer;
begin // affineEquivalence
    result := false;
    NbrePointDeriveeL := 2*(index2 - index1) div 3;
    if not odd(NbrePointDeriveeL) then inc(NbrePointDeriveeL);
    if NbrePointDeriveeL<3 then NbrePointDeriveeL := 3;
    if NbrePointDeriveeL>7 then NbrePointDeriveeL := 7;
    if (index1-(NbrePointDeriveeL div 2))<0 then exit;
    if (index2+(NbrePointDeriveeL div 2))>FGraphe.courbes[FGraphe.indexCourbeEquivalence].finC then exit;
    DeriveeLisse(Fgraphe.monde[mondeX].axe.valeur,
                 Fgraphe.monde[mondepH].axe.valeur,
                 nbrePointDeriveeL,
                 index1,xvecteur1,yvecteur1,derivee1);
    pente := derivee1[NbrePointDeriveeLisse div 2];
    x1 := xvecteur1[NbrePointDeriveeLisse div 2];
    y1 := yvecteur1[NbrePointDeriveeLisse div 2];
    chercheApres(index2);
    index2Min := index1+index2;
    if odd(index2Min) then inc(index2min);
    index2Min := index2Min div 2;
    if (N2=0) and (index2>index2Min) then chercheApres(index2-1);
    if N2=pred(NbrePointDeriveeLisse) then chercheApres(index2+1);
    if ((N2=pred(NbrePointDeriveeLisse)) or (N2=0)) and (ecartGrand) then exit;
    x2 := xvecteur2[N2];
    y2 := yvecteur2[N2];
    ve := (StoechBecherGlb*x1+StoechBuretteGlb*x2)/(StoechBecherGlb+StoechBuretteGlb);
    pHe := (StoechBecherGlb*y1+StoechBuretteGlb*y2)/(StoechBecherGlb+StoechBuretteGlb);
    ChercheEquivalence(ve,phe);
    if (Fgraphe.monde[MondeY].axe.nom='pH') and
       modeliseEquivalenceAvant(index1) and
       modeliseEquivalenceApres(index2) and
       ChercheApresModele(index2,modeleAvant.yder[NbrePointDeriveeLisse div 2]) then begin
           x1 := modeleAvant.xl[NbrePointDeriveeLisse div 2];
           y1 := modeleAvant.yl[NbrePointDeriveeLisse div 2];
           x2 := modeleApres.xl[N2modele];
           y2 := modeleApres.yl[N2modele];
           pente := modeleAvant.yder[NbrePointDeriveeLisse div 2];
           ve := (StoechBecherGlb*x1+StoechBuretteGlb*x2)/(StoechBecherGlb+StoechBuretteGlb);
           pHe := (StoechBecherGlb*y1+StoechBuretteGlb*y2)/(StoechBecherGlb+StoechBuretteGlb);
           if (ve<Fgraphe.monde[mondeX].axe.valeur[index2-1-(nbrePointDeriveeL div 2)]) and
              modeliseEquivalenceApres(index2-1) and
              ChercheApresModele(index2-1,pente) then begin
                x2 := modeleApres.xl[N2modele];
                y2 := modeleApres.yl[N2modele];
                ve := (StoechBecherGlb*x1+StoechBuretteGlb*x2)/(StoechBecherGlb+StoechBuretteGlb);
                pHe := (StoechBecherGlb*y1+StoechBuretteGlb*y2)/(StoechBecherGlb+StoechBuretteGlb);
           end;
           Fgraphe.traceCourbeEquivalence(modeleAvant.xl,modeleAvant.yl,NbrePointDeriveeLisse,NbrePointDeriveeLisse div 2);
           Fgraphe.traceCourbeEquivalence(modeleApres.xl,modeleApres.yl,NbrePointDeriveeLisse,N2modele);
         //  if not chercheInflexionVerticale then
           if not chercheInflexion then chercheIntersection;
    end
    else begin
        Fgraphe.traceCourbeEquivalence(xvecteur1,yvecteur1,NbrePointDeriveeLisse,NbrePointDeriveeLisse div 2);
        Fgraphe.traceCourbeEquivalence(xvecteur2,yvecteur2,NbrePointDeriveeLisse,N2);
      //  if not chercheInflexionVerticale then
        if not chercheInflexion then chercheIntersection;
    end;
    result := true;
end;// affineEquivalence

const dimEq = 3;
var ecart,x3,x4,y3,y4 : double;
    posTrait : integer;
    signe : integer;
    couleur : Tcolor;
//    i : integer;
begin // Tequivalence.draw
with Fgraphe do begin
     if LigneRappel in [lrXdeY,lrEquivalenceManuelle]
        then pen.mode := pmNotXor
        else pen.mode := pmCopy;
     couleur := pColorTangente;
     correcte := false;
     if ligneRappel in [lrXdeY,lrX,lrY,lrReticule] then couleur := pColorReticule;
     createPen(PstyleTangente,1,colorToRGB(couleur));
     if (FGraphe.indexCourbeEquivalence<0) or
        (FGraphe.indexCourbeEquivalence>=FGraphe.courbes.count) then FGraphe.indexCourbeEquivalence := 0;
     case LigneRappel of
        lrEquivalence,lrEquivalenceManuelle : begin
             if (ligneRappel=lrEquivalence) and not affineEquivalence then exit;
             x3 := x1-abs(x2-x1)/2;
             if x3<Fgraphe.monde[mondeX].mini then x3 := Fgraphe.monde[mondeX].mini;
             x4 := x2+abs(x2-x1)/2;
             if x4>Fgraphe.monde[mondeX].maxi then x4 := Fgraphe.monde[mondeX].maxi;
             y3 := (y1+y2)/2-abs(y2-y1);
             if y3<Fgraphe.monde[mondepH].mini then y3 := Fgraphe.monde[mondepH].mini;
             y4 := (y2+y1)/2+abs(y2-y1);
             if y4>Fgraphe.monde[mondeph].maxi then y4 := Fgraphe.monde[mondeph].maxi;
             WindowRT(ve,pHe,MondepH,vei,phei);
             createPen(PstyleTangente,1,colorToRGB(couleur));
             Fgraphe.canvas.MoveTo(vei,limiteCourbe.bottom);
             Fgraphe.canvas.LineTo(vei,phei);
             Fgraphe.canvas.MoveTo(limiteCourbe.left,phei);
             Fgraphe.canvas.LineTo(vei,phei);
         // perpendiculaire
             traceDroite(ve,pHe,-sqr(monde[mondeX].a)/(pente*sqr(monde[mondepH].a)),x3,y3,x4,y4,mondepH);
         // haut et bas
             traceDroite(x2,y2,pente,x3,y3,x4,y4,mondepH);
             traceDroite(x1,y1,pente,x3,y3,x4,y4,mondepH);
         // équivalence
             traceDroite(ve,pHe,pente,x3,y3,x4,y4,mondepH);
             if LigneRappel=lrEquivalenceManuelle then begin
                 CreateSolidBrush(colorToRGB(pen.color));
                 WindowRT(x1,y1,mondepH,x1i,y1i);
                 WindowRT(x2,y2,mondepH,x2i,y2i);
                 canvas.rectangle(x1i-dimEq,y1i-dimEq,x1i+dimEq,y1i+dimEq);
                 canvas.rectangle(x2i-dimEq,y2i-dimEq,x2i+dimEq,y2i+dimEq);
                 canvas.rectangle(vei-dimEq,phei-dimEq,vei+dimEq,phei+dimEq);
             end;
        end;
        lrTangente : begin
             WindowRT(ve,pHe,MondepH,vei,phei);
             ecart := (monde[mondeX].maxi - monde[mondeX].mini)*LongueurTangente;
             x3 := ve+ecart;
             if x3>monde[mondeX].maxi then x3 := monde[mondeX].maxi;
             x4 := ve-ecart;
             if x4<monde[mondeX].mini then x4 := monde[mondeX].mini;
             ecart := (monde[MondepH].maxi - monde[MondepH].mini)*LongueurTangente;
             y3 := pHe+ecart;
             if y3>monde[mondepH].maxi then y3 := monde[mondepH].maxi;
             y4 := pHe-ecart;
             if y4<monde[mondepH].mini then y4 := monde[mondepH].mini;
             traceDroite(ve,pHe,pente,x4,y4,x3,y3,mondepH);
        end;
        lrXdeY,lrReticule : begin
            WindowRT(ve,pHe,mondepH,vei,phei);
            canvas.moveTo(vei,phei);
            canvas.lineTo(vei,limiteCourbe.bottom);
            case mondepH of
                 mondeY : begin
                     canvas.moveTo(limiteCourbe.left,phei);
                     canvas.lineTo(vei,phei);
                 end;
                 mondeDroit : begin
                     canvas.moveTo(limiteCourbe.right,phei);
                     canvas.lineTo(vei,phei);
                 end;
            end;
        end;
        lrX : begin
            WindowRT(x1,y1,mondepH,x1i,y1i);
            WindowRT(x2,y2,mondepH,x2i,y2i);
            CreatePen(psSolid,1,clHighLight);
            posTrait := limiteCourbe.top + hautCarac div 2;
            Segment(x1i,posTrait,x2i,posTrait);
            // fléches
            if x1i < x2i
               then signe := 1
               else signe := -1;
            Segment(x1i + signe * marge * 3, posTrait + marge, x1i, posTrait);
            Segment(x1i + signe * marge * 3, posTrait - marge, x1i, posTrait);
            signe := -signe;
            Segment(x2i + signe * marge * 3, posTrait + marge, x2i, posTrait);
            Segment(x2i + signe * marge * 3, posTrait - marge, x2i, posTrait);
            CreatePenFin(psDash,clHighLight);
            Segment(x1i,limiteCourbe.bottom,x1i,posTrait);
            Segment(x2i,limiteCourbe.bottom,x2i,posTrait);
        end;
        lrY : begin
            WindowRT(x1,y1,mondepH,x1i,y1i);
            WindowRT(x2,y2,mondepH,x2i,y2i);
            CreatePen(psSolid,1,clHighLight);
            posTrait := LimiteCourbe.right - 4*largCarac;
            Segment(posTrait,y1i,posTrait,y2i);
            // fléches
            if y1i < y2i
               then signe := 1
               else signe := -1;
            Segment(posTrait - marge, y1i + 3 * signe * marge, posTrait, y1i);
            Segment(posTrait + marge, y1i + 3 * signe * marge, posTrait, y1i);
            signe := -signe;
            Segment(posTrait - marge, y2i + 3 * signe * marge, posTrait, y2i);
            Segment(posTrait + marge, y2i + 3 * signe * marge, posTrait, y2i);
            CreatePen(psDash,1,clHighLight);
            Segment(limiteCourbe.left,y1i,posTrait,y1i);
            Segment(limiteCourbe.left,y2i,posTrait,y2i);
        end;
        lrPente : ;
     end;
     pen.mode := pmCopy;
     correcte := true;
end end; // Tequivalence.draw

Procedure Tequivalence.DrawLatex(var latexStr : TstringList);
var exposantX,exposantY : double;

Procedure TraceDroiteLatex(x,y,pente : double;
   xMin,yMin,xMax,Ymax : double);
var x1d,x2d : double;
    y1d,y2d : double;
begin
    if pente=0
       then begin
          x1d := xMin;
          x2d := xMax;
       end
       else begin
          try
          if pente>0
             then begin
                x1d := x+(yMin-y)/pente;
                x2d := x+(yMax-y)/pente;
             end
             else begin
                x1d := x+(yMax-y)/pente;
                x2d := x+(yMin-y)/pente;
             end;
         if x1d<xMin then x1d := xMin;
         if x2d>xMax then x2d := xMax;
         except
             x1d := xMin;
             x2d := xMax;
         end;
    end;
    y1d := y+pente*(x1d-x);
    y2d := y+pente*(x2d-x);
    latexStr.add('\draw['+couleurLatex(pen.color)+styleLatex[PStyleTangente]+',thick] '+
     '(axis cs:'+floatToStrLatex(x1d/exposantX)+','+floatToStrLatex(y1d/exposantY)+')'+
     ' -- '+
     '(axis cs:'+floatToStrLatex(x2d/exposantX)+','+floatToStrLatex(y2d/exposantY)+');');
end;

const dimEq = 3;
var ecart,x3,x4,y3,y4,xAxe : double;
    strX,strY : string;
begin with Fgraphe do begin
     latexStr.clear;
     if monde[mondepH].axe = nil
        then strY := formatReg(pHe / monde[mondepH].Fexposant) + ' '
        else strY := monde[mondepH].axe.formatNombre(pHe / monde[mondepH].Fexposant) + ' ';
     if monde[mondeX].axe = nil
        then strX := formatReg(ve / monde[mondeX].Fexposant) + ' '
        else strX := monde[mondeX].axe.formatNombre(ve / monde[mondeX].Fexposant) + ' ';
     case mondepH of
          mondeY : xAxe := monde[mondeX].mini;
          mondeDroit : xAxe := monde[mondeX].maxi;
          else xAxe := monde[mondeX].mini;
     end;
     exposantX := monde[mondeX].Fexposant;
     exposantY := monde[mondepH].Fexposant;
     case LigneRappel of
        lrEquivalence,lrEquivalenceManuelle : begin
             x3 := x1-(x2-x1)/2;
             x4 := x2+(x2-x1)/2;
             y3 := (y1+y2)/2-abs(y2-y1);
             y4 := (y2+y1)/2+abs(y2-y1);
             latexStr.add('\draw[dotted,thick] '+
             '(axis cs:'+floatToStrLatex(xAxe/exposantX)+','+floatToStrLatex(phe/exposantY)+') node[above right] {'+strY+'} '+
             '-- (axis cs:'+floatToStrLatex(ve/exposantX)+','+floatToStrLatex(phe/exposantY)+') '+
             '-- (axis cs:'+floatToStrLatex(ve/exposantX)+','+floatToStrLatex(monde[mondepH].mini/exposantY)+') node[above right] {'+strX+'} ;');
             traceDroiteLatex(x1,y1,pente,x3,y3,x4,y4);
             traceDroiteLatex(x2,y2,pente,x3,y3,x4,y4);
             traceDroiteLatex(ve,pHe,pente,x3,y3,x4,y4);
        end;
        lrTangente : begin
             ecart := (monde[mondeX].maxi - monde[mondeX].mini)*LongueurTangente;
             x3 := ve+ecart;
             if x3>monde[mondeX].maxi then x3 := monde[mondeX].maxi;
             x4 := ve-ecart;
             if x4<monde[mondeX].mini then x4 := monde[mondeX].mini;
             ecart := (monde[MondepH].maxi - monde[MondepH].mini)*LongueurTangente;
             y3 := pHe+ecart;
             if y3>monde[mondepH].maxi then y3 := monde[mondepH].maxi;
             y4 := pHe-ecart;
             if y4<monde[mondepH].mini then y4 := monde[mondepH].mini;
             traceDroiteLatex(ve,pHe,pente,x4,y4,x3,y3);
             setUnitePente(mondepH);
             strX := unitePente.formatNomPenteUnite(pente);
             latexStr.add('\draw (axis cs:'+floatToStrLatex(ve/exposantX)+','+
                                            floatToStrLatex(phe/exposantY)+
                                 ') node[above right] {'+
                                            strX+'} ;');
        end;
        lrXdeY,lrReticule : begin
              latexStr.add('\draw[dash dot,thick] '+
                '(axis cs:'+floatToStrLatex(xAxe/exposantX)+','+floatToStrLatex (phe/exposantY)+') node[above right] {'+strY+'} '+
                '-- (axis cs:'+floatToStrLatex(ve/exposantX)+','+floatToStrLatex(phe/exposantY)+') '+
                '-- (axis cs:'+floatToStrLatex(ve/exposantX)+','+floatToStrLatex(monde[mondepH].mini/exposantY)+') node[above right] {'+strX+'} ;');
        end;
     end;
end end; // equivalence.drawLatex

Procedure Tequivalence.DrawFugitif;
var ecartX,ecartY : double;
    DC : HDC;
begin with Fgraphe do begin
     DC := canvas.handle;
     setRop2(DC,R2_NotXorPen);
     createPen(PstyleTangente,1,PcolorTangente);
     ecartX := (monde[mondeX].maxi - monde[mondeX].mini)*LongueurTangente;
     ecartY := (monde[MondepH].maxi - monde[MondepH].mini)*LongueurTangente;
     traceDroite(ve,pHe,pente,ve-ecartX,pHe-ecartY,
                              ve+ecartX,pHe+ecartY,mondepH);
     pen.mode := pmCOPY;
end end;

constructor Tequivalence.Create(v1,ph1,v2,ph2,v,ph,p : double;gr : TgrapheReg);
begin
     Inherited create(gr);
     ve := v;
     phe := pH;
     pente := p;
     x2 := v2;
     y2 := ph2;
     x1 := v1;
     y1 := ph1;
     mondepH := mondeY;
     varY := nil;
     //modelisee := false;
     index2 := 0;
     index1 := 0;
     commentaire := '';
end;

constructor Tequivalence.CreateVide(gr : TgrapheReg);
begin
     Inherited create(gr);
     ve := 10;
     phe := 10;
     pente := 1;
     x2 := 1;
     y2 := 1;
     x1 := 1;
     y1 := 1;
     mondepH := mondeY;
     varY := nil;
     pen.color := clBlack;
     commentaire := '';
end;

Procedure TgrapheReg.AjouteEquivalence(i : integer;effaceDouble : boolean);
var penteTg : double;
    codeDerivee : integer;
    penteTgSI : double;
    iApres : integer;

Procedure CherchePente;
begin
     vee := monde[mondeX].axe.valeur[i];
     pHee := monde[mondeDerivee].axe.valeur[i];
     penteTg := Grandeurs[codeDerivee].valeur[i];
     v11 := vee;
     v22 := vee;
     pH11 := pHee;
     pH22 := pHee;
end;// CherchePente

var t : integer;
    NewEquivalence : Tequivalence;
    dx : double;
begin // AjouteEquivalence
     codeDerivee := indexDerivee(monde[mondeDerivee].axe,monde[mondeX].axe,true,true);
     if codeDerivee=grandeurInconnue then exit;
     case LigneRappelCourante of
          lrEquivalence,lrEquivalenceManuelle : if not ChercheVpH(i,iApres,penteTg) then exit;
          lrTangente : CherchePente;
     end;
     if uniteSIGlb
        then penteTgSI := penteTg*coeffSIpente
        else penteTgSI := penteTg;
     with monde[mondeX] do dx := (monde[mondeX].axe.valeur[i+1]-monde[mondeX].axe.valeur[i-1])/4;
     for t := 0 to pred(equivalences[pageCourante].count) do
         with equivalences[pageCourante].items[t] do
             if (abs(x1-monde[mondeX].axe.valeur[i])<dx) then begin
                  if effaceDouble then
                     equivalences[pageCourante].Delete(t);
                  exit;
             end;
      NewEquivalence := Tequivalence.Create(v11,ph11,v22,ph22,vee,phee,penteTgSI,self);
      NewEquivalence.index1 := i;
      NewEquivalence.index2 := iApres;
      NewEquivalence.mondepH := mondeDerivee;
      NewEquivalence.ligneRappel := ligneRappelCourante;
      equivalences[pageCourante].Add(NewEquivalence);
      StatusSegment[0].clear;
      StatusSegment[1].clear;
      StatusSegment[1].Add(monde[mondeX].Axe.formatNomEtUnite(vee));
      StatusSegment[1].Add(monde[mondeDerivee].Axe.formatNomEtUnite(pHee));
      StatusSegment[1].Add(grandeurs[codeDerivee].formatNomEtUnite(penteTg));
      StatusSegment[0].Add(monde[mondeX].Axe.Nom);
      StatusSegment[0].Add(monde[mondeDerivee].Axe.Nom);
      StatusSegment[0].Add(grandeurs[codeDerivee].Nom);
      if ligneRappelCourante=lrEquivalenceManuelle then
         equivalenceCourante := newEquivalence;
end;// AjouteEquivalence

Procedure Tequivalence.SetValeurEquivalence(i : integer);
var codeDerivee : integer;
begin
if (FGraphe.indexCourbeEquivalence<0) or
   (FGraphe.indexCourbeEquivalence>=FGraphe.courbes.count) then FGraphe.indexCourbeEquivalence := 0;
with Fgraphe.courbes[Fgraphe.indexCourbeEquivalence] do begin
     ve := valX[i];
     pHe := valY[i];
     codeDerivee := indexDerivee(varY,varX,true,true);
     if codeDerivee=grandeurInconnue
         then pente := 0
         else pente := Grandeurs[codeDerivee].valeur[i];
end end;// SetValeurEquivalence

procedure TgrapheReg.RemplitTableauEquivalence;
var ligne,i : integer;
    codeDerivee : integer;
begin
     if LigneRappelCourante in [lrEquivalence,lrEquivalenceManuelle,lrTangente]
        then begin
           codeDerivee := indexDerivee(monde[mondeDerivee].axe,monde[mondeX].axe,true,true);
           if codeDerivee=grandeurInconnue then exit;
        end
        else codeDerivee := 0;
     if curseurModeleDlg=nil then
        Application.CreateForm(TcurseurModeleDlg,curseurModeleDlg);
// prévoir le cas où le curseur pointe sur deux courbes différentes
// premier point gain, deuxième point phase par exemple        
     with curseurModeleDlg.tableau do begin
          rowCount := equivalences[pageCourante].count+3;
          colCount := 3;
          cells[0,0] := monde[mondeX].axe.nom;
          Cells[0,1] := monde[mondeX].axe.NomUnite;
          cells[1,0] := monde[mondeDerivee].axe.nom;
          Cells[1,1] := monde[mondeDerivee].axe.NomUnite;
          if LigneRappelCourante in [lrXdeY,lrReticule,lrX,lrY]
             then begin
                 cells[2,0] := stCommentaire;
                 cells[2,1] := '';
             end
             else begin // equivalence tangente
                 cells[2,0] := grandeurs[codeDerivee].nom;
                 Cells[2,1] := grandeurs[codeDerivee].NomUnite;
             end;
          ligne := 1;
          for i := 0 to pred(equivalences[pageCourante].count) do
          with equivalences[pageCourante].items[i] do begin
              inc(ligne);
              cells[0,ligne] := formatReg(ve);
              cells[1,ligne] := formatReg(phe);
              if LigneRappel in [lrTangente,lrEquivalence,lrEquivalenceManuelle,lrPente]
                 then cells[2,ligne] := formatReg(pente)
                 else cells[2,ligne] := commentaire;
          end;
          inc(ligne);
          for i := 0 to 2 do cells[i,ligne] := ''
     end;
end;

Procedure Tequivalence.Store;
begin
  writeln(fichier,pente);{1}
  writeln(fichier,ve);{2}
  writeln(fichier,pHe);{3}
  writeln(fichier,vei);{4}
  writeln(fichier,phei);{5}
  writeln(fichier,mondepH);{6}
  writeln(fichier,ord(LigneRappel));{7}
  writeln(fichier,ord(false));{8}
  ecritChaineRW3(commentaire);{9}
  writeln(fichier,pen.color);{10}
end;

Procedure Tequivalence.StoreXML(ANode : IXMLNOde);
begin
  writeFloatXML(ANode,stPente,pente);
  writeFloatXML(ANode,'Ve',ve);
  writeFloatXML(ANode,'Phe',pHe);
  writeIntegerXML(ANode,'Index1',index1);
  writeIntegerXML(ANode,stMonde,mondepH);
  writeIntegerXML(ANode,'isRappel',ord(LigneRappel));
  writeStringXML(ANode,'Comment',commentaire);
  writeIntegerXML(ANode,stCouleur,pen.color);
end;

Procedure Tequivalence.Load;
var i,imax : integer;
    zi : integer;
    zw : longWord;
begin
  imax := NbreLigneWin(ligneWin);
  readln(fichier,pente); {1}
  readln(fichier,ve); {2}
  readln(fichier,Phe); {3}
  readln(fichier,vei); {4}
  readln(fichier,phei);{5}
  readln(fichier,mondepH);{6}
  readln(fichier,zi);{7}
  ligneRappel := TligneRappel(zi);
  litBooleanWin;{8}
  litLigneWinU;
  commentaire := ligneWin;{9}
  litligneWin;
  try
  zw := strToInt(ligneWin);
  pen.color := zw;
  except
     pen.color := clBlack;
  end;
  for i := 11 to imax do readln(fichier);
end;

Procedure Tequivalence.LoadXML(ANode : IXMLNOde);

procedure litEnfant(ANode : IXMLNOde);
var zi : integer;
begin
    if ANode.NodeName=stPente then begin
        pente := getFloatXML(Anode);
       exit;
    end;
    if ANode.NodeName='Ve' then begin
        ve := getFloatXML(Anode);
        exit;
    end;
    if ANode.NodeName='Index1' then begin
        index1 := getIntegerXML(Anode);
        exit;
    end;
    if ANode.NodeName='Phe' then begin
        Phe := getFloatXML(Anode);
        exit;
    end;
    if ANode.NodeName=stMonde then begin
        mondepH := getIntegerXML(Anode);
        exit;
    end;
    if ANode.NodeName='isRappel' then begin
        zi := getIntegerXML(Anode);
        ligneRappel := TligneRappel(zi);
        exit;
    end;
    if ANode.NodeName='isModele' then begin
        getBoolXML(Anode);
        exit;
    end;
    if ANode.NodeName='Comment' then begin
        commentaire := ANode.text;
        exit;
    end;
    if ANode.NodeName=stCouleur then begin
        pen.color := getColorXML(Anode);
        exit;
    end;
end;

var i : integer;
begin
 if ANode.HasChildNodes then
      for I := 0 to ANode.ChildNodes.Count - 1 do
          LitEnfant(ANode.ChildNodes.Nodes[I]);
end;

Function TgrapheReg.ChercheVpH(i : integer;var iApres : integer;var penteTg : double) : boolean;
var veAp,pHeAp : double;
    codeDerivee : integer;

function ChercheEqui(i : integer) : boolean;
var v3,pH3,penteCourbe : double;
// intersection droite (veeAp pHeAp pentetg) et (v3 ph3 pentecourbe)
begin
     penteCourbe :=
        (monde[MondeY].axe.valeur[succ(i)]-monde[mondeY].axe.valeur[i])/
        (monde[mondeX].axe.valeur[succ(i)]-monde[mondeX].axe.valeur[i]);
     v3 := monde[mondeX].axe.valeur[i];
     ph3 := monde[mondeY].axe.valeur[i];
     vee := (pH3-penteCourbe*v3-pHeAp+penteTg*veAp)/(penteTg-penteCourbe);
     pHee := pH3+penteCourbe*(vee-v3);
     result := ((vee-monde[mondeX].axe.valeur[succ(i)])*
               (vee-monde[mondeX].axe.valeur[i])<=0) and
               ((phee-monde[mondeY].axe.valeur[succ(i)])*
               (phee-monde[mondeY].axe.valeur[i])<=0);;
end; // ChercheEqui

var i2,i3,iprec,isuiv : integer;
    derRef : double;
    k,kmax : integer;
    VcroissantSelonI,Croissant : boolean;
begin  // ChercheVpH
     result := false;
     vee := monde[mondeX].Maxi;
     codeDerivee := indexDerivee(monde[mondeDerivee].axe,
                                 monde[mondeX].axe,true,true);
     penteTg := grandeurs[codeDerivee].valeur[i];
     derRef := abs(penteTg);
     i2 := i;
     croissant := true;
     iprec := i-2;
     if iprec<0 then iprec := 0;
     isuiv := i+2;
     if isuiv>=pages[pageCourante].nmes
        then isuiv := pred(pages[pageCourante].nmes);
     with monde[mondeX].axe do VcroissantSelonI :=
          valeur[isuiv]>valeur[iprec];
     repeat inc(i2)
     until (i2>=pages[pageCourante].nmes) or
           (abs(grandeurs[codeDerivee].valeur[i2])>derRef);
     if i2>=pages[pageCourante].nmes then begin
        croissant := false;
        i2 := i;
        repeat dec(i2)
        until (i2<0) or
              (abs(grandeurs[codeDerivee].valeur[i2])>derRef);
        if i2<0 then exit;
        repeat dec(i2);
        until (i2<0) or
               (abs(grandeurs[codeDerivee].valeur[i2])<derRef);
        if i2<0 then exit;
     end
     else begin
         repeat inc(i2);
         until (i2>=pages[pageCourante].nmes) or
          (abs(grandeurs[codeDerivee].valeur[i2])<derRef);
         if i2>=pages[pageCourante].nmes then exit;
     end;
     if not croissant then swap(i,i2);
// i2 : point après l'équivalence de même pente
     v11 := monde[mondeX].axe.valeur[i];
     ph11 := monde[mondeY].axe.valeur[i];
     v22 := monde[mondeX].axe.valeur[i2]+(penteTg-grandeurs[codeDerivee].valeur[i2])*
        (monde[mondeX].axe.valeur[i2]-monde[mondeX].axe.valeur[pred(i2)])/
        (grandeurs[codeDerivee].valeur[i2]-grandeurs[codeDerivee].valeur[pred(i2)]);
     ph22 := monde[mondeY].axe.valeur[i2]+(v22-monde[mondeX].axe.valeur[i2])*
        (monde[mondeY].axe.valeur[i2]-monde[mondeY].axe.valeur[pred(i2)])/
        (monde[mondeX].axe.valeur[i2]-monde[mondeX].axe.valeur[pred(i2)]);
// valeur approchée de ve pHe
     veAp := (StoechBecherGlb*v11+StoechBuretteGlb*v22)/(StoechBecherGlb+StoechBuretteGlb);
     pHeAp := (StoechBecherGlb*pH11+StoechBuretteGlb*pH22)/(StoechBecherGlb+StoechBuretteGlb);
// cherche intersection avec courbe
     i3 := (i+i2) div 2;
     k := 0;
     kmax := abs(i3-i2);
     if kmax>16 then kmax := 16;
     repeat
        inc(k);
        result := chercheEqui(i3);
// result si vee entre les deux points
        if not Result then begin
           if vee>monde[mondeX].axe.valeur[i3]
               then if VcroissantSelonI then inc(i3) else dec(i3)
               else if VcroissantSelonI then dec(i3) else inc(i3);
        end;
     until result or (k>kmax) or (i3>i2) or (i3<i);
     if not result then chercheEqui((i+i2) div 2);
// on remet à la valeur approchée la plus raisonnable
// on vérifie si raisonnable
     result := (vee<monde[mondeX].maxi) and
               (vee>monde[mondeX].mini) and
               ((abs(vee-veAp)/veAp)<0.08);
     iApres := i2;
end; // ChercheVpH

// pH=if(v<Ve,pKa+log(v/(Ve-v)),pcB+log((v-Ve)/(v+V0)))
// dosage acide faible base forte




