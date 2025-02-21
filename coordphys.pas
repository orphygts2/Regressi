unit coordphys;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ImgList, ComCtrls, CheckLst, spin, maths,
  vcl.HtmlHelpViewer,
  Constreg, regutil, uniteKer, compile, graphker, selpage, aidekey,
  system.Contnrs, System.ImageList, Vcl.VirtualImageList,
  Vcl.BaseImageCollection, Vcl.ImageCollection, Vcl.Imaging.pngimage;

type
TFcoordonneesPhys = class(TForm)
    BoutonsPanel: TPanel;
    GroupBoxOptions: TGroupBox;
    OrthonormeCB: TCheckBox;
    MemeZeroCB: TCheckBox;
    MemeXCB: TCheckBox;
    AnalyseurCB: TCheckBox;
    MemeEchelleCB: TCheckBox;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    PolaireCB: TCheckBox;
    VariableLB: TTabControl;
    Panel3: TPanel;
    AbscisseGB: TGroupBox;
    LabelZeroX: TLabel;
    LabelGradX: TLabel;
    ListeX: TComboBox;
    ZeroXCB: TCheckBox;
    GraduationX: TComboBox;
    OrdonneeGB: TGroupBox;
    labelZeroY: TLabel;
    LabelAxeY: TLabel;
    LabelGradY: TLabel;
    ListeY: TComboBox;
    ZeroYCB: TCheckBox;
    MondeCB: TComboBox;
    GraduationY: TComboBox;
    OptionsGB: TGroupBox;
    LigneCB: TCheckBox;
    PointCB: TCheckBox;
    PageBioMeca: TPageControl;
    MecaniqueTS: TTabSheet;
    VitesseCB: TCheckBox;
    AccelerationCB: TCheckBox;
    OptionsVitesseBtn: TBitBtn;
    OptiqueTS: TTabSheet;
    AddBtn: TBitBtn;
    DeleteBtn: TBitBtn;
    ZoomAutoBtn: TSpeedButton;
    EchelleManuelleLabel: TLabel;
    GraduationZeroCB: TCheckBox;
    OrdreLissageSE: TSpinEdit;
    FilDeFerCB: TCheckBox;
    GrilleCB: TCheckBox;
    DetailBtn: TSpeedButton;
    CouleurCombo: TColorBox;
    LigneRG: TComboBox;
    LigneBevel: TBevel;
    PointBevel: TBevel;
    PointCombo: TComboBoxEx;
    LigneCombo: TComboBoxEx;
    ContrastePanel: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    NiveauGrisTB: TTrackBar;
    ChimieTS: TTabSheet;
    IndicateurCombo: TComboBox;
    IndicateurBtn: TSpeedButton;
    MinidBEdit: TSpinEdit;
    LabelDimPoint: TLabel;
    Label5: TLabel;
    LabelVitesse: TLabel;
    IntensiteCB: TCheckBox;
    TexteTS: TTabSheet;
    NbreLabel: TLabel;
    NbreSE: TSpinEdit;
    LabelTaille: TLabel;
    SpinEditHauteur: TSpinEdit;
    IndicateurCB: TCheckBox;
    OptionsIndicateurLB: TCheckListBox;
    AstroTS: TTabSheet;
    axeXinverseCB: TCheckBox;
    axeYinverseCB: TCheckBox;
    pagesGB: TGroupBox;
    PagesBtn: TSpeedButton;
    LabelWidth: TLabel;
    SuperPagesCB: TCheckBox;
    ConfigPageCB: TCheckBox;
    ReperePageRG: TRadioGroup;
    PagePrecBtn: TSpeedButton;
    CommentaireEdit: TEdit;
    PageSuivBtn: TSpeedButton;
    FinModeleBtn: TBitBtn;
    Timer: TTimer;
    CouleursSpectreCB: TCheckBox;
    Label12: TLabel;
    OptionsBtn: TSpeedButton;
    CouleurPointTS: TTabSheet;
    TeinteLabel: TLabel;
    CouleurPointEdit: TEdit;
    dimPointSE: TSpinEdit;
    widthEcranSE: TSpinEdit;
    PasPointSE: TSpinEdit;
    ImageCollectionLigne: TImageCollection;
    ImageCollectionPoint: TImageCollection;
    VirtualImageListLigne: TVirtualImageList;
    VirtualImageListPoint: TVirtualImageList;
    UniteImposeeBtn: TBitBtn;
    CouleurSigneCB: TCheckBox;
    HueImage: TImage;
    SigneLabel: TLabel;
    procedure MemeXCBClick(Sender: TObject);
    procedure MemeEchelleCBClick(Sender: TObject);
    procedure OrthonormeCBClick(Sender: TObject);
    procedure AnalyseurCBClick(Sender: TObject);
    procedure PolaireCBClick(Sender: TObject);
    procedure SuperPagesCBClick(Sender: TObject);
    procedure PagesBtnClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
    procedure LigneCBClick(Sender: TObject);
    procedure PointCBClick(Sender: TObject);
    procedure IntensiteCBClick(Sender: TObject);
    procedure VitesseCBClick(Sender: TObject);
    procedure AccelerationCBClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListeXChange(Sender: TObject);
    procedure ListeYChange(Sender: TObject);
    procedure GraduationXChange(Sender: TObject);
    procedure GraduationYChange(Sender: TObject);
    procedure MondeCBChange(Sender: TObject);
    procedure VariableLBClick(Sender: TObject);
    procedure CouleurComboChange(Sender: TObject);
    procedure PointComboChange(Sender: TObject);
    procedure ZeroXCBClick(Sender: TObject);
    procedure ZeroYCBClick(Sender: TObject);
    procedure LigneRGClick(Sender: TObject);
    procedure PageBioMecaChange(Sender: TObject);
    procedure OptionsVitesseBtnClick(Sender: TObject);
    procedure VariableLBDrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure DetailBtnClick(Sender: TObject);
    procedure ZoomAutoBtnClick(Sender: TObject);
    procedure LigneComboChange(Sender: TObject);
    procedure indicateurCBClick(Sender: TObject);
    procedure IndicateurBtnClick(Sender: TObject);
    procedure MinidBEditChange(Sender: TObject);
    procedure HelpCornishBtnClick(Sender: TObject);
    procedure OptionsIndicateurLBClick(Sender: TObject);
    procedure IndicateurComboChange(Sender: TObject);
    procedure axeXinverseCBClick(Sender: TObject);
    procedure axeYinverseCBClick(Sender: TObject);
    procedure PagePrecBtnClick(Sender: TObject);
    procedure PageSuivBtnClick(Sender: TObject);
    procedure FinModeleBtnClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure LigneRGDrawItem(Control: TWinControl; Index: Integer; Rect: TRect;
      State: TOwnerDrawState);
    procedure LigneRGChange(Sender: TObject);
    procedure CouleursSpectreCBClick(Sender: TObject);
    procedure OptionsBtnClick(Sender: TObject);
    procedure CouleurPointEditExit(Sender: TObject);
    procedure UniteImposeeBtnClick(Sender: TObject);
    procedure CouleurSigneCBClick(Sender: TObject);
  private
    ListeVar : TstrListe;
    CourbeCourante : TindiceOrdonnee;
    activation : boolean;
    VitesseCalculee,AccelerationCalculee : boolean;
    pageActive : integer;
    PageOption : TTabSheet;
    Procedure Maj;
    Procedure MajIndicateur;
    Procedure majOptions;
    Procedure setNom;
    Procedure afficheDetail;
    Procedure MajPages;
    procedure AffecteVecteurs(AffecteAcceleration : boolean);
  public
     Transfert : TtransfertGraphe;
     ListeConst : boolean;
     modeleEnCours,modelePermis : boolean;
     Agraphe : TgrapheReg;
  end;

