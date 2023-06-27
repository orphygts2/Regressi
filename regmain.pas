unit regmain;

interface

uses Windows, Dialogs, Menus, StdCtrls, Controls, Buttons, comCtrls,
     system.UITypes, system.Contnrs, System.ImageList, system.IOutils,
     inifiles, Classes, system.SysUtils, Forms, Messages, ExtCtrls, graphics,
     clipBrd, Grids, shellApi, vcl.HtmlHelpViewer, ToolWin, Vcl.ImgList,
     SHFolder, registry,
     constreg, regutil, math, maths, uniteker, fft, compile, valeurs, coordphys,
     graphker, graphvar, graphpar, regdde,
     Vcl.VirtualImageList, Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TFRegressiMain = class(TForm)
    MainMenu: TMainMenu;
    MenuFile: TMenuItem;
    FileNewItem: TMenuItem;
    FileOpenItem: TMenuItem;
    MenuFenetre: TMenuItem;
    MenuHelp: TMenuItem;
    FileExitItem: TMenuItem;
    WindowCascade: TMenuItem;
    WindowMosaiqueHoriz: TMenuItem;
    WindowMaxi: TMenuItem;
    FileSaveItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    MenuEdition: TMenuItem;
    CutItem: TMenuItem;
    CopyItem: TMenuItem;
    PasteItem: TMenuItem;
    MenuPage: TMenuItem;
    PageSuivItem: TMenuItem;
    PagePrecItem: TMenuItem;
    PageDelItem: TMenuItem;
    DeleteItem: TMenuItem;
    FilePrintItem: TMenuItem;
    SeparatorItem: TMenuItem;
    WindowMosaiqueVert: TMenuItem;
    NewClavierItem: TMenuItem;
    NewSimulationItem: TMenuItem;
    PrinterSetUpItem: TMenuItem;
    StatistiqueItem: TMenuItem;
    SeparatorWindow: TMenuItem;
    GrapheConstItem: TMenuItem;
    MruSeparator: TMenuItem;
    MRUItem0: TMenuItem;
    MruItem1: TMenuItem;
    MruItem2: TMenuItem;
    MruITem3: TMenuItem;
    MRUItem5: TMenuItem;
    FileAddItem: TMenuItem;
    AboutItem: TMenuItem;
    SeparatorAide: TMenuItem;
    FileNewClipItem: TMenuItem;
    GrandeursItem: TMenuItem;
    GrapheItem: TMenuItem;
    FourierItem: TMenuItem;
    N1: TMenuItem;
    CollerPageItem: TMenuItem;
    CollerNewDocItem: TMenuItem;
    PanelStatut: TPanel;
    OptionsItem: TMenuItem;
    GrandeursBtn: TSpeedButton;
    GrapheBtn: TSpeedButton;
    FourierBtn: TSpeedButton;
    StatistiqueBtn: TSpeedButton;
    GrapheConstBtn: TSpeedButton;
    AcqSeparator: TMenuItem;
    AcqItem1: TMenuItem;
    AcqItem2: TMenuItem;
    AcqItem3: TMenuItem;
    AcqItem4: TMenuItem;
    PageTrierItem: TMenuItem;
    PageSelectItem: TMenuItem;
    AcquisitionItem: TMenuItem;
    PageAddItem: TMenuItem;
    AcqItem5: TMenuItem;
    AcqItem6: TMenuItem;
    PageGrouperItem: TMenuItem;
    FocusAcquisitionBtn: TSpeedButton;
    SaveDialog: TSaveDialog;
    PageNewItem: TMenuItem;
    PageCopyItem: TMenuItem;
    PageCalculerItem: TMenuItem;
    PageNewClipItem: TMenuItem;
    FileCalcItem: TMenuItem;
    UtilisateurSepar: TMenuItem;
    UtilisateurItem: TMenuItem;
    OpenDialog: TOpenDialog;
    RestaurerItem: TMenuItem;
    RecupItem: TMenuItem;
    WebItem: TMenuItem;
    RazItem: TMenuItem;
    EnregistreBtn: TSpeedButton;
    PopupMenuAcq: TPopupMenu;
    AcqItemBis1: TMenuItem;
    AcqItemBis2: TMenuItem;
    AcqItemBis3: TMenuItem;
    AcqItemBis4: TMenuItem;
    AcqItemBis5: TMenuItem;
    AcqItemBis6: TMenuItem;
    AcqItem7: TMenuItem;
    AcqItem11: TMenuItem;
    ListeRegAction: TMenuItem;
    Acqitem8: TMenuItem;
    Acqitem9: TMenuItem;
    Acqitem10: TMenuItem;
    AcqItem12: TMenuItem;
    AcqItem13: TMenuItem;
    AnnulerItem: TMenuItem;
    EnvoyerItem: TMenuItem;
    RecevoirItem: TMenuItem;
    PanelPage: TPanel;
    PageDebutBtn: TSpeedButton;
    PagePrecBtn: TSpeedButton;
    PageFinBtn: TSpeedButton;
    PagesBtn: TSpeedButton;
    PanelNumPage: TPanel;
    ConstHeader: TStatusBar;
    PageSuivBtn: TSpeedButton;
    CommentaireEdit: TEdit;
    PageAddBtn: TSpeedButton;
    OpenFileBtn: TSpeedButton;
    TOCitem: TMenuItem;
    WindowManuelle: TMenuItem;
    UndoBtn: TSpeedButton;
    RandomItem: TMenuItem;
    CommPagePanel: TPanel;
    CommPageEdit: TEdit;
    GrouperColonnesItem: TMenuItem;
    ExporterLatexItem: TMenuItem;
    MRUitem4: TMenuItem;
    SonItem: TMenuItem;
    FileBitmap: TMenuItem;
    CourbesItem: TMenuItem;
    FileNewChronophoto: TMenuItem;
    FileNewIntensite: TMenuItem;
    FileNewAngle: TMenuItem;
    EchantillonnerItem: TMenuItem;
    DistribuerItem: TMenuItem;
    ArduinoItem: TMenuItem;
    graphe3DBtn: TSpeedButton;
    Graphe3DItem: TMenuItem;
    ExemplesItem: TMenuItem;
    N11: TMenuItem;
    N21: TMenuItem;
    N31: TMenuItem;
    N41: TMenuItem;
    N51: TMenuItem;
    N61: TMenuItem;
    N71: TMenuItem;
    N81: TMenuItem;
    N91: TMenuItem;
    N101: TMenuItem;
    VideoItem: TMenuItem;
    OscilloArduinoItem: TMenuItem;
    Documentationpdf: TMenuItem;
    DocumentationWord: TMenuItem;
    GrapheEulerBtn: TSpeedButton;
    DocModele: TMenuItem;
    ArduinoWifiItem: TMenuItem;
    ArduinoWifiDirectItem: TMenuItem;
    EphmridesIMCCE1: TMenuItem;
    CSVhorizontal1: TMenuItem;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    procedure TOCitemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure UpdateMenuItems(Sender: TObject);
    procedure FileOpenItemClick(Sender: TObject);
    procedure FileExitItemClick(Sender: TObject);
    procedure FileSaveItemClick(Sender: TObject);
    procedure FileSaveAsItemClick(Sender: TObject);
    procedure CutItemClick(Sender: TObject);
    procedure CopyItemClick(Sender: TObject);
    procedure PasteItemClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AboutItemClick(Sender: TObject);
    procedure PageSuivClick(Sender: TObject);
    procedure PageAddClick(Sender: TObject);
    procedure PageDelClick(Sender: TObject);
    procedure FileNewClipItemClick(Sender: TObject);
    procedure NewClavierItemClick(Sender: TObject);
    procedure NewSimulationItemClick(Sender: TObject);
    procedure FourierBtnClick(Sender: TObject);
    procedure GrapheBtnClick(Sender: TObject);
    procedure GrandeursBtnClick(Sender: TObject);
    procedure FileAddItemClick(Sender: TObject);
    procedure StatistiqueBtnClick(Sender: TObject);
    procedure PagePrecClick(Sender: TObject);
    procedure MenuPageClick(Sender: TObject);
    procedure GrapheConstBtnClick(Sender: TObject);
    procedure MruItemClick(Sender: TObject);
    procedure AcqItemClick(Sender: TObject);
    procedure MenuEditionClick(Sender: TObject);
    procedure DeleteItemClick(Sender: TObject);
    procedure PageDebutBtnClick(Sender: TObject);
    procedure PageFinBtnClick(Sender: TObject);
    procedure CommentaireEditChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OptionsItemClick(Sender: TObject);
    procedure CollerPageItemClick(Sender: TObject);
    procedure FileNewItemClick(Sender: TObject);
    procedure PageTrierItemClick(Sender: TObject);
    procedure PageCalculerItemClick(Sender: TObject);
    procedure PageSelectItemClick(Sender: TObject);
    procedure PageCopyItemClick(Sender: TObject);
    procedure FilePrintItemClick(Sender: TObject);
    procedure PageGrouperItemClick(Sender: TObject);
    procedure FocusAcquisitionBtnClick(Sender: TObject);
    procedure FileCalcItemClick(Sender: TObject);
    procedure UtilisateurItemClick(Sender: TObject);
    procedure RestaurerItemClick(Sender: TObject);
    procedure PrinterSetUpItemClick(Sender: TObject);
    procedure ConstHeaderClick(Sender: TObject);
    procedure RecupItemClick(Sender: TObject);
    procedure WebItemClick(Sender: TObject);
    procedure RazItemClick(Sender: TObject);
    procedure EnregistreBtnClick(Sender: TObject);
    procedure ListeRegActionClick(Sender: TObject);
    procedure PageNewSimulItemClick(Sender: TObject);
    procedure AnnulerItemClick(Sender: TObject);
    procedure RecevoirItemClick(Sender: TObject);
    procedure EnvoyerItemClick(Sender: TObject);
    procedure PageAddBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure RandomItemClick(Sender: TObject);
    procedure CommPageEditChange(Sender: TObject);
    function FormHelp(Command: Word; Data: Integer;
      var CallHelp: Boolean): Boolean;
    procedure GrouperColonnesItemClick(Sender: TObject);
    procedure ExporterLatexItemClick(Sender: TObject);
    procedure WindowClick(Sender: TObject);
    procedure FileVideoItemClick(Sender: TObject);
    procedure PageAddItemClick(Sender: TObject);
    procedure SonItemClick(Sender: TObject);
    procedure ImageItemClick(Sender: TObject);
    procedure NumerisationItemClick(Sender: TObject);
    procedure CourbesItemClick(Sender: TObject);
    procedure EchantillonnerItemClick(Sender: TObject);
    procedure DistribuerItemClick(Sender: TObject);
    procedure ArduinoItemClick(Sender: TObject);
    procedure graphe3DBtnClick(Sender: TObject);
    procedure ExemplesClick(Sender: TObject);
    procedure OscilloArduinoItemClick(Sender: TObject);
    procedure DocumentationpdfClick(Sender: TObject);
    procedure DocumentationWordClick(Sender: TObject);
    procedure GrapheEulerBtnClick(Sender: TObject);
    procedure DocModeleClick(Sender: TObject);
    procedure VideoItemClick(Sender: TObject);
    procedure ArduinoWifiItemClick(Sender: TObject);
    procedure ArduinoWifiDirectItemClick(Sender: TObject);
    procedure EphmridesIMCCE1Click(Sender: TObject);
    procedure CSVhorizontal1Click(Sender: TObject);
  private
    MruList,ExemplesList : TStringList;
    EditCtl : TCustomEdit; { pour menu édition }
    ActiveGrid : TStringGrid; { pour menu édition }
    GrecActif : boolean;
    NomFichierSauvegarde : string;
    HeureSauvegarde : TDateTime;
    procedure CloseAll;
    procedure EnvoieMessage(TypeChange : integer);
    procedure MajPages;
    procedure MruItemUpdate;
    procedure AcqItemUpdate;
    procedure MruAdd(const FileName: String);
    procedure MruDel(const FileName: String);
    Procedure verifWindowsMin;
    Procedure verifWindowsMax(aForm : TForm);
    function litFichierVideo(const nomFichier : string) : boolean;
    function litFichierSon(const nomFichier : string) : boolean;
    function litFichierImage(const nomFichier : string) : boolean;
    procedure AddFichier(NomFichier : string);
    procedure AppelFichier(nomFichier : string);
  public
    NbreGrandeursSauvees : integer;
    ModifConfigAcq : boolean;
    KeypadReturn : boolean;
    function VerifSauve : boolean;
    procedure LitFichier(const FileName : string;verif : boolean;isPasco : boolean);
    procedure FinOuvertureFichier(LectureOK : boolean);
    procedure AppMessage(var Msg: TMsg; var Handled: Boolean);
    procedure SauveEtatCourant;
    procedure GrapheConstOpen;
    procedure GrapheEulerOpen;
    procedure Graphe3DOpen;
    procedure GrapheOpen;
    procedure StatistiqueOpen;
    procedure FourierOpen;
    procedure GrandeursOpen;
    Procedure AffValeurParametre;
    Procedure VerifSauvegarde;
    procedure FormShowHint(Sender: TObject);
  protected
    procedure WMRegMaj(var Msg: TWMRegMessage); message wm_Reg_Maj;
    procedure WMRegFichier(var Msg: TWMRegMessage); message wm_Reg_Fichier;
  end;

