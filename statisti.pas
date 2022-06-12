unit statisti;

interface

uses Windows, Classes, Graphics, Forms, Controls, Menus, ExtCtrls,
     Dialogs, sysUtils, Buttons, StdCtrls, Grids, Messages, spin,
     math, constreg, ComCtrls, ToolWin, ImgList, System.ImageList,
     vcl.HtmlHelpViewer,
     statOpt, statcalc, compile, regutil, maths,
     graphker, regdde, regmain, Vcl.Mask, Vcl.VirtualImageList,
  Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TFstatistique = class(TForm)
    PaintBoxStat: TPaintBox;
    PanelValeurs: TGroupBox;
    StatGrid: TStringGrid;
    DistGrid: TStringGrid;
    SaveDialog: TSaveDialog;
    ToolBar: TToolBar;
    SelectBtn: TToolButton;
    TexteBtn: TToolButton;
    GommeBtn: TToolButton;
    OptionsBtn: TToolButton;
    ImprimeBtn: TToolButton;
    CopierBtn: TToolButton;
    MemoVocabulaire: TMemo;
    ListeNom: TComboBox;
    GridBtn: TToolButton;
    ToolButton3: TToolButton;
    EchellePanel: TPanel;
    XLabel: TLabel;
    YLabel: TLabel;
    miniXedit: TLabeledEdit;
    maxiXEdit: TLabeledEdit;
    miniYEdit: TLabeledEdit;
    MaxiYEdit: TLabeledEdit;
    EchelleBtn: TToolButton;
    SaveGrapheBtn: TToolButton;
    CopyBtn: TToolButton;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    procedure FormCreate(Sender: TObject);
    procedure GrapheCopierClick(Sender: TObject);
    procedure PaintBoxStatPaint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PaintBoxStatMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBoxStatMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure OptionsItemClick(Sender: TObject);
    procedure CopierTableauItemClick(Sender: TObject);
    procedure PaintBoxStatMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBoxStatDblClick(Sender: TObject);
    procedure ImprimeBtnClick(Sender: TObject);
    procedure TableauBtnClick(Sender: TObject);
    procedure EditBidonKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure GommeBtnClick(Sender: TObject);
    procedure TexteBtnClick(Sender: TObject);
    procedure SelectBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure ListeNomChange(Sender: TObject);
    procedure GridBtnClick(Sender: TObject);
    procedure miniXeditExit(Sender: TObject);
    procedure miniXeditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure miniXeditKeyPress(Sender: TObject; var Key: Char);
    procedure EchelleBtnClick(Sender: TObject);
    procedure EnregistrerGrapheItemClick(Sender: TObject);
    procedure CopierItemClick(Sender: TObject);
  private
      Graphe : TgrapheReg;
      FrequenceGr : Tgrandeur;
      FrequenceGrDefault : Tgrandeur;
      indexStat,indexEffectif : integer;
      zoneSelect : Trect;
      reelClick : boolean;
      CurseurStat : TcurseurStat;
      IndexPointCourant : integer;
      PoissonPermis : boolean;
      StatGlb,statCourante : TcalculStatistique;
      majFichierEnCours : boolean;
      Procedure InitStat;
      Procedure VerifStat(p : TcodePage);
      Procedure SetCoordonnee;
      Procedure MajNomStat;
      procedure SetCurseurStat(c : TcurseurStat);
      procedure setPointCourant(i : integer);
  protected
      procedure WMRegMaj(var Msg : TWMRegMessage); message WM_Reg_Maj;
  public
      procedure EcritConfig;
      procedure LitConfig;
      procedure ImprimerGraphe(var bas : integer);
      procedure VersLatex(const NomFichier : string);
  end;

var Fstatistique : TFstatistique;

implementation

uses Options, printers;

{$R *.DFM}

 procedure TFstatistique.VersLatex(const NomFichier : string);
  begin
      graphe.VersLatex(nomFichier,'S');
  end;

procedure TFstatistique.FormCreate(Sender: TObject);
begin
   StatGlb := TcalculStatistique.create;
   setLength(statGlb.Donnees,MaxPages+1);
   StatGlb.avecTri := true;
   Graphe := TgrapheReg.create;
   exclude(graphe.OptionGraphe,OgQuadrillage);
   Graphe.monde[mondeX].zeroInclus := false;
   Graphe.modif := [gmXY];
   FrequenceGrDefault := Tgrandeur.create;
   FrequenceGrDefault.Init('N','','',variable);
   StatOptDlg := TStatOptDlg.create(self);
   StatOptDlg.NomStat := '';
   StatOptDlg.NomEffectif := '';
   reelClick := false;
   curseurStat := crsSelect;
   selectBtn.down := true;
   IndexPointCourant := -1;
   indexStat := 1;
   ImprimeBtn.visible := imBoutonImpr in menuPermis;
//   DistGrid.DefaultRowHeight := HauteurColonne;
 //  StatGrid.DefaultRowHeight := HauteurColonne;
   ResizeButtonImagesforHighDPI(self);
end;

procedure TFstatistique.SetCoordonnee;
const hauteurLegende = 3; { % }
var Ylegende : double;
    deltaYlegende,deltaXlegende : double;
    Npages,indexPage : integer;
    couleurC : TColor;

Procedure AjouteLegende(xLegende : double;const t : string;Couleur : Tcolor);
var Dessin : Tdessin;
begin
      if (xlegende<graphe.monde[mondeX].mini) or (xlegende>graphe.monde[mondeX].maxi) then exit;
      Dessin := Tdessin.create(graphe);
      with Dessin do begin
         isTexte := true;
         texte.add(' '+t+' ');
         x1 := xLegende;
         y1 := yLegende;
         x2 := xLegende;
         y2 := yLegende;
         pen.color := couleur;
         IsOpaque := true;
         CouleurFond := colorToRGB(clWindow);
         hauteur := hauteurLegende;
      end;
      Graphe.dessins.add(Dessin);
end;

Procedure SetHistogramme(p : TCodePage);
// Tracé de l'histogramme de la variable aléatoire

procedure SetCourbeGauss;
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
    Lcourbe : Tcourbe;
begin with pages[p].stat do begin
// comparaison avec la loi normale
     setLength(x,2*Nth+1);
     setLength(y,2*Nth+1);
     h := sigma/10;
     for i := 0 to 2*Nth do x[i] := moyenne+(i-Nth)*h;
     echelle := Ntotal*2*EcartDist/Sigma;
     for i := 0 to Nth do begin
        y[i] := yth[i]*echelle;
        y[2*Nth-i] := y[i];
     end;
     Lcourbe := Graphe.AjouteCourbe(x,y,mondeY,succ(2*Nth),
         grandeurs[indexStat],frequenceGr,p);
     if (min>0) and (x[0]<0) then begin
        Lcourbe.DebutC := ceil(Nth-moyenne/h);
     end;
     Lcourbe.setStyle(GetCouleurPale(couleurC),psSolid,mCroix,'');
     Lcourbe.Adetruire := true;
     Lcourbe.trace := [trLigne];
