unit newvar;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, SysUtils, Spin, ComCtrls,
  Vcl.htmlHelpViewer,
  constreg, maths, regutil, uniteker, compile, filerrr, aidekey;

type
  TNewVarDlg = class(TForm)
    GenreGrandeurRG: TRadioGroup;
    Panel1: TPanel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Panel2: TPanel;
    PageControl: TPageControl;
    VarDeriveeYCB: TComboBox;
    VarDeriveeXCB: TComboBox;
    Label4: TLabel;
    VarLisseCB: TComboBox;
    OrdreLissageSE: TSpinEdit;
    Label11: TLabel;
    NomEdit: TEdit;
    Label1: TLabel;
    UniteEdit: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    SignifEdit: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    NomDerivee: TLabel;
    LabelDiff: TLabel;
    VarIntgCB: TComboBox;
    IntegraleEdit: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    FonctionEdit: TEdit;
    ModeleCB: TCheckBox;
    Bevel: TBevel;
    Label9: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    NomIntg: TLabel;
    GenerationAutoCB: TCheckBox;
    GenerationPanel: TPanel;
    ExpressionParam: TLabel;
    ParametreEdit: TEdit;
    Label16: TLabel;
    Label14: TLabel;
    NbrePagesSE: TSpinEdit;
    NomFonctionLabel: TLabel;
    ExpVarSheet: TTabSheet;
    ExpParSheet: TTabSheet;
    FonctionSheet: TTabSheet;
    DeriveeSheet: TTabSheet;
    IntgSheet: TTabSheet;
    LissageSheet: TTabSheet;
    TexteVarSheet: TTabSheet;
    EulerCB: TCheckBox;
    ValeurInitEdit: TEdit;
    ValeurInitLabel: TLabel;
    Label17: TLabel;
    Label15: TLabel;
    ParametreDerivee: TCheckBox;
    OptionsDeriveeGB: TGroupBox;
    NbreEdit: TEdit;
    NbreSpinButton: TSpinButton;
    Label18: TLabel;
    Label19: TLabel;
    LissageRG: TRadioGroup;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure GenreGrandeurRGClick(Sender: TObject);
    procedure NomEditChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure GenerationAutoCBClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure EulerCBClick(Sender: TObject);
    procedure NbreSpinButtonDownClick(Sender: TObject);
    procedure NbreSpinButtonUpClick(Sender: TObject);
    procedure ParametreDeriveeClick(Sender: TObject);
    procedure OrdreDeriveeSEChange(Sender: TObject);
    procedure NomEditKeyPress(Sender: TObject; var Key: Char);
  private
  public
    LigneInit,LigneCompile,LigneSignif : string;
    procedure Initialise(index : integer);
  end;

var
  NewVarDlg: TNewVarDlg;

const
    iVarExp = 0;
    iParamExp = 1;
    iFonction = 2;

implementation

uses RegMain;

{$R *.DFM}

type
    EcompileError = class(Exception);

const
    iDerivee = 3;
    iIntegrale = 4;
    iLissage = 5;
    iVarTexte = 6;

procedure TNewVarDlg.FormCloseQuery(Sender: TObject;var CanClose: Boolean);
var index : TcodeGrandeur;
    g : tgrandeur;
    posErreur,longErreur : integer;
    NewNom : string;

procedure VerifExp(Agenre : TgenreGrandeur);
begin
    G.init(nomEdit.text,uniteEdit.text,'',Agenre);
    if (AGenre=Constante) and
        GenerationAutoCB.checked then begin
       G.fonct.expression := ParametreEdit.text;
       if G.compileG(posErreur,longErreur,0) and
         (ParametreEdit.text='') then codeErreurC := erExpressionVide;
       if (codeErreurC=erVide) and
          OKreg(OkNoParamAuto,0) then begin
          codeErreurC := '';
          GenerationAutoCB.checked := false;
       end;
    end;
    if (AGenre=Variable) and
       (ModeAcquisition in [AcqCan,AcqBitMap,AcqSimulation]) and
        not(DataCanModifiable)
           then codeErreurC := erDataCan;
    if codeErreurC<>'' then afficheErreur(codeErreurC,0);
    if (AGenre=Constante) and
        GenerationAutoCB.checked
          then begin
             G.fonct.genreC := g_fonction;{ !! ?? }
             LigneCompile := NomEdit.text+'='+ParametreEdit.text;
             if uniteEdit.text<>'' then
                   LigneCompile := LigneCompile + '_' +uniteEdit.text;
          end
          else G.fonct.genreC := g_experimentale;
    G.genreG := Agenre;