var
  FRegressiMain: TFRegressiMain;

implementation

uses about, statisti, fileRRR,  filerw3U, varkeyb, options, newvar, supprDlg,
     graphFFT, graphEuler, graph3D,
     pageCalc, selPage, pageCopy, pagedistrib,  pageechant,
     selParam, oneInst, regprint,
     indicateurU, fusionU, latexreg,
     WavMain, interfMain, courbesU, chronoBitmap,
     arduinoU, arduinoOscillo, arduinoWifi, arduinoWifiDirect,
     Videoffmpeg, ephemerU;

{$R curseurAvi.res}
{$R *.DFM}

const FilterIndexPasco = 5;
      maxMRU = 5;

procedure TFregressiMain.AppMessage(var Msg: TMsg; var Handled: Boolean);

const
        GrecMaj : array[0..25] of char =
  (AlphaMaj,BetaMaj,ChiMaj,deltaMaj,EpsilonMaj,phiMaj,gammaMaj,etaMaj,
   iotaMaj,psiMaj,kappaMaj,lambdaMaj,MuMaj,NuMaj,omicronMaj,piMaj,thetaMaj,
   rhoMaj,sigmaMaj,tauMaj,upsilonMaj,'V',omegaMaj,xiMaj,'Y',zetaMaj);

        GrecMin : array[0..25] of char =
  (alpha,beta,chi,deltaMin,epsilon,phiMin,gammaMin,eta,iota,psi,kappa,lambdaMin,
   mu,nu,omicron,piMin,theta,rho,sigmaMin,tau,upsilon,'v',omegaMin,xi,'y',zeta);

var codeCarac : integer;
    isMinuscule : boolean;
begin with Msg do
   if Message=wm_char
   then if (GetKeyState(vk_control)<0)  // Ctrl+
         then begin
              isMinuscule := (GetKeyState(vk_shift)>=0) and
                             (GetKeyState(vk_capital)>=0);
              if (Wparam=7) and isMinuscule
                 then GrecActif := true // Ctrl+G(7)
                 else begin
                     if (wparam>1) and not(Wparam in [3,22,24]) and (wparam<26) then // Ctrl+C(3) Ctrl+V(22) Ctrl+A(1) Ctrl+Z(26) Ctrl+X(24)
                     if isMinuscule
                         then Wparam := ord(GrecMin[Wparam-1])
                         else Wparam := ord(GrecMaj[Wparam-1]);
                    // if (wparam=94) and (GetKeyState(vk_shift)>=0) then wparam := ord('^');
                 end
         end
         else begin
              if GrecActif then begin
                 CodeCarac := Wparam-ord('A');
                 if (CodeCarac<26) and (codeCarac>=0)
                    then Wparam := ord(GrecMaj[CodeCarac])
                    else begin
                       CodeCarac := Wparam-ord('a');
                       if (CodeCarac<26) and (codeCarac>=0)
                          then Wparam := ord(GrecMin[codeCarac]);
                    end;
              end;
              GrecActif := false;
         end
  // Interception des messages 'touche ENTER appuyée'
   else if (message=WM_KEYDOWN) and (wParam=VK_RETURN)
         then KeypadReturn := (Msg.lParam And $1000000)<>0;
end;

procedure TFRegressiMain.ArduinoItemClick(Sender: TObject);
begin
  if not verifSauve then exit;
     try
     if ArduinoForm=nil then
         Application.CreateForm(TArduinoForm,ArduinoForm);
     NomFichierData := '';
     modeAcquisition := AcqArduino;
     ArduinoForm.Show;
     ArduinoForm.SetFocus;
     except
     end;
end;

procedure TFRegressiMain.ArduinoWifiItemClick(Sender: TObject);
begin
     if not verifSauve then exit;
     try
     if ArduinoWifiForm=nil then
         Application.CreateForm(TArduinoWifiForm,ArduinoWifiForm);
     NomFichierData := '';
     modeAcquisition := AcqOscilloArduino;
     ArduinoWifiForm.Show;
     ArduinoWifiForm.SetFocus;
     except
     end;
end;

procedure TFRegressiMain.ArduinoWifiDirectItemClick(Sender: TObject);
begin
     if not verifSauve then exit;
     try
     if ArduinoWifiDirectForm=nil then
         Application.CreateForm(TArduinoWifiDirectForm,ArduinoWifiDirectForm);
     NomFichierData := '';
     modeAcquisition := AcqOscilloArduino;
     ArduinoWifiDirectForm.Show;
     ArduinoWifiDirectForm.SetFocus;
     except
     end;
end;

procedure TFRegressiMain.FormCreate(Sender: TObject);

Procedure LitExemples;
var
  Rini : TIniFile;
  nomIni : string;
  i : integer;
  nom,texte : string;
  maxExemples : integer;
begin
  ExemplesItem.Visible := false;
  nomIni := exemplesDir+'Exemples.ini';
  ExemplesList := TStringList.Create;
  if not FileExists(nomIni) then exit;
  Rini := TIniFile.create(nomIni);
  maxExemples := ExemplesItem.Count-1;
  for i  := 0 to maxExemples do begin
      ExemplesItem.items[i].visible := false;
      nom := Rini.ReadString(intToStr(i),stNom,'');
      texte := Rini.ReadString(intToStr(i),'Texte','');
      ExemplesList.add(nom);
      if nom<>'' then begin
         ExemplesItem.items[i].visible := true;
         ExemplesItem.Items[i].caption := texte;
         ExemplesItem.Visible := true;
      end;
  end;
  Rini.free;
end; // litExemples

Procedure LitCurrentUser;
var Rini : TIniFile;
    i : integer;
    zByte : byte;
    zz : string;
begin
  try
  Rini := TIniFile.create(NomFichierIni);
  try
  with Rini do begin
  for i := 0 to maxMRU do begin
      try
      zz := ReadString('Fichier','MRU'+IntToStr(i),'');
      MRUList.Add(zz);
      except
         MRUList.Add('');
      end;
  end;
  chiffreSignif := TchiffreSignif(ReadInteger(stGraphe,stChiffreSignif,ord(chiffreSignif)));
  couleurFondIdent := ReadInteger(stColor,'Ident',couleurFondIdent);
  MotifIdent := TmotifTexte(ReadInteger(stGraphe,'motifIdent',ord(MotifIdent)));
  hauteurIdent := ReadInteger(stGraphe,'hauteurIdent',hauteurIdent);
  avecCadreIdent := ReadBool(stGraphe,'cadreIdent',avecCadreIdent);
  isOpaqueIdent := ReadBool(stGraphe,'opaqueIdent',isOpaqueIdent);
  couleurMecanique[1] := ReadInteger(stColor,identVitesse,clRed);
  couleurMecanique[2] := ReadInteger(stColor,identAcceleration,clBlue);
  CouleurVitesseImposee := ReadBool(stColor,'VitesseImposee',true);
  couleurLigne := ReadInteger(stColor,stLigne,couleurLigne);
  imprimanteMonochrome := ReadBool(stImprimante,'Mono',false);
  imprimanteMonochrome := imprimanteMonochrome or ReadBool(stImprimante,'NB',false);
  try
  longueurTangente := 1/ReadInteger(stTangente,'Largeur',1);
  except
      longueurTangente := 0.33;
  end;
  ReticuleComplet := ReadBool(stGraphe,'Reticule',true);
  zByte := ReadInteger(stGraphe,'ZoneVirage',1);
  OptionsIndicateur := ToptionsIndicateur(zByte);
  if OptionsIndicateur=[] then optionsIndicateur := [oiEchelleTeinte];
  FondReticule := ReadInteger(stColor,'FondMarque',clYellow);
  LigneRappelTangente := TligneRappel(ReadInteger(stGraphe,stTangente,0));
  avecOptionsXY := ReadBool(stGraphe,'OptionsXY',avecOptionsXY);
  ChercheUniteParam := ReadBool(stModele,'UnitParam',ChercheUniteParam);
  AvecModeleManuel := ReadBool(stModele,'Manuel',AvecModeleManuel);
  AvecReglagePeriode := ReadBool(stFFT,'ReglePeriode',false);
  NbreHarmoniqueAff := ReadInteger(stFFT,'NbreHarmAff',NbreHarmoniqueAff);
  HarmoniqueAff := ReadBool(stFFT,'HarmAff',HarmoniqueAff);
  PrecisionCorrel := ReadInteger('CoeffCorrel','Nchiffres',5);
  if readBool(stSauvegarde,'Arecuperer',false) and premierAppel then
     MruAdd(NomFichierSauvegarde);
  writeBool(stSauvegarde,'Arecuperer',true);
  fenetre := Tfenetre(readInteger(stFFT,stFenetre,ord(fenetre)));
  PasSonagrammeAff := readInteger(stFFT,'PasSonAff',25)/1000;
  PasSonCalcul := readInteger(stFFT,'PasSonCalcul',1);
  if pasSonCalcul<1 then pasSonCalcul := 1;
  if pasSonCalcul>3 then pasSonCalcul := 3;
  FreqMaxSonagramme := readInteger(stFFT,'FreqSonMax',5000);
end;
  finally
  Rini.free;
  end;
  except
  end;
end; // litCurrentUser

Procedure AppelFichier;
var NomFichier,zz : String;
    i : integer;
begin
    NomFichier := '';
    for i := 1 to paramCount do begin
        zz := ParamStr(i);
        if zz[1]<>'/' then if NomFichier=''
            then NomFichier := zz
            else NomFichier := NomFichier+' '+zz;
    end;
    if NomFichier<>'' then begin
       ClipBoard.AsText := NomFichier;
       PostMessage(handle,wm_reg_fichier,1,0);
    end;
end; // appelFichier

