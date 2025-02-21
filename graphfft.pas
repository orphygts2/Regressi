unit graphfft;

interface

uses Windows, Classes, Graphics, Messages, Forms, Controls, Menus, ExtCtrls,
     System.ImageList, ToolWin, Buttons,
     Dialogs, system.Types, system.UITypes, StdCtrls, Grids, Printers, ComCtrls,
     ImgList, math, spin, fft, mplayer, sysutils,
     Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc,
     constreg, maths, regutil, compile, graphker, aidekey, Vcl.Mask,
  Vcl.VirtualImageList, Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TFGrapheFFT = class(TForm)
    PanelCourbe: TPanel;
    PaintBoxTemps: TPaintBox;
    PaintBoxFrequence: TPaintBox;
    PopupMenuFFT: TPopupMenu;
    OptionsFourierItem: TMenuItem;
    CouleursItem: TMenuItem;
    VariablesItem: TMenuItem;
    CopierGrapheItem: TMenuItem;
    ValeursGrid: TStringGrid;
    FFTToolBar: TToolBar;
    OptionsBtn: TToolButton;
    ZoomBtn: TToolButton;
    TableauBtn: TToolButton;
    TempsBtn: TToolButton;
    limitesBtn: TToolButton;
    FenetrageBtn: TToolButton;
    ImprimeBtn: TToolButton;
    SplitterGrid: Tsplitter;
    PopupMenuGrid: TPopupMenu;
    CopyGridBtn: TMenuItem;
    PopupMenuTemps: TPopupMenu;
    CopierTempsWMF: TMenuItem;
    CacherTemps: TMenuItem;
    CacherGrid: TMenuItem;
    PeriodeFFTEdit: TEdit;
    FinFFTspin: TSpinButton;
    DebutFFTspin: TSpinButton;
    SplitterTemps: TSplitter;
    FenetrageMenu: TPopupMenu;
    HammingBtn: TMenuItem;
    RectBtn: TMenuItem;
    FlatTopBtn: TMenuItem;
    ZoomAutoBtn: TToolButton;
    Imprimer1: TMenuItem;
    Imprimer2: TMenuItem;
    MenuDessin: TPopupMenu;
    DessinSupprimerItem: TMenuItem;
    ProprietesMenu: TMenuItem;
    SelectBtn: TToolButton;
    ValeurCouranteH: TStatusBar;
    LabelX: TLabel;
    LabelY: TLabel;
    SauverLigneItem: TMenuItem;
    SaveFreqItem: TMenuItem;
    ZoomManuel: TMenuItem;
    SourisMenu: TPopupMenu;
    StandardItem: TMenuItem;
    exte1: TMenuItem;
    ReticuleItem: TMenuItem;
    LigneItem: TMenuItem;
    N1: TMenuItem;
    BlackmanBtn: TMenuItem;
    NbreHarmAffSpin: TSpinButton;
    NaturelleCorrBtn: TMenuItem;
    ToolBarGrandeurs: TToolBar;
    ToolButton6: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    OptionsSonagramme: TPanel;
    DecadeSE: TSpinEdit;
    DecadeLabel: TLabel;
    DecibelCB: TCheckBox;
    PasSonAffEdit: TLabeledEdit;
    FreqmaxEdit: TLabeledEdit;
    FaussesCouleursCB: TCheckBox;
    SonagrammeBtn: TToolButton;
    DureeMenu: TPopupMenu;
    Priode1: TMenuItem;
    out1: TMenuItem;
    PasSonCalculSE: TSpinEdit;
    Label2: TLabel;
    CurseurGrid: TStringGrid;
    SeparePeriodeBtn: TToolButton;
    EnregistrerItem: TMenuItem;
    SaveDialog: TSaveDialog;
    EnregistrerGrapheItem: TMenuItem;
    TimerWav: TTimer;
    PlayBtn: TToolButton;
    MediaPlayer: TMediaPlayer;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    harmoniqueAffItem: TMenuItem;
    FreqMaxSonUD: TUpDown;
    PanelAnimation: TPanel;
    DebutBtn: TSpeedButton;
    RetourRapideBtn: TSpeedButton;
    RetourBtn: TSpeedButton;
    StopBtn: TSpeedButton;
    AvanceBtn: TSpeedButton;
    AvanceRapideBtn: TSpeedButton;
    FinBtn: TSpeedButton;
    OptionsAnimBtn: TSpeedButton;
    HelpAnimBtn: TSpeedButton;
    GroupBox6: TGroupBox;
    TrackBar6: TTrackBar;
    GroupBox4: TGroupBox;
    TrackBar4: TTrackBar;
    GroupBox5: TGroupBox;
    TrackBar2: TTrackBar;
    GroupBox2: TGroupBox;
    TrackBar1: TTrackBar;
    GroupBox1: TGroupBox;
    TrackBar3: TTrackBar;
    GroupBox3: TGroupBox;
    TrackBar5: TTrackBar;
    BoucleCB: TCheckBox;
    TitreAnimCB: TCheckBox;
    NbreTickBar: TTrackBar;
    GroupBox8: TGroupBox;
    TrackBar8: TTrackBar;
    GroupBox9: TGroupBox;
    TrackBar9: TTrackBar;
    GroupBox7: TGroupBox;
    TrackBar7: TTrackBar;
    TimerAnim: TTimer;
    AnimationBtn: TToolButton;
    GroupBox10: TGroupBox;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    SaveHarmItem: TMenuItem;
    SaveDialogCSV: TSaveDialog;
    EnregistrerSpectreItem: TMenuItem;
    procedure FrequenceMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ZoomAvantItemClick(Sender: TObject);
    procedure FrequenceMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FrequenceMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure zoomAutoItemClick(Sender: TObject);
    procedure TableauItemClick(Sender: TObject);
    procedure TempsItemClick(Sender: TObject);
    procedure FrequencePaint(Sender: TObject);
    procedure TempsPaint(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure OptionsFourierItemClick(Sender: TObject);
    procedure CouleursItemClick(Sender: TObject);
    procedure PopupMenuFFTPopup(Sender: TObject);
    procedure TempsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TempsMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure TempsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PeriodeBtnClick(Sender: TObject);
    procedure PaintBoxFrequenceDblClick(Sender: TObject);
    procedure ToutBtnClick(Sender: TObject);
    procedure copierTableauItemClick(Sender: TObject);
    procedure ImprimeBtnClick(Sender: TObject);
    procedure FenetreBtnClick(Sender: TObject);
    procedure ValeursGridDblClick(Sender: TObject);
    procedure ValeursGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SplitterGridCanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure CacherTempsClick(Sender: TObject);
    procedure CacherGridClick(Sender: TObject);
    procedure DebutFFTEditKeyPress(Sender: TObject; var Key: Char);
    procedure DebutFFTEditExit(Sender: TObject);
    procedure DebutFFTspinDownClick(Sender: TObject);
    procedure DebutFFTspinUpClick(Sender: TObject);
    procedure FinFFTspinUpClick(Sender: TObject);
    procedure FinFFTspinDownClick(Sender: TObject);
    procedure CopierItemClick(Sender: TObject);
    procedure ZoomManuelBtnClick(Sender: TObject);
    procedure FenetrageMenuPopup(Sender: TObject);
    procedure DessinSupprimerItemClick(Sender: TObject);
    procedure ProprietesMenuClick(Sender: TObject);
    procedure SelectBtnClick(Sender: TObject);
    procedure TextBtnClick(Sender: TObject);
    procedure ReticuleBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure SauverLigneItemClick(Sender: TObject);
    procedure PopupMenuGridPopup(Sender: TObject);
    procedure SaveFreqItemClick(Sender: TObject);
    procedure ReticuleItemClick(Sender: TObject);
    procedure TexteItemClick(Sender: TObject);
    procedure StandardItemClick(Sender: TObject);
    procedure LigneItemClick(Sender: TObject);
    procedure ZoomDebutFinItemClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure NbreHarmAffSpinDownClick(Sender: TObject);
    procedure NbreHarmAffSpinUpClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PasSonAffEditExit(Sender: TObject);
    procedure DecibelCBClick(Sender: TObject);
    procedure DecadeSEChange(Sender: TObject);
    procedure FreqmaxEditExit(Sender: TObject);
    procedure pasSonCalculEditExit(Sender: TObject);
    procedure FaussesCouleursCBClick(Sender: TObject);
    procedure SonagrammeBtnClick(Sender: TObject);
    procedure EnregistrerItemClick(Sender: TObject);
    procedure EnregistrerGrapheItemClick(Sender: TObject);
    procedure TimerWavTimer(Sender: TObject);
    procedure PlayBtnClick(Sender: TObject);
    procedure MediaPlayerNotify(Sender: TObject);
    procedure bitmapItemClick(Sender: TObject);
    procedure CopierTempsWMFClick(Sender: TObject);
    procedure harmoniqueAffItemClick(Sender: TObject);
    procedure ToolButtonClick(Sender: TObject);
    procedure FreqMaxSonUDChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Integer; Direction: TUpDownDirection);
    procedure GroupBoxAnimDblClick(Sender: TObject);
    procedure GroupBoxAnimClick(Sender: TObject);
    procedure AnimSliderChange(Sender: TObject);
    procedure TimerAnimTimer(Sender: TObject);
    procedure DebutBtnClick(Sender: TObject);
    procedure FinBtnClick(Sender: TObject);
    procedure RetourRapideBtnClick(Sender: TObject);
    procedure AvanceRapideBtnClick(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
    procedure RetourBtnClick(Sender: TObject);
    procedure AvanceBtnClick(Sender: TObject);
    procedure HelpAnimBtnClick(Sender: TObject);
    procedure OptionsAnimBtnClick(Sender: TObject);
    procedure AnimationBtnClick(Sender: TObject);
    procedure TitreAnimCBClick(Sender: TObject);
    procedure SaveHarmItemClick(Sender: TObject);
    procedure EnregistrerSpectreItemClick(Sender: TObject);
  
  private
      reelClick : boolean;
      listePic : array[TindiceOrdonnee] of TlistePic;
      indexFonction : integer;
      CourbeCourante : integer;
      CurseurF : TcurseurFrequence;
      CurseurT : TcurseurTemps;
      ZoomEnCours,avecPoint : boolean;
      rectDeplace : Trect;
      ListeY : TstringList;
      PointOld : Tpoint;
      iCourant : integer;
      Reference : Trect;
      XdebutInt,XfinInt : Integer;
      FrequenceV,AmplitudeV : Tvecteur;
      colClick,rowClick : longInt;
      Xdeplace : integer;
      ordonneeFFTgr : TordonneeFFT;
      CurMovePermis : boolean;
      xCurseurEchelleFreq : integer;
      ContinuInclus : boolean;
      majRaiesAfaire : boolean;
      RazSon : boolean;
      indexSonagramme : integer;
      positionPB : integer;
      TempsZeroWav : double;
      MediaPlayerOpen : boolean;
      MaJTempsAfaire : boolean;
      grapheUtilise : boolean;
// Animation
      Avance : boolean;
      ActiverTimerAnim : boolean;
      InitManuelleAfaire : boolean;
      ParamAnimCourant : integer;
      maxParamAnimFFT : integer;
// Fin data animation
      Procedure SetAnimation;
      procedure CalculeAnimation;
      procedure paramPrecedent;
      procedure paramSuivant;
      procedure CacheAnimation;
// Fin procedure animation
      Procedure SetCoordonnee;
      procedure SetCurseurF(c : TcurseurFrequence);
      Procedure TraceReference;
      Procedure AffecteDebutFin;
      procedure TraceDebutFin;
      procedure ChercheReference;
      Procedure MajGrapheFFT;
      function VerifPeriodeFFT(Sender: TObject) : boolean;
      procedure SauverFrequence(f,a : double);
      procedure changeEchelleSon(xnew, xold: integer);
      procedure TracePosition;
      procedure calculSonagramme;
      procedure AffecteToolBar;
  protected
      procedure WMRegMaj(var Msg : TWMRegMessage); message WM_Reg_Maj;
      procedure WMRegAnimation(var Msg : TWMRegMessage); message WM_Reg_Animation;
  public
      GrapheFrequence,GrapheTemps : TgrapheReg;
      enveloppeSpectre : boolean;
      configCharge,majFichierEnCours : boolean;
      procedure ecritConfig;
      procedure litConfig;
      procedure ecritConfigXML(ANode : IXMLNOde);
      procedure litConfigXML(ANode : IXMLNOde);
      procedure ImprimerGraphe(var bas : integer);
      procedure VersLatex(const NomFichier : string);
  end;

var FGrapheFFT : TFGrapheFFT;

implementation

uses Regmain, optFFT, regdde, Modif, options,
  optcolordlg, ZoomManuelFFT, graphvar, choixparamanim, saveHarm;

const
   IconeW : array [Tfenetre] of integer =(8,29,10,30,31);
   margeDebutFin = 5;
   HauteurInitTemps = 50;
   playIndex = 22;
   stopIndex = 33;
   minPeriodeFFT = 32;

{$R *.DFM}

procedure TFgrapheFFT.VersLatex(const NomFichier : string);
begin
    if PaintBoxTemps.visible then begin
         grapheTemps.withDebutFin := true;
         grapheTemps.versLatex(nomFichier,'T');
         grapheTemps.withDebutFin := false;
    end;
    if not SonagrammeBtn.down then
         grapheFrequence.versLatex(nomFichier,'F')
end;

procedure TFGrapheFFT.FrequenceMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);

procedure AffichePosition;
var xPos,yPos : integer;
    Xr,Yr : double;

procedure PicProche;
var
  i,i1,i2 : integer;
  deltaX,X1,X2 : double;
begin with grapheFrequence do
//  if (courbeCourante<0) or (courbeCourante>=courbes.count) then courbeCourante := 0;
  with courbes[CourbeCourante] do begin
  deltaX := (monde[mondeX].maxi-monde[mondeX].mini)/256;
  mondeRT(xPos,yPos, iMondeC, xr, yr);
  X1 := xr-deltaX;
  if X1<monde[mondeX].mini then X1 := monde[mondeX].mini;
  X2 := xr+deltaX;
  if X2>monde[mondeX].maxi then X2 := monde[mondeX].maxi;
  i1 := debutC-1;
  repeat
      inc(i1);
  until (valX[i1]>=X1);
  i2 := finC+1;
  repeat
      dec(i2);
  until (i1=i2) or (valX[i2]<=X2);
  i := (i1+i2) div 2;
  if i>=Pages[pageCourante].nmes then exit;  // débordement ??
  xr := valX[i];
  yr := valY[i];
  for i := i1 to i2 do begin
      if valY[i] > yr then begin
          xr := valX[i];
          yr := valY[i];
      end;
  end;
  if yr<monde[imondeC].maxi/128 then yr := monde[imondeC].mini;
  windowRT(xr,yr, iMondeC, xPos, yPos);
end end;

var XX,YY : string;
    decale : integer;
begin  // AffichePosition
with GrapheFrequence do begin
      if not(monde[mondeX].defini) or not(monde[mondeY].defini) then exit;
      Ypos := y; xPos := x;
      mondeRT(XPos,YPos,mondeY,Xr,Yr);
      if SonagrammeBtn.down
         then XX := courbes.items[courbeCourante].varX.formatNomEtUnite(xr)
         else XX := grandeurs[cFrequence].FormatNomEtUnite(xr);
      if SonagrammeBtn.down
      then begin
          yr := round(yr/pasFreqSonagramme)*pasFreqSonagramme;
          YY := courbes.items[courbeCourante].varY.formatNomEtUnite(yr);
      end
      else begin
          PicProche;
          XX := grandeurs[cFrequence].FormatNomEtUnite(xr);
          if monde[mondeY].graduation=gdB
              then YY := courbes.items[courbeCourante].varY.nom+'='+
                      floatToStrF(20*log10(yr),ffGeneral,3,0)+' dB'
              else YY := courbes.items[courbeCourante].varY.formatNomEtUnite(yr);
      end;
      if curseurF=curReticuleF then begin
         decale := PaintBoxFrequence.Top+4;
         labelX.transparent := false;
         labelY.transparent := false;
         labelX.caption := ' '+XX+' ';
         labelY.caption := ' '+YY+' ';
         labelX.top := limiteCourbe.bottom+decale;
         labelY.top := yPos-12+decale;
         labelY.left := limiteFenetre.left+4;
         labelX.left := xPos-(labelX.width div 2);
     end;
     AffecteStatusPanel(valeurCouranteH,2,pad(XX,25));
     AffecteStatusPanel(ValeurCouranteH,3,Pad(YY,25));
end end; // AffichePosition

var deplacement,isMaxi : boolean;
    hintLoc : string;
    deltaM : double;
