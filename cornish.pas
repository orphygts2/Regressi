unit Cornish;

interface

uses Windows, Classes, Graphics, Forms, Controls, Menus, ExtCtrls,
     Dialogs, sysUtils, Buttons, StdCtrls, Grids, Messages, spin, Printers,
     math, maths, constreg, regutil, graphker, compile, cornopt,
     Vcl.htmlHelpViewer,
     regdde, statcalc, aidekey, system.UITypes;

type
  TFcornish = class(TForm)
    PaintBox: TPaintBox;
    PanelValeurs: TPanel;
    StatGrid: TStringGrid;
    BoutonsPanel: TPanel;
    OptionsBtn: TSpeedButton;
    ImprimeBtn: TSpeedButton;
    CopierGrapheBtn: TSpeedButton;
    EditBidon: TEdit;
    AideModeleBtn: TSpeedButton;
    ClipGridBtn: TSpeedButton;
    DistGrid: TStringGrid;
    CornishRG: TRadioGroup;
    TexteBtn: TSpeedButton;
    GommeBtn: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure GrapheCopierClick(Sender: TObject);
    procedure PaintBoxPaint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CopierItemClick(Sender: TObject);
    procedure PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure OptionsItemClick(Sender: TObject);
    procedure CopierTableauItemClick(Sender: TObject);
    procedure PaintBoxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBoxDblClick(Sender: TObject);
    procedure ImprimeBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure EditBidonKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure AideModeleBtnClick(Sender: TObject);
    procedure CurseurCBKeyPress(Sender: TObject; var Key: Char);
    procedure PaintBoxClick(Sender: TObject);
    procedure EditBidonKeyPress(Sender: TObject; var Key: Char);
    procedure TexteBtnClick(Sender: TObject);
    procedure GommeBtnClick(Sender: TObject);
    procedure CornishRGClick(Sender: TObject);
  private
      Graphe : TgrapheReg;
      CornishK,CornishV,FrequenceGr,CornishCourant : Tgrandeur;
      statCourant : TcalculStatistique;
      xLegende : double;
      zoneSelect : Trect;
      reelClick : boolean;
      CurseurStat : TcurseurStat;
      indexPointCourant : integer;
      MajGraphe : boolean;
      Procedure SetCoordonnee;
      procedure SetCurseurStat(c : TcurseurStat);
      procedure SetPointCourant(i : integer);
  protected
      procedure WMRegMaj(var Msg : TWMRegMessage); message WM_Reg_Maj;
  public
   //   procedure ImprimerGraphe(var bas : integer);
  end;

var Fcornish : TFcornish;

implementation

uses regmain, options;

{$R *.DFM}

procedure TFcornish.FormCreate(Sender: TObject);
begin
   CornishK := Tgrandeur.create;
   CornishK.Init('KM','','',variable);
   FrequenceGr := Tgrandeur.create;
   Frequencegr.Init('N','','',variable);
   CornishV := Tgrandeur.create;
   CornishV.Init('Vlim','','',variable);
   CornishCourant := CornishK;
   StatCourant := pages[pageCourante].statK;
   Graphe := TgrapheReg.create;
   MajGraphe := true;
   reelClick := false;
   curseurStat := crsSelect;
   ImprimeBtn.visible := imBoutonImpr in menuPermis;
   StatGrid.DefaultRowHeight := hauteurColonne;
   DistGrid.DefaultRowHeight := hauteurColonne;
end;

procedure TFcornish.SetCoordonnee;