var FichierParam : string;
begin  // FormCreate
{$IFDEF Debug}
   ecritDebug('formCreate regmain');
{$ENDIF}
  DocumentationPdf.visible := fileExists(docregPdf);
  DocumentationWord.visible := fileExists(docregWord);
  Screen.Cursors[crLettre] := LoadCursor(Hinstance,'LETTRE');
  Screen.Cursors[crZoom]   := LoadCursor(Hinstance,'ZOOM');
  Screen.Cursors[crGomme]  := LoadCursor(Hinstance,'GOMME');
  Screen.Cursors[crPencil] := LoadCursor(Hinstance,'PENCIL');
  Screen.Cursors[crCible]  := LoadCursor(Hinstance,'CIBLE');
  Screen.Cursors[crRectangle]  := LoadCursor(Hinstance,'RECTANGLE');

  Screen.Cursors[crCibleMove] := LoadCursor(Hinstance,'CIBLEMOVE');
  Screen.Cursors[crOrigine] := LoadCursor(Hinstance,'ORIGINE');
  Screen.Cursors[crOrigineTemps] := LoadCursor(Hinstance,'ORIGINETEMPS');

  WebItem.Visible := true;
  Application.OnHint := FormShowHint;
  try
  system.sysUtils.ForceDirectories(tempDirReg);
  except
    // Protégé sur certains réseaux ?
  end;
  FichierParam := ChangeFileExt(Application.ExeName,'.CHM');
  if FileExists(FichierParam)
     then Application.HelpFile := FichierParam
     else Application.HelpFile := '';
  Application.ShowHint := true;
  ModeAcquisition := AcqClavier;
  MruList := TStringList.Create;
  LitExemples;
  try
  litCurrentUser;
  except
  end;
  OptionsItem.visible := existeOption('O',true);
  MruItemUpdate; // Update MRU menu items
  AcqItemUpdate; // Update Acquisition menu items
  Application.OnMessage := AppMessage;
  ModifFichier := false;
  NomFichierData := '';
  ModifConfigAcq := false;
  FichierParam := '';
  if paramCount>0 then appelFichier;
  UpDateMenuItems(nil);
  HeureSauvegarde := now;
  openDialog.filterIndex := 1;
  NomFichierSauvegarde := TPath.Combine(tempDirReg,'Regressi.rw3');
  HauteurColonne := GridFontSize * Screen.PixelsPerInch div 46;
  LargeurUnCarac := HauteurColonne*2 div 3;
  ResizeButtonImagesforHighDPI(self);
  {$IFDEF Win32}
  {$ELSE}
     VideoItem.visible := false;
     VideoItem.enabled := false;
  {$ENDIF}
end; // FormCreate

procedure TFRegressiMain.FormShowHint(Sender: TObject);
var FilePart : string;
begin
   if Application.Hint=''
      then begin
          Caption := stRegressi;
          if NomFichierData<>'' then begin
             try
             FilePart := ExtractFileName(nomFichierData);
             Caption := stRegressi+' ['+FilePart+']';
             except
             end;
          end;
      end
      else Caption := Application.Hint
end;

procedure TFRegressiMain.SonItemClick(Sender: TObject);
begin
     if not verifSauve then exit;
     try
     if WaveForm=nil then
         Application.CreateForm(TWaveForm,WaveForm);
     WaveForm.WindowState := wsMaximized;
     NomFichierData := '';
     modeAcquisition := AcqSon;
     WaveForm.Show;
     WaveForm.SetFocus;
     except
     end;
end;

procedure TFRegressiMain.CloseAll;
begin
     Caption := 'Regressi';
     if Fvaleurs<>nil then Fvaleurs.perform(WM_REG_MAJ,MajVide,0);
     if FgrapheVariab<>nil then FgrapheVariab.perform(WM_REG_MAJ,MajVide,0);
     if FgrapheFFT<>nil then FgrapheFFT.close;
     if Fstatistique<>nil then Fstatistique.close;
     if FgrapheParam<>nil then FgrapheParam.close;
     if WaveForm<>nil then WaveForm.close;
     if OptiqueForm<>nil then OptiqueForm.close;
     if ffmpegForm<>nil then ffmpegForm.Close;
     commPagePanel.visible := false;
     resetEnTete;
     Application.ProcessMessages;
end;

Function TFregressiMain.VerifSauve : boolean;
var zz : string;
begin
  result := true;
  grandeursOpen;
  grapheOpen;
  if pageCourante>0 then begin
     if (pageCourante>0) and modifFichier
        then begin
        if NomFichierData=''
        then zz := stData
        else zz := stModif+ExtractFileName(nomFichierData);
           case MessageDlg(stSauve+zz,mtConfirmation,[mbYes,mbNo,mbCancel],0) of
           mrYes : if NomFichierData=''
               then FileSaveAsItemClick(nil)
               else FileSaveItemClick(nil);
           mrNo : result := true;
           mrCancel : result := false;
        end; // case
        end;
  end;
  if result then closeAll;
end;

procedure TFRegressiMain.FileOpenItemClick(Sender: TObject);
begin
    if OpenDialog.InitialDir='' then OpenDialog.InitialDir := DataDir;
    OpenDialog.Title := stOuvrir;
    if OpenDialog.execute then
       LitFichier(openDialog.FileName,true,openDialog.filterIndex=FilterIndexPasco);
end;

function TFRegressiMain.litFichierVideo(const nomFichier : string) : boolean;
begin
     if ffmpegForm=nil then
         Application.CreateForm(TffmpegForm,ffmpegForm);
     ffmpegForm.WindowState := wsMaximized;
     ModeAcquisition := AcqVideo;
     ffmpegForm.Show;
     ffmpegForm.SetFocus;
     ffmpegForm.ouvreFichier(nomFichier);
     result := pageCourante>0;
end;

function TFRegressiMain.litFichierSon(const nomFichier : string) : boolean;
begin
     if WaveForm=nil then
         Application.CreateForm(TWaveForm,WaveForm);
     WaveForm.WindowState := wsMaximized;
     WaveForm.Show;
     WaveForm.SetFocus;
     WaveForm.ouvreFichier(nomFichier);
     result := pageCourante>0;
end;

function TFRegressiMain.litFichierImage(const nomFichier : string) : boolean;
begin
     if OptiqueForm=nil then
         Application.CreateForm(TOptiqueForm,OptiqueForm);
     OptiqueForm.WindowState := wsMaximized;
     OptiqueForm.Show;
     OptiqueForm.SetFocus;
     OptiqueForm.ouvreFichier(nomFichier);
     result := pageCourante>0;
end;

procedure TFRegressiMain.LitFichier(const FileName : string;verif : boolean;isPasco : boolean);
var verifLecture : boolean;
    extension : string;
begin
try
if FileExists(FileName)
  then begin
      if verif
           then begin
              if not verifSauve then exit
           end
           else closeAll;
     optionsDlg.resetConfig;
     grandeursOpen;
     grapheOpen;
     modeAcquisition := AcqFichier;
     Screen.cursor := crHourGlass;
     nomFichierData := FileName;
     ErreurDetectee := false;
     extension := AnsiUpperCase(extractFileExt(nomFichierData));
     if extension='' then nomFichierData := ChangeFileExt(nomFichierData,'.RW3');
     if extension='.RW3'
        then VerifLecture := litFichierWin
        else if extension='.RRR'
             then VerifLecture := litFichierDos(nomFichierData)
        else if extension='.CSV'
             then VerifLecture := litFichierCSV(nomFichierData,true,isPasco)
             else if extension='.CPT'
             then VerifLecture := litFichierCPT(nomFichierData)
             else if extension='.EPS'
             then VerifLecture := litFichierCCD(nomFichierData)
             else if extension='.RXML'
             then VerifLecture := litFichierXML(nomFichierData)
             else if extension='.LAB'
                 then VerifLecture := litFichierVTT(nomFichierData)
                 else if (extension='.XMBL') or
                            (extension='.CMBL') or
                            (extension='.QMBL')
                     then VerifLecture := litFichierLogger(nomFichierData)
                     else if (extension='.AVI') or (extension='.MP4') or
                             (extension='.MPG') or (extension='.ASF') or
                             (extension='.WMV') or (extension='.MOV') or
                             (extension='.MPEG')
                     then VerifLecture := litFichierVideo(FileName)
                     else if (extension='.WAV') or (extension='.MP3')
                     then VerifLecture := litFichierSon(FileName)
                     else if (extension='.XML')
                     then VerifLecture := litFichierVotable(FileName,true)
                     else if (extension='.BMP') or (extension='.JPG') or
                             (extension='.PNG') or (extension='.JPEG')
                     then VerifLecture := litFichierImage(FileName)
                     else if (extension='.FIT') or (extension='.FITS')
                     then VerifLecture := litFichierFITS(FileName)
                     else if (extension='.TXT') and (isPasco)
                     then VerifLecture := litFichierCSV(nomFichierData,true,true)
                     else if (extension='.H5')
                     then VerifLecture := litFichierH5(nomFichierData)
                     else verifLecture := FormDDE.importeFichierTableur(nomFichierData);
     FinOuvertureFichier(verifLecture);
     Screen.cursor := crDefault;
  end
  else begin
     strErreurFichier := erFileNotExist+' : '+FileName;
     FinOuvertureFichier(false);
  end;
  except
     strErreurFichier := '';
     FinOuvertureFichier(false);
  end;
end;

procedure TFRegressiMain.FileSaveItemClick(Sender: TObject);
var extension : string;
begin
     if pageCourante>0 then if nomFichierData<>''
        then begin
             extension := AnsiUpperCase(ExtractFileExt(NomFichierData));
             if extension='.RXML'
                then begin
                   EcritFichierXML(NomFichierData)
                end
                else begin
                   nomFichierData := changeFileExt(NomFichierData,'.rw3');
                   EcritFichierWin(NomFichierData);
                end;
             MruAdd(NomFichierData); // Update MRUList using saved filename
        end
        else FileSaveAsItemClick(sender);
    modifFichier := false;
end;

procedure TFRegressiMain.FileSaveAsItemClick(Sender: TObject);
var extension : string;
begin
if SaveDialog.InitialDir=''
   then SaveDialog.InitialDir := DataDir;
with saveDialog do if Execute then begin
     extension := AnsiUpperCase(ExtractFileExt(FileName));
     case filterIndex of
          1 : extension := '.RW3';
          2 : extension := '.TXT';
          3 : extension := '.CSV';
          4 : extension := '.RXML';
     end;
     if (ofExtensionDifferent in Options) or (filterIndex>1)
        then begin
            if extension='.CSV' then begin
                 FormDDE.exporteFichierTableur(FileName);
                 filterIndex := 3;
                 exit;
            end;
            if extension='.RXML' then begin
                 EcritFichierXML(FileName);
                 filterIndex := 4;
                 exit;
            end;
            if extension='.TXT' then begin
                 FileName := ChangeFileExt(FileName,'.TXT');
                 FormDDE.exporteFichierTableur(FileName);
                 filterIndex := 2;
                 exit
            end;
    end;
    MruAdd(FileName); // Update MRUList using saved filename
    NomFichierData := FileName;
    ecritFichierWin(FileName);
end end;

procedure TFRegressiMain.FileExitItemClick(Sender: TObject);
begin
    Close
end;

procedure TFRegressiMain.CutItemClick(Sender: TObject);

procedure CutRange;
var r1,c1,r2,c2,r,c:integer;
    list,flist:tstringlist;
