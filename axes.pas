// Axes.pas : fichier inclus de graphker.pas pour tracé des axes

procedure TGrapheReg.TraceTitreAxe(g : tgrandeur;m : TindiceMonde;
      indexCourbe : integer);
var signeX,oldxtitre : integer;
    couleurLoc : TcolorRef;
    U,N : string;
    x0,y0 : Integer;

Procedure TextOutLoc(const S : string);
var x : integer;
    avecIncert : boolean;
begin with monde[m] do begin
   if S='' then exit;
   if (courbes.count>1) and
      (m in [mondeDroit,mondeY]) and
      not(superposePage) and
      (trPoint in courbes[indexCourbe].trace) then begin
       canvas.pen.Color := couleurLoc;
       x := xTitre;
       avecIncert := avecEllipse and axe.incertDefinie;
       if m=mondeDroit then dec(x,canvas.textWidth(S)+largCarac);
       if not avecIncert then
          traceMotif(x,yTitre+hautCarac div 2,courbes[indexCourbe].motif);
       if m=mondeY then inc(xTitre,largCarac);
   end;
   if graduationZeroX or graduationZeroY
      then MyTextOutFond(xTitre,yTitre,S,clWindow)
      else MyTextOut(xTitre,yTitre,S);
   xTitre := xTitre+signeX*canvas.textWidth(S);
end end;

Procedure AxeItalique;
begin with monde[m] do begin
        if (signeX<0) and (length(U)>0) then begin
           TextOutLoc(U);
           xTitre := xTitre-largCarac;
        end;
        canvas.Font.style := [fsItalic];
        TextOutLoc(N); // en italique
        canvas.Font.style := [];
        if (signeX>0) and (length(U)>0) then begin
           xTitre := xTitre+largCarac;
           TextOutLoc(U);
        end;
end end;

var i : integer;
    RectangleTitre : Trect;
begin // traceTitreAxe
    if g.fonct.genreC=g_Texte then exit;
    canvas.brush.style := bsClear;
    if (m=mondeX) and UnAxeX
       then couleurLoc := couleurAxeX
       else if superposePage
            then couleurLoc := clBlack
            else couleurLoc := courbes[indexCourbe].couleur;
    oldXtitre := monde[m].xTitre;
    signeX := +1;
    canvas.font.Color := couleurLoc;
    if m=mondeX
       then begin
            if axeYbas
                then SetTextAlign(TA_right+TA_bottom)
                else SetTextAlign(TA_right+TA_top);
            signeX := -1;
       end
       else if (OgPolaire in OptionGraphe)
           then begin
                WindowXY(0,0,mondeY,x0,y0);
                signeX := -1;
                setTextAlign(TA_right+TA_top);
           end
           else begin
              if OgAnalyseurLogique in OptionGraphe
                then begin
                    setTextAlign(TA_left+TA_top);
                end
                else case m of
                    mondeDroit : begin
                       setTextAlign(TA_right+TA_top);
                       signeX := -1;
                    end;
                    mondeY : if axeYbas
                       then setTextAlign(TA_left+TA_bottom)
                       else setTextAlign(TA_left+TA_top);
                    else begin
                        m := mondeSans;
                        setTextAlign(TA_left+TA_top);
                    end;
                end;
           end;
        if g.affSignif
           then N := g.fonct.expression
           else N := g.nom;
        with monde[m] do begin
        if graduation=gInv then N := '1/'+N;
        if graduation=gdB
           then U := '/dB'
           else U := g.UniteAxe(Fexposant);
        if (m=mondeY) and (courbes[0].trace=[trResidus]) then begin
            if not(typeResidu=residuN) then U := '';// adimensionnée;
            case typeResidu of
              residuStudent : N := 'ti* ('+N+')';
              residuNormalise : N := DeltaMaj+'('+N+')/u('+N+')';
              residuN : N := DeltaMaj+N;
            end;
        end;
        if UseItalic then axeItalique else TextOutLoc(N+U);
        xTitre := xTitre+signeX*LargCarac;
        if m<>mondeX then begin
           rectangleTitre := rect(oldxtitre,ytitre,xtitre,ytitre+hautCarac);
           for i := 1 to maxOrdonnee do
                   if g.nom=coordonnee[i].nomY then begin
                        coordonnee[i].iCourbe := indexCourbe;
                        if coordonnee[i].regionTitre<>0 then
                           DeleteObject(coordonnee[i].regionTitre);
                        coordonnee[i].regionTitre := createRectRgnIndirect(rectangleTitre);
                        break;
                   end;
        end;
        TitreAxe.Add(g.nom);
    end // monde[m]
end; // traceTitreAxe