end end; // setCourbeGauss

procedure SetCourbePoisson;
var x,y : Tvecteur;
    i,Nth : integer;
    echelle,maxPoisson : double;
    Lcourbe : Tcourbe;
begin with pages[p].stat do begin
  { comparaison avec la loi de Poisson }
     Nth := round(moyenne)*2;
     if Nth<max then Nth := round(max);
     setlength(x,2*Nth);setlength(y,2*Nth);
     for i := 0 to pred(Nth) do x[i] := i;
     echelle := Ntotal*EcartDist;
     maxPoisson := 0;
     for i := 0 to Nth do begin
         y[i] := poisson(i,moyenne)*echelle;
         if y[i]>maxPoisson then maxPoisson := y[i];
     end;
     Lcourbe := Graphe.AjouteCourbe(x,y,mondeY,Nth,grandeurs[indexStat],nil,p);
     Lcourbe.Adetruire := true;
     Lcourbe.trace := [trPoint];
//     Acourbe.motif := mBarreG;
     Lcourbe.motif := mHisto;
     Lcourbe.courbeExp := false;
     Lcourbe.indexModele := 1;
     Lcourbe.couleur := getCouleurPale(couleurC);
     Graphe.monde[mondeX].mini := 0;
     if Graphe.monde[mondeX].maxi<Nth then
        Graphe.monde[mondeX].maxi := Nth;
     if Graphe.monde[mondeY].maxi<MaxPoisson then
        Graphe.monde[mondeY].maxi := MaxPoisson*1.05;
     AjouteLegende(Graphe.monde[mondeX].maxi/10,'Poisson',Lcourbe.couleur);
end end;

procedure SetCourbeBinomiale;
var x,y : Tvecteur;
    i,Nth : integer;
    echelle : double;
    Lcourbe : Tcourbe;
begin with pages[p].stat do begin
// comparaison avec la loi binomiale
     Nth := round(moyenne)*2;
     if Nth<max then Nth := round(max);
     setlength(x,2*Nth);setlength(y,2*Nth);
     for i := 0 to pred(Nth) do x[i] := i;
     echelle := Ntotal*EcartDist;
     for i := 0 to Nth do
         y[i] := Binomial(moyenne,Ntotal,i)*echelle;
     Lcourbe := Graphe.AjouteCourbe(x,y,mondeY,Nth,grandeurs[indexStat],nil,p);
     Lcourbe.Adetruire := true;
     Lcourbe.trace := [trPoint];
     Lcourbe.motif := mBarreD;
     Lcourbe.couleur := getCouleurPale(couleurC);
     Graphe.monde[mondeX].mini := 0;
     if Graphe.monde[mondeX].maxi<Nth then Graphe.monde[mondeX].maxi := Nth;
     AjouteLegende(Graphe.monde[mondeX].maxi/10,'Binomiale',Lcourbe.couleur); { TODO : traduction 1 }
end end;

procedure SetPoints;
var x,y : Tvecteur;
    i : integer;
    Lcourbe : Tcourbe;
begin with pages[p].stat do begin
     setlength(x,Nbre);
     setLength(y,Nbre);
     for i := 0 to pred(Nbre) do begin
         x[i] := donnees[i];
         y[i] := 0;
     end;
     Lcourbe := Graphe.AjouteCourbe(x,y,mondeY,Nbre,
         grandeurs[indexStat],frequenceGr,p);
     Lcourbe.setStyle(couleurC,psSolid,mCroix,'');
     Lcourbe.Adetruire := true;
     Lcourbe.trace := [trPoint];
end end;

procedure setCourbe;
var Lcourbe : Tcourbe;
    idebut,ifin : integer;
begin with pages[p].stat do begin
    idebut := 1;
    while NbreDist[iDebut]=0 do inc(iDebut);
    iFin := MaxHisto;
    while NbreDist[iFin]=0 do dec(iFin);
// histogramme de la distribution experimentale
    Lcourbe := Graphe.AjouteCourbe(BornesDist,NbreDist,mondeY,iFin,
        grandeurs[indexStat],frequenceGr,p);
    case classeStat of
       csEffectifDonne : begin
         graphe.monde[mondeX].mini := Donnees[0]-sigma/3;
         graphe.monde[mondeX].maxi := Donnees[Nbre]+sigma/3;
       end
       else begin
         graphe.monde[mondeX].mini := BornesDist[iDebut-1]-sigma/3;
         graphe.monde[mondeX].maxi := BornesDist[iFin]+sigma/3;
       end;
    end;
    graphe.monde[mondeY].mini := 0;
    graphe.monde[mondeY].maxi := maxDist*1.05;
    Lcourbe.setStyle(couleurC,psSolid,mCroix,'');
    if classeStat in [csEffectifDonne,csFrequenceDonnee]
       then begin
          Lcourbe.DebutC := 0;
          Lcourbe.FinC := pred(Nbre);
          Lcourbe.trace := [trPoint];
          Lcourbe.motif := mHisto;
       end
       else begin
          Lcourbe.DebutC := pred(iDebut);
          Lcourbe.FinC := iFin;
          Lcourbe.trace := [trStat];
       end;
    if StatOptDlg.DistributionCB.checked then begin // distribution
       Lcourbe := Graphe.AjouteCourbe(MoyDist,NbreDist,mondeY,iFin,
           grandeurs[indexStat],frequenceGr,p);
       Lcourbe.setStyle(couleurC,psSolid,mCroix,'');
       Lcourbe.DebutC := iDebut;
       Lcourbe.FinC := iFin;
       Lcourbe.trace := [trLigne];
    end;
end end;  // setCourbe

Procedure AjouteLigneVert(x : double;Acouleur : Tcolor);
var LDessin : Tdessin;
begin
   if (x<graphe.monde[mondeX].mini) or (x>graphe.monde[mondeX].maxi) then exit;
   LDessin := Tdessin.create(graphe);
   with LDessin do begin
        y1 := 0;
        y2 := yLegende;
        x1 := x;
        x2 := x;
        pen.style := psSolid;
        isTexte := false;
        pen.color := Acouleur;
        deplacable := false;
   end;
   Graphe.dessins.add(LDessin);
end;

Procedure AjouteDeuxLignes(marge : double;const texte : string;
    Acouleur : Tcolor);
begin with pages[p].stat do begin
      AjouteLigneVert(moyenne-marge,Acouleur);
      AjouteLigneVert(moyenne+marge,Acouleur);
      AjouteLegende(moyenne-marge*1.2,'m-'+texte,Acouleur);
      AjouteLegende(moyenne+marge*1.2,'m+'+texte,Acouleur);
      yLegende := yLegende + deltayLegende;
