unit graphpar;

interface

uses Windows, Classes, Graphics, Forms, Controls, Menus, ExtCtrls,
     Dialogs, sysUtils, Buttons, StdCtrls, Grids, Messages, printers,
     math, ComCtrls, Spin, GripSplitter, ImgList, ToolWin,
     system.Types, System.ImageList,
         Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc,
     constreg, maths, regutil, uniteker, compile, graphker, modeleGr,
  Vcl.VirtualImageList, Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TfgrapheParam = class(TForm)
    PanelModele: TPanel;
    PaintBox: TPaintBox;
    PanelAjuste: TPanel;
    PopupMenuAxes: TPopupMenu;
    ZoomAvantItem: TMenuItem;
    CoordonneesItem: TMenuItem;
    PopupMenuModele: TPopupMenu;
    PanelCourbe: TPanel;
    Zoomavant1: TMenuItem;
    Zoomarrire1: TMenuItem;
    EchelleAutoItem: TMenuItem;
    EchelleManuelle: TMenuItem;
    chi2Item: TMenuItem;
    ImprimeGrItem: TMenuItem;
    MemoModele: TRichEdit;
    EditBidon: TEdit;
    PanelAjusteBtn: TPanel;
    AjusteBtn: TSpeedButton;
    ParamScrollBox: TScrollBox;
    Panel5: TPanel;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SpeedButton15: TSpeedButton;
    Edit3: TEdit;
    Panel6: TPanel;
    SpeedButton16: TSpeedButton;
    SpeedButton17: TSpeedButton;
    SpeedButton18: TSpeedButton;
    SpeedButton19: TSpeedButton;
    SpeedButton20: TSpeedButton;
    Edit4: TEdit;
    Panel7: TPanel;
    SpeedButton21: TSpeedButton;
    SpeedButton22: TSpeedButton;
    SpeedButton23: TSpeedButton;
    SpeedButton24: TSpeedButton;
    SpeedButton25: TSpeedButton;
    Edit5: TEdit;
    Panel8: TPanel;
    SpeedButton26: TSpeedButton;
    SpeedButton27: TSpeedButton;
    SpeedButton28: TSpeedButton;
    SpeedButton29: TSpeedButton;
    SpeedButton30: TSpeedButton;
    Edit6: TEdit;
    Panel9: TPanel;
    SpeedButton31: TSpeedButton;
    SpeedButton32: TSpeedButton;
    SpeedButton33: TSpeedButton;
    SpeedButton34: TSpeedButton;
    SpeedButton35: TSpeedButton;
    Edit7: TEdit;
    Panel11: TPanel;
    SpeedButton36: TSpeedButton;
    SpeedButton37: TSpeedButton;
    SpeedButton38: TSpeedButton;
    SpeedButton39: TSpeedButton;
    SpeedButton40: TSpeedButton;
    Edit8: TEdit;
    PanelParam1: TPanel;
    SpeedButton41: TSpeedButton;
    SpeedButton42: TSpeedButton;
    SpeedButton43: TSpeedButton;
    SpeedButton44: TSpeedButton;
    SpeedButton45: TSpeedButton;
    Edit9: TEdit;
    ResultatGB: TGroupBox;
    memoResultat: TRichEdit;
    TraceAutoCB: TCheckBox;
    RepeatTimer: TTimer;
    ToolBarGr: TToolBar;
    CordonneesBtn: TToolButton;
    ZoomAvantBtn: TToolButton;
    ZoomArriereBtn: TToolButton;
    ToolButton5: TToolButton;
    ZoomAutoBtn: TToolButton;
    ZoomManuelBtn: TToolButton;
    ToolButton8: TToolButton;
    ImprimeBtn: TToolButton;
    CopierBtn: TToolButton;
    CurseurBtn: TToolButton;
    ToolButton2: TToolButton;
    CurseurMenu: TPopupMenu;
    SelectItem: TMenuItem;
    CurTexteItem: TMenuItem;
    CurLigneItem: TMenuItem;
    CurGommesItem: TMenuItem;
    CurReticuleItem: TMenuItem;
    ToolBarModele: TToolBar;
    PagesBtn: TToolButton;
    ModeLinBtn: TToolButton;
    TitreModeleBtn: TToolButton;
    IdentPagesBtn: TToolButton;
    IdentPagesItem: TMenuItem;
    LabelErreur: TLabel;
    LabelX: TLabel;
    LabelY: TLabel;
    ToolBarGrandeurs: TToolBar;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    SplitterModele: TGripSplitter;
    SupprReticule: TMenuItem;
    EnregistrerGrapheItem: TMenuItem;
    SaveDialog: TSaveDialog;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Edit1: TEdit;
    TempsTB: TTrackBar;
    AddModeleItem: TMenuItem;
    MajBtn: TSpeedButton;
    ToolButton14: TToolButton;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ZoomAvantItemClick(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure CoordonneesItemClick(Sender: TObject);
    procedure ZoomAutoItemClick(Sender: TObject);
    procedure CopierItemClick(Sender: TObject);
    procedure PaintBoxPaint(Sender: TObject);
    procedure PaintBoxDblClick(Sender: TObject);
    procedure AjusteBtnClick(Sender: TObject);
    procedure MemoModeleChange(Sender: TObject);
    procedure MemoModeleKeyPress(Sender: TObject; var Key: Char);
    procedure ZoomArriereItemClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ValeursParamKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure ZoomManuelItemClick(Sender: TObject);
    procedure CopierModeleItemClick(Sender: TObject);
    procedure TraceModeleClick(Sender: TObject);
    procedure MemoResultatKeyPress(Sender: TObject; var Key: Char);
    procedure PopupMenuAxesPopup(Sender: TObject);
    procedure Chi2ItemClick(Sender: TObject);
    procedure PopupMenuModelePopup(Sender: TObject);
    procedure TitreModeleBtnClick(Sender: TObject);
    procedure setPointCourant(i : integer);
    procedure EditBidonKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PagesBtnClick(Sender: TObject);
    procedure ImprimeGrItemClick(Sender: TObject);
    procedure PageSuivBtnClick(Sender: TObject);
    procedure ModeLinBtnClick(Sender: TObject);
    procedure MemoModeleClick(Sender: TObject);
    procedure MajBtnClick(Sender: TObject);
    procedure TraceAutoBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure EditValeurExit(Sender: TObject);
    procedure EditValeurKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditValeurKeyPress(Sender: TObject; var Key: Char);
    procedure SigneClick(Sender: TObject);
    procedure PlusRapideClick(Sender: TObject);
    procedure PlusClick(Sender: TObject);
    procedure MoinsClick(Sender: TObject);
    procedure MoinsRapideClick(Sender: TObject);
    procedure ParamBtnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ParamBtnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RepeatTimerTimer(Sender: TObject);
    procedure SelectItemClick(Sender: TObject);
    procedure CurseurBtnClick(Sender: TObject);
    procedure IdentPagesItemClick(Sender: TObject);
    procedure IdentPagesBtnClick(Sender: TObject);
    procedure LabelYMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SupprReticuleClick(Sender: TObject);
    procedure EnregistrerGrapheItemClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure TempsTBChange(Sender: TObject);
    procedure AddModeleItemClick(Sender: TObject);
  private
      Curseur : Tcurseur;
      reelClick : boolean;
      zoneZoom : Trect;
      GrapheP : TgrapheReg;
      IndexModeleGr : integer;
      verifGraphe : boolean;
      etatModele : TsetEtatModele;
      ModeleCalcule : boolean;
      ParamCourant : TcodeParam;
      EntreeValidee : boolean;
      DerF : TMatriceFonction; // Dérivées premières / aux paramètres
      valeursParamChange,erreurCalcul : boolean;
      modeleEnCours : boolean;
      editValeur : array[TcodeParam] of Tedit;
      panelParam : array[TcodeParam] of Tpanel;
      IsModeleMagnum : boolean;
      TimerButton : TSpeedButton;
      Chi2ActifGlb : boolean;
      ParamMaxAffiche : integer;
      procedure SetUniteParamGlb;
      Procedure SetCoordonnee;
      procedure SetPenBrush(c : Tcurseur);
      function getPage(x,y : integer) : integer;
      procedure MajParametres;
      procedure MajResultat;
      Procedure LanceModele(ajuste : boolean);
      procedure CompileModeleGlb(var PosErreur,LongErreur : integer);
      procedure ConstruitModeleGlb;
      Procedure EffectueModeleGlb(Ajuste : boolean);
      Procedure LanceCompile;
      Procedure EffectueCompile;
      procedure MajModeleGr(Numero : integer);
      Procedure ValideParam(paramV : integer;maj : boolean);
      procedure ModifParam(paramM : integer;coeff : double);
      procedure ModeleMagnum;
      procedure activeToutesPages;
      procedure SetPanelModele(NouvelEtat : boolean);
      procedure MajToolBar;
      procedure setTaillePolice;
      procedure AjustePanelModele;
  protected
      procedure WMRegMaj(var Amessage: TWMRegMessage); message WM_Reg_Maj;
      procedure WMRegCalcul(var Amessage: TWMRegMessage); message WM_Reg_Calcul;
  public
      configCharge,majFichierEnCours : boolean;
      MajModelePermis : boolean;
      procedure EcritConfig;
      procedure LitConfig;
      procedure EcritConfigXML(ANode : IXMLNOde);
      procedure LitConfigXML(ANode : IXMLNOde);
      procedure ImprimerGraphe(var bas : integer);
      procedure VersLatex(const NomFichier : string);
  end;

var fgrapheParam : TfgrapheParam;

implementation

uses
    zoomMan, clipBrd, selPage, options,
    CoordPhys, regmain, ChoixModeleGlb, statCalc, OptionsAffModeleU;

{$R *.DFM}


const maxParamGlb = 7;
      coeffParam = 1.023;

{$I modelCte.pas}

  procedure TFgrapheParam.VersLatex(const NomFichier : string);
  begin
        grapheP.VersLatex(nomFichier,'P');
  end;

Function IndexToGrandeur(i : integer) : Tgrandeur;
// Renvoie la grandeur d'index i
var k : integer;
begin
   if i<NbreGrandeurs
      then IndexToGrandeur := Grandeurs[i]
      else begin
         k := indexToParam(paramNormal,i);
         if k<>grandeurInconnue then begin
             IndexToGrandeur := Parametres[paramNormal,k];
             exit;
         end;
         k := IndexToParam(paramGlb,i);
         if k<>grandeurInconnue then begin
             IndexToGrandeur := Parametres[paramGlb,k];
             exit;
         end;
         indexToGrandeur := nil;
     end;
end;

procedure TfgrapheParam.FormMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);

procedure AffichePosition;
var Xr,Yr : double;
    YY,XX : string;
begin with GrapheP do begin
    if not(monde[mondeX].defini) or not(monde[mondeY].defini) then exit;
    MondeRT(x,y,mondeY,xr,yr);
    if monde[mondeY].graduation=gdB
       then begin
          yr := 20*log10(yr);
          YY := monde[mondeY].Axe.nom+'='+formatGeneral(Yr,PrecisionMin)+' dB';
       end
       else YY := monde[mondeY].Axe.formatNomEtUnite(Yr);
    XX := monde[mondeX].Axe.formatNomEtUnite(Xr);
    labelX.transparent := false;
    labelY.transparent := false;
    labelX.caption := ' '+XX+' ';
    labelY.caption := ' '+YY+' ';
    labelX.top := LimiteCourbe.bottom+4+PaintBox.top;
    labelY.top := y-8+PaintBox.top;
    labelY.left := LimiteFenetre.left;
    labelX.left := x-(labelX.width div 2);