begin with activeGrid do begin
 c1:=Selection.Left;
 r1:=selection.top;
 c2:=Selection.Right ;
 r2:=selection.Bottom ;
 if not ((c1>=0)and (r1>=0)and (c2>=c1)and (r2>=r1)) then exit;
 list:=tstringlist.create;
 flist:=tstringlist.create;
 for r:=r1 to r2 do begin
   flist.clear;
   for c:=c1 to c2 do begin
     flist.append(cells[c,r]);
     cells[c,r]:='';
   end;
   list.append(flist.commatext);
 end;
 clipboard.astext:=list.text;
 flist.free;
 list.free;
end end;

begin
   if Assigned(EditCtl) then with EditCtl do CutToClipBoard;
   if Assigned(ActiveGrid) then CutRange;
end; // CutItemClick

procedure TFRegressiMain.CopyItemClick(Sender: TObject);

procedure CopyRange;
var r1,c1,r2,c2,r,c:integer;
    list,flist:tstringlist;
begin with activeGrid do begin
 c1:=Selection.Left;
 r1:=selection.top;
 c2:=Selection.Right ;
 r2:=selection.Bottom ;
 if not ((c1>=0)and (r1>=0)and (c2>=c1)and (r2>=r1)) then exit;
 list:=tstringlist.create;
 flist:=tstringlist.create;
 for r:=r1 to r2 do begin
    flist.clear;
    for c:=c1 to c2 do flist.append(cells[c,r]);
    list.append(flist.commatext);
 end;
 clipboard.astext:=list.text;
 flist.free;
 list.free;
end end;

begin
    if Assigned(EditCtl)
       then with EditCtl do CopyToClipBoard
       else if Assigned(ActiveGrid)
       then CopyRange
       else begin
           if ActiveMDIchild=FgrapheVariab then
              FgrapheVariab.CopierItemClick(sender);
           if ActiveMDIchild=FgrapheParam then
              FgrapheParam.CopierItemClick(sender);
           if ActiveMDIchild=FgrapheFFT then
              FgrapheFFT.CopierItemClick(sender);
           if ActiveMDIchild=Fstatistique then
              Fstatistique.CopierItemClick(sender);
       end;
end; //CopyItemClick

procedure TFRegressiMain.CourbesItemClick(Sender: TObject);
begin
     if not verifSauve then exit;
     try
     if courbesForm=nil then
         Application.CreateForm(TcourbesForm,courbesForm);
     courbesForm.WindowState := wsMaximized;
     NomFichierData := '';
     modeAcquisition := AcqCourbes;
     courbesForm.Show;
     courbesForm.SetFocus;
     except
     end;
end;

procedure TFRegressiMain.CSVhorizontal1Click(Sender: TObject);
var verifLecture : boolean;
    fileName : string;
begin
    if OpenDialog.InitialDir='' then OpenDialog.InitialDir := DataDir;
    openDialog.filterIndex := 1;
    OpenDialog.Title := stOuvrir;
    if OpenDialog.execute then begin
           FileName := OpenDialog.FileName;
           if FileExists(FileName) then begin
              if not verifSauve then exit;
              optionsDlg.resetConfig;
              grandeursOpen;
              grapheOpen;
              modeAcquisition := AcqFichier;
              Screen.cursor := crHourGlass;
              nomFichierData := FileName;
              ErreurDetectee := false;
              VerifLecture := litFichierCSVHorizontal(nomFichierData,true);
              FinOuvertureFichier(verifLecture);
              Screen.cursor := crDefault;
           end
           else begin
              strErreurFichier := erFileNotExist+' : '+FileName;
              FinOuvertureFichier(false);
           end;
    end;
end;

procedure TFRegressiMain.PasteItemClick(Sender: TObject);

procedure PasteRange;
var r1,c1,r2,c2,r,c,i,j:integer;
    list,flist:tstringlist;
begin
if activeGrid=Fvaleurs.GridVariab then with activeGrid do begin
 if not clipboard.HasFormat(CF_TEXT) then exit;
 if not ((col>=0) and (row>=0)) then exit;
 list:=tstringlist.create;
 flist:=tstringlist.create;
 list.text:=clipboard.AsText ;
 if list.count>0 then begin
    c1:=col;
    r1:=row;
    flist.commatext:=list[0];
    c2:=c1+flist.count-1;
    r2:=r1+list.count-1;
    if c2>(colcount-1) then c2:=colcount-1;
    if r2>(rowcount-1) then r2:=rowcount-1;
    j:=0;
    for r:=r1 to r2 do begin
      flist.commatext:=list[j];
      i:=0;
      for c:=c1 to c2 do begin
        Fvaleurs.setValeurVariab(c,r,flist[i]);
        inc(i);
      end;
      inc(j);
   end;
 end;
 flist.free;
 list.free;
 Fvaleurs.MajGridVariab := true;
 Fvaleurs.traceGridVariab;
end end;

begin
   if Assigned(EditCtl) then begin
      if editCtl=Fvaleurs.memo
         then Fvaleurs.CollerItemClick(sender)
         else EditCtl.PasteFromClipBoard;
   end;
   if Assigned(ActiveGrid) then PasteRange;   
end; // PasteItemClick

procedure TFRegressiMain.UpdateMenuItems(Sender: TObject);
var p,NbrePagesExp : integer;
begin
   PrinterSetUpItem.visible := imPrinterSetUp in menuPermis;
   GrandeursBtn.enabled := pageCourante>0;
   GrandeursItem.enabled := GrandeursBtn.enabled;
   GrapheBtn.enabled := GrandeursBtn.enabled;
   FourierBtn.enabled := GrapheBtn.enabled;
   GrapheEulerBtn.Visible := GrapheBtn.enabled and (imEuler in menuPermis);
   FourierItem.enabled := FourierBtn.enabled;
   GrapheConstBtn.visible := (NbrePages>2) and
                             ((NbreConst+NbreParam[paramNormal])>=1);
   GrapheConstItem.visible := GrapheConstBtn.visible;
   Graphe3DBtn.visible := ((NbrePages>8) and
                          ((NbreConst+NbreParam[paramNormal])>=1)) or
                          (NbreVariab>3);
   Graphe3DItem.visible := Graphe3DBtn.visible;
   StatistiqueBtn.enabled := GrapheBtn.enabled and
                               (imStat in menuPermis);
   StatistiqueItem.enabled := StatistiqueBtn.enabled;
   FileSaveItem.Enabled := GrandeursBtn.enabled;
   EnvoyerItem.visible := GrandeursBtn.enabled and (GroupeDir<>'');
   RecevoirItem.visible := GroupeDir<>'';
   FileSaveAsItem.Enabled := GrandeursBtn.enabled;
   FileAddItem.Enabled := GrandeursBtn.enabled;
   FilePrintItem.enabled := GrandeursBtn.enabled;
   ExporterLatexItem.enabled := GrandeursBtn.enabled;
   FileCalcItem.Enabled := GrandeursBtn.enabled;
   MenuPage.Enabled := GrandeursBtn.enabled;
   MenuFenetre.Enabled := GrapheBtn.enabled;
   FocusAcquisitionBtn.visible := (ModeAcquisition in [AcqVideo,AcqBitmap,AcqSon,AcqChrono]) or
       (GrandeursBtn.visible and (ModeAcquisition=AcqCan));
   AcquisitionItem.visible := FocusAcquisitionBtn.visible;
   case modeAcquisition of
        AcqVideo : AcquisitionItem.caption := '&Video';
        AcqSon : AcquisitionItem.caption := '&Son';
        AcqBitmap : AcquisitionItem.caption := '&Image';
        AcqChrono : AcquisitionItem.caption := '&Chronophotographie';
        AcqCourbes : AcquisitionItem.caption := '&Courbes';
        else AcquisitionItem.caption := '&Acquisition';
   end;
   PrinterSetUpItem.visible := imPrinterSetUp in menuPermis;
   NbrePagesExp := 0;
   for p := 1 to nbrePages do
       if pages[p].experimentale then inc(NbrePagesExp);
   PageCalculerItem.Enabled := (NbrePagesExp>=2) and
                               (ModeAcquisition<>AcqSimulation);
   PageCopyItem.Enabled := ModeAcquisition<>AcqSimulation;
   PageSelectItem.Enabled := nbrePages>1;
end;

procedure TFRegressiMain.FormDestroy(Sender: TObject);
begin
   MruList.free;
   ExemplesList.Free;
end;

function TFRegressiMain.FormHelp(Command: Word; Data: Integer;
  var CallHelp: Boolean): Boolean;
begin
  inherited;
  result := Application.HelpFile<>'';
end;

procedure TFRegressiMain.EnvoieMessage(TypeChange : integer);
begin
     if (TypeChange=MajChangePage) and (pageCourante>0) then
        with pages[pageCourante] do begin
           affecteConstParam(false);
           affecteVariableP(false);
        end;
     Perform(WM_Reg_Maj,TypeChange,0)
end;

procedure TFRegressiMain.AffValeurParametre;
var i,index,imax,largeur,largeurMax : integer;
    Asection : TstatusPanel;
begin
     i := 0;
     while i<ListeConstAff.count do begin
         index := indexNom(ListeConstAff[i]);
         if (index=grandeurInconnue) or
            (grandeurs[index].genreG<>constante)
            then ListeConstAff.delete(i)
            else inc(i)
     end;
     if (NbreConst>0) and
        (ListeConstAff.count=0) then begin
           imax := pred(NbreConst);
           if imax>2 then imax := 2;
           for i := 0 to imax do
               ListeConstAff.add(grandeurs[indexConst[i]].nom);
     end;
     ConstHeader.panels.clear;
     largeurMax := 0;
     for i := 0 to pred(ListeConstAff.count) do begin
         index := indexNom(ListeConstAff[i]);
         Asection := ConstHeader.panels.add;
         Asection.text := ' '+grandeurs[index].FormatNomEtUnite(pages[pageCourante].valeurConst[index])+' ';
         largeur := length(Asection.text);
         if largeur>largeurMax then largeurMax := largeur;
     end;
     largeurMax := largeurMax*largeurUnCarac;
     for i := 0 to pred(ListeConstAff.count) do ConstHeader.panels[i].width := largeurMax;
     ConstHeader.width := largeurMax*ListeConstAff.count+2;
end;

procedure TFRegressiMain.MajPages;
var i : integer;
begin
     lectureFichier := false;
     lecturePage := false;
     if pageCourante>NbrePages then pageCourante := NbrePages;
     PanelPage.visible := NbrePages>1;
     CommPagePanel.visible := NbrePages=1;
     FocusAcquisitionBtn.visible := (ModeAcquisition in [AcqCan,AcqChrono,AcqVideo,AcqBitmap,AcqSon]);
     if pageCourante>0 then
        CommentaireEdit.text := pages[pageCourante].commentaireP;
     if NbrePages=1 then
        CommPageEdit.text := pages[1].commentaireP;
     for i := 1 to NbrePages do pages[i].numero := i;
     PanelNumPage.Caption := IntToStr(PageCourante)+'/'+IntToStr(NbrePages);
     PanelNumPage.Font.color := couleurPages[pageCourante];
     CommentaireEdit.Font.color := couleurPages[pageCourante];
     AffValeurParametre;
end;


procedure TFRegressiMain.TOCitemClick(Sender: TObject);
begin
    if Application.HelpFile<>''
       then //Application.HelpShowTableOfContents
           HtmlHelp(0,Application.helpFile,HH_Display_toc,0)
       else afficheErreur('Fichier Regressi.chm non trouvé ; effectuer l''installation de Regressi',0)
end;