end end;

Procedure AjouteLigne(valeur : double;const texte : string;Acouleur : Tcolor);
begin
      AjouteLigneVert(valeur,acouleur);
      AjouteLegende(valeur,texte,Acouleur);
      yLegende := yLegende + deltayLegende;
end;

begin // SetHistogramme
with pages[p].stat do begin
   if not(classeStat in [csEffectifDonne,csFrequenceDonnee]) then setPoints;
//   if statOptDlg.CourbePoissonCB.checked then setCourbePoisson; // ??
   setCourbe;
   deltayLegende := -graphe.monde[mondeY].maxi*(hauteurLegende+1)/100;
   yLegende := graphe.monde[mondeY].maxi-deltayLegende/2;
   deltaxLegende := (graphe.monde[mondeX].maxi-graphe.monde[mondeX].mini)/10;
   if StatOptDlg.MoyenneCB.checked then
      AjouteLigne(moyenne,stMoyenne+' '+
            grandeurs[indexStat].FormatValeurEtUnite(moyenne),
            clBlue);
   if StatOptDlg.MedianeCB.checked then
      AjouteLigne(mediane,stMediane+' '+
            grandeurs[indexStat].FormatValeurEtUnite(mediane),
            clRed);
   if not isNan(cible) then
      AjouteLigne(cible,stCible+' '+
            grandeurs[indexStat].FormatValeurEtUnite(cible),clGreen);
   if statOptDlg.CourbeGaussCB.checked then setCourbeGauss;
   if statOptDlg.CourbePoissonCB.checked then setCourbePoisson;
   if statOptDlg.CourbeBinomeCB.checked then setCourbeBinomiale;
   if StatOptDlg.t95CB.checked then
       AjouteDeuxLignes(t95,'µ95',clBlue);
   if StatOptDlg.t99CB.checked then
       AjouteDeuxLignes(t99,'µ99',clRed);
   if StatOptDlg.int2SigmaCB.checked then
       AjouteDeuxLignes(2*sigma,'2'+sigmaMin,clBlue);
   if StatOptDlg.int3SigmaCB.checked then
       AjouteDeuxLignes(3*sigma,'3'+sigmaMin,clRed);
   if StatOptDlg.int1SigmaCB.checked then
       AjouteDeuxLignes(sigma,sigmaMin,clGreen);
end end; // SetHistogramme

Procedure AfficheStat;
var Decimales : integer;
    expValeurIng : integer;
    coeffValeurIng : double;

Procedure ChercheDecimales;
var valeurLoc,precLoc : double;
    premierChiffre,expPrec,expValeur : integer;
begin
   valeurLoc := statCourante.moyenne;
   precLoc := statCourante.sigma;
   expValeurIng := 3*floor(log10(valeurLoc)/3);
   coeffValeurIng := power(10,expValeurIng);
   try
       expPrec := floor(log10(precLoc));
       expValeur := floor(log10(valeurLoc));
       Decimales := expValeur-expPrec+1;
       premierChiffre := floor(precLoc*dix(-expPrec));
       if premierChiffre<3 then inc(decimales); // deux chiffres pour 0,13 ou 0,24
       if Decimales>precisionMaxIncert then Decimales := PrecisionMaxIncert;
       decimales := decimales - expValeur + expValeurIng;
       if decimales<0 then decimales := 0;
   except
   end;
end; // ChercheDecimales

function formatValeur(valeur : double) : string;
var suffixe : string;
begin
 //  result := grandeurs[indexStat].formatValeurEtUnite(valeur);
   result := FloatToStrF(valeur/coeffValeurIng,ffFixed,Decimales+3,Decimales);
   if grandeurs[indexStat].correct
      then begin
          suffixe := grandeurs[indexStat].NomAff(expValeurIng);
          if (length(suffixe)>1) and (suffixe[1]='1')
             then suffixe :=  pointMedian + suffixe
             else suffixe :=  ' ' + suffixe;
          result := result + suffixe;
      end
      else begin
          if expValeurIng<>0 then
             result := result + pointMedian + '10' + puissToStr(expValeurIng);
          result := result + ' S.I.';
      end;
end;

begin with StatGrid,statCourante,grandeurs[indexStat] do begin
    if isNan(cible)
       then rowCount := 10
       else rowCount := 14;
    height := succ(rowCount)*DefaultRowHeight;
    ColWidths[0] := LargeurUnCarac*8;
    ColWidths[1] := LargeurUnCarac*10;
    if (classeStat in [csEffectifDonne,csFrequenceDonnee])
       then begin
            cells[0,0] := '';cells[1,0] := '';
       end
       else begin
            cells[0,0] := stTaille;cells[1,0] := IntToStr(Ntotal);
       end;
    chercheDecimales;
    cells[0,1] := stEtendue+'mini';cells[1,1] := formatValeur(min);
    cells[0,2] := stEtendue+stMaxi;cells[1,2] := formatValeur(max);
    if (classeStat in [csEffectifDonne,csFrequenceDonnee])
       then begin
          cells[0,3] := '';
          cells[1,3] := '';
       end
       else begin
          cells[0,3] := stMediane;
          cells[1,3] := formatValeurEtUnite(mediane);
       end;
    cells[0,4] := stMoyenne;cells[1,4] := formatValeur(moyenne);
    if classeStat=csFrequenceDonnee then begin
       cells[0,5] := '';cells[1,5] := '';
       cells[0,6] := '';cells[1,6] := '';
    end
    else begin
       cells[0,5] := 'ICm 95% mini';cells[1,5] := formatValeur(moyenne-t95);
       cells[0,6] := 'ICm 95% maxi';cells[1,6] := formatValeur(moyenne+t95);
    end;
    cells[0,7] := stEcartType;cells[1,7] := formatValeur(sigma);
    cells[0,8] := 'U(m,95%)';cells[1,8] := formatValeur(t95);
    cells[0,9] := 'CV';cells[1,9] := chainePrec(sigma/abs(moyenne));
    if not isNan(cible) then begin
       cells[0,10]  := stCible;cells[1,10] := formatReg(Cible);
       cells[0,11] := stInexactitude;cells[1,11] := '';
       cells[0,12] := '   '+StAbsolue;cells[1,12] := formatValeurEtUnite(Moyenne-Cible);
       cells[0,13] := '   '+StRelative;cells[1,13] := ChainePrec(Abs((Moyenne-Cible)/Cible));
    end;
end end;

(*
dans ce tableau on pourrait imaginer une autre ligne 'incertitude combinée' =
sqrt((inc type A)² + (inc type B)²) avec
inc type A : incertitude élargie de la série proposée et
inc type B : la valeur d'incertitude calculée dans le tableau de l'onglet "grandeurs" pour la grandeur concernée.
Par contre je vois tout de suite un problème qui va se poser pour les grandeurs
calculées parce que normalement, les incertitudes de type A  et B n'existent normalement pas.
*)