var
  FcoordonneesPhys: TFcoordonneesPhys;

implementation

uses Valeurs, optionsVitesse, indicateurU, options, optcolordlg, unitGraphe, regmain;

{$R *.DFM}

const
   hMotif : array[boolean] of string = ('Motif du point','Ellipse d''incertitude');

procedure TFcoordonneesPhys.MemeXCBClick(Sender: TObject);
var courbe : integer;
begin
     if MemeXCB.checked then
        for courbe := 2 to maxOrdonnee do with transfert do
            nomX[courbe] := nomX[1];
     for courbe := 2 to variableLB.tabs.count do with transfert do
         VariableLB.tabs[courbe-1] := nomY[courbe]+'=f('+nomX[1]+')';
     FilDeFerCB.Visible := not MemeXCB.checked;
end;

procedure TFcoordonneesPhys.MemeEchelleCBClick(Sender: TObject);
begin
     if MemeEchelleCB.checked
        then include(Transfert.OptionGr,OgMemeEchelle)
        else exclude(Transfert.OptionGr,OgMemeEchelle);
end;

procedure TFcoordonneesPhys.OrthonormeCBClick(Sender: TObject);
begin
    if OrthonormeCB.checked
         then include(Transfert.OptionGr,OgOrthonorme)
         else exclude(Transfert.OptionGr,OgOrthonorme);
end;

procedure TFcoordonneesPhys.AnalyseurCBClick(Sender: TObject);
begin
     Maj
end;

procedure TFcoordonneesPhys.axeXinverseCBClick(Sender: TObject);
begin
    Transfert.axeInverse[mondeX] := axeXinverseCB.checked;
    Maj;
end;

procedure TFcoordonneesPhys.axeYinverseCBClick(Sender: TObject);
var m : TindiceMonde;
begin
    m := transfert.iMonde[courbeCourante];
    Transfert.axeInverse[m] := axeYinverseCB.checked;
    Maj;
end;

procedure TFcoordonneesPhys.PolaireCBClick(Sender: TObject);
begin
with Transfert do if PolaireCB.checked
        then begin
             include(OptionGr,OgPolaire);
             OrthonormeCB.checked := true;
             OrthonormeCB.enabled := false;
             MemeZeroCB.visible := false;
             labelAxeY.visible := false;
             labelGradX.visible := false;
             labelGradY.visible := false;
             labelZeroX.visible := false;
             labelZeroY.visible := false;
             GraduationX.visible := false;
             AnalyseurCB.visible := false;
             AnalyseurCB.checked := false;
        end
        else begin
             exclude(OptionGr,OgPolaire);
             OrthonormeCB.enabled := true;
             MemeZeroCB.visible := true;
             labelAxeY.visible := true;
             labelGradX.visible := true;
             labelGradY.visible := true;
             labelZeroX.visible := true;
             labelZeroY.visible := true;
             GraduationX.visible := true;
             AnalyseurCB.visible := true;
        end;
     if sender<>nil then Maj;
end;

procedure TFcoordonneesPhys.SuperPagesCBClick(Sender: TObject);
begin
     afficheDetail;
     majPages;
end;

procedure TFcoordonneesPhys.TimerTimer(Sender: TObject);
begin
  PageBioMeca.ActivePage := PageOption;
  timer.Enabled := false;
  // problème non compris de rafraichissement de TPageControl
  // on force le rafraichissement
end;

procedure TFcoordonneesPhys.UniteImposeeBtnClick(Sender: TObject);
var code : integer;
begin
    if unitGrapheDlg=nil then application.createForm(TunitGrapheDlg,unitGrapheDlg);
    with unitGrapheDlg do begin
         code := indexNom(listeX.text);
         varX := grandeurs[code];
         code := indexNom(listeY.text);
         varY := grandeurs[code];
    end;
    unitGrapheDlg.ShowModal;
end;

procedure TFcoordonneesPhys.PagesBtnClick(Sender: TObject);
begin
     if selectPageDlg=nil then Application.CreateForm(TselectPageDlg, selectPageDlg);
     SelectPageDlg.caption := 'Choix des pages affichées sur le graphe';
     SelectPageDlg.appelPrint := false;
     SelectPageDlg.showModal
end;

procedure TFcoordonneesPhys.PageSuivBtnClick(Sender: TObject);
begin
  if pageActive<NbrePages
     then inc(PageActive)
     else pageActive := 1;
  MajPages;
end;

procedure TFcoordonneesPhys.OKBtnClick(Sender: TObject);
var i,mondeLoc : integer;
begin with transfert do begin
     if  MemeZeroCB.visible then if MemeZeroCB.checked
        then include(OptionGr,OgMemeZero)
        else exclude(OptionGr,OgMemeZero);
     if GrilleCB.checked
        then include(OptionGr,OgQuadrillage)
        else exclude(OptionGr,OgQuadrillage);
     OrdreLissage := OrdreLissageSE.Value;
     penWidthCourbe := widthEcranSE.value;
     TexteGrapheSize := spinEditHauteur.value;
     NbreTexteMax := NbreSE.value;
     DimPointVGA := DimPointSE.value;
     if not OrthonormeCB.visible then exclude(optionGr,OgOrthonorme);
     if pasPointSE.visible
        then pasPoint := PasPointSE.value
        else pasPoint := 1;
     GammaNiveauGris := exp(NiveauGrisTB.position/NiveauGrisTB.max);
     avecOptionsXY := DetailBtn.visible and DetailBtn.down;
     reperePage := TreperePage(reperePageRG.itemIndex);
     for i := succ(VariableLB.tabs.count) to maxOrdonnee do begin
         nomX[i] := '';
         nomY[i] := '';
     end;
     superposePage := SuperPagesCB.checked;
     FilDeFer := FilDeFerCB.checked and not(memeXCB.checked);
     if GraduationZeroCB.checked
        then include(optionGr,OgZeroGradue)
        else exclude(optionGr,OgZeroGradue);
     if AnalyseurCB.checked
         then include(OptionGr,OgAnalyseurLogique)
         else exclude(OptionGr,OgAnalyseurLogique);
     if OgAnalyseurLogique in OptionGr
        then begin
           if not SuperPagesCB.checked then
              for i := 1 to maxOrdonnee do
                  iMonde[i] := mondeY+i-1;
           exclude(optionGr,OgMemeZero);
        end
        else begin
           mondeLoc := mondeSans;
           if (VariableLB.tabs.count=1) and
              (iMonde[1]=mondeDroit) then iMonde[1] := mondeY;
           for i := 1 to maxOrdonnee do
               if iMonde[i]=mondeSans then begin
                  iMonde[i] := mondeLoc;
                  inc(MondeLoc);
               end;
        end;
      if (indicateurCB.checked) and (indicateurCombo.itemIndex>=0) then begin
         indicateur := Tindicateur(indicateurCombo.items.objects[indicateurCombo.itemIndex]);
         pages[pageCourante].indicateurP := indicateur;
      end;
      if OptionsIndicateur=[] then OptionsIndicateur := [oiEchelleTeinte] ;
      GraphePageIndependante := configPageCB.checked;