procedure TFRegressiMain.AboutItemClick(Sender: TObject);
begin
     AboutBox := TaboutBox.create(self);
     AboutBox.ShowModal;
     AboutBox.free;
end;

procedure TFRegressiMain.WMRegFichier(var Msg: TWMRegMessage);
var clipspn,ficspn,NomComplet : string;
begin
     nomComplet := clipBoard.asText;
     clipspn := ExtractShortPathName(nomComplet);
     if clipspn='' then clipspn := 'clip';
     ficspn := ExtractShortPathName(nomFichierData);
     if ficspn='' then ficspn := 'fichier';
     if not AnsiSameText(nomComplet,NomFichierData) and
        not AnsiSameText(clipspn,ficspn)
            then LitFichier(nomComplet,true,false);
end;

procedure TFRegressiMain.WMRegMaj(var Msg: TWMRegMessage);
var i : integer;
begin if Fvaleurs<>nil then with Msg do begin
     case typeMaj of
          MajNumeroMesure : Fvaleurs.Perform(WM_Reg_Maj,MajNumeroMesure,CodeMaj);
          MajFichier : begin
             majPages;
             Fvaleurs.Perform(WM_Reg_Maj,MajFichier,CodeMaj);
          end
          else begin
             if TypeMaj in [MajGrandeur,MajAjoutPage,
                   MajSelectPage,MajGroupePage,MajChangePage,MajSupprPage] then
                       majPages;
             if TypeMaj in [MajAjoutPage,MajSupprPage,MajTri] then SauveEtatCourant;
             UpDateMenuItems(nil);
             Fvaleurs.Perform(WM_Reg_Maj,TypeMaj,CodeMaj); // en premier
             for i := 0 to pred(mdiChildCount) do
                 if (mdiChildren[i]<>Fvaleurs) then
                     mdiChildren[i].Perform(WM_Reg_Maj,TypeMaj,CodeMaj);
        end
    end;
end end;

procedure TFRegressiMain.PageSuivClick(Sender: TObject);
begin
  envoieMessage(MajSauvePage);
  if pageCourante<NbrePages
     then inc(PageCourante)
     else pageCourante := 1;
  envoieMessage(MajChangePage);
end; // PageSuivante

procedure TFRegressiMain.PagePrecClick(Sender: TObject);
begin
    envoieMessage(MajSauvePage);
    if pageCourante>1
       then dec(pageCourante)
       else pageCourante := NbrePages;
    envoieMessage(MajChangePage)
end; // PagePrecedente

procedure TFRegressiMain.PageAddClick(Sender: TObject);
var i : integer;
begin
     case ModeAcquisition of
          AcqClavier,AcqClipBoard : if ajoutePage then begin
             for i := 1 to NbreConstExp do
                 Pages[NbrePages].valeurConst[i] := pages[pred(NbrePages)].valeurConst[i];
             if NbreConstExp>0 then
                FValeurs.Feuillets.ActivePage := Fvaleurs.paramSheet;
             envoieMessage(MajAjoutPage);
             ModifFichier := true;
             if NbreConstExp>0 then FValeurs.show;
          end;
          AcqCan : if nomExeAcquisition<>'' then FormDDE.FocusAcquisition;
          AcqFichier : FileAddItemClick(sender);
          AcqSimulation : PageNewSimulItemClick(sender);
          AcqVideo : begin
              include(menuPermis,imVitesse);
              if ffmpegForm<>nil then begin
                 ffmpegForm.Show;
                 ffmpegForm.SetFocus;
              end;
          end;// AcqVideo
          AcqSon : begin
              if WaveForm=nil then
                 Application.CreateForm(TWaveForm,WaveForm);
              WaveForm.WindowState := wsMaximized;
              WaveForm.Show;
              WaveForm.SetFocus;
          end;
          AcqBitmap : begin
              if OptiqueForm=nil then
                 Application.CreateForm(TOptiqueForm,OptiqueForm);
              OptiqueForm.WindowState := wsMaximized;
              OptiqueForm.Show;
              OptiqueForm.SetFocus;
          end;
          AcqChrono : begin
              if chronoForm=nil then
                 Application.CreateForm(TchronoForm,chronoForm);
              chronoForm.WindowState := wsMaximized;
              chronoForm.Show;
              chronoForm.SetFocus;
          end;
          AcqCourbes : begin
              if courbesForm=nil then
                 Application.CreateForm(TcourbesForm,courbesForm);
              courbesForm.WindowState := wsMaximized;
              courbesForm.Show;
              courbesForm.SetFocus;
          end;
          AcqArduino : begin
              if ArduinoForm=nil then
                 Application.CreateForm(TArduinoForm,ArduinoForm);
              verifWindowsMax(ArduinoForm);
              ArduinoForm.Show;
              ArduinoForm.SetFocus;
          end;
          AcqOscilloArduino : begin
              if ArduinoOscilloForm=nil then
                 Application.CreateForm(TArduinoOscilloForm,ArduinoOscilloForm);
              verifWindowsMax(ArduinoOscilloForm);
              ArduinoOscilloForm.Show;
              ArduinoOscilloForm.SetFocus;
          end;
     end;
     modifFichier := true;
end;

procedure TFRegressiMain.PageAddItemClick(Sender: TObject);
begin
  inherited;
  CollerPageItem.Visible := ModeAcquisition=AcqClipBoard;
  PageNewItem.Visible := true;
  case ModeAcquisition of
        AcqClavier,AcqClipBoard : PageNewItem.Caption := 'Créer page vierge';
        AcqCan : begin
            PageNewItem.Caption := ChangeFileExt(ExtractFileName(nomExeAcquisition),'');
            PageNewItem.Visible := FileExists(NomExeAcquisition)
        end;
        AcqFichier : PageNewItem.Caption := 'Fusionner';
        AcqSimulation : PageNewItem.Caption := 'Créer page simulée';
        AcqBitmap : PageNewItem.Caption := 'Image';
        AcqVideo : PageNewItem.Caption := 'Video';
        AcqSon : PageNewItem.Caption := 'Son';
        AcqArduino : PageNewItem.Caption := stArduino;
        else begin
           PageNewItem.Caption := '';
           PageNewItem.Visible := false;
        end;
  end;
end;

procedure TFRegressiMain.PageDelClick(Sender: TObject);
begin
     if OKformat(OkDelPage,[IntToStr(pageCourante)]) then begin
        supprimePage(pageCourante,true);
        envoieMessage(MajSupprPage);
     end;
end;

procedure TFRegressiMain.FileNewClipItemClick(Sender: TObject);
begin
    ModifFichier := true;
    FgrapheVariab.Perform(WM_Reg_Maj,MajVide,0);
    FormDDE.ImportePressePapier;
    PanelStatut.visible := NbrePages>0;
    dispositionFenetre := dMosaicVert;
    WindowClick(nil);
    FgrapheVariab.Perform(WM_Reg_Maj,MajFichier,0);
end;

procedure TFRegressiMain.ExemplesClick(Sender: TObject);
var numero : integer;
begin
    numero := (sender as TMenuItem).tag;
    litFichier(ExemplesDir+ExemplesList[numero],true,false)
end;

procedure TFRegressiMain.NewClavierItemClick(Sender: TObject);
begin
      if NewClavierDlg=nil then
         Application.CreateForm(TNewClavierDlg,NewClavierDlg);
      if (NewClavierDlg.showModal=mrOK) and (NbreVariab>0) then begin
         FichierTrie := DataTrieGlb;
         AjoutePage;
         Pages[1].CommentaireP := NewClavierDlg.MemoClavier.lines[0];
         ModifFichier := true;
         optionsDlg.resetConfig;
         ClavierAvecGraphe := false;
         FgrapheVariab.Perform(WM_Reg_Maj,MajVide,0);
         FgrapheVariab.configCharge := true;
         FgrapheVariab.Graphes[1].useDefault := NewClavierDlg.grapheMinMax;
         FgrapheVariab.Perform(WM_Reg_Maj,MajFichier,0);
         if ClavierAvecGraphe
            then dispositionFenetre := dMosaicVert
            else dispositionFenetre := dMaxi;
         PanelStatut.visible := true;
         pages[pageCourante].affectevariableP(false);
         FValeurs.Perform(WM_Reg_Maj,MajFichier,0);
         FValeurs.feuillets.ActivePage := Fvaleurs.VariabSheet;
         FValeurs.TraceGrid;
         WindowClick(nil);
         Fvaleurs.show;
      end;
end;

procedure TFRegressiMain.NewSimulationItemClick(Sender: TObject);
begin
    if not verifSauve then exit;
    NomFichierData := '';
    ModeAcquisition := AcqSimulation;
    OrdreLissage := 3;
    OrdreFiltrage := 2;
    AjoutePage;
    optionsDlg.resetConfig;
    ajouteExperimentale('t',variable);
    Grandeurs[0].NomUnite := 's';
    GrandeursBtnClick(nil);
    PanelStatut.visible := true;
    Fvaleurs.Perform(WM_Reg_Maj,MajFichier,0);
    Fvaleurs.Show;
end;

procedure TFRegressiMain.NumerisationItemClick(Sender: TObject);
begin
     if not verifSauve then exit;
     try
     if chronoForm=nil then
         Application.CreateForm(TchronoForm,chronoForm);
     chronoForm.WindowState := wsMaximized;
     NomFichierData := '';
     modeAcquisition := AcqChrono;
     chronoForm.Show;
     chronoForm.SetFocus;
     except
     end;
end;

procedure TFRegressiMain.FourierBtnClick(Sender: TObject);
begin
     FourierOpen;
     verifWindowsMax(FgrapheFFT);
     FgrapheFFT.Show;
     FgrapheFFT.SetFocus;
     FgrapheFFT.MajFichierEnCours := false;
end;

procedure TFRegressiMain.FourierOpen;
begin
     if FgrapheFFT=nil then begin
        sauveEtatCourant;
        FgrapheFFT := TfgrapheFFT.create(self);
     end;
end;

procedure TFRegressiMain.ExporterLatexItemClick(Sender: TObject);
begin
     if LatexDlg=nil
        then Application.CreateForm(TLatexDlg, LatexDlg);
     LatexDlg.showModal;
end;

procedure TFRegressiMain.GrandeursOpen;
begin
     if Fvaleurs=nil then Fvaleurs := TFvaleurs.create(self)
end;

Procedure TFRegressiMain.verifWindowsMax(aForm : TForm);
begin
    if aForm.WindowState=wsMinimized then if dispositionFenetre=dMaxi
        then aForm.WindowState:=wsMaximized
        else aForm.WindowState:=wsNormal;
end;

procedure TFRegressiMain.graphe3DBtnClick(Sender: TObject);
begin
     Graphe3DOpen;
     verifWindowsMax(Fgraphe3D);
     Fgraphe3D.Show;
     Fgraphe3D.SetFocus;
     Fgraphe3D.MajFichierEnCours := false;
end;

procedure TFRegressiMain.Graphe3DOpen;
begin
     if Fgraphe3D=nil then begin
        SauveEtatCourant;
        Fgraphe3D := Tfgraphe3D.create(self);
     end;
end;

procedure TFRegressiMain.GrapheBtnClick(Sender: TObject);
begin
     grapheOpen;
     verifWindowsMax(FgrapheVariab);
//               Fvaleurs.WindowState:=wsMaximized;
     if (Screen.ActiveForm=FgrapheVariab) and (sender<>GrapheBtn)
        then begin
           Fvaleurs.Show;
           Fvaleurs.SetFocus;
        end
        else begin
           FgrapheVariab.Show;
           FgrapheVariab.SetFocus;
        end;