Procedure AfficheDist;
var i,idebut,ifin : integer;
    ligne : integer;
begin with statCourante do begin
     idebut := 1;
     while (NbreDist[idebut]=0) do inc(idebut);
     ifin := MaxHisto;
     while (NbreDist[ifin]=0) do dec(ifin);
     DistGrid.ColCount := 3;
     DistGrid.RowCount := 2+iFin-iDebut;
     if grandeurs[indexStat].nomUnite<>''
         then begin
            DistGrid.cells[0,0] := stMini+' ('+grandeurs[indexStat].nomUnite+')';
            DistGrid.cells[1,0] := stMaxi+' ('+grandeurs[indexStat].nomUnite+')';
         end
         else begin
            DistGrid.cells[0,0] := stMinimum;
            DistGrid.cells[1,0] := stMaximum;
         end;
     DistGrid.cells[2,0] := stTaille;
     DistGrid.ColWidths[2] := largeurUnCarac*10;
     for i := iDebut to iFin do begin
        ligne := succ(i-iDebut);
        DistGrid.cells[0,ligne] := grandeurs[indexStat].formatNombre(BornesDist[pred(i)]);
        DistGrid.cells[1,ligne] := grandeurs[indexStat].formatNombre(BornesDist[i]);
        DistGrid.cells[2,ligne] := IntToStr(round(NbreDist[i]));
     end;
end end;

Procedure AfficheDistInteger;
var i,idebut,ifin : integer;
    ligne : integer;
begin with statCourante do begin
     idebut := 1;
     while (NbreDist[idebut]=0) do inc(idebut);
     ifin := MaxHisto;
     while (NbreDist[ifin]=0) do dec(ifin);
     DistGrid.ColCount := 3;
     DistGrid.RowCount := 2+iFin-iDebut;
     if grandeurs[indexStat].nomUnite<>''
         then DistGrid.cells[0,0] := stValeur+' ('+grandeurs[indexStat].nomUnite+')'
         else DistGrid.cells[0,0] := stValeur;
     DistGrid.cells[1,0] := stTaille;
     DistGrid.ColWidths[2] := 0;
     for i := iDebut to iFin do begin
        ligne := succ(i-iDebut);
        DistGrid.cells[0,ligne] := grandeurs[indexStat].formatNombre(
                   round((BornesDist[pred(i)]+BornesDist[i])/2));
        DistGrid.cells[1,ligne] := IntToStr(round(NbreDist[i]));
     end;
end end;

Procedure AfficheDistEffectif;
var i : integer;
    ligne : integer;
begin with statCourante do begin
     DistGrid.ColCount := 2;
     DistGrid.RowCount := 1+Nbre;
     DistGrid.cells[0,0] := stValeur+grandeurs[indexStat].nomUnite;
     DistGrid.cells[1,0] := stTaille;
     for i := 0 to pred(Nbre) do begin
        ligne := succ(i);
        DistGrid.cells[0,ligne] := grandeurs[indexStat].formatNombre(Donnees[i]);
        DistGrid.cells[1,ligne] := IntToStr(round(Effectif[i]));
     end;
end end;

Procedure AfficheDistFrequence;
var i : integer;
    ligne : integer;
begin with statCourante do begin
     DistGrid.ColCount := 2;
     DistGrid.RowCount := 1+Nbre;
     if grandeurs[indexStat].nomUnite<>''
         then DistGrid.cells[0,0] := stValeur+' ('+grandeurs[indexStat].nomUnite+')'
         else DistGrid.cells[0,0] := stValeur;
     DistGrid.cells[1,0] := '';
     for i := 0 to pred(Nbre) do begin
        ligne := succ(i);
        DistGrid.cells[0,ligne] := grandeurs[indexStat].formatNombre(BornesDist[i]);
        DistGrid.cells[1,ligne] := '';
     end;
end end;

Function TestFrequence : boolean;
Var i : integer;
    total : double;
begin with Pages[pageCourante] do begin
       total := 0;
       for i := 0 to pred(nmes) do
           total := total + valeurVar[indexEffectif,i];
       result := (abs(total-1)<0.01) or (abs(total-100)<1);
       if result then begin
           statOptDlg.nomEffectif := grandeurs[indexEffectif].nom;
           statOptDlg.nomStat := grandeurs[indexStat].nom;
           statOptDlg.ClasseGroupe.itemIndex := ord(csFrequenceDonnee);
      end;
end end;

Function TestEffectif : boolean;
Var i,j,n : integer;
begin with Pages[pageCourante] do begin
       result := true;
       for i := 0 to pred(nmes) do begin
           if not IsEntier(valeurVar[indexEffectif,i],n) then begin
                  result := false;
                  break;
           end;     // indexEffectif non entier donc pas un effectif
           for j := 0 to pred(i) do
               if valeurVar[indexStat,i]=valeurVar[indexStat,j] then begin
                  result := false;
                  break;
               end; // doublon indexStat donc pas une variable
      end;
      if result then begin
           statOptDlg.nomEffectif := grandeurs[indexEffectif].nom;
           statOptDlg.nomStat := grandeurs[indexStat].nom;
           statOptDlg.ClasseGroupe.itemIndex := ord(csEffectifDonne);
      end;
end end;

Var
   PrecisionS,SauvePrecision,i : integer;
   oldFormat : TnombreFormat;
   p : TCodePage;