procedure TGrapheReg.DrawAxis(initialisation : boolean);
var xNombreMax,xNombreMin,signeMargeX,signeMargeY : integer;
    PointCourant : double;
    yAxeX,xAxeY : integer;
    couleurAxeY : TcolorRef;
    GraduationYtrace : boolean;
    mondeYseul : boolean;
    penWidthGrad,penWidthAxe : integer;
    CouleurGrillePale :  Tcolor;

procedure OutText(x,y : integer;const S : string;opaque : boolean);
begin
      if opaque
         then MyTextOutFond(x,y,S,clWindow)
         else MyTextOut(x,y,S);
end;

Function YcorrectNombre(y : integer;m : TindiceMonde) : boolean;
begin with monde[m] do
     if axeYpositif
        then YcorrectNombre := (y>CourbeBottom) and (y<=CourbeTop-3*marge)
        else YcorrectNombre := (y>(CourbeTop+marge*3)) and (y<=CourbeBottom)
end;

Function YcorrectGrad(y : integer;m : TindiceMonde) : boolean;
begin with monde[m] do
     if axeYpositif
        then result := (y>CourbeBottom) and
                       (y<=CourbeTop-3*marge) and
                       (y<>yAxeX)
        else result := (y>(CourbeTop+marge*3)) and
                       (y<=CourbeBottom) and
                       (y<>yAxeX)
end;

Function XcorrectNombre(x : integer) : boolean;
begin
     XcorrectNombre := (x>=xNombreMin) and (x<=xNombreMax)
end;

Function XcorrectGrad(x : integer) : boolean;
begin
     XcorrectGrad := (x>=limiteCourbe.left) and
                     (x<=limiteCourbe.right) and
                     (x<>xAxeY)
end;

Procedure graduationX(x,y : integer;quadrillage,grande : boolean);
begin
  if quadrillage
       then begin
    // pSSolid psDot psDash psDashDot psDashDotDot psClear
          if grande
             then begin
                canvas.pen.width := penWidthGrad;
                canvas.pen.style := psSolid;
                canvas.pen.color := couleurGrille;
             end
             else begin
                canvas.pen.width := 1;
                canvas.pen.style := psDot;
                canvas.pen.color := couleurGrillePale;
             end;
          segment(x,limiteCourbe.top,x,limiteCourbe.bottom);
       end
       else begin
          canvas.pen.style := psSolid;
          canvas.pen.color := couleurAxeX;
          canvas.pen.width := penWidthGrad;
          if grande
             then segment(x,y,x,y+signeMargeY*marge*tailleTick)
             else segment(x,y,x,y+signeMargeY*marge*tailleTick div 2)
       end;
end;

Procedure graduationY(y : integer;quadrillage,grande : boolean);
begin
   if quadrillage
       then begin
          if grande
             then begin
                canvas.pen.width := penWidthGrad;
                canvas.pen.style := psSolid;
                canvas.pen.color := couleurGrille;
             end
             else begin
                canvas.pen.width := 1;
                canvas.pen.style := psDot;
                canvas.pen.color := couleurGrillePale;
             end;
          segment(limiteCourbe.left,y,limiteCourbe.right,y)
       end
       else begin
          canvas.pen.style := psSolid;
          canvas.pen.width := penWidthGrad;
          canvas.pen.color := couleurAxeY;
          if grande
             then segment(xAxeY,y,xAxeY+signeMargeX*marge*tailleTick,y)
             else segment(xAxeY,y,xAxeY+signeMargeX*marge*tailleTick div 2,y);
       end
end;

  procedure initAxeX;
  var x1,y1 : Integer;
  begin with monde[mondeX] do begin
    PointCourant := PointDebut;
    CreatePen(psSolid,penWidthAxe,CouleurAxeX);
    if (Graduation=gLin) and
        not(GraduationZeroY) then begin
            WindowXY(0,0,mondeY,x1,y1);
            if (x1>limiteCourbe.left) and (x1<limiteCourbe.right) then
            with limiteCourbe do segment(x1,bottom,x1,top);
    end;
    xNombreMax := limiteFenetre.right-largCarac*NbreChiffres div 2;
    xNombreMin := limiteFenetre.left+largCarac*NbreChiffres div 2;
    if monde[mondeX].axe<>nil then
          TraceTitreAxe(Axe,mondeX,0);
    CreatePen(psSolid,penWidthAxe,CouleurAxeX);
    with limiteFenetre do begin
          segment(left,yAxeX,right,yAxeX);
          // fléche X
          segment(right-marge*3,yAxeX+marge,right,yAxeX);
          segment(right-marge*3,yAxeX-marge,right,yAxeX);
    end;
    if axeYbas
          then begin
             SetTextAlign(TA_center+TA_bottom);
          end
          else begin
             SetTextAlign(TA_center+TA_top);
          end;
    canvas.pen.color := couleurGrille;
  end end;// initAxeX

  procedure traceAxeX;
  var xs,ys : Integer;
      NombreAff : string;
      Ticks : integer;
      grandeGraduation,Q : boolean;
      Xmax : double;
  begin with monde[mondeX] do begin
       Q := OgQuadrillage in OptionGraphe;
       Ticks := TickDebut;
       if orthonorme
          then Xmax := maxiOrtho
          else Xmax := maxi;
       repeat
          windowXY(PointCourant,monde[mondeY].Mini,mondeY,xs,ys);
          if XcorrectGrad(xs) then begin
               ys := yAxeX;
               grandeGraduation := (Ticks mod NTicks)=0;
               graduationX(xs,ys,Q,grandeGraduation);
               if XcorrectNombre(xs) and (grandeGraduation) then begin
                  if abs(PointCourant)< deltaAxe then pointCourant := 0;
                  if GraduationPiActive
                     then NombreAff := formatRadian(pointCourant)
                     else NombreAff := formatMonde(pointCourant);
                  if xs<>xAxeY
                     then OutText(xs,ys+signeMargeY*marge,NombreAff,graduationZeroX)
                     else if PointCourant=0
                          then OutText(xs+marge,ys+signeMargeY*marge,'0',graduationZeroX)
              end;
          end;
          PointCourant := PointCourant+deltaAxe;
          inc(Ticks);
      until ( PointCourant>=Xmax );
      CreatePen(psSolid,penWidthAxe,CouleurAxeX);
      with limiteFenetre do segment(left,yAxeX,right,yAxeX);
 end end; // traceAxeX