end end; // OKBtn

procedure TFcoordonneesPhys.HelpBtnClick(Sender: TObject);
begin
     Aide(HELP_Coordonnees)
end;

procedure TFcoordonneesPhys.Maj;
var m : TindiceMonde;
    NonAnalyseur : boolean;
    codeX,codeY : integer;
begin
     courbeCourante := succ(variableLB.tabIndex);
     if activation then exit;
     MajOptions;
with transfert do begin
     NonAnalyseur := not(AnalyseurCB.checked);
     if AnalyseurCB.checked then begin
          memeXCB.checked := true;
          polaireCB.checked := false;
     end;
     labelAxeY.visible := NonAnalyseur;
     memeZeroCB.visible := NonAnalyseur;
     memeEchelleCB.visible := not NonAnalyseur;
     memeXCB.visible := NonAnalyseur;
     polaireCB.visible := NonAnalyseur;
     GraduationX.itemIndex := ord(grad[mondeX]);
     axeXinverseCB.checked := axeInverse[mondeX];
     zeroXCB.checked := zero[mondeX];
     zeroXCB.visible := not(PolaireCB.checked) and (grad[mondeX]<>gLog);
     OrthonormeCB.enabled := true;
     if (grad[mondeX]<>gLin) then begin
          OrthonormeCB.enabled := false;
          OrthonormeCB.checked := false;
     end;
     m := iMonde[courbeCourante];
     if m>mondeSans then m := mondeSans;
     axeYinverseCB.checked := axeInverse[m];
     mondeCB.itemIndex := m-mondeY;
     minidbEdit.Visible := (grad[m]=gdB) or (PolaireCB.checked);
     if PolaireCB.checked
        then begin
           minidbEdit.value := round(zeroPolaire);
           minidBEdit.Hint := 'Zéro|Valeur correspondante à un rayon nul';
        end
        else begin
           minidbEdit.value := round(minidb[m]);
           minidBEdit.Hint := 'Minimum|Valeurs inférieures à ce mini non prises en compte';
        end;
     mondeCB.visible := NonAnalyseur and
                        (nomY[courbeCourante]<>'') and
                        not (PolaireCB.checked);
     zeroYCB.checked := zero[m];
     zeroYCB.visible := (nomY[courbeCourante]<>'') and (grad[m]<>gLog);
     graduationY.itemIndex := ord(grad[m]);
     graduationY.visible := not(PolaireCB.checked) and (nomY[courbeCourante]<>'');
     listeX.text := nomX[courbeCourante];
     if (nomY[courbeCourante]<>'') and (grad[m]<>gLin) then begin
           OrthonormeCB.enabled := false;
           OrthonormeCB.checked := false;
     end;
     indicateurCB.checked := IndicateurCB.visible and
                            (trIndicateur in trace[CourbeCourante]) and
                             chimieTS.enabled;
     CouleursSpectreCB.checked := CouleursSpectreCB.visible and
                            (trCouleursSpectre in trace[CourbeCourante]) and
                             chimieTS.enabled;
     if IndicateurCB.checked or CouleursSpectreCB.checked then begin
          pageBioMeca.activePage := chimieTS;
          DetailBtn.down := true;
     end;
     indicateurCombo.visible := IndicateurCB.checked;
     optionsIndicateurLB.visible := IndicateurCB.checked;
     FilDeFerCB.visible := not memeXCB.checked;
     AddBtn.visible := variableLB.tabs.count<MaxOrdonnee;
     DeleteBtn.visible := variableLB.tabs.count>1;
     codeY := ListeVar.MyIndexOf(nomY[courbeCourante]);
     listeY.itemIndex := codeY;
     codeX := listeVar.MyIndexOf(nomX[courbeCourante]);
     listeX.itemIndex := codeX;
     LigneRG.Visible := LigneCB.checked;
     LigneRG.itemIndex := ord(Ligne[CourbeCourante]);
     //if ligne[CourbeCourante]=liSpline then
     ordreLissageSE.MaxValue := ordreMaxSpline;
     if (LigneRG.itemIndex=1) and not ModelePermis then LigneRG.itemIndex := 0;
     if (LigneRG.itemIndex=2) and (pages[pageCourante].nmes>maxVecteurSpline) then LigneRG.itemIndex := 0;
     finModeleBtn.visible := modeleEnCours;
     if modeleEnCours then begin
          ligneCB.checked := true;
          ligneRG.ItemIndex := 1;
          ligneCB.hint := 'Obligatoire (modélisation en cours)';
          PointCB.checked := true;
     end
     else ligneCB.hint := '';
     PointCB.enabled := not modeleEnCours;
     ligneCB.Enabled := not modeleEnCours;
     ligneRG.Enabled := not modeleEnCours;
     OrdreLissageSE.visible := LigneRG.Visible and (LigneRG.itemIndex=2);
     couleurPointEdit.Text := couleurPoint[courbeCourante];
     couleurSigneCB.checked := (codeCouleur[courbeCourante]=tSigne);
     HueImage.Visible := (codeCouleur[courbeCourante]=tHue);
     SigneLabel.Visible := (codeCouleur[courbeCourante]=tSigne);
     TeinteLabel.caption := codeCouleurStr[codeCouleur[courbeCourante]];
     SetNom;
     if PolaireCB.checked
        then begin
             AbscisseGB.Caption := stAngle;
             OrdonneeGB.Caption := stRayon;
        end
        else begin
             AbscisseGB.Caption := stAbscisse;
             OrdonneeGB.Caption := stOrdonnee;
        end;
     LigneCombo.itemIndex := ord(style[courbeCourante]);
     CouleurCombo.selected := Couleur[CourbeCourante];
     PointCombo.hint := hMotif[avecEllipse];
     if avecEllipse and grandeurs[codeY].incertDefinie
        then motif[courbeCourante] := mIncert
        else if motif[courbeCourante]=mIncert
             then motif[courbeCourante] := Tmotif(courbeCourante);
     PointCombo.itemIndex := ord(motif[courbeCourante]);
     if pageBioMeca.visible then pageBioMeca.repaint;