begin  // FrequenceMouseMove
   if not grapheFrequence.grapheOK then exit;
   deplacement := ssLeft in Shift;
   hintLoc := hClicDroit;
   with PaintBoxFrequence do
   case curseurF of
        curZoomF : if zoomEnCours then begin
            grapheFrequence.RectangleGr(rectDeplace); // efface l'ancien
            rectDeplace.right := X;
            if SonagrammeBtn.down then rectDeplace.bottom := Y;
            grapheFrequence.RectangleGr(rectDeplace); // trace le nouveau
        end;
        curFmaxi : if abs(x-xCurseurEchelleFreq)>8 then begin
             grapheFrequence.changeEchelleX(x,xCurseurEchelleFreq,true);
             xCurseurEchelleFreq := x;
             PaintBoxFrequence.invalidate;
        end;
        curFmaxiSon : if abs(y-xCurseurEchelleFreq)>8 then begin
             changeEchelleSon(y,xCurseurEchelleFreq);
             xCurseurEchelleFreq := y;
        end;
        curReticuleF : begin
           grapheFrequence.TraceReticule(1); // efface
           affichePosition;
           grapheFrequence.curseurOsc[1].xc := x;
           grapheFrequence.curseurOsc[1].yc := y;
           grapheFrequence.TraceReticule(1); // nouvelle position
           hintLoc := stBarreReticuleFFT;
        end;
        curMoveF : if deplacement
        then begin
            with grapheFrequence.monde[mondeX] do begin
                 deltaM := (x-rectDeplace.left)/a;
                 if deltaM>mini then deltaM := mini; // ne pas dépasser f=0
                 mini := mini-deltaM;
                 maxi := maxi-deltaM;
                 defini := true;
            end;
            if abs(x-rectDeplace.left)>8 then begin
               paintBoxFrequence.invalidate;
               rectDeplace := rect(X,Y,X,Y);
            end;
        end
        else setCurseurF(curSelectF);
        curSelectF : if deplacement
                  then begin if grapheFrequence.dessinCourant<>nil then with grapheFrequence.DessinCourant do begin
                    if grapheFrequence.posDessinCourant=sdCadre
                      then begin
                         grapheFrequence.RectangleGr(rectDeplace); // efface
                         grapheFrequence.AffecteCentreRect(x,y,rectDeplace);
                         grapheFrequence.RectangleGr(rectDeplace);
                      end
                      else begin
                         grapheFrequence.LineGr(rectDeplace); // efface
                         affectePosition(x,y,grapheFrequence.posDessinCourant,shift);
                         rectDeplace := rect(x1i,y1i,x2i,y2i);
                         grapheFrequence.LineGr(rectDeplace);
                      end;
                  end // with dessinCourant
                  end // deplacement
                  else begin
                      grapheFrequence.SetDessinCourant(x,y);
                      AffichePosition;
                      if grapheFrequence.posDessinCourant<>sdNone then begin
                          cursor := crSize;
                          hintLoc := hGlisser;
                          if grapheFrequence.posDessinCourant=sdCadre then
                              hintLoc := hintLoc+hDbletexte;
                      end
                      else if grapheFrequence.isAxeX(x,y,isMaxi) and
                              not SonagrammeBtn.down
                         then begin
                            hintLoc := hEchelleFreq;
                            cursor := crHsplit;
                         end
                         else if SonagrammeBtn.down and
                                (x<grapheFrequence.limiteCourbe.left) then begin
                               hintLoc := hEchelleFreq;
                               cursor := crVsplit;
                         end
                         else cursor := crDefault;
                  end;
        curTexteF,curLigneF : if deplacement then
            with Canvas,grapheFrequence.dessinCourant do begin
                MoveTo(x1i,y1i);
                LineTo(x2i,y2i); // efface l'ancienne
                AffectePosition(x,y,sdPoint2,shift);
                MoveTo(x1i,y1i);
                LineTo(x2i,y2i);
           end;
   end; // case curseurF
   TgraphicControl(sender).hint := hintLoc;
end; // FrequenceMouseMove

procedure TFGrapheFFT.ZoomAvantItemClick(Sender: TObject);
begin
    zoomEnCours := false;
    setCurseurF(curZoomF);
end;

procedure TFGrapheFFT.SetCurseurF(c : TcurseurFrequence);
var i : integer;
begin with PaintBoxFrequence.Canvas do begin
  Pen.style := psSolid;
  Pen.mode := pmNotXor;
  Brush.style := bsClear;
  Brush.Color := clWindow;
  curseurF := c;
  case c of
       curZoomF : begin
          PaintBoxFrequence.cursor := crZoom;
          Pen.style := psDash;
       end;
       curFmaxi : begin
          PaintBoxFrequence.cursor := crHsplit;
       end;
       curFmaxiSon : begin
          PaintBoxFrequence.cursor := crVsplit;
       end;
       curTexteF : begin
          PaintBoxFrequence.cursor := crLettre;
          selectBtn.imageIndex := 25;
       end;
       curLigneF : begin
          PaintBoxFrequence.cursor := crPencil;
          selectBtn.imageIndex := 32;
       end;
       curReticuleF : begin
           PaintBoxFrequence.cursor := crNone;
           ReticuleItem.checked := true;
           selectBtn.imageIndex := 23;
           with grapheFrequence do begin
              for i := 1 to 3 do
                  curseurOsc[i].grandeurCurseur := monde[mondeY].axe;
              cCourant := 1;
           end;
           ligneRappelCourante := lrReticule;
       end;
       curSelectF : begin
          PaintBoxFrequence.cursor := crDefault;
          selectBtn.imageIndex := 26;
          StandardItem.checked := true;
       end;
       curMoveF : PaintBoxFrequence.cursor := crSizeAll;
    end;{case}
    labelX.Visible := curseurF=curReticuleF;
    labelY.Visible := curseurF=curReticuleF;
    LabelX.Color := fondReticule;
    LabelY.Color := fondReticule;
end end; // setCurseurF

procedure TFGrapheFFT.FrequenceMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var j : integer;
    isMaxi : boolean;
begin
   if grapheFrequence.grapheOK then with grapheFrequence do case curseurF of
       curZoomF : if not(zoomEnCours) and (sender=PaintBoxFrequence) then begin
            if SonagrammeBtn.down
               then rectDeplace := rect(X,Y,X,Y)
               else rectDeplace := rect(X,10,X,PaintBoxFrequence.height-10);
            zoomEnCours := true;
            RectangleGr(rectDeplace);
       end;
       curFmaxi,curFmaxiSon : ;
       curReticuleF : ;
       curSelectF : begin
           if (Button=mbRight) then begin
              grapheFrequence.SetDessinCourant(x,y);
              if dessinCourant=nil
                 then paintBoxFrequence.Popupmenu := popupmenufft
                 else paintBoxFrequence.Popupmenu := menuDessin;
              exit; // clic droit donc menu contextuel
           end;
          for j := 1 to grapheFrequence.NbreOrdonnee do
            SetDessinCourant(x,y);
            if dessinCourant<>nil then with dessinCourant do
               if posDessinCourant=sdcadre
                  then begin
                    rectDeplace := cadre;
                    RectangleGr(rectDeplace);
                  end
                  else begin
                      rectDeplace := rect(x1i,y1i,x2i,y2i);
                      LineGr(rectDeplace);
                  end;
           if curMovePermis and
              (dessinCourant=nil) then begin
                  setCurseurF(curMoveF);
                  rectDeplace := rect(X,Y,X,Y);
              end;
           if (dessinCourant=nil) and
               not SonagrammeBtn.down and
               isAxeX(x,y,isMaxi) then begin
                 xCurseurEchelleFreq := x;
                 SetCurseurF(curFmaxi);
            end;
           if SonagrammeBtn.down and
              (dessinCourant=nil) and
              (x<limiteCourbe.left) then begin
                 xCurseurEchelleFreq := y;
                 SetCurseurF(curFmaxiSon);
            end;
       end;
       curTexteF,curLigneF : if dessinCourant<>nil then
       with dessinCourant do  begin
           AffectePosition(x,y,sdPoint1,shift);
           x2i := x1i;
           y2i := y1i;
       end;
  end
end; // FrequenceMouseDown

procedure TFGrapheFFT.FrequenceMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

Procedure AffecteZoomLoc;
begin with grapheFrequence do begin
    RectangleGr(RectDeplace);// efface
    rectDeplace.right := X;
    with rectDeplace do
         if (right=left) then begin
            setCurseurF(CurSelectF);
            exit;
         end;
    AffecteZoomAvant(rectDeplace,SonagrammeBtn.down);
    monde[mondeX].ZeroInclus := false;
    monde[mondeX].defini := true;
    monde[mondeX].minDefaut := monde[mondeX].mini;
    monde[mondeX].maxDefaut := monde[mondeX].maxi;
    useDefautX := true;
    if SonagrammeBtn.down then begin
        monde[mondeY].ZeroInclus := false;
        monde[mondeY].defini := true;
        monde[mondeY].minDefaut := monde[mondeY].mini;
        monde[mondeY].maxDefaut := monde[mondeY].maxi;
    end;
    ZoomEnCours :=  false;
    curMovePermis := true;
    setCurseurF(CurSelectF);
    PaintBoxFrequence.invalidate;
end end; // affecteZoom

procedure AffecteDessin;
label fin;
begin
if grapheFrequence.dessinCourant<>nil then
with grapheFrequence.dessinCourant do begin
   with PaintBoxFrequence.Canvas do begin
        MoveTo(x1i,y1i);
        LineTo(x2i,y2i); // efface 
   end;
   if isTexte then if not litOption(grapheFrequence) then begin
      grapheFrequence.dessinCourant.free;
      goto fin;
   end
   else begin
        if (curseurF=curLigneF) and
           ((abs(x1i-x2i)+abs(y1i-y2i))<3) then begin
            afficheErreur(erLigneNulle,0);
            grapheFrequence.dessinCourant.free;
            goto fin;
        end;
   end;
   AffectePosition(x,y,sdPoint2,shift);
   GrapheFrequence.dessins.Add(grapheFrequence.DessinCourant);
   draw;
end;
   fin:
   grapheFrequence.dessinCourant := nil;
   setCurseurF(curSelectF);
end;

var P : Tpoint;
begin // FrequenceMouseUp
with grapheFrequence do begin
   if not grapheOK then exit;
   if Button=mbRight then begin
      P := PaintBoxFrequence.ClientToScreen(point(X,Y));
      if dessinCourant<>nil then MenuDessin.popUp(P.x,P.y);
      exit;
   end;
   case curseurF of
       curZoomF : if zoomEnCours then affecteZoomLoc;
       curFmaxi : begin
           changeEchelleX(x,xCurseurEchelleFreq,true);
           setCurseurF(curSelectF);
           PaintBoxFrequence.invalidate;
       end;
       curFmaxiSon : begin
           changeEchelleSon(y,xCurseurEchelleFreq);
           PaintBoxFrequence.invalidate;
           setCurseurF(curSelectF);
       end;
       curTexteF,curLigneF : AffecteDessin;
       curReticuleF : ;
       curMoveF : begin
          setCurseurF(curSelectF);
          monde[mondeX].defini := true;
          monde[mondeX].minDefaut := monde[mondeX].mini;
          monde[mondeX].maxDefaut := monde[mondeX].maxi;
          useDefautX := true;
       end;
       curSelectF : if reelClick
          then begin
             SetDessinCourant(x,y);
             if (dessinCourant<>nil) then begin
                dessinCourant.litOption(grapheFrequence);
                PaintBoxFrequence.invalidate;
                DessinCourant := nil;
              end;
          end
          else if dessinCourant<>nil then with dessinCourant do begin
               if posDessinCourant=sdCadre
                  then RectangleGr(rectDeplace)
                  else LineGr(rectDeplace);// efface
               AffectePosition(x,y,posDessinCourant,shift);
               dessinCourant := nil;
               paintBoxFrequence.invalidate;
         end;
  end;
  PointOld := point(X,Y);
  reelClick := false;
end end; // FrequenceMouseUp

procedure TFGrapheFFT.FormCreate(Sender: TObject);

procedure CreateAnim;
var i : integer;
begin
     InitManuelleAfaire := true;
     ActiverTimerAnim := false;
     maxParamAnimFFT := 0;
     with PanelAnimation do
        for i := 0 to pred(controlCount) do begin
           if (controls[i] is TgroupBox) and (controls[i].Tag>=0) then begin
              paramAnimManuelle[maxParamAnimFFT].GroupBoxF := TgroupBox(controls[i]);
              paramAnimManuelle[maxParamAnimFFT].GroupBoxF.OnClick := GroupBoxAnimClick;
              paramAnimManuelle[maxParamAnimFFT].GroupBoxF.OnDblClick := GroupBoxAnimDblClick;
              paramAnimManuelle[maxParamAnimFFT].GroupBoxF.tag := maxParamAnimFFT;
              paramAnimManuelle[maxParamAnimFFT].SliderF := TtrackBar(TGroupBox(controls[i]).controls[0]);
              paramAnimManuelle[maxParamAnimFFT].SliderF.Tag := maxParamAnimFFT;
              paramAnimManuelle[maxParamAnimFFT].SliderF.onChange := AnimSliderChange;
              inc(maxParamAnimFFT);
           end;
     end;
     paramAnimCourant := 0;
end;

var i : TindiceOrdonnee;
begin
  MajFichierEnCours := true;
  PanelCourbe.DoubleBuffered := True; // pour pas de scintillement ? mais toolBar noire
  enveloppeSpectre := false;
  AvecPoint := true;
  razSon := true;
  reelClick := false;
  CurseurGrid.ColWidths[0] := largeurUnCarac*8;
  CurseurGrid.ColWidths[1] := largeurUnCarac*8;
  CurseurGrid.width := largeurUnCarac*17;
  ListeY := TstringList.Create;
  for i := Low(TindiceOrdonnee) to High(TindiceOrdonnee) do
      listePic[i] := TlistePic.Create;
  GrapheFrequence := TgrapheReg.create;
  GrapheFrequence.optionGraphe := [OgPseudo3D];
  GrapheFrequence.canvas := PaintBoxFrequence.canvas;
  GrapheFrequence.paintBox := PaintBoxFrequence;
  GrapheFrequence.labelYcurseur := labelY;
  GrapheFrequence.modif := [gmXY];
  MajRaiesAfaire := true;
  curseurF := curSelectF;
  curseurT := curNormal;
  GrapheTemps := TgrapheReg.create;
  GrapheTemps.Monde[MondeX].zeroInclus := false;
  GrapheTemps.paintBox := PaintBoxTemps;
  GrapheTemps.canvas := PaintBoxTemps.canvas;
  setLength(FrequenceV,MaxVecteurDefaut+1);
  setLength(AmplitudeV,MaxVecteurDefaut+1);
  if (NbreGrandeurs>0) and
     (nomGrandeurTri='') and
     (grandeurs[cFrequence].nom='f') then begin
       if grandeurs[indexTri].nom='f' then grandeurs[cFrequence].nom := 't';
       if grandeurs[indexTri].nom=lambdaMin then grandeurs[cFrequence].nom := sigmaMin;
   end;
   OptionsFFTdlg := TOptionsFFTdlg.Create(self);
   PaintBoxFrequence.canvas.copyMode := cmSrcCopy;
   PaintBoxTemps.canvas.copyMode := cmSrcCopy;
   PaintBoxTemps.height := HauteurInitTemps;
   FaussesCouleursCB.Checked := UseFaussesCouleurs;
   FenetrageBtn.imageIndex := IconeW[fenetre];
   PasSonAffEdit.text := formatReg(pasSonagrammeAff);
   PasSonCalculSE.value := pasSonCalcul;
   freqMaxEdit.text := formatReg(freqMaxSonagramme);
   freqMaxSonUD.position := round(freqMaxSonagramme);
   freqMaxSonUD.increment := round(freqMaxSonagramme/10);
   ValeursGrid.DefaultRowHeight := hauteurColonne;
   CurseurGrid.DefaultRowHeight := hauteurColonne;
   VirtualImageList1.height := VirtualImageListSize;
   VirtualImageList1.width := VirtualImageListSize;
   createAnim;
end;

procedure TFGrapheFFT.SetCoordonnee;

procedure SetCoordonneeFFT;
var indexY : integer;
    decale : integer;
    indicePic : TindiceOrdonnee;
    avecEnveloppe : boolean;
    freqMax : double;

Procedure AjouteFFT(Acouleur : Tcolor;Apage,colF : integer;Amonde : TindiceMonde);
var Ay,Ax : Tvecteur; // sert au graphe et au tableau
    AmplitudeMax : double;