procedure tracePolaire;

Function MaxInteger(a,b : integer)  : integer;
begin
    if abs(a)>abs(b) then result := abs(a) else result := abs(b)
end;

  var xs,ys,x0,y0 : Integer;
      NombreAff : string;
      NU : string;
      m : TindiceMonde;
      ticks : integer;
      grandeGraduation : boolean;
      minix,miniy,maxix,maxiy : double;
      pente,maxiXY : double;
      i : integer;
      oldmaxX,oldminX,oldmaxY,oldminY : integer;
  begin with limiteFenetre do begin
      if monde[mondeX].maxi>monde[mondeY].maxi
          then m := mondeX
          else m := mondeY;
      MondeXY(left,bottom,mondeY,miniX,miniY);
      MondeXY(right,top,mondeY,maxiX,maxiY);
      if maxiX>maxiY
          then maxiXY := maxiX
          else maxiXY := maxiY;
      NU := monde[mondeY].Axe.nom+monde[mondeY].Axe.UniteAxe(monde[m].Fexposant);
      xNombreMax := right-(length(NU)+monde[m].NbreChiffres)*largCarac;
      windowXY(0,0,mondeY,x0,y0);
      Ticks := monde[m].TickDebut;
      with monde[mondeX] do begin
           oldminX := miniInt;
           oldmaxX := maxiInt;
           maxiInt := maxInteger(miniInt,maxiInt)*3; // pour tracer des ellipses plus larges que l'écran
           miniInt := -maxiInt;
      end;
      with monde[mondeY] do begin
           oldminY := miniInt;
           oldmaxY := maxiInt;
           maxiInt := maxInteger(miniInt,maxiInt)*3;
           miniInt := -maxiInt;
      end;
      if (OgQuadrillage in OptionGraphe)
         then begin
            SetTextAlign(TA_left+TA_top);
            canvas.pen.width := penWidthGrad;
            PointCourant := monde[m].pointDebut;
            repeat
               windowXY(PointCourant,PointCourant,mondeY,xs,ys);
               if (xs>=0) and (ys>=0) then begin
                 grandeGraduation := (Ticks mod monde[m].NTicks)=0;
                 if grandeGraduation
                    then begin
                       canvas.pen.width := penWidthGrad;
                       canvas.pen.style := psSolid;
                       canvas.pen.color := couleurGrille;
                    end
                    else begin
                       canvas.pen.width := 1;
                       canvas.pen.style := psDot;
                       canvas.pen.color := couleurGrillePale;
                    end;
                 canvas.ellipse(2*x0-xs,ys,xs,2*y0-ys);
               end;