Procedure SetHistogramme;
{ Tracé de l'histogramme de la variable aléatoire A }

procedure SetCourbeTh;
Const Nth = 30;
      yth : array[0..Nth] of double =
        (0.0022,0.003,0.004,0.00525,0.00675,
         0.00875,0.0112,0.01415,0.01775,0.022,
         0.027,0.0328,0.0395,0.047,0.05545,
         0.06475,0.07485,0.0857,0.0971,0.10895,
         0.121,0.13305,0.14485,0.15615,0.1666,
         0.17605,0.18415,0.1907,0.1955,0.1985,
         0.19945);
var x,y : Tvecteur;
    i : integer;
    h,echelle : double;
    Acourbe : Tcourbe;
begin with statCourant do begin
  { comparaison avec la loi normale }
     setLength(x,2*Nth+1);
     setlength(y,2*Nth+1);
     h := sigma/10;
     for i:=0 to 2*Nth do x[i] := moyenne+(i-Nth)*h;
     xLegende := x[1];
     echelle := Nbre*2*EcartDist/Sigma;
     for i:=0 to Nth do begin
        y[i] := yth[i]*echelle;
        y[2*Nth-i] := y[i];
     end;
     Acourbe := Graphe.AjouteCourbe(x,y,mondeY,succ(2*Nth),
         CornishCourant,FrequenceGr,pageCourante);
     Acourbe.setStyle(couleurPages[3],psSolid,mCroix,'');
     Acourbe.Adetruire := true;
     Acourbe.trace := [trLigne];
end end;

procedure SetPoints;
var x,y : Tvecteur;
    i : integer;
    Acourbe : Tcourbe;
begin
     setLength(x,statCourant.Nbre);
     setlength(y,statCourant.Nbre);
     for i:=0 to pred(statCourant.Nbre) do y[i] := 0;
     copyVecteur(x,statCourant.donnees);
     Acourbe := Graphe.AjouteCourbe(x,y,mondeY,statCourant.Nbre,
              CornishCourant,FrequenceGr,pageCourante);
     Acourbe.setStyle(couleurPages[2],psSolid,mCroix,'');
     Acourbe.Adetruire := true;
     Acourbe.trace := [trPoint];
end;

procedure setCourbe;
var Acourbe : Tcourbe;
    idebut,ifin : integer;
begin with statCourant do begin
    idebut := 1;
    while NbreDist[iDebut]=0 do inc(iDebut);
    iFin := MaxHisto;
    while NbreDist[iFin]=0 do dec(iFin);
{ histogramme de la distribution experimentale }
    Acourbe := Graphe.AjouteCourbe(BornesDist,NbreDist,mondeY,iFin,
        CornishCourant,FrequenceGr,pageCourante);
    Acourbe.setStyle(couleurPages[1],psSolid,mCroix,'');
    Acourbe.DebutC := pred(iDebut);
    Acourbe.FinC := iFin;
    Acourbe.trace := [trStat];
{ distribution }
    Acourbe := Graphe.AjouteCourbe(MoyDist,NbreDist,mondeY,iFin,
        CornishCourant,frequenceGr,pageCourante);
    Acourbe.setStyle(couleurPages[2],psSolid,mCroix,'');
    Acourbe.DebutC := iDebut;
    Acourbe.FinC := iFin;
    Acourbe.trace := [trLigne];
end end;

var Ylegende,HauteurLigne : double;

Procedure AjouteLigneVert(const x : double;IndexCouleur : integer);
var Dessin : Tdessin;
begin
   Dessin := Tdessin.create(graphe);
   with Dessin do begin
        y1 := 0;
        y2 := statCourant.maxDist;
        x1 := x;
        x2 := x;
        pen.style := psDot;
        isTexte := false;
        pen.color := couleurPages[indexCouleur];
   end;
   Graphe.dessins.add(Dessin);
end;

Procedure AjouteLegende(const t : string;indexCouleur : integer);
var Dessin : Tdessin;
begin
      yLegende := yLegende - HauteurLigne;
      Dessin := Tdessin.create(graphe);
      with Dessin do begin
         isTexte := true;
         texte.add(t);
         x1 := xLegende;
         y1 := yLegende;
         x2 := xLegende;
         y2 := yLegende;
         pen.color := couleurPages[indexCouleur];
         centre := false;
      end;
      Graphe.dessins.add(Dessin);
end;

var couleur : integer;

Procedure AjouteDeuxLignes(const marge : double;const texte : string);
begin
      inc(couleur);
      AjouteLigneVert(statCourant.moyenne-marge,couleur);
      AjouteLigneVert(statCourant.moyenne+marge,couleur);
      AjouteLegende(texte,couleur);
end;

Procedure AjouteLigne(const valeur : double;const texte : string);
begin
      inc(couleur);
      AjouteLigneVert(valeur,couleur);
      AjouteLegende(texte,couleur);
end;

begin { SetHistogramme } with statCourant do begin
   setPoints;
   setCourbe;
   setCourbeTh;
   couleur := 4;
   HauteurLigne := maxDist*0.06;
 //  yTrace := MaxDist;
   yLegende := MaxDist;
   if CornishOptDlg.MoyenneCB.checked then
      AjouteLigne(moyenne,stMoyenne);
   if CornishOptDlg.MedianeCB.checked then
      AjouteLigne(mediane,stMediane);
   if not isNan(cible) then
      AjouteLigne(cible,stCible);
   if CornishOptDlg.t95CB.checked then
       AjouteDeuxLignes(t95,'µ(ICm 95%)');
   if CornishOptDlg.t99CB.checked then
       AjouteDeuxLignes(t99,'µ(ICm 99%)');
   if CornishOptDlg.int2SigmaCB.checked then
       AjouteDeuxLignes(2*sigma,'±2s');
   if CornishOptDlg.int3SigmaCB.checked then
       AjouteDeuxLignes(3*sigma,'±3s');
end end; { SetHistogramme }

Procedure SetKmVmax;
var Acourbe : Tcourbe;
begin
     with pages[pageCourante] do
        Acourbe := Graphe.AjouteCourbe(statK.donnees,statV.donnees,
            mondeY,statCourant.Nbre,CornishK,CornishV,pageCourante);
     Acourbe.setStyle(couleurPages[2],psSolid,mCroix,'');
     Acourbe.trace := [trPoint];
     graphe.monde[mondeX].zeroInclus := true;
end; { SetKmVmax }

Procedure AfficheDist;
var i,idebut,ifin : integer;
    ligne : integer;
begin with DistGrid,statCourant do begin
     idebut := 1;
     while (NbreDist[idebut]=0) do inc(idebut);
     ifin := MaxHisto;
     while (NbreDist[ifin]=0) do dec(ifin);
     RowCount := 2+iFin-iDebut;
     cells[0,0] := stMini;
     cells[1,0] := stMaxi;
     cells[2,0] := stTaille;
     ColWidths[0] := largeurUnCarac*6;
     ColWidths[1] := largeurUnCarac*6;
     ColWidths[2] := largeurUnCarac*4;
     for i := iDebut to iFin do begin
        ligne := succ(i-iDebut);
        cells[0,ligne] := formatReg(BornesDist[pred(i)]);
        cells[1,ligne] := formatReg(BornesDist[i]);
        cells[2,ligne] := formatReg(NbreDist[i]);
     end;
end end;

Procedure AfficheStat;
begin with StatGrid,pages[pageCourante] do begin
    if CornishOptDlg.CibleCB.checked
       then rowCount := 12
       else rowCount := 8;
    defaultRowHeight := hauteurColonne;
    height := succ(rowCount)*defaultRowHeight;
    colWidths[0] := largeurUnCarac*9;
    colWidths[1] := largeurUnCarac*6;
    colWidths[2] := largeurUnCarac*6;
    cells[0,0] := '';
       cells[1,0] := 'KM';
       cells[2,0] := 'Vlim';
    cells[0,1] := stTaille;
       cells[1,1] :=  formatReg(statK.Nbre);
       cells[2,1] :=  formatReg(statV.Nbre);
    cells[0,2] := stMediane;
       cells[1,2] :=  formatReg(statK.mediane);
       cells[2,2] :=  formatReg(statV.mediane);
    cells[0,3] := stMoyenne;
       cells[1,3] :=  formatReg(statK.moyenne);
       cells[2,3] :=  formatReg(statV.moyenne);
    cells[0,4] := 'ICm 95% mini';
       cells[1,4] := formatReg(statK.moyenne-statK.t95);
       cells[2,4] := formatReg(statV.moyenne-statV.t95);
    cells[0,5] := 'ICm 95% maxi';
       cells[1,5] := formatReg(statK.moyenne+statK.t95);
       cells[2,5] := formatReg(statV.moyenne+statV.t95);
    cells[0,6] := stEcartType;
       cells[1,6] := formatReg(statK.sigma);
       cells[2,6] := formatReg(statV.sigma);
    cells[0,7] := 'CV';
       cells[1,7] := chainePrec(statK.sigma/statK.Moyenne);
       cells[2,7] := chainePrec(statV.sigma/statV.Moyenne);
    if CornishOptDlg.CibleCB.checked then begin
       cells[0,8] := stCible;
       cells[0,9] := stInexactitude;
       cells[0,10]  := '   '+StAbsolue;
       cells[0,11] := '   '+StRelative;
       with statK do begin
         cells[1,8] := formatReg(Cible);
         cells[1,9] := '';
         cells[1,10] := formatReg(Moyenne-Cible);
         cells[1,11] := ChainePrec(Abs((Moyenne-Cible)/Cible));
       end;
       with statV do begin
         cells[2,8] := formatReg(Cible);
         cells[2,9] := '';
         cells[2,10] := formatReg(Moyenne-Cible);
         cells[2,11] := ChainePrec(Abs((Moyenne-Cible)/Cible));
       end;
    end;
end end;

Procedure InitStat;
var N : integer;
    indexS,indexV : integer;
    indexK,indexVmax : integer;
begin
   Graphe.raz;
   indexK := indexNom('KM');
   if indexK=grandeurInconnue then
      indexK := AjouteExperimentale('KM',constante);
   indexVmax := indexNom('Vlim');
   if indexVmax=grandeurInconnue then
      indexVmax := AjouteExperimentale('Vlim',constante);
with CornishOptDlg do begin
   case CornishRG.itemIndex of
        0 : begin
          CornishCourant := CornishK;
          statCourant := pages[pageCourante].statK;
          self.Caption := '(KM)';
        end;
        1 : begin
          CornishCourant := CornishV;
          statCourant := pages[pageCourante].statV;
          self.Caption := '(Vlim)';
        end;
        2 : self.Caption := '';
   end;
   indexS := indexNom(ConcentrationListe.items[ConcentrationListe.itemIndex]);
   grandeurs[indexK].recopieUnite(grandeurs[indexS]);
   CornishK.recopieUnite(grandeurs[indexS]);
   indexV := indexNom(VitesseListe.items[VitesseListe.itemIndex]);
   grandeurs[indexVmax].recopieUnite(grandeurs[indexV]);
   CornishV.recopieUnite(grandeurs[indexV]);
   self.caption := 'Cornish-Bowden '+
                   self.caption +
                   ' : '+grandeurs[indexV].nom+' = f('+grandeurs[indexS].nom+')';
end;
   with pages[pageCourante] do begin
       if majCornishAfaire
          then calcCornish(ValeurVar[indexS],ValeurVar[indexV],Nmes,statK.donnees,statV.donnees,N)
          else N := statCourant.Nbre;
       MajCornishAfaire := false;
       with statK do begin
            Nbre := N;
            statOK := false;
            avecTri := false;
            Calcul;
       end;
       valeurConst[indexK] := statK.mediane;
       incertConst[indexK] := statK.t95;
       with statV do begin
            Nbre := N;
            statOK := false;
            avecTri := false;
            Calcul;
       end;
       valeurConst[indexVmax] := statV.mediane;
       incertConst[indexVmax] := statV.t95;
   end;
end;

begin
     initStat;
     afficheStat;
     distGrid.Visible := cornishRG.itemIndex<2;
     afficheDist;
     if CornishRG.itemIndex=2
        then setKmVmax
        else begin
           SetHistogramme;
           graphe.monde[mondeX].zeroInclus := false;
        end;
     MajGraphe := false;
     pages[pageCourante].MajCornishAfaire := false;
end; // setCoordonnee

procedure TFcornish.FormResize(Sender: TObject);
begin
     Refresh
end;

procedure TFcornish.GrapheCopierClick(Sender: TObject);
begin
     Graphe.VersPressePapier(grapheClip)
end;

procedure TFcornish.WMRegMaj(var Msg : TWMRegMessage);
begin
      case msg.TypeMaj of
          MajValeur,MajValeurConst : pages[pageCourante].MajCornishAfaire := true;
          MajChangePage,MajSupprPage,MajGroupePage,MajAjoutPage : begin
              MajGraphe := true;
              Refresh;
          end;
      end
end;

procedure TFcornish.PaintBoxPaint(Sender: TObject);
begin with PaintBox.Canvas do begin
        Graphe.grapheOK := NbreGrandeurs>1;
        if not Graphe.grapheOK then exit;
        Graphe.canvas := paintBox.canvas;
        if MajGraphe then setCoordonnee;
        graphe.limiteFenetre := paintBox.clientRect;
        Pen.mode := pmCopy;
        Brush.style := bsClear;
        graphe.draw;
        Pen.Color := PColorReticule;
        Pen.style := PstyleReticule;
        Pen.mode := pmNotXor;
        Brush.color := BrushCouleurZoom;
        Brush.style := bsSolid;
        setCurseurStat(crsSelect);
        indexPointCourant := -1;
end end;

procedure TFcornish.FormDestroy(Sender: TObject);
begin
     Graphe.Free;
     CornishK.free;
     CornishV.free;
     FrequenceGr.free;
     cornishOptDlg.free;
     Fcornish := nil;
     inherited;
end;

procedure TFcornish.CopierItemClick(Sender: TObject);
begin
     Graphe.VersPressePapier(grapheClip)
end;

procedure TFcornish.PaintBoxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin with graphe do begin
      paintBox.hint := '';
      case curseurStat of
         crsTexte : with dessinCourant do  begin
           AffectePosition(x,y,sdPoint1,shift);
           x2i := x1i;
           y2i := y1i;
         end;
         crsSelect : begin
            SetDessinCourant(x,y);
            if dessinCourant<>nil then with dessinCourant do
                  if posDessinCourant=sdCadre
                     then begin
                        zoneSelect := cadre;
                        RectangleGr(zoneSelect);
                     end
                     else begin
                        zoneSelect := rect(x1i,y1i,x2i,y2i);
                        LineGr(zoneSelect);
                     end
               else begin
                    setPointCourant(PointProche(x,y,0,true,false));
                    if indexPointCourant>=0 then
                       if pages[pageCourante].PointActif[indexPointCourant]
                          then paintBox.hint := hSupprPointActif
                          else paintBox.hint := hSupprPointNonActif
              end;
       end;
       crsEfface : begin
            SetDessinCourant(x,y);
            if dessinCourant<>nil
               then with dessins do begin
                  remove(DessinCourant);
                  TPaintBox(sender).refresh;
               end
               else begin
                  zoneSelect := rect(x,y,x,y);
                  RectangleGr(zoneSelect);
               end;
       end;
  end; { case }
end end;

procedure TFcornish.PaintBoxMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var deplacement : boolean;
begin with graphe do begin
   deplacement := ssLeft in Shift;
   case curseurStat of
        crsSelect : if deplacement then if dessinCourant<>nil
                 then with dessinCourant do
                 if posDessinCourant=sdCadre
                    then begin
                       RectangleGr(zoneSelect); { efface }
                       AffecteCentreRect(x,y,zoneSelect);
                       rectangleGr(zoneSelect);
                    end
                    else begin
                       LineGr(zoneSelect); { efface }
                       affectePosition(x,y,posDessinCourant,shift);
                       zoneSelect := rect(x1i,y1i,x2i,y2i);
                       LineGr(zoneSelect);
                    end
             else begin
                SetDessinCourant(x,y);
                if posDessinCourant<>sdNone
                  then paintBox.cursor := crSize
                  else paintBox.cursor := crDefault;
             end;
        crsTexte : if deplacement then
            with paintBox.canvas,dessinCourant do begin
                MoveTo(x1i,y1i);
          	LineTo(x2i,y2i); { efface l'ancienne }
  	        AffectePosition(x,y,sdPoint2,shift);
                MoveTo(x1i,y1i);
                LineTo(x2i,y2i);
        end;
        crsEfface : if deplacement then begin
             RectangleGr(zoneSelect); { efface }
             zoneSelect.bottom := y;
             zoneSelect.right := x;
             RectangleGr(zoneSelect);
        end;
   end;
end end;

procedure TFcornish.OptionsItemClick(Sender: TObject);
var p : TcodePage;
begin with CornishOptDlg,pages[pageCourante] do begin
     EditCibleK.text := FormatReg(statK.cible);
     EditCibleV.text := FormatReg(statV.cible);
     ClasseGroupe.itemIndex := ord(statK.classeStat);
     NombreSpin.Value := statK.NbreClasse;
     if CornishOptDlg.ShowModal=mrOK then begin
         statK.classeStat := TclasseStat(ClasseGroupe.itemIndex);
         statV.classeStat := statK.classeStat;
         if statK.classeStat=csNombreImpose then begin
            statK.NbreClasse := NombreSpin.Value;
            statV.NbreClasse := NombreSpin.Value;
         end;
         if CibleCB.checked then begin
              try
              statK.cible := StrToFloatWin(EditCibleK.text);
              except
              statK.cible := Nan;
              end;
              try
              statV.cible := StrToFloatWin(EditCibleV.text);
              except
              statV.cible := Nan;
              end;
         end;
         MajGraphe := true;
         if ModifCoord then for p := 1 to NbrePages do
            pages[p].MajCornishAfaire := true;
         paintBox.refresh;
     end;
end end;

procedure TFcornish.CopierTableauItemClick(Sender: TObject);
begin
     FormDDE.RazRTF;
     FormDDE.AjouteGrid(StatGrid);
     FormDDE.EnvoieRTF;
end;

procedure TFcornish.SetCurseurStat(c : TcurseurStat);
begin with PaintBox,Canvas do begin
   Pen.style := psSolid;
   Pen.mode := pmNotXor;
   Brush.style := bsClear;
   Brush.Color := clWindow;
   curseurStat := c;
   case curseurStat of
       crsTexte : cursor := crLettre;
       crsEfface : cursor := crGomme;
       crsSelect : cursor := crDefault;
   end;{case}
   EditBidon.setFocus;
end end;

procedure TFcornish.PaintBoxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

Procedure SupprRectangle;
var i,j : integer;
    Xi,Yi : Integer;
begin with pages[pageCourante] do begin
    i := 0;
    while i<statK.Nbre do begin
        if CornishRG.itemIndex=2
           then graphe.windowXY(statK.donnees[i],statV.donnees[i],mondeY,Xi,Yi)
           else graphe.windowXY(statCourant.donnees[i],0,mondeY,Xi,Yi);
        if ((Xi-zoneSelect.left)*(Xi-ZoneSelect.right)<0) and
           ((Yi-zoneSelect.top)*(Yi-ZoneSelect.bottom)<0)
              then begin
                   StatK.Nbre := StatK.Nbre-1;
                   StatV.Nbre := StatV.Nbre-1;
                   for j := i to pred(statK.Nbre) do begin
                       StatK.donnees[j] := StatK.donnees[succ(j)];
                       StatV.donnees[j] := StatV.donnees[succ(j)];
                   end;
              end
              else inc(i)
    end;
    MajGraphe := true;
    setCurseurStat(crsSelect);
    PaintBox.refresh;
end end;

procedure AffecteDessin;
begin with graphe.dessinCourant do begin
   with paintBox.canvas do begin
        MoveTo(x1i,y1i);
        LineTo(x2i,y2i); { efface }
   end;
   if isTexte then if not litOption(graphe) then begin
      graphe.dessinCourant.free;
      setCurseurStat(crsSelect);
      exit;
   end;
   AffectePosition(x,y,sdPoint2,shift);
   graphe.dessins.Add(graphe.DessinCourant);
   draw;
   setCurseurStat(crsSelect);
end end;

begin with graphe do begin
  case curseurStat of
       crsTexte : AffecteDessin;
       crsSelect : if reelClick
          then begin
             SetDessinCourant(x,y);
             if (dessinCourant<>nil) then begin
                dessinCourant.litOption(graphe);
                PaintBox.refresh;
                DessinCourant := nil;
              end;
          end
          else if dessinCourant<>nil
            then with dessinCourant do begin
                if posDessinCourant=sdCadre
                   then RectangleGr(zoneSelect)
                   else LineGr(zoneSelect);{ efface }
                AffectePosition(x,y,posDessinCourant,shift);
                dessinCourant := nil;
                PaintBox.refresh;
            end;
       crsEfface : if OKreg(OkDeldata,0) then supprRectangle
  end; { case }
  reelClick := false;
end end;

procedure TFcornish.PaintBoxDblClick(Sender: TObject);
begin
     reelClick := true
end;

procedure TFcornish.ImprimeBtnClick(Sender: TObject);
var bas : integer;
begin
       if OKReg(OkImprGr,0) then begin
          debutImpressionGr(poPortrait,bas);
          Graphe.versImprimante(HautGrapheGr,bas);
          if OKReg(OkImprTab,0) then begin
             DebutImpressionTexte(bas);
             ImprimerLigne(caption,bas);
             ImprimerGrid(StatGrid,bas);
          end;
          finImpressionGr;
       end;
end;

procedure TFcornish.FormActivate(Sender: TObject);
begin
     inherited;
     MajGraphe := true
end;

procedure TFcornish.EditBidonKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var P : Tpoint;
    i : integer;
begin
     GetCursorPos(P);
     P := PaintBox.ScreenToClient(P);
     if (key=vk_cancel) and (curseurStat<>crsSelect) then begin
        setCurseurStat(crsSelect);
        paintBox.refresh;
        exit;
     end;
     case key of
          vk_left : dec(P.X);
          vk_right : inc(P.X);
          vk_down : inc(P.Y);
          vk_up : dec(P.Y);
          vk_prior : dec(P.X,10);
          vk_next : inc(P.X,10);
          vk_delete,110,8 : with graphe do begin
             SetDessinCourant(P.x,P.y);
             if (curseurStat=crsSelect) and (posDessinCourant<>sdNone)
                then with dessins do begin
                    remove(DessinCourant);
                    PaintBox.refresh;
                end
                else if indexPointCourant>=0 then with pages[pageCourante] do begin
                     StatV.Nbre := StatV.Nbre-1;
                     StatK.Nbre := StatK.Nbre-1;
                     for i := indexPointCourant to pred(statCourant.Nbre) do begin
                         statK.donnees[i] :=  statK.donnees[succ(i)];
                         statV.donnees[i] :=  statV.donnees[succ(i)];
                     end;
                     MajGraphe := true;
                     PaintBox.refresh;
                end;
             exit;
          end
          else exit;
     end;
     P := PaintBox.ClientToScreen(P);
     setCursorPos(P.X,P.Y);
end;

procedure TFcornish.AideModeleBtnClick(Sender: TObject);
begin
     Aide(HELP_MethodedeCornishBowden)
end;

procedure TFcornish.CurseurCBKeyPress(Sender: TObject; var Key: Char);
begin
     if key=#27 then EditBidon.SetFocus { sinon CurseurCB garde Focus }
end;

procedure TFcornish.PaintBoxClick(Sender: TObject);
begin
     EditBidon.setFocus
end;

(*
procedure TFcornish.ImprimerGraphe(var bas : integer);
begin
     Graphe.versImprimante(HautGrapheTxt,bas)
end;
*)

procedure TFcornish.SetPointCourant(i : integer);

Procedure AffichePointCourant;
var xi,yi,dimP : Integer;
begin
if indexPointCourant<0 then exit;
with PaintBox.canvas do begin
        Pen.color := color;
        Pen.mode := pmNotXor;
        Pen.style := psSolid;
        Brush.color := pen.color;
        graphe.WindowRT(graphe.courbes.items[0].valX[indexPointCourant],
                        graphe.courbes.items[0].valY[indexPointCourant],
                        graphe.courbes.items[0].iMondeC,Xi,Yi);
        DimP := graphe.dimPoint+2;
        Ellipse(xi-dimP,yi-dimP,xi+dimP,yi+dimP);
end end;

begin
     AffichePointCourant; { efface }
     indexPointCourant := i;
     AffichePointCourant;
end;

procedure TFcornish.EditBidonKeyPress(Sender: TObject; var Key: Char);
begin
     EditBidon.text := ''
end;

procedure TFcornish.TexteBtnClick(Sender: TObject);
begin
    setCurseurStat(crsTexte);
    graphe.DessinCourant := Tdessin.create(graphe);
    graphe.DessinCourant.isTexte := curseurStat=crsTexte
end;

procedure TFcornish.GommeBtnClick(Sender: TObject);
begin
  setCurseurStat(crsEfface)
end;

procedure TFcornish.CornishRGClick(Sender: TObject);
begin
      MajGraphe := true;
      paintBox.refresh;
end;

end.