Procedure InitGrid(nbre : integer);
begin with valeursGrid,pages[PageCourante] do begin
      defaultColWidth := largeurUnCarac*8;
      colCount := 2*listeY.count;
      if RowCount<3 then RowCount := 3;
      col := 1;
      row := 2;
      Cells[2*colF,0] := grandeurs[cFrequence].nom;
      with Grandeurs[cFrequence] do begin
           try
           puissAff := 3*floor(log10(Ax[pred(Nbre)])/3);
           except
           puissAff := 0;
           end;
           CoeffAff := dix(-puissAff);
           Cells[2*colF,1] := NomAff(PuissAff);
           Cells[2*colF,2] := '0';
      end;
      with grandeurs[indexY] do begin
           Cells[2*colF+1,1] := NomAff(puissAff);
           Cells[2*colF+1,0] := nom;
      end;
      listePic[indicePic].clear;
end end; // InitGrid

Procedure RemplitColonne(colCourante : integer;nbre : integer);
var ligne,ligne0 : integer;
    maxiA,z : double;
    i,i0 : integer;
begin with valeursGrid,pages[Apage] do begin
      initGrid(nbre);
      colCourante := 2*colCourante+1;
      i0 := getFondamental(Nbre,Ay);
      maxiA := Ay[i0]*precisionFFT;
      ligne0 := i0 div 8;
      if ligne0=0 then ligne0 := 1;
      listePic[indicePic].index := indexY;
      if avecPeriode and (fenetre=rectangulaire)
      then begin
         for ligne := succ(ligne0) to (Nbre-2) do begin
           z := Ay[ligne];
           if z>maxiA then listePic[indicePic].Add(ax[ligne],z);
         end;
      end
      else begin
         for ligne := succ(ligne0) to (Nbre-2) do begin
            z := Ay[ligne];
            if (z>maxiA) and (z>Ay[ligne-1]) and (z>Ay[ligne+1])
              then listePic[indicePic].Add(ax[ligne],z);

         end;
      end;
      listePic[indicePic].Nettoie(FreqMax);
      if listePic[indicePic].nbre>128 then begin
          listePic[indicePic].TriValeurDecroissante;
          listePic[indicePic].TriFrequenceCroissante;
      end;
      if valeursGrid.RowCount<listePic[indicePic].nbre+3 then
          valeursGrid.RowCount := listePic[indicePic].nbre+3;
      valeursGrid.Cells[colCourante,2] :=
             grandeurs[indexY].FormatNombre(Ay[0]*grandeurs[indexY].coeffAff);
      valeursGrid.Cells[colCourante-1,2] := 'DC';
      for i := 0 to pred(listePic[indicePic].nbre) do begin
           valeursGrid.Cells[colCourante,i+3] :=
               grandeurs[indexY].FormatNombre(listePic[indicePic].picsH[i]*grandeurs[indexY].coeffAff);
           valeursGrid.Cells[colCourante-1,i+3] :=
               Grandeurs[cFrequence].FormatNombre(listePic[indicePic].picsF[i]*Grandeurs[cFrequence].coeffAff);
      end;
      listePic[indicePic].TriValeurDecroissante; // selon la valeur alors que le remplissage est selon la fréquence
end end; // RemplitColonne

Procedure AjouteCourbeFreq(var Nbre : integer);
var Acourbe : Tcourbe;

Procedure AddCourbe;
begin with GrapheFrequence do begin
     Acourbe := AjouteCourbe(Ax,Ay,Amonde,
         Nbre,
         grandeurs[cFrequence],grandeurs[indexY],Apage);
     monde[Amonde].graduation := monde[mondeY].graduation;
     monde[Amonde].MinidB := monde[mondeY].MinidB;
     Acourbe.setStyle(Acouleur,psSolid,mCroix);
     if continuInclus
        then Acourbe.debutC := 0
        else Acourbe.debutC := 1;
     Acourbe.decalage := decale;
end end; // AddCourbe

var i : integer;
    harmMax : double;
begin // AjouteCourbeFreq
     if grandeurs[indexY].fonct.genreC<>g_definitionFiltre then begin
          if NbreHarmoniqueOptimise then begin
                harmMax := precisionFFT*AmplitudeMax;
                while (Ay[Nbre]<harmMax) do dec(Nbre);
                Nbre := Puiss2Sup(Nbre);
          end;
          if freqMax<Ax[pred(Nbre)] then freqMax := Ax[pred(Nbre)];
// en cas de zoom (avec non puissance de 2)
// soit zero padding et donc la période de calcul est plus grande que la période affichée
// soit extrapolation et donc la fréquence d'échantillonage (et donc le maxi de freq) est
// plus grande que celle initiale
     end;
     if ordonneeFFTgr=oReduite then
         for i := 1 to pred(Nbre) do
             Ay[i] := Ay[i]/AmplitudeMax;
     if ordonneeFFTgr=oPuissance then
         for i := 0 to pred(Nbre) do
             Ay[i] := sqr(Ay[i]);
     AddCourbe;
     Acourbe.Adetruire := true;
     if (grandeurs[indexY].fonct.genreC=g_definitionFiltre) or
        (grapheFrequence.monde[mondeY].graduation=gdB)
        then Acourbe.trace := [trLigne]
        else begin
           Acourbe.trace := [trPoint];
           Acourbe.motif := mSpectre;
        end;
end; // AjouteCourbeFreq

Procedure AjouteCourbeEnv;
var Acourbe : Tcourbe;
    i,Nbre,maxi : integer;
    envAmpl,envFreq : Tvecteur;
begin // AjouteCourbeEnv
     with pages[Apage] do begin
         Maxi := 16*NbreFFT;
         if Maxi>MaxMaxVecteur then Maxi := MaxMaxVecteur;
         if Maxi<4096 then Maxi := 4096;
         setlength(envFreq,Maxi);
         setlength(envAmpl,Maxi);
         enveloppeFourier(NbreFFT,Maxi,PeriodeFFT,fenetreFourier[indexY],envFreq,envAmpl);
         Nbre := Maxi div 2;
     end;
     Acourbe := GrapheFrequence.AjouteCourbe(envFreq,envAmpl,Amonde,Nbre,
         grandeurs[cFrequence],grandeurs[indexY],Apage);
     Acourbe.setStyle(Acouleur,psSolid,mLosange);
     if ordonneeFFTgr=oReduite then
         for i := 0 to pred(Nbre) do
             envAmpl[i] := envAmpl[i]/amplitudeMax;
     if ordonneeFFTgr=oPuissance then
         for i := 0 to pred(Nbre) do
             envAmpl[i] := sqr(envAmpl[i]);
     Acourbe.decalage := decale;
     i := 0;
     if not continuInclus then begin
        repeat inc(i)
        until (i>Nbre div 64) or (envAmpl[i]>envAmpl[i-1]) or (envAmpl[i]<amplitudeMax);
           // fin du pic continu
     end;
     Acourbe.debutC := i;
     Acourbe.trace := [trLigne];
     Acourbe.Adetruire := true;
     if Apage=pageCourante then listePic[indicePic].cherchePicEnv(envAmpl,envFreq,FreqMax);
end; // AjouteCourbeEnv

Procedure AjouteCourbeTemps;
var Acourbe : Tcourbe;
begin
if grandeurs[indexY].fonct.genreC=g_definitionFiltre then exit;
with Pages[Apage] do begin
     If Fenetre in [Hamming,Flattop,Blackman] then begin
        Acourbe := GrapheTemps.AjouteCourbe(valeurLisse[indexTri],fenetreFourier[indexY],
            Amonde,NbreFFT,grandeurs[indexTri],grandeurs[indexY],Apage);
        Acourbe.setStyle(GetCouleurPale(Acouleur),psSolid,mCroix);
        Acourbe.trace := [trLigne];
     end;
     Acourbe := GrapheTemps.AjouteCourbe(valeurVar[indexTri],valeurVar[indexY],
            Amonde,Nmes,grandeurs[indexTri],grandeurs[indexY],Apage);
     Acourbe.setStyle(Acouleur,psSolid,mCroix);
     Acourbe.trace := [trLigne];
end end;

var i,nbre : integer; // ajouteFFT
begin with GrapheFrequence,pages[Apage] do begin
     tri;
     genereSpectreFourierP(indexY);
     if fftReel[indexY]=nil then exit;
     setLength(Ay,NbreFFT div 2 +1);
     for i := 0 to pred(NbreFFT div 2) do
         AY[i] := fftAmpl[indexY,i];
     setLength(Ax,NbreFFT div 2+1);
     copyVecteur(Ax,grandeurs[cFrequence].valeur);
     AmplitudeMax := getMaxiFFT(NbreFFT div 2,fftAmpl[indexY]);
     if (colF=0) and (Apage=pageCourante) then if (Ay[0]>AmplitudeMax/128)
        then AffecteStatusPanel(ValeurCouranteH,0,
           stContinu+grandeurs[indexY].FormatNomEtUnite(Ay[0]))
        else AffecteStatusPanel(ValeurCouranteH,0,'');
     avecEnveloppe := enveloppeSpectre and
            (NbreFFT<(MaxMaxVecteur div 2));
     Nbre := NbreFFT div 2;
     AjouteCourbeFreq(nbre);
     AjouteCourbeTemps;
     if avecEnveloppe
        then AjouteCourbeEnv
        else if Apage=pageCourante
             then RemplitColonne(colF,nbre);
     inc(decale,decalageFFT);
end end; // ajouteFFT

var
  j : integer;
  p : integer;
  mondeLoc : TindiceMonde;
begin // SetCoordonneeFFT
    freqMax := 0;
    mondeLoc := mondeY;
    valeursGrid.RowCount := 3;
    courbeCourante := 0;
    with GrapheFrequence do begin
       decale := 0;
       for j := 1 to maxOrdonnee do
           Coordonnee[j].iMondeC := mondeY;
       NbreOrdonnee := listeY.count;
       if NbreOrdonnee>MaxOrdonnee then NbreOrdonnee := MaxOrdonnee;
       for j := 1 to NbreOrdonnee do begin
           coordonnee[j].nomY := ListeY[j-1];
           indexY := IndexNom(listeY[j-1]);
           if j=1 then indexFonction := indexY;
           indicePic := j;
           if superposePage and (NbrePages>1)
             then begin
                for p := 1 to NbrePages do
                  if pages[p].active then begin
                      AjouteFFT(getCouleurPages(p),p,p*(j-1),mondeLoc);
                      if p=pageCourante then courbeCourante := pred(courbes.Count);
                      if OgAnalyseurLogique in OptionGraphe then inc(mondeLoc);
                  end;
             end
             else begin
                AjouteFFT(couleurInit[j],pageCourante,j-1,MondeLoc);
                if OgAnalyseurLogique in OptionGraphe then inc(mondeLoc);
             end;
        end;
        grapheOK := true;
        if freqMax>0 then begin
           if (gmXY in modif)
              then begin
                 monde[mondeX].defini := false;
                 monde[mondeX].mini := 0;
                 monde[mondeX].maxi := freqMax;
                 monde[mondeX].minDefaut := 0;
                 monde[mondeX].maxDefaut := freqMax;
                 useDefautX := false;
                 MaJTempsAfaire := tempsBtn.down;
              end
              else if not UseDefautX then begin
                  monde[mondeX].mini := 0;
                  monde[mondeX].maxi := freqMax;
              end;
           if not useDefautX then
              for j := 0 to pred(courbes.count) do with courbes[j] do
                  finC := round(finC*freqMax/valX[finc]);
        end;
        modif := [];
    end; // GrapheFrequence
    valeursGrid.Row := 2;
    valeursGrid.Col := 0;
    with grapheTemps do begin
       grapheOK := true;
       modif := [];
    end; // GrapheTemps
    MajRaiesAfaire := true;
    optionsSonagramme.visible := false;
    optionsBtn.enabled := true;
    fenetrageBtn.enabled := true;
    tableauBtn.enabled := true;
    limitesBtn.enabled := true;
    NbreHarmAffSpin.enabled := true;
    zoomBtn.enabled := true;
    zoomAutoBtn.enabled := true;
    NbreHarmAffSpin.Hint := hNbreHarm;
end; // SetCoordonneeFFT

procedure SetCoordonneeSonagramme;
var indexY : integer;

Procedure AjouteCourbeSonagramme;
var Acourbe : Tcourbe;
begin with Pages[pageCourante] do begin
     if not decibelCB.checked then DecadeDB := 0; // linéaire
     finFFT := pred(nmes);
     debutFFT := 0;
     indexSonagramme := indexY;
     calculSonagramme;
     Acourbe := GrapheFrequence.AjouteCourbe(
         valeurVar[indexTri],
         grandeurs[cFrequence].valeur,mondeY,Nmes,
         grandeurs[indexTri],grandeurs[cFrequence],pageCourante);
     grapheFrequence.monde[mondeY].graduation := gLin;
     Acourbe.trace := [trSonagramme];
     GrapheFrequence.useDefautX := false;
end end; // AjouteCourbeSonagramme;

var Acourbe : Tcourbe;
begin // SetCoordonneeSonagramme
    with GrapheFrequence do begin
       Coordonnee[1].iMondeC := mondeY;
       NbreOrdonnee := 1;
       coordonnee[1].nomY := ListeY[0];
       indexY := IndexNom(listeY[0]);
       AjouteCourbeSonagramme;
       exclude(OptionGraphe,OgAnalyseurLogique);
       grapheOK := true;
       courbes[0].finC := pred(pages[pageCourante].nmes);
       modif := [];
    end; // GrapheFrequence
    with grapheTemps do begin
       Acourbe := GrapheTemps.AjouteCourbe(pages[pageCourante].valeurVar[indexTri],
                  pages[pageCourante].valeurVar[indexY],
                  mondeY,pages[pageCourante].Nmes,
                  grandeurs[indexTri],grandeurs[indexY],pageCourante);
       Acourbe.setStyle(couleurInit[1],psSolid,mCroix);
       Acourbe.trace := [trLigne];
       grapheOK := true;
       modif := [];
    end; // GrapheTemps
    MajRaiesAfaire := true;
    optionsSonagramme.visible := true;
    optionsBtn.enabled := false;
    fenetrageBtn.enabled := false;
    tableauBtn.enabled := false;
    limitesBtn.enabled := false;
    zoomBtn.enabled := false;
    zoomAutoBtn.enabled := false;
    NbreHarmAffSpin.Hint := erSonagramme;
end; // SetCoordonneeSonagramme

procedure VerifListe;
var i,j,jmax,codeY : integer;
    nomY : string;
    bouton : TToolButton;
begin
   i := 0;
   while i<ListeY.count do begin
       codeY := indexNom(ListeY[i]);
       if (codeY=grandeurInconnue) or
          (codeY=0) or // 0=temps
          (grandeurs[codeY].genreG<>variable)
          then ListeY.delete(i)
          else inc(i)
   end;
   if ListeY.Count=0 then begin
        nomY := '';
        if FgrapheVariab.graphes[1].courbes.count>0
           then nomY := FgrapheVariab.graphes[1].courbes[0].varY.nom;
        if nomY='' then nomY := grandeurs[indexVariab[1]].nom;
        ListeY.add(nomY);
   end;
   jmax := pred(NbreVariab);
   if jmax>=ToolBarGrandeurs.ButtonCount
      then jmax := ToolBarGrandeurs.ButtonCount-1;
   for j := 0 to jmax do begin
       bouton := ToolBarGrandeurs.Buttons[j];
       bouton.down := false;
       for i := 0 to pred(listeY.count) do
          if listeY[i]=bouton.caption then begin
               bouton.down := true;
               break;
          end;
   end;
end;

begin // SetCoordonnee
     DefinitGrandeurFrequence;
     if gmXY in grapheFrequence.modif
        then begin
           if sonagrammeBtn.down then tempsBtn.down := true;
           GrapheTemps.raz;
           GrapheFrequence.raz;
           if sonagrammeBtn.down then begin
              GrapheFrequence.monde[mondeX].ZeroInclus := false;
              GrapheFrequence.monde[mondeY].ZeroInclus := true;
           end;
        end
        else begin
           GrapheTemps.courbes.clear;
           GrapheFrequence.courbes.clear;
        end;
     if NbreVariab<2 then begin
        afficheErreur(erNbreVarInf2,0);
        exit;
     end;
     VerifListe;
     if sonagrammeBtn.down
        then SetCoordonneeSonagramme
        else SetCoordonneeFFT;
     tempsItemClick(nil);
end; // SetCoordonnee

procedure TFGrapheFFT.FormResize(Sender: TObject);
begin
    curseurGrid.Top := PanelCourbe.Top;
    curseurGrid.Height := (curseurGrid.rowCount+1)*curseurGrid.rowHeights[1];
    curseurGrid.Left := PanelCourbe.Left+PanelCourbe.width-CurseurGrid.width;
    if animationBtn.down and not majFichierEnCours then majGrapheFFT
end;