// Windows n'est pas capable de gérer une cloture dans un EMF =>
// il faut utiliser SelectClipRgn(PaintDC,ClipRegion)
               PointCourant := PointCourant+monde[m].deltaAxe;
               inc(Ticks);
            until PointCourant>=maxiXY;
         end
         else begin
             SetTextAlign(TA_center+TA_top);
         end;
      PointCourant := monde[m].pointDebut;
      CreatePen(psSolid,penWidthGrad,CouleurAxeX);
      Ticks := monde[m].TickDebut;
      repeat
        windowXY(PointCourant,PointCourant,mondeY,xs,ys);
        grandeGraduation := ((Ticks mod monde[m].NTicks)=0) and
                              (xs<=xNombreMax);
        if grandeGraduation then begin
             with Monde[m] do NombreAff := formatMonde(pointCourant+zeroPolaire);
             OutText(xs,y0+signeMargeY*marge,NombreAff,true);
        end;
        segment(xs,y0+marge,xs,y0-marge);
        if ys>=top then segment(x0-marge,ys,x0+marge,ys);
        PointCourant := -PointCourant;
        windowXY(PointCourant,PointCourant,mondeY,xs,ys);
        PointCourant := -PointCourant;
        if xs>=left then segment(xs,y0+marge,xs,y0-marge);
          if ys<=bottom then segment(x0-marge,ys,x0+marge,ys);
        PointCourant := PointCourant+monde[m].deltaAxe;
        inc(Ticks);
      until PointCourant>=maxiXY;
      CreatePen(psDashDot,penWidthGrad,CouleurAxeX);
      segment(x0,bottom,x0,top); // axe y
      segment(left,y0,right,y0); // axe x
      if (OgQuadrillage in OptionGraphe) then begin
         CreatePen(psDashDot,penWidthGrad,CouleurGrillePale);
         for i := 1 to 5 do begin
             pente := math.tan(i*pi/12);
             TraceDroite(0,0,pente,miniX,miniY,maxiX,maxiY);
             TraceDroite(0,0,-pente,miniX,miniY,maxiX,maxiY);
         end;
      end;
      TraceTitreAxe(monde[mondeY].axe,mondeY,0);
      canvas.font.Color := CouleurAxeX;
      with monde[mondeX] do begin
           maxiInt := oldmaxX; // retour à la normale
           miniInt := oldminX;
      end;
      with monde[mondeY] do begin
           maxiInt := oldmaxY;
           miniInt := oldminY;
      end;
 end end; // tracePolaire

 procedure initAxeY(m : TindiceMonde;indexCourbe : integer);
 var x1,y1 : Integer;
 begin with monde[m] do begin
        monde[m].Axe := courbes[indexCourbe].varY;
        if courbes[indexCourbe].varY.fonct.genreC=g_Texte then exit;
        if mondeYseul
           then couleurAxeY := couleurAxeX
           else couleurAxeY := courbes[indexCourbe].couleur;
        if not empilePage then TraceTitreAxe(Axe,m,indexCourbe);
        if mondeYseul then canvas.font.Color := CouleurAxeX;
        PointCourant := PointDebut;
        CreatePen(psSolid,penWidthAxe,CouleurAxeY);
        if (Graduation=gLin) and
           not(GraduationZeroX) then begin
              WindowXY(0,0,m,x1,y1);
              if yCorrectGrad(y1,m) then
                 with limiteCourbe do segment(left,y1,right,y1);
        end;
        if (m=mondeDroit) and not(OgAnalyseurLogique in OptionGraphe)
           then setTextAlign(TA_left+TA_bottom)
           else setTextAlign(TA_right+TA_bottom);
        CreatePen(psSolid,penWidthGrad,couleurAxeX);
 end end; // initAxeY

 procedure traceAxeY(m : TindiceMonde);
 var xs,ys,ticks : Integer;
     nombreAff : string;
     grandeGraduation,Q : boolean;
     Ymax : double;
 begin with monde[m] do begin
      if axe.fonct.genreC=g_Texte then exit;
      Q := (OgQuadrillage in OptionGraphe) and
           ( not(GraduationYtrace) or
            (OgAnalyseurLogique in OptionGraphe));
      GraduationYTrace := true;
      Ticks := TickDebut;
      if Orthonorme
         then Ymax := maxiOrtho
         else Ymax := maxi;
      repeat
           windowXY(monde[mondeX].Mini,PointCourant,m,xs,ys);
             // coordonnée écran de la marque
           if YcorrectGrad(ys,m) then begin
                 grandeGraduation := (Ticks mod NTicks)=0;
                 if YcorrectNombre(ys,m) and (grandeGraduation) then begin
                    if abs(pointCourant) < deltaAxe then pointCourant := 0;
                    if graduationPiActive
                       then NombreAff := formatRadian(pointCourant)
                       else NombreAff := formatMonde(pointCourant);
                    if ys<>yAxeX
                       then OutText(xAxeY+signeMargeX*marge,
                                    ys+signeMargeY*marge,NombreAff,GraduationZeroY)
                       else if PointCourant=0
                          then OutText(xAxeY+signeMargeX*marge,
                                       ys,'0',GraduationZeroY);
                 end;
                 graduationY(ys,Q,grandeGraduation);
           end;
           pointCourant := pointCourant+deltaAxe;
           inc(Ticks);
      until ( pointCourant>=Ymax );
      CreatePen(psSolid,penWidthAxe,CouleurAxeY);
      segment(xAxeY,CourbeBottom,xAxeY,CourbeTop);
      if avecAxeY then begin // fléche Y
            segment(xAxeY-marge,courbeTop+3*signeMargeY*marge,xAxeY,courbeTop);
            segment(xAxeY+marge,courbeTop+3*signeMargeY*marge,xAxeY,courbeTop);
      end;