end;

procedure TFRegressiMain.GrandeursBtnClick(Sender: TObject);
begin
     grandeursOpen;
     verifWindowsMax(Fvaleurs);
     Fvaleurs.Show;
     Fvaleurs.SetFocus;
end;

procedure TFRegressiMain.AddFichier(NomFichier : string);
var extension : string;
    p,pageDebut : TcodePage;
begin
       extension := AnsiUpperCase(extractFileExt(NomFichier));
       if extension='' then begin
          nomFichier := ChangeFileExt(nomFichier,'.RW3');
          extension := '.RW3'
       end;
       PageDebut := succ(PageCourante);
       if extension = '.RW3'
          then AjouteFichier(NomFichier)
          else if extension = '.CSV'
                  then LitFichierCSV(NomFichier,false,false)
                  else if extension = '.CPT'
                  then AjouteFichierCPT(NomFichier)
                  else if extension = '.EPS'
                  then AjouteFichierCCD(NomFichier)
                  else if extension = '.LAB'
                     then afficheErreur(erVTTAdd,0)
                  else if (extension='.XMBL') or
                          (extension='.CMBL') or
                          (extension='.QMBL')
                        then litFichierLogger(nomFichierData)
                  else if (extension='.AVI') or (extension='.MP4') or
                          (extension='.MPG') or (extension='.ASF') or
                          (extension='.WMV') or (extension='.MOV') or
                          (extension='.M4V') or
                          (extension='.MPEG')
                     then litFichierVideo(NomFichier)
                     else if (extension='.WAV') or (extension='.MP3')
                     then litFichierSon(NomFichier)
                     else if (extension='.FIT') or (extension='.FITS')
                     then ajouteFichierFits(NomFichier)
                     else if (extension='.XML')
                     then litFichierVotable(NomFichier,false)
                     else FormDDE.AjouteFichierTableur(NomFichier);
       for p := pageDebut to NbrePages do pages[p].recalculP;
end;

procedure TFRegressiMain.FileAddItemClick(Sender: TObject);
var i : integer;
    saveFilter : string;
begin
   OpenDialog.Title := 'Fusionner';
   saveFilter := OpenDialog.Filter;
   OpenDialog.Filter := 'Regressi Windows|*.rw3;*.rxml|Tableur txt ou csv|*.txt;*.csv|Spectre FITS|*.fit;*.fits|Votable IMCE|*.xml';
   OpenDialog.options := OpenDialog.options + [ofAllowMultiSelect];
   Screen.cursor := crHourGlass;
   lecturePage := true;
   if OpenDialog.execute then
      if OpenDialog.Files.count>1
         then begin
             for i := 0 to OpenDialog.Files.Count - 1 do
               AddFichier(OpenDialog.Files.Strings[I])
         end
         else AddFichier(openDialog.FileName);
   envoieMessage(MajFichier);
   OpenDialog.options := OpenDialog.options - [ofAllowMultiSelect];
   Screen.cursor := crDefault;
   modifFichier := true;
   OpenDialog.Filter := saveFilter;
end;

procedure TFRegressiMain.StatistiqueBtnClick(Sender: TObject);
begin
     if pageCourante=0 then exit;
     statistiqueOpen;
     if Fstatistique.WindowState=wsMinimized then if dispositionFenetre=dMaxi
        then Fstatistique.WindowState:=wsMaximized
        else Fstatistique.WindowState:=wsNormal;
     Fstatistique.Show;
     Fstatistique.SetFocus;
end;

procedure TFRegressiMain.StatistiqueOpen;
begin
     if Fstatistique=nil then begin
        SauveEtatCourant;
        Fstatistique := Tfstatistique.create(self);
     end;
end;

procedure TFRegressiMain.FinOuvertureFichier(LectureOK : boolean);
var p : integer;
begin
     LectureFichier := false;
     LecturePage := false;
     ModifFichier := false;
     ModifConfigAcq := false;
     if LectureOK
         then begin
           p := 1;
           while (p<NbrePages) and not pages[p].active do inc(p);
           if not pages[p].active then pages[1].active := true;
           MruAdd(nomFichierData);  // Update MRUList 
           Caption := 'Regressi Windows ['+nomFichierData+']';
           for p := 1 to NbrePages do
               pages[p].NbrePointsSauves := pages[p].nmes;
        end
        else begin
           MruDel(nomFichierData);
           nomFichierData := '';
           if strErreurFichier<>'' then AfficheErreur(strErreurFichier,0);
           Caption := 'Regressi Windows';
           // Must be done backwards through the MDIChildren array
           for p := pred(MDIChildCount) downto 0 do
               MDIChildren[p].WindowState := wsMinimized
        end;
     if NbrePages>0
         then begin
             PageCourante := 1;
             if FgrapheVariab.ModelePagesIndependantesMenu.checked and
                 (Pages[1].TexteModeleP.count>0) then begin
                    ModelePagesIndependantes := true;
                    TexteModele.clear;
                    TexteModele := pages[1].TexteModeleP;
              end;
         end
         else PageCourante := 0;
     PanelStatut.Visible := NbrePages>0;
     envoieMessage(MajFichier); // Fvaleurs uniquement ; fait également majPages
     NbreGrandeursSauvees := NbreGrandeurs;
     UpDateMenuItems(nil);
     if lectureOK then begin
        if erreurDetectee or (NbreVariab<2)
           then Fvaleurs.show
           else FgrapheVariab.show;
        windowClick(nil);
     end;
end;

procedure TFRegressiMain.MenuPageClick(Sender: TObject);
begin
     PageSuivItem.enabled := NbrePages>1;
     PagePrecItem.enabled := NbrePages>1;
     PageDelItem.enabled := NbrePages>1;
     PageGrouperItem.enabled := NbrePages>1;
     PageAddItem.enabled := NbrePages<MaxPages;
     PageNewClipItem.visible := ModeAcquisition=AcqClipBoard;
     PageNewItem.visible := true;
end;

procedure TFRegressiMain.GrapheConstBtnClick(Sender: TObject);
begin
     GrapheConstOpen;
     if FgrapheParam.WindowState=wsMinimized then if dispositionFenetre=dMaxi
        then FgrapheParam.WindowState:=wsMaximized
        else FgrapheParam.WindowState:=wsNormal;
     FgrapheParam.configCharge := true;
     FgrapheParam.MajFichierEnCours := false;
     FgrapheParam.Show;
     FgrapheParam.SetFocus;
end;

procedure TFRegressiMain.GrapheConstOpen;
begin
     if FgrapheParam=nil then begin
        SauveEtatCourant;
        FgrapheParam := TfgrapheParam.create(self);
     end;
end;

procedure TFRegressiMain.GrapheEulerOpen;
begin
     if FgrapheEuler=nil then begin
        SauveEtatCourant;
        FgrapheEuler := TfgrapheEuler.create(self);
     end;
end;

procedure TFRegressiMain.GrapheEulerBtnClick(Sender: TObject);
begin
     GrapheEulerOpen;
     if FgrapheEuler.WindowState=wsMinimized then if dispositionFenetre=dMaxi
        then FgrapheEuler.WindowState:=wsMaximized
        else FgrapheEuler.WindowState:=wsNormal;
     FgrapheEuler.configCharge := true;
     FgrapheEuler.MajFichierEnCours := false;
     FgrapheEuler.Show;
     FgrapheEuler.SetFocus;
end;

procedure TFRegressiMain.GrapheOpen;
begin
     if FgrapheVariab=nil then
        FgrapheVariab := TfgrapheVariab.create(self);
end;

procedure TFRegressiMain.GrouperColonnesItemClick(Sender: TObject);
var NomFichierTemp : string;
begin
   if OKreg(okPageVersCol,0) then begin
      NomFichierTemp := TPath.Combine(tempDirReg,'Grouper.RW3');
      EcritFichierWin(NomFichierTemp);
      groupePageColonnes;
      modifFichier := true;
   end;
end;

procedure TFRegressiMain.ImageItemClick(Sender: TObject);
begin
     if not verifSauve then exit;
     try
     if OptiqueForm=nil then
         Application.CreateForm(TOptiqueForm,OptiqueForm);
     OptiqueForm.WindowState := wsMaximized;
     NomFichierData := '';
     modeAcquisition := AcqBitmap;
     if sender=FileNewIntensite then optiqueForm.mesureRG.itemIndex := 0;
     if sender=FileNewAngle then optiqueForm.mesureRG.itemIndex := 1;
     OptiqueForm.Show;
     OptiqueForm.SetFocus;
     except
     end;
end;

procedure TFRegressiMain.MruItemClick(Sender: TObject);
var index : Integer;
    nom : string;
begin
  Index := TMenuItem(Sender).Tag;
  nom := MruList[Index];
  if FileExists(nom)
     then LitFichier(nom,true,false)
     else afficheErreur(TMenuItem(Sender).caption+erNotExists,0)
end;

procedure TFRegressiMain.MruItemUpdate;
var i,ii : integer;
    MRUpermis : boolean;
begin
  MRUpermis := imMRU in MenuPermis;
  ii := MRUSeparator.MenuIndex+1;
  for i := 0 to pred(MRUList.count) do begin
     if length(MRUList[i])>0 then
        MenuFile.Items[i+ii].Caption := '&'+IntToStr(succ(i))+' '+
            MRUList[i][1]+': '+ ExtractFileName(MRUList[i]);
     MenuFile.Items[i+ii].Visible := MRUpermis and (MRUList[i]<>''); {Visible if not blank}
  end;
  MRUSeparator.Visible := MRUpermis and (MRUList[0] <> ''); {Seperator visible if not blank}
end;

procedure TFRegressiMain.AcqItemUpdate;
var i,ii : integer;
    nomCourant : string;
begin
  ii := AcqSeparator.MenuIndex+1;
  AcqSeparator.Visible := AcqList.count>0;
  for i := 0 to pred(AcqList.count) do begin
      NomCourant := ChangeFileExt(ExtractFileName(AcqList[i]),'');
      FileNewItem.Items[i+ii].Caption := NomCourant;
      FileNewItem.Items[i+ii].Visible := true;
  end;
  for i := AcqList.count to maxAcq do
      FileNewItem.Items[i+ii].Visible := false;
end;

procedure TFRegressiMain.MruAdd(const FileName: String);
begin
  if FileName='' then exit;
  MruDel(FileName);
  while MruList.count > maxMru do MRUList.delete(MRUList.Count - 1);
  while MruList.count < maxMru do MRUList.add('');
  MruList.Insert(0,Filename);
  MruItemUpdate;
end;

procedure TFRegressiMain.MruDel(const FileName: String);
var
  Index: Integer;
begin
  Index := 0;
// Compare FileName to MRUList items
  while Index < (MRUList.count - 1) do
    if AnsiUpperCase(FileName) = AnsiUpperCase(MRUList[Index])
       then MRUList.delete(Index) // If already there, delete occurrence
       else inc(Index) // If not try next item
end;