end end; // MaJ

procedure TFcoordonneesPhys.FinModeleBtnClick(Sender: TObject);
begin
     finModeleBtn.visible := false;
     modeleEnCours := false;
     modelePermis := false;
     ligneCB.Enabled := true;
     ligneRG.Enabled := true;
     PointCB.enabled := true;
end;

procedure TFcoordonneesPhys.FormActivate(Sender: TObject);
var i : integer;
    cx,cy : integer;
    memeX : boolean;
    indic : Tindicateur;
    oi : ToptionIndicateur;
begin
inherited;
with transfert do begin
    if indicateurDlg.indicateurs.count>0 then begin
        indicateurCombo.clear;
        for i := 0 to pred(indicateurDlg.indicateurs.count) do begin
          indic := Tindicateur(indicateurDlg.indicateurs[i]);
          indicateurCombo.AddItem(indic.nom+' ('+floatToStr(indic.pka)+')',
                             indicateurDlg.indicateurs[i]);
        end;
        indicateurCombo.itemIndex := indicateurCombo.items.IndexOfObject(indicateur);
        if indicateurCombo.itemIndex<0 then indicateurCombo.itemIndex := 0;
        for oi := low(TOptionIndicateur) to High(TOptionIndicateur) do
            optionsIndicateurLB.checked[ord(oi)] := oi in OptionsIndicateur;
    end
    else chimieTS.enabled := false;
    mecaniqueTS.Enabled := (imVitesse in menuPermis);
    optiqueTS.Enabled := (imOptique in menuPermis);
    activation := true;
    pageActive := pageCourante;
    reperePageRG.itemIndex := ord(reperePage);
    widthEcranSE.value := penWidthCourbe;
    DimPointSE.Value := DimPointVGA;
    PasPointSE.Value := PasPoint;
    spinEditHauteur.Value := texteGrapheSize;
    NbreSE.Value := NbreTexteMax;
    ListeVar.Clear;
    if ListeConst
       then begin
            for i := 0 to pred(NbreGrandeurs) do with grandeurs[i] do
                if genreG=constante then ListeVar.add(nom);
            for i := 1 to NbreParam[ParamNormal] do
                ListeVar.add(Parametres[paramNormal,i].nom);
            if NbreConstGlb>0 then ListeVar.add(SeparateurConst);
            for i := 0 to pred(NbreGrandeurs) do with grandeurs[i] do
                if genreG=constanteGlb then ListeVar.add(RepereConst+nom);
            ListeVar.add(SeparateurConst);
            for i := 1 to pred(NbreGrandeurs) do with grandeurs[i] do
                if genreG=variable then ListeVar.add(nom);
       end
       else begin
            for i := 0 to pred(NbreGrandeurs) do with grandeurs[i] do
                if genreG=variable then ListeVar.add(nom);
            if (NbreConstGlb+NbreConst)>0 then ListeVar.add(SeparateurConst);                
            for i := 0 to pred(NbreGrandeurs) do with grandeurs[i] do
                if genreG=constante then ListeVar.add(RepereConst+nom);
            for i := 0 to pred(NbreGrandeurs) do with grandeurs[i] do
                if genreG=constanteGlb then ListeVar.add(RepereConst+nom);

       end;
    ListeX.items := listeVar;
    ListeY.items := listeVar;
    memeX := true;
    variableLB.tabs.clear;
    for i := 1 to maxOrdonnee do begin
        cY := ListeVar.MyIndexOf(nomY[i]);
        cX := listeVar.MyIndexOf(nomX[i]);
        if cX<0 then if i=1
           then begin
              nomX[1] := getNomCoord(listeVar[0]);
              cX := 0;
           end
           else nomX[i] := '';
        if cY<0 then if i=1
           then begin
               nomY[1] := getNomCoord(listeVar[1]);
               cY := 1;
           end
           else nomY[i] := '';
        memeX := memeX and ((nomX[i]=nomX[1]) or (nomX[i]=''));
        if (cY>=0) and (cX<0) and memeX then begin
           nomX[i] := nomX[1];
           cX := 0;
        end;
        if (cX>=0) and (cY>=0) then variableLB.tabs.add('');
    end;
    GrilleCB.checked := OgQuadrillage in optionGr;
    OrdreLissageSE.Value := OrdreLissage;
    NiveauGrisTB.position := round(ln(GammaNiveauGris)*NiveauGrisTB.max);
    MemeZeroCB.checked := OgMemeZero in OptionGr;
    MemeEchelleCB.checked := OgMemeEchelle in OptionGr;
    AnalyseurCB.checked := OgAnalyseurLogique in OptionGr;
    PolaireCB.checked := OgPolaire in OptionGr;
    OrthonormeCB.checked := OgOrthonorme in OptionGr;
    PolaireCBclick(nil);
    memeXCB.checked := memeX;
    memeXCBClick(nil);
    SuperPagesCB.visible := (NbrePages>1) and not listeConst;
    ConfigPageCB.visible := SuperPagesCB.Visible;
    SuperPagesCB.checked := superPagesCB.visible and superposePage;
    configPageCB.checked := configPageCB.Visible and GraphePageIndependante;
    FilDeFerCB.checked := FilDeFer;
    courbeCourante := 1;
    variableLB.tabIndex := 0;
    activation := false;
    DetailBtn.visible := MecaniqueTS.enabled or OptiqueTS.enabled;
    if DetailBtn.visible
       then DetailBtn.down := avecOptionsXY
       else DetailBtn.down := false;
    EchelleManuelleLabel.visible := UseDefaut;
    ZoomAutoBtn.visible := UseDefaut;
    GraduationZeroCB.checked := OgZeroGradue in optionGr;
    pagesGB.visible := superPagesCB.checked;
    Maj;
    SetNom;
    PageOption := PageBioMeca.ActivePage;
    if pageOption=TexteTS
       then PageBioMeca.ActivePage := ChimieTS
       else PageBioMeca.ActivePage := TexteTS;
    timer.Enabled := true;
end end; // FormActivate

procedure TFcoordonneesPhys.MajOptions;
var indexX,indexY : integer;
    indexXX,indexYY : integer;