end end; // traceAxeY

 procedure traceAxeBitsY(m : TindiceMonde);
 var ys,i : Integer;
 begin with monde[m] do begin
      graduationYtrace := true;
      CreatePen(psSolid,penWidthAxe,clSilver);
      for i := 0 to NombreBits - 1 do begin
           ys := courbeBottom+i*ecartBit;
           segment(xAxeY,ys,limiteCourbe.right,ys);
           ys := ys+(valeurBit div 2);
           OutText(xAxeY+signeMargeX*marge,ys,'bit '+intToStr(i),GraduationZeroY);
           ys := ys+(valeurBit div 2);
           segment(xAxeY,ys,limiteCourbe.right,ys);
      end;
      CreatePen(psSolid,penWidthAxe,CouleurAxeY);
      segment(xAxeY,CourbeBottom,xAxeY,CourbeTop);
      if avecAxeY then begin // fléche Y
           segment(xAxeY-marge,courbeTop+3*signeMargeY*marge,xAxeY,courbeTop);
           segment(xAxeY+marge,courbeTop+3*signeMargeY*marge,xAxeY,courbeTop);
      end;
end end; // traceAxeBitsY

procedure traceAxeInvY(m : TindiceMonde);
var i,j,debut,fin : integer;
    xs,ys,ypred,ysucc : Integer;
    intermediaire,negatif,fini : boolean;
    ecart : integer;
    yy : single;
    Q : boolean;
begin with Monde[mondeY] do begin
   Q := (OgQuadrillage in OptionGraphe) and (m=mondeY);
   Intermediaire := (Maxi/Mini) <= 100;
   Negatif := mini<0;
   Ecart := 2*hautCarac;
   if Negatif
      then begin
          debut := floor(log10(-Maxi));
          fin := ceil(log10(-Mini));
      end
      else begin
          debut := floor(log10(Mini));
          fin := ceil(log10(Maxi));
      end;
   for i := debut to fin do begin
        yy := dix(-i);
        if negatif then yy := -yy;
	windowRT(monde[mondeX].Mini,yy,m,xs,ys);
	if YcorrectGrad(ys,m) then begin
	     graduationY(ys,Q,true);
       if YcorrectNombre(ys,m) then
	        OutText(xAxeY+signeMargeX*marge,ys,formatMonde(yy),graduationZeroY);
	end;
  ypred := ys-ecart;
  if ypred<0 then ypred := courbeBottom;
	if intermediaire then if negatif
       then windowRT(monde[mondeX].Mini,yy*10,m,xs,ysucc)
       else windowRT(monde[mondeX].Mini,yy/10,m,xs,ysucc);
  ysucc := ysucc+ecart;
	if negatif then j := 2 else j := 9;
  repeat
      if negatif
           then yy := -j*dix(-i)
           else yy := j*dix(-i)/10;
	     windowRT(monde[mondeX].Mini,yy,m,xs,ys);
	     if YcorrectGrad(ys,m) then
	         if intermediaire
		     then begin
		     	graduationY(ys,Q,false);
                        if YcorrectNombre(ys,m) and
		     	   ( ys>ysucc ) and ( ys<ypred ) then begin
		     		OutText(xAxeY+signeMargeX*marge,ys,formatMonde(yy),graduationZeroY);
		     		ypred := ys-ecart;
		     	end;
		     end
		     else graduationY(ys,false,false);
                if negatif
                   then begin
                      inc(j);
                      fini := j=10;
                   end
                   else begin
                      dec(j);
                      fini := j=1;
                   end;
	  until fini;{for j}
   end; {for i}
   if avecAxeY then begin // fléche Y
        CreatePen(psSolid,penWidthAxe,CouleurAxeY);
        segment(xAxeY,CourbeBottom,xAxeY,CourbeTop);
        segment(xAxeY-marge,courbeTop+3*signeMargeY*marge,xAxeY,courbeTop);
        segment(xAxeY+marge,courbeTop+3*signeMargeY*marge,xAxeY,courbeTop);
   end;
end end; // TraceAxeInvY

procedure traceAxeLogx;
var i,j : integer;
    xs,ys,xprec,xsucc : Integer;
    intermediaire,intermediaire25 : boolean;
    ecart : integer;
    Q : boolean;
    nombreStr : string;
    nbreLabel : integer;
    labelPermis : set of byte;