procedure TFGrapheFFT.zoomAutoItemClick(Sender: TObject);
var i,j : integer;
begin with GrapheFrequence do begin
     monde[mondeX].defini := false;
     monde[mondeX].ZeroInclus := true;
     curMovePermis := false;
     useDefautX := false;
     useDefaut := false;
     for i := 0 to pred(courbes.count) do
         with courbes.items[i] do begin
           if continuInclus
              then debutC := 0
              else debutC := 1;
           j := 0;
           repeat inc(j) until valY[j]=0;
           finC := j-1;
           if trace=[trLigne] then // cas de la courbe enveloppe à traiter
              finC := MaxMaxVecteur div 2;
     end;
     PaintBoxFrequence.invalidate
end end;

procedure TFGrapheFFT.WMRegMaj(var Msg : TWMRegMessage);

procedure FaireMajFichier;

Procedure SetAnim;
var i : integer;
begin
       if NbreConstExp>maxParamAnimFFT
          then NbreParamAnim := MaxParamAnimFFT
          else NbreParamAnim := NbreConstExp;
       for i := 0 to pred(NbreParamAnim) do with paramAnimManuelle[i] do begin
           codeA := indexConstExp[i];
           GroupBoxF.caption := grandeurs[codeA].formatNomEtUnite(valeurA)+
                  ' ['+formatReg(debutA)+','+formatReg(finA)+']';
           SliderF.visible := active;
           if active
              then GroupBoxF.height := 48
              else GroupBoxF.height := 24;
           if variationLog
              then SliderF.position := round(log10(valeurA/debutA)/log10(pasA))
              else SliderF.position := round((valeurA-debutA)/pasA);
           GroupBoxF.visible := true;
       end;
       for i := NbreParamAnim to pred(maxParamAnimFFT) do
           paramAnimManuelle[i].GroupBoxF.visible := false;
end; // SetAnim

begin
       if (WindowState=wsMinimized) and
          (dispositionFenetre<>dNone) then WindowState := wsNormal;
       FenetrageBtn.imageIndex := IconeW[fenetre];
       GrapheFrequence.Modif := [gmXY];
       avecPeriode := false;
       MajFichierEnCours := false;
       configCharge := true;
       panelAnimation.Visible := animationBtn.down;
       if animationBtn.down then setAnim;
end;

begin with msg do begin
      GrapheFrequence.Modif := [];
      case TypeMaj of
          MajVide : begin
             majFichierEnCours := true;
             cacheAnimation;
             exit;
          end;
          MajChangePage,majSupprPage : if not grapheFrequence.superposePage then
              GrapheFrequence.Modif := [gmValeurs];
          MajSelectPage : if codeMaj<>0 then begin
              GrapheTemps.SuperposePage := CodeMaj>1;
              GrapheFrequence.SuperposePage := CodeMaj>1;
              GrapheFrequence.Modif := [gmValeurs];
          end;
          MajGroupePage : GrapheFrequence.Modif := [gmValeurs];
          MajGrandeur : begin
               if majFichierEnCours then FaireMajFichier;
               AffecteToolBar;
               GrapheFrequence.Modif := [gmXY];
          end;
          MajSuperposition : PaintBoxFrequence.invalidate;
          MajTri : if active then exit else GrapheFrequence.Modif := [gmValeurs];
          MajFichier : if majFichierEnCours then FaireMajFichier;
          MajValeur,MajValeurConst : begin
              if majFichierEnCours
                 then FaireMajFichier
                 else GrapheFrequence.Modif := [];
              include(GrapheFrequence.Modif,gmValeurs);
          end;
      end;
      if GrapheFrequence.Modif<>[] then begin
         GrapheTemps.Modif := grapheFrequence.modif;
         MajGrapheFFT;
         if PaintBoxTemps.visible then PaintBoxTemps.Invalidate;
      end;
      RazSon := true;
end end; // WMRegMaj

procedure TFGrapheFFT.TableauItemClick(Sender: TObject);
begin
     GrapheFrequence.monde[mondeX].defini := false;
     refresh;
end;

procedure TFGrapheFFT.TempsItemClick(Sender: TObject);
var F : double;
begin with pages[pageCourante] do begin
     if (finFFT-debutFFT)>2048 // 1 seconde à 2 kHz
         then F := (finFFT-debutFFT)/(valeurVar[indexTri,finFFT]-valeurVar[indexTri,debutFFT])
         else F := 0;
     PlayBtn.Visible := tempsBtn.down;
     PlayBtn.Enabled := (F<1e5) and (F>2000);
     if F<2000 then PlayBtn.hint := hFreqBasse;
     if F>1e5 then PlayBtn.hint := hFreqHaute;
     if F=0 then PlayBtn.hint := hFreqNulle;
     refresh;
end end;

procedure TFGrapheFFT.FrequencePaint(Sender: TObject);

Procedure MajRaies;
var deltay : double;

Procedure TraceMarque(i : integer;j : TindiceOrdonnee);
var Dessin : Tdessin;
    xx,yy : double;
begin
    XX := listePic[j].picsF[i];
    if xx>GrapheFrequence.Monde[mondeX].maxi then exit;
    // pour éviter repliement ?
    YY := ListePic[j].picsH[i];
    Dessin := Tdessin.create(grapheFrequence);
    with Dessin do begin
            isTexte := true;
            avecLigneRappel := false;
            MotifTexte := mtNone;
            hauteur := 2;
            NumPage := 0;
            vertical := false;
            pen.color := grapheFrequence.coordonnee[j].couleur;
            identification := identRaie;
            x1 := xx;
            if grapheFrequence.monde[mondeY].graduation=gdB
              then yy := 1.03*yy
              else yy := yy+deltay;
            y1 := yy;
            x2 := xx;
            y2 := yy;
            if OgAnalyseurLogique in grapheFrequence.OptionGraphe then begin
               iMonde := mondeY+j-1;
            end;
            grapheFrequence.dessins.add(Dessin);
            if xx<1
               then texte.add(grandeurs[indextri].formatValeurEtUnite(1/xx))
               else texte.add(grandeurs[cFrequence].formatValeurEtUnite(xx));
      end;
      if j=1 then begin
      with grandeurs[cFrequence] do
         CurseurGrid.Cells[0,i+2] := formatNombre(XX*coeffAff);
      with grandeurs[listePic[j].index] do
         CurseurGrid.Cells[+1,i+2] := formatNombre(YY*coeffAff);
      end;
end; // TraceMarque

Procedure SupprTout;
var i : integer;
begin with grapheFrequence do begin
    i := 0;
    MajRaiesAfaire := false;
    curseurGrid.Visible := false;
    while (i<dessins.count) do
       if dessins[i].identification=identRaie
          then Dessins.remove(dessins[i])
          else inc(i);
end end;

var i,imax : integer;
    j : TindiceOrdonnee;
begin // MajRaies
    SupprTout;
    if (NbreHarmoniqueAff=0) or
       not(HarmoniqueAff) or
       SonagrammeBtn.down then exit;
    deltaY := grapheFrequence.monde[mondeY].maxi/32;
     // pour séparation verticale du texte
    iMax := listePic[1].NbreAff;
    CurseurGrid.RowCount := imax+2;
    with grandeurs[cFrequence] do begin
       CurseurGrid.Cells[0,0] := nom;
       CurseurGrid.Cells[0,1] := NomAff(PuissAff);
    end;
    with grandeurs[listePic[1].index] do begin
       CurseurGrid.Cells[1,0] := nom;
       CurseurGrid.Cells[1,1] := NomAff(PuissAff);
    end;
    for j := 1 to grapheFrequence.NbreOrdonnee do begin
        imax := listePic[j].nbreAff;
        for i := 0 to pred(imax) do traceMarque(i,j);
    end;
    curseurGrid.Visible := true;
    curseurGrid.Top := PanelCourbe.Top;
    curseurGrid.Height := (curseurGrid.rowCount+1)*curseurGrid.rowHeights[1];
    curseurGrid.Left := PanelCourbe.Left+PanelCourbe.width-CurseurGrid.width;
end; // MajRaies

var precFreq,pasFreq : double;
    i,indexMax : integer;
label finProc;
begin // FrequencePaint
if (pageCourante=0) or (NbrePages=0) or
   lectureFichier or lecturePage or grapheUtilise then exit;
if (pages[pageCourante].nmes<16) then begin
       PaintBoxFrequence.Canvas.textOut(PaintBoxFrequence.width div 2,
                                        PaintBoxFrequence.height div 2,
                                        erNmesInf16);
       exit;
end;
SonagrammeBtn.Enabled := pages[pageCourante].nmes > NbrePointsSonagramme*8;
if not SonagrammeBtn.Enabled then SonagrammeBtn.down := false;
if SonagrammeBtn.Enabled
   then SonagrammeBtn.hint := hSonagramme
   else SonagrammeBtn.hint := hNotSonagramme;
MajRaiesAfaire := MajRaiesAfaire or (HarmoniqueAffItem.checked<>HarmoniqueAff);
harmoniqueAff := HarmoniqueAffItem.checked;
with grapheFrequence do begin
        canvas := PaintBoxFrequence.canvas;
        limiteFenetre := PaintBoxFrequence.clientRect;
        superposePage :=  superposePage and (NbrePages>1);
        screen.cursor := crHourGlass;
        PaintBoxFrequence.canvas.brush.Color := clWindow;
        PaintBoxFrequence.canvas.brush.style := bsSolid;
        PaintBoxFrequence.canvas.FillRect(PaintBoxFrequence.clientRect);
        if modif<>[] then curseurF := curSelectF;
        if (gmXY in modif) or
           (gmEchelle in modif) or
           (gmValeurs in modif) or
           (pages[pageCourante].periodeFFT=0)
              then setCoordonnee;
        if (pages[pageCourante].periodeFFT=0) and
           not (sonagrammeBtn.down) then begin
             PaintBoxFrequence.Canvas.textOut(PaintBoxFrequence.width div 2,
                                              PaintBoxFrequence.height div 2,
                                              erNmesInf16);
             goto finProc;
        end;
        if not grapheOK or (courbes.count=0) then
           goto finProc;
        Brush.style := bsSolid;
        Brush.color := clWindow;
        if SonagrammeBtn.down then begin
           indexMax := round(FreqMaxSonagramme/pasFreqSonagramme);
           for i := 0 to indexMax do
               grandeurs[cFrequence].valeur[i] := i*pasFreqSonagramme;
           for i := succ(indexMax) to high(grandeurs[cFrequence].valeur) do
               grandeurs[cFrequence].valeur[i] := 0;
           NbreHarmAffSpin.enabled := false;
        end;
        chercheMonde;
        if MajRaiesAfaire then MajRaies;
        canvas.Pen.mode := pmCopy;
        grapheFrequence.draw;
        setCurseurF(curseurF);
        if active then case curseurF of
           curZoomF : if zoomEnCours then RectangleGr(rectDeplace);
           curFmaxi,curFmaxiSon : ;
           curReticuleF : traceReticule(1);
        end; // case curseurF
        try
        if SonagrammeBtn.down then begin
           AffecteStatusPanel(ValeurCouranteH,1,
                DeltaMaj+grandeurs[cFrequence].FormatNomEtUnite(pasFreqSonagramme))
        end
        else begin
           pasFreq := 1/pages[pageCourante].periodeFFT;
           PrecFreq := power(10,floor(log10(pasFreq))-1);
           pasFreq := precFreq*round(pasFreq/precFreq);
           AffecteStatusPanel(ValeurCouranteH,1,
                DeltaMaj+grandeurs[cFrequence].FormatNomEtUnite(pasFreq));
        end;
        except
        end;
        finProc :
        screen.cursor := crDefault;
        if MaJTempsAfaire then PaintBoxTemps.invalidate;
        Modif := [];
end end; // FrequencePaint

procedure TFGrapheFFT.TempsPaint(Sender: TObject);
var zut,finLoc : Integer;
begin // TempsPaint
if (pageCourante=0) or (pages[pageCourante].nmes<16) or
   (NbrePages=0) or LectureFichier or
   (PaintBoxTemps.height<2) or grapheUtilise then exit;
GrapheTemps.canvas := PaintBoxTemps.canvas;
with PaintBoxTemps.Canvas do begin
      if (gmXY in grapheTemps.modif) or
         (gmEchelle in grapheTemps.modif) or
         (gmValeurs in grapheTemps.modif) then setCoordonnee;
      if not grapheTemps.grapheOK then exit;
      Pen.mode := pmCopy;
      Pen.Color := GetCouleurPages(1);
      Brush.style := bsSolid;
      Brush.color := clWindow;
      FillRect(clientRect);
      grapheTemps.limiteFenetre := PaintBoxTemps.clientRect;
      grapheTemps.chercheMonde;
      with pages[pageCourante] do begin
          if finFFT<(nmes-2) then finLoc := finFFT+1 else finLoc := pred(nmes);
          // de manière  à ce que le graphe représente la durée
          // alors que le dernier point est à (durée - deltat)
          grapheTemps.windowXY(valeurVar[indexTri,finLoc],valeurVar[indexFonction,finLoc],mondeY,XfinInt,zut);
          grapheTemps.windowXY(valeurVar[indexTri,debutFFT],valeurVar[indexFonction,debutFFT],mondeY,XdebutInt,zut);
      end;
      grapheTemps.draw;
      TraceDebutFin;
      MajTempsAfaire := false;
end end; // TempsPaint

procedure TFGrapheFFT.FormPaint(Sender: TObject);
var avecDebutFin : boolean;
    largMin : integer;
begin
     if TempsBtn.down
        then begin // pas le même ordre !
             PaintBoxTemps.visible := true;
             SplitterTemps.visible := true;
             if (PaintBoxTemps.Height=HauteurInitTemps) or
                (PaintBoxTemps.Height=1) then
                          PaintBoxTemps.Height := Height div 3;
        end
        else begin
             SplitterTemps.visible := false;
             PaintBoxTemps.visible := false;
        end;
     if TableauBtn.down
        then with ValeursGrid do begin
             largMin := (7*DefaultColWidth) div 2;
             if width<largMin then width := largMin;
             valeursGrid.refresh;
        end
        else ValeursGrid.width := 1;
      avecDebutFin := tempsBtn.Down and
                      not(sonagrammeBtn.down);
      periodeFFTedit.enabled := avecDebutFin;
      periodeFFTedit.text := grandeurs[indexTri].FormatValeurEtUnite(pages[pageCourante].periodeFFT);
      finFFTspin.enabled := avecDebutFin;
      debutFFTspin.enabled := avecDebutFin;
      if avecDebutFin then curseurT := curNormal;
end;

Procedure TFGrapheFFT.TraceReference;
begin
     with Reference do
          PaintBoxTemps.Canvas.Rectangle(left,top,right,bottom);
end;

procedure TFGrapheFFT.AnimationBtnClick(Sender: TObject);
begin
   if (pageCourante=0) or (NbreConstExp=0) then exit;
   if AnimationBtn.down
      then begin
         setAnimation;
         PanelAnimation.visible := true;
         timerAnim.enabled := false;
         grapheFrequence.modif := [gmXY];
         grapheTemps.modif := [gmXY];
         MajGrapheFFT;
      end
      else cacheAnimation
end;

procedure TFGrapheFFT.AnimSliderChange(Sender: TObject);
var Aslider : TtrackBar;
    newValeur : double;
begin
    Aslider := (sender as  TtrackBar);
    GroupBoxAnimClick(Aslider.parent as TgroupBox);
    with ParamAnimManuelle[paramAnimCourant] do begin
        if variationLog
           then newValeur := debutA*power(pasA,Aslider.position)
           else newValeur := debutA+Aslider.position*pasA;
        if newValeur<>valeurA then begin
           valeurA := newValeur;
           calculeAnimation;
           FRegressiMain.AffValeurParametre;
        end;
    end;

end;

procedure TFGrapheFFT.AvanceBtnClick(Sender: TObject);
begin
     TimerAnim.enabled := false;
     paramSuivant;
end;

procedure TFGrapheFFT.AvanceRapideBtnClick(Sender: TObject);
begin
     DebutBtnClick(sender);
     Perform(WM_Reg_Animation,0,0)
end;

procedure TFGrapheFFT.FormDestroy(Sender: TObject);
var i : TindiceOrdonnee;
begin
    GrapheFrequence.Free ;
    GrapheTemps.Free;
    ListeY.Free;
    finalize(FrequenceV);
    finalize(AmplitudeV);
    OptionsFFTDlg.close;
    FGrapheFFT := nil;
    for i := Low(TindiceOrdonnee) to High(TindiceOrdonnee) do begin
       listePic[i].Clear;
       listePic[i].Free;
    end;
    inherited
end;

Procedure TFgrapheFFT.ecritConfig;