end end; // AffichePosition

var deplacement : boolean;
    hintLoc : string;
    indexLoc : integer;
    p : integer;
begin // MouseMove
with grapheP do begin
   if not grapheOK then exit;
   hintLoc := '';
   deplacement := ssLeft in Shift;
   case curseur of
        curZoomAv : if deplacement then with grapheP.canvas,zoneZoom do begin
           Rectangle(left,top,right,bottom); { efface l'ancien }
           right := X;
           bottom := Y;
           Rectangle(left,top,right,bottom);
        end;
        curModeleGr : with modeleParametre[1] do
           if deplacement and (indexModeleGr<>0)
              then begin
                      DessineUnPoint(indexModeleGr); { efface }
                      AffecteUnPoint(indexModeleGr,x,y);
                      DessineUnPoint(indexModeleGr);
              end
              else begin
                 indexLoc := GetIndex(x,y);
                 if indexLoc=0
                    then paintBox.cursor := crDefault
                    else begin
                        paintBox.cursor := crHandPoint;
                        hintLoc := GetHint(indexLoc);
                    end;
        end;
        curSelect : if deplacement
            then begin if dessinCourant<>nil
                then with dessinCourant do
                  case posDessinCourant of
                     sdCadre : begin
                        RectangleGr(zoneZoom); { efface }
                        AffecteCentreRect(x,y,zoneZoom);
                        RectangleGr(zoneZoom);
                     end
                     else begin
                        LineGr(zoneZoom); { efface }
                        affectePosition(x,y,posDessinCourant,shift);
                        case posDessinCourant of
                            sdVert : zoneZoom := rect(x1i,LigneMin,x1i,ligneMax);
                            sdHoriz : zoneZoom := rect(ligneMin,y1i,ligneMax,y1i);
                            else zoneZoom := rect(x1i,y1i,x2i,y2i);
                        end;
                        LineGr(zoneZoom);
                     end
                 end { case }
            end
            else begin
               SetDessinCourant(x,y);
               if dessinCourant<>nil then begin
                    paintBox.cursor := crHandPoint;
                    hintLoc := hGlisser;
                    if posDessinCourant=sdcadre then
                       hintLoc := hintLoc+hDbleTexte;
                end
                else begin
                   p := GetPage(x,y);
                   if p>0 then begin
                      hintLoc := stPageActive[active];
                      hintLoc := hintLoc+hClicPage;
                   end;
                end;
            end;
        curLigne,curTexte : if deplacement then
            with grapheP.canvas,dessinCourant do begin
                MoveTo(x1i,y1i);
                LineTo(x2i,y2i); // efface l'ancienne
                AffectePosition(x,y,sdPoint2,shift);
                MoveTo(x1i,y1i);
                LineTo(x2i,y2i);
                affichePosition;
        end;
        curReticule : if not deplacement then begin
           grapheP.TraceReticule(1); // efface
           affichePosition;
           curseurOsc[1].xc := x;
           curseurOsc[1].yc := y;
           TraceReticule(1);
        end;
        curReticuleData : ;
   end;
   if hintLoc=''
      then paintBox.hint := hClicDroit
      else paintBox.hint := hintLoc
end end; // FormMouseMove

procedure TfgrapheParam.ZoomAvantItemClick(Sender: TObject);
begin
    setPenBrush(curZoomAv)
end;

procedure TfgrapheParam.SetPenBrush(c : Tcurseur);

Procedure SetPenLoc;
begin with PaintBox,canvas do begin
  Pen.Color := PcolorReticule;
  Pen.style := PstyleReticule;
  Pen.mode := pmNotXor;
  Brush.style := bsClear;
  Brush.color := clWindow;
  cursor := crDefault;
  case curseur of
       curZoomAv : begin
          Brush.color := BrushcouleurZoom;
          cursor := crZoom;
          Brush.style := bsSolid;
          CurseurBtn.ImageIndex := 12;
       end;
       curModeleGr : begin
            cursor := crCross;
            Brush.color := BrushCouleurSelect;
            Brush.style := bsSolid;
            CurseurBtn.ImageIndex := 8;
       end;
       curTexte : begin
          cursor := crLettre;
          CurseurBtn.ImageIndex := 2;
       end;
       curLigne : begin
           cursor := crPencil;
           CurseurBtn.ImageIndex := 1;
       end;
       curReticule : begin
           cursor := crNone;
           CurseurBtn.ImageIndex := 3;
       end;
       curEfface : begin
           cursor := crGomme;
           CurseurBtn.ImageIndex := 0;
       end
       else begin
           cursor := crDefault;
           CurseurBtn.ImageIndex := 20;
       end;
    end;{case}
end end;

begin
     curseur := c;
     labelX.visible := curseur=curReticule;
     labelY.visible := curseur=curReticule;
     LabelX.Color := fondReticule;
     LabelY.Color := fondReticule;
     SetPenLoc;
end; // SetPenBrush

procedure TfgrapheParam.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var iProche : integer;
    PointReticule : Tpoint;
begin with grapheP do begin
  if not grapheOK then exit;
  case curseur of
       curZoomAv : zoneZoom := rect(X,Y,X,Y);
       curModeleGr : indexModeleGr := modeleParametre[1].GetIndex(x,y);
       curLigne,curTexte : with grapheP.dessinCourant do  begin
           affectePosition(x,y,sdPoint1,shift);
           x2i := x1i;
           y2i := y1i;
       end;
       curReticule : with CurseurOsc[1] do begin
          TraceReticule(1); // efface
          iProche := PointProche(x,y,0,true,false);
          Xc := x;
          Yc := y;
          PointReticule := PaintBox.ClientToScreen(Point(xc,yc));
          setCursorPos(PointReticule.X,PointReticule.Y);
          with courbes.items[0] do begin
             labelX.Caption := monde[mondeX].Axe.formatNomEtUnite(valX[iproche]);
             labelY.Caption := monde[mondeY].Axe.FormatNomEtUnite(valY[iproche]);
          end;
          TraceReticule(1);// retrace
       end;
       curSelect : begin
          SetDessinCourant(x,y);
          if dessinCourant<>nil
             then with dessinCourant do begin
               case posDessinCourant of
                    sdcadre : begin
                       zoneZoom := cadre;
                       RectangleGr(zoneZoom);
                    end;
                    sdVert : zoneZoom := rect(x1i,ligneMin,x1i,ligneMax);
                    sdHoriz : zoneZoom := rect(ligneMin,y1i,ligneMax,y1i);
                    else zoneZoom := rect(x1i,y1i,x2i,y2i);
               end;
               if posDessinCourant<>sdCadre then
                    LineGr(zoneZoom);
          end;
       end; // curselect
       curEfface : begin
            SetDessinCourant(x,y);
            if dessinCourant<>nil then with dessins do begin
                 remove(DessinCourant);
                 PaintBox.invalidate;
            end;
            setPenBrush(curSelect);
       end;
  end { case }
end end; // FormMouseDown

procedure TfgrapheParam.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

Procedure affecteZoomAvantForm;
begin
  with zoneZoom do begin
        PaintBox.canvas.Rectangle(left,top,right,bottom);{ efface }
        right := X;
        bottom := Y;
        setPenBrush(curSelect);
        if (left=right) or (bottom=top) then exit;
        grapheP.affecteZoomAvant(zoneZoom,true);
   end;
   include(grapheP.modif,gmEchelle);
   PaintBox.invalidate;
end; // affecteZoomAvant

procedure AffecteDessin;
begin with grapheP.dessinCourant do begin
   with PaintBox.canvas do begin
        MoveTo(x1i,y1i);
      	LineTo(x2i,y2i); { efface }
   end;
   if isTexte then if not litOption(grapheP) then begin
      grapheP.dessinCourant.free;
      setPenBrush(curSelect);
      exit;
   end;
   AffectePosition(x,y,sdPoint2,shift);
   grapheP.dessins.Add(grapheP.DessinCourant);
   draw;
   setPenBrush(curSelect);
end end;

var p : integer;
begin // FormMouseUp
with grapheP do begin
  if not grapheOK then exit;
  case curseur of
       curZoomAv : affecteZoomAvantForm;
       curTexte,curLigne : affecteDessin;
       curSelect : if reelClick
          then begin
             SetDessinCourant(x,y);
             if (dessinCourant<>nil)
                then begin
                   dessinCourant.litOption(grapheP);
                   PaintBox.invalidate;
                   DessinCourant := nil;
                end
                else begin
                   p := GetPage(x,y);
                   if p>0 then begin
                       pages[p].active := not pages[p].active;
                       if [ModeleConstruit,ModeleLineaire] <= etatModele
                          then LanceModele(true)
                          else begin
                              ModeleCalcule := false;
                              etatModele := [];
                           end;
                       include(grapheP.modif,gmXY);
                       PaintBox.invalidate;
                   end;
                end {else}
          end
          else if dessinCourant<>nil
             then with dessinCourant do begin
                if posDessinCourant=sdCadre
                   then RectangleGr(zoneZoom)
                   else LineGr(zoneZoom);{ efface }
                AffectePosition(x,y,posDessinCourant,shift);
                PaintBox.invalidate;
             end;
       curModeleGr : if indexModeleGr>0 then with modeleParametre[1] do begin
               DessineUnPoint(indexModeleGr); { efface }
               AffecteUnPoint(indexModeleGr,x,y);
               DessineUnPoint(indexModeleGr);
               MajModeleGr(1);
               indexModeleGr := 0;
       end;
       curReticuleData,curReticule : ;
  end;
  reelClick := false;
end end; // FormMouseUp

procedure TfgrapheParam.FormCreate(Sender: TObject);
var i,j,k : integer;
    m : TcodeIntervalle;
begin
  MajFichierEnCours := true;
  ModeleEnCours := true;
  ConfigCharge := false;
  VerifGraphe := true;  
  GrapheP := TgrapheReg.create;
  GrapheP.canvas := PaintBox.canvas;
  GrapheP.paintBox := PaintBox;
  grapheP.grapheParam := true;
  GrapheP.labelYcurseur := labelY;
  curseur := curSelect;
  entreeValidee := false;
  for m := 1 to maxIntervalles do begin
      for i := 1 to maxParamGlb do
          derf[m,i] := nil;
  end;
  ParamCourant := 1;
  ImprimeBtn.visible := imBoutonImpr in menuPermis;
  ParamMaxAffiche := 0;
  with ParamScrollBox do
        for i := 0 to pred(controlCount) do begin
           if controls[i] is Tpanel then begin
              j := TPanel(controls[i]).tag;
              if j>ParamMaxAffiche then ParamMaxAffiche := j;
              PanelParam[j] := TPanel(controls[i]);
              with PanelParam[j] do
                   for k := 0 to pred(controlCount) do begin
                       if controls[k] is Tedit then
                          EditValeur[j] := TEdit(controls[k]);
                   end;
           end;
  end;
  ModeleEnCours := false;
  setTaillePolice;
  ResizeButtonImagesforHighDPI(self);
end;

procedure TfgrapheParam.SetCoordonnee;

procedure SetCoordonneeParam;

Procedure AjouteParam(i : integer);
var x,y,xspline,yspline,xincert,yincert : Tvecteur;
    n,p : integer;
    Acourbe,courbeAdd : Tcourbe;
    iX,iY : integer;
    ligneC : Tligne;
    traceC : TsetTrace;
    m : TcodeIntervalle;
    mondeLoc : TindiceMonde;
    c,cc : integer;
    CouleurModeleActive : boolean;
    couleurLoc : Tcolor;

procedure SetCouleurTexte(m : TcodeIntervalle);
begin with memoModele,fonctionTheoriqueGlb[m] do begin
    selStart := findText(expression,0,length(text),[]);
    if selStart<0 then exit;
    selLength := length(expression);
    couleur := ACourbe.couleur;
    selAttributes.color := couleur;
    selLength := 0;
    selAttributes.color := clBlack;
end end;

begin with GrapheP do begin
      with Coordonnee[i] do begin
           iX := codeX;
           iY := codeY;
           TraceC := trace;
           LigneC := ligne;
           if (ligneC=liModele) and (NbreModeleGlb=0) then LigneC := LiDroite;
           MondeLoc := iMondeC;
      end;
      if not splitterModele.snapped then begin
         include(traceC,trLigne);
         ligneC := liModele;
         include(traceC,trPoint);
      end;
      if traceC=[] then case TraceDefaut of
             tdPoint : traceC := [trPoint];
             tdLigne : traceC := [trLigne];
             tdLissage : begin
                traceC := [trLigne,trPoint];
                ligneC := LiSpline;
             end;
      end;
      if grandeurs[iY].fonct.genreC=g_texte then begin
         if courbes.count>0 then with courbes[0] do begin
            include(trace,trTexte);
            texteC := TstringList.create;
            for p := 1 to NbrePages do with pages[p] do
                texteC.add(texteConst[iY]);
         end;
         exit;
      end;
      if (grandeurs[iY].genreG=variable) or
         (grandeurs[iX].genreG=variable) then begin
              setLength(y,MaxPages);
              case grandeurs[iY].genreG of
                   constante : for p := 1 to NbrePages do y[p-1] := pages[p].valeurConst[iY];
                   variable : ;
                   paramNormal : for p := 1 to NbrePages do y[p-1] := pages[p].valeurParametre(iX);
              end;
              setLength(x,MaxPages);
              case grandeurs[iX].genreG of
                   constante : for p := 1 to NbrePages do x[p-1] := pages[p].valeurConst[iX];
                   variable : ;
                   paramNormal : for p := 1 to NbrePages do x[p-1] := pages[p].valeurParametre(iX);
              end;
              Acourbe := AjouteCourbe(x,y,mondeLoc,NbrePages,
                   grandeurs[iX],grandeurs[iY],0);
              Acourbe.Adetruire := true;
              Acourbe.Trace := traceC;
              Acourbe.couleur := coordonnee[i].couleur;
              Acourbe.styleT := coordonnee[i].styleT;
              Acourbe.motif := coordonnee[i].motif;
              exit;
      end;
     if (grandeurs[iY].genreG=constanteGlb) or
        (grandeurs[iX].genreG=constanteGlb) then begin
              setLength(y,MaxPages);
              setLength(x,MaxPages);
              n := 0;
              for p := 1 to NbrePages do with pages[p] do begin
                  if grandeurs[iY].genreG=constanteGlb
                      then y[n] := grandeurs[iY].valeurCourante
                      else y[n] := valeurParametre(iY);
                  if grandeurs[iX].genreG=constanteGlb
                      then x[n] := grandeurs[iX].valeurCourante
                      else x[n] := valeurParametre(iX);
                  inc(n);
              end;
              Acourbe := AjouteCourbe(x,y,MondeLoc,NbrePages,
                 grandeurs[iX],grandeurs[iY],0);
              Acourbe.Trace := traceC;
              Acourbe.Adetruire := true;
              Acourbe.couleur := coordonnee[i].couleur;
              Acourbe.styleT := coordonnee[i].styleT;
              Acourbe.motif := coordonnee[i].motif;
           exit;
      end;
// c'est un paramètre      
      setlength(x,MaxVecteurDefaut+1);
      setLength(y,MaxVecteurDefaut+1);
      if avecEllipse then begin
         setlength(xIncert,MaxVecteurDefaut+1);
         setLength(yIncert,MaxVecteurDefaut+1);
      end;
      n := 0;
      for p := 1 to NbrePages do with pages[p] do begin
             x[n] := valeurParametre(iX);
             y[n] := valeurParametre(iY);
             if avecEllipse then begin
                xIncert[n] := precisionParametre(iX);
                yIncert[n] := precisionParametre(iY);
             end;
             inc(n);
      end;
      Acourbe := AjouteCourbe(x,y,MondeLoc,NbrePages,
         indexToGrandeur(iX),indexToGrandeur(iY),0);
      if (i=1) then begin
         Monde[mondeX].axe := grandeurs[iX];
         Monde[mondeX].axe.valeur := x;
         Monde[mondeLoc].axe := grandeurs[iY];
         Monde[mondeLoc].axe.valeur := y;
      end;
      Acourbe.couleur := coordonnee[i].couleur;
      Acourbe.motif := coordonnee[i].motif;
      Acourbe.styleT := coordonnee[i].styleT;
      if avecEllipse then begin
         Acourbe.IncertX := xIncert;
         Acourbe.IncertY := yIncert;
         Acourbe.DetruireIncert := true;
      end;
      Acourbe.Adetruire := true;
      Acourbe.Trace := TraceC;
      if (Coordonnee[i].motif=mSpectre) and (trPoint in TraceC)
         then Acourbe.decalage := (i-1)*decalageFFT;
// 2 modeles différents => on force des couleurs différentes
      CouleurModeleActive := false;
      for c := 2 to NbreModeleGlb do
          for cc := 1 to pred(c) do
              if (fonctionTheoriqueGlb[c].indexY)=
                 (fonctionTheoriqueGlb[cc].indexY) then begin
                     CouleurModeleActive := true;
                     break;
               end;
      if trLigne in traceC then case ligneC of
           liModele : if ModeleCalcule and (ModeleDefini in etatModele) then
              for m := 1 to NbreModeleGlb do with fonctionTheoriqueGlb[m] do
                  if (iY=indexY) and (iX=indexX) and not(implicite) then begin
                       exclude(Acourbe.Trace,trLigne);
                       include(Acourbe.Trace,trPoint);
                       if avecChi2 then Acourbe.motif := mIncert;
                       setLength(x,MaxVecteurDefaut+1);
                       setLength(y,MaxVecteurDefaut+1);
                       courbeAdd := AjouteCourbe(x,y,MondeLoc,NbrePages,
                             indexToGrandeur(iX),indexToGrandeur(iY),1);
                       if couleurModeleActive
                          then couleurLoc := couleurModele[m]
                          else couleurLoc := coordonnee[i].couleur;
                       courbeAdd.couleur := couleurLoc;
                       courbeAdd.StyleT := psSolid;
                       courbeAdd.IndexModele := m;
                       courbeAdd.Trace := [trLigne];
                       courbeAdd.Adetruire := true;
                       setCouleurTexte(m);
         end;
         liSpline : begin
              exclude(Acourbe.trace,trLigne);
              CalculBspline(x,y,OrdreLissage,n,xspline,yspline);
              Acourbe := AjouteCourbe(xspline,yspline,MondeLoc,n,
                   indexToGrandeur(iX),indexToGrandeur(iY),0);
              with coordonnee[i] do
                   Acourbe.setStyle(couleur,psSolid,mCroix,couleurPoint);
              Acourbe.Adetruire := true;
              Acourbe.trace := [trLigne];
         end;
      end;{case}
      if (SimulationDefinie in etatModele) and
         not (splitterModele.snapped) then
         for m := 1 to NbreFonctionSuperGlb do with fonctionSuperposeeGlb[m] do
           if (iY=indexY) and (iX=indexX) then begin
                 setLength(x,MaxVecteurDefaut+1);
                 setLength(y,MaxVecteurDefaut+1);
                 exclude(Acourbe.Trace,trLigne);
                 courbeAdd := AjouteCourbe(x,y,mondeLoc,NbrePages,
                    grandeurs[iX],grandeurs[iY],0);
                 courbeAdd.IndexModele := -m;
                 courbeAdd.setStyle(couleurModele[-m],psSolid,mCroix,'');
                 courbeAdd.Trace := [trLigne];
                 courbeAdd.Adetruire := true;
           end; // for c de SimulationDefini
end end; // AjouteParam

var  i : TindiceOrdonnee;
begin with GrapheP do begin
     MajModelePermis := false;
     NbreOrdonnee := 0;
     for i := 1 to maxOrdonnee do with Coordonnee[i] do
         if nomY<>'' then  begin
                AjouteParam(i);
                inc(NbreOrdonnee);
         end;
     grapheOK := true;
     MajModelePermis := true;
     TempsTB.Visible := (courbes[0].varY.genreG=variable) or
                        (courbes[0].varX.genreG=variable);
end end; // SetCoordonneeParam

procedure VerifCoordonnee;
var i : TindiceOrdonnee;
begin with grapheP do begin
      nbreOrdonnee := 0;
      for i := 1 to maxOrdonnee do with coordonnee[i] do
          if (nomX<>'') and (nomY<>'')
           then begin
              inc(nbreOrdonnee);
              coordonnee[nbreOrdonnee] := coordonnee[i];
           end;
     for i := succ(nbreOrdonnee) to maxOrdonnee do with coordonnee[i] do begin
          nomX := '';
          nomY := '';
     end;
     with coordonnee[1] do begin
        codeX := indexNom(nomX);
        if (codeX=grandeurInconnue) or
           ((codeX<NbreGrandeurs) and
            (grandeurs[codeX].genreG=variable)) then
           if NbreConst>0
               then begin
                  codeX := indexConst[0];
                  nomX := grandeurs[codeX].nom;
                  if NbreConst>1
                    then begin
                        codeY := indexConst[1];
                        nomY := grandeurs[codeY].nom;
                    end
                    else if NbreParam[paramNormal]>0 then begin
                        codeY := ParamToIndex(paramNormal,1);
                        nomY := Parametres[paramNormal,1].nom;
                    end
                    else begin
                        codeY := indexVariab[1];
                        nomY := grandeurs[codeY].nom;
                    end;
               end
               else begin
                  codeX := ParamToIndex(paramNormal,1);
                  nomX := Parametres[paramNormal,1].nom;
                  if NbreParam[paramNormal]>1 then begin
                     codeY := ParamToIndex(paramNormal,2);
                     nomY := Parametres[paramNormal,2].nom;
                  end
                  else begin
                     codeY := indexVariab[1];
                     nomY := grandeurs[codeY].nom;
                  end;
               end;
     end;
     nbreOrdonnee := 0;
     for i := 1 to maxOrdonnee do with coordonnee[i] do begin
        codeY := indexNom(nomY);
        codeX := indexNom(nomX);
        if codeX=grandeurInconnue then nomX := coordonnee[1].nomX;
        if (codeY=grandeurInconnue)
        //or ((codeY<NbreGrandeurs) and (grandeurs[codeY].genreG=variable))
           then nomY := ''
           else inc(nbreOrdonnee);
     end;
     if nbreOrdonnee=0 then begin
        with coordonnee[1] do if NbreConst>1
          then begin
               codeY := indexConst[1];
               nomY := grandeurs[codeY].nom;
          end
          else begin
               codeY := ParamToIndex(ParamNormal,1);
               nomY := parametres[paramNormal,1].nom;
         end;
         NbreOrdonnee := 1;
     end;
end end;

begin
     grapheP.raz;
     if NbreConst+NbreParam[paramNormal]>=1 then begin
          VerifCoordonnee;
          SetCoordonneeParam;
          grapheP.modif := [gmEchelle];
     end
end; // setCoordonnees

procedure TFgrapheParam.FormResize(Sender: TObject);
const HauteurMini = 76;
var hauteurAjuste,hauteurPanel,hauteurMemo,hauteurResultat,i : integer;
begin
     hauteurPanel := ClientHeight-ToolBarModele.height;
// valeurs par défaut
     if MemoModele.lines.count<3
        then i := 3
        else i := MemoModele.lines.count;
     hauteurMemo := (abs(memoModele.Font.height)+4)*(i+2);
     if NbreParam[paramGlb]<3
        then i := 3
        else i := NbreParam[paramGlb];
     HauteurAjuste := (PanelParam1.height+2)*i+PanelAjusteBtn.height+8;
     hauteurResultat := hauteurPanel-hauteurMemo-HauteurAjuste;
// on teste si résultats pas trop petit
     if (hauteurResultat<HauteurMini) then
        if ((HauteurPanel-HauteurMemo-HauteurMini)>HauteurMini)
           then begin
              HauteurAjuste := HauteurPanel-HauteurMemo-HauteurMini;
              // on ajuste panelAjuste résultat à mini
           end
           else begin
              HauteurMemo := HauteurPanel div 3;
              HauteurAjuste := hauteurMemo;
           end;
// on affecte
     MemoModele.Height := hauteurMemo;
     PanelAjuste.height := hauteurAjuste;
end;

procedure TfgrapheParam.CoordonneesItemClick(Sender: TObject);
begin
    with FcoordonneesPhys,grapheP do begin
        Agraphe := grapheP;
        ListeConst := true;
        modeleEnCours := false;
        modelePermis := NbreModeleGlb>0; 
        Transfert.AssignEntree(grapheP);
        SuperPagesCB.visible := false;
        SuperPagesCB.checked := false;
        if FcoordonneesPhys.ShowModal=mrOK then begin
            Transfert.AssignSortie(grapheP);
            useDefault := false;
            equivalences[0].clear;
            include(modif,gmXY);
            PaintBox.invalidate;
        end;
     end;
end;

procedure TfgrapheParam.ZoomAutoItemClick(Sender: TObject);
begin
     include(grapheP.modif,gmEchelle);
     grapheP.monde[mondeX].defini := false;
     grapheP.useDefault := false;
     PaintBox.invalidate
end;

procedure TfgrapheParam.CopierItemClick(Sender: TObject);
begin
     GrapheP.VersPressePapier(grapheClip)
end;

procedure TfgrapheParam.WMRegMaj(var Amessage: TWMRegMessage);

procedure FaireMajFichier;
begin
         if (WindowState=wsMinimized) and
            (dispositionFenetre<>dNone)
                then WindowState:=wsNormal;
         MajFichierEnCours := false;
         MemoModeleChange(nil);
         if MemoModele.lines.count>0 then setPanelModele(true);
         configCharge := true;
end;

begin
      case Amessage.typeMaj of
      MajPolice : begin
           setTaillePolice;
           exit;
      end;
      MajPreferences : begin
         ImprimeBtn.visible := imBoutonImpr in menuPermis;
         ModeLinBtn.visible := imModeleGr in MenuPermis;
         exit;
      end;
      MajVide : majFichierEnCours := true;
      MajFichier : if majFichierEnCours then FaireMajFichier else exit;
      MajSupprPage,MajAjoutPage,MajModele,
      MajGrandeur,MajModeleGlb,MajTri,MajValeurConst,MajValeur,MajSelectPage : begin
         MajToolBar;
         if majFichierEnCours then FaireMajFichier;
         GrapheP.Modif := [gmEchelle,gmXY];
         configCharge := true;
         if Amessage.TypeMaj=MajModeleGlb
            then begin
               include(GrapheP.modif,gmModele);
               majParametres;
               majResultat;
               if curseur=curModeleGr then with ModeleParametre[1] do begin
                  DessineTout; {efface}
                  setParamGlb;
                  DessineTout;
               end;
            end
            else begin
               etatModele := [];
               if curseur=curModeleGr then curseur := curSelect;
               grapheP.useDefault := false;
            end;
         PaintBox.invalidate;
      end;
      end;
end;

procedure TfgrapheParam.PaintBoxPaint(Sender: TObject);
var min,max : double;

procedure chercheMinMax;
begin with GrapheP do
      if OgPolaire in OptionGraphe
             then begin
                  min := 0;
                  if angleEnDegre
                     then max := 360
                     else max := 2*pi;
             end
             else with monde[mondeX] do case Graduation of
                 gLog : begin
                    max := power(10,Maxi);
                    min := power(10,Mini);
                 end;
                 gInv : begin
                    max := 1/Mini;
                    min := 1/Maxi;
                 end;
                 else begin
                    max := Maxi;
                    min := Mini;
                 end;
              end;{case}
end; // chercheMinMax

procedure affecteModele;
var i,k,n : integer;
begin with grapheP do
for i := 0 to pred(courbes.count) do with courbes.items[i] do
    if (indexModele>0) and (indexBande=0) then begin
        n := 0;
        for k := 1 to NbrePages do with pages[k] do begin
            valY[n] := valeurTheoriqueGlb[indexModele];
            valX[n] := valeurParametre(fonctionTheoriqueGlb[indexModele].indexX);
            inc(n);
        end;
    end;
end; // affecteModele

procedure zoomModele;
var i : integer;
begin
    ChercheMinMax;
    with grapheP do
       for i := 0 to pred(courbes.count) do with courbes.items[i] do
           if (indexModele>0) and (indexBande=0) then with fonctionTheoriqueGlb[indexModele] do begin
              DebutC := 0;
              GenereMGlb(valX,valY,min,max,monde[mondeX].graduation=gLog,FinC);
           end;
end; // zoomModele

procedure AffecteVariable;
var p,i,k : integer;
    code : integer;
begin with grapheP do
    for k := 0 to pred(courbes.count) do with Courbes[k] do begin
       if (varY.genreG=variable) then begin
          code := varY.indexG;
          i := TempsTB.Position;
          for p := 1 to NbrePages do begin
              if i>=pages[p].nmes then i := pages[p].nmes;
              valY[p-1] := pages[p].valeurVar[code,i];
          end;
       end;
end end;

procedure affecteSuperpose;
var i : integer;
begin
  ChercheMinMax;
  with GrapheP do
  for i := 0 to pred(courbes.count) do with courbes.items[i] do
      if (indexModele<0) and (-indexModele<=NbreFonctionSuperGlb) then
          with fonctionSuperposeeGlb[-indexModele] do begin
             DebutC := 0;
             GenereMGlb(valX,valY,min,max,monde[mondeX].graduation=gLog,FinC);
      end;
end; // affecteSuperpose

Procedure majTexteCourbes;
var p : integer;
begin with grapheP do
         if IdentPagesBtn.down then begin
               include(courbes[0].trace,trTexte);
               if courbes[0].TexteC=nil then courbes[0].TexteC := TstringList.create;
               courbes[0].TexteC.clear;
               for p := 1 to NbrePages do with pages[p] do
                   courbes[0].texteC.Add(Pages[p].commentaireP)
         end
         else exclude(courbes[0].trace,trTexte);
end;

var i : integer;
begin // PaintBoxPaint
        if (pageCourante=0) or not configCharge or majFichierEnCours then exit;
        grapheP.canvas := paintBox.canvas;
        if ([gmXY,gmModele]*grapheP.modif)<>[] then setCoordonnee;
        if not grapheP.grapheOK then exit;
        if TempsTB.visible then affecteVariable;
        grapheP.limiteFenetre := paintBox.clientRect;
        ZoomManuelBtn.down := grapheP.UseDefault;
        if ZoomManuelBtn.down
           then begin
              ZoomManuelBtn.imageIndex := 26;
              ZoomManuelBtn.hint := hZoomManuelDebloq;
           end
           else begin
              ZoomManuelBtn.imageIndex := 13;
              ZoomManuelBtn.hint := hZoomManuelBloq;
           end;
        if ModeleCalcule and
          (ModeleDefini in etatModele)
           then AffecteModele;
        grapheP.chercheMonde;
        if not grapheP.monde[mondeX].defini then exit;
        ModeleEnCours := true;
        if curseur=curModeleGr then with ModeleParametre[1] do
           for i := 1 to indexPointMax[genre] do
               grapheP.AjoutePoint(mondeY,xs[i],ys[i]);
        if (NbreFonctionSuperGlb>0) and
            ModeleCalcule and
           (ModeleDefini in etatModele)
           then affecteSuperpose;
        if (NbreModeleGlb>0) and
           (omExtrapole in grapheP.OptionModele) and
            ModeleCalcule and
           (ModeleDefini in etatModele)
           then zoomModele;
       	canvas.Pen.mode := pmCopy;
        majTexteCourbes;
        paintBox.canvas.brush.Color := clWindow;
        paintBox.canvas.brush.style := bsSolid;
        paintBox.canvas.FillRect(paintBox.clientRect);
        grapheP.draw;
        if active then begin
           setPenBrush(curseur);
           case curseur of
                curReticule : grapheP.TraceReticule(1);
                curModeleGr : modeleParametre[1].DessineTout;
           end;
        end;
        grapheP.modif := [];
        ModeleEnCours := false;
        screen.Cursor := crDefault;
end; // PaintBoxPaint

procedure TfgrapheParam.PaintBoxDblClick(Sender: TObject);
begin
     reelClick := true
end;

procedure TfgrapheParam.AddModeleItemClick(Sender: TObject);
var Dessin : Tdessin;
    i : integer;
    nouveauDessin : boolean;
begin with grapheP do begin
      if OptionsAffModeleDlg=nil then
         Application.createForm(TOptionsAffModeleDlg,OptionsAffModeleDlg);
      OptionsAffModeleDlg.isGlobal := true;
      OptionsAffModeleDlg.showModal;
      nouveauDessin := true;
      dessin := nil;// pour le compilateur
      for i := 0 to pred(Dessins.count) do
         if dessins[i].isTexte and
            (pos('%M',dessins[i].texte[0])>0) then begin
               dessin := dessins[i];
               nouveauDessin := false;
            end;
      if nouveauDessin then Dessin := Tdessin.create(grapheP);
      with Dessin do begin
           texte.Clear;
            isTexte := true;
           //centre := false;
           avecCadre := true;
           avecLigneRappel := false;
           hauteur := 4;
           vertical := false;
           pen.color := couleurModele[1];
           identification := identNone;
           paramModeleBrut := true;
           with monde[mondeX] do x1 := (mini+maxi)/2;
           with monde[mondeY] do y1 := maxi-(maxi-mini)/32;
           x2 := x1;
           y2 := y1;
           numPage := 0; // pageCourante
           for i := 1 to NbreModeleGlb do
               if OptionsAffModeleDlg.listeModeleBox.checked[i-1] then
                  texte.Add('%M'+intToStr(i+decalageModeleGlb));
           for i := 1 to NbreParam[paramNormal] do
               if OptionsAffModeleDlg.listeParamBox.checked[i-1] then
                  texte.Add('%P'+intToStr(i));
      end;
      if nouveauDessin then dessins.add(Dessin);
      PaintBox.invalidate;
end end; // addModele

procedure TfgrapheParam.AjusteBtnClick(Sender: TObject);
begin
// vérification : entrée dans éditeur paramètres à valider
     if (activeControl<>nil) and 
        (activeControl.width=edit9.width) and
        (activeControl.height=edit9.height) and
        (activeControl.tag>0)
            then ValideParam(activeControl.tag,false);
     LanceModele(true)
end;

procedure TFgrapheParam.MemoModeleChange(Sender: TObject);
begin
     if not MajModelePermis then exit;
     IsModeleMagnum := false;     
     if NbrePages=0 then begin
        MemoModele.clear;
        exit;
     end;
     etatModele := [];
     MemoResultat.clear;
     MajBtn.enabled := true;
     if curseur=curModeleGr then setPenBrush(curSelect);
end;

procedure TfgrapheParam.MemoModeleKeyPress(Sender: TObject; var Key: Char);
begin
    if (key=crCR) and (FregressiMain.KeypadReturn)
       then begin
           key := #0;
           MajBtnClick(Sender);
       end
end;

Procedure TfgrapheParam.MajParametres;
var i,imax : integer;
begin
       imax := NbreParam[paramGlb];
       if imax>ParamMaxAffiche then imax := ParamMaxAffiche;
       for i := 1 to imax do begin
           PanelParam[i].visible := true;
           if isNan(Parametres[paramGlb,i].valeurCourante)
              then Parametres[paramGlb,i].valeurCourante := 1;
           PanelParam[i].caption := Parametres[paramGlb,i].nom;
           EditValeur[i].text := formatCourt(Parametres[paramGlb,i].valeurCourante);
       end;
       for i := succ(imax) to ParamMaxAffiche do
           PanelParam[i].visible := false;
end;

procedure TfgrapheParam.MajResultat;

Procedure Ajoute(const Aligne : string);
begin
    MemoResultat.Lines.add(Aligne)
end;

var i : TcodeParam;
    m : TcodeIntervalle;
    k : integer;
begin
    MemoResultat.Clear;
    if not ModeleCalcule then exit;
    for m := 1 to NbreModeleGlb do with fonctionTheoriqueGlb[m] do begin
        memoResultat.selAttributes.color := couleur;
        if (ModeleLineaire in etatModele) and
            withCoeffCorrel then
        for k := 0 to pred(grapheP.courbes.count) do with grapheP.courbes[k] do
           if (grandeurs[indexY]=varY) and (grandeurs[indexX]=varX) then with pages[pag].stat2 do begin
              init(valX,valY,debutC,finC);
              Ajoute(stCoeffCorrel+'='+
                     FormatGeneral(Correlation,precisionCorrel));
              break;
        end;
        if Chi2ActifGlb
           then Ajoute('Chi2/(N-p)='+formatGeneral(chi2Relatif,precisionMin))
           else Ajoute(stSigmaY+addrY.formatNomEtUnite(sigmaY))
    end;
    memoResultat.selAttributes.color := clBlack;
    if ParamAjustesGlb
       then begin
          Ajoute(stIncertitudeType);
          for i := 1 to NbreParam[paramGlb] do
             Ajoute(ParamEtPrecGlb(i,false));
       end
       else begin
          Ajoute(stTest1);
          Ajoute(stTest2);
          Ajoute(stTest3);
       end;
end;

procedure TfgrapheParam.LanceModele(ajuste : boolean);
var i : integer;
    m : TcodeIntervalle;
label finProc;
begin
     if not(ajuste) and
       ( (OmManuel in GrapheP.OptionModele) or
         (splitterModele.snapped) ) then exit;
     ModeleEnCours := true;
     LabelErreur.Visible := false;
     if not (ModeleDefini in etatModele) then lanceCompile;
     if not (ModeleDefini in etatModele) then goto finProc;
     if not (ModeleConstruit in etatModele) then ConstruitModeleGlb;
     if not (ModeleConstruit in etatModele) then goto finProc;{ erreur ? }
     for i := 1 to NbreParam[paramGlb] do with Parametres[paramGlb,i] do
         if isNan(valeurCourante) then valeurCourante := 1;
     for i := 1 to NbrePages do with pages[i] do
         for m := 1 to NbreModeleGlb do
             if isNan(valeurParametre(fonctionTheoriqueGlb[m].indexY)) or
                isNan(valeurParametre(fonctionTheoriqueGlb[m].indexX))
                then begin
                    active := false;
                    exclude(grapheP.courbes[0].trace,trTexte);
                    LabelErreur.Visible := true;
                    LabelErreur.caption := erValeurNoDef+intToStr(i);
                end;
     if not (UniteParamDefinie in etatModele) then setUniteParamGlb;
     EffectueModeleGlb(ajuste);
     FRegressiMain.Perform(WM_Reg_Maj,MajModeleGlb,0);
     MajBtn.enabled := false;
finProc :
     ModeleEnCours := false;
end; // LanceModele

procedure TfgrapheParam.LanceCompile;
var PosErreur,longErreur : integer;
begin
     MajModelePermis := false;
     MajBtn.enabled := false;
     if MemoModele.Lines.count>0 then begin
        while (MemoModele.lines.count>0) and
           (MemoModele.lines[0]='') do MemoModele.lines.delete(0);
        while (MemoModele.lines.count>2) and
           (MemoModele.lines[MemoModele.lines.count-1]='') and
           (MemoModele.lines[MemoModele.lines.count-2]='')
          do MemoModele.lines.delete(MemoModele.lines.count-1);
        compileModeleGlb(posErreur,longErreur);
        if ModeleDefini in etatModele
           then ConstruitModeleGlb
           else with memoModele do begin
              selStart := pred(posErreur);
              selLength := longErreur;
              MajBtn.enabled := true;
              if not splitterModele.snapped then setFocus;
           end;
     end;      
     MajModelePermis := true;
end;

procedure TfgrapheParam.ZoomArriereItemClick(Sender: TObject);
begin with paintBox do begin
        grapheP.affecteZoomArriere;
        include(grapheP.modif,gmEchelle);
        refresh;
    end;
end; // zoomArriere

procedure TfgrapheParam.FormDestroy(Sender: TObject);
var i : integer;
    m : TcodeIntervalle;
begin
     for m := 1 to maxIntervalles do begin
         for i := 1 to maxParamGlb do
           libere(derf[m,i]);
     end;
     GrapheP.Free;
     FgrapheParam := nil
end;

Procedure TfgrapheParam.ecritConfig;
var i : integer;
begin with GrapheP do begin
   writeln(fichier,symbReg2,NbreOrdonnee,' X');
   for i := 1 to NbreOrdonnee do
       ecritChaineRW3(coordonnee[i].nomX);
   writeln(fichier,symbReg2,NbreOrdonnee,' Y');
   for i := 1 to NbreOrdonnee do
       ecritChaineRW3(coordonnee[i].nomY);
   writeln(fichier,symbReg2,NbreOrdonnee,' MONDE');
   for i := 1 to NbreOrdonnee do
       writeln(fichier,ord(coordonnee[i].iMondeC));
   if dispositionFenetre=dNone then begin
      writeln(fichier,symbReg2,'5 '+stFenetre);
      writeln(fichier,ord(windowState));
      writeln(fichier,top);
      writeln(fichier,left);
      writeln(fichier,width);
      writeln(fichier,height);
   end;
end end;

Procedure TfgrapheParam.ecritConfigXML(ANode : IXMLNode);
var i : integer;
    OptionsXML,CoordXML : IXMLNode;
    LtexteModele : TstringList;
begin
   for i := 1 to grapheP.NbreOrdonnee do with grapheP.coordonnee[i] do begin
       CoordXML := ANode.AddChild('COORD');
       CoordXML.Attributes['Index'] := intToStr(i);
       writeIntegerXML(CoordXML,stLigne,ord(ligne));
       writeIntegerXML(CoordXML,stCouleur,couleur);
       writeIntegerXML(CoordXML,'MOTIF',ord(Motif));
       writeStringXML(CoordXML,'X',nomX);
       writeStringXML(CoordXML,'Y',nomY);
       writeIntegerXML(CoordXML,'TRACE',word(TraceToXML(Trace)));
       writeIntegerXML(CoordXML,stMonde,ord(iMondeC));
       writeIntegerXML(CoordXML,'GRADUATION',ord(grapheP.monde[iMondeC].Graduation));
       writeIntegerXML(CoordXML,'ZERO',ord(grapheP.monde[iMondeC].ZeroInclus));
   end;
   if (NbreModeleGlb>0) or (MemoModele.lines.count>0) then begin
        OptionsXML := ANode.addChild(stModele);
        LTexteModele := TStringList.create;
        for i := 0 to pred(memoModele.Lines.Count) do
            LTexteModele.Add(memoModele.Lines[i]);
        LTexteModele.Delimiter := crCR;
        WriteStringXML(OptionsXML,'Modelisation',LTexteModele.delimitedText);
        writeIntegerXML(OptionsXML,'OptModele',byte(grapheP.optionModele));
     end;
end;

Procedure TfgrapheParam.litConfig;
var i,imax,Nligne,m,zint : integer;
    choix : integer;
    zByte : byte;
begin
   majFichierEnCours := true;
   while (Length(LigneWin)>0) and (ligneWin[1]=symbReg2) do with grapheP do begin
      choix := 0;
      Nligne := NbreLigneWin(ligneWin);
      imax := Nligne;
      if imax>5 then imax := 5;
      if pos('X',ligneWin)<>0 then choix := 1;
      if pos('Y',ligneWin)<>0 then choix := 2;
      if pos(stMonde,ligneWin)<>0 then choix := 3;
      if pos(stFenetre,ligneWin)<>0 then choix := 4;
      case choix of
           0 : for i := 1 to imax do readln(fichier);
           1 : for i := 1 to imax do
              coordonnee[i].nomX := litLigneWinU;
           2 : for i := 1 to imax do
              coordonnee[i].nomY := litLigneWinU;
           3 : for i := 1 to imax do begin
                readln(fichier,m);
                coordonnee[i].iMondeC := TindiceMonde(m);
           end;
           4 : begin
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
           end;
       end;
       for i := succ(imax) to Nligne do readln(fichier);
   // Pour récupérer une erreur de sauvegarde
       litLigneWin;
   end;
end;

Procedure TfgrapheParam.litConfigXML(ANode : IXMLNode);
var CoordCourante : integer;
    chaines : TStringList;

procedure ResetCoord;
var i : integer;
begin with grapheP do begin
    for i := mondeX to mondeSans do begin
        monde[i].axe := nil;
        monde[i].defini := false;
    end;
    for i := 1 to maxOrdonnee do with coordonnee[i] do begin
        nomY := '';
        nomX := '';
        exclude(trace,trSonagramme);
    end;
end end;

procedure VerifCoord;
var i : integer;
begin with grapheP do begin
    for i := 1 to maxOrdonnee do with coordonnee[i] do begin
        codeY := indexNom(nomY);
        if codeY<>grandeurInconnue
           then monde[iMondeC].axe := grandeurs[codeY];
        codeX := indexNom(nomX);
        if codeX<>grandeurInconnue then
           monde[mondeX].axe := grandeurs[codeX];
    end;
end end;

procedure LoadXMLInReg(ANode: IXMLNode);

procedure Suite;
var i: Integer;
begin
if ANode.HasChildNodes then
   for I := 0 to ANode.ChildNodes.Count - 1 do
       LoadXMLInReg(ANode.ChildNodes.Nodes[I]);
end;

Procedure ExtraitChaines;
begin
    chaines.Clear;
    chaines.DelimitedText := ANode.Text;
end; // extraitChaines

var Adessin : Tdessin;
    zWord : word;
    zByte : byte;
    aTrace : TsetTraceXML;
begin // loadXMLInReg
      if ANode.NodeName='COORD' then begin
         coordCourante := ANode.Attributes['Index'];
         suite;
         exit;
      end;
      if ANode.NodeName=stModele then begin
         suite;
         exit;
      end;
      if ANode.NodeName='X' then begin
         grapheP.coordonnee[coordCourante].nomX := ANode.Text;
         exit;
      end;
      if ANode.NodeName='Y' then  begin
         grapheP.coordonnee[coordCourante].nomY := ANode.Text;
         exit;
      end;
      if ANode.NodeName=stMonde then begin
         zByte := GetIntegerXML(ANode);
         grapheP.coordonnee[coordCourante].iMondeC := TindiceMonde(zByte);
         exit;
      end;
      if ANode.NodeName='GRADUATION' then begin
         zByte := GetIntegerXML(ANode);
         grapheP.monde[coordCourante].graduation := Tgraduation(zByte);
         exit;
      end;
      if ANode.NodeName=stOptions then begin
         suite;
         exit;
      end;
      if ANode.NodeName='ZERO' then begin
         grapheP.monde[coordCourante].zeroInclus := GetBoolXML(ANode);
         exit;
      end;
      if ANode.NodeName='OptGraphe' then begin
         zByte := GetIntegerXML(ANode);
         grapheP.optionGraphe := TsetOptionGraphe(zByte);
         exit;
      end;
      if ANode.NodeName='OptModele' then begin
         zByte := GetIntegerXML(ANode);
         grapheP.optionModele := TsetOptionModele(zByte);
         exit;
      end;
      if ANode.NodeName='TEXTE' then begin
          Adessin := Tdessin.create(grapheP);
          Adessin.loadXML(ANode);
          grapheP.dessins.add(Adessin);
          exit;
      end;
      if ANode.NodeName='SHAPE' then begin
          Adessin := Tdessin.create(grapheP);
          Adessin.loadXML(ANode);
          grapheP.dessins.add(Adessin);
          exit;
      end;
      if ANode.NodeName='TRACE' then begin
         zWord := GetIntegerXML(ANode);
         aTrace := TsetTraceXML(zWord);
         grapheP.coordonnee[coordCourante].Trace := traceFromXML(aTrace);
         exit;
      end;
      if (ANode.NodeName='Modelisation') then begin
          extraitChaines;
          MemoModele.lines.Assign(chaines);
          exit;
      end;
      if ANode.NodeName=stCouleur then begin
         grapheP.coordonnee[coordCourante].couleur := GetColorXML(ANode);
         exit;
      end;
      if ANode.NodeName='UseDefault' then begin
         grapheP.useDefault := GetBoolXML(ANode);
         exit;
      end;
      if ANode.NodeName=stLigne then begin
         zByte := GetIntegerXML(ANode);
         grapheP.coordonnee[coordCourante].ligne := Tligne(zByte);
         exit;
      end;
      if ANode.NodeName='MOTIF' then begin
         zByte := GetIntegerXML(ANode);
         grapheP.coordonnee[coordCourante].motif := Tmotif(zByte);
         exit;
      end;
end; // LoadXMLInReg

var i : integer;
begin
   majFichierEnCours := true;
   Curseur := curSelect;
   chaines := TStringList.create;
   chaines.Delimiter := crCR;
   resetCoord;
   configCharge := true;
   if ANode.HasChildNodes then
      for I := 0 to ANode.ChildNodes.Count - 1 do
          LoadXMLInReg(ANode.ChildNodes.Nodes[I]);
   verifCoord;
end;

procedure TfgrapheParam.ValeursParamKeyPress(Sender: TObject; var Key: Char);
begin
     VerifKeyGetFloat(key);
     if key<>#0 then valeursParamChange := true;
end;

procedure TfgrapheParam.FormActivate(Sender: TObject);
begin
     inherited;
     reelClick := false;
     ModeLinBtn.visible := imModeleGr in MenuPermis;
     ImprimeBtn.visible := imBoutonImpr in menuPermis;
     FregressiMain.GrapheConstBtn.down := true;
     TempsTB.Max := pages[pageCourante].nmes;
     TempsTB.pageSize := pages[pageCourante].nmes div 16;
     MajToolBar;
end;

procedure TfgrapheParam.ZoomManuelItemClick(Sender: TObject);
var reponse : integer;
begin
     if ZoomManuelDlg=nil then
        Application.CreateForm(TzoomManuelDlg, ZoomManuelDlg);
     zoomManuelDlg.Echelle := grapheP;
     reponse := ZoomManuelDlg.showModal;
     if reponse in [mrOK,mrNo] then begin
        include(grapheP.modif,gmEchelle);
        grapheP.monde[mondeX].defini := reponse=mrOK;
        PaintBox.invalidate
     end;
end;

procedure TfgrapheParam.EffectueCompile;
var memoActif : boolean;
    i,posFin : integer;
    oldNbreParam : integer;
begin
     memoActif := memoModele=activeControl;
     oldNbreParam := NbreParam[paramGlb];
     LanceCompile;
     if ModeleDefini in etatModele then begin
     if OptionsDlg.AjustageAutoLinCB.checked and
       (ModeleLineaire in etatModele)
         then lanceModele(true)
         else begin
            Perform(WM_Reg_Maj,MajModeleGlb,0);
            if memoActif then begin
               posFin := 0;
               for i := 0 to pred(MemoModele.Lines.count) do
                  posFin := posFin+Length(MemoModele.Lines[i])+2;
               memoModele.selStart := posFin;
               memoModele.selLength := 0;
               MemoModele.setFocus;
            end
         end;
      end;
      if nbreParam[paramGlb]<>oldNbreParam then FormResize(nil);
end;

procedure TfgrapheParam.WMRegCalcul(var Amessage: TWMRegMessage);
begin
     case Amessage.typeMaj of
          calculCompile : effectueCompile;
          calculModele : lanceModele(false);
     end;
end;

procedure TfgrapheParam.CopierModeleItemClick(Sender: TObject);
var z1 : Pchar;
    z2 : array[0..255] of char;
    i : integer;
begin
     z1 := strAlloc(2000);
     strCopy(z1,'');
     with MemoModele do
          for i := 0 to pred(lines.count) do begin
              StrCat(z1,strPcopy(z2,lines[i]));
              StrCat(z1,crCRLF);
          end;
     StrCat(z1,#13#10);
     with MemoResultat do
          for i := 0 to pred(lines.count) do begin
              StrCat(z1,strPcopy(z2,lines[i]));
              StrCat(z1,crCRLF);
          end;
     ClipBoard.SetTextBuf(z1);
     strDispose(z1);
end;

procedure TfgrapheParam.TraceModeleClick(Sender: TObject);
begin
     if TraceAutoCB.checked
        then begin
           exclude(GrapheP.OptionModele,OmManuel);
           LanceModele(false);
        end
        else include(GrapheP.OptionModele,OmManuel)
end;

procedure TfgrapheParam.MemoResultatKeyPress(Sender: TObject; var Key: Char);
begin
    key := #0
end;

procedure TfgrapheParam.PopupMenuAxesPopup(Sender: TObject);
begin
     splitterModele.enabled := ModeAcquisition<>AcqSimulation
end;

procedure TfgrapheParam.Chi2ItemClick(Sender: TObject);
begin
     avecChi2 := chi2Item.checked;
     if avecChi2 then avecEllipse := true;
end;

procedure TfgrapheParam.PopupMenuModelePopup(Sender: TObject);
begin
     chi2Item.checked := avecChi2 and (imLycee in menuPermis);
     chi2Item.visible := imLycee in menuPermis;
end;

procedure TfgrapheParam.TempsTBChange(Sender: TObject);
begin
    if not zoomManuelBtn.down then begin
       grapheP.monde[mondeX].defini := false;
       grapheP.useDefault := false;
    end;
    paintBox.Invalidate
end;

procedure TfgrapheParam.TitreModeleBtnClick(Sender: TObject);
var Dessin : Tdessin;
begin
      Dessin := Tdessin.create(grapheP);
      with Dessin do begin
         isTexte := true;
         avecCadre := true;
         hauteur := 4;
         texte.assign(memoModele.lines);
         with grapheP.monde[mondeX] do
              x2 := (mini+maxi)/2;
         with grapheP.monde[mondeY] do
              y2 := maxi-(maxi-mini)/20;
         x1 := x2;
         y1 := y2;
         vertical := false;
         pen.color := couleurAxeX;
      end;
      grapheP.dessins.add(Dessin);
      PaintBox.invalidate;
end;

procedure TfgrapheParam.ToolButton1Click(Sender: TObject);
var indexV,j,numO : integer;
begin with grapheP do begin
     indexV := (sender as TtoolButton).tag;
     numO := 0;
     for j := 1 to NbreOrdonnee do // test existe déjà  ?
         if indexV=coordonnee[j].codeY then numO := j;
     if numO>0 then begin // supprime
        coordonnee[numO].nomX := '';
        coordonnee[numO].nomY := '';
     end
     else begin // ajoute
         if NbreOrdonnee<MaxOrdonnee
           then begin
              inc(NbreOrdonnee);
              numO := NbreOrdonnee;
           end
           else numO := 1;
           coordonnee[numO].codeY := indexV;
           coordonnee[numO].nomY := grandeurs[indexV].nom;
           coordonnee[numO].codeX := coordonnee[1].codeX;
           coordonnee[numO].nomX := coordonnee[1].nomX;
           coordonnee[numO].iMondeC := mondeY;
           if numO>1 then begin
              coordonnee[numO].trace := coordonnee[1].trace;
              coordonnee[numO].ligne := coordonnee[1].ligne;
           end;
     end;
  include(modif,gmXY);
  paintBox.Invalidate;
end end;

procedure TFgrapheParam.SetPointCourant(i : integer);
begin
    Application.MainForm.perform(WM_Reg_Maj,MajSauvePage,pageCourante);
    pageCourante := succ(i);
    Application.MainForm.perform(WM_Reg_Maj,MajChangePage,0);
end;

procedure TfgrapheParam.EditBidonKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var P : Tpoint;
begin with grapheP do begin
     GetCursorPos(P);
     case key of
          vk_left : dec(P.X);
          vk_right : inc(P.X);
          vk_down : inc(P.Y);
          vk_up : dec(P.Y);
          vk_F9 : begin
              setPanelModele(splitterModele.snapped);
              exit;
          end;
          vk_delete,110 : begin
             P := PaintBox.ScreenToClient(P);
             SetDessinCourant(P.x,P.y);
             if (curseur=curSelect) and (posDessinCourant<>sdNone)
                then with dessins do begin
                    remove(DessinCourant);
                    PaintBox.invalidate;
                end;
             exit;
          end
          else exit;
     end;
     key := 0;
     setCursorPos(P.X,P.Y);
end end;

procedure TfgrapheParam.PagesBtnClick(Sender: TObject);
begin
     if selectPageDlg=nil then Application.CreateForm(TselectPageDlg, selectPageDlg);
     SelectPageDlg.caption := hSelectPageMod;
     SelectPageDlg.appelPrint := true;
     if SelectPageDlg.showModal=mrOK then LanceModele(true)
end;

procedure TfgrapheParam.ImprimeGrItemClick(Sender: TObject);
var bas : integer;
    i : integer;
begin
     if OKreg(OkImprGr,0) then begin
     try
       debutImpressionGr(poPortrait,bas);
       grapheP.versImprimante(HautGrapheGr,bas);
       if not splitterModele.snapped then begin
          DebutImpressionTexte(bas);
          for i := 0 to pred(MemoModele.Lines.Count) do
             ImprimerLigne('  '+memoModele.Lines[i],bas);
          for i := 0 to pred(MemoResultat.Lines.Count) do
              ImprimerLigne('  '+memoResultat.Lines[i],bas);
       end;
       FinImpressionGr;
     except
     end;
     end;
end;

procedure TfgrapheParam.PageSuivBtnClick(Sender: TObject);
var coeff : double;
begin
     coeff := Power(1.023,(sender as Tcomponent).tag);
     Parametres[paramGlb,paramCourant].valeurCourante :=
           Parametres[paramGlb,paramCourant].valeurCourante*Coeff;
     LanceModele(false);
end;

procedure TfgrapheParam.ModeLinBtnClick(Sender: TObject);
var m : TindiceMonde;
begin
    if ChoixModeleGlbDlg=nil then
       Application.createForm(TChoixModeleGlbDlg,ChoixModeleGlbDlg);
    activeToutesPages;
    if NbreModele<maxIntervalles then
    with fonctionTheoriqueGlb[succ(NbreModeleGlb)] do begin
       if grapheP.monde[mondeX].axe<>nil then
          indexX := indexNom(grapheP.monde[mondeX].axe.nom);
       for m := mondeY to mondeSans do
           if grapheP.monde[m].axe<>nil then begin
              indexY := indexNom(grapheP.monde[m].axe.nom);
              break;
           end;
    end;
    ChoixModeleGlbDlg.appelMagnum := true;
    ChoixModeleGlbDlg.PageControl.ActivePage := ChoixModeleGlbDlg.ModMagnum;
    if ChoixModeleGlbDlg.showModal=mrOk then begin
       if ChoixModeleGlbDlg.modeleChoisi=mgManuel
           then begin
              if ChoixModeleGlbDlg.effaceModele then MemoModele.clear;
              with FonctionTheoriqueGlb[NbreModeleGlb] do
                if enTete<>'' then begin
                      MemoModele.lines.Add(enTete+'='+expression);
                      etatModele := [];
                      lanceModele(genreC=g_fonction);
                      TPaintBox(sender).refresh;
                      exit;
                end
           end
           else ModeleMagnum;
    end;
end;

procedure TFgrapheParam.MajModeleGr(Numero : integer);
begin with pages[pageCourante] do begin
     ModeleParametre[Numero].GetParamGlb;
     if ModeleParametre[Numero].ModeleOK then begin
          EffectueModeleGlb(false);
          MajParametres;
     end;
     include(etatModele,ajustementGraphique);
     include(GrapheP.modif,gmEchelle);
     PaintBox.invalidate;
end end;

procedure TfgrapheParam.MemoModeleClick(Sender: TObject);
begin
     if curseur=curModeleGr then setPenBrush(curSelect)
end;

procedure TFgrapheParam.ImprimerGraphe(var bas : integer);
begin
     grapheP.versImprimante(HautGrapheTxt,bas)
end;

procedure TfgrapheParam.MajBtnClick(Sender: TObject);
begin
    PostMessage(handle,WM_Reg_Calcul,CalculCompile,0)
end;

procedure TfgrapheParam.TraceAutoBtnClick(Sender: TObject);
begin
     if TraceAutoCB.checked
        then begin
           exclude(GrapheP.OptionModele,OmManuel);
           PostMessage(handle,WM_Reg_Calcul,CalculModele,0);
        end
        else include(GrapheP.OptionModele,OmManuel)
end;

procedure TfgrapheParam.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     inherited;
     Action := caFree
end;

Function TfgrapheParam.GetPage(X,Y : integer) : integer;
var j : integer;
    indexX,indexY : integer;
    p : TcodePage;
    i : integer;
    Xi,Yi : Integer;
    distance,distanceMin : integer;
begin
     result := -1;
     distanceMin := 64;
     for j := 0 to pred(grapheP.courbes.count) do
         with grapheP.courbes.items[j] do
         if indexModele=0 then begin
              indexX := varX.indexG;
              indexY := varY.indexG;
              for i := DebutC to FinC do begin
                 grapheP.windowRT(valX[i],valY[i],iMondeC,Xi,Yi);
                 distance := round(abs(X-Xi)+abs(Y-Yi));
                 if distance<distanceMin then begin
               	    distanceMin := distance;
                    for p := 1 to NbrePages do if
                      (valX[i]=pages[p].valeurParametre(indexX)) and
                      (valY[i]=pages[p].valeurParametre(indexY))
                       then begin
                          result := p;
                          break;{ for p }
                       end;
                 end; { if distance }
              end;{ for i }
          end;{ indexModele=0 }
end;

procedure TfgrapheParam.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var P : Tpoint;
    changePos : boolean;
begin with grapheP do begin
     if ssAlt in Shift then begin
        case key of
             ord('C') : CoordonneesItemClick(nil);
             ord('I') : ImprimeGrItemClick(nil);
        end;
        exit;
     end;
     if key=vk_F9 then begin
        setPanelModele(splitterModele.snapped);
        key := 0;
        exit
     end;
     if not splitterModele.snapped and
        (key=vk_F2) and
        MajBtn.enabled then begin
        MajBtnClick(sender);
        key := 0;
        exit;
     end;
     GetCursorPos(P);
     P := PaintBox.ScreenToClient(P);
     if (P.X<0) or (P.X>paintBox.width) or
        (P.Y<0) or (P.Y>paintBox.height) then exit;
     changePos := true;
     case key of
          vk_left : dec(P.X);
          vk_right : inc(P.X);
          vk_down : inc(P.Y);
          vk_up : dec(P.Y);
          vk_delete,110 : begin
             changePos := false;
             SetDessinCourant(P.x,P.y);
             if (curseur=curSelect) and (posDessinCourant<>sdNone)
                then with dessins do begin
                    remove(DessinCourant);
                    PaintBox.invalidate;
                end
          end
          else changePos := false;
     end;
     if changePos then begin
        P := PaintBox.ClientToScreen(P);
        setCursorPos(P.X,P.Y);
     end;
end end;

procedure TfgrapheParam.FormKeyPress(Sender: TObject; var Key: Char);

Function Supprime(posSouris : Tpoint;aMonde : TindiceMonde) : boolean;
var i : integer;
    aEquivalence : Tequivalence;
    xi,yi : integer;
    trouve,trouveI : boolean;
begin with grapheP do begin
     trouve := false;
     i := 0;
     while i<equivalences[0].count do begin
            aEquivalence := equivalences[0].items[i];
            with aEquivalence do if (ligneRappel=lrReticule) then begin
               WindowRT(x1,y1,aMonde,xi,yi);
               trouveI := (abs(posSouris.x-xi)+abs(posSouris.y-yi))<12;
               if not trouveI then begin
                  WindowRT(x2,y2,aMonde,xi,yi);
                  trouveI := (abs(posSouris.x-xi)+abs(posSouris.y-yi))<12;
               end;
               if not trouveI then begin
                  WindowRT(ve,pHe,aMonde,xi,yi);
                  trouveI := (abs(posSouris.x-xi)+abs(posSouris.y-yi))<12;
               end;
                // supprime
               if trouveI then begin
                  equivalences[0].Remove(aEquivalence);
                  trouve := true;
               end
               else inc(i);
            end;// with newEq
         end; // while
         if trouve then PaintBox.invalidate;
         result := trouve;
end end;

var posSouris : Tpoint;
    j,p : integer;
    xrS,yrS : double;
    NewEquivalence : Tequivalence;
    icourbe,mondeLoc : integer;
begin
if (key=' ') then begin
    GetCursorPos(PosSouris);
    PosSouris := PaintBox.ScreenToClient(PosSouris);
    case curseur of
    curReticule : with grapheP do begin
        if (PosSouris.X<0) or (PosSouris.X>paintBox.width) or
           (PosSouris.Y<0) or (PosSouris.Y>paintBox.height) then exit;
        with posSouris do iCourbe := courbeProche(x,y);
        if iCourbe<0
            then mondeLoc := mondeY
            else mondeLoc := courbes[iCourbe].iMondeC;
        if supprime(posSouris,mondeLoc) then exit;
         mondeRT(posSouris.x,posSouris.y,mondeLoc,xrS,yrS);
         NewEquivalence := Tequivalence.Create(0,0,0,0,xrS,yrS,
                   0,grapheP);
         NewEquivalence.mondepH := mondeLoc;
         NewEquivalence.ligneRappel := lrReticule;
         equivalences[0].Add(NewEquivalence);
         PaintBox.invalidate;
   end;// curReticule
   curReticuleData : with grapheP do begin
        if supprime(posSouris,curseurOsc[curseurData1].mondeC) then exit;
        for j := curseurData1 to curseurData2 do
        if curseurOsc[j].mondeC<>mondeX then begin
            NewEquivalence := Tequivalence.Create(0,0,0,0,
                         curseurOsc[j].xr,curseurOsc[j].yr,
                         0,grapheP);
            NewEquivalence.mondepH := curseurOsc[j].mondeC;
            NewEquivalence.ligneRappel := lrReticule;
            equivalences[0].Add(NewEquivalence);
         end;
         PaintBox.invalidate;
   end;// curReticuleData
   curSelect : begin
         p := GetPage(posSouris.x,posSouris.y);
         if p>0 then begin
            Pages[p].active := not Pages[p].active;
            include(grapheP.modif,gmXY);
            PaintBox.invalidate;
         end;
   end;  // curSelect
   end;// case curseur
end end;

procedure TfgrapheParam.FormShortCut(var Msg: TWMKey;
  var Handled: Boolean);
begin
     if msg.charCode=vk_delete then begin
        if (curseur=curSelect) and (grapheP.DessinCourant<>nil)
                then with grapheP.dessins do begin
                    remove(grapheP.DessinCourant);
                    PaintBox.invalidate;
                end;
     end;
end;

procedure TfgrapheParam.EditValeurExit(Sender: TObject);
begin
   ValideParam((sender as Tcomponent).tag,true)
end;

procedure TfgrapheParam.EditValeurKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var paramLoc : integer;
begin
     paramLoc := (sender as Tcomponent).tag;
     if toucheValidation(key)
        then begin
           valideParam(paramLoc,true);
           case key of
                vk_up,vk_prior : begin
                   dec(paramLoc);
                   if paramLoc>0 then
                       EditValeur[paramLoc].setFocus;
                end;
                vk_down,vk_next,vk_tab,vk_return : begin
                   inc(paramLoc);
                   if paramLoc<=NbreParam[paramGlb] then
                       EditValeur[paramLoc].setFocus;
                end;
           end;
        end
        else if (key=vk_F9) and
                (splitterModele.enabled)
                  then setPanelModele(splitterModele.snapped);
     paramCourant := paramLoc;
end;

procedure TfgrapheParam.EditValeurKeyPress(Sender: TObject; var Key: Char);
begin
     VerifKeyGetFloat(key);
     if key<>#0 then begin
           ValeursParamChange := true;
           TraceAutoCB.checked := false;
     end;
end;

procedure TfgrapheParam.EnregistrerGrapheItemClick(Sender: TObject);
begin
    saveDialog.options := saveDialog.options-[ofOverwritePrompt];
    if saveDialog.Execute then
       GrapheP.VersFichier(saveDialog.fileName);
end;

Procedure TFgrapheParam.ValideParam(paramV : integer;maj : boolean);
var valeurLoc : double;
begin
     if ValeursParamChange then begin
        try
          valeurLoc := GetFloat(editValeur[paramV].text);
          parametres[paramGlb,paramV].valeurCourante := valeurLoc;
          if maj then PostMessage(handle,WM_Reg_Calcul,CalculModele,0);
          ValeursParamChange := false;
        except
          EditValeur[paramV].SetFocus
        end;
     end
end;

procedure TfgrapheParam.SigneClick(Sender: TObject);
begin
     ModifParam((sender as Tcomponent).tag,-1)
end;

procedure TfgrapheParam.SupprReticuleClick(Sender: TObject);
begin
     with GrapheP do begin
         equivalences[0].clear;
         paintBox.invalidate;
     end;
end;

procedure TfgrapheParam.PlusRapideClick(Sender: TObject);
begin
     ModifParam((sender as Tcomponent).tag,2)
end;

procedure TfgrapheParam.PlusClick(Sender: TObject);
begin
     ModifParam((sender as Tcomponent).tag,CoeffParam)
end;

procedure TfgrapheParam.MoinsClick(Sender: TObject);
begin
     ModifParam((sender as Tcomponent).tag,1/CoeffParam)
end;

procedure TfgrapheParam.MoinsRapideClick(Sender: TObject);
begin
     ModifParam((sender as Tcomponent).tag,0.5)
end;

procedure TFGrapheParam.ModifParam(paramM : integer;coeff : double);
begin
     if ModeleEnCours then exit;
     if valeursParamChange then valideParam(paramM,true);
     parametres[paramGlb,paramM].valeurCourante :=
              parametres[paramGlb,paramM].valeurCourante*coeff;
     if TraceAutoCB.checked
          then PostMessage(handle,WM_Reg_Calcul,CalculModele,0)
          else MajParametres
end;

procedure TFgrapheParam.ModeleMagnum;
var j,debut,fin : integer;
begin with ModeleParametre[NbreModeleGlb] do begin
     if ChoixModeleGlbDlg=nil then
        Application.createForm(TChoixModeleGlbDlg,ChoixModeleGlbDlg);
//     isModeleGlb := true;
     init(ChoixModeleGlbDlg.ModeleChoisi,grapheP,NbreModeleGlb,NbreModeleGlb);
     debut := 0;fin := pred(NbrePages);
     initialiseParametre(debut,fin,false);
     if not ModeleOK then begin
        afficheErreur(erModeleGr,0);
        NbreModele := 0;
        exit;
     end;
     MajModelePermis := false;
     if ChoixModeleGlbDlg.effaceModele then MemoModele.clear;
     for j := 0 to pred(expression.count) do
         MemoModele.lines.Add(expression[j]);
     MajModelePermis := true;
     MemoModeleChange(nil);
     etatModele := [];
     Resize;
     IsModeleMagnum := true;
     LanceCompile;
     include(GrapheP.modif,gmModele);
     if NbreModele=1
        then setPenBrush(curModeleGr)
        else setPenBrush(curSelect);
     MajModeleGr(NbreModele);
     LanceModele(OptionsDlg.AjustageAutoGrCB.checked);
end end;

Procedure TFgrapheParam.SetUniteParamGlb;
begin
    if chercheUniteParam then chercheUniteParametreGlb;
    include(etatModele,UniteParamDefinie);
end;

procedure TfgrapheParam.ParamBtnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  RepeatTimer.Interval := InitRepeatPause;
  RepeatTimer.Enabled  := True;
  TimerButton := sender as TspeedButton;
end;

procedure TfgrapheParam.ParamBtnMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  RepeatTimer.Enabled  := False
end;

procedure TfgrapheParam.RepeatTimerTimer(Sender: TObject);
begin
  RepeatTimer.Interval := RepeatPause;
  if csLButtonDown in TimerButton.ControlState
     then begin
        TimerButton.onClick(timerButton);
        Application.processMessages;
     end
     else RepeatTimer.Enabled := False
end;

procedure TfgrapheParam.SelectItemClick(Sender: TObject);
var Origin : Tpoint;
    newCurseur : Tcurseur;
begin with grapheP do begin
     if curseur=curReticule then TraceReticule(1); // efface
     dessinCourant := nil;
     newCurseur := Tcurseur((sender as Tcomponent).tag);
     setPenBrush(newCurseur);
     case curseur of
          curReticule : begin
              GetCursorPos(Origin);
              Origin := ScreenToClient(Origin);
              InitReticule(Origin.x,Origin.y);
          end;
          curLigne,curTexte : begin
             DessinCourant := Tdessin.create(grapheP);
             DessinCourant.isTexte := curseur=curTexte;
          end;
     end;
end end;

procedure TfgrapheParam.CurseurBtnClick(Sender: TObject);
begin
   (sender as TtoolButton).CheckMenuDropdown
end;

procedure TfgrapheParam.IdentPagesItemClick(Sender: TObject);
begin
     IdentPagesItem.checked := not IdentPagesItem.checked;
     IdentPagesBtnClick(sender);
end;

procedure TfgrapheParam.IdentPagesBtnClick(Sender: TObject);
begin
    if not grapheP.grapheOK then exit;
    if sender=IdentPagesItem then
       IdentPagesBtn.down := IdentPagesItem.checked;
    paintBox.invalidate
end;

procedure TfgrapheParam.ActiveToutesPages;
var p : TcodePage;
begin
     if IdentPagesBtn.down then grapheP.courbes[0].TexteC.clear;
     for p := 1 to NbrePages do begin
         pages[p].active := true;
         if IdentPagesBtn.down then
             grapheP.courbes[0].texteC.Add(Pages[p].commentaireP)
     end;
end;

procedure TfgrapheParam.LabelYMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var P : Tpoint;
begin
     P := (sender as Tlabel).ClientToScreen(point(X,Y));
     P := paintBox.ScreenToClient(P);
     FormMouseMove(sender,shift,P.x,P.Y);
end;

procedure TFgrapheParam.SetPanelModele(NouvelEtat : boolean);
var i : integer;
begin
   if not splitterModele.enabled or not grapheP.grapheOK then NouvelEtat := false;
   if NouvelEtat
      then begin
           if not(splitterModele.snapped) then begin
              splitterModele.snapped := false;
           end;
           ModelinBtn.visible := imModeleGr in MenuPermis;
           TraceAutoCB.checked := not(OmManuel in GrapheP.OptionModele);
           VerifGraphe := false;
           PanelModele.refresh;
           if not (ModeleDefini in etatModele) then begin
                activeToutesPages;
                LanceCompile;
                MajParametres;
           end;
           TraceAutoCB.checked := not(OmManuel in GrapheP.OptionModele);
           if not(ModeleDefini in etatModele)
               then begin
                  LanceCompile;
                  MajParametres;
               end;
           Resize;
           MemoModele.setFocus;
      end
      else begin
        SplitterModele.snapped := true;
        LabelErreur.Visible := false;
        if ModeleDefini in etatModele then
        for i := 1 to GrapheP.NbreOrdonnee do
            with GrapheP.Coordonnee[i] do begin
                 include(trace,trLigne);
                 ligne := liModele;
                 include(trace,trPoint);
            end;
     end;
end;

procedure TFgrapheParam.MajToolBar;
var nbre,i,iC : integer;
    j : TcodeParam;
begin
         Nbre := NbreParam[paramNormal]+NbreConst;
         for i := 0 to pred(ToolBarGrandeurs.ButtonCount) do begin
             ToolBarGrandeurs.Buttons[i].visible := i<Nbre;
             if i<NbreConst then begin
                  iC := indexConst[i];
                  ToolBarGrandeurs.Buttons[i].caption := grandeurs[iC].nom;
                  ToolBarGrandeurs.Buttons[i].tag := iC;
             end
             else if i<nbre then begin
                  j := i-NbreConst+1;
                  ToolBarGrandeurs.Buttons[i].caption := parametres[paramNormal,j].nom;
                  ToolBarGrandeurs.Buttons[i].tag := parametre0 + j;
             end;
         end;
end;

procedure TFgrapheParam.SetTaillePolice;
begin
         majModelePermis := false;
         VerifMemo(MemoModele);
         majModelePermis := true;
         verifMemo(memoResultat);
         AjustePanelModele;
end;

procedure TFgrapheParam.AjustePanelModele;
const HauteurMini = 76;
var hauteurAjuste,hauteurPanel,hauteurMemo,
    hauteurResultat,i : integer;
begin
     hauteurPanel := ClientHeight-ToolbarModele.height;
// valeurs par défaut
     if MemoModele.lines.count<3
        then i := 3
        else i := MemoModele.lines.count;
     hauteurMemo := (abs(memoModele.Font.height)+4)*(i+2)+20; // 20 = titre GroupBox
     if NbreParam[paramNormal]<3
        then i := 3
        else i := NbreParam[paramNormal];
     HauteurAjuste := (PanelParam1.height+2)*i+PanelAjusteBtn.height+2;
     hauteurResultat := hauteurPanel-hauteurMemo-HauteurAjuste;
// on teste si résultat pas trop petit
     if (hauteurResultat<HauteurMini) then
        if ((HauteurPanel-HauteurMemo-HauteurMini)>HauteurMini)
           then begin
              HauteurAjuste := HauteurPanel-HauteurMemo-HauteurMini;
              { on ajuste panelAjuste résultat à mini }
           end
           else begin // on divise en trois
              HauteurMemo := HauteurPanel div 3;
              HauteurAjuste := hauteurMemo;
           end;
// on affecte
     PanelAjuste.height := hauteurAjuste;
end;

end.