begin with Monde[mondeX] do begin
   try
   Q := OgQuadrillage in OptionGraphe;
   Intermediaire := (Maxi-Mini) < 6;
   Intermediaire25 := (Maxi-Mini) < 9;
   for i := floor(Mini) to ceil(Maxi) do begin
       windowXY(i,monde[mondeY].Mini,mondeY,xs,ys);
       ys := yAxeX;
       nombreStr := formatMonde(dix(i));
       Ecart := 5*largCarac;
       if XcorrectGrad(xs) then begin
           graduationX(xs,ys,Q,true);
           if XcorrectNombre(xs) then
              OutText(xs,ys+signeMargeY*marge,nombreStr,false);
       end;
       if xs=intMoinsInf then xs := -ecart;
       xprec := xs;
       windowXY(succ(i),monde[mondeY].Mini,mondeY,xsucc,ys);
       if xsucc=intPlusInf then xsucc := limiteFenetre.left;
       NbreLabel := round(2*(xsucc-xprec)/(3*Ecart));
       case nbreLabel of
            0 : labelPermis := [];
            1,2 : labelPermis := [3];
            3,4,5 : labelPermis := [2,5];
            else labelPermis := [2..9];
       end;
       xprec := xs+Ecart;
       xsucc := xsucc-Ecart;
       for j := 2 to 9 do begin
           windowXY(i+log10(j),monde[mondeY].Mini,mondeY,xs,ys);
           ys := yAxeX;
           if XcorrectGrad(xs) then
              if intermediaire or
                 (intermediaire25 and (j in [2,5])) then begin
                        graduationX(xs,ys,Q,false);
                        if (j in labelPermis) and (xs>xprec) and (xs<xsucc) then begin
                           OutText(xs,ys+signeMargeY*marge,formatMonde(j*dix(i)),false);
                           xprec := xs+ecart;
                        end;
              end // intermediaire
              else graduationX(xs,ys,false,false);
          end;{for j}
   end; {for i}
   except
       verifierLog := true;
   end;
end end;// TraceAxeLogx

procedure traceAxeInvX;
var i,j,debut,fin : integer;
    xs,ys,xpred,xsucc : Integer;
    intermediaire,negatif,q,fini : boolean;
    ecart : integer;
    xx : single;
begin with Monde[mondeX] do begin
   Q := OgQuadrillage in OptionGraphe;
   Intermediaire := (Maxi/Mini) <= 100;
   Ecart := largCarac*NbreChiffres;
   Negatif := mini<0;
   if Negatif
      then begin
          debut := floor(log10(-Maxi));
          fin := ceil(log10(-Mini));
      end
      else begin
          debut := floor(log10(Mini));
          fin := ceil(log10(Maxi));
      end;
   for i := debut to fin do begin
        xx := dix(-i);
        if negatif then xx := -xx;
        windowRT(xx,monde[mondeY].Mini,mondeY,xs,ys);
        ys := yAxeX;
        if XcorrectGrad(xs) then begin
             graduationX(xs,ys,Q,true);
             if XcorrectNombre(xs) then
                OutText(xs,ys+signeMargeY*marge,formatMonde(xx),graduationZeroY);
   end;
   if intermediaire then if negatif
            then windowRT(xx*10,monde[mondeY].Mini,mondeY,xsucc,ys)
            else windowRT(xx/10,monde[mondeY].Mini,mondeY,xsucc,ys);
        xsucc := xsucc-ecart;
        if xsucc<0 then xsucc := xNombreMax;
        xpred := xs+ecart;
        if negatif then j := 2 else j := 9;
        repeat
             if negatif
                then xx := -j*dix(-i)
                else xx := j*dix(-i)/10;
	     windowRT(xx,monde[mondeY].Mini,mondeY,xs,ys);
       ys := yAxeX;
       if XcorrectGrad(xs) then
	         if intermediaire
                then begin
                graduationX(xs,ys,Q,true);
                        if XcorrectNombre(xs) and
		     	   ( xs>xpred ) and ( xs<xsucc ) and
		     	   ( xs<(xnombreMax-ecart) ) then begin
		     		OutText(xs,ys+signeMargeY*marge,formatMonde(xx),graduationZeroY);
		     		xpred := xs+ecart
		     	end;
		     end
		     else graduationX(xs,ys,false,false);
                if negatif
                   then begin
                      inc(j);
                      fini := j=10;
                   end
                   else begin
                      dec(j);
                      fini := j=1;
                   end;
          until fini;{for j}
   end; {for i}
end end;// TraceAxeInvX

procedure traceAxeLogY(m : TindiceMonde);
var i,j : integer;
    xs,ys,yprec,ysucc,ecart : Integer;
    intermediaire,intermediaire25,Q : boolean;
    NbreLabel : integer;
    labelPermis : set of byte;