end;

procedure VerifTexte(Agenre : TgenreGrandeur);
begin
    G.init(nomEdit.text,'','',Agenre);
    G.fonct.genreC := g_texte;
    G.genreG := Agenre;
    if not OKReg(OkNonNum,0)
       then CodeErreurC := erNonNum
end;

procedure VerifFonction;
var i : integer;
begin
     if EulerCB.checked
        then begin
             LigneCompile := NomEdit.text+'[i]='+FonctionEdit.text;
             LigneInit := NomEdit.text+'[0]='+ValeurInitEdit.text;
        end
        else LigneCompile := NomEdit.text+'='+FonctionEdit.text;
     if uniteEdit.text<>'' then begin
        LigneCompile := LigneCompile + '_' +uniteEdit.text;
        if EulerCB.checked then LigneInit := LigneInit + '_' +uniteEdit.text;
     end;
     if not EulerCB.checked then begin
        G.Init(nomEdit.text,uniteEdit.text,FonctionEdit.text,variable);
        for i := 0 to pred(NbreGrandeurs) do include(G.fonct.depend,i);
        G.compileG(posErreur,longErreur,0);
        if (codeErreurC='') and (FonctionEdit.text='') then
            codeErreurC := erExpressionVide;
     end;
     if codeErreurC<>'' then begin
          afficheErreur(codeErreurC,0);
          FonctionEdit.setFocus;
          FonctionEdit.selStart := pred(posErreur);
          FonctionEdit.selLength := longErreur;
     end;
     if (codeErreurC='') and (G.nomUnite='') then G.setUnite;
end;

procedure VerifDerivee;
var xx,yy : TcodeGrandeur;
    i : integer;
begin
    xx := indexNom(VarDeriveeXCB.text);
    yy := indexNom(VarDeriveeYCB.text);
    LigneCompile := NomFonctionGlb[derivee]+
        '('+grandeurs[yy].nom+','+grandeurs[xx].nom;
    if ParametreDerivee.Checked
      then LigneCompile := LigneCompile+','+intToStr(LissageRG.itemIndex+1)+','+NbreEdit.Text;
    LigneCompile := LigneCompile+')';
    G.Init(nomEdit.text,uniteEdit.text,LigneCompile,variable);
    for i := 0 to pred(NbreGrandeurs) do include(G.fonct.depend,i);
    if G.compileG(posErreur,longErreur,0)
       then begin
         LigneCompile := NomEdit.text+'='+LigneCompile;
         if G.nomUnite='' then
            G.AdUnite('-',grandeurs[yy],grandeurs[xx]);
       end
       else afficheErreur(codeErreurC,0);
end;

procedure VerifIntegrale;
var xx : TcodeGrandeur;
    i : integer;
begin
    xx := indexNom(VarIntgCB.text);
    LigneCompile := NomFonctionGlb[integrale]+'('+IntegraleEdit.text+','+grandeurs[xx].nom+')';
    G.Init(nomEdit.text,uniteEdit.text,LigneCompile,variable);
    for i := 0 to pred(NbreGrandeurs) do include(G.fonct.depend,i);
    if G.compileG(posErreur,longErreur,0)
       then begin
          LigneCompile := NomEdit.text+'='+LigneCompile;
          if G.nomUnite='' then begin
             G.calcUnite(G.fonct.calcul.OperandGlb);
             G.PlusUnite(grandeurs[xx]);
          end;
       end
       else begin
          afficheErreur(codeErreurC,0);
          IntegraleEdit.setFocus;
          IntegraleEdit.selStart := pred(posErreur);
          IntegraleEdit.selLength := longErreur;
       end;
end;

procedure VerifLissage;
var xx : TcodeGrandeur;
begin
    xx := indexNom(VarLisseCB.text);
    LigneCompile := NomFonctionGlb[lissageCentre]+
       '('+grandeurs[xx].nom+','+IntToStr(OrdreLissageSE.value)+')';
    G.Init(nomEdit.text,'',LigneCompile,variable);
    if G.compileG(posErreur,longErreur,0)
       then begin
          G.recopieUnite(grandeurs[xx]);
          LigneCompile := NomEdit.text+'='+LigneCompile;
       end
       else afficheErreur(codeErreurC,0);