begin with transfert do begin
      indexX := indexNom(nomX[CourbeCourante]);
      if indexX=grandeurInconnue then begin
         indexX := 1;
         nomX[CourbeCourante] := getNomCoord(listeVar[indexX]);
      end;
      indexY := indexNom(nomY[CourbeCourante]);
      if indexY=grandeurInconnue then begin
         indexY := 2;
         nomY[CourbeCourante] := getNomCoord(listeVar[indexY]);
      end;
      OptionsGB.Caption := 'Options de représentation de '+
         nomY[CourbeCourante]+'('+
         nomX[CourbeCourante]+')';
      LigneRG.itemIndex := ord(transfert.ligne[courbeCourante]);
      LigneCB.checked := trLigne in trace[CourbeCourante];
      LigneRG.Visible := LigneCB.checked;
      PointCB.checked := trPoint in trace[CourbeCourante];
      pageBioMeca.activePage := mecaniqueTS; { par défaut }
      IntensiteCB.checked := trIntensite in trace[CourbeCourante];
      if IntensiteCB.checked then begin
         pageBioMeca.activePage := optiqueTS;
         DetailBtn.down := true;
      end;
      if grandeurs[indexY].fonct.genreC=g_texte  then begin
          pageBioMeca.activePage := texteTS;  // ??
          DetailBtn.down := true;
      end;
      if axeInverse[mondeX] or axeInverse[mondeY] then begin
          pageBioMeca.activePage := astroTS;
          DetailBtn.down := true;
      end;
      VitesseCB.enabled := (indexX<>0) and (indexY<>0) and
                           not(listeConst) and
                           (grandeurs[indexX].genreG=variable) and
                           (grandeurs[indexY].genreG=variable);
      if VitesseCB.enabled
         then VitesseCB.hint := ''
         else if listeConst
              then VitesseCB.hint := 'Non prévu dans le graphe des paramètres'
              else VitesseCB.hint := labelVitesse.Hint;
      indexXX := IndexVitesse(grandeurs[indexX].nom);
      indexYY := IndexVitesse(grandeurs[indexY].nom);
      VitesseCalculee := (indexXX<>grandeurInconnue) and
                         (indexYY<>grandeurInconnue);
      VitesseCB.checked := (trVitesse in trace[CourbeCourante]) and
                            VitesseCB.enabled and
                            VitesseCalculee;
      if not VitesseCB.checked then
         exclude(trace[courbeCourante],trVitesse);
      AccelerationCB.enabled := VitesseCB.enabled;
      if AccelerationCB.enabled then begin
           AccelerationCB.hint := '';
           indexXX := IndexAcceleration(grandeurs[indexX].nom);
           indexYY := IndexAcceleration(grandeurs[indexY].nom);
           AccelerationCalculee := (indexXX<>grandeurInconnue) and
                                   (indexYY<>grandeurInconnue);
      end
      else AccelerationCB.hint := labelVitesse.Hint;
      AccelerationCB.checked := (trAcceleration in trace[CourbeCourante]) and
                                 AccelerationCB.enabled and
                                 AccelerationCalculee;
      if not AccelerationCB.checked then
           exclude(trace[courbeCourante],trAcceleration);
      if VitesseCB.checked or AccelerationCB.checked then begin
            pageBioMeca.activePage := mecaniqueTS;
            detailBtn.down := true;
            include(menuPermis,imVitesse);
      end;
      if trace[CourbeCourante]=[] then begin
         if (ModeAcquisition=AcqSimulation)
         then trace[CourbeCourante] := [trLigne]
         else case traceDefaut of
            tdPoint : if pages[pageCourante].nmes>256
                then trace[CourbeCourante] := [trLigne] // sinon illisible
                else trace[CourbeCourante] := [trPoint]; // points entrés à la main
            tdLigne : trace[CourbeCourante] := [trLigne];
            tdLissage : begin
                trace[CourbeCourante] := [trPoint,trLigne];
                ligne[CourbeCourante] := liSpline;
                ligneRG.ItemIndex := 2;
            end;
         end;
         PointCB.checked := trPoint in trace[CourbeCourante];
         LigneCB.checked := trLigne in trace[CourbeCourante];
      end; { case }
      OrthonormeCB.Visible := grandeurs[indexX].nomUnite=grandeurs[indexY].nomUnite;
      afficheDetail;
end end; // MajOptions

procedure TFcoordonneesPhys.AddBtnClick(Sender: TObject);
var code : integer;
    i,k,c : integer;
    Yok : boolean;
    nomC : string;
    grandeurRef : Tgrandeur;
    mondeYInterdit,mondeDroitInterdit : boolean;
begin with transfert do begin
     CourbeCourante := succ(VariableLB.tabs.count);
     PointCombo.itemIndex := ord(motifInit[courbeCourante]);
     CouleurCombo.selected := CouleurInit[CourbeCourante];
     code := listeVar.MyIndexOf(nomX[courbeCourante]);
     if (code<0) or memeXCB.checked then
        nomX[courbeCourante] := nomX[1];
     k := 1;
     for i := 0 to pred(ListeVar.count) do begin
         nomC := ListeVar[i];
         code := indexNom(nomC);
         if listeConst
             then Yok := (code<>grandeurInconnue) and
                         (grandeurs[code].genreG in [constante,paramNormal,variable])
             else Yok := (code<>grandeurInconnue) and
                     (grandeurs[code].genreG=variable);
         for c := 1 to pred(courbeCourante) do
             if (nomC=nomY[c]) or
                (nomC=nomX[c])  then
                 begin Yok := false;break end;
         if Yok then begin k := i;break end;
     end;
     nomY[courbeCourante] := getNomCoord(listeVar[k]);
     if pos(RepereConst,nomY[courbeCourante])>0 then
           system.delete(nomY[courbeCourante],1,length(RepereConst));
     VariableLB.tabs.add('');
     VariableLB.tabIndex := pred(courbeCourante);
     code := indexNom(nomY[courbeCourante]);
     grandeurRef := grandeurs[code];
     iMonde[courbeCourante] := mondeX;
     mondeYInterdit := false;
     mondeDroitInterdit := false;
     for i := 1 to pred(courbeCourante) do begin
         code := indexNom(nomY[i]);
         if code<>grandeurInconnue then
            if grandeurs[code].uniteEgale(grandeurRef)
                then begin
                   iMonde[courbeCourante] := iMonde[i];
                   break;
                end
                else begin
                   if iMonde[i]=mondeY then mondeYinterdit := true;
                   if iMonde[i]=mondeDroit then mondeDroitinterdit := true;
                end;
     end;  // for i
     if iMonde[courbeCourante]=mondeX then
        if mondeYInterdit
           then if mondeDroitInterdit
                then iMonde[courbeCourante] := mondeSans
                else iMonde[courbeCourante] := mondeDroit
           else iMonde[courbeCourante] := mondeY;
     Maj;
end end;

procedure TFcoordonneesPhys.DeleteBtnClick(Sender: TObject);
var i : TindiceOrdonnee;
begin with transfert do
     for i := succ(variableLB.tabIndex) to pred(variableLB.tabs.count) do begin
         nomY[i] := nomY[succ(i)];
         nomX[i] := nomX[succ(i)];
         iMonde[i] := iMonde[succ(i)];
         trace[i] := trace[succ(i)];
     end;
     VariableLB.tabs.delete(VariableLB.tabIndex);
     VariableLB.tabIndex := 0;
     Maj;