begin with monde[m] do begin
   try
   Q := (OgQuadrillage in OptionGraphe) and (m=mondeY);
   Intermediaire := (Maxi-Mini) <= 4;
   Intermediaire25 := (Maxi-Mini) <= 6;
   Ecart := hautCarac*2;
   for i := floor(Mini) to ceil(Maxi) do begin
       windowXY(Mini,i,m,xs,ys);
       if YcorrectGrad(ys,m) then begin
      	    graduationY(ys,Q,true);
            if YcorrectNombre(ys,m) then
            	OutText(xAxeY,ys,formatMonde(dix(i)),false);
       end;
       if ys=intPlusInf then ys := limiteFenetre.bottom+Ecart;
       yprec := ys;
       windowXY(monde[mondeX].Mini,succ(i),m,xs,ysucc);
       if ysucc=intMoinsInf then ysucc := -Ecart;
       NbreLabel := round((ysucc-yprec)/Ecart);
       case nbreLabel of
            0 : labelPermis := [];
            1,2 : labelPermis := [3];
            3,4,5,6 : labelPermis := [2,5];
            else labelPermis := [2..9];
       end;
       yprec := yprec-Ecart;
       ysucc := ysucc+Ecart;
       for j := 2 to 9 do begin
    	    windowXY(monde[mondeX].Mini,i+log10(j),m,xs,ys);
	        if YcorrectGrad(ys,m) then
	          if intermediaire or (intermediaire25 and (j in [2,5]))
	            then begin
                   graduationY(ys,Q,false);
                   if (j in labelPermis) and
                      YcorrectNombre(ys,m) and (ys<yprec) and (ys>ysucc) then begin
                         OutText(xAxeY,ys,formatMonde(j*dix(i)),false);
                         yprec := ys-Ecart;
                      end;
		     end
		     else graduationY(ys,false,false);
	  end;{for j}
   end; {for i}
   segment(xAxeY,CourbeBottom,xAxeY,CourbeTop);
   segment(xAxeY-marge,courbeTop+3*signeMargeY*marge,xAxeY,courbeTop);
   segment(xAxeY+marge,courbeTop+3*signeMargeY*marge,xAxeY,courbeTop);
   except
   verifierLog := true;
   end;
end end;

  procedure zeroPolaire;
  var x0,y0 : Integer;
  begin with limiteFenetre do begin
      WindowXY(0,0,mondeY,x0,y0);
      CreatePen(psSolid,penWidthAxe,CouleurAxeX);
      segment(x0,bottom,x0,top); // axe y
      segment(left,y0,right,y0); // axe x
  end end; // zeroPolaire

  procedure zeroX;
  var x1,y1 : Integer;
  begin with monde[mondeX] do if graduation=gLin then begin
	  WindowXY(0,0,mondeY,x1,y1);
	  if (x1>limiteCourbe.left) and (x1<limiteCourbe.right) then begin
	      CreatePen(psSolid,penWidthAxe,CouleurAxeX);
              with limiteCourbe do begin
      	           segment(x1,bottom,x1,top);
                   // fléche Y
                   segment(x1-marge,top+3*marge,x1,top);
                   segment(x1+marge,top+3*marge,x1,top);
              end;
	  end;
  end end; // zeroX

 procedure zeroY(m : TindiceMonde;avecFleche : boolean);
 var x1,y1 : Integer;
     couleur : Tcolor;
 begin
     with monde[m] do if Graduation=gLin then begin
          windowXY(0,0,m,x1,y1);
          if yCorrectGrad(y1,m) then begin
             if m=mondeY
                then couleur := CouleurAxeX
                else couleur := CouleurAxeY;
             CreatePen(psSolid,penWidthAxe,Couleur);
             with limiteCourbe do begin
    	          segment(left,y1,right,y1);
                if avecFleche then begin // fléche X
                   segment(right-marge*3,y1+marge,right,y1);
                   segment(right-marge*3,y1-marge,right,y1);
                end;   
            end;
         end
     end
end;// zeroY

var i : integer;
    m : TindiceMonde;
    x0,y0,decalage : Integer;