Procedure ecritAnimation;
var i : integer;
begin
      writeln(fichier,symbReg2,intToStr(3+NbreParamAnim*NbreItemParamAnim),' ANIMATION');
      writeln(fichier,NbreItemParamAnim);
      for i := 0 to pred(NbreParamAnim) do
          paramAnimManuelle[i].ecritFichier;
      writeln(fichier,NbreTickbar.position);
      writeln(fichier,ord(TitreAnimCB.checked));
end;

var i,NbreOrdonnee : integer;
begin
   NbreOrdonnee := listeY.count;
   if NbreOrdonnee<1 then exit;
   if NbreOrdonnee>MaxOrdonnee then NbreOrdonnee := MaxOrdonnee;
   writeln(fichier,symbReg2,NbreOrdonnee,' Y');
   for i := 0 to NbreOrdonnee-1 do
       ecritChaineRW3(listeY[i]);
   if animationBtn.down and (NbreParamAnim>0) then ecritAnimation;
   writeln(fichier,symbReg2,'1 F');
   ecritChaineRW3(grandeurs[cFrequence].nom);
   writeln(fichier,symbReg2,'18 '+stOptions);
   writeln(fichier,ord(grapheFrequence.SuperposePage));{1}
   writeln(fichier,ord(grapheFrequence.monde[mondeY].graduation));{2}
   writeln(fichier,ord(false));{3}
   writeln(fichier,grapheFrequence.monde[mondeY].MinidB);{4}
   writeln(fichier,Pages[pageCourante].nmes);{5}
   writeln(fichier,round(PrecisionFFT*1000));{6}
   writeln(fichier,ord(enveloppeSpectre));{7}
   writeln(fichier,ord(SonagrammeBtn.down));{8}
   writeln(fichier,ord(NbreHarmoniqueOptimise));{9}
   writeln(fichier,ord(OptionsFFTdlg.ordonneeFFT));{10}
   writeln(fichier,ord(continuInclus));{11}
   writeln(fichier,ord(TempsBtn.down));{12}
   writeln(fichier,SplitterTemps.top);{13}
   writeln(fichier,DecadeDB);{14}
   writeln(fichier,NbreHarmoniqueAff);{15}
   writeln(fichier,pasSonagrammeAff);{16}
   writeln(fichier,PasSonCalcul);{17}
   writeln(fichier,FreqMaxSonagramme);{18}
   for i := 0 to pred(GrapheFrequence.Dessins.count) do begin
       writeln(fichier,symbReg2,IntToStr(GrapheFrequence.dessins.items[i].NbreData)+' '+stDessin);
       GrapheFrequence.dessins.items[i].Store;
   end;
   if dispositionFenetre=dNone then begin
       writeln(fichier,symbReg2,'5 '+stFenetre);
       writeln(fichier,ord(windowState));
       writeln(fichier,top);
       writeln(fichier,left);
       writeln(fichier,width);
       writeln(fichier,height);
   end;
   PasSonAffEdit.text := formatReg(pasSonagrammeAff);
   PasSonCalculSE.value := pasSonCalcul;
end; // ecritConfig

Procedure TFgrapheFFT.ecritConfigXML(ANode : IXMLNode);
var i : integer;
begin
   listeY.delimiter := ' ';
   writeStringXML(ANode,'Y',listeY.DelimitedText);
   writeStringXML(ANode,'X',grandeurs[cFrequence].nom);
   writeBoolXML(ANode,'SuperPage',grapheFrequence.SuperposePage);
   writeIntegerXML(ANode,'Graduation',ord(grapheFrequence.monde[mondeY].graduation));
   writeIntegerXML(ANode,stFenetre,ord(fenetre));
   writeFloatXML(ANode,'MinidB',grapheFrequence.monde[mondeY].MinidB);
   writeIntegerXML(ANode,'PrecisionFFT',round(PrecisionFFT*1000));
   writeBoolXML(ANode,'EnveloppeSpectre',enveloppeSpectre);
   writeFloatXML(ANode,'PrecisionFFT',precisionFFT);
   writeBoolXML(ANode,'SonagrammeBtn',SonagrammeBtn.down);
   writeBoolXML(ANode,'NbreHarmOpt',NbreHarmoniqueOptimise);
   writeIntegerXML(ANode,'TypeOrdonnee',ord(OptionsFFTdlg.ordonneeFFT));
   writeBoolXML(ANode,'ContinuInclus',continuInclus);
   writeBoolXML(ANode,'TempsBtn',TempsBtn.down);
   writeIntegerXML(ANode,'DecadedB',DecadeDB);
   writeIntegerXML(ANode,'NbreHarmAff',NbreHarmoniqueAff);
   writeFloatXML(ANode,'PasSonagrammeAff',pasSonagrammeAff);
   writeIntegerXML(ANode,'PasSonCalcul',PasSonCalcul);
   writeIntegerXML(ANode,'HauteurTemps',PaintBoxTemps.height);
   writeFloatXML(ANode,'FreqMaxSonagramme',FreqMaxSonagramme);{18}
   for i := 0 to pred(GrapheFrequence.Dessins.count) do begin
   //    GrapheFrequence.dessins.ecritXML;
   end;
end; // ecritConfigXML

procedure TFGrapheFFT.EnregistrerItemClick(Sender: TObject);
begin
    saveDialog.options := saveDialog.options-[ofOverwritePrompt];
    if saveDialog.Execute then begin
       GrapheTemps.withDebutFin := true;
       grapheUtilise := true;
       GrapheTemps.VersFichier(saveDialog.fileName);
       GrapheTemps.withDebutFin := false;
       grapheUtilise := false;

    end;
end;

procedure TFGrapheFFT.EnregistrerSpectreItemClick(Sender: TObject);

procedure ecritUneCourbe(i : integer);
var fichier : textFile;
    j : integer;
    nomFichier : string;
begin
   nomFichier := saveDialogCSV.FileName;
   if i>0 then insert(IntToStr(i),nomFichier,length(nomFichier)-3);
   with grapheFrequence.courbes[i] do begin
      AssignFile(fichier,nomFichier);
      Rewrite(fichier);
      writeln(fichier,grandeurs[cFrequence].nom+','+varY.nom);
      writeln(fichier,grandeurs[cFrequence].nomUnite+','+varY.nomUnite);
      for j := debutC to finC do
          writeln(fichier,FloatToStrPoint(valX[j])+','+FloatToStrPoint(valY[j]));
      CloseFile(fichier);
   end;
end;

procedure ecritCourbes;
var fichier : textFile;
    i,j : integer;
begin
   AssignFile(fichier,saveDialogCSV.FileName);
   Rewrite(fichier);
   write(fichier,grandeurs[cFrequence].nom);
   for i := 0 to pred(grapheFrequence.courbes.Count)  do
       write(fichier,','+grapheFrequence.courbes[i].varY.nom);
   writeln(fichier);
   write(fichier,grandeurs[cFrequence].nomUnite);
   for i := 0 to pred(grapheFrequence.courbes.Count)  do
       write(fichier,','+grapheFrequence.courbes[i].varY.nomUnite);
   writeln(fichier);
   for j := grapheFrequence.courbes[0].debutC to grapheFrequence.courbes[0].finC do begin
       write(fichier,FloatToStrPoint(grapheFrequence.courbes[0].valX[j]));
       for i := 0 to pred(grapheFrequence.courbes.Count)  do
           write(fichier,','+FloatToStrPoint(grapheFrequence.courbes[i].valY[j]));
       writeln(fichier);
   end;
   CloseFile(fichier);
end;

var i : integer;
begin
   saveDialogCSV.title := 'Sauvegarde du spectre';
   if saveDialogCSV.Execute then
      if grapheFrequence.superposepage
          then for i := 0 to pred(grapheFrequence.courbes.Count) do
             ecritUneCourbe(i)
          else ecritCourbes
end;

procedure TFGrapheFFT.EnregistrerGrapheItemClick(Sender: TObject);
begin
   saveDialog.options := saveDialog.options-[ofOverwritePrompt];
   if saveDialog.Execute then begin
      grapheUtilise := true;
      GrapheFrequence.VersFichier(saveDialog.FileName);
      grapheUtilise := false;
   end;
end;

Procedure TFgrapheFFT.litConfig;
var imax : integer;
    lignesLues : boolean;

Procedure litAnimation;
var i,Nparam,Nitem,supplement,N : integer;
begin
     readln(fichier,Nitem);
     if Nitem=0 then exit;
     Nparam := imax div Nitem;
     supplement := imax mod Nitem;
     for i := 0 to pred(Nparam) do with paramAnimManuelle[i] do begin
         litFichier(Nitem);
         sliderA.max := sliderMaxValue;
         SliderA.lineSize := succ(sliderA.max div 8);
         SliderA.pageSize := succ(sliderA.max div 32);
     end;
     if supplement>1 then begin
         readln(fichier,N);
         NbreTickBar.position := N;
     end;
     if supplement>2 then
         titreAnimCB.checked := litBooleanWin;
     for i := (Nparam*Nitem+supplement+1) to imax do readln(fichier);
     AnimationBtn.down := true;
     grapheFrequence.useDefaut := false;
     initManuelleAfaire := true;
     lignesLues := true;
end;

var i,zint : integer;
    Adessin : Tdessin;
    zbyte : byte;
    zreel : double;
begin
  majFichierEnCours := true;
  while (Length(LigneWin)>0) and (ligneWin[1]=symbReg2) do begin
      imax := NbreLigneWin(ligneWin);
      lignesLues := false;
      if pos('Y',ligneWin)<>0 then for i := 1 to imax do begin
           litLigneWinU;
           if listeY.count<maxOrdonnee then listeY.add(ligneWin);
           lignesLues := true;
      end;
      if pos('ANIMATION',ligneWin)<>0 then litAnimation;
      if pos(stOptions,ligneWin)<>0 then begin
         grapheFrequence.SuperposePage := litBooleanWin; //1
         grapheTemps.SuperposePage := grapheFrequence.SuperposePage;
         readln(fichier,zint); //1
         grapheFrequence.monde[mondeY].graduation := Tgraduation(zint);
         litBooleanWin; //3
         readln(fichier,grapheFrequence.monde[mondeY].MinidB); //4
         if imax>=5 then readln(fichier);
         if imax>=6 then begin
            readln(fichier,zint);
            if zint<3 then zint := 10;
            precisionFFT := zint/1000;
         end;
         if imax>=7 then enveloppeSpectre := litBooleanWin;
         if imax>=8 then SonagrammeBtn.down := litBooleanWin;
         if imax>=9 then NbreHarmoniqueOptimise := litBooleanWin;
         if imax>=10 then begin
             readln(fichier,zint);
             OptionsFFTdlg.ordonneeFFT := TordonneeFFT(zint);
         end;
         if imax>=11 then continuInclus := litBooleanWin;
         if imax>=12 then TempsBtn.down := litBooleanWin;
         if imax>=13 then begin
            readln(fichier,zint);
            PaintBoxTemps.height := zint;
         end;
         if imax>=14 then begin
            readln(fichier,zint);
            DecadeDB := zint;
         end;
         if imax>=15 then begin
            readln(fichier,zint);
            NbreHarmoniqueAff := zint;
         end;
         if imax>=16 then readln(fichier,pasSonagrammeAff);
         if imax>=17 then begin
           readln(fichier,zreel);
           pasSonCalcul := round(zreel);
           if pasSonCalcul<1 then pasSonCalcul := 1;
           if pasSonCalcul>3 then pasSonCalcul := 3;
         end;
         if imax>=18 then readln(fichier,FreqMaxSonagramme);
         for i := 19 to imax do readln(fichier);
         lignesLues := true;
      end;
      if pos(stFenetre,ligneWin)<>0 then begin
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
              lignesLues := true;
      end;
      if not(lignesLues) and (pos('F',ligneWin)<>0) then begin
             litLigneWin;
             grandeurs[cFrequence].nom := ligneWin;
             lignesLues := true;
      end;
      if not(lignesLues) and (pos('MEMO',ligneWin)<>0) then
         for i := 1 to imax do begin
             litLigneWin;
             lignesLues := true;
         end;
      if not(lignesLues) and (pos(stDessin,ligneWin)<>0) then begin
            Adessin := Tdessin.create(grapheFrequence);
            Adessin.load;
            grapheFrequence.dessins.add(Adessin);
            lignesLues := true;
      end;
      if not lignesLues then for i := 1 to imax do readln(fichier);
      litLigneWin
   end;
end; // litConfig

Procedure TFgrapheFFT.litConfigXML;

procedure LoadXMLInReg(ANode: IXMLNode);

procedure Suite;
var i: Integer;
begin
if ANode.HasChildNodes then
   for I := 0 to ANode.ChildNodes.Count - 1 do
       LoadXMLInReg(ANode.ChildNodes.Nodes[I]);
end;

Function GetInteger : integer;
begin
     try
     result := StrToInt(ANode.text);
     except
        result := 0;
     end;
end;

var zint : integer;
begin
      if ANode.NodeName='Y' then begin
         listeY.Delimiter := ' ';
         listeY.DelimitedText := ANode.Text;
         exit;
      end;
      if ANode.NodeName='SuperPage' then begin
         grapheFrequence.SuperposePage := GetBoolXML(ANode);
         grapheTemps.SuperposePage := grapheFrequence.SuperposePage;
         exit;
      end;
      if ANode.NodeName='Graduation' then begin
         zint := GetInteger;
         grapheFrequence.monde[mondeY].graduation := Tgraduation(zInt);
         exit;
      end;
      if ANode.NodeName='MinidB' then begin
         grapheFrequence.monde[mondeY].MinidB := getFloatXML(ANode);
         exit
      end;
      if ANode.NodeName='PrecisionFFT' then begin
          PrecisionFFT := getFloatXML(ANode);
          exit
      end;
      if ANode.NodeName='EnveloppeSpectre' then begin
          enveloppeSpectre := getBoolXML(ANode);
          exit
      end;
      if ANode.NodeName='SonagrammeBtn' then begin
          SonagrammeBtn.down := getBoolXML(ANode);
          exit
      end;
      if ANode.NodeName='NbreHarmOpt' then begin
            NbreHarmoniqueOptimise := getBoolXML(ANode);
            exit
      end;
      if ANode.NodeName='azerty' then begin
           zint := GetInteger;
           OptionsFFTdlg.ordonneeFFT := TordonneeFFT(zint);
           exit
      end;
      if ANode.NodeName='ContinuInclus' then begin
          continuInclus := getBoolXML(ANode);
          exit;
      end;
      if ANode.NodeName='TempsBtn' then begin
            TempsBtn.down := getBoolXML(ANode);
            exit
      end;
     if ANode.NodeName='HauteurTemps' then begin
           PaintBoxTemps.height := getInteger;
           exit
     end;
     if ANode.NodeName=stFenetre then begin
           fenetre := TFenetre(getInteger);
           exit
     end;
     if ANode.NodeName='DecadedB' then begin
            DecadeDB := getInteger;
            exit
     end;
     if ANode.NodeName='NbreHarmAff' then begin
           NbreHarmoniqueAff := getInteger;
           exit;
     end;
     if ANode.NodeName='PasSonagrammeAff' then begin
         pasSonagrammeAff := GetFloatXML(ANode);
         exit
     end;
     if ANode.NodeName='PasSonCalcul' then begin
           pasSonCalcul := getInteger;
          if pasSonCalcul<1 then pasSonCalcul := 1;
          if pasSonCalcul>3 then pasSonCalcul := 3;
          exit
     end;
     if ANode.NodeName='FreqMaxSonagramme' then begin
           FreqMaxSonagramme := getFloatXML(ANode);
           exit;
     end;
     if ANode.NodeName='X' then begin
          grandeurs[cFrequence].nom := ANode.text;
          exit;
     end;
     if ANode.NodeName=stDessin then begin
           exit;
     end;
end;

var i : integer;
begin
    majFichierEnCours := true;
    if ANode.HasChildNodes then
       for I := 0 to ANode.ChildNodes.Count - 1 do
          LoadXMLInReg(ANode.ChildNodes.Nodes[I]);
end; // litConfigXML

procedure TFGrapheFFT.OptionsAnimBtnClick(Sender: TObject);
begin
    GroupBoxAnimDblClick(sender)
end;

procedure TFGrapheFFT.OptionsFourierItemClick(Sender: TObject);

Procedure SetCoordonneeFFT;
var i : integer;
    OldListeY : TstringList;
    ModifListe : boolean;
begin with GrapheFrequence do begin
           oldListeY := TstringList.Create;
           oldListeY.assign(listeY);
           ListeY.Clear;
           with OptionsFFTDlg.ListeVariableBox do begin
                for i := 0 to pred(items.count) do
                    if selected[i] and (listeY.count<maxOrdonnee)
                       then ListeY.Add(items[i]);
                if listeY.count=0 then ListeY.add(Items[0]);
           end;   // droite
           ModifListe := oldListeY.count<>listeY.count;
           if not modifListe then
              for i := 0 to pred(listeY.count) do
                  if listeY[i]<>oldListeY[i] then modifListe := true;
           if modifListe then include(modif,gmXY);
           oldListeY.Free;