end;

Procedure TFcoordonneesPhys.setNom;
var i : TindiceOrdonnee;
begin 
    with transfert do
        for i := 1 to variableLB.tabs.count do
            VariableLB.tabs[i-1] := nomY[i]+'=f('+nomX[i]+')';
end;

procedure TFcoordonneesPhys.LigneCBClick(Sender: TObject);
begin
      if LigneCB.checked
         then include(transfert.trace[courbeCourante],trLigne)
         else exclude(transfert.trace[courbeCourante],trLigne);
      LigneRG.Visible := LigneCB.checked;
      if LigneCB.checked and (LigneRG.itemIndex<>0) then PointCB.checked := true;
end;

procedure TFcoordonneesPhys.PointCBClick(Sender: TObject);
begin
     if PointCB.checked
        then include(transfert.trace[courbeCourante],trPoint)
        else exclude(transfert.trace[courbeCourante],trPoint);
     PointCombo.visible := PointCB.checked;
     DimPointSE.Visible := PointCB.checked and (PointCombo.itemIndex<>ord(mIncert));
     LabelDimPoint.visible := DimPointSE.visible;
     PasPointSE.visible := PointCB.checked and detailBtn.down;
end;

procedure TFcoordonneesPhys.IntensiteCBClick(Sender: TObject);
begin
     ContrastePanel.visible := IntensiteCB.checked;
     if IntensiteCB.checked
         then include(transfert.trace[courbeCourante],trIntensite)
         else exclude(transfert.trace[courbeCourante],trIntensite)
end;

procedure TFcoordonneesPhys.VitesseCBClick(Sender: TObject);
begin
      if vitesseCB.checked
         then if vitesseCalculee
             then include(transfert.trace[courbeCourante],trVitesse)
             else AffecteVecteurs(false)
         else exclude(transfert.trace[courbeCourante],trVitesse)
// trVitesse donc orthonormé ?         
end;

procedure TFcoordonneesPhys.AccelerationCBClick(Sender: TObject);
begin
      if AccelerationCB.checked
         then if accelerationCalculee
             then include(transfert.trace[courbeCourante],trAcceleration)
             else AffecteVecteurs(true)             
         else exclude(transfert.trace[courbeCourante],trAcceleration)
end;

procedure TFcoordonneesPhys.FormCreate(Sender: TObject);
begin
    ListeVar := TstrListe.create;
    PageOption := MecaniqueTS;
    if transfert=nil then transfert := TtransfertGraphe.Create;
    VirtualImageListLigne.height := VirtualImageListSize;
    VirtualImageListLigne.width := VirtualImageListSize;
    VirtualImageListPoint.height := VirtualImageListSize;
    VirtualImageListPoint.width := VirtualImageListSize;
end;

procedure TFcoordonneesPhys.FormDestroy(Sender: TObject);
begin
     ListeVar.free;
     Transfert.free;
     inherited
end;

procedure TFcoordonneesPhys.ListeXChange(Sender: TObject);
var i : integer;
begin
      if listeX.text=SeparateurConst then
         listeX.ItemIndex := pred(listeX.ItemIndex);
      if memeXCB.checked then
         for i := 1 to VariableLB.tabs.count do
             transfert.nomX[i] := getNomCoord(listeX.text)
         else transfert.nomX[courbeCourante] := getNomCoord(listeX.text);
      MajOptions;
      setNom;
end;

procedure TFcoordonneesPhys.ListeYChange(Sender: TObject);
var i,code,codeR : integer;
begin with transfert do begin
      if listeY.text=SeparateurConst then
         listeY.ItemIndex := pred(listeY.ItemIndex);
      nomY[courbeCourante] := getNomCoord(listeY.text);
      codeR := indexNom(nomY[courbeCourante]);
      for i := 1 to VariableLB.tabs.count do
         if (i<>courbeCourante) then begin
         code := indexNom(nomY[i]);
         if (code<>grandeurInconnue) and
            (grandeurs[code].uniteEgale(grandeurs[codeR]))
                then begin
                   iMonde[courbeCourante] := iMonde[i];
                   mondeCB.itemIndex := iMonde[courbeCourante]-mondeY;
                   break;
                end
     end; // for i
     MajOptions;
     setNom;
end end;

procedure TFcoordonneesPhys.GraduationXChange(Sender: TObject);
begin
     transfert.grad[mondeX] := Tgraduation(GraduationX.itemIndex);
     OrthonormeCB.enabled := (transfert.grad[mondeX]=gLin) and
                  (OgPolaire in transfert.OptionGr);
     zeroXCB.visible := not(PolaireCB.checked) and
                        (transfert.grad[mondeX]=gLin);
     ZoomAutoBtnClick(sender);
     transfert.useDefautX := false;
end;

procedure TFcoordonneesPhys.GraduationYChange(Sender: TObject);
var m : TindiceMonde;
begin
     m := transfert.iMonde[courbeCourante];
     if m>mondeSans then m := mondeSans;
     transfert.grad[m] := Tgraduation(GraduationY.itemIndex);
     OrthonormeCB.enabled := (transfert.grad[m]=gLin) and
                  (OgPolaire in transfert.OptionGr);
     zeroYCB.visible := not(PolaireCB.checked) and
                           (transfert.grad[m]=gLin);
     minidBEdit.Visible := (transfert.grad[m]=gdB) or (OgPolaire in transfert.OptionGr);
     if (OgPolaire in transfert.OptionGr)
        then minidBEdit.value := round(transfert.zeroPolaire)
        else minidBEdit.value := round(transfert.minidb[m]);
     ZoomAutoBtnClick(sender);
end;

procedure TFcoordonneesPhys.MondeCBChange(Sender: TObject);
var m : TindiceMonde;
begin
     m := mondeY+mondeCB.itemIndex;
     transfert.iMonde[courbeCourante] := m;
     transfert.grad[m] := Tgraduation(GraduationY.itemIndex);
end;

procedure TFcoordonneesPhys.VariableLBClick(Sender: TObject);
begin
     Maj
end;

procedure TFcoordonneesPhys.CouleurComboChange(Sender: TObject);
begin
     if transfert=nil then Transfert := TtransfertGraphe.Create;
     if pagesGB.visible and (reperePageRG.itemIndex=2)
        then couleurPages[PageActive mod MaxPagesGr] := CouleurCombo.selected
        else begin
            couleurInit[CourbeCourante] := CouleurCombo.selected;
            Transfert.couleur[CourbeCourante] := CouleurCombo.selected;
        end;
     setNom;
end;

procedure TFcoordonneesPhys.CouleurPointEditExit(Sender: TObject);
begin
    Transfert.couleurPoint[CourbeCourante] := CouleurPointEdit.text;
end;