begin // setCoordonnee
     Graphe.raz;
     Graphe.dessins.clear;
     Graphe.grapheOK := NbreGrandeurs>0;
     if not graphe.GrapheOK then exit;
     indexStat := indexNom(statOptDlg.nomStat);
     if indexStat=grandeurInconnue then begin
        statOptDlg.ClasseGroupe.itemIndex := 0;
        if NbreVariabExp>1
           then begin
               indexStat := indexVariab[0];
               indexEffectif := indexVariab[1];
               if not TestEffectif then begin
                  if not TestFrequence then begin
                        indexStat := indexVariab[0];
                        indexEffectif := indexVariab[1];
                        testFrequence;
                  end;
                  indexStat := indexVariab[1];
                  indexEffectif := indexVariab[0];
                  testEffectif;
               end;
           end
           else begin
               indexStat := indexVariab[0];
               statOptDlg.nomStat := grandeurs[indexStat].nom;
           end;
        initStat;
     end;
     if grandeurs[indexStat].genreG=variable then
        statCourante := pages[pageCourante].stat;
     indexEffectif := indexNom(statOptDlg.nomEffectif);
     if indexEffectif=grandeurInconnue then begin
        indexEffectif := indexVariab[0];
        statOptDlg.nomEffectif := grandeurs[indexEffectif].nom;
        if statOptDlg.ClasseGroupe.itemIndex=ord(csEffectifDonne)
           then statOptDlg.ClasseGroupe.itemIndex := 0;
     end;
     with statCourante do begin
          calcul;
          PoissonPermis := moyenne<64;
          if PoissonPermis then for i := 0 to pred(Nbre) do begin
             PoissonPermis := PoissonPermis and
                 (abs(donnees[i]-round(donnees[i]))<0.001);
             if not PoissonPermis then break;
          end;
     end;
     Graphe.grapheOK := statCourante.statOK;
     if not graphe.GrapheOK then exit;
     Caption := stStatistique+StatOptDlg.nomStat;
     if statCourante.ClasseStat in [csEffectifDonne,csFrequenceDonnee]
        then frequenceGr := grandeurs[indexEffectif]
        else frequenceGr := frequenceGrDefault;
     with statCourante do begin
        SauvePrecision := grandeurs[indexStat].PrecisionU;
        oldFormat := grandeurs[indexStat].formatU;
        if oldFormat=fDefaut then grandeurs[indexStat].formatU := fExponent;
        try
        PrecisionS := ceil(-log10(sigma/abs(Moyenne)))+1;
        except
        PrecisionS := precision;
        end;
        if precisionS<3 then precisionS := 3;
        if precisionS>8 then precisionS := 8;
        grandeurs[indexStat].PrecisionU := PrecisionS;
     end;
     DistGrid.ColWidths[0] := largeurUnCarac*8;
     DistGrid.ColWidths[1] := largeurUnCarac*8;
     case statCourante.ClasseStat of
        csEffectifDonne : afficheDistEffectif;
        csFrequenceDonnee : afficheDistFrequence;
        else if statCourante.DataInteger and (statCourante.ecartDist=1)
           then afficheDistInteger
           else afficheDist;
     end;
     afficheStat;
     if graphe.superposePage
        then begin
           NPages := 0;
           for p := 1 to NbrePages do
               if pages[p].active then inc(Npages);
        end
        else NPages := 1;
     indexPage := 0;
     if Npages>1
        then begin for p := 1 to NbrePages do
             if pages[p].active then begin
                inc(indexPage);
                couleurC := couleurPages[indexPage];
                pages[p].Stat.Calcul;
                verifStat(p);
                setHistogramme(p);
             end;
        end
        else begin
           couleurC := couleurInit[1];
           SetHistogramme(pageCourante);
        end;
     graphe.modif := [];
     grandeurs[indexStat].PrecisionU := SauvePrecision;
     MajNomStat;
     grandeurs[indexStat].formatU := oldFormat;
end; // setCoordonnee

procedure TFstatistique.GrapheCopierClick(Sender: TObject);
begin
      Graphe.VersPressePapier(grapheClip)
end;

procedure TFstatistique.WMRegMaj(var Msg : TWMRegMessage);
begin
      case msg.TypeMaj of
          MajVide : begin
             statOptDlg.nomStat := '';
             majFichierEnCours := true;
          end;
          MajFichier : begin
             graphe.modif := [gmXY];
             majFichierEnCours := false;
          end;
          MajGrandeur : if majFichierEnCours then begin
             graphe.modif := [gmXY];
             majFichierEnCours := false;
             statCourante := pages[1].Stat;
             statCourante.statOK := false;
          end
          else majNomStat;
          MajAjoutValeur,MajValeur,MajValeurConst,MajValeurAcq,MajSupprPoints,MajAjoutPage : begin
             graphe.Modif := [gmXY];
             initStat;
             refresh;
          end;
          MajChangePage,MajSupprPage,MajGroupePage : begin
             graphe.modif := [gmXY];
             verifStat(pageCourante);
             refresh;
          end;
          MajSelectPage : begin
             graphe.modif := [gmXY];
             if msg.codeMaj<>0 then graphe.SuperposePage := msg.codeMaj>1;
             refresh;
          end;
          MajSauvePage,MajPreferences,MajModele,MajIncertitude,MajOptionsgraphe : ;
          MajNumeroMesure,MajTri,MajValeurGr : ;
          MajUnites,MajUnitesParam,MajNom : MajNomStat;
      end;
end;

procedure TFstatistique.PaintBoxStatPaint(Sender: TObject);

procedure setMinMax;
var minX,maxX,minY,maxY : double;
begin
    with graphe.monde[mondeX] do begin
          try
          minX := GetFloat(miniXEdit.text);
          except
          minX := mini;
          end;
          try
          maxX := GetFloat(maxiXEdit.text);
          except
          maxX := maxi;
          end;
          SetMinMaxDefaut(minX,maxX);
          defini := true;
    end;
    with graphe.monde[mondeY] do begin
          try
          minY := GetFloat(miniYEdit.text);
          except
          minY := mini;
          end;
          try
          maxY := GetFloat(maxiYEdit.text);
          except
          maxY := maxi;
          end;
          SetMinMaxDefaut(minY,maxY);
          defini := true;
    end;
end;

procedure affecteMinMax;
begin
      miniXEdit.text := formatReg(graphe.monde[mondeX].mini);
      maxiXEdit.text := formatReg(graphe.monde[mondeX].maxi);
      miniYEdit.text := formatReg(graphe.monde[mondeY].mini);
      maxiYEdit.text := formatReg(graphe.monde[mondeY].maxi);
end;

begin
      graphe.canvas := PaintBoxStat.canvas;
      if gmXY in graphe.modif then setCoordonnee;
      if not graphe.grapheOK then begin
           if not statCourante.statOK then
              PaintBoxStat.Canvas.textOut(PaintBoxStat.width div 2,
                                          PaintBoxStat.height div 2,
                                          erNbreData);
           exit;
      end;
      graphe.limiteFenetre := PaintBoxStat.clientRect;
      with PaintBoxStat.Canvas do begin
         	Pen.mode := pmCopy;
          brush.Color := clWindow;
          brush.style := bsSolid;
          FillRect(PaintBoxStat.clientRect);
         	Brush.style := bsClear;
          if echelleBtn.down
             then setMinMax
             else affecteMinMax;
          graphe.UseDefaultX := echelleBtn.down;
          if EchelleBtn.down then begin
             if graphe.monde[mondeX].axe<>nil
             then Xlabel.Caption := stAbscisse+' '+graphe.monde[mondeX].axe.nom
             else Xlabel.Caption := stAbscisse;
             if graphe.monde[mondeY].axe<>nil
             then Ylabel.Caption := stOrdonnee+' '+graphe.monde[mondeY].axe.nom
             else Ylabel.Caption := stOrdonnee;
          end;
          graphe.chercheMonde;
          graphe.draw;
          Pen.Color := PcolorReticule;
          Pen.style := PstyleReticule;
          Pen.mode := pmNotXor;
          Brush.color := BrushCouleurZoom;
          Brush.style := bsSolid;
      end;
      indexPointCourant := -1;