end end;

var i : integer;
begin
    with OptionsFFTdlg do begin
          ActiverTimerAnim := false;
          timerAnim.enabled := false;
          if (sender=VariablesItem) then pageControl.ActivePage := OrdonneeTS;
          superPagesCB.checked := grapheFrequence.SuperposePage;
          ordonneeFFT := ordonneeFFTgr;
          OptionsFFTdlg.DecibelCB.Checked := not SonagrammeBtn.down and
                    (grapheFrequence.monde[mondeY].graduation=gdB);
          ContinuCB.checked := ContinuInclus;
          MiniDecibel := grapheFrequence.monde[mondeY].MinidB;
          with ListeVariableBox do begin
               Items.Clear;
               for i := 1 to pred(NbreGrandeurs) do with grandeurs[i] do
                  if (genreG=variable) and
                     (fonct.genreC<>g_texte) then Items.add(nom);
               for i := 0 to pred(items.count) do
                   selected[i] := listeY.indexOf(items[i])>=0;
          end;
          if OptionsFFTDlg.showModal=mrOK then begin
             FenetrageBtn.imageIndex := IconeW[fenetre];
             recalculFourierE;
             GrapheFrequence.modif := [gmEchelle];
             grapheFrequence.SuperposePage := superPagesCB.checked;
             grapheTemps.SuperposePage := grapheFrequence.SuperposePage;
             ContinuInclus := ContinuCB.checked;
             if OptionsFFTdlg.DecibelCB.checked and not SonagrammeBtn.down
                then grapheFrequence.monde[mondeY].graduation := gdB
                else grapheFrequence.monde[mondeY].graduation := gLin;
             grapheFrequence.monde[mondeY].MinidB := MiniDecibel;
             ordonneeFFTgr := ordonneeFFT;
             SetCoordonneeFFT;
             GrapheTemps.modif := GrapheFrequence.modif;
             HarmoniqueAffItem.checked := harmoniqueAff;
             separePeriodeBtn.visible := avecReglagePeriode;
             debutFFTspin.Visible := avecReglagePeriode;
             PeriodeFFTEdit.Visible := avecReglagePeriode;
             finFFTspin.Visible := avecReglagePeriode;
             MajGrapheFFT;
         end;
     end; // OptionsFourierItemClick
end;

procedure TFGrapheFFT.CopierTempsWMFClick(Sender: TObject);
begin
     GrapheTemps.withDebutFin := true;
     grapheUtilise := true;
     GrapheTemps.VersPressePapier(grapheClip);
     GrapheTemps.withDebutFin := false;
     grapheUtilise := false;
end;

procedure TFGrapheFFT.CouleursItemClick(Sender: TObject);
begin
     OptionCouleurDlg := TOptionCouleurDlg.create(self);
     OptionCouleurDlg.DlgGraphique := GrapheFrequence;
     if optionCouleurDlg.ShowModal=mrOK then refresh;
     OptionCouleurDlg.free;
end;

procedure TFGrapheFFT.PopupMenuFFTPopup(Sender: TObject);
begin
     SaveFreqItem.visible := curseurF=curReticuleF;
     ZoomManuel.checked := grapheFrequence.UseDefautX;
     SaveHarmitem.Visible := NbreHarmoniqueAff>6;
end;

procedure TFGrapheFFT.TempsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if Button=mbRight then exit;
   curseurT := curNormal;
   if abs(x-XfinInt)<margeDebutFin then curseurT := curFin;
   if abs(x-XdebutInt)<margeDebutFin then curseurT := curDebut;
   if (curseurT=curNormal) and
      (x>xDebutInt) and
      (x<xfinInt) then curseurT := curDeplace;
   case curseurT of
       curNormal : PaintBoxTemps.Cursor := crDefault;
       curDeplace : PaintBoxTemps.Cursor := crHandPoint;
       else PaintBoxTemps.Cursor := crHsplit;
   end;
   if curseurT<>curNormal then ChercheReference;
   Xdeplace := X;   
end;

procedure TFGrapheFFT.TempsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var DeltaMini,dX : integer;
begin
     if curseurT=curNormal
        then if (abs(X-XfinInt)<margeDebutFin) or (abs(X-XdebutInt)<margeDebutFin)
             then PaintBoxTemps.cursor := crHsplit
             else if (x>xDebutInt) and (x<xFinInt)
                  then PaintBoxTemps.cursor := crHandPoint
                  else PaintBoxTemps.cursor := crDefault
        else begin
          deltaMini := Round(PaintBoxTemps.Width*16/pages[pageCourante].Nmes);
          traceReference; // efface
          traceDebutFin; // efface l'ancien 
          case curseurT of
               curDebut : if X<(XfinInt-DeltaMini) then XdebutInt := X;
               curFin : if X>(XdebutInt+DeltaMini) then XfinInt := X;
               curDeplace : begin
                  dX := X-Xdeplace;
                  if ((xdebutInt+dX)>grapheTemps.limiteCourbe.left) and
                     ((xfinInt+dX)<grapheTemps.limiteCourbe.right) then begin
                    xdebutInt := xdebutInt + dX;
                    xfinInt := xfinInt + dX;
                    Xdeplace := X;
                  end;
               end;
          end;
          RazSon := true;
          traceDebutFin; // trace le nouveau
          chercheReference;
       end;
end; // TempsMouseMove

procedure TFGrapheFFT.TempsMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var xf,xd,yy : double;
    zut : integer;
begin
      if Button=mbRight then exit;
      PaintBoxTemps.Cursor := crDefault;
      TraceReference; // efface
      with GrapheTemps do begin
          case curseurT of
            curDebut : begin
               XdebutInt := x;
               if (xdebutInt<grapheTemps.limiteCourbe.left) then
                   xdebutInt := grapheTemps.limiteCourbe.left;
               RazSon := true;
            end;
            curFin : begin
               XfinInt := x;
               if (xfinInt>grapheTemps.limiteCourbe.right) then
                   xfinInt := grapheTemps.limiteCourbe.right;
               RazSon := true;
            end;
            curDeplace : RazSon := true;
          end;
          curseurT := curNormal;
          mondeXY(XdebutInt,0,mondeY,xd,yy);
          mondeXY(XfinInt,0,mondeY,xf,yy);
      end;
      with pages[pageCourante] do begin
          periodeFFT := xf-xd;
          DebutFFT := 0;
          while (debutFFT<pred(nmes)) and
                (valeurVar[indexTri,debutFFT]<xd) do inc(debutFFT);
// point(debutFFT) >= debut
          xf := valeurVar[indexTri,debutFFT] + periodeFFT;
          FinFFT := pred(nmes);
          while (finFFT>debutFFT) and
                (valeurVar[indexTri,finFFT]>=xf) do dec(finFFT);
// point(finFFT) < fin
          if finFFT<(debutFFT+minPeriodeFFT) then
             if debutFFT<nmes div 2
                then begin
                   finFFT := debutFFT+minPeriodeFFT;
                   grapheTemps.windowXY(valeurVar[indexTri,debutFFT],0,mondeY,XfinInt,zut);
                end
                else begin
                   debutFFT := finFFT-minPeriodeFFT;
                   grapheTemps.windowXY(valeurVar[indexTri,debutFFT],0,mondeY,XdebutInt,zut);
                end;
          periodeFFT := valeurVar[indexTri,finFFT]-valeurVar[indexTri,debutFFT]/ (finFFT-debutFFT) * (finFFT-debutFFT+1);
      end;
      AffecteDebutFin;
end;

procedure TFgrapheFFT.AffecteDebutFin;
begin with pages[pageCourante] do begin
    recalculFourierP;
    GrapheFrequence.modif := [gmEchelle];
    MajGrapheFFT;
end end;

procedure TFgrapheFFT.TraceDebutFin;
var yy,xFinIntMax,xDebutIntMin : integer;
begin with grapheTemps,PaintBoxTemps.Canvas,pages[pageCourante] do begin
      Pen.Color := clGray;
      Pen.Width := 3;
      Pen.mode := pmNotXor;
      windowXY(valeurVar[indexTri,pred(nmes)],0,mondeY,XfinIntMax,yy);
      windowXY(valeurVar[indexTri,0],0,mondeY,XdebutIntMin,yy);
      if XdebutInt<XdebutIntMin then XdebutInt := XdebutIntMin;
      if XfinInt>XfinIntMax then XfinInt := XfinIntMax;
      if (XfinInt-XdebutInt)<(3*LimiteCourbe.right div 4) then begin
         Brush.color := clCream;
         Brush.style := bsSolid;
      end;
      Rectangle(XdebutInt,LimiteFenetre.Bottom-marge,XfinInt,LimiteFenetre.Top+marge);
      Brush.style := bsClear;
      Pen.Width := 1;
      periodeFFTedit.text := grandeurs[indexTri].FormatValeurEtUnite(periodeFFT);
end end;

procedure TFGrapheFFT.PasSonAffEditExit(Sender: TObject);
begin
    if SonagrammeBtn.down then begin
        pasSonagrammeAff := GetFloat(pasSonAffEdit.text);
        calculSonagramme;
        PaintBoxFrequence.invalidate;
    end;
end;

procedure TFGrapheFFT.pasSonCalculEditExit(Sender: TObject);
begin
    if SonagrammeBtn.down then begin
       pasSonCalcul := pasSonCalculSE.value;
       calculSonagramme;
       PaintBoxFrequence.invalidate;
    end;
end;

procedure TFGrapheFFT.PeriodeBtnClick(Sender: TObject);
var zut,finLoc : Integer;
begin with pages[pageCourante] do begin
    if PaintBoxTemps.visible then traceDebutFin; // efface
    cherchePeriode(valeurVar[indexFonction],nmes,debutFFT,finFFT);
    with GrapheTemps do begin
        if finFFT<(nmes-2)
            then finLoc := finFFT+1
            else finLoc := pred(nmes);
// de manière  à ce que le graphe représente la durée
// alors que le dernier point est à (durée - deltat)
        windowXY(valeurVar[indexTri,finLoc],valeurVar[indexFonction,finLoc],mondeY,XfinInt,zut);
        windowXY(valeurVar[indexTri,debutFFT],valeurVar[indexFonction,debutFFT],mondeY,XdebutInt,zut);
    end;
    if PaintBoxTemps.visible then traceDebutFin;
    RazSon := true;
    avecPeriode := true;
    MajRaiesAfaire := true;
    AffecteDebutFin;
end end;

procedure TFgrapheFFT.ChercheReference;
var x,y : double;
    ifin,idebut : integer;
    YdebutInt,YfinInt,z : Integer;
begin with grapheTemps,PaintBoxTemps.Canvas,pages[pageCourante] do begin
         mondeXY(XdebutInt,YdebutInt,mondeY,x,y);
         idebut := 0;
         while (idebut<pred(nmes)) and (valeurVar[indexTri,idebut]<x) do inc(idebut);
         windowXY(valeurVar[indexTri,idebut],valeurVar[IndexFonction,idebut],mondeY,z,YdebutInt);
         mondeXY(XfinInt,YfinInt,mondeY,x,y);
         ifin := pred(nmes);
         while (ifin>idebut) and (valeurVar[indexTri,ifin]>x) do dec(ifin);
         windowXY(valeurVar[indexTri,ifin],valeurVar[IndexFonction,ifin],mondeY,z,YfinInt);
         Reference := rect(XdebutInt,YdebutInt,XfinInt,YfinInt);
         TraceReference;
end end;

procedure TFGrapheFFT.PaintBoxFrequenceDblClick(Sender: TObject);
begin
    reelClick := true
end;

procedure TFGrapheFFT.ToolButtonClick(Sender: TObject);
var i : integer;
    nom : string;
    bouton : TToolButton;
begin
  bouton := (sender as TToolButton);
  nom := bouton.caption;
  if bouton.Down
      then begin
           if listeY.Count>=maxOrdonnee then listeY.Delete(0);
           ListeY.add(nom);
      end
      else begin
           for i := 0 to pred(listeY.count) do
               if listeY[i]=nom
                  then begin
                       ListeY.delete(i);
                       break;
                  end;
           if listeY.count=0 then ListeY.add(Grandeurs[indexVariab[1]].nom);
      end;
   include(GrapheFrequence.modif,gmXY);
   MajGrapheFFT;
end;

procedure TFGrapheFFT.PlayBtnClick(Sender: TObject);
var duree : double;
begin
if playBtn.ImageIndex=stopIndex
then begin
        timerWav.Enabled := false;
        MediaPlayer.Notify := false;
        MediaPlayer.Stop;
        MediaPlayer.Notify := false;
        PlayBtn.imageIndex := playIndex;
        PlayBtn.Caption := stJouer;
        if not SonagrammeBtn.down then paintBoxFrequence.invalidate;
end
else with pages[pageCourante] do begin
  AffecteDebutFin;
  if RazSon then begin
     if MediaPlayerOpen then MediaPlayer.close;
     MediaPlayer.FileName := '';
     MediaPlayerOpen := false;
     grapheTemps.genereSon;
  end;
  RazSon := false;
  MediaPlayer.FileName := FichierSon;
  mediaPlayer.timeFormat := tfMilliseconds;
  if not MediaPlayerOpen then begin
     MediaPlayer.open;
     MediaPlayerOpen := true;
  end;
  Duree := valeurVar[indexTri,finFFT]-valeurVar[indexTri,debutFFT];
  TimerWav.Enabled := Duree>0.5;
  PositionPB := grapheTemps.windowX(valeurVar[indexTri,debutFFT]);
  tempsZeroWav := valeurVar[indexTri,debutFFT]+timerWav.Interval/2000;
  TracePosition; // position de départ
  PlayBtn.caption := stStop;
  PlayBtn.imageIndex := stopIndex;
  MediaPlayer.notify := true;
  MediaPlayer.Play;
end end;

procedure TFGrapheFFT.ToutBtnClick(Sender: TObject);
var zut : Integer;
begin with pages[pageCourante] do begin
    if PaintBoxTemps.visible then traceDebutFin; // efface
    debutFFT := 0;
    finFFT := pred(nmes);
    RazSon := true;
    with GrapheTemps do begin
        windowXY(valeurVar[indexTri,finFFT],valeurVar[indexFonction,finFFT],mondeY,XfinInt,zut);
        windowXY(valeurVar[indexTri,0],valeurVar[indexFonction,0],mondeY,XdebutInt,zut);
    end;
    if PaintBoxTemps.visible then traceDebutFin;
    AffecteDebutFin;
    avecPeriode := false;
    MajRaiesAfaire := true;
end end;

procedure TFGrapheFFT.MajGrapheFFT;
begin
      if pageCourante=0 then exit;
      GrapheTemps.Modif := GrapheFrequence.Modif;
      MajRaiesAfaire := true;
      PaintBoxFrequence.invalidate;
      if paintBoxTemps.visible then PaintBoxTemps.invalidate;
      periodeFFTedit.text := grandeurs[indexTri].FormatValeurEtUnite(pages[pageCourante].periodeFFT);
end;

procedure TFGrapheFFT.MediaPlayerNotify(Sender: TObject);
begin
     PlayBtn.imageIndex := playIndex;
     PlayBtn.Caption := stJouer;
     TimerWav.enabled := false;
     TracePosition; // efface
//     MediaPlayer.Close;     // ?
     if not SonagrammeBtn.down then paintBoxFrequence.invalidate;
end;

procedure TFGrapheFFT.SonagrammeBtnClick(Sender: TObject);
begin
     include(grapheFrequence.modif,gmXY);
     setCoordonnee
end;

procedure TFGrapheFFT.GroupBoxAnimClick(Sender: TObject);
var AgroupBox : TgroupBox;
    i : integer;
begin
    AgroupBox := (sender as  TgroupBox);
    i := AgroupBox.tag;
    if paramAnimManuelle[i].active then begin
       paramAnimCourant := i;
       for i := 0 to pred(NbreParamAnim) do with paramAnimManuelle[i] do
           if i=paramAnimCourant
              then groupBoxF.color := clBtnHighLight
              else groupBoxF.color := clBtnFace;
    end;

end;