procedure TFcoordonneesPhys.CouleurSigneCBClick(Sender: TObject);
begin
   if CouleurSigneCB.checked
      then Transfert.codeCouleur[CourbeCourante] := tSigne
      else Transfert.codeCouleur[CourbeCourante] := tHue;
   TeinteLabel.caption := codeCouleurstr[Transfert.codeCouleur[CourbeCourante]]  ;
   HueImage.Visible := not CouleurSigneCB.checked;
   SigneLabel.Visible := CouleurSigneCB.checked;
end;

procedure TFcoordonneesPhys.CouleursSpectreCBClick(Sender: TObject);
begin
     if CouleursSpectreCB.checked
         then include(transfert.trace[courbeCourante],trCouleursSpectre)
         else exclude(transfert.trace[courbeCourante],trCouleursSpectre);
end;

procedure TFcoordonneesPhys.PointComboChange(Sender: TObject);
begin
if pagesGB.visible and (reperePageRG.itemIndex=1)
     then motifPages[pageActive mod MaxPagesGr] := Tmotif(PointCombo.itemIndex)
     else begin
        motifInit[CourbeCourante] := Tmotif(PointCombo.itemIndex);
        Transfert.Motif[CourbeCourante] := Tmotif(PointCombo.itemIndex);
     end;
     if Transfert.Motif[CourbeCourante]=mIncert then begin
         avecEllipse := true;
         PointCombo.hint := hMotif[true];
     end;
end;

procedure TFcoordonneesPhys.ZeroXCBClick(Sender: TObject);
begin
    Transfert.zero[mondeX] := zeroXCB.checked;
    Maj;
end;

procedure TFcoordonneesPhys.ZeroYCBClick(Sender: TObject);
var m : TindiceMonde;
begin
     m := transfert.iMonde[courbeCourante];
     Transfert.zero[m] := zeroYCB.checked;
     Maj;
end;

procedure TFcoordonneesPhys.LigneRGChange(Sender: TObject);
begin
    if (LigneRG.itemIndex=1) and not ModelePermis then LigneRG.itemIndex := 0;
    if (LigneRG.itemIndex=2) and (pages[pageCourante].nmes>maxVecteurSpline) then LigneRG.itemIndex := 0;
    OrdreLissageSE.visible := LigneRG.itemIndex=2;
    if LigneCB.checked and (LigneRG.itemIndex<>0) then PointCB.checked := true;
    transfert.ligne[courbeCourante] := Tligne(LigneRG.itemIndex);
end;

procedure TFcoordonneesPhys.LigneRGClick(Sender: TObject);
begin
    if ligneRG.itemIndex=ord(liSpline) then ordreLissageSE.MaxValue := ordreMaxSpline;
    ordreLissageSE.MinValue := ordreMinSpline;
end;

procedure TFcoordonneesPhys.LigneRGDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin with Control as TComboBox do begin
     Canvas.FillRect(Rect);
     if ((Index=1) and not modelePermis) or
        ((index=2) and (pages[pageCourante].nmes>maxVecteurSpline))
         then Canvas.Font.Color := clGray
         else Canvas.Font.Color := clBlack;
     Canvas.TextOut(Rect.Left, Rect.Top, ligneRG.items[Index]);
end end;

procedure TFcoordonneesPhys.AffecteVecteurs(AffecteAcceleration : boolean);
var recalcul : boolean;
    nomV,nomA : array[1..2] of string;
    suffixe : string;
    indexV : array[1..2 ] of integer;
    index : array[1..2] of integer;
    indexA : array[1..2] of integer;

Procedure CalcVitesse;
var k : integer;

Function AddVitesse(y,x : tgrandeur) : string;
begin
    inc(k);
    Fvaleurs.memo.lines.add('v'+y.nom+'=Diff('+y.nom+','+x.nom+')');
    recalcul := true;
    result := 'v'+y.nom;
end;

var i : integer;
begin with transfert do begin
      k := 1;
      index[1] := indexNom(nomX[CourbeCourante]);
      index[2] := indexNom(nomY[CourbeCourante]);
      suffixe := grandeurs[index[1]].nom;
      delete(suffixe,1,1);
      for i := 1 to 2 do begin
         indexv[i] := IndexVitesse(grandeurs[index[i]].nom);
         if indexv[i]=GrandeurInconnue
            then nomv[i] := AddVitesse(grandeurs[index[i]],grandeurs[0])
            else nomv[i] := grandeurs[indexv[i]].nom;
      end;
      if k=3 then Fvaleurs.memo.lines.add('v'+suffixe+'=sqrt('+
            nomv[1]+'^2+'+nomv[2]+'^2)');
end end;

Procedure CalcAcceleration;
var k : integer;

Function AddAcceleration(const y,v,t : string) : string;
begin
    inc(k);
    Fvaleurs.memo.lines.add('a'+y+'=Diff('+v+','+t+')');
    recalcul := true;
    result := 'a'+y;
end;

var i : integer;
begin with transfert do begin
           k := 1;
           for i := 1 to 2 do begin
              indexa[i] := IndexAcceleration(grandeurs[index[i]].nom);
              if indexa[i]=GrandeurInconnue
                 then nomA[i] := AddAcceleration(grandeurs[index[i]].nom,nomv[i],grandeurs[0].nom)
                 else nomA[i] := grandeurs[indexa[i]].nom;
           end;
           if k=3 then Fvaleurs.memo.lines.add('a'+suffixe+'=sqrt('+
                 nomA[1]+'^2+'+nomA[2]+'^2)');
end end;

begin with transfert do begin
      recalcul := false;
      calcVitesse;
      if AffecteAcceleration then calcAcceleration;
      if recalcul then begin
         Fvaleurs.MajBtnClick(nil);
         Application.processMessages;
      end;
      majOptions;
      if AffecteAcceleration
         then begin
            AccelerationCB.checked := AccelerationCalculee;
            if accelerationCalculee
               then include(trace[courbeCourante],trAcceleration)
               else exclude(trace[courbeCourante],trAcceleration)
         end
         else begin
            VitesseCB.checked := VitesseCalculee;
            if vitesseCalculee
               then include(trace[courbeCourante],trVitesse)
               else exclude(trace[courbeCourante],trVitesse)
         end
end end; // AffecteVecteurs 

procedure TFcoordonneesPhys.PageBioMecaChange(Sender: TObject);
var m : TindiceMonde;
begin
 //    exclude(transfert.trace[courbeCourante],trCouples);
 //    exclude(transfert.trace[courbeCourante],trSpirometrie);
     if (PageBioMeca.activePage<>OptiqueTS) then begin
         exclude(transfert.trace[courbeCourante],trIntensite);
     end;
     if (PageBioMeca.activePage<>MecaniqueTS) then begin
         exclude(transfert.trace[courbeCourante],trVitesse);
         exclude(transfert.trace[courbeCourante],trAcceleration)
     end;                                   if (PageBioMeca.activePage<>AstroTS) then begin
         transfert.axeInverse[mondeX] := false;
         m := transfert.iMonde[courbeCourante];
         transfert.axeInverse[m] := false;
     end;