end;

Procedure calculeConstante;
var pageC : integer;
begin
      grandeurs[index].fonct.genreC := g_fonction;
      for pageC := succ(NbrePages) to NbrePagesSE.value do begin
          ajoutePageForce;
          with pages[pageC] do begin
               nmes := pages[1].nmes;
               valeurVar[0] := pages[1].valeurVar[0];
          end;
      end;
      for pageC := 1 to NbrePages do begin
          grandeurs[cPage].valeurCourante := pageC;
          pages[pageC].numero := pageC;          
          try
          pages[pageC].ValeurConst[index] := calcule(grandeurs[index].Fonct.calcul);
          except
          end;
      end;
end;

Procedure MajOrdre; // à vérifier
var i,p,iCalc : integer;
    tampon : tgrandeur;
begin
    for i := 0 to pred(NbreVariab) do begin
        iCalc := indexVariab[i];
        if grandeurs[iCalc].fonct.genreC<>g_experimentale then begin
           for p := 1 to NbrePages do
               pages[p].transfereVariabP(index,iCalc);
           tampon :=  grandeurs[iCalc];
           grandeurs[iCalc] := grandeurs[index];
           grandeurs[index] := tampon;
           break;
        end;
    end;
end;

begin // FormCloseQuery
   if modalResult<>mrOK then begin
      canClose := true;
      exit;
   end;
   NewNom := NomEdit.text;
   trimComplet(NewNom);
   NomEdit.text := NewNom;
   LigneCompile := '';
   if signifEdit.text<>''
      then ligneSignif := ''''+NomEdit.text+'='+SignifEdit.text
      else ligneSignif := '';
   posErreur := 0;
   longErreur := 0;
   codeErreurC := '';
   if NomCorrect(NomEdit.text,grandeurInconnue)
       then begin
             G := Tgrandeur.create;
             G.NomUnite := UniteEdit.text;
             if not(G.correct) and not OKReg(OkUniteInconnue,HELP_Unites) then begin
                   G.free;
                   CanClose := false;
                   UniteEdit.setFocus;
                   exit;
             end;
      end
      else begin
            afficheErreur(codeErreurC,0);
            CanClose := false;
            NomEdit.setFocus;
            exit;
       end;
   codeErreurC := '';
   LigneInit := '';
   case GenreGrandeurRG.itemIndex of
         iVarExp : VerifExp(variable);
         iParamExp : VerifExp(constante);
         iFonction : VerifFonction;
         iDerivee : VerifDerivee;
         iIntegrale : VerifIntegrale;
         iLissage : VerifLissage;
         iVarTexte : VerifTexte(variable);
   end;
   canClose := codeErreurC='';
   if not (genreGrandeurRG.itemIndex=iFonction) then EulerCB.checked := false;
   if canClose
      then begin
           if not EulerCB.checked then index := ajouteGrandeurE(G);
           if GenreGrandeurRG.itemIndex=iVarExp then MajOrdre;
           if (GenreGrandeurRG.itemIndex=iParamExp) and
              GenerationAutoCB.checked then
                 calculeConstante;
           if not (genreGrandeurRG.itemIndex=iVarTexte)
              then ReCalculE;
           ModifFichier := true;
      end
      else G.free;
end;

procedure TNewVarDlg.Initialise(index : integer);
var i : integer;
begin
     NomEdit.text := '';
     UniteEdit.text := '';
     SignifEdit.text := '';
     IntegraleEdit.text := '';
     FonctionEdit.text := '';
     ParametreEdit.text := '';
     VarIntgCB.Clear;
     for i := 0 to pred(NbreVariab) do with grandeurs[indexVariab[i]] do
         VarIntgCB.Items.Add(nom);
     VarLisseCB.Items.Assign(VarIntgCB.Items);
     VarDeriveeXCB.Items.Assign(VarIntgCB.Items);
     VarDeriveeYCB.Items.Assign(VarIntgCB.Items);
     VarLisseCB.ItemIndex := pred(NbreVariab);
     VarDeriveeXCB.ItemIndex := 0;
     VarDeriveeYCB.ItemIndex := 1;
     VarIntgCB.ItemIndex := 0;
     GenreGrandeurRG.itemIndex := index;
     PageControl.ActivePageIndex := index;
end;

procedure TNewVarDlg.GenreGrandeurRGClick(Sender: TObject);
begin
     PageControl.ActivePageIndex := GenreGrandeurRG.itemIndex;
end;

procedure TNewVarDlg.NomEditChange(Sender: TObject);
var prompt : string;
    nomX : string;
begin
     prompt := NomEdit.Text+'''';
     NomDerivee.caption := NomEdit.text+'=';
     NomIntg.caption := NomEdit.text+'=';
     NomFonctionLabel.caption := NomEdit.text+'=';
     ExpressionParam.caption := NomEdit.text+'=';
     ValeurInitLabel.caption := NomEdit.text+'[0]=';
     if (GenreGrandeurRG.itemIndex=iFonction) and EulerCB.checked then begin
        nomX := grandeurs[0].nom+'[i';
        FonctionEdit.text := NomEdit.text+'[i-1]+( )*('+nomX+']-'+nomX+'-1])';
        NomFonctionLabel.caption := NomEdit.text+'[i]=';
     end;