procedure TFGrapheFFT.GroupBoxAnimDblClick(Sender: TObject);
var i : integer;
begin
     TimerAnim.enabled := false;
     if AnimParamDlg=nil then
        Application.CreateForm(TAnimParamDlg, AnimParamDlg);
     if AnimParamDlg.ShowModal=mrOK then begin
        if (paramAnimCourant>=NbreParamAnim) then paramAnimCourant := 0;
        if not paramAnimManuelle[paramAnimCourant].active then
          for i := 0 to pred(NbreParamAnim) do
              if paramAnimManuelle[i].active then begin
                 paramAnimCourant := i;
                 break;
              end;
        for i := 0 to pred(NbreParamAnim) do with paramAnimManuelle[i] do begin
           codeA := indexConstExp[i];
           if (codeA<NbreGrandeurs) then
                GroupBoxF.caption := grandeurs[codeA].formatNomEtUnite(valeurA)+
                    ' ['+formatReg(debutA)+','+formatReg(finA)+']';
           SliderF.visible := active;
           if active
              then GroupBoxF.height := 48
              else GroupBoxF.height := 24;
           SliderF.max := sliderMaxValue;
           SliderF.lineSize := succ(sliderF.max div 8);
           SliderF.pageSize := succ(sliderF.max div 32);
      end;
    end;
end;

procedure TFGrapheFFT.harmoniqueAffItemClick(Sender: TObject);
begin
  inherited;
  PaintBoxFrequence.invalidate;
end;

procedure TFGrapheFFT.HelpAnimBtnClick(Sender: TObject);
begin
    Aide(Help_animation)
end;

procedure TFGrapheFFT.copierTableauItemClick(Sender: TObject);
begin
     FormDDE.razRTF;
     FormDDE.AjouteGrid(ValeursGrid);
     FormDDE.EnvoieRTF;
end;

procedure TFGrapheFFT.ImprimeBtnClick(Sender: TObject);
var bas : integer;
    withGrid,PleinePage : boolean;
begin
    if OKreg(OkImprGr,0) then begin
         withGrid := TableauBtn.down and OKreg(OkImprTab,0);
         PleinePage := not(withGrid) and not(PaintBoxTemps.visible);
         if PleinePage
            then DebutImpressionGr(poLandScape,bas)
            else DebutImpressionGr(poPortrait,bas);
         if PaintBoxTemps.visible then begin
            grapheTemps.withDebutFin := true;
            grapheTemps.versImprimante(HautGrapheGr,bas);
            grapheTemps.withDebutFin := false;
         end;
         if PleinePage
            then grapheFrequence.versImprimante(1,bas)
            else grapheFrequence.versImprimante(HautGrapheGr,bas);
        if withGrid then
           ImprimerGrid(FgrapheFFT.ValeursGrid,bas);
        finImpressionGr;
     end;
end;

procedure TFGrapheFFT.FenetreBtnClick(Sender: TObject);
begin
     Fenetre := Tfenetre((sender as Tcomponent).tag);
     FenetrageBtn.imageIndex := IconeW[fenetre];
     (sender as TmenuItem).checked := true;
     recalculFourierE;
     GrapheFrequence.modif := [gmEchelle];
     GrapheTemps.modif := [gmEchelle];
     MajRaiesAfaire := true;
     Application.MainForm.perform(WM_Reg_Maj,MajValeur,0);
end;

procedure TFGrapheFFT.ValeursGridDblClick(Sender: TObject);
begin
     if (rowClick=0) or (rowClick=1) then begin
  // modif du nom, de l'unité et du format
        ModifDlg := TmodifDlg.create(self);
        if colClick=0
           then modifDlg.index := cFrequence
           else if (colClick mod 2=1)
                then modifDlg.index := IndexNom(valeursGrid.cells[colClick,0])
                else modifDlg.index := IndexNom(valeursGrid.cells[colClick-1,0]);
        if modifDlg.showModal=mrOk then begin
           grapheFrequence.modif := [gmXY];
           paintBoxFrequence.invalidate;
        end;
        modifDlg.free;
     end;
end;

procedure TFGrapheFFT.ValeursGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     ValeursGrid.MouseToCell(X,Y,colClick,RowClick)
end;

procedure TFgrapheFFT.ImprimerGraphe(var bas : integer);
begin
    if printer.orientation=poLandscape then begin
       Printer.NewPage;
       bas := 0;
    end;
    if PaintBoxTemps.visible
       then begin
           grapheTemps.versImprimante(HautGrapheTxt,bas);
           grapheFrequence.versImprimante(HautGrapheTxt,bas);
       end
       else grapheFrequence.versImprimante(HautGrapheTxt,bas);
end;

procedure TFGrapheFFT.SplitterGridCanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  TableauBtn.down := newSize>16;
  Accept := true;
end;

procedure TFGrapheFFT.FormActivate(Sender: TObject);
begin
   inherited;
   HarmoniqueAffItem.checked := harmoniqueAff;
   ImprimeBtn.visible := imBoutonImpr in menuPermis;
   FregressiMain.FourierBtn.down := true;
   FenetrageBtn.imageIndex := IconeW[fenetre];
   separePeriodeBtn.visible := avecReglagePeriode;
   debutFFTspin.Visible := avecReglagePeriode;
   PeriodeFFTEdit.Visible := avecReglagePeriode;
   finFFTspin.Visible := avecReglagePeriode;
   grapheUtilise := false;
   AffecteToolBar;
end;

procedure TFGrapheFFT.CacherTempsClick(Sender: TObject);
begin
  TempsBtn.down := false;
  refresh;
end;

procedure TFGrapheFFT.bitmapItemClick(Sender: TObject);
begin
     GrapheTemps.withDebutFin := true;
     GrapheTemps.VersBitmap('');
     GrapheTemps.withDebutFin := false;
end;

procedure TFGrapheFFT.CacherGridClick(Sender: TObject);
begin
  TableauBtn.down := false;
  refresh;
end;

procedure TFGrapheFFT.DebutFFTEditKeyPress(Sender: TObject; var Key: Char);
begin
     if key=crCR
        then begin
           if sender=periodeFFTedit then VerifPeriodeFFT(sender);
           if sender=pasSonAffEdit then PasSonAffEditexit(sender);
           if sender=freqMaxEdit then FreqMaxEditexit(sender);
           key := #0;
        end
        else if key<>crTab
             then VerifKeyGetFloat(key)
end;

procedure TFGrapheFFT.DebutBtnClick(Sender: TObject);
begin
     TimerAnim.enabled := false;
     paramAnimManuelle[paramAnimCourant].sliderF.position := 0;
end;

procedure TFGrapheFFT.DebutFFTEditExit(Sender: TObject);
begin
     if not VerifPeriodeFFT(sender)
        then with Sender as Tedit do SetFocus
end;

function TFGrapheFFT.VerifPeriodeFFT(Sender: TObject) : boolean;
var valFin,deltat : double;
    posU : integer;
    tampon : String;
begin
     result := true;
     try
     with pages[pageCourante] do begin
        tampon := periodeFFTedit.text;
        // enlever l'unité
        posU := pos(grandeurs[indexTri].nomUnite,tampon);
        if posU>0 then delete(tampon,posU,length(tampon)-posU+1);
        periodeFFT := GetFloat(tampon);
        deltat := valeurVar[indexTri,1]-valeurVar[indexTri,0];
        valFin := valeurVar[indexTri,debutFFT]+periodeFFT-deltat;
        if valFin>valeurVar[indexTri,pred(nmes)] then begin
           debutFFT := 0;
           valFin := valeurVar[indexTri,0]+periodeFFT-deltat;
        end;
        finFFT := pred(nmes);
        while (finFFT>0) and (valeurVar[indexTri,finFFT]>valFin) do dec(finFFT);
     end;
     AffecteDebutFin;
     except
         result := false
     end;
end;

procedure TFGrapheFFT.DebutFFTspinDownClick(Sender: TObject);
begin
     if pages[pageCourante].debutFFT>0 then
        dec(pages[pageCourante].debutFFT);
     AffecteDebutFin;
end;

procedure TFGrapheFFT.DebutFFTspinUpClick(Sender: TObject);
begin
     if pages[pageCourante].debutFFT<(pages[pageCourante].finFFT-minPeriodeFFT) then
        inc(pages[pageCourante].debutFFT);
     AffecteDebutFin;
end;

procedure TFGrapheFFT.DecadeSEChange(Sender: TObject);
begin
    DecadeDB := DecadeSE.value;
    PaintBoxFrequence.invalidate;
end;

procedure TFGrapheFFT.DecibelCBClick(Sender: TObject);
begin
    decadeSE.visible := decibelCB.checked;
    decadeLabel.visible := decadeSE.visible;
    if decibelCB.checked
       then begin
          DecadeDB := DecadeSE.value;
          decibelCB.Caption := 'en dB sur';
       end
       else begin
         DecadeDB := 0;
         decibelCB.Caption := 'en dB';
       end;
    paintBoxFrequence.invalidate;
end;

procedure TFGrapheFFT.FinFFTspinUpClick(Sender: TObject);
begin
     if pages[pageCourante].finFFT<pred(pages[pageCourante].nmes) then
        inc(pages[pageCourante].finFFT);
     AffecteDebutFin;
end;

procedure TFGrapheFFT.FinBtnClick(Sender: TObject);
begin
     TimerAnim.enabled := false;
     with paramAnimManuelle[paramAnimCourant].sliderF do position := max;
end;

procedure TFGrapheFFT.FinFFTspinDownClick(Sender: TObject);
begin
     if pages[pageCourante].finFFT>(pages[pageCourante].debutFFT+minPeriodeFFT) then
        dec(pages[pageCourante].finFFT);
     AffecteDebutFin;
end;

procedure TFGrapheFFT.CopierItemClick(Sender: TObject);
begin
     grapheUtilise := true;
     GrapheFrequence.VersPressePapier(grapheClip);
     grapheUtilise := false;
end;

procedure TFGrapheFFT.ZoomManuelBtnClick(Sender: TObject);
begin
     if ZoomManuelFFTDlg=nil then
        Application.CreateForm(TzoomManuelFFTDlg, ZoomManuelFFTDlg);
     case ZoomManuelFFTDlg.showModal of
          mrOK : grapheFrequence.modif := [gmEchelle];
          mrCancel : grapheFrequence.modif := [gmXY];
     end;
     PaintBoxFrequence.invalidate;
end;

procedure TFGrapheFFT.FenetrageMenuPopup(Sender: TObject);
begin
    case Fenetre of
         Rectangulaire : RectBtn.checked := true;
         Hamming : HammingBtn.checked := true;
         Flattop : FlatTopBtn.checked := true;
         Blackman : BlackmanBtn.checked := true;
    end;
    FenetrageBtn.imageIndex := IconeW[fenetre];
end;

procedure TFGrapheFFT.DessinSupprimerItemClick(Sender: TObject);
var P : Tpoint;
begin
    if grapheFrequence.DessinCourant=nil then begin
         P := menuDessin.PopupPoint;
         P := grapheFrequence.paintBox.ScreenToClient(P);
         grapheFrequence.setDessinCourant(P.x,P.y);
    end;
    if grapheFrequence.DessinCourant=nil then exit;
    with grapheFrequence.dessins do Remove(grapheFrequence.DessinCourant);
    refresh;
end;

procedure TFGrapheFFT.ProprietesMenuClick(Sender: TObject);
var P : Tpoint;
begin
   if grapheFrequence.DessinCourant=nil then begin
         P := menuDessin.PopupPoint;
         P := grapheFrequence.paintBox.ScreenToClient(P);
         grapheFrequence.setDessinCourant(P.x,P.y);
   end;
   if grapheFrequence.DessinCourant=nil then exit;
   grapheFrequence.dessinCourant.litOption(grapheFrequence);
   refresh;
end;

procedure TFGrapheFFT.SelectBtnClick(Sender: TObject);
begin
    (sender as TtoolButton).CheckMenuDropdown
end;

procedure TFGrapheFFT.TextBtnClick(Sender: TObject);
begin
      curseurF := curTexteF;
      PaintBoxFrequence.Invalidate;
      Application.ProcessMessages;
      grapheFrequence.DessinCourant := Tdessin.create(grapheFrequence);
      grapheFrequence.DessinCourant.isTexte := true
end;

procedure TFGrapheFFT.ReticuleBtnClick(Sender: TObject);
begin
      setCurseurF(curReticuleF);
      PaintBoxFrequence.invalidate;
      pages[pageCourante].AffecteConstParam(false);
end;

procedure TFGrapheFFT.FaussesCouleursCBClick(Sender: TObject);
begin
    UseFaussesCouleurs := FaussesCouleursCB.Checked;
    PaintBoxFrequence.invalidate;
end;

procedure TFGrapheFFT.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if mediaPlayerOpen then begin
     MediaPlayer.Close;
     mediaPlayerOpen := false;
  end;
  action := caFree;
end;

procedure TFGrapheFFT.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
     case msg.charCode of
          vk_F10 : if curseurF=curReticuleF then begin
              SaveFreqItemClick(nil);
              handled := true;
          end;
     end;
end;

procedure TFGrapheFFT.SauverLigneItemClick(Sender: TObject);
var ligne : integer;
begin
      ligne := valeursGrid.selection.top;
      sauverFrequence(getFloat(valeursGrid.cells[0,ligne]),
                      getFloat(valeursGrid.cells[1,ligne]));
end;

procedure TFGrapheFFT.PopupMenuGridPopup(Sender: TObject);
begin
  inherited;
  sauverLigneItem.visible := valeursGrid.selection.top>0;
end;

procedure TFGrapheFFT.SaveFreqItemClick(Sender: TObject);
var P : Tpoint;
begin
    with grapheFrequence.curseurOsc[1] do begin
        sauverFrequence(xr,yr);
        P := point(xc,yc);
        P := paintBoxFrequence.ClientToScreen(P);
        mouse.CursorPos := P;
    end;
end;

procedure TFGrapheFFT.SaveHarmItemClick(Sender: TObject);
begin
   saveDialogCSV.title := 'Sauvegarde des raies ("harmoniques")';
   if saveDialogCSV.Execute then
      listePic[1].ecritCSV(saveDialogCSV.FileName);
end;

procedure TFGrapheFFT.SauverFrequence(f,a : double);
begin with grapheFrequence do begin
       if saveHarmoniqueDlg=nil then
          Application.CreateForm(TsaveHarmoniqueDlg, saveHarmoniqueDlg);
       saveHarmoniqueDlg.valeur[gFrequence] := f;
       saveHarmoniqueDlg.valeur[gAmplitude] := a;
       saveHarmoniqueDlg.Agrandeur[gAmplitude] := grandeurs[indexNom(listeY[0])];
       saveHarmoniqueDlg.Agrandeur[gFrequence] := grandeurs[cFrequence];
       saveHarmoniqueDlg.showModal;
end end;

procedure TFGrapheFFT.ReticuleItemClick(Sender: TObject);
begin
     SelectBtn.imageIndex := 23;
     ReticuleItem.checked := true;
end;

procedure TFGrapheFFT.RetourBtnClick(Sender: TObject);
begin
    TimerAnim.enabled := false;
    paramPrecedent
end;

procedure TFGrapheFFT.RetourRapideBtnClick(Sender: TObject);
begin
     FinBtnClick(sender);
     Perform(WM_Reg_Animation,1,0)
end;

procedure TFGrapheFFT.TexteItemClick(Sender: TObject);
begin
     CurseurF := curTexteF;
     PaintBoxFrequence.Invalidate;
     Application.ProcessMessages;
     grapheFrequence.DessinCourant := Tdessin.create(grapheFrequence);
     grapheFrequence.DessinCourant.isTexte := true
end;

procedure TFGrapheFFT.TimerAnimTimer(Sender: TObject);
begin
    timerAnim.enabled := false;
    ActiverTimerAnim := true;
    timerAnim.interval := (1+(NbreTickBar.Max-NbreTickBar.position))*55;
    if avance
        then paramSuivant
        else paramPrecedent;
    timerAnim.enabled := ActiverTimerAnim;
end;

procedure TFGrapheFFT.TimerWavTimer(Sender: TObject);
var posSec : double;
begin
    if MediaPlayer.FileName<>'' then begin
         TracePosition; // efface
         if mediaPlayer.timeFormat=tfMilliseconds
            then PosSec := mediaPlayer.position/1000
            else PosSec := mediaPlayer.position/FreqEchWave;
         positionPB := grapheTemps.windowX(posSec+tempsZeroWav);
         TracePosition; // retrace
    end;
end;

procedure TFGrapheFFT.TitreAnimCBClick(Sender: TObject);
var indexCourant : integer;

procedure AjouteTitre;
var Dessin : Tdessin;
    i : integer;
    atexte : string;
begin
       Dessin := Tdessin.create(grapheFrequence);
       aTexte := '';
       with Dessin do begin
          isTexte := true;
          avecCadre := true;
          hauteur := 6;
          identification := identAnimation;
          longAnim := 0;
          isOpaque := true;
          with grapheFrequence do begin
               x1i := paintBox.width div 2;
               y1i := paintBox.height div 20;
               x2i := x1i;y2i := y1i;
               x2 := 0;y2 := 0;
               try
               if pageCourante>0
                  then MondeRT(x1i,y1i,mondeY,x2,y2)
               except
               end;
          end;
          x1 := x2;
          y1 := y2;
          vertical := false;
          pen.color := couleurPages[1];
       end;
       for i := 0 to pred(NbreParamAnim) do
           if paramAnimManuelle[i].active then
              if aTexte=''
                 then aTexte := '%C'+intToStr(succ(i))
                 else aTexte := aTexte+' ; %C'+intToStr(succ(i));
       dessin.texte.add(aTexte);
       grapheFrequence.dessins.add(Dessin);