end;

procedure TFstatistique.FormDestroy(Sender: TObject);
begin
     StatGlb.free;
     Graphe.Free;
     FrequenceGrDefault.free;
     StatOptDlg.free;
     Fstatistique := nil;
end;

procedure TFstatistique.EchelleBtnClick(Sender: TObject);
begin
  inherited;
  EchellePanel.visible := echelleBtn.down;
  graphe.monde[mondeX].Defini := echelleBtn.down;
  graphe.monde[mondeY].Defini := echelleBtn.down;
  graphe.modif := [gmEchelle];
end;

Procedure TFstatistique.ecritConfig;
begin
   writeln(fichier,symbReg2,'1 X');
   ecritChaineRW3(statOptDlg.nomStat);
   writeln(fichier,symbReg2,'1 Y');
   ecritChaineRW3(statOptDlg.nomEffectif);
   writeln(fichier,symbReg2,'5 '+stOptions);
   writeln(fichier,ord(statOptDlg.courbeGaussCB.checked));
   writeln(fichier,ord(statOptDlg.distributionCB.checked));
   writeln(fichier,ord(statOptDlg.classeGroupe.itemIndex));
   writeln(fichier,ord(statOptDlg.courbePoissonCB.checked));
   writeln(fichier,ord(statOptDlg.courbeBinomeCB.checked));
   if dispositionFenetre=dNone then begin
       writeln(fichier,symbReg2,'5 '+stFenetre);
       writeln(fichier,ord(windowState));
       writeln(fichier,top);
       writeln(fichier,left);
       writeln(fichier,width);
       writeln(fichier,height);
   end;    
end;

Procedure TFstatistique.litConfig;
var i,imax : integer;
    zbyte : byte;
    zint : integer;
begin
   majFichierEnCours := true;
   while (Length(LigneWin)>0) and (ligneWin[1]=symbReg2) do begin
   imax := NbreLigneWin(ligneWin);
   if pos('X',ligneWin)<>0
      then StatOptDlg.nomStat := litLigneWinU
      else if pos('Y',ligneWin)<>0
      then StatOptDlg.nomEffectif := litLigneWinU
      else if pos(stOptions,ligneWin)<>0
          then begin
               statOptDlg.courbeGaussCB.checked := litBooleanWin;
               if imax>1 then
                   statOptDlg.distributionCB.checked := litBooleanWin;
               if imax>2 then begin
                   litLigneWin;
                   statOptDlg.ClasseGroupe.ItemIndex := strToInt(ligneWin);
               end;
               if imax>3 then
                   statOptDlg.CourbePoissonCB.checked := litBooleanWin;
               if imax>4 then
                   statOptDlg.CourbeBinomeCB.checked := litBooleanWin;
               for i := 6 to imax do litLigneWin;
          end
          else if pos(stFenetre,ligneWin)<>0 then begin
              readln(fichier,zByte);
              windowState := TwindowState(zByte);
              readln(fichier,zint);
              top := zint;
              readln(fichier,zint);
              left := zint;
              readln(fichier,zint);
              width := zint;
              readln(fichier,zint);
              height := zint;
              position := poDesigned;
          end
          else for i := 1 to imax do litLigneWin;
   litLigneWin;
end end;

Procedure TFStatistique.InitStat;
var p,iP : integer;
begin
   if grandeurs[indexStat].genreG in [constante,paramNormal] then begin
         statGlb.Nbre := NbrePages;
         statGlb.statOK := false;
         statCourante := statGlb;
   end;
   if grandeurs[indexStat].genreG=paramNormal
      then iP := indexToParam(paramNormal,indexStat)
      else iP := 0;
   for p := 1 to NbrePages do with pages[p] do begin
      stat.statOK := false;
      stat.classeStat := TclasseStat(statOptDlg.ClasseGroupe.itemIndex);
      case stat.classeStat of
         csEffectifDonne : begin
            stat.setValeurEffectif(ValeurVar[indexStat],ValeurVar[indexEffectif],Nmes);
            if not stat.statOK then begin
               stat.classeStat := csFrequenceDonnee;
               stat.calcul;
               if stat.statOK then
                  statOptDlg.ClasseGroupe.itemIndex := ord(csFrequenceDonnee);
            end;
         end;
         csFrequenceDonnee : begin
            stat.setValeurEffectif(ValeurVar[indexStat],ValeurVar[indexEffectif],Nmes);
            if not stat.statOK then begin
               stat.classeStat := csEffectifDonne;
               stat.calcul;
               if stat.statOK then
                  statOptDlg.ClasseGroupe.itemIndex := ord(csEffectifDonne);
            end;
         end
         else case grandeurs[indexStat].genreG of
          variable : stat.setValeur(ValeurVar[indexStat],Nmes,true);
          constante : statGlb.Donnees[p-1] := valeurConst[indexStat];
          paramNormal : statGlb.Donnees[p-1] := valeurParam[paramNormal,iP];
         end;
      end;
   end;
   if grandeurs[indexStat].genreG in [constante,paramNormal]
        then statGlb.Calcul;
end;

Procedure TFStatistique.VerifStat(p : TcodePage);
begin
   if (grandeurs[indexStat].genreG=variable) and
      (pages[p].stat.Nbre=0)
   then with pages[p] do begin
      stat.statOK := false;
      stat.classeStat := TclasseStat(statOptDlg.ClasseGroupe.itemIndex);
      case stat.classeStat of
         csEffectifDonne : begin
            stat.setValeurEffectif(ValeurVar[indexStat],ValeurVar[indexEffectif],Nmes);
            if not stat.statOK then begin
               stat.classeStat := csFrequenceDonnee;
               stat.calcul;
               if stat.statOK then
                  statOptDlg.ClasseGroupe.itemIndex := ord(csFrequenceDonnee);
            end;
         end;
         csFrequenceDonnee : begin
            stat.setValeurEffectif(ValeurVar[indexStat],ValeurVar[indexEffectif],Nmes);
            if not stat.statOK then begin
               stat.classeStat := csEffectifDonne;
               stat.calcul;
               if stat.statOK then
                  statOptDlg.ClasseGroupe.itemIndex := ord(csEffectifDonne);
            end;
         end
         else stat.setValeur(ValeurVar[indexStat],Nmes,true);
      end;
   end;
end;