begin // DrawAxis
//     setBkColor(clWhite);
     CouleurGrillePale := getCouleurPale(couleurGrille);
     penWidthAxe := limiteFenetre.width div 800;
     penWidthGrad := penWidthAxe div 2;
     if penWidthGrad<penWidthGrid then penWidthGrad := penWidthGrid;
     if courbes.count>0 then monde[mondeX].Axe := courbes[0].varX;
     mondeYseul := true;
     for i := 0 to pred(courbes.count) do with courbes[i] do begin
           if monde[iMondeC].Axe=nil then monde[iMondeC].Axe := varY;
           if iMondeC<>mondeY then begin
               mondeYseul := false;
               continue;
           end;
     end;
     mondeYseul := mondeYseul or (OgAnalyseurLogique in OptionGraphe);
     signeMargeX := -1;
     if axeYpositif then signeMargeY := -1 else signeMargeY := +1;
     couleurAxeY := CouleurAxeX;
     GraduationYTrace := false;
     canvas.font.Color := CouleurAxeY;
     WindowXY(0,0,mondeY,xAxeY,yAxeX);
     if not GraduationZeroX then xAxeY := limiteCourbe.left;
     if not GraduationZeroY then yAxeX := BasCourbe;
     for m := low(TindiceMonde) to high(TindiceMonde) do
         monde[m].TitreAxe.clear;
     monde[mondeX].xTitre := limiteFenetre.right-marge;
     monde[mondeX].yTitre := yAxeX+signeMargeY*(hautCarac+marge);
     if OgAnalyseurLogique in OptionGraphe
        then for m := mondeY to high(TindiceMonde) do begin
             monde[m].xTitre := limiteFenetre.left+marge;
             if superposePage
                then if axeYpositif
                    then monde[m].yTitre := limiteFenetre.Bottom
                    else monde[m].yTitre := limiteFenetre.Top
                else monde[m].yTitre := monde[m].CourbeTop-signeMargeY*hautCarac;
        end
        else begin
             for m := mondeY to MaxOrdonnee do
                 if axeYpositif
                    then monde[m].yTitre := limiteFenetre.Bottom
                    else monde[m].yTitre := limiteFenetre.Top;
             with monde[mondeY] do
                xTitre := xAxeY-NbreChiffres*largCarac;
             with monde[mondeDroit] do
                xTitre := limiteFenetre.right-marge;
             for m := mondeSans to MaxOrdonnee do
                 monde[m].xTitre := (limiteFenetre.left+limiteFenetre.right) div 2;
       end;
     if initialisation then exit;
     if (OgPolaire in OptionGraphe) then begin
        monde[mondeY].xTitre := limiteCourbe.right-marge;
        WindowXY(0,0,mondeY,x0,y0);
        monde[mondeY].yTitre := y0+signeMargeY*marge;
        if avecAxeX then tracePolaire else zeroPolaire;
        exit;
     end;
     initAxeX;
     if avecAxeX then begin
          case monde[mondeX].Graduation of
               gLog : traceAxeLogX;
               gInv : traceAxeInvX;
               else traceAxeX;
          end;
          if monde[mondeX].axe=nil then zeroX;
     end;
     if monde[mondeY].defini then begin
        i := 0;
        while (i<courbes.count) and
              (courbes[i].iMondeC<>mondeY) do inc(i);
        if i=courbes.count
           then monde[mondeY].defini := false
           else begin
             initAxeY(mondeY,i);
             if avecAxeY then begin
                case monde[mondeY].Graduation of
                   gLog : traceAxeLogY(mondeY);
                   gInv : traceAxeInvY(mondeY);
                   gBits : traceAxeBitsY(mondeY);
                   else traceAxeY(mondeY);
                end;
                zeroY(mondeY,false);
             end
             else zeroY(mondeY,true);
           end;
     end;
     if (OgPseudo3D in OptionGraphe) then begin
          WindowXY(0,0,MondeY,x0,y0);
          decalage := decalageFFT*(courbes.count-1);
          segment(x0,y0,x0+decalage,y0-decalage); // ligne de base
     end;
     if monde[mondeDroit].defini then begin
           if not(OgAnalyseurLogique in OptionGraphe) then begin
              xAxeY := limiteCourbe.right;
              signeMargeX := +1;
           end;
           i := 0;
           while (i<courbes.count) and
                 (courbes[i].iMondeC<>mondeDroit) do inc(i);
           if i=courbes.count
              then monde[mondeDroit].defini := false
              else begin
           initAxeY(mondeDroit,i);
           if avecAxeY
              then begin
                case monde[mondeDroit].Graduation of
                  gLog : traceAxeLogY(mondeDroit);
                  gInv : traceAxeInvY(mondeDroit);
                  gBits : traceAxeBitsY(mondeDroit);
                  else traceAxeY(mondeDroit);
                end;
                zeroY(mondeDroit,false);
              end
              else zeroY(mondeDroit,true);
              end;
     end;
     if OgAnalyseurLogique in OptionGraphe then
        for m := mondeSans to high(TindiceMonde) do with monde[m] do
            if monde[m].defini then begin
                   i := 0;
                   while (i<courbes.count) and
                         (courbes[i].iMondeC<>m) do inc(i);
                   if i=courbes.count
                      then monde[m].defini := false
                      else begin
                   initAxeY(m,i);
                   if avecAxeY
                      then begin
                        case monde[m].Graduation of
                          gLog : traceAxeLogY(m);
                          gInv : traceAxeInvY(m);
                          gBits : traceAxeBitsY(m);
                          else traceAxeY(m);
                        end;
                        segment(limiteCourbe.left,courbeBottom,limiteCourbe.right,courbeBottom);
                     end
                     else zeroY(m,true);
                   end;
           end;
     SetTextAlign(TA_left+TA_top);
end; // DrawAxis