end; // ajouteTitre

var i : integer;
begin
     indexCourant := -1;
     i := 0;
     while (i<grapheFrequence.dessins.count) and (indexCourant=-1) do
       if (grapheFrequence.dessins[i].identification=identAnimation)
          then indexCourant := i
          else inc(i);
     if not titreAnimCB.enabled then exit;
     if (indexCourant>=0) and not titreAnimCB.checked
        then with grapheFrequence do
              Dessins.remove(dessins[indexCourant]);
     if (indexCourant<0) and titreAnimCB.checked
        then ajouteTitre;
     if (pageCourante>0) then invalidate;
end; // TitreAnimCBClick

procedure TFGrapheFFT.StandardItemClick(Sender: TObject);
begin
     CurseurF := curSelectF;
     PaintBoxFrequence.Invalidate;
end;

procedure TFGrapheFFT.StopBtnClick(Sender: TObject);
begin
    TimerAnim.enabled := false
end;

procedure TFGrapheFFT.FreqMaxEditExit(Sender: TObject);
begin
    freqMaxSonagramme := GetFloat(freqMaxEdit.text);
    freqMaxSonUD.position := round(freqMaxSonagramme);
    freqMaxSonUD.increment := round(freqMaxSonagramme/10);
    grapheFrequence.monde[mondeX].defini := false;
    grapheFrequence.monde[mondeY].defini := false;
    PaintBoxFrequence.invalidate;
end;


procedure TFGrapheFFT.FreqMaxSonUDChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Integer; Direction: TUpDownDirection);
begin
    freqMaxSonagramme := newValue;
    freqMaxSonUD.increment := round(freqMaxSonagramme/10);
    grapheFrequence.monde[mondeX].defini := false;
    grapheFrequence.monde[mondeY].defini := false;
    freqMaxEdit.text := formatReg(freqMaxSonagramme);
    PaintBoxFrequence.invalidate;
end;

procedure TFGrapheFFT.LigneItemClick(Sender: TObject);
begin
    CurseurF := curLigneF;
    PaintBoxFrequence.Invalidate;
    Application.ProcessMessages;
    grapheFrequence.DessinCourant := Tdessin.create(grapheFrequence);
    grapheFrequence.DessinCourant.isTexte := false
end;

procedure TFGrapheFFT.ZoomDebutFinItemClick(Sender: TObject);
begin
    refresh
end;

procedure TFGrapheFFT.NbreHarmAffSpinDownClick(Sender: TObject);
begin
  if MajRaiesAfaire then exit;
  if NbreHarmoniqueAff>0 then dec(NbreHarmoniqueAff);
  HarmoniqueAff := NbreHarmoniqueAff>0;
  MajRaiesAfaire := true;
  paintBoxFrequence.invalidate;
end;

procedure TFGrapheFFT.NbreHarmAffSpinUpClick(Sender: TObject);
begin
  if MajRaiesAfaire then exit;
  if NbreHarmoniqueAff<NbreHarmoniqueAffMax then begin
     inc(NbreHarmoniqueAff);
     HarmoniqueAff := true;
     HarmoniqueAffItem.Checked := true;
     MajRaiesAfaire := true;
     paintBoxFrequence.invalidate;
  end;
end;

procedure TFGrapheFFT.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var P : Tpoint;
begin
     if ssAlt in Shift then begin
        case key of
             ord('C') : OptionsFourierItemClick(nil);
             ord('I') : ImprimeBtnClick(nil);
        end;
        exit;
     end;
     GetCursorPos(P);
     P := PaintBoxFrequence.ScreenToClient(P);
     if (P.X<0) or (P.X>paintBoxFrequence.width) or
        (P.Y<0) or (P.Y>paintBoxFrequence.height) then exit;
     case key of
          vk_left : if ssShift in Shift then dec(P.X,4) else dec(P.X);
          vk_right :  if ssShift in Shift then inc(P.X,4) else inc(P.X);
          vk_down : inc(P.Y);
          vk_up : dec(P.Y);
          vk_prior : dec(P.X,16);
          vk_next : inc(P.X,16);
          vk_escape : begin
               case curseurF of
                    curZoomF : zoomEnCours := false;
                    curFmaxi : ;
                    curFmaxiSon : ;
                    curTexteF,curLigneF : begin
                       grapheFrequence.dessinCourant.free;
                       grapheFrequence.dessinCourant := nil;
                    end;
                    curReticuleF : exit;
                    curMoveF : ;
                    curSelectF : ;
                end;
            setCurseurF(curSelectF);
            PaintBoxFrequence.invalidate;
            exit;
          end // escape
          else exit;
     end;
     key := 0;
     P := PaintBoxFrequence.ClientToScreen(P);
     setCursorPos(P.X,P.Y);
end; //  FormKeyDown

procedure TFGrapheFFT.FormKeyPress(Sender: TObject; var Key: Char);
var posSouris : Tpoint;
    i : integer;
    xr,yr,dy : double;
    Dessin : Tdessin;
    indexTemps,IndexFreq : integer;
label fin;
begin   // à vérifier dans le cas sonagramme
   if (key=' ') and
      (curseurF in [curReticuleF,curSelectF]) and
      not SonagrammeBtn.down then begin
        GetCursorPos(PosSouris);
        PosSouris := PaintBoxFrequence.ScreenToClient(PosSouris);
        if (PosSouris.X<0) or (PosSouris.X>paintBoxFrequence.width) or
           (PosSouris.Y<0) or (PosSouris.Y>paintBoxFrequence.height) then exit;
        iCourant := -1;
        with grapheFrequence.courbes[0] do
          if (((trace=[trLigne]) and (motif=mLosange)) or
              ((trace=[trPoint]) and (motif=mSpectre))) and
             (page=pageCourante) then with grapheFrequence do begin
                  mondeRT(posSouris.x,posSouris.y,mondeY,xr,yr);
                  iCourant := listePic[1].Proche(xr,yr,monde[mondeX].maxi);
                  xr := listePic[1].picsF[iCourant];
                  yr := listePic[1].picsH[iCourant];
          end;
      if iCourant<0 then exit;
      with grapheFrequence do
      for i := 0 to pred(dessins.count) do
         if (dessins[i].identification=identRaie) and
            (abs(dessins[i].x1i-posSouris.x)<16) and
            (abs(dessins[i].y1i-posSouris.y)<32)
          then begin
             Dessins.remove(dessins[i]);
             goto fin
          end;
      dy := grapheFrequence.monde[mondeY].maxi/64;
      Dessin := Tdessin.create(grapheFrequence);
      with Dessin do begin
            isTexte := true;
            avecLigneRappel := false;
            MotifTexte := mtNone;
            hauteur := 2;
            NumPage := 0;
            vertical := false;
            pen.color := clBlue;
            identification := identRaie;
            x1 := xr;
            y1 := yr+dy;
            x2 := xr;
            y2 := yr+dy;
            grapheFrequence.dessins.add(Dessin);
            texte.add(grandeurs[cFrequence].formatValeurEtUnite(xr));
      end;
      fin:
      MajRaiesAfaire := false;
      PaintBoxFrequence.invalidate;
   end; // if barre et select
   if (key=' ') and  SonagrammeBtn.down then begin
       GetCursorPos(PosSouris);
       PosSouris := PaintBoxFrequence.ScreenToClient(PosSouris);
       if (PosSouris.X<0) or (PosSouris.X>paintBoxFrequence.width) or
          (PosSouris.Y<0) or (PosSouris.Y>paintBoxFrequence.height) then exit;
       grapheFrequence.mondeRT(posSouris.X,posSouris.Y,mondeY,Xr,Yr);
       with grapheFrequence do
       for i := 0 to pred(dessins.count) do
         if (abs(dessins[i].x1i-posSouris.x)<16) and
            (abs(dessins[i].y1i-posSouris.y)<32)
          then begin
             Dessins.remove(dessins[i]);
             PaintBoxFrequence.invalidate;
             exit;
          end;
      dy := grapheFrequence.monde[mondeY].maxi/64;
      Dessin := Tdessin.create(grapheFrequence);
      grapheFrequence.getIndexSonagramme(xr,yr,indexTemps,indexFreq,yr);
      with Dessin do begin
            isTexte := true;
            avecLigneRappel := false;
            MotifTexte := mtNone;
            hauteur := 2;
            NumPage := 0;
            vertical := false;
            pen.color := clBlack;
            isOpaque := true;
            x1 := xr;
            y1 := yr+dy;
            x2 := xr;
            y2 := yr+dy;
            grapheFrequence.dessins.add(Dessin);
            texte.add(grandeurs[cFrequence].formatValeurEtUnite(yr));
        end;
        PaintBoxFrequence.invalidate;
   end;
end;

procedure TFGrapheFFT.changeEchelleSon(xnew, xold: integer);
begin
  with grapheFrequence do begin
    xnew := limiteCourbe.bottom - xnew;
    if xnew < 16 then exit;
    xold := limiteCourbe.bottom - xold;
    with monde[mondeY] do begin
       A := A * xnew / xold;
       Maxi := Mini + (limiteCourbe.top - limiteCourbe.bottom) / A;
       FreqMaxSonagramme := Maxi;
       if FreqMaxSonagramme>pasFreqSonagramme*NbrePointsSonagramme
          then freqMaxSonagramme := pasFreqSonagramme*NbrePointsSonagramme;
       freqMaxEdit.text := formatReg(freqMaxSonagramme);
       freqmaxsonUD.Position := round(freqMaxSonagramme);
       freqMaxSonUD.increment := round(freqMaxSonagramme/10);
    end;
  end;
  PaintBoxFrequence.invalidate;
end;

procedure TFGrapheFFT.TracePosition;
begin
    with paintBoxTemps.canvas do begin
         pen.mode := pmNotXor;
         pen.color := clRed;
         pen.Width := 1;
         moveTo(positionPB,0);
         lineTo(positionPB,paintBoxTemps.height);
    end;
    if sonagrammeBtn.Down then with paintBoxFrequence.canvas do begin
         pen.mode := pmNotXor;
         pen.color := clRed;
         pen.Width := 1;
         moveTo(positionPB,0);
         lineTo(positionPB,paintBoxFrequence.height);
    end;
end;

procedure TFGrapheFFT.CalculSonagramme;
var freqEch : double;
begin with pages[pageCourante] do begin
     FreqEch := pred(Nmes)/(valeurVar[indexTri][pred(Nmes)]-valeurVar[indexTri][0]);
     Sonagramme(Nmes,valeurVar[indexSonagramme],FreqEch);
     PasSonCalculSE.MaxValue := pasSonCalculMax;
     freqMaxSonUD.max := round(freqEch/2);
     PeriodeFFT := valeurVar[indexTri,pred(nmes)];
     nbreFFT := NbrePointsSonagramme;
end end;

procedure TFGrapheFFT.AffecteToolBar;
var i,j,iVar : integer;
begin
     j := 0;
     for i := 0 to pred(NbreVariab) do begin
         iVar := indexVariab[i];
         if iVar<>indexTri then
            with ToolBarGrandeurs.Buttons[j] do begin
                 visible := true;
                 caption := grandeurs[iVar].nom;
                 tag := iVar;
                 inc(j);
            end;
            if j>=ToolBarGrandeurs.ButtonCount then break;
      end;
      for i := j to pred(ToolBarGrandeurs.ButtonCount) do
               ToolBarGrandeurs.Buttons[i].visible := false;
end;

Procedure TFgrapheFFT.SetAnimation;
var i : integer;
    avecVerif,UnActif : boolean;
    valDebut,valFin,valC : double;
begin
    if NbreConstExp>maxParamAnimFFT
       then NbreParamAnim := MaxParamAnimFFT
       else NbreParamAnim := NbreConstExp;
    if NbreParamAnim=0 then
       AnimationBtn.down := false;
    if AnimationBtn.down then begin
       avecVerif := false;
       for i := 0 to pred(NbreParamAnim) do with paramAnimManuelle[i] do begin
           codeA := indexConstExp[i];
           if (nomA<>grandeurs[codeA].nom) or Ainitialiser then begin
              nomA := grandeurs[codeA].nom;
              valDebut := pages[1].valeurConst[codeA];
              valFin := pages[NbrePages].valeurConst[codeA];
              Ainitialiser := isNan(valDebut) or isNan(valFin);
              if isNan(valDebut) then valDebut := 1;
              if isNan(valFin) then valFin := valDebut+1;
              debutA := valDebut;
              finA := valFin;
              VerifMinMaxReal(debutA,finA);
              variationLog := false;
              if finA=debutA then finA := debutA+1;
              pasA := (finA-debutA)/sliderF.max;
              valC := pages[PageCourante].valeurConst[codeA];
              if not isCorrect(valC) then valC := (valDebut+valFin)/2;
              valeurA := valC;
              //sauveValeurA := valeurA;
              avecVerif := avecVerif or not Ainitialiser;
              active := ((ModeAcquisition<>AcqSimulation) or
                         (i>0) or
                         (NbreParamAnim=1)) and
                         not Ainitialiser;
           end;
           GroupBoxF.caption := grandeurs[codeA].formatNomEtUnite(valeurA)+
                  ' ['+formatReg(debutA)+','+formatReg(finA)+']';
           SliderF.visible := active;
           if active
              then GroupBoxF.height := 48
              else GroupBoxF.height := 24;
           if variationLog
              then SliderF.position := round(log10(valeurA/debutA)/log10(pasA))
              else SliderF.position := round((valeurA-debutA)/pasA);
           GroupBoxF.visible := true;
       end;
       UnActif := false;
       for i := 0 to pred(NbreParamAnim) do
           UnActif := UnActif or paramAnimManuelle[i].active;
       if not UnActif then with paramAnimManuelle[pred(NbreParamAnim)] do begin
           active := true;
           SliderF.visible := true;
           GroupBoxF.height := 48;
       end;
       for i := NbreParamAnim to pred(maxParamAnimFFT) do
           paramAnimManuelle[i].GroupBoxF.visible := false;
       if (paramAnimCourant>=NbreParamAnim) or
          not(paramAnimManuelle[ParamAnimCourant].active) then begin
          paramAnimCourant := 0;
          for i := 0 to pred(NbreParamAnim) do begin
             if paramAnimManuelle[i].active then
                paramAnimCourant := i;
                break;
             end;
       end;
       if avecVerif
          then GroupBoxAnimDblClick(nil)
          else AnimSliderChange(paramAnimManuelle[paramAnimCourant].sliderF);
    end;
    InitManuelleAfaire := false;
end; // SetAnimation

procedure TFgrapheFFT.CalculeAnimation;
var i : integer;
begin
  if (pageCourante=0) or not PanelAnimation.visible then exit;
  with grapheFrequence do begin
      Screen.cursor := crHourGlass;
      for i := 0 to pred(NbreParamAnim) do with paramAnimManuelle[i] do begin
          if active then begin
             codeA := indexNom(nomA);
             pages[pageCourante].valeurConst[codeA] := valeurA;
             grandeurs[codeA].valeurCourante := pages[pageCourante].valeurConst[codeA];
          end;
          GroupBoxF.caption := grandeurs[codeA].formatNomEtUnite(valeurA)
                   +' ['+formatCourt(debutA)+';'+formatCourt(finA)+']';
      end;
      pages[pageCourante].RecalculP;
      include(modif,gmValeurs);
      Screen.cursor := crDefault;
      invalidate;
  end;
  include(grapheTemps.modif,gmValeurs);
  MajGrapheFFT;
  if PaintBoxTemps.visible then PaintBoxTemps.Invalidate;
end; // CalculeAnimation

procedure TFgrapheFFT.ParamSuivant;
begin with paramAnimManuelle[paramAnimCourant].sliderF do
    if position<max
       then position := position+1
       else if boucleCB.checked
          then position := 0
          else ActiverTimerAnim := false;
end;

procedure TFgrapheFFT.ParamPrecedent;
begin with paramAnimManuelle[paramAnimCourant].sliderF do
    if position>0
       then position := position-1
       else if boucleCB.checked
          then position := max
          else ActiverTimerAnim := false;
end;

procedure TFgrapheFFT.CacheAnimation;
begin
        PanelAnimation.visible := false;
        TimerAnim.enabled := false;
        AnimationBtn.down := false;
end;

procedure TFgrapheFFT.WMRegAnimation(var Msg : TWMRegMessage);
begin
    Avance := msg.typeMaj=0;
    TimerAnim.enabled := true;
end;

end.