procedure TFRegressiMain.MenuEditionClick(Sender: TObject);
var S : tsauvegarde;
begin
   UtilisateurItem.visible := true;
   UtilisateurSepar.visible := true;
   CollerPageItem.enabled := NbrePages>0;
   RazItem.enabled := NbrePages>0;
   RestaurerItem.visible := PileSauvegarde.count>0;
   UndoBtn.Hint := 'Annuler';
   If restaurerItem.visible then begin
      S := PileSauvegarde.peek;
      case S.undo of
           UsupprPage : restaurerItem.caption := stUndoSuppr+stPage;
           UsupprPoint : restaurerItem.caption := stUndoSuppr+'points';
           UsupprConst,UsupprVariab :
              restaurerItem.caption := stUndoSuppr+S.GrandeurSauvee.nom;
           Ugrouper : restaurerItem.caption := stUndoGr;
      end;
      UndoBtn.Hint := restaurerItem.caption;
   end;
   undoBtn.Hint := restaurerItem.caption;
   EditCtl := nil;
   ActiveGrid := nil;
   if Screen.ActiveControl is TCustomEdit
      then EditCtl := Screen.ActiveControl as TCustomEdit
      else if (Screen.ActiveControl is TCustomGrid)
           then ActiveGrid := Screen.ActiveControl as TstringGrid;
//  if Assigned(EditCtl) and (EditCtl.SelLength=0) then EditCtl.selLength := 1;
  if Assigned(EditCtl) or Assigned(ActiveGrid)
    then begin
       CutItem.Enabled := true;
       CopyItem.Enabled := CutItem.Enabled;
       PasteItem.Enabled := ClipBoard.AsText <> '';
       DeleteItem.Enabled := CutItem.Enabled;
    end
    else begin
       CutItem.Enabled := false;
       CopyItem.Enabled := (ActiveMDIchild=FgrapheVariab) or
          (ActiveMDIchild=FgrapheParam) or
          (ActiveMDIchild=FgrapheFFT) or
          (ActiveMDIchild=Fstatistique);
       PasteItem.Enabled := False;
       DeleteItem.Enabled := False;
    end;
end;

procedure TFRegressiMain.DeleteItemClick(Sender: TObject);
begin
   if Assigned(EditCtl) then with EditCtl do ClearSelection;
end;

procedure TFRegressiMain.DistribuerItemClick(Sender: TObject);
begin
     PageDistribDlg := TPageDistribDlg.create(self);
     PageDistribDlg.showModal;
     PageDistribDlg.free;
end;

procedure TFRegressiMain.AppelFichier(nomFichier : string);
begin
      if ShellExecute(Handle, 'open', PChar(nomFichier), nil, nil, SW_SHOW) <= 32 then
         ShowMessage(stNoAccesInstall+NomFichier);
end;

procedure TFRegressiMain.DocModeleClick(Sender: TObject);
begin
  //  appelFichier(DocModelisation)
    AppelFichier(DocIncertitudes)
end;

procedure TFRegressiMain.DocumentationpdfClick(Sender: TObject);
begin
     AppelFichier(DocRegPdf)
end;

procedure TFRegressiMain.DocumentationWordClick(Sender: TObject);
begin
     appelFichier(DocRegWord)
end;

procedure TFRegressiMain.PageDebutBtnClick(Sender: TObject);
begin
     if PageCourante>1 then begin
        envoieMessage(MajSauvePage);
        PageCourante := 1;
        envoieMessage(MajChangePage);
     end;
end;

procedure TFRegressiMain.PageFinBtnClick(Sender: TObject);
begin
     if PageCourante<NbrePages then begin
        envoieMessage(MajSauvePage);
        PageCourante := NbrePages;
        envoieMessage(MajChangePage);
     end;
end;

procedure TFRegressiMain.AcqItemClick(Sender: TObject);
var index : integer;
begin
      index := TMenuItem(Sender).Tag;
      nomExeAcquisition := AcqList[index];
      FormDDE.FocusAcquisition;
end;

procedure TFRegressiMain.CommentaireEditChange(Sender: TObject);
begin
    if pageCourante>0 then
       pages[pageCourante].commentaireP := CommentaireEdit.text
end;

procedure TFRegressiMain.CommPageEditChange(Sender: TObject);
begin
    pages[1].commentaireP := CommPageEdit.text
end;

procedure TFRegressiMain.FormClose(Sender: TObject;var Action: TCloseAction);

procedure sauveExtension;
var regist : Tregistry;
    clefRW3 : string;
    ini : TregIniFile;
begin
  try
  Regist := TRegistry.create;
  Regist.RootKey := HKey_Classes_Root;
  if Regist.OpenKey('\.rw3',true) then begin // true force à créer
     clefRW3 := Regist.ReadString(''); // '' donc default
     if clefRW3='' then begin // création
        clefRW3 := 'RW3File';
        Regist.WriteString('',clefRW3);
        Regist.WriteString('Content Type','application\regressi');
     end;
     clefRW3 := '\'+clefRW3;
  end;
  if Regist.OpenKey(clefRW3,true) then begin
     Regist.DeleteKey('IsShortcut');
     if Regist.OpenKey(clefRW3+'\shell',true) then ;
     if Regist.OpenKey(clefRW3+'\shell\Open',true) then ;
     if Regist.OpenKey(clefRW3+'\shell\Open\ddeExec',true) then
     if Regist.OpenKey(clefRW3+'\shell\Open\ddeExec\Topic',true) then
        Regist.WriteString('','ServeurDDE');
     if Regist.OpenKey(clefRW3+'\shell\Open\ddeExec\Application',true) then
        Regist.WriteString('',stRegressi);
  end;
  regist.free;
  except
  end;
  try
  Ini := TRegIniFile.create(RegistreReg);
  Ini.WriteString(stRegressi,'Path',extractFilePath(application.exeName));
  Ini.Free;
  Ini := TRegIniFile.create('Software');
  Ini.WriteString(stRegressi,'Path',extractFilePath(application.exeName));
  Ini.Free;
  except
  end;
end;

Procedure EcritCurrentUser;
var i : integer;
    Rini : TInifile;
begin
    MruDel(NomFichierSauvegarde);
    try
    RIni := TIniFile.create(NomFichierIni);
    with RIni do begin
    for i := 0 to maxMru do
        WriteString('Fichier','MRU'+IntToStr(i),MRUList[i]);
    WriteInteger(stGraphe,stChiffreSignif,ord(chiffreSignif));
    WriteInteger(stColor,'Ident',couleurFondIdent);
    WriteInteger(stGraphe,'motifIdent',ord(MotifIdent));
    WriteInteger(stGraphe,'hauteurIdent',hauteurIdent);
    WriteBool(stGraphe,'cadreIdent',avecCadreIdent);
    WriteBool(stGraphe,'opaqueIdent',isOpaqueIdent);
    WriteInteger(stColor,identVitesse,couleurMecanique[1]);
    WriteInteger(stColor,identAcceleration,couleurMecanique[2]);
    WriteBool(stColor,'VitesseImposee',CouleurVitesseImposee);
    WriteInteger(stColor,'Axe',couleurGrille);
    WriteInteger(stColor,stLigne,couleurLigne);
    WriteBool(stGraphe,'Reticule',ReticuleComplet);
    WriteBool(stImprimante,'Mono',imprimanteMonochrome);
    WriteBool(stImprimante,'NB',imprimanteMonochrome);
    WriteBool(stFFT,'ReglePeriode',AvecReglagePeriode);
    WriteInteger(stTangente,'Largeur',round(1/longueurTangente));
    WriteInteger(stGraphe,'ZoneVirage',byte(optionsIndicateur));
    WriteInteger(stColor,'FondMarque',FondReticule);
    WriteInteger(stGraphe,stTangente,ord(LigneRappelTangente));
    WriteInteger('Fichier','Filtre',OpenDialog.filterIndex);
    WriteBool(stModele,'UnitParam',ChercheUniteParam);
    WriteBool(stModele,'Manuel',AvecModeleManuel);
    writeBool(stGraphe,'OptionsXY',avecOptionsXY);
    writeBool(stGraphe,stGrille,OgQuadrillage in OptionGrapheDefault);
    writeBool(stGraphe,'ZeroIdem',OgMemeZero in OptionGrapheDefault);
    writeBool(stGraphe,'ZeroGradue',OgZeroGradue in OptionGrapheDefault);
    writeBool('CoeffCorrel','Affiche',WithCoeffCorrel);
    writeBool(stGraphe,'Pvaleur',WithPvaleur);
    writeInteger(stGraphe,'AffIncertParam',ord(affIncertParam));
    writeBool(stGraphe,'BandeConfiance',WithBandeConfiance);
    writeBool(stGraphe,'BandePrediction',WithBandePrediction);
    writeInteger('CoeffCorrel','Nchiffres',PrecisionCorrel);
    writeInteger(stFFT,stFenetre,ord(fenetre));
    writeInteger(stFFT,'PasSonAff',round(PasSonagrammeAff*1000));
    writeInteger(stFFT,'PasSonCalcul',PasSonCalcul);
    writeInteger(stFFT,'FreqSonMax',round(FreqMaxSonagramme));
    writeInteger(stFFT,'NbreHarmAff',NbreHarmoniqueAff);
    WriteBool(stFFT,'HarmAff',HarmoniqueAff);
    WriteInteger(stColor,'Exp',couleurExp);
    WriteInteger(stColor,'NonExp',couleurNonExp);
    WriteInteger(stGraphe,'TracePoint',ord(TraceDefaut));
    WriteBool(stSauvegarde,'Arecuperer',false);
    end;
    except
    end;
end; // EcritCurrentUser

begin
    action := caNone;
    if not VerifSauve then exit;
    action := caFree;
    if Fvaleurs<>nil then Fvaleurs.Close;
    if FgrapheVariab<>nil then FgrapheVariab.Close;
    EcritCurrentUser;
    sauveExtension;
end; // FormClose

procedure TFRegressiMain.OptionsItemClick(Sender: TObject);
var i : integer;
begin
     if OptionsDlg.showModal=mrOK then begin
        if OptionsDlg.modifPreferences then MruItemUpdate;
        if Fvaleurs=nil then exit;
        for i := 0 to pred(NbreGrandeurs) do with grandeurs[i]
            do if formatU=fDefaut then precisionU := precision;
        Fvaleurs.MajGridVariab := true;
        if OptionsDlg.modifUniteSI
           then PostMessage(Fvaleurs.handle,WM_Reg_Calcul,CalculCompile,1)
           else if OptionsDlg.modifDerivee then begin
                recalculE;
                EnvoieMessage(MajValeur);
           end;
        if OptionsDlg.modifPolice then EnvoieMessage(MajPolice);
        if OptionsDlg.modifGraphe and (FgrapheVariab<>nil) then
           FgrapheVariab.Perform(WM_Reg_Maj,MajOptionsGraphe,0);
        if OptionsDlg.modifDerivee and (FgrapheVariab<>nil) then
           FgrapheVariab.Perform(WM_Reg_Maj,MajEquivalence,0);
        if OptionsDlg.modifPreferences then begin
           GrapheConstBtn.visible := (NbrePages>2) and
               ((NbreConst+NbreParam[paramNormal])>1);;
           Graphe3DBtn.visible := ((NbrePages>5) and
               ((NbreConst+NbreParam[paramNormal])>1)) or
               (NbreVariab>3);
           StatistiqueBtn.visible := GrapheBtn.visible and
                              (imStat in menuPermis);
           PrinterSetUpItem.visible := imPrinterSetUp in menuPermis;
           GrapheEulerBtn.Visible := GrapheBtn.visible and (imEuler in menuPermis);
           case dispositionFenetre of
              dMaxi : WindowMaxi.Checked := true;
              dCascade : WindowCascade.Checked := true;
              dMosaicVert : WindowMosaiqueVert.Checked := true;
              dMosaicHoriz : WindowMosaiqueHoriz.Checked := true;
              dNone :  WindowManuelle.Checked := true;
            end;
            EnvoieMessage(MajPreferences);
        end;
     end
end;

