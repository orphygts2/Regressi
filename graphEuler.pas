unit graphEuler;

interface

uses Windows, Classes, Graphics, Forms, Controls, Menus, ExtCtrls,
     system.UITypes,System.ImageList,
     Dialogs, sysUtils, Buttons, StdCtrls, Grids, Messages, printers,
     ComCtrls, ToolWin, Spin, ImgList, math,
     Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc,
     constreg, maths, regutil, uniteKer, statCalc, compile, graphKer;

type
  TFgrapheEuler = class(TForm)
    PanelModele: TPanel;
    PanelAjuste: TPanel;
    MenuAxes: TPopupMenu;
    PaintBoxPrinc: TPaintBox;
    ClipBitmapItem: TMenuItem;
    ClipMetafileItem: TMenuItem;
    MemoModeleGB: TGroupBox;
    ResultatGB: TGroupBox;
    HeaderXY: TStatusBar;
    MajTimer: TTimer;
    PanelCentral: TPanel;
    SplitterModele: TSplitter;
    SaveDialog: TSaveDialog;
    memoResultat: TRichEdit;
    SauverGraphe: TMenuItem;
    PanelPrinc: TPanel;
    RepeatTimer: TTimer;
    ToolBar: TToolBar;
    CoordonneesBtn: TToolButton;
    ZommAvantBtn: TToolButton;
    ZoomAutoBtn: TToolButton;
    ToolButton9: TToolButton;
    ImprimeBtn: TToolButton;
    CopierBtn: TToolButton;
    ToolButton20: TToolButton;
    Bevel: TBevel;
    memoModele: TRichEdit;
    copierAsJPEGitem: TMenuItem;
    Panel10: TPanel;
    SpeedButton41: TSpeedButton;
    SpeedButton42: TSpeedButton;
    SpeedButton43: TSpeedButton;
    SpeedButton44: TSpeedButton;
    SpeedButton45: TSpeedButton;
    EditValeur1: TEdit;
    Panel11: TPanel;
    SpeedButton36: TSpeedButton;
    SpeedButton37: TSpeedButton;
    SpeedButton38: TSpeedButton;
    SpeedButton39: TSpeedButton;
    SpeedButton40: TSpeedButton;
    Edit8: TEdit;
    Panel9: TPanel;
    SpeedButton31: TSpeedButton;
    SpeedButton32: TSpeedButton;
    SpeedButton33: TSpeedButton;
    SpeedButton34: TSpeedButton;
    SpeedButton35: TSpeedButton;
    Edit7: TEdit;
    DeltatLabel: TLabel;
    Label1: TLabel;
    MajBtn: TSpeedButton;
    iBtn: TSpeedButton;
    iMoinsBtn: TSpeedButton;
    DeltatBtn: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    Label2: TLabel;
    Panel6: TPanel;
    SpeedButton16: TSpeedButton;
    SpeedButton17: TSpeedButton;
    SpeedButton18: TSpeedButton;
    SpeedButton19: TSpeedButton;
    SpeedButton20: TSpeedButton;
    SpeedButton1: TSpeedButton;
    Edit4: TEdit;
    Panel7: TPanel;
    SpeedButton21: TSpeedButton;
    SpeedButton22: TSpeedButton;
    SpeedButton23: TSpeedButton;
    SpeedButton24: TSpeedButton;
    SpeedButton25: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Edit5: TEdit;
    Panel8: TPanel;
    SpeedButton26: TSpeedButton;
    SpeedButton27: TSpeedButton;
    SpeedButton28: TSpeedButton;
    SpeedButton29: TSpeedButton;
    SpeedButton30: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Edit6: TEdit;
    NbrePasLabel: TLabel;
    NpasSB: TSpinButton;
    VarBtn: TSpeedButton;
    tBtn: TSpeedButton;
    ToolButton1: TToolButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ZoomAvantItemClick(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure CoordonneesItemClick(Sender: TObject);
    procedure ZoomAutoItemClick(Sender: TObject);
    procedure CopierItemClick(Sender: TObject);
    procedure PaintBoxPaint(Sender: TObject);
    procedure MemoModeleChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    Procedure ValideParam(paramCourant : integer;maj : boolean);
    procedure ValeursParamKeyPress(Sender: TObject; var Key: Char);
    procedure MemoResultatKeyPress(Sender: TObject; var Key: Char);
    procedure ClipBitmapItemClick(Sender: TObject);
    procedure MajBtnClick(Sender: TObject);
    procedure MajTimerTimer(Sender: TObject);
    procedure MemoModeleKeyPress(Sender: TObject; var Key: Char);
    procedure ImprModeleBtnClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure memoModeleKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SauverGrapheClick(Sender: TObject);
    procedure EditValeurExit(Sender: TObject);
    procedure EditValeurKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditValeurKeyPress(Sender: TObject; var Key: Char);
    procedure MoinsRapideBtnClick(Sender: TObject);
    procedure MoinsBtnClick(Sender: TObject);
    procedure PlusBtnClick(Sender: TObject);
    procedure PlusRapideBtnClick(Sender: TObject);
    procedure SigneBtnClick(Sender: TObject);
    procedure ModifParam(paramCourant : integer;coeff : double);
    procedure ParamBtnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ParamBtnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RepeatTimerTimer(Sender: TObject);
    procedure SplitterModeleCanResize(Sender: TObject;
      var NewSize: Integer; var Accept: Boolean);
    procedure copierAsJPEG(Sender: TObject);
    procedure iBtnClick(Sender: TObject);
    procedure ValeurInitClick(Sender: TObject);
    procedure NpasSBUpClick(Sender: TObject);
    procedure NpasSBDownClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
      indexModeleX,indexModeleY,indexAbscisse : integer;
      ParamEditCourant : integer;
      ValeursParamChange : boolean;
      Curseur,SauveCurseur : Tcurseur;
      zoneZoom : Trect;
      oldKey : char;
      EntreeValidee : boolean;
      deltaReg : tableauReal;
      erreurCalcul,erreurParam : boolean;
      ErreurModele : array[TcodeIntervalle] of boolean;
      PosErreurModele : array[TcodeIntervalle] of integer;
      MajModelePermis : boolean;
      SelStartMod : integer;
      editValeur : array[TcodeParam] of Tedit;
      panelParam : array[TcodeParam] of Tpanel;
      ParamInit : array[TcodeParam] of boolean;
      TimerButton : TSpeedButton;
      GraphePrinc : TgrapheReg;
      etatModele : TsetEtatModele;
      oldModeleCalcule : boolean;
      oldvaleurYEuler : array[TcodeIntervalle] of Tvecteur;
      oldFinC : integer;
      oldParam,oldNbre : string;
      nbrePas : integer;
      panelValeurInit,panelValeurParam : array[1..3] of Tpanel;
      changementMemo : boolean;
      orthoAverifier : boolean;
      Procedure VerifCoordonnee;
      procedure SetPenBrush(c : Tcurseur);
      procedure MajParametres;
      procedure CompileModele(var PosErreur,LongErreur : integer);
      procedure ConstruitModele;
      Procedure EffectueModele;
      Procedure LanceCompile;
      procedure verifParametres;
      procedure SetTaillePolice;
      procedure SetParamEdit;
      Procedure SetCoordonnee;
      procedure NbrePasChange(NewNbre : integer);
  protected
      procedure WMRegMaj(var Msg : TWMRegMessage); message WM_Reg_Maj;
      procedure WMRegCalcul(var Msg : TWMRegMessage); message WM_Reg_Calcul;
      procedure WMRegModele(var Msg : TWMRegMessage); message WM_Reg_Modele;
  public
      configCharge : boolean;
      majFichierEnCours : boolean;
      procedure EcritConfig;
      procedure LitConfig;
      procedure EcritConfigXML(ANode : IXMLNOde);
      procedure LitConfigXML(ANode : IXMLNOde);
  end;

var FgrapheEuler : TFgrapheEuler;

implementation

uses
     ClipBrd, fspec, regmain, options, aideKey,
     systDiff, Regdde, CoordEuler, Valeurs;

{$R *.DFM}

type
   EEulerError = class(Exception);

const
   MaxParamEuler = 6;
   CoeffParam = 1.023;
   CoeffParamRapide = 2;
   InitRepeatPause = 400;  { pause before repeat timer (ms) }
   RepeatPause     = 100;  { pause before hint window displays (ms)}
   motifData = mCroix;   

// Répond aux mouvements de la souris
procedure TFgrapheEuler.FormMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
var hintLoc : string;
begin // FormMouseMove
with graphePrinc do begin
   if not grapheOK then exit;
   hintLoc := '';
   case curseur of
        curZoomAv : if ssLeft in Shift
           then with canvas,zoneZoom do begin
               Rectangle(left,top,right,bottom); { efface l'ancien }
               right := X;
               bottom := Y;
               Rectangle(left,top,right,bottom);
               hintLoc := stFinZoom;
          end
          else hintLoc := stDebutZoom;
        curSelect : TgraphicControl(sender).cursor := crDefault;
   end;
   if hintLoc='' then hintLoc := hClicDroit;
   TgraphicControl(sender).hint := hintLoc;
   headerXY.simpleText := hintLoc;
end end; // FormMouseMove

procedure TFgrapheEuler.ZoomAvantItemClick(Sender: TObject);
begin
    if graphePrinc.grapheOK then begin
       SauveCurseur := curseur;
       setPenBrush(curZoomAv)
    end;
end; // zoomAvant 

procedure TFgrapheEuler.SetPenBrush(c : Tcurseur);
begin with graphePrinc,canvas,paintBox do begin
  curseur := c;
  Pen.Color := PColorReticule;
  Pen.style := PstyleReticule;
  Pen.mode := pmNotXor;
  if curseur=curZoomAv
       then begin
          Brush.color := BrushCouleurZoom;
          cursor := crZoom;
          Brush.style := bsSolid;
       end
       else begin
          cursor := crDefault;
          Brush.style := bsClear;
          Brush.color := clWindow;
       end;
end end;

procedure TFgrapheEuler.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin // MouseDown
   if (ssRight in shift) then exit; // clic droit donc menu contextuel
   if not graphePrinc.grapheOK then exit;
   if (curseur=curSelect) and
      (ssDouble in shift) then if graphePrinc.isAxe(x,y)>0
              then CoordonneesItemClick(nil);
   if curseur=curZoomAv then zoneZoom := rect(X,Y,X,Y);
end; // FormMouseDown

procedure TFgrapheEuler.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

Procedure AffecteZoomAv;
begin
  with zoneZoom do begin
        graphePrinc.canvas.Rectangle(left,top,right,bottom);{ efface }
        right := X;
        bottom := Y;
        setPenBrush(sauveCurseur);
        if (left=right) or (bottom=top) then exit;
        graphePrinc.affecteZoomAvant(zoneZoom,true);
   end;
   include(graphePrinc.modif,gmEchelle);
   paintBoxPrinc.invalidate;
end; // affecteZoomAv

begin // FormMouseUp
  if (x<0) or (y<0) then exit;
  if Button=mbRight then begin
     if (y<graphePrinc.limiteCourbe.top) or
        (y>graphePrinc.limiteCourbe.bottom)
              then CoordonneesItemClick(nil);
     exit;
  end; // bouton droit
  if curseur=curZoomAv then affecteZoomAv;
end; // FormMouseUp

procedure TFgrapheEuler.FormActivate(Sender: TObject);
begin
     ImprimeBtn.visible := imBoutonImpr in menuPermis;
     etatModele := [];
     MajBtn.enabled := true;
     FregressiMain.GrapheEulerBtn.down := true;
end;

procedure TFgrapheEuler.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    MajTimer.Enabled := false;
    RepeatTimer.Enabled := false;
    Action := caFree
end;

procedure TFgrapheEuler.FormCreate(Sender: TObject);
begin
  FcoordonneesEuler := TFcoordonneesEuler.create(self);
  oldkey := #0;
  GraphePrinc := TgrapheReg.create;
  with GraphePrinc do begin
     paintBox := paintBoxPrinc;
     canvas := paintBoxPrinc.canvas;
  end;
  curseur := curSelect;
  entreeValidee := false;
  setTaillePolice;
  NbrePas := 16;
  panelValeurInit[1] := Panel6;
  panelValeurInit[2] := Panel7;
  panelValeurInit[3] := Panel8;  
  panelValeurParam[1] := Panel9;
  panelValeurParam[2] := Panel11;
  panelValeurParam[3] := Panel10;
  ResizeButtonImagesforHighDPI(self);
end; // formCreate

procedure TFgrapheEuler.SetCoordonnee;

Procedure AjouteVariab;
var c : shortInt;
    courbeVariab,courbeAdd : Tcourbe;
    iX,iY : byte;
begin with graphePrinc,pages[pageCourante] do begin
      with Coordonnee[1] do begin
           iX := CodeX;
           iY := CodeY;
     end;
     courbeVariab := AjouteCourbe(valeurVar[iX],valeurVar[iY],mondeY,nmes,
              grandeurs[iX],grandeurs[iY],pageCourante);
     with coordonnee[1] do courbeVariab.setStyle(clBlack,psSolid,motifData,'');
     if avecEllipse then begin
         courbeVariab.IncertX := incertVar[iX];
         courbeVariab.IncertY := incertVar[iY];
     end;
     courbeVariab.Trace := [trPoint];
     if ModeleDefini in etatModele then begin
         for c := 1 to NbreModele do with fonctionTheorique[c] do
               if (iY=indexY) and (iX=indexX) and not(implicite) then begin
                      courbeVariab.courbeExp := true;
                      courbeVariab.IndexModele := c;
                      if modeleCalcule then begin
                         courbeAdd := AjouteCourbe(fonctionTheorique[indexModeleX].valeurYEuler,
                                         valeurYEuler,mondeY,nmes,
                                         grandeurs[iX],grandeurs[iY],pageCourante);
                         courbeAdd.IndexModele := c;
                         courbeAdd.Trace := [trLigne,trPoint];
                         courbeAdd.setStyle(clBlue,psSolid,mLigneEuler,'');
                      end;// modeleCalcule
                      if oldModeleCalcule  then begin
                         courbeAdd := AjouteCourbe(oldvaleurYEuler[indexModeleX],
                              oldValeurYEuler[c],mondeY,oldFinC,
                              courbes[1].varX,
                              courbes[1].varY,pageCourante);
                         courbeAdd.IndexModele := -c;
                         courbeAdd.Trace := [trLigne,trPoint];
                         courbeAdd.setStyle(clSkyBlue,psSolid,mLigneEuler,'');
                     end;
               end; // if
       end; // ModeleDefini 
end end; // AjouteVariab

begin // SetCoordonnee
with graphePrinc do begin
   VerifCoordonnee;
   Pages[pageCourante].tri;
   with Coordonnee[1] do
     if codeX<>grandeurInconnue then AjouteVariab;
   modif := [gmEchelle];
   grapheOK := true;
end end; // SetCoordonnee

procedure TFgrapheEuler.VerifCoordonnee;
var i : integer;
begin with graphePrinc do begin
    with coordonnee[1] do begin
        codeY := indexNom(nomY);
        if (codeY<>grandeurInconnue) and
           not (grandeurs[codeY].genreG in [variable,constante,constanteGlb])
           then codeY := grandeurInconnue;
        codeX := indexNom(nomX);
        if (codeX<>grandeurInconnue) and
           not (grandeurs[codeX].genreG in [variable,constante,constanteGlb])
           then codeX := grandeurInconnue;
    end;
    nbreOrdonnee := 0;
    with coordonnee[1] do
        if (codeX<>grandeurInconnue) and
           (codeY<>grandeurInconnue)
           then inc(nbreOrdonnee);
    for i := 2 to maxOrdonnee do with coordonnee[i] do begin
           codeX := grandeurInconnue;
           codeY := grandeurInconnue;
           iMondeC := mondeY;
           nomX := '';
           nomY := '';
           ligne := liDroite;
    end;
    if nbreOrdonnee=0 then begin
       for i := mondeX to MaxOrdonnee do Monde[i].graduation := gLin;
       with coordonnee[1] do begin
          codeX := indexVariab[0];
          nomX := grandeurs[codeX].nom;
          curseur := curSelect;
          codeY := indexVariab[1];
          nomY := grandeurs[codeY].nom;
          iMondeC := mondeY;
          nbreOrdonnee := 1;
       end;
    end; // nbreOrdonnee=0
    indexModeleX := 1;
    indexModeleY := 1;
    indexAbscisse := coordonnee[1].codeX;
    for i := 1 to NbreModele do begin
        if fonctionTheorique[i].indexY=coordonnee[1].codeX then
           indexModeleX := i;
        if fonctionTheorique[i].indexY=coordonnee[1].codeY then
           indexModeleY := i;
    end;
end end;

procedure TFgrapheEuler.CoordonneesItemClick(Sender: TObject);
begin with FcoordonneesEuler do begin
      if not graphePrinc.grapheOK then exit;
      Transfert.AssignEntree(graphePrinc);
      if FcoordonneesEuler.ShowModal=mrOK then begin
          Curseur := curSelect;
          orthoAverifier := true;
          Transfert.AssignSortie(graphePrinc);
          include(graphePrinc.modif,gmXY);
          PaintBoxPrinc.refresh;
     end;
end end; // Coordonnees

procedure TFgrapheEuler.ZoomAutoItemClick(Sender: TObject);
begin with graphePrinc do begin
     include(modif,gmEchelle);
     monde[mondeX].defini := false;
     useDefault := false;
     useDefaultX := false;
     autoTick := true;
     graphePrinc.PaintBox.invalidate;
end end; // ZoomAutoItemClick

procedure TFgrapheEuler.CopierItemClick(Sender: TObject);
begin
    graphePrinc.VersMetaFile('')
end;

procedure TFgrapheEuler.WMRegMaj(var Msg : TWMRegMessage);

var LmodifParam : boolean;
begin with msg,graphePrinc do begin { WMRegMaj }
      Modif := [gmXY]; { le + général }
      case TypeMaj of
          MajNom : MajNomGr(codeMaj);
          MajSauvePage : exit;
          MajChangePage,MajSupprPage : begin
              if ([ModeleDefini,ModeleConstruit] <= etatModele)
                 then PostMessage(handle,Wm_Reg_Calcul,CalculModele,0);
              exit;
          end;
          MajAjoutPage : ;
          MajSelectPage,MajGroupePage : modif := [gmXY,gmOptions];
          MajValeurAcq,MajValeurGr,MajValeur,MajAjoutValeur,MajIncertitude : begin
              Modif := [gmValeurs];
              MemoModeleChange(nil);
          end;
          MajSupprPoints : GraphePrinc.Modif := [gmValeurs];
          MajTri : if active then exit;
          MajPolice : begin
             setTaillePolice;
             Modif := [];
             exit;
          end;
          MajPreferences : begin
             ImprimeBtn.visible := imBoutonImpr in menuPermis;
             exit;
          end;
          MajModele,MajVide : exit;
          MajGrandeur : if (etatModele<>[])
            // and not ajoutDerivee
             then begin
               etatModele := [];
               MajTimer.enabled := true;
                    // pour prévenir modif etatModele
             end;
          MajUnites : exclude(etatModele,UniteParamDefinie);
          MajUnitesParam : exit;
          MajFichier : exit;
          MajNumeroMesure : exit;
          MajOptionsGraphe : begin
                if OgQuadrillage in optionGrapheDefault
                     then include(optionGraphe,OgQuadrillage)
                     else exclude(optionGraphe,OgQuadrillage);
                if OgZeroGradue in optionGrapheDefault
                     then include(optionGraphe,OgZeroGradue)
                     else exclude(optionGraphe,OgZeroGradue);
          end;
      end;
      grandeurs[cDeltat].nom := DeltaMaj+grandeurs[0].nom;
      grandeurs[cDeltat].nomUnite := Grandeurs[0].nomUnite;
      grandeurs[cDeltat].fonct.expression := 'Pas de calcul pour Euler';
      deltatBtn.caption := grandeurs[cDeltat].nom;
      LModifParam := TypeMaj in [MajChangePage,MajGroupePage,MajSupprPage,MajAjoutPage,MajModele];
      if TypeMaj in [MajIncertitude,MajAjoutPage,MajValeur,MajValeurAcq]
          then begin
             pages[PageCourante].modeleCalcule := false;
             pages[PageCourante].modeleErrone := false;
          end;
      if LModifParam then begin
           MajParametres;
           include(Modif,gmValeurModele);
           PaintBoxPrinc.refresh;
      end;
      if typeMaj=MajSupprPoints then begin
           pages[pageCourante].ModeleCalcule := false;
           etatModele := [];
      end;
end end; // WMRegMaj

procedure TFgrapheEuler.PaintBoxPaint(Sender: TObject);

procedure AffecteModele;
var i : integer;
begin with graphePrinc do begin
for i := 0 to pred(courbes.count) do with courbes[i],Pages[pageCourante] do begin
    if (indexModele>0) and
        not courbeExp and
       (indexModele<=NbreModele) then
        with fonctionTheorique[indexModele] do begin
               DebutC := 0;
               if ModeleCalcule
                    then begin
                        valY := fonctionTheorique[indexModele].valeurYEuler;
                        FinC := NbrePas;
                        valX := fonctionTheorique[indexModeleX].valeurYEuler;
                        couleur := clBlue;
                        motif := mLigneEuler;
                        trace := [trLigne,trPoint];
                    end
                    else begin
                        valY := valeurVar[indexY];
                        FinC := pred(nmes);
                        valX := valeurVar[indexAbscisse];
                        couleur := courbes[0].couleur;
                        motif := motifData;
                        trace := [trPoint];
                    end;
       end; { with }
    if (indexModele<0) and
        not courbeExp and
       (-indexModele<=NbreModele) then begin
               DebutC := 0;
               if oldModeleCalcule and FcoordonneesEuler.oldParamCB.checked
                    then begin
                       FinC := oldFinC;
                       valX := oldValeurYEuler[indexModeleX];
                       valY := oldValeurYEuler[-indexModele];
                       FinC := oldFinC;
                       couleur := clSkyBlue;
                       motif := mLigneEuler;
                       trace := [trLigne,trPoint];
                    end
                    else begin
                        valY := valeurVar[fonctionTheorique[-indexModele].indexY];
                        FinC := pred(nmes);
                        valX := valeurVar[indexAbscisse];
                        couleur := courbes[0].couleur;
                        motif := motifData;
                        trace := [trPoint];
                    end;
       end; { with }
end {i}
end end; // affecteModele

var
	tempsTrouve,varTrouve : boolean;
  enTeteTemps,enTeteVar : string;
  i : integer;
label finProc;
begin // PaintBoxPrinc Paint
with graphePrinc do begin
        if (pageCourante=0) or lecturePage then exit;
        grapheOK := (NbreVariab>1) and (NbrePages>0);
        if not grapheOK then begin
           raz;
           optionGraphe := optionGrapheDefault;
           goto finProc;
        end;
        canvas := paintBoxPrinc.canvas;
        limiteFenetre := paintBoxPrinc.clientRect;
        UseDefault := false;
        Screen.Cursor := crHourGlass;
        PanelAjuste.enabled := false;
        if (([gmXY,gmModele,gmPage,gmValeurs]*modif)<>[]) or
           (courbes.count=0) then begin
               courbes.clear;
               setCoordonnee;
        end;
        if (modif<>[]) and
           pages[pageCourante].modeleCalcule
           and (ModeleDefini in etatModele) then
                AffecteModele;
        chercheMonde;
        if not grapheOK then goto finProc;
        if not FcoordonneesEuler.oldParamCB.checked then Dessins.clear; //??
        canvas.Pen.mode := pmCopy;
        setEchelle(graphePrinc.canvas);
        canvas.brush.Color := clWindow;
        canvas.brush.style := bsSolid;
        with paintBoxPrinc.clientRect do
             canvas.FillRect(rect(left,top,right,bottom));
        avecBorne := false;
        draw;
        resetEchelle;
        modif := [];
        if verifierOrtho and orthoAverifier then begin
             afficheErreur(erOrtho,0);
             verifierOrtho := false;
             orthoAverifier := false;
        end;
        finProc :
        Screen.Cursor := crDefault;
        PanelAjuste.enabled := true;
        with pages[pageCourante] do
           deltatLabel.caption := deltaMaj+grandeurs[0].formatNomEtUnite((valeurVar[0,pred(nmes)]-valeurVar[0,0])/NbrePas);
        NbrePasLabel.caption := StNEuler+intToStr(NbrePas);
        grandeurs[cDeltat].nom := DeltaMaj+grandeurs[0].nom;
        Grandeurs[cDeltat].nomUnite := Grandeurs[0].nomUnite;
        Grandeurs[cDeltat].fonct.expression := 'Pas de calcul pour Euler';
        DeltatBtn.caption := grandeurs[cDeltat].nom;
        varBtn.caption := grandeurs[Coordonnee[1].codeY].nom;
        tBtn.caption := grandeurs[0].nom;

        enTeteTemps := tBtn.caption+'[i]=';
        enTeteVar := varBtn.caption+'[i]=';
        varTrouve := false;
        tempsTrouve := false;
        for i := 0 to pred(memoModele.Lines.count) do begin
            varTrouve := varTrouve or (pos(enTeteVar,memoModele.Lines[i])=1);
            tempsTrouve := tempsTrouve or (pos(enTeteTemps,memoModele.Lines[i])=1);
        end;
        if not tempsTrouve then memoModele.Lines.add(enTeteTemps);
        if not varTrouve then memoModele.Lines.add(enTeteVar);
end end; // PaintBoxPrinc.Paint

procedure TFgrapheEuler.MemoModeleChange(Sender: TObject);
begin if MajModelePermis then begin
     MajModelePermis := false;
     if MemoModele.defAttributes.name<>stRegressi then
        VerifMemo(memoModele);
     if NbrePages=0 then begin
        MemoModele.clear;
        MajModelePermis := true;
        exit;
     end;
     etatModele := [];
     MemoResultat.clear;
     MajBtn.enabled := true;
     MajTimer.enabled := true;
     pages[pageCourante].ModeleCalcule := false;
     pages[pageCourante].ModeleErrone := false;
//     if sender<>nil then verifCRLF(memoModele);
     MajModelePermis := true;
end end; // MemoModeleChange

Procedure TFgrapheEuler.MajParametres;
var i,iMod,iPar,iCtr : integer;
begin with pages[pageCourante] do begin
       verifParametres;
       for i := 1 to MaxParamEuler do ParamInit[i] := false;
       for i := 1 to 3 do begin
           PanelValeurInit[i].visible := false;
           PanelValeurParam[i].visible := false;
       end;
       try
       i := 1;
       for iMod := 1 to NbreModele do with FonctionTheorique[iMod] do begin
          if calcul^.varx<>nil
              then iPar := indexNom(calcul^.varx.nom)
              else iPar := 0;
          if (iPar>parametre0) then begin
               iPar := indexToParam(paramNormal,iPar);
// paramètre valeur initiale
               if i>3 then raise EEulerError.create('Plus de trois variables');
               panelParam[iPar] := panelValeurInit[i];
               ParamInit[iPar] := true;
               inc(i);
          end;
       end;
       if NbreParam[paramNormal]>MaxParamEuler then
          raise EEulerError.create('Plus de six paramètres ou variables');
       i := 1;
       for iPar := 1 to NbreParam[paramNormal] do begin
           if not ParamInit[iPar] then begin
              if i>3 then raise EEulerError.create('Plus de trois paramètres');
              panelParam[iPar] := panelValeurParam[i];
              inc(i);
           end;
           panelParam[iPar].tag := iPar;
           for iCtr := 0 to panelParam[iPar].controlCount - 1 do begin
               panelParam[iPar].controls[iCtr].Tag := iPar;
               if PanelParam[iPar].controls[iCtr] is Tedit then
                  EditValeur[iPar] := TEdit(PanelParam[iPar].controls[iCtr]);
           end;
           PanelParam[iPar].visible := true;
           PanelParam[iPar].caption := Parametres[paramNormal,iPar].nom;
           EditValeur[iPar].text := formatReg(valeurParam[paramNormal,iPar]);
       end;
    except
       on E: EUniteError do begin
         etatModele := [];
         afficheErreur(E.message,107);
       end;
    end;
end end; // MajParametres

procedure TFgrapheEuler.LanceCompile;
var PosErreur,longErreur : integer;
begin
     MajModelePermis := false;
     etatModele := [];
     NbreModele := 0;
     NbreFonctionSuper := 0;
     NbreParam[paramNormal] := 0;
     PosErreur := 0;
     LongErreur := 0;
     MajTimer.enabled := false;
     while (MemoModele.lines.count>0) and
           (MemoModele.lines[0]='') do MemoModele.lines.delete(0);
     while (MemoModele.lines.count>2) and
           (MemoModele.lines[MemoModele.lines.count-1]='') and
           (MemoModele.lines[MemoModele.lines.count-2]='')
          do MemoModele.lines.delete(MemoModele.lines.count-1);
     compileModele(posErreur,longErreur);
     oldKey := #0;
     if ModeleDefini in etatModele
        then begin
             ConstruitModele;
             MajBtn.enabled := false;
             NbrePasChange(NbrePas);
        end
        else if not (PasDeModele in etatModele) then
        with memoModele do begin
             selStart := pred(posErreur);
             selLength := longErreur;
             MajBtn.enabled := true;
             MajTimer.enabled := PanelModele.visible;
             if showing then setFocus;
        end;
    MajModelePermis := true;
end; // LanceCompile

procedure TFgrapheEuler.FormDestroy(Sender: TObject);
begin
     GraphePrinc.Free;
     FcoordonneesEuler.free;
     FGrapheEuler := nil;
end;

Procedure TFgrapheEuler.ValideParam(paramCourant : integer;maj : boolean);
var valeurLoc : double;
begin
     if ValeursParamChange then begin
        try
          valeurLoc := GetFloat(editValeur[paramCourant].text);
          Pages[pageCourante].valeurParam[paramNormal,paramCourant] := valeurLoc;
          if maj then PostMessage(handle,WM_Reg_Calcul,CalculModele,0);
          ValeursParamChange := false;
        except
          EditValeur[paramCourant].SetFocus
        end;
     end
end;

procedure TFgrapheEuler.ValeursParamKeyPress(Sender: TObject; var Key: Char);
begin
     VerifKeyGetFloat(key);
     if key<>#0 then ValeursParamChange := true;
end;

procedure TFgrapheEuler.WMRegModele(var Msg : TWMRegMessage);

procedure MajResultat;
var m : shortInt;
begin with pages[pageCourante] do begin
    MemoResultat.Clear;
    MemoResultat.selAttributes.color := clBlack;
    verifMemo(memoResultat);
    if ModeleCalcule then
    for m := 1 to NbreModele do with fonctionTheorique[m] do begin
        if indexY=0 then continue; // Ne pas afficher le temps
        MemoResultat.Lines.add(stEcartRelatif);
        MemoResultat.Lines.add(chainePrec(PrecisionModele[m])+
                 ' sur '+copy(enTete,1,length(enTete)-3));
    end;
    MemoResultat.Lines.add('');
    if FcoordonneesEuler.oldParamCB.checked then begin
       MemoResultat.selLength := 0;
       MemoResultat.selAttributes.color := clSkyBlue;
       MemoResultat.lines.Add('Valeur précédente');
       MemoResultat.selAttributes.color := clSkyBlue;
       MemoResultat.lines.Add(OldParam);
       MemoResultat.lines.Add(OldNbre);       
    end;
    for m := 1 to NbreParam[paramNormal] do
        EditValeur[m].text := formatReg(valeurParam[paramNormal,m]);
end end; // MajResultat

begin
        MajResultat;
        graphePrinc.modif := [gmModele,gmValeurModele];
        PaintBoxPrinc.invalidate;
end; // WMRegModele

procedure TFgrapheEuler.WMRegCalcul(var Msg : TWMRegMessage);

procedure AffecteOldModele;
var i,j,m : integer;
    trouve : boolean;
    courbeAdd : Tcourbe;
begin if pages[pageCourante].modeleCalcule then with graphePrinc do
for i := 0 to pred(courbes.count) do
    if (courbes[i].indexModele>0) and
        not courbes[i].courbeExp and
       (courbes[i].indexModele<=NbreModele) then begin
             m := courbes[i].indexModele;
             trouve := false;
             oldFinC := courbes[i].FinC;
             oldModeleCalcule := true;
             copyVecteur(oldValeurYEuler[m],
                         fonctionTheorique[m].valeurYEuler);
             copyVecteur(oldValeurYEuler[indexModeleX],
                         fonctionTheorique[indexModeleX].valeurYEuler);
             for j := 0 to pred(courbes.count) do
                 if (courbes[j].indexModele<0) and
                    (courbes[j].indexModele=-courbes[i].indexModele) then begin
                        courbes[j].FinC := oldFinC;
                        trouve := true;
                 end;
             if not trouve  then begin
                 courbeAdd := AjouteCourbe(oldvaleurYEuler[indexModeleX],
                              oldValeurYEuler[m],mondeY,oldFinC,
                              courbes[i].varX,
                              courbes[i].varY,pageCourante);
                 courbeAdd.IndexModele := -m;
                 courbeAdd.Trace := [trLigne,trPoint];
                 courbeAdd.setStyle(GetCouleurPale(courbes[i].couleur),psSolid,mLigneEuler,'');
             end;
       end;
end; // affecteOldModele

procedure LanceModele;
label finProc;
begin
     Screen.cursor := crHourGlass;
     if not (ModeleDefini in etatModele) then begin
        lanceCompile;
        if not (ModeleDefini in etatModele) then begin
           if MemoModele.showing then MemoModele.setFocus;
           goto finProc;
        end;
     end;
     if not (ModeleConstruit in etatModele) then begin
        ConstruitModele;
        if not (ModeleConstruit in etatModele) then begin{ erreur ? }
           if MemoModele.showing then MemoModele.setFocus;
           goto finProc;
        end;
     end;
     if chercheUniteParam and
        not(UniteParamDefinie in etatModele) then begin
           chercheUniteParametre;
           include(etatModele,UniteParamDefinie);
     end;
     VerifParametres;
     AffecteOldModele;
     EffectueModele;
     MajBtn.enabled := false;
     if (OmEchelle in graphePrinc.OptionModele) then
        graphePrinc.monde[mondeX].Defini := false;
     finProc :
     PanelAjuste.enabled := true;
     PostMessage(handle,WM_Reg_Modele,0,0);
     Screen.cursor := crDefault;
     setParamEdit;
end; // LanceModele

procedure AffecteValeurInit;
var k,j : byte;
begin with pages[pageCourante] do
      for k := 1 to NbreModele do with FonctionTheorique[k] do begin
          if calcul^.varx<>nil
              then j := indexNom(calcul^.varx.nom)
              else j := 0;
          if (j>parametre0) then begin
               j := indexToParam(paramNormal,j);
               ValeurParam[paramNormal,j] := valeurVar[indexY,0];
               EditValeur[j].text := formatReg(valeurParam[paramNormal,j]);
          end;
     end;
     changementMemo := false;
end;

procedure EffectueCompile;
var memoActif : boolean;
    i,posFin : integer;
begin
     memoActif := memoModele=activeControl;
     LanceCompile;
     if ModeleDefini in etatModele then begin
             MajParametres;
             if changementMemo then AffecteValeurInit;
             if memoActif then begin
                posFin := 0;
                for i := 0 to pred(MemoModele.Lines.count) do
                   posFin := posFin+Length(MemoModele.Lines[i])+2;
                memoModele.selStart := posFin;
                memoModele.selLength := 0;
                MemoModele.setFocus;
             end;
             setParamEdit;
      end
      else if PasDeModele in etatModele then MajParametres;
end;

begin
     case msg.typeMaj of
          calculCompile : effectueCompile;
          calculModele : lanceModele;
     end;
end;

procedure TFgrapheEuler.MemoResultatKeyPress(Sender: TObject; var Key: Char);
begin
    key := #0
end;

procedure TFgrapheEuler.ClipBitmapItemClick(Sender: TObject);
begin
     graphePrinc.versBitMap('')
end;

procedure TFgrapheEuler.MajBtnClick(Sender: TObject);
begin
     oldModeleCalcule := false;
     PostMessage(handle,WM_Reg_Calcul,CalculCompile,0)
end;

procedure TFgrapheEuler.MajTimerTimer(Sender: TObject);
begin
    if MajBtn.enabled
       then if MajBtn.Layout=blGlyphLeft
          then MajBtn.Layout := blGlyphRight
          else MajBtn.Layout := blGlyphLeft
       else begin
          MajTimer.enabled := false;
          MajBtn.Layout := blGlyphLeft
       end;
end;

procedure TFgrapheEuler.MemoModeleKeyPress(Sender: TObject;
  var Key: Char);
begin
    if (key=crCR) and (oldKey=crCR)
       then begin
           oldKey := #0;
           MajBtnClick(Sender);
           key := #0;
       end
       else begin
          oldKey := key;
          if (key=alpha) then begin
              if sender=memoModele then begin
                 memoModele.selStart := SelStartMod;
                 memoModele.selLength := 0;
              end;
          end;
          SelStartMod := memoModele.selStart;
          changementMemo := changementMemo or isLettre(key)
       end;
end;

procedure TFgrapheEuler.ImprModeleBtnClick(Sender: TObject);
var bas : integer;

procedure ImprimeModele;
var i : integer;
begin
         DebutImpressionTexte(bas);
         ImprimerLigne(stModelisation,bas);
         for i := 0 to pred(MemoModele.lines.count) do
             if MemoModele.lines[i]<>'' then
                ImprimerLigne(MemoModele.lines[i],bas);
         ImprimerLigne(pages[pageCourante].TitrePage,bas);
         for i := 0 to pred(MemoResultat.lines.Count) do
             ImprimerLigne(MemoResultat.lines[i],bas);
end;

begin
     if OKreg(OkImprGr,0) then begin
           debutImpressionGr(poPortrait,bas);
           bas := 0;
           graphePrinc.versImprimante(HautGrapheGr,bas);
           ImprimeModele;
           finImpressionGr;
     end;
end;

procedure TFgrapheEuler.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var P : Tpoint;
begin
     GetCursorPos(P);
     P := PaintBoxPrinc.ScreenToClient(P);
     if (P.X<0) or (P.X>paintBoxPrinc.width) or
        (P.Y<0) or (P.Y>paintBoxPrinc.height) then exit;
     case key of
          vk_left : dec(P.X);
          vk_right : inc(P.X);
          vk_down : inc(P.Y);
          vk_up : dec(P.Y);
          vk_prior : dec(P.X,10);
          vk_next : inc(P.X,10);
          else exit;
     end;
     P := PaintBoxPrinc.ClientToScreen(P);
     setCursorPos(P.X,P.Y);
end; // FormKeyDown 

procedure TFgrapheEuler.FormShortCut(var Msg: TWMKey;var Handled: Boolean);
begin
     case msg.charCode of
          vk_delete : begin
            if (memoModele=activeControl) then begin
               handled := false;
               exit;
            end;
          end; // vk_delete
          vk_cancel :  { ou 27 ? }
             if curseur<>curSelect then begin
                setPenBrush(curSelect);
                PaintBoxPrinc.invalidate;
                handled := true;
          end;
     end;
end;

procedure TFgrapheEuler.memoModeleKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    SelStartMod := memoModele.selStart;
end;

procedure TFgrapheEuler.iBtnClick(Sender: TObject);
begin
     ClipBoard.Astext := (sender as TspeedButton).caption;
     MemoModele.PasteFromClipboard;
     MemoModele.setFocus;
     changementMemo := true;
end;

procedure TFgrapheEuler.SauverGrapheClick(Sender: TObject);
begin
    saveDialog.options := saveDialog.options-[ofOverwritePrompt];
    if saveDialog.Execute then
       graphePrinc.versFichier(saveDialog.fileName);
end;

procedure TFgrapheEuler.VerifParametres;
var i : integer;
begin with pages[pageCourante] do
    for i := 1 to NbreParam[paramNormal] do
        if isNan(valeurParam[paramNormal,i])
           then valeurParam[paramNormal,i] := parametres[paramNormal,i].ordreDeGrandeur;
end;

procedure TFgrapheEuler.EditValeurExit(Sender: TObject);
begin
   ValideParam((sender as Tcomponent).tag,true)
end;

procedure TFgrapheEuler.EditValeurKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var paramCourant : integer;
begin
     paramCourant := (sender as Tcomponent).tag;
     if toucheValidation(key)
        then begin
           valideParam(paramCourant,true);
           case key of
                vk_up,vk_prior : begin
                   dec(paramCourant);
                   if paramCourant>0 then
                       EditValeur[paramCourant].setFocus;
                end;
                vk_down,vk_next,vk_tab,vk_return : begin
                   inc(paramCourant);
                   if paramCourant<=NbreParam[paramNormal] then
                       EditValeur[paramCourant].setFocus;
                end;
           end;
        end
end;

procedure TFgrapheEuler.EditValeurKeyPress(Sender: TObject;
  var Key: Char);
begin
     VerifKeyGetFloat(key);
     if key<>#0 then ValeursParamChange := true;
end;

procedure TFgrapheEuler.MoinsRapideBtnClick(Sender: TObject);
begin
     ModifParam((sender as Tcomponent).tag,1/CoeffParamRapide)
end;

procedure TFgrapheEuler.NbrePasChange(NewNbre : integer);
var dt : double;
begin
    if NewNbre>1024 then NewNbre := 1024;
    if NewNbre<4 then NewNbre := 4;
    OldNbre := 'N=' +intToStr(NbrePas);
    NbrePas := newNbre;
    with pages[pageCourante] do begin
         dt := (valeurVar[0,pred(nmes)]-valeurVar[0,0])/NbrePas;
         deltatLabel.caption := deltaMaj+grandeurs[0].formatNomEtUnite(dt);
         grandeurs[cDeltat].valeurCourante := dt;
    end;
    NbrePasLabel.caption := StnEuler+intToStr(NbrePas);
    if ([ModeleDefini,ModeleConstruit] <= etatModele)
       then PostMessage(handle,WM_Reg_Calcul,CalculModele,0)
end;

procedure TFgrapheEuler.MoinsBtnClick(Sender: TObject);
begin
     ModifParam((sender as Tcomponent).tag,1/CoeffParam)
end;

procedure TFgrapheEuler.PlusBtnClick(Sender: TObject);
begin
    ModifParam((sender as Tcomponent).tag,CoeffParam)
end;

procedure TFgrapheEuler.PlusRapideBtnClick(Sender: TObject);
begin
    ModifParam((sender as Tcomponent).tag,CoeffParamRapide)
end;

procedure TFgrapheEuler.SigneBtnClick(Sender: TObject);
begin
    ModifParam((sender as Tcomponent).tag,-1)
end;

procedure TFgrapheEuler.ModifParam(paramCourant : integer;coeff : double);
begin
     ParamEditCourant := paramCourant;
     with Parametres[paramNormal,paramCourant] do
          OldParam := formatNomEtUnite(valeurCourante);
     valideParam(paramCourant,false);
     with pages[pageCourante] do begin
         ValeurParam[paramNormal,paramCourant] :=
              ValeurParam[paramNormal,paramCourant]*coeff;
         Parametres[paramNormal,paramCourant].valeurCourante :=
              ValeurParam[paramNormal,paramCourant];
     end;
     PostMessage(handle,WM_Reg_Calcul,CalculModele,0);
end;

procedure TFgrapheEuler.ParamBtnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  RepeatTimer.Interval := InitRepeatPause;
  RepeatTimer.Enabled  := True;
  TimerButton := sender as TspeedButton;
end;

procedure TFgrapheEuler.ParamBtnMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  RepeatTimer.Enabled  := False
end;

procedure TFgrapheEuler.RepeatTimerTimer(Sender: TObject);
begin
  RepeatTimer.Interval := RepeatPause;
  if csLButtonDown in TimerButton.ControlState
     then begin
        TimerButton.onClick(timerButton);
        Application.processMessages;
     end
     else RepeatTimer.Enabled := False
end;

procedure TFgrapheEuler.SetTaillePolice;
begin
         majModelePermis := false;
         verifMemo(memoModele);
         majModelePermis := true;
end;

procedure TFgrapheEuler.ValeurInitClick(Sender: TObject);
var k,j : byte;
begin with pages[pageCourante] do begin
      for k := 1 to NbreModele do with FonctionTheorique[k] do begin
          if calcul^.varx<>nil
              then j := indexNom(calcul^.varx.nom)
              else j := 0;
          if (j>parametre0) then begin
               j := indexToParam(paramNormal,j);
               if (j=(sender as TspeedButton).tag) then begin
// origine est bien un paramètre
                  ValeurParam[paramNormal,j] := valeurVar[indexY,0];
                  EditValeur[j].text := formatReg(valeurParam[paramNormal,j]);
               end;
          end;
     end;
     PostMessage(handle,WM_Reg_Calcul,CalculModele,0);
end end;

procedure TFgrapheEuler.NpasSBDownClick(Sender: TObject);
begin
    NbrePasChange(NbrePas div 2)
end;

procedure TFgrapheEuler.NpasSBUpClick(Sender: TObject);
begin
    NbrePasChange(2*NbrePas)
end;

procedure TFgrapheEuler.SplitterModeleCanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  inherited;
  accept := (newSize>200) and ((width-newSize)>(width div 2))
end;

procedure TFgrapheEuler.ToolButton1Click(Sender: TObject);
begin
   Aide(107)
end;

procedure TFgrapheEuler.SetParamEdit;
begin
    if Panel11.visible then begin
       if paramEditCourant<1 then paramEditCourant := 1;
       if paramEditCourant>NbreParam[paramNormal] then paramEditCourant := NbreParam[paramNormal];
       EditValeur[paramEditCourant].setFocus;
    end;
end;

procedure TFgrapheEuler.copierAsJPEG(Sender: TObject);
begin
     graphePrinc.versBitMap('')
end;

Procedure TFgrapheEuler.ecritConfig;
var i : integer;
begin with GraphePrinc do begin
   writeln(fichier,symbReg2,1,' X');
   writeln(fichier,coordonnee[1].nomX);
   writeln(fichier,symbReg2,1,' Y');
   writeln(fichier,coordonnee[1].nomY);
   if dispositionFenetre=dNone then begin
      writeln(fichier,symbReg2,'5 '+stFenetre);
      writeln(fichier,ord(windowState));
      writeln(fichier,top);
      writeln(fichier,left);
      writeln(fichier,width);
      writeln(fichier,height);
   end;
   if ModeleDefini in etatModele then begin
      writeln(fichier,symbReg2,IntToStr(MemoModele.lines.count)+' '+stModele);
      for i := 0 to MemoModele.lines.count-1 do
          writeln(fichier,MemoModele.lines[i]);
   end;
end end; // ecritConfig

Procedure TFgrapheEuler.litConfig;
var i,imax : integer;
    choix : byte;
    zInt : integer;
    zN : string;
begin // litConfig
   for i := mondeX to mondeSans do graphePrinc.monde[i].axe := nil;
   MajModelePermis := false;
   MemoModele.Clear;
   while (Length(LigneWin)>0) and (ligneWin[1]=symbReg2) do begin
      choix := 0;
      imax := NbreLigneWin(ligneWin);
      if pos('X',ligneWin)<>0 then choix := 1;
      if pos('Y',ligneWin)<>0 then choix := 2;
      if pos(stFenetre,ligneWin)<>0 then choix := 3;
      if pos(stModele,ligneWin)<>0 then choix := 4;
      case choix of
           0 : for i := 1 to imax do readln(fichier);
           1 : with graphePrinc do for i := 1 to imax do
               with coordonnee[i] do begin
                litLigneWin;
                nomX := LigneWin;
                codeX := indexNom(nomX);
                if codeX<>grandeurInconnue then
                   monde[mondeX].axe := grandeurs[codeX];
           end;
           2 : with graphePrinc do for i := 1 to imax do
               with coordonnee[i] do begin
                litLigneWin;
                nomY := LigneWin;
                codeY := indexNom(nomY);
                if codeY<>grandeurInconnue
                   then monde[mondeY].axe := grandeurs[codeY];
           end;
           3 : begin
              readln(fichier,zInt);
              windowState := TwindowState(zInt);
              readln(fichier,zint);
              top := zint;
              readln(fichier,zint);
              left := zint;
              readln(fichier,zint);
              width := zint;
              readln(fichier,zint);
              height := zint;
              position := poDesigned;
              dispositionFenetre := dNone;
           end;
           4 : for i := 1 to imax do begin
               readln(fichier,zN);
               MemoModele.lines.add(zN);
           end;
       end; // case
       litLigneWin;
    end; // while
    MajModelePermis := true;
    MajTimer.enabled := true; // pour prévenir modif etatModele
end; // litConfig

Procedure TFgrapheEuler.ConstruitModele;

Procedure VerifierGraphe;
var CoordOK : boolean;
    m,mp : byte;
begin with graphePrinc do begin
     coordOK := false;
     for m := 1 to NbreModele do with fonctionTheorique[m] do
             coordOK := coordOK or
              ( (grandeurs[indexX].nom=coordonnee[1].nomX) and
                (grandeurs[indexY].nom=coordonnee[1].nomY) ) or
              ( (grandeurs[indexX].nom=coordonnee[1].nomY) and
                (grandeurs[indexY].nom=coordonnee[1].nomX) );
     if not CoordOK and (NbreModele>1) then
        for m := 1 to NbreModele do begin
            for mp := 1 to NbreModele do
            coordOK := coordOK or
              ((grandeurs[fonctionTheorique[m].indexY].nom=coordonnee[1].nomX) and
               (grandeurs[fonctionTheorique[mp].indexY].nom=coordonnee[1].nomY));
            if coordOK then break;
        end;
     if not CoordOK then begin
         if NbreModele=2 then begin // y(t)
            coordonnee[1].nomX := grandeurs[fonctionTheorique[1].indexY].nom;
            Coordonnee[1].nomY := grandeurs[fonctionTheorique[2].indexY].nom;
         end;
         if NbreModele=3 then begin // x(t) y(t)
            coordonnee[1].nomX := grandeurs[fonctionTheorique[2].indexY].nom;
            Coordonnee[1].nomY := grandeurs[fonctionTheorique[3].indexY].nom;
         end;
         include(GraphePrinc.modif,gmModele);
         PaintBoxPrinc.refresh;
     end; // not CoordOK
end end; // VerifierGraphe

var m : TcodeIntervalle;
    l : integer;
begin
   if chercheUniteParam then begin
      chercheUniteParametre;
      include(etatModele,UniteParamDefinie);
   end;
   verifierGraphe;
   with Pages[pageCourante] do begin
        ParamAjustes := false;
        ModeleCalcule := false;
        ModeleErrone := false;
        for m := 1 to NbreModele do
            for l := 0 to NmesMax do
                valeurTheorique[m,l] := Nan;
   end;
   include(etatModele,ModeleConstruit);
   for m := 1 to NbreModele do with fonctionTheorique[m] do
       VariableEgalAbscisse := grandeurs[indexX]=graphePrinc.Monde[mondeX].axe;
end; // construitModele

Procedure TFgrapheEuler.CompileModele(var PosErreur,LongErreur : integer);
var posErreurLigne : integer;
    LigneCourante : string;
    i,k : integer;

Function LigneModele : boolean;
var PosEgal : byte;
    index : integer;
    NomLu : string;
begin
    result := false;
    if IsLigneComment(LigneCourante) then exit;
    if pos(':=',LigneCourante)>0 then exit;
    PosEgal := Pos('=',ligneCourante);
    if PosEgal=0 then begin
       codeErreurC := erEgalAbsent;
       exit;
    end;
    nomLu := copy(ligneCourante,1,pred(posEgal)); // extrait le nom 
    trimComplet(nomLu);
    index := indexToParam(paramNormal,IndexNom(nomLu));
    if index=grandeurInconnue then result := true
end;

Procedure CompileModelisation;
begin
    if NbreModele<maxIntervalles
       then begin
            inc(NbreModele);
            trimComplet(LigneCourante);
            with fonctionTheorique[NbreModele] do begin
                 LigneMemo := i;
                 compileM(LigneCourante,posErreurLigne,longErreur);
            end;
      end
      else begin
           codeErreurC := erMaxModele;
           posErreurLigne := 0;
      end;
end; // CompileModelisation

var m : integer;
    index : integer;
begin
    for i := 1 to maxParametres do begin
        paramInverse[i] := false;
        inversePermis[i] := true;
    end;
    k := NbreParam[ParamNormal];
    for i := 1 to NbreParam[ParamNormal] do begin
        if k>i then transfereParamE(ParamNormal, i, k);
        dec(k);
    end;
    codeErreurC := '';
    i := 0;
    while i<MemoModele.Lines.count do begin
        LigneCourante := memoModele.Lines[i];
        if LigneModele then compileModelisation;
        if codeErreurC=''
           then posErreur := posErreur + length(LigneCourante) + 2 { 2=CR+LF }
           else begin
                posErreur := posErreur + posErreurLigne;
                break;
           end;
        inc(i);
     end; // while i                                         
     if codeErreurC=''
        then begin
           for m := 1 to NbreModele do with fonctionTheorique[m] do begin
               calcul^.varX := nil;
               index := indexGrandeurInitiale(addrY,calcul^.varX,true);
               for i := succ(NbreParam[genreParam]) to maxParametres do
                   if calcul^.varX.nom = parametres[genreParam, i].nom then begin
                      pages[pageCourante].valeurParam[ParamNormal,index] :=
                            pages[pageCourante].valeurParam[ParamNormal,i];
                      break;
                   end;
           end;
           if NbreModele>0
              then include(etatModele,ModeleDefini)
              else include(etatModele,PasDeModele);
        end
        else afficheErreur(codeErreurC,0);
    include(GraphePrinc.Modif,gmModele);
end; // CompileModele

Procedure TFgrapheEuler.EffectueModele;
var
   deltat : double;
   J : tableauReal;
// (FonctionTheorique(x,param)-FonctionExperimentale(x))^2

Procedure InitCalculJ;
// On calcule une valeur relative à l'étendue des mesures
var m : byte;
    i : integer;
begin with pages[pageCourante] do begin
   for m := 1 to NbreModele do with fonctionTheorique[m] do begin
      SommeCarreY := 0;
      for i := 0 to pred(nmes) do
          SommeCarreY := SommeCarreY + sqr(valeurVar[indexY,i]);
      if uniteSIglb and
         (grandeurs[indexY].fonct.genreC=G_experimentale)
          then begin
               coeffSI := grandeurs[indexY].coeffSI;
               sommeCarreY := sommeCarreY*sqr(coeffSI);
          end
          else coeffSI := 1;
      DeltaReg[m] := Nan;
   end;
end end;// initCalculJ

procedure CalculJ;

procedure calculLoc;
var m : byte;
    i : integer;
    ecart : double; // valeur de l'écart entre la fonction théorique et expérimentale
begin with pages[pageCourante] do begin
    try
    for m := 1 to NbreModele do with fonctionTheorique[m] do begin
        debut[m] := 0;
        fin[m] := pred(nmes);
        for i := 0 to pred(nmes) do
            if not isNan(valeurVar[indexY,i]) then begin
            if posErreurModele=i then continue;
            if uniteSIglb
               then Ecart := valeurTheorique[m,i]-valeurVar[indexY,i]*coeffSI
               else Ecart := valeurTheorique[m,i]-grandeurs[indexY].valeur[i];
             J[m] := J[m] + sqr(ecart);
        end; // for i
    end;// for m
    except
         erreurParam := true
    end;
end end; // calculLoc

var m : byte;
begin // calculJ
with pages[pageCourante] do begin
// Initialisation
   AffecteConstParam(true);
   AffecteVariableP(false);
   grandeurs[cDeltat].valeurCourante := deltat;
// deltat Euler et non des données
   erreurCalcul := false;
   erreurParam := false;
   Chi2Actif := fonctionTheorique[1].chi2Permis and Chi2Actif;
   for m := 1 to NbreModele do begin
       J[m] := 0;
       chi2[m] := 0;
       ErreurModele[m] := false;
       PosErreurModele[m] := -1;
   end;
   try
   ModeleEuler(NbrePas);
   except
       on E : exception do begin
          derniereErreur := E.message;
          erreurCalcul := true;
       end;
   end;
   if not erreurCalcul then CalculLoc;
   for m := 1 to NbreModele do begin
        PrecisionModele[m] := sqrt(J[m]/FonctionTheorique[m].SommeCarreY);
        if Chi2Actif
           then DeltaReg[m] := sqrt(chi2[m]/nmes)/FonctionTheorique[m].CoeffSI
           else DeltaReg[m] := sqrt(J[m]/nmes)/FonctionTheorique[m].CoeffSI;
   end; { m }
end end; // calculJ

var i,m : integer;
begin // effectueModele
with pages[pageCourante] do begin
    PanelAjuste.enabled := false;
    ModeleCalcule := false;
    ModeleErrone := true;
    deltat := (valeurVar[0,pred(nmes)]-valeurVar[0,0])/NbrePas;
    grandeurs[cDeltat].valeurCourante := deltat;
    InitCalculJ;
    CalculJ;
    if erreurCalcul or ErreurParam then begin
       MessageDlg(ErDomaine+' : '+derniereErreur,mtError,[mbOK], HELP_Erreurdedomainededefinition);
       exit;
    end;
    ModeleCalcule := true;
    ModeleErrone := false;
    for m := 1 to NbreModele do with fonctionTheorique[m],pages[pageCourante] do
        if coeffSI<>1 then for i := 0 to pred(nmes) do
            valeurTheorique[m,i] := valeurTheorique[m,i]/coeffSI;
    pages[pageCourante].remplitVarLisse;
end end; // EffectueModele

Procedure TFGrapheEuler.EcritConfigXML(Anode : IXMLNode);
var i : integer;
    OptionsXML,CoordXML : IXMLNode;
    texte : TstringList;
begin with GraphePrinc do begin
   for i := 1 to NbreOrdonnee do with coordonnee[i] do begin
       CoordXML := ANode.AddChild('COORD');
       CoordXML.Attributes['Index'] := intToStr(i);
       writeIntegerXML(CoordXML,stLigne,ord(ligne));
       writeIntegerXML(CoordXML,stCouleur,couleur);
       writeIntegerXML(CoordXML,'MOTIF',ord(Motif));
       writeStringXML(CoordXML,'X',coordonnee[i].nomX);
       writeStringXML(CoordXML,'Y',nomY);
       writeIntegerXML(CoordXML,'TRACE',word(TraceToXML(Trace)));
       writeIntegerXML(CoordXML,stMonde,ord(iMondeC));
       writeIntegerXML(CoordXML,'GRADUATION',ord(monde[iMondeC].Graduation));
       writeIntegerXML(CoordXML,'ZERO',ord(monde[iMondeC].ZeroInclus));
       writeIntegerXML(CoordXML,'INVERSE',ord(monde[i].axeInverse));
   end;
   OptionsXML := ANode.addChild(stOptions);
   writeIntegerXML(optionsXML,'OptGraphe',byte(optionGraphe));{1}
   writeIntegerXML(optionsXML,'OptModele',byte(optionModele));{2}
   writeBoolXML(optionsXML,stEllipse,avecEllipse);
   writeBoolXML(optionsXML,'CouleurVitesseImposee',couleurVitesseImposee);
   writeIntegerXML(optionsXML,'ReperePage',ord(reperePage));
   if ModeleDefini in etatModele then begin
        Texte := TstringList.create;
        Texte.Delimiter := crCR;
        texte.Assign(memoModele.lines);
        WriteStringXML(ANode,stModele,Texte.delimitedText);
        texte.free;
   end;
end end;  // ecritConfigXML

Procedure TFgrapheEuler.litConfigXML(ANode : IXMLNode);
var CoordCourante : integer;

procedure ResetCoord;
var i : integer;
begin with graphePrinc do begin
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
begin with graphePrinc do begin
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

var
    zWord : word;
    zByte : byte;
    aTrace : TsetTraceXML;
    chaines : TStringList;
begin // loadXMLInReg
      with graphePrinc do begin
      if ANode.NodeName='COORD' then begin
         coordCourante := ANode.Attributes['Index'];
         suite;
         exit;
      end;
      if ANode.NodeName='X' then begin
         coordonnee[coordCourante].nomX := ANode.Text;
         exit;
      end;
      if ANode.NodeName='Y' then  begin
         coordonnee[coordCourante].nomY := ANode.Text;
         exit;
      end;
      if ANode.NodeName=stMonde then begin
         zByte := GetIntegerXML(ANode);
         coordonnee[coordCourante].iMondeC := TindiceMonde(zByte);
         exit;
      end;
      if ANode.NodeName='GRADUATION' then begin
         zByte := GetIntegerXML(ANode);
         monde[coordCourante].graduation := Tgraduation(zByte);
         exit;
      end;
      if ANode.NodeName=stOptions then begin
         suite;
         exit;
      end;
      if ANode.NodeName='ZERO' then begin
         monde[coordCourante].zeroInclus := GetBoolXML(ANode);
         exit;
      end;
      if ANode.NodeName='MAXIT' then begin
         maxiTemps := GetFloatXML(ANode);
         exit;
      end;;
      if ANode.NodeName='MINIT' then begin
         miniTemps := GetFloatXML(ANode);
         exit;
      end;;
      if ANode.NodeName='OptGraphe' then begin
         zByte := GetIntegerXML(ANode);
         optionGraphe := TsetOptionGraphe(zByte);
         exit;
      end;
      if ANode.NodeName='OptModele' then begin
         zByte := GetIntegerXML(ANode);
         optionModele := TsetOptionModele(zByte);
         exit;
      end;
      if ANode.NodeName='TRACE' then begin
         zWord := GetIntegerXML(ANode);
         aTrace := TsetTraceXML(zWord);
         coordonnee[coordCourante].Trace := traceFromXML(aTrace);
         exclude(coordonnee[coordCourante].trace,trTexte);
         exclude(coordonnee[coordCourante].trace,trSonagramme);
         exit;
      end;
      if ANode.NodeName=stCouleur then begin
         coordonnee[coordCourante].couleur := GetColorXML(Anode);
         exit;
      end;
      if ANode.NodeName='CouleurVitesseImposee' then begin
         CouleurVitesseImposee := GetBoolXML(ANode);
         exit;
      end;
      if ANode.NodeName='ReperePage' then begin
         reperePage := TreperePage(GetIntegerXML(ANode));
         exit;
      end;
      if ANode.NodeName='SuperPage' then begin
         superposePage := GetBoolXML(ANode);
         exit;
      end;
      if ANode.NodeName='UseDefault' then begin
         useDefault := GetBoolXML(ANode);
         exit;
      end;
      if ANode.NodeName='ProjeteVect' then begin
         exit;
      end;
      if ANode.NodeName=stFilDeFer then begin
         exit;
      end;
      if ANode.NodeName=stEllipse then begin
         AvecEllipse := GetBoolXML(ANode);
         exit;
      end;
      if ANode.NodeName='ProlongeVect' then begin
         exit;
      end;
      if ANode.NodeName=stLigne then begin
         zByte := GetIntegerXML(ANode);
         coordonnee[coordCourante].ligne := Tligne(zByte);
         exit;
      end;
      if ANode.NodeName='MOTIF' then begin
         zByte := GetIntegerXML(ANode);
         coordonnee[coordCourante].motif := Tmotif(zByte);
         exit;
      end;
      if ANode.NodeName=stTangente then begin
         exit;
      end;
      if (ANode.NodeName=stModele) then begin
         chaines := TStringList.Create;
         chaines.Delimiter := crCR;
         chaines.DelimitedText := ANode.Text;
         MemoModele.Lines.Assign(chaines);
         chaines.free;
         exit;
      end;
end end; // LoadXMLInReg

var i : Integer;
begin
   majFichierEnCours := true;
   Curseur := curSelect;
   resetCoord;
   configCharge := true;
   if ANode.HasChildNodes then
      for I := 0 to ANode.ChildNodes.Count - 1 do
          LoadXMLInReg(ANode.ChildNodes.Nodes[I]);
   verifCoord;
end; // litConfigXML


end.