end;

procedure TNewVarDlg.NomEditKeyPress(Sender: TObject; var Key: Char);
begin
     case key of
        crCR,crTab : ;
        crEsc : ;
        crSupprArr : ;
        else if not isCaracGrandeur(key) then key := #0;
     end;
end;

procedure TNewVarDlg.FormActivate(Sender: TObject);
begin
       inherited;
       GenerationAutoCB.visible := ModeAcquisition=AcqSimulation;
       GenerationPanel.visible := (ModeAcquisition=AcqSimulation) and
           GenerationAutoCB.checked;
       GenreGrandeurRGClick(Sender);
       NbreEdit.text := IntToStr(NbrePointDerivee);
       LissageRG.ItemIndex := DegreDerivee-1;
end;

procedure TNewVarDlg.GenerationAutoCBClick(Sender: TObject);
begin
       GenerationPanel.visible := GenerationAutoCB.checked
end;

procedure TNewVarDlg.HelpBtnClick(Sender: TObject);
begin
     Aide(HELP_Grandeurs)
end;

procedure TNewVarDlg.EulerCBClick(Sender: TObject);
var nomX : string;
begin
     ValeurInitEdit.visible := EulerCB.checked;
     ValeurInitLabel.visible := EulerCB.checked;
     if EulerCB.checked
        then begin
            NomFonctionLabel.caption := NomEdit.text+'[i]=';
            nomX := grandeurs[0].nom+'[i';
            FonctionEdit.text := NomEdit.text+'[i-1]+()*('+nomX+']-'+nomX+'-1])';
            FonctionEdit.hint := 'Complèter entre les parenthèses';
        end
        else begin
            NomFonctionLabel.caption := NomEdit.text+'=';
            if pos('[',FonctionEdit.text)>0 then FonctionEdit.text := '';
            FonctionEdit.hint := '';
        end
end;

procedure TNewVarDlg.NbreSpinButtonDownClick(Sender: TObject);
var N : integer;
begin
     N := strToInt(NbreEdit.text);
     if (N>3) and
        (N>(LissageRG.itemIndex*2+1)) then begin
           dec(N,2);
           NbreEdit.text := IntToStr(N);
     end;
end;

procedure TNewVarDlg.NbreSpinButtonUpClick(Sender: TObject);
var N : integer;
begin
     N := strToInt(NbreEdit.text);
     if N<13 then begin
        inc(N,2);
        NbreEdit.text := IntToStr(N);
     end;
end;

procedure TNewVarDlg.ParametreDeriveeClick(Sender: TObject);
begin
  inherited;
  OptionsDeriveeGB.visible := ParametreDerivee.checked;
  LissageRG.visible := ParametreDerivee.checked  
end;

procedure TNewVarDlg.OrdreDeriveeSEChange(Sender: TObject);
var N : integer;
begin
    N := strToInt(NbreEdit.text);
    if N<(LissageRG.itemIndex*2+1) then begin
       N := LissageRG.itemIndex*2+1;
       NbreEdit.text := intToStr(N);
    end;
end;

end.