procedure TFstatistique.PaintBoxStatMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin with graphe do begin
      case curseurStat of
         crsTexte : with dessinCourant do  begin
           affectePosition(x,y,sdPoint1,shift);
           x2i := x1i;
           y2i := y1i;
         end;
         crsSelect : begin
            SetDessinCourant(x,y);
            if dessinCourant<>nil then with dessinCourant do
                  if posDessinCourant=sdCadre
                     then begin
                        zoneSelect := cadre;
                        graphe.RectangleGr(zoneSelect);
                     end
               else setPointCourant(PointProche(x,y,0,true,false));
       end;
       crsEfface : begin
            SetDessinCourant(x,y);
            if dessinCourant<>nil then with dessins do begin
                   remove(DessinCourant);
                   PaintBoxStat.invalidate;
               end;
            if (graphe.dessinCourant=nil) and
               not(statCourante.classeStat in [csEffectifDonne,csFrequenceDonnee]) then begin
                   zoneSelect := rect(x,y,x,y);
                   RectangleGr(zoneSelect);
            end;
       end;
  end // case curseurStat
end end; // MouseDown

procedure TFstatistique.PaintBoxStatMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var deplacement : boolean;
begin with graphe do begin
   deplacement := ssLeft in Shift;
   case curseurStat of
          crsSelect : if deplacement then begin
             if dessinCourant<>nil then with dessinCourant do
                if posDessinCourant=sdCadre
                   then begin
                       RectangleGr(zoneSelect); { efface }
                       graphe.AffecteCentreRect(x,y,zoneSelect);
                       RectangleGr(zoneSelect);
                   end
             end
             else begin
                SetDessinCourant(x,y);
                if (posDessinCourant<>sdNone) 
                  then PaintBoxStat.cursor := crSize
                  else PaintBoxStat.cursor := crDefault;
             end;
        crsTexte : if deplacement then
            with PaintBoxStat.canvas,dessinCourant do begin
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
end end;// MouseMove

procedure TFstatistique.OptionsItemClick(Sender: TObject);
begin with statOptDlg do begin
       EditAmplitude.text := FormatReg(statCourante.ecartDist);
       EditDebut.text :=  FormatReg(statCourante.debutDist);
       EditCible.text := FormatReg(statCourante.cible);
       ClasseGroupe.itemIndex := ord(statCourante.classeStat);
       NombreSpin.Value := statCourante.NbreClasse;
       CourbePoissonCB.visible := PoissonPermis;
       CourbeBinomeCB.visible := PoissonPermis;       
       GrilleCB.checked := OgQuadrillage in graphe.optionGraphe;
       SuperPagesCB.visible := NbrePages>1;
       SuperPagesCB.checked := superPagesCB.visible and graphe.superposePage;
       if not PoissonPermis then begin
          CourbePoissonCB.checked := false;
          CourbeBinomeCB.checked := false;
       end;
       if StatOptDlg.ShowModal=mrOK then begin
          graphe.superposePage := SuperPagesCB.checked;
          if GrilleCB.checked
             then include(graphe.OptionGraphe,OgQuadrillage)
             else exclude(graphe.OptionGraphe,OgQuadrillage);
          indexStat := indexNom(nomStat);
          indexEffectif := indexNom(nomEffectif);
          statCourante.classeStat := TclasseStat(ClasseGroupe.itemIndex);
          if (grandeurs[indexStat].genreG<>variable) and
            (statCourante.classeStat in [csEffectifDonne,csFrequenceDonnee]) then begin
               if indexEffectif=indexVariab[1]
                  then indexStat := indexVariab[0]
                  else indexStat := indexVariab[1];
          end;
          if grandeurs[indexStat].genreG=variable
             then statCourante := pages[pageCourante].stat
             else statCourante := statGlb;
          case statCourante.classeStat of
              csNombreImpose : statCourante.NbreClasse := NombreSpin.Value;
              csEcartImpose : begin
                 try
                 statCourante.ecartDist := getFloat(EditAmplitude.text);
                 except end;
                 try
                 statCourante.debutDist := getFloat(EditDebut.text);
                 except end;
              end;
          end;// case classeStat
          if CibleCB.checked
             then begin
               try
               statCourante.cible := getFloat(EditCible.text)
               except end;
             end
             else statCourante.cible := Nan;
          graphe.modif := [gmXY];
          initStat;
          PaintBoxStat.invalidate;
       end;
end end;

procedure TFstatistique.CopierItemClick(Sender: TObject);
begin
     Graphe.VersPressePapier(grapheClip)
end;

procedure TFstatistique.CopierTableauItemClick(Sender: TObject);
begin
     FormDDE.RazRTF;
     FormDDE.Editor.lines.Add(stCaracStat+statOptDlg.nomStat);
     FormDDE.AjouteGrid(StatGrid);
     FormDDE.EnvoieRTF;
end;

procedure TFstatistique.SetCurseurStat(c : TcurseurStat);
begin with PaintBoxStat,Canvas do begin
  Pen.style := psSolid;
  Pen.mode := pmNotXor;
  Brush.style := bsClear;
  Brush.Color := clWindow;
  curseurStat := c;
  case curseurStat of
       crsTexte : begin
          cursor := crLettre;
          TexteBtn.Down := true;
       end;
       crsEfface : begin
          cursor := crGomme;
          GommeBtn.hint := hFinGomme;
          GommeBtn.Down := true;
       end;
       crsSelect : begin
          cursor := crDefault;
          SelectBtn.Down := true;
       end;
   end;{case}
   if curseurStat<>crsEfface then GommeBtn.hint := hGommeStat;
end end;

procedure TFstatistique.PaintBoxStatMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

Procedure chercheDebutFin;
var i : integer;
    Xi,Yi : Integer;
    nbreSelect,debutSelect,finSelect : integer;
begin with Graphe,statCourante do begin
      debutSelect := Nbre;
      finSelect := -1;
      RectangleGr(zoneSelect); { efface }
      windowXY(donnees[0],0,mondeY,Xi,Yi);
      if (ZoneSelect.top-Yi)*(ZoneSelect.bottom-Yi)>0
         then afficheErreur(ErGommeStat,0)
         else for i := 0 to pred(Nbre) do begin
             windowXY(donnees[i],0,mondeY,Xi,Yi);
             if (Xi>zoneSelect.left) and (debutSelect>i) then
                  debutSelect := i;
             if (Xi<zoneSelect.right) and (finSelect<i) then
                  finSelect := i;
          end;
      if finSelect>=debutSelect
         then NbreSelect := succ(finSelect-debutSelect)
         else NbreSelect := 0;
      if (NbreSelect>0) and OKreg(OkDeldata,0) then
           with statCourante do begin
                Nbre := Nbre-NbreSelect;
                for i := 0 to pred(Nbre-debutSelect) do
                    donnees[debutSelect+i] := donnees[finSelect+i+1];
                statOK := false;
                graphe.modif := [gmXY];
                if not GommeBtn.down then setCurseurStat(crsSelect);
                PaintBoxStat.invalidate;
          end;
end end;