end;

procedure TFcoordonneesPhys.PagePrecBtnClick(Sender: TObject);
begin
    if pageActive>1
       then dec(pageActive)
       else pageActive := NbrePages;
    MajPages;
end;

procedure TFcoordonneesPhys.OptionsVitesseBtnClick(Sender: TObject);
var code : integer;
begin
     OptionsVitesseDlg := TOptionsVitesseDlg.create(self);
     code := indexNom(listeX.text);
     OptionsVitesseDlg.grandeurX := grandeurs[code];
     code := indexNom(listeY.text);
     OptionsVitesseDlg.grandeurY := grandeurs[code];
     if OptionsVitesseDlg.showModal=mrOK then majOptions;
     OptionsVitesseDlg.free;
end;

procedure TFcoordonneesPhys.VariableLBDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
var decale : integer;
begin with VariableLB.canvas do begin
       if active
          then begin
            Pen.color := clBtnFace;
            Brush.color := clBtnFace;
            decale := 6;
          end
          else begin
            Pen.color := clBtnShadow;
            Brush.color := clBtnShadow;
            decale := 2;
          end;
       FillRect(rect);
       TextRect(rect,rect.left+decale,rect.top+2,VariableLB.tabs[tabIndex]);
end end;

procedure TFcoordonneesPhys.AfficheDetail;
const Aide : array[boolean] of string = ('Plus d''options','Moins d''options');
var Hauteur : integer;
begin
     hauteur := GroupBoxOptions.Height+(9*AbscisseGB.height div 2)+16;
     PageBioMeca.visible := DetailBtn.down;
     pagesGB.Visible := superPagesCB.checked;
     if DetailBtn.down
        then hauteur := hauteur+PageBioMeca.height;
     if pagesGB.Visible
        then hauteur := hauteur+pagesGB.height;
     ClientHeight := hauteur;
     DetailBtn.caption := Aide[DetailBtn.down];
     PasPointSE.Visible := DetailBtn.down and PointCB.checked;
     LigneCombo.Visible := DetailBtn.down;
     OptionsVitesseBtn.visible := VitesseCB.enabled and (imVitesse in MenuPermis);
     LabelVitesse.visible := not vitesseCB.enabled;
     ContrastePanel.visible := IntensiteCB.checked;
     if pageBioMeca.visible then pageBioMeca.repaint;
end;

procedure TFcoordonneesPhys.DetailBtnClick(Sender: TObject);
begin
     afficheDetail
end;

procedure TFcoordonneesPhys.ZoomAutoBtnClick(Sender: TObject);
begin
     EchelleManuelleLabel.visible := false;
     ZoomAutoBtn.visible := false;
     Transfert.useDefaut := false;
     Transfert.useDefautX := false;
     Transfert.autoTick := true;
     Transfert.useZoom := false;
end;

procedure TFcoordonneesPhys.LigneComboChange(Sender: TObject);
begin
 if pagesGB.visible and (reperePageRG.itemIndex=0)
     then stylePages[PageActive mod MaxPagesGr] := TpenStyle(LigneCombo.itemIndex)
     else Transfert.style[CourbeCourante] := TpenStyle(LigneCombo.itemIndex);
end;

procedure TFcoordonneesPhys.indicateurCBClick(Sender: TObject);
begin
     MajIndicateur
end;

procedure TFcoordonneesPhys.IndicateurBtnClick(Sender: TObject);
var i : integer;
    indic : Tindicateur;
begin
   if indicateurDlg.showModal=mrOK then begin
        indicateurCombo.clear;
        for i := 0 to pred(indicateurDlg.indicateurs.count) do begin
          indic := Tindicateur(indicateurDlg.indicateurs[i]);
          indicateurCombo.AddItem(indic.nom+' ('+floatToStr(indic.pka)+')',
                             indicateurDlg.indicateurs[i]);
        end;
   end;
end;

procedure TFcoordonneesPhys.MinidBEditChange(Sender: TObject);
var m : TindiceMonde;
begin
     m := transfert.iMonde[courbeCourante];
     if polaireCB.Checked
        then transfert.zeroPolaire := minidBEdit.value
        else transfert.minidb[m] := minidBEdit.value;
end;

procedure TFcoordonneesPhys.HelpCornishBtnClick(Sender: TObject);
begin
     Aide(HELP_MethodedeCornishBowden)
end;

procedure TFcoordonneesPhys.OptionsBtnClick(Sender: TObject);
begin
   OptionCouleurDlg := TOptionCouleurDlg.create(self);
   OptionCouleurDlg.DlgGraphique := nil;
   OptionCouleurDlg.ShowModal;
   OptionCouleurDlg.free;
end;

procedure TFcoordonneesPhys.OptionsIndicateurLBClick(Sender: TObject);
var oi : TOptionIndicateur;
begin
    for oi := low(TOptionIndicateur) to High(TOptionIndicateur) do
        if optionsIndicateurLB.checked[ord(oi)]
           then include(OptionsIndicateur,oi)
           else exclude(OptionsIndicateur,oi);
    MajIndicateur;
end;

procedure TFcoordonneesPhys.IndicateurComboChange(Sender: TObject);
begin
   MajIndicateur
end;

procedure TFcoordonneesPhys.MajIndicateur;
begin
     indicateurCombo.visible := IndicateurCB.checked;
     optionsIndicateurLB.visible := IndicateurCB.checked;
     if IndicateurCB.checked
         then include(transfert.trace[courbeCourante],trIndicateur)
         else exclude(transfert.trace[courbeCourante],trIndicateur);
     if indicateurCombo.itemIndex>=0 then begin
         Agraphe.indicateur := Tindicateur(indicateurCombo.items.objects[indicateurCombo.itemIndex]);
         pages[pageCourante].indicateurP := Agraphe.indicateur; 
     end;
     Agraphe.affecteIndicateur(indicateurCB.checked,transfert.nomY[courbeCourante]);
     Agraphe.paintBox.refresh;
end;


Procedure TFcoordonneesPhys.majPages;
begin
//    CommentaireEdit.Font.color := couleurPages[pageActive];
    if pages[pageActive].commentaireP=''
       then CommentaireEdit.text := IntToStr(PageActive)+'/'+IntToStr(NbrePages)
       else CommentaireEdit.text := pages[pageActive].commentaireP;
    case ReperePageRG.itemIndex of
         0 : LigneCombo.itemIndex := ord(stylePages[PageActive mod MaxPagesGr]);
         1 : PointCombo.itemIndex := ord(motifPages[PageActive mod MaxPagesGr]);
         2 : CouleurCombo.selected := couleurPages[PageActive mod MaxPagesGr];
    end;
end;

end.