procedure TFRegressiMain.OscilloArduinoItemClick(Sender: TObject);
begin
     if not verifSauve then exit;
     try
     if ArduinoOscilloForm=nil then
         Application.CreateForm(TArduinoOscilloForm,ArduinoOscilloForm);
     NomFichierData := '';
     modeAcquisition := AcqOscilloArduino;
     ArduinoOscilloForm.Show;
     ArduinoOscilloForm.SetFocus;
     except
     end;
end;

procedure TFRegressiMain.CollerPageItemClick(Sender: TObject);
begin
    FormDDE.AjoutePressePapier
end;

procedure TFRegressiMain.FileNewItemClick(Sender: TObject);
begin
    AcqItemUpdate
end;

procedure TFRegressiMain.PageTrierItemClick(Sender: TObject);
var index : integer;
begin
     if suppressionDlg=nil then Application.CreateForm(TSuppressionDlg, SuppressionDlg);
     SuppressionDlg.operation := oTriPage;
     index := indexConst[0];
     if index=grandeurInconnue then exit;
     SuppressionDlg.nomDefaut := grandeurs[index].nom;
     if SuppressionDlg.showModal=mrOk then begin
        envoieMessage(MajChangePage);
        if Fvaleurs.Feuillets.ActivePage=Fvaleurs.ParamSheet then
           Fvaleurs.traceGridParam;
     end;
end;

procedure TFRegressiMain.PageCalculerItemClick(Sender: TObject);
begin
     PageCalcDlg := TPageCalcDlg.create(self);
     PageCalcDlg.showModal;
     PageCalcDlg.free;
end;

procedure TFRegressiMain.PageSelectItemClick(Sender: TObject);
begin
     if selectPageDlg=nil then Application.CreateForm(TselectPageDlg, selectPageDlg);
     SelectPageDlg.caption := stChoixPages;
     SelectPageDlg.appelPrint := false;
     SelectPageDlg.showModal;
end;

procedure TFRegressiMain.PageCopyItemClick(Sender: TObject);
begin
     PageCopyDlg := TPageCopyDlg.create(self);
     PageCopyDlg.showModal;
     PageCopyDlg.free;
end;

procedure TFRegressiMain.FilePrintItemClick(Sender: TObject);
begin
     if PrintDlg=nil
        then Application.CreateForm(TPrintDlg, PrintDlg);
     PrintDlg.showModal;
end;

procedure TFRegressiMain.verifWindowsMin;
var i : integer;
begin
     for i := 0 to pred(MDIChildCount) do
         if mdiChildren[i].WindowState=WsMinimized then
            if dispositionFenetre=dMaxi
               then mdiChildren[i].WindowState := wsMaximized
               else mdiChildren[i].WindowState := wsNormal;
end;

procedure TFRegressiMain.VideoItemClick(Sender: TObject);
var ffmpegPath : string;
begin
     if not verifSauve then exit;
     FFMPEGPATH := ExtractFilePath(application.exeName);
     if not FileExists(FFMPEGPATH+'avutil-56.dll') then begin
        showMessage('Effectuer l''installation complète de Regressi');
        exit;
     end;
     include(menuPermis,imVitesse);
     if ffmpegForm=nil then Application.CreateForm(TffmpegForm,ffmpegForm);
     ffmpegForm.Show;
     ModeAcquisition := AcqVideo;
     NomFichierData := '';
end;

procedure TFRegressiMain.FileVideoItemClick(Sender: TObject);
begin
     if not verifSauve then exit;
     include(menuPermis,imVitesse);
     if ffmpegForm=nil then Application.CreateForm(TffmpegForm,ffmpegForm);
     ffmpegForm.Show;
     ModeAcquisition := AcqVideo;
     NomFichierData := '';
end;

procedure TFRegressiMain.PageGrouperItemClick(Sender: TObject);
var NomFichierTemp : string;
begin
   if selectPageDlg=nil then Application.CreateForm(TselectPageDlg, selectPageDlg);
   SelectPageDlg.caption := stChoixPagesGr;
   SelectPageDlg.statusBar.SimpleText := stGroupeSuper;
   SelectPageDlg.statusBar.visible := true;
   if SelectPageDlg.showModal=mrOK then begin
      NomFichierTemp := TPath.Combine(tempDirReg,'Grouper.RW3');
      EcritFichierWin(NomFichierTemp);
      groupePage;
      modifFichier := true;
   end;
   SelectPageDlg.statusBar.visible := false;
end;

procedure TFRegressiMain.FocusAcquisitionBtnClick(Sender: TObject);
begin
      PageAddClick(sender);
end;

procedure TFRegressiMain.FileCalcItemClick(Sender: TObject);
var sauveFiltre : string;
begin
    sauveFiltre := OpenDialog.filter;
    OpenDialog.filter := 'Regressi |*.rw3|';
    OpenDialog.Title := stImportCalc;
    if openDialog.execute then
      if pageCourante=0 then begin
         nomFichierData := openDialog.FileName;
         FregressiMain.FinOuvertureFichier(LitFichierWin);
      end
      else LitCalcul(openDialog.FileName);
    OpenDialog.filter := sauveFiltre;
end;

procedure TFRegressiMain.UtilisateurItemClick(Sender: TObject);
begin
     UserName := InputBox(stPrint,stEnTete,UserName)
end;

procedure TFRegressiMain.RestaurerItemClick(Sender: TObject);
var S : tsauvegarde;
    SauveNom : string;
begin
   if not RestaurerItem.visible or (PileSauvegarde.count=0)  then begin
      AnnulerItemClick(sender);
      exit;
   end;
   S := PileSauvegarde.pop;
   S.restaure;
   case S.undo of
      UsupprPage : Perform(WM_Reg_Maj,MajAjoutPage,0);
      UsupprPoint : Perform(WM_Reg_Maj,MajAjoutValeur,0);
      UsupprConst : Perform(WM_Reg_Maj,MajGrandeur,0);
      UsupprVariab : Perform(WM_Reg_Maj,MajGrandeur,0);
      Ugrouper : begin
          closeAll;
          SauveNom := NomFichierData;
          NomFichierData := TPath.Combine(tempDirReg,'Grouper.RW3');
          FinOuvertureFichier(litFichierWin);
          NomFichierData := SauveNom;
          Perform(WM_Reg_Maj,MajAjoutPage,0);
      end;
   end;
   S.free;
end;

procedure TFRegressiMain.PrinterSetUpItemClick(Sender: TObject);
begin
   if PrintDlg=nil then
      Application.CreateForm(TPrintDlg, PrintDlg);
   PrintDlg.PrinterSetUpDialog.execute
end;

procedure TFRegressiMain.ConstHeaderClick(Sender: TObject);
begin
    selParamDlg := TselParamDlg.create(self);
    selParamDlg.showModal;
    selParamDlg.free;
    AffValeurParametre;
end;

procedure TFRegressiMain.RecupItemClick(Sender: TObject);
begin
     grandeursOpen;
     grapheOpen;
     closeAll;
     NomFichierData := NomFichierSauvegarde;
     FinOuvertureFichier(litFichierWin);
     NomFichierData := '';
     modifFichier := true;
end;

procedure TFRegressiMain.WebItemClick(Sender: TObject);
const FileName = 'http://regressi.fr/WordPress';
begin
    AppelFichier(FileName)
end;

procedure TFRegressiMain.RandomItemClick(Sender: TObject);
begin
  inherited;
  Fvaleurs.RandomBtnClick(sender);
end;

procedure TFRegressiMain.RazItemClick(Sender: TObject);
begin
    Fvaleurs.MajBtnClick(nil);
    FgrapheVariab.RaZModeleClick(nil);
end;

procedure TFRegressiMain.EchantillonnerItemClick(Sender: TObject);
begin
     PageEchantillonDlg := TPageEchantillonDlg.create(self);
     PageEchantillonDlg.showModal;
     PageEchantillonDlg.free;
end;

procedure TFRegressiMain.EnregistreBtnClick(Sender: TObject);
begin
   FileSaveItemClick(Sender)
end;

procedure TFRegressiMain.ListeRegActionClick(Sender: TObject);
const FileName = 'http://fr.groups.yahoo.com/group/regressi-demo';
begin
    appelFichier(FileName)
end;

procedure TFRegressiMain.PageNewSimulItemClick(Sender: TObject);
var i : integer;
begin
     if ajoutePage then begin
           for i := 1 to NbreConstExp do
                 Pages[NbrePages].valeurConst[i] := pages[pred(Nbrepages)].valeurConst[i];
           with Pages[NbrePages] do begin
                copyVecteur(valeurVar[0],pages[1].valeurVar[0]);
                nmes := pages[1].nmes;
                miniSimulation := pages[1].miniSimulation;
                maxiSimulation := pages[1].maxiSimulation;
                numero := NbrePages;
                recalculP;
           end;
           if NbreConstExp>0 then
                FValeurs.Feuillets.ActivePage := Fvaleurs.paramSheet;
           envoieMessage(MajAjoutPage);
           ModifFichier := true;
           if NbreConstExp>0 then FValeurs.show;
     end;
end;

procedure TFRegressiMain.AnnulerItemClick(Sender: TObject);
begin
   if Screen.ActiveControl is TCustomEdit
      then EditCtl := Screen.ActiveControl as TCustomEdit
      else if (Screen.ActiveControl is TCustomGrid)
           then ActiveGrid := Screen.ActiveControl as TstringGrid;
   if Assigned(EditCtl) then EditCtl.Undo
end;

procedure TFRegressiMain.RecevoirItemClick(Sender: TObject);
begin
    LitFichier(FichierGroupe,true,false)
end;

procedure TFRegressiMain.EnvoyerItemClick(Sender: TObject);
begin
    ecritFichierWin(FichierGroupe)
end;

procedure TFRegressiMain.EphmridesIMCCE1Click(Sender: TObject);
begin
     EphemerForm := TEphemerForm.create(self);
     EphemerForm.ShowModal;
     EphemerForm.free;
end;

procedure TFRegressiMain.PageAddBtnClick(Sender: TObject);
begin
   PageAddClick(Sender);
end;

procedure TFRegressiMain.WindowClick(Sender: TObject);
begin
  if sender<>nil then
     dispositionFenetre := TdispositionFenetre((sender as TMenuItem).tag);
  VerifWindowsMin;
  case dispositionFenetre of
       dMaxi : if Fvaleurs<>nil then
          Fvaleurs.WindowState := wsMaximized;
       dCascade : Cascade;
       dMosaicVert : begin
          TileMode := tbVertical;
          Tile;
       end;
       dMosaicHoriz : begin
          TileMode := tbHorizontal;
          Tile;
       end;
       dNone :  ;
  end; // case dispoFenetre
end;

procedure TFRegressiMain.FormActivate(Sender: TObject);
begin
  inherited;
{$IFDEF Debug}
   ecritDebug('formActivate regMain');
{$ENDIF}
  MruItemUpdate; // Update MRU menu items
end;

Procedure TFRegressiMain.SauveEtatCourant;
var p : TcodePage;
begin
     if (pageCourante=0) or LectureFichier or not SauvegardePermise then exit;
     try // pb si répertoire interdit en écriture
     EcritFichierWin(NomFichierSauvegarde);
     HeureSauvegarde := now;
     NbreGrandeursSauvees := NbreGrandeurs;
     for p := 1 to NbrePages do
         pages[p].NbrePointsSauves := pages[p].nmes
     except
     end;
end;

Procedure TFRegressiMain.VerifSauvegarde;
begin
    if (now-HeureSauvegarde)>IntervalleSauvegarde then sauveEtatCourant;
end;

end.