procedure AffecteDessin;
begin with graphe.dessinCourant do begin
   with PaintBoxStat.canvas do begin
        MoveTo(x1i,y1i);
        LineTo(x2i,y2i); { efface }
   end;
   if isTexte and
      not litOption(graphe)
        then graphe.dessinCourant.free
        else begin
           AffectePosition(x,y,sdPoint2,shift);
           graphe.dessins.Add(graphe.DessinCourant);
           draw;
        end;  
   setCurseurStat(crsSelect);
end end;

begin //mouseUp
with graphe do begin
  if grandeurs[indexStat].genreG=variable then
      StatCourante := pages[pageCourante].stat;
  case curseurStat of
       crsTexte : affecteDessin;
       crsSelect : if reelClick
          then begin
             SetDessinCourant(x,y);
             if (dessinCourant<>nil) then begin
                dessinCourant.litOption(graphe);
                PaintBoxStat.invalidate;
                DessinCourant := nil;
             end;
          end
          else if dessinCourant<>nil then with dessinCourant do begin
               AffectePosition(x,y,posDessinCourant,shift);
               dessinCourant := nil;
               PaintBoxStat.invalidate;
          end;
       crsEfface : chercheDebutFin;
  end;
  reelClick := false;
end end; // mouseUp

procedure TFstatistique.PaintBoxStatDblClick(Sender: TObject);
begin
     reelClick := true
end;

procedure TFstatistique.ImprimeBtnClick(Sender: TObject);
var bas : integer;
begin
       if OKReg(OkImprGr,0) then begin
          try
          debutImpressionGr(poPortrait,bas);
          Graphe.versImprimante(HautGrapheGr,bas);
          if OKReg(OkImprTab,0) then begin
             DebutImpressionTexte(bas);
             ImprimerLigne(stStatistique+Fstatistique.caption,bas);
             ImprimerGrid(Fstatistique.StatGrid,bas);
             ImprimerGrid(Fstatistique.DistGrid,bas);
          end;
          finImpressionGr;
          except
          end;
       end;
end;

procedure TFstatistique.TableauBtnClick(Sender: TObject);
begin
     refresh
end;

procedure TFstatistique.ImprimerGraphe(var bas : integer);
begin
    graphe.versImprimante(HautGrapheTxt,bas)
end;

procedure TFstatistique.SetPointCourant(i : integer);

Procedure AffichePointCourant;
var xi,yi,dimP : Integer;
begin
if indexPointCourant<0 then exit;
with PaintBoxStat.canvas do begin
        Pen.color := graphe.courbes.items[0].couleur;
        Pen.mode := pmNotXor;
        Pen.style := psSolid;
        Brush.color := graphe.courbes.items[0].couleur;
        Brush.style := bsSolid;
        graphe.WindowRT(graphe.courbes.items[0].valX[indexPointCourant],
                        graphe.courbes.items[0].valY[indexPointCourant],
                        graphe.courbes.items[0].iMondeC,Xi,Yi);
        DimP := graphe.dimPoint+3;
        Ellipse(xi-dimP,yi-dimP,xi+dimP,yi+dimP);
end end;

begin
     AffichePointCourant; // efface
     indexPointCourant := i;
     AffichePointCourant;
end;

procedure TFstatistique.EditBidonKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if ssAlt in Shift then begin
        case key of
             ord('C') : ListeNom.SetFocus;
             ord('I') : ImprimeBtnClick(nil);
        end;
        exit;
     end;
     if (key=vk_cancel) and (curseurStat<>crsSelect) then begin
        setCurseurStat(crsSelect);
        PaintBoxStat.invalidate;
     end;
end;

procedure TFstatistique.EnregistrerGrapheItemClick(Sender: TObject);
begin
    if saveDialog.Execute then
       Graphe.VersFichier(saveDialog.fileName)
end;

procedure TFstatistique.FormShortCut(var Msg: TWMKey;
  var Handled: Boolean);
var P : Tpoint;
    i : integer;
begin with graphe do begin
     case msg.charCode of
          vk_delete : begin
             SetDessinCourant(P.x,P.y);
             if (curseurStat=crsSelect) and
                (posDessinCourant<>sdNone)
                then with dessins do begin
                    remove(DessinCourant);
                    PaintBoxStat.invalidate;
                    handled := true;
                end
                else with statCourante do
                    if (indexPointCourant>=0) and
                       not(classeStat in [csEffectifDonne,csFrequenceDonnee]) then begin
                     Nbre := Nbre-1;
                     for i := indexPointCourant to pred(Nbre) do
                        donnees[i] := donnees[succ(i)];
                     statOK := false;
                     calcul;
                     graphe.modif := [gmXY];
                     refresh;
                     handled := true;
                end;
       end;
       vk_cancel : if curseurStat<>crsSelect then begin
          setCurseurStat(crsSelect);
          PaintBoxStat.invalidate;
          handled := true;
       end;
    end;{case}
end end;

procedure TFstatistique.GommeBtnClick(Sender: TObject);
begin
     if GommeBtn.Down
        then setCurseurStat(crsEfface)
        else setCurseurStat(crsSelect)
end;

procedure TFstatistique.TexteBtnClick(Sender: TObject);
begin
      setCurseurStat(crsTexte);
      graphe.DessinCourant := Tdessin.create(graphe);
      graphe.DessinCourant.isTexte := curseurStat=crsTexte
end;

procedure TFstatistique.SelectBtnClick(Sender: TObject);
begin
      setCurseurStat(crsSelect)
end;

procedure TFstatistique.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TFstatistique.FormActivate(Sender: TObject);
begin
  inherited;
  FregressiMain.StatistiqueBtn.down := true;
end;

procedure TFstatistique.ListeNomChange(Sender: TObject);
begin
   if statOptDlg.NomStat<>listeNom.text then begin
        statOptDlg.NomStat := listeNom.text;
        indexStat := indexNom(StatOptDlg.nomStat);
        graphe.modif := [gmXY];
        initStat;
        PaintBoxStat.invalidate;
   end;
end;

procedure TFstatistique.majNomStat;
var i : integer;
begin
     ListeNom.Items.Clear;
     for i := 0 to pred(NbreGrandeurs) do with grandeurs[i] do
         if genreG=variable then ListeNom.Items.add(nom);
     listeNom.itemIndex := listeNom.items.indexOf(statOptDlg.NomStat);
     if listeNom.itemIndex<0 then listeNom.itemIndex := 1;
end;

procedure TFstatistique.miniXeditExit(Sender: TObject);
begin
  inherited;
  graphe.modif := [gmEchelle];
  PaintBoxStat.invalidate;
end;

procedure TFstatistique.miniXeditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key=vk_return then miniXeditExit(Sender)
end;

procedure TFstatistique.miniXeditKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  VerifKeyGetFloat(key)
end;

procedure TFstatistique.GridBtnClick(Sender: TObject);
begin
  panelValeurs.Visible := gridBtn.Down
end;

end.

