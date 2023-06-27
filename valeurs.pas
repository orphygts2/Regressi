unit valeurs;

interface

uses Windows, Classes, Graphics, Forms, Controls, StdCtrls, ShellApi,
  Buttons, ExtCtrls, Grids, sysUtils, Dialogs, Menus, Messages, printers,
  Spin, ComCtrls, ImgList, ToolWin, math, keysU, system.IOUtils,
  latex, constreg, Maths, regUtil, Compile, Modif,
  vcl.HtmlHelpViewer,
  aideKey, OleCtrls, SHDocVw, Variants,
  system.Types, System.ImageList, system.UITypes,
  PythonVersions, PythonEngine,
  Vcl.VirtualImageList, Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TFValeurs = class(TForm)
    Feuillets: TPageControl;
    GridParam: TStringGrid;
    gridVariab: TStringGrid;
    SimulationBox: TGroupBox;
    NomLabel: TLabel;
    NomEdit: TEdit;
    UniteLabel: TLabel;
    UniteEdit: TEdit;
    MiniLabel: TLabel;
    MiniEdit: TEdit;
    MaxiLabel: TLabel;
    MaxiEdit: TEdit;
    NmesEdit: TEdit;
    NmesSpin: TSpinButton;
    LogBox: TCheckBox;
    PopupMenuExpr: TPopupMenu;
    CompileItem: TMenuItem;
    CreerGrandeurItem: TMenuItem;
    CopierItem: TMenuItem;
    ParamSheet: TTabSheet;
    VariabSheet: TTabSheet;
    ExpSheet: TTabSheet;
    ImporterTraitements: TMenuItem;
    CollerItem: TMenuItem;
    GridParamGlb: TStringGrid;
    DeltaLabel: TLabel;
    DeltaEdit: TEdit;
    NbreLabel: TLabel;
    PagesIndependantesCB: TCheckBox;
    RazItem: TMenuItem;
    FreqEchLabel: TLabel;
    StatusBar: TStatusBar;
    MajTimer: TTimer;
    GrandeursPC: TPageControl;
    ConstanteTabSheet: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    ToolBarFonctions: TToolBar;
    ToolButton4: TToolButton;
    ToolButton8: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton13: TToolButton;
    ToolButton22: TToolButton;
    ToolButton23: TToolButton;
    ToolButton24: TToolButton;
    ToolButton25: TToolButton;
    ToolButton26: TToolButton;
    ToolButton34: TToolButton;
    ToolButton43: TToolButton;
    ToolButton73: TToolButton;
    ToolBarStat: TToolBar;
    ToolButton46: TToolButton;
    ToolButton56: TToolButton;
    ToolButton57: TToolButton;
    ToolButton58: TToolButton;
    ToolButton59: TToolButton;
    ToolButton60: TToolButton;
    ToolButton61: TToolButton;
    ToolButton62: TToolButton;
    ToolButton66: TToolButton;
    ToolButton63: TToolButton;
    TabSheet4: TTabSheet;
    ToolBarSignal: TToolBar;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolButton32: TToolButton;
    ToolButton40: TToolButton;
    ToolButton44: TToolButton;
    ToolButton50: TToolButton;
    ToolButton51: TToolButton;
    ToolButton52: TToolButton;
    ToolButton53: TToolButton;
    ToolButton54: TToolButton;
    ToolButton55: TToolButton;
    TabSheet5: TTabSheet;
    ToolBarDivers: TToolBar;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton27: TToolButton;
    ToolButton28: TToolButton;
    ToolButton29: TToolButton;
    ToolButton37: TToolButton;
    ToolButton38: TToolButton;
    ToolButton39: TToolButton;
    ToolButton45: TToolButton;
    ToolButton48: TToolButton;
    ToolButton49: TToolButton;
    TabSheet6: TTabSheet;
    ToolBarProgram: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton12: TToolButton;
    GrandeursTS: TTabSheet;
    ListeGrandeur: TListBox;
    ToolButton64: TToolButton;
    ToolButton9: TToolButton;
    ToolBarVariab: TToolBar;
    TriBtn: TToolButton;
    AddVarBtn: TToolButton;
    DeleteVarBtn: TToolButton;
    DelLinesBtn: TToolButton;
    DeltaBtn: TToolButton;
    CopyGridBtn: TToolButton;
    ToolBarParam: TToolBar;
    TriPageBtn: TToolButton;
    AddParamBtn: TToolButton;
    DeleteParamBtn: TToolButton;
    DeltaParamBtn: TToolButton;
    PrintParamBtn: TToolButton;
    CopyParamBtn: TToolButton;
    AddPageBtn: TToolButton;
    ToolBarExpr: TToolBar;
    AddBtn: TToolButton;
    HelpBtn: TToolButton;
    MajBtn: TToolButton;
    ImprimeBtn: TToolButton;
    CopierBtn: TToolButton;
    TrigoBtn: TToolButton;
    PrintVarBtn: TToolButton;
    Phase: TMenuItem;
    PhaseBtn: TToolButton;
    ListConstanteUniv: TListBox;
    PopupMenuGrid: TPopupMenu;
    CreerGrandeurGrid: TMenuItem;
    DelGrandeurItem: TMenuItem;
    TrierItem: TMenuItem;
    DelSelectItem: TMenuItem;
    CopierTableauItem: TMenuItem;
    PhaseItem: TMenuItem;
    PanelOperateurs: TPanel;
    PlusBtn: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    RazBtn: TToolButton;
    ToolButton14: TToolButton;
    ToolButton21: TToolButton;
    ToolButton30: TToolButton;
    ToolButton31: TToolButton;
    ToolButton33: TToolButton;
    TrigoBtnBis: TToolButton;
    TrigoItem: TMenuItem;
    ToolButton35: TToolButton;
    ToolButton36: TToolButton;
    RandomBtnBis: TToolButton;
    RandomItemBis: TMenuItem;
    ToolButton41: TToolButton;
    ToolButton42: TToolButton;
    ToolButton47: TToolButton;
    Grec: TTabSheet;
    ListBox1: TListBox;
    AlphaSpeedButton: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SpeedButton15: TSpeedButton;
    ToolButton65: TToolButton;
    Memo: TRichEdit;
    MathSheet: TTabSheet;
    WebBrowser1: TWebBrowser;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    Button1: TButton;
    SpeedButton16: TSpeedButton;
    SpeedButton17: TSpeedButton;
    SpeedButton18: TSpeedButton;
    SpeedButton19: TSpeedButton;
    ToolButton67: TToolButton;
    ToolButton68: TToolButton;
    ToolButton69: TToolButton;
    ToolButton70: TToolButton;
    SigmaBtn: TToolButton;
    ToolButton72: TToolButton;
    ToolButton74: TToolButton;
    ToolButton75: TToolButton;
    ConstGlbEdit: TRichEdit;
    ToolButton76: TToolButton;
    PythonTS: TTabSheet;
    CalcPythonBtn: TButton;
    MemoResultat: TMemo;
    Panel3: TPanel;
    PythonVersionLabel: TLabel;
    cbPyVersions: TComboBox;
    PythonSplitter: TSplitter;
    AidePythonBtn: TButton;
    ListeGrandeurPython: TListBox;
    PanelSource: TPanel;
    UniteSILabelVariab: TLabel;
    UniteSIBtn: TToolButton;
    UniteSIBtnBis: TToolButton;
    PythonDllBtn: TButton;
    SpeedButton20: TSpeedButton;
    SpeedButton21: TSpeedButton;
    SpeedButton22: TSpeedButton;
    SpeedButton23: TSpeedButton;
    effaceConsoleBtn: TButton;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    MemoSource: TRichEdit;
    NumeroLigneMemo: TRichEdit;
    PythonModule1: TPythonModule;
    PythonEngine1: TPythonEngine;
    PythonInputOutput1: TPythonInputOutput;
    ToolButton71: TToolButton;
    ToolButton77: TToolButton;
    ToolButton78: TToolButton;
    ToolButton79: TToolButton;
    procedure gridVariabKeyPress(Sender: TObject; var Key: Char);
    procedure FermeBtnClick(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
    procedure MemoKeyPress(Sender: TObject; var Key: Char);
    procedure CompileItemClick(Sender: TObject);
    procedure FeuilletsClick(Sender: TObject);
    procedure NmesSpinDownClick(Sender: TObject);
    procedure EditMinMaxKeyPress(Sender: TObject; var Key: Char);
    procedure EditMinMaxExit(Sender: TObject);
    procedure NmesSpinUpClick(Sender: TObject);
    procedure NomEditExit(Sender: TObject);
    procedure NomEditKeyPress(Sender: TObject; var Key: Char);
    procedure UniteEditExit(Sender: TObject);
    procedure TriBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CopierBtnClick(Sender: TObject);
    procedure MajBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure gridVariabExit(Sender: TObject);
    procedure GridParamExit(Sender: TObject);
    procedure gridVariabKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MemoChange(Sender: TObject);
    procedure DelSelectItemClick(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure SimulationChange(Sender: TObject);
    procedure CopierTableauItemClick(Sender: TObject);
    procedure pageNewItemClick(Sender: TObject);
    procedure pageCopyItemClick(Sender: TObject);
    procedure pageCalculeeItemClick(Sender: TObject);
    procedure FileAddItemClick(Sender: TObject);
    procedure ImprimeBtnClick(Sender: TObject);
    procedure DeltaBtnClick(Sender: TObject);
    procedure gridVariabMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure gridVariabMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure gridVariabMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GridParamDblClick(Sender: TObject);
    procedure GridParamGlbDblClick(Sender: TObject);
    procedure gridVariabDblClick(Sender: TObject);
    procedure GridParamMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GridParamGlbKeyPress(Sender: TObject; var Key: Char);
    procedure GridParamMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FeuilletsChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FeuilletsChange(Sender: TObject);
    procedure PhaseItemClick(Sender: TObject);
    procedure TrigoBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure ImporterTraitementsClick(Sender: TObject);
    procedure CollerItemClick(Sender: TObject);
    procedure NmesEditExit(Sender: TObject);
    procedure NmesEditEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PageNewAcqItemClick(Sender: TObject);
    procedure GridParamGlbSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure GridParamGlbExit(Sender: TObject);
    procedure ListeGrandeurClick(Sender: TObject);
    procedure FonctionBtnClick(Sender: TObject);
    procedure ListeGrandeurMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure MajTimerTimer(Sender: TObject);
    procedure NewPageBtnClick(Sender: TObject);
    procedure PageNewSimulItemClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure FonctionBtnMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CopyGridBtnClick(Sender: TObject);
    procedure CopyParamBtnClick(Sender: TObject);
    procedure TriPageBtnClick(Sender: TObject);
    procedure AddPageBtnClick(Sender: TObject);
    procedure ListConstanteUnivClick(Sender: TObject);
    procedure ListConstanteUnivMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure ConstanteTabSheetShow(Sender: TObject);
    procedure PlusBtnClick(Sender: TObject);
    procedure RazBtnClick(Sender: TObject);
    procedure RandomBtnClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure GrecBtnClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure MemoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CopierItemClick(Sender: TObject);
    procedure gridVariabGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure GridParamGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure GridParamGlbGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure GridParamSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure gridVariabDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure gridVariabSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure CalcPythonBtnClick(Sender: TObject);
    procedure cbPyVersionsSelect(Sender: TObject);
    procedure AidePythonBtnClick(Sender: TObject);
    procedure ListeGrandeurPythonClick(Sender: TObject);
    procedure UniteSIBtnClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure PythonEngine1PathInitialization(Sender: TObject;
      var Path: string);
    procedure PythonDllBtnClick(Sender: TObject);
    procedure effaceConsoleBtnClick(Sender: TObject);
    procedure MemoSourceKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PythonInputOutput1SendUniData(Sender: TObject;
      const Data: string);
 private
     triTexte : boolean;
     ColPermise : array[0..1] of TsetGrandeur;
     MesureCourante : integer;
     CompilationEnCours : boolean;
     Recompiler : boolean;
     MajSimulation,MajNmes : boolean;
     colClick,rowClick : longInt;
     oldNmes : integer;
     ErreurCompile : boolean;
     SauveLigne : TstringList;
     SauveLigneCourante : boolean;
     oldSelStart : word;
     PyVersions: TPythonVersions;
     prefixeRegressiPython : string;
     AlertMatplotlib,AlertPyQt : boolean;
     isCaracDecimal : boolean;
     pathPython : string;
     Function FormatGridVariab(Acol,Arow : Integer) : string;
     Function FormatGridConst(Acol,Arow : Integer) : string;
     Function FormatGridConstGlb(Acol,Arow : Integer) : string;
     Procedure NmesSpinClick(Down : boolean);
     Procedure SetValeurVariabCourante;
     Procedure SetValeurConstCourante;
     Procedure SetValeurConstGlbCourante;
     Procedure CompileP;
     Procedure Remplit;
     procedure SetSelectionGridVariab(Acol, Arow : Integer);
     Procedure RecalculIncertitude(index : TcodeGrandeur);
     function  VerifMinMax(Sender: TObject) : boolean;
     Procedure ResetListeGrandeur;
     procedure AfficheDelta;
     procedure MajValeurConstGlb(i : integer);
     procedure AfficheTrigo;
     procedure GenerateMath;
     procedure afficheSI;
     Procedure MajNumeroLigne;
  public
      MajGridVariab : boolean;
      MajWidthsVariab : boolean;
      // MajWidthsConst : boolean;
      prevenirPi : boolean;
      modifPython : boolean;
      procedure WMRegCalcul(var Msg : TWMRegMessage); message WM_Reg_Calcul;
      procedure WMRegMaj(var Msg : TWMRegMessage); message WM_Reg_Maj;
      Procedure SetValeurVariab(c,r : integer;const value : string);
      Procedure SupprimeGrandeurCalc(const anom : string);
      procedure ChangeAngle(isDegre : boolean);
      procedure PassageEnRadian(force : boolean);
      procedure TraceGrid;
      Procedure TraceGridVariab;
      Procedure TraceGridParam;
      procedure EcritConfig;
      procedure LitConfig;
  end;

var
  FValeurs: TFValeurs;

implementation

uses UniteKer, NewVar, clipBrd, fileRRR, varkeyb,
     supprDlg, regdde, regmain, options, fft, graphvar, constante,
     mathml_presentation, filerw3U;

{$R *.DFM}

const
     TabParam = 0;
     TabVariab = 1;
     TabExpressions = 2;
     captionAngle : array[boolean] of string = ('Radian','Degré');
     indexAngle : array[boolean] of integer = (6,11);
     indexAngleGr : array[boolean] of integer = (46,47);
     indexSI : array[boolean] of integer = (27,26);

Function TFValeurs.FormatGridVariab(Acol,Arow : Integer) : string;
var x : double;
    index : integer;
    isPrec : boolean;
begin
    result := '';
    if pageCourante=0 then exit;
    if Acol=0
       then begin
          if triTexte
             then result := pages[pageCourante].texteVar[indexTri,arow-2]
             else result := IntToStr(Arow-2)
       end
       else begin
         dec(Acol);
         isPrec := DeltaBtn.down and (Acol mod 2=1);
         if DeltaBtn.down then Acol := Acol div 2;
         index := indexVariab[Acol];
         if index=grandeurInconnue
            then result := ''
            else if isPrec
                   then with grandeurs[index] do begin
                      if fonct.genreC<>g_texte then begin
                         x := pages[pageCourante].incertVar[index,Arow-2];
                         if isCorrect(x) then result := FormatIncert(x*CoeffAff);
                      end
                   end
                   else with grandeurs[index] do begin
                       if fonct.genreC=g_texte
                          then result := pages[pageCourante].texteVar[index,arow-2]
                          else begin
                              x := pages[pageCourante].valeurVar[index,Arow-2];
                              if isCorrect(x) then result := FormatNombre(x*CoeffAff)
                   end;
            end;// grandeur Connue
       end;// Acol<>0
end;

Function TFValeurs.FormatGridConst(Acol,Arow : Integer) : string;
var x : double;
    index,iParam : integer;
    isPrec : boolean;
begin
    result := '';
    if Arow<2 then exit;
    if Acol=0
       then result := IntToStr(pred(Arow))
       else begin
    isPrec := DeltaBtn.down and (Acol mod 2=0);
    dec(Acol);
    if DeltaBtn.down then Acol := Acol div 2;
    dec(Arow);
    if (Arow<=NbrePages) then if Acol<NbreConst
           then begin
              index := indexConst[Acol];
              if index<>grandeurInconnue then begin
                 if grandeurs[index].fonct.genreC=g_texte
                    then result := pages[Arow].texteConst[index]
                    else if index<=MaxGrandeurs
                       then if isPrec
                           then begin
                              x := pages[Arow].incertConst[index];
                              with grandeurs[index] do
                                   result := formatIncert(x*coeffAff);
                           end
                           else begin
                              x := pages[Arow].valeurConst[index];
                              with Grandeurs[index] do
                                   result := FormatNombre(x*CoeffAff)
                           end;
              end;
           end
           else begin
               iParam := Acol+1-NbreConst;
               if isPrec
                   then begin
                      x := pages[Arow].incertParam[iParam];
                      with Parametres[paramNormal,iParam] do
                          result := formatIncert(x*coeffAff);
                   end
                   else begin
                      x := pages[Arow].valeurParam[paramNormal,iParam];
                      with Parametres[paramNormal,iParam] do
                           result := FormatNombre(x*CoeffAff)
                   end;
           end;
    end
end;

Function TFValeurs.FormatGridConstGlb(Acol,Arow : Integer) : string;
var
    index,iParam : integer;
    isPrec : boolean;
begin
    result := '';
    if Arow<2 then exit;
    isPrec := DeltaBtn.down and ((Acol mod 2)=1);
    if DeltaBtn.down then Acol := Acol div 2;
    if Acol<NbreConstGlb
         then begin
             index := indexConstGlb[Acol];
             if index<>grandeurInconnue
                then with grandeurs[index] do if isPrec
                    then result := formatIncert(incertCourante*CoeffAff)
                    else result := formatNombre(valeurCourante*CoeffAff);
         end
         else begin
             iParam := Acol+1-NbreConstGlb;
             with parametres[paramGlb,iParam] do if isPrec
                then result := FormatIncert(incertCourante*CoeffAff)
                else result := FormatNombre(valeurCourante*CoeffAff)
         end;
end;

procedure TFValeurs.TraceGridVariab;
var CoeffDelta : integer;

Procedure gestionUnitePage;
var Lmaximum,z : double;
    j : integer;
    index,k,colonne : integer;
    modifiable : boolean;
begin with pages[PageCourante] do begin
    if deltaBtn.down then CoeffDelta := 2 else CoeffDelta := 1;
    ColPermise[TabVariab] := [];
    if triTexte
    then GridVariab.colWidths[0] := largeurColonneTexte
    else if nmes<100
       then GridVariab.colWidths[0] := 2*largeurUnCarac
       else if nmes<1000
            then GridVariab.colWidths[0] := 3*largeurUnCarac
       else if nmes<10000
            then GridVariab.colWidths[0] := 4*largeurUnCarac
       else GridVariab.colWidths[0] := 5*largeurUnCarac;
    GridParam.colWidths[0] := 3*largeurUnCarac;
    for k := 0 to pred(NbreVariab) do begin
        index := indexVariab[k];
        colonne := coeffDelta*k+1;
        with grandeurs[index] do begin
           Modifiable := (fonct.genreC=g_experimentale) and
                ((ModeAcquisition in [AcqClavier,AcqFichier,AcqClipBoard]) or
                  DataCanModifiable);
           puissAff := 0;
           CoeffAff := 1;
           if fonct.genreC=g_texte then
              include(ColPermise[TabVariab],colonne);
           if (fonct.genreC=g_equation) or modifiable then
              include(ColPermise[TabVariab],colonne);
           if deltaBtn.down and (incertCalcA.expression='') then
              include(ColPermise[TabVariab],succ(colonne));
           if not modifiable and
               correct and
               not(UniteDonnee) and
               not(UnitePart) and
               (fonct.genreC<>g_texte) and
               not(formatU in [fLongueDuree,fDateTime,fDate,fTime])
             then begin
               Lmaximum := 0;
               for j := 0 to pred(nmes) do begin
                  z := abs(valeurVar[index,j]);
                  if not isNan(z) and (z>Lmaximum) then Lmaximum := z;
               end;
               if (Lmaximum>0) and
                  (nomUnite<>'') and
                  (formatU<>fDefaut) then begin
                  Lmaximum := Lmaximum*1.001;
                  puissAff := 3*floor(log10(Lmaximum)/3);
                  if (puissAff<>0) and (puissance<>0) then
                     puissAff := 3*floor((puissAff+puissance)/3)-puissance;
                  coeffAff := dix(-puissAff);
               end;
         end;
       end
     end;
     if ColPermise[TabVariab]=[]
        then GridVariab.options := GridVariab.options - [goEditing]
        else GridVariab.options := GridVariab.options + [goEditing];
end end;// gestionUnitePage

Procedure AffichePage;
var k,colonne,index,ligne : integer;
    LigneSup : boolean;
begin
      gestionUnitePage;
      LigneSup := (ModeAcquisition in [AcqClavier,AcqFichier,AcqClipBoard]) or
                   DataCanModifiable;
      with GridVariab do begin
  //         defaultRowHeight := hauteurColonne;
           ColCount := NbreVariab*CoeffDelta+1; // 1=numéro
           if majWidthsVariab then
              for k := 0 to pred(NbreVariab) do begin
                  colWidths[k*coeffDelta+1] := filerw3U.largeurColonnesVariab[k];
                  if grandeurs[k].fonct.genreC=g_texte then begin
                     largeurColonneTexte := GridVariab.colWidths[k*coeffDelta+1];
                     GridVariab.colWidths[0] := largeurColonneTexte;
                  end;
              end;
           if LigneSup
                then RowCount := pages[PageCourante].Nmes+3
                else RowCount := pages[PageCourante].Nmes+2;
           if RowCount<=2 then RowCount := 3; // ne devrait pas arriver
           if triTexte
              then begin
                 for ligne := 2 to pred(rowCount) do
                    Cells[0,ligne] := pages[PageCourante].texteVar[indexTri,ligne-2];
                 Cells[0,0] := grandeurs[indexTri].nom;
              end
              else begin
                 for ligne := 2 to pred(rowCount) do
                    Cells[0,ligne] := intToStr(ligne-2);
                 Cells[0,0] := grandeurs[cIndice].nom;
              end;
           for k := 0 to pred(NbreVariab) do begin
               index := indexVariab[k];
               colonne := succ(k*coeffDelta);
               with grandeurs[index] do begin
                  Cells[colonne,0] := titreAff;
                  Cells[colonne,1] := NomAff(PuissAff);
                  if deltaBtn.down then begin
                     Cells[succ(colonne),0] := nomIncertitude;
                     Cells[succ(colonne),1] := Cells[colonne,1];
                  end;
               end;
               for ligne := 0 to pred(pages[PageCourante].nmes) do begin
                   Cells[colonne,ligne+2] := FormatGridVariab(colonne,ligne+2);
                   if DeltaBtn.down then
                      Cells[succ(colonne),ligne+2] := FormatGridVariab(succ(colonne),ligne+2);
               end;
               if LigneSup then begin
                     ligne := pages[PageCourante].nmes+2;
                     if sauveLigneCourante
                        then Cells[colonne,ligne] := SauveLigne[colonne]
                        else Cells[colonne,ligne] := FormatGridVariab(colonne,ligne);
                     if DeltaBtn.down then Cells[succ(colonne),ligne] :=
                               FormatGridVariab(succ(colonne),ligne);
               end;
           end;
           SauveLigneCourante := false;
           SauveLigne.clear;
           col := 1;
           if row>(pages[PageCourante].nmes+2)
              then row := pages[PageCourante].nmes+2
              else if row<2
                 then row := 2;
           GridVariab.visible := Feuillets.ActivePage=VariabSheet;
           MajGridVariab := false;
           MajWidthsVariab := false;
end end; // AffichePage 

begin
   if MajGridVariab then begin
      Screen.Cursor := crHourGlass;
      GridVariab.visible := false;
      TriTexte := grandeurs[indexTri].fonct.genreC=g_texte;
      if (NbreVariab>0) and (pageCourante>0) then affichePage;
      Screen.Cursor := crDefault;
   end;
   RazBtn.visible := (modeAcquisition=AcqClavier);
   DeleteVarBtn.visible := NbreVariabExp>0;
   TriBtn.visible := pages[pageCourante].experimentale;
   TriBtn.hint := htriData;
   DelLinesBtn.visible := true;
//   DeltaBtn.visible := TriBtn.visible;
   AddPageBtn.visible := ModeAcquisition in [AcqClavier,AcqClipBoard,AcqSimulation,AcqCan,AcqFichier];
   case modeAcquisition of
        AcqCan : AddPageBtn.Hint := 'Acquisition par '+ChangeFileExt(ExtractFileName(nomExeAcquisition),'');
        AcqFichier : AddPageBtn.Hint := 'Fusionner un fichier';
        else AddPageBtn.Hint := stNewpage
   end;
   if modeAcquisition=AcqCan
      then AddPageBtn.Hint := stAcqBy+ChangeFileExt(ExtractFileName(nomExeAcquisition),'')
      else AddPageBtn.Hint := stNewPage;
   FRegressiMain.PageAddBtn.hint := AddPageBtn.Hint;
end; // TraceGridVariab

procedure TFValeurs.TraceGridParam;
var CoeffDelta : integer;

Procedure gestionUniteConstantes;
var Lmaximum,z : double;
    p,i : integer;
    index,colonne : integer;
begin
    colPermise[TabParam] := [];
    if deltaBtn.down then CoeffDelta := 2 else CoeffDelta := 1;
    for i := 0 to pred(NbreConst) do begin
        index := indexConst[i];
        colonne := CoeffDelta*i+1;
        with grandeurs[index] do begin
        PuissAff := 0;
        CoeffAff := 1;
        if fonct.genreC=g_texte then
           include(ColPermise[TabParam],colonne);
        if fonct.genreC in [g_experimentale,g_equation] then begin
           include(ColPermise[TabParam],colonne);
           if deltaBtn.down then include(ColPermise[TabParam],succ(colonne));
        end;
        if (fonct.genreC<>g_experimentale) and
           correct and
           not(UniteDonnee) and
           not(UnitePart) and
           not(formatU in [fLongueDuree,fDateTime,fdate,fTime]) then begin
              Lmaximum := 0;
              for p := 1 to NbrePages do begin
                  z := pages[p].valeurConst[index];
                  if not isNan(z) then begin
                     z := abs(z);
                     if z>Lmaximum then Lmaximum := z;
                  end;
              end;
              if (Lmaximum>0) and
                 (nomUnite<>'') and 
                 (formatU<>fDefaut) then begin
                 Lmaximum := Lmaximum*1.001;
                 puissAff := 3*floor(log10(Lmaximum)/3);
                 if (puissAff<>0) and (puissance<>0) then
                     puissAff := 3*floor((puissAff+puissance)/3)-puissance;
                 coeffAff := dix(-puissAff);
              end;
        end; { if }
        end { with }
     end; {for i }
     for i := 1 to NbreParam[paramNormal] do with parametres[paramNormal,i] do begin
        PuissAff := 0;
        CoeffAff := 1;
        Lmaximum := 0;
        for p := 1 to NbrePages do begin
               z := pages[p].valeurParam[paramNormal,i];
               if isCorrect(z) then begin
                  z := abs(z);
                  if (z>Lmaximum) then Lmaximum := z;
               end;
        end;
        if (Lmaximum>0) and
           (formatU<>fDefaut) then begin
            Lmaximum := Lmaximum*1.001;
            puissAff := 3*floor(log10(Lmaximum)/3);
            if (puissAff<>0) and (puissance<>0) then
                puissAff := 3*floor((puissAff+puissance)/3)-puissance;
            coeffAff := dix(-puissAff);
        end;
     end;
end; // gestionUniteConstantes

Procedure AfficheConstantes;
var index,p,i,colonne : integer;
begin with GridParam do begin
      gestionUniteConstantes;
 //     defaultRowHeight := hauteurColonne;
      if (ModeAcquisition=AcqSimulation) and (NbrePages<MaxPages)
          then RowCount := NbrePages+3
          else RowCount := NbrePages+2;
      fixedRows := 2;
      row := 1+pageCourante;
      ColCount := CoeffDelta*(NbreConst + NbreParam[paramNormal])+1;
      (*
      if majWidthsConst then
           for i := 0 to pred(NbreConstExp) do
               colWidths[i*coeffDelta+1] := filerw3U.largeurColonnesConst[i];
      *)
      fixedCols := 1;
      col := 1;
      Cells[0,0] := stPage;
      Cells[0,1] := 'n°';
      for p := 1 to NbrePages do
          Cells[0,succ(p)] := IntToStr(p);
      if (ModeAcquisition=AcqSimulation) and
         (NbrePages<maxPages) then Cells[0,NbrePages+2] := IntToStr(succ(NbrePages));
      for i := 0 to pred(NbreConst) do begin
           index := indexConst[i];
           colonne := CoeffDelta*i+1;
           with grandeurs[index] do begin
              Cells[colonne,0] := nom;
              Cells[colonne,1] := NomAff(PuissAff);
              if deltaBtn.down then begin
                 Cells[succ(colonne),0] := nomIncertitude;
                 Cells[succ(colonne),1] := Cells[colonne,1];
              end;
           end;
           for p := 1 to NbrePages do begin
               Cells[colonne,succ(p)] := FormatGridConst(colonne,succ(p));
               if DeltaBtn.down then
                  Cells[succ(colonne),succ(p)] := FormatGridConst(succ(colonne),succ(p));
           end;
           if (ModeAcquisition=AcqSimulation) and (NbrePages<maxPages) then begin
              Cells[colonne,NbrePages+2] := '';
              if DeltaBtn.down then
                 Cells[succ(colonne),NbrePages+2] := '';
           end;
      end;
      for i := 1 to NbreParam[paramNormal] do with Parametres[paramNormal,i] do begin
          colonne := CoeffDelta*(NbreConst+i-1)+1;
          Cells[colonne,0] := nom;
          Cells[colonne,1] := NomAff(PuissAff);
          if DeltaBtn.down then begin
             Cells[succ(colonne),0] := nomIncertitude;
             Cells[succ(colonne),1] := Cells[colonne,1];
          end;
          for p := 1 to NbrePages do begin
              Cells[colonne,succ(p)] := FormatGridConst(colonne,succ(p));
              if DeltaBtn.down then
                 Cells[succ(colonne),succ(p)] := FormatGridConst(succ(colonne),succ(p));
          end;
      end;
      colonne := CoeffDelta*(NbreConst+NbreParam[paramNormal])+1;
      for p := 0 to pred(rowCount) do begin
          Cells[colonne,p] := '';
          if DeltaBtn.down then
                  Cells[succ(colonne),p] := '';
      end;
      if (ModeAcquisition=AcqSimulation) and (NbrePages<maxPages) then
         for colonne := 0 to pred(colCount) do
             Cells[colonne,pred(rowCount)] := '';
      visible := true;
      //MajWidthsConst := false;
end end;// AfficheConstantes

Procedure AfficheConstGlb;
var index,i,colonne : integer;
    coeffDeltaGlb : integer;
begin with GridParamGlb do begin
 //     defaultRowHeight := hauteurColonne;
      if deltaBtn.down then CoeffDeltaGlb := 2 else CoeffDeltaGlb := 1;
      ColCount := CoeffDeltaGlb*(NbreConstGlb + NbreParam[paramGlb]);
      col := 0;
      row := 2;
      for i := 0 to pred(NbreConstGlb) do begin
           index := indexConstGlb[i];
           colonne := CoeffDeltaGlb*i;
           with grandeurs[index] do begin
                puissAff := 0;
                coeffAff := 1;
                if correct and
                   (nomUnite<>'') and 
                   not(UniteDonnee) and
                   not(UnitePart) and
                   not(formatU in [fLongueDuree,fDateTime,fDate,fTime]) then begin
                      try
                      puissAff := 3*floor(log10(abs(valeurCourante))/3);
                      coeffAff := dix(-puissAff);
                      except
                          puissAff := 0;
                          coeffAff := 1;
                      end;
                end;
                Cells[colonne,0] := nom;
                Cells[colonne,1] := NomAff(PuissAff);
                if deltaBtn.down then begin
                   Cells[succ(colonne),0] := nomIncertitude;
                   Cells[succ(colonne),1] := Cells[colonne,1];
                end;
                Cells[colonne,2] := FormatNombre(valeurCourante*CoeffAff);
                if DeltaBtn.down then
                   Cells[succ(colonne),2] := FormatNombre(incertCourante*CoeffAff);
          end;
      end;
      for i := 1 to NbreParam[paramGlb] do with Parametres[paramGlb,i] do begin
          colonne := CoeffDeltaGlb*(NbreConstGlb+i-1);
          puissAff := 3*floor(log10(abs(valeurCourante))/3);
          coeffAff := dix(-puissAff);
          Cells[colonne,0] := nom;
          Cells[colonne,1] := NomAff(PuissAff);
          Cells[colonne,2] := FormatNombre(valeurCourante*coeffAff);
          inc(colonne);
          if DeltaBtn.down then begin
              Cells[colonne,0] := nomIncertitude;
              Cells[colonne,1] := Cells[pred(colonne),1];
              Cells[colonne,2] := FormatNombre(incertCourante*coeffAff);
          end;
      end;
      visible := true;
end end;// AfficheConstGlb

begin
   GridParam.visible := false;
   if (NbreConst + NbreParam[paramNormal])>0 then afficheConstantes;
   GridParamGlb.visible := false;
   if (NbreConstGlb+NbreParam[paramGlb])>0 then afficheConstGlb;
   TriPageBtn.visible := NbrePages>2;
   TriPageBtn.hint := htriPage;
   DeleteParamBtn.visible := NbreConstExp>0;
//   DeltaParamBtn.visible := ModeAcquisition<>AcqSimulation;
end;// TraceGridParam

procedure TFValeurs.GrecBtnClick(Sender: TObject);
begin
  inherited;
  ClipBoard.Astext := (sender as TspeedButton).caption;
  Memo.PasteFromClipboard;
  Memo.setFocus;
end;

procedure TFValeurs.gridVariabKeyPress(Sender: TObject; var Key: Char);
var FormatCol : TnombreFormat;
    ColTexte,isDegre : boolean;

Procedure GetFormat(colonne : integer);
var k,index : integer;
begin
    k := colonne - 1;
    if deltaBtn.down then k := k div 2;
    if Feuillets.ActivePage.PageIndex=TabVariab
       then index := indexVariab[k]
       else index := indexConst[k];
    if index=grandeurInconnue
       then begin
          formatCol := fDefaut;
          colTexte := false;
          isDegre := false;
       end
       else begin
          formatCol := grandeurs[index].formatU;
          colTexte := grandeurs[index].fonct.genreC=g_texte;
          isDegre := grandeurs[index].nomUnite='°';
       end;
end;

begin with Sender as TstringGrid do begin
    if (pages[pageCourante].experimentale or
        (sender=GridParam)) and
       (col in colPermise[Feuillets.ActivePage.PageIndex]) and
       (row>0)
        then begin
           GetFormat(col);
           if not ColTexte then
              case formatCol of
              fDateTime : if not charinset(key,CaracDateTime) then key := #0;
              fDate : if not charinset(key,CaracDate) then key := #0;
              fTime,fLongueDuree : if not charinset(key,CaracTime) then key := #0;
              else if isDegre and charinset(key,CaracDegre)
                     then pages[pageCourante].TriAfaire := true
                     else begin
                          VerifKeyGetFloat(key);
                           if charinset(key,chiffre) then
                              pages[pageCourante].TriAfaire := true
                      end; { else }
          end;{case}
       end
       else key := #0
end end;

procedure TFValeurs.FermeBtnClick(Sender: TObject);
begin
     WindowState := wsMinimized
end;

procedure TFValeurs.AddBtnClick(Sender: TObject);
var index : integer;
begin
     if feuillets.ActivePage=paramSheet
        then index := iParamExp
        else if feuillets.ActivePage=variabSheet
           then index := iVarExp
           else if feuillets.ActivePage=expSheet
              then index := iFonction
              else index := 0;
     NewVarDlg := TNewVarDlg.Create(self);
     with NewVarDlg do begin
        Initialise(index);
        if NewVarDlg.showModal=mrOK then begin
           if LigneInit<>'' then Memo.Lines.Add(LigneInit);
           if LigneCompile<>'' then Memo.Lines.Add(LigneCompile);
           // grandeur calculée
           if LigneSignif<>'' then Memo.Lines.Add(LigneSignif);
           if NomEdit.text<>'' then ListeGrandeur.Items.Add(NomEdit.text);
           Application.MainForm.perform(WM_Reg_Maj,MajGrandeur,0);
           MajBtn.ImageIndex := 16;
           MajTimer.Enabled := false;
           Recompiler := not ErreurCompile or EulerCB.checked;
           ModifFichier := true;
        end;
     end;
     NewVarDlg.free;
     if Recompiler then Perform(WM_Reg_Calcul,CalculCompile,0);
end; // AddBtn

procedure TFValeurs.TraceGrid;
begin
     if Feuillets.ActivePage=variabSheet then traceGridVariab;
     if Feuillets.ActivePage=paramSheet then traceGridParam;
end;

procedure TFValeurs.DeleteBtnClick(Sender: TObject);
var index : integer;
    Acol : integer;
begin
     MajBtnClick(sender);
     Application.ProcessMessages;
     index := 0;
     if feuillets.ActivePage=paramSheet then begin
         Acol := GridParam.col-1;
         if DeltaBtn.down then Acol := Acol div 2;
         if Acol<=NbreConst then
             index := indexConst[Acol];
     end;
     if feuillets.ActivePage=variabSheet then begin
         Acol := GridVariab.col-1;
         if DeltaBtn.down then Acol := Acol div 2;
         index := indexVariab[Acol];
     end;
     if suppressionDlg=nil then Application.CreateForm(TSuppressionDlg, SuppressionDlg);
     SuppressionDlg.operation := oSuppression;
     SuppressionDlg.nomDefaut := grandeurs[index].nom;
     if SuppressionDlg.showModal=mrOK then begin
        reCompiler := true;
        MajGridVariab := true;
        compileP;
// en particulier les fonctions pouvant contenir la grandeur supprimée
     end;
end; // DeleteBtn

procedure TFValeurs.MemoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (key=VK_Return) and (FregressiMain.KeypadReturn)
       then key := 0;
//  if (key=18) and (ssAlt in shift) then key := ord('^');
  oldSelStart := memo.SelStart;
  isCaracDecimal := key=vk_decimal;
end;

procedure TFValeurs.MemoKeyPress(Sender: TObject; var Key: Char);
var ligneCourante : string;
    indexLigne : integer;
begin
    if key=crCR
    then if FregressiMain.KeyPadReturn
       then begin
           key := #0;
           MajBtnClick(Sender);
       end
       else begin
            // pour avoir le curseur
            indexLigne := Memo.Perform(em_LineFromChar,$FFFF,0);
            if (indexLigne>0) then dec(indexLigne);  // CR a effectué changement de ligne
            ligneCourante := memo.lines[indexLigne];
            if not isLigneComment(ligneCourante) and
               (Pos('=',ligneCourante)=0) then MajValeurConstGlb(indexLigne);
     end
     else if isCaracDecimal and (key=',') then key := '.';
end;

procedure TFValeurs.MemoSourceKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key=ord(crCR) then MajNumeroLigne;
end;

procedure TFValeurs.CompileP;
var i : integer;
    posErreurLigne,posErreur,longErreur : integer;
    indexHelp : integer;

Function ErreurConstante : boolean;
type
    tdepend = (dInit,dFonction,dNone);
var i,j,index : integer;
    depend : Tdepend;
    strErreur : string;
begin
      result := false;
      for i := 0 to pred(NbreConstExp) do with pages[pageCourante] do begin
          index := indexConstExp[i];
          if isNan(valeurConst[index]) then begin
                depend := dNone;
                for j := 0 to pred(NbreGrandeurs) do
                    if index in grandeurs[j].fonct.depend then begin
                       depend := dFonction;
                       if grandeurs[j].fonct.genreC in [g_diff1,g_diff2,g_euler] then
                          depend := dInit;
                       break;
                    end;
                case depend of
                    dInit : strErreur := erInitAdefinir;
                    dNone : strErreur := erConstNonDef;
                    dFonction : strErreur := erParamAdefinir;
                end;
                result := depend<>dNone;
                if result then begin
                   ErreurDetectee := true;
                   AfficheErreur(strErreur,0);
                   Feuillets.ActivePage := ParamSheet;
                   TraceGridParam;
                   GridParam.setFocus;
                   break;
                end;
             end;
      end;       
end; // ErreurConstante

Function ErreurForward : boolean;
var i : integer;
begin
      result := false;
      if ModeAcquisition=AcqSimulation then
         for i := 0 to pred(NbreGrandeurs) do with Grandeurs[i] do
            if fonct.genreC=g_forward then begin
               result := true;
               AfficheErreur(erForward,0);
               erreurDetectee := true;
               break;
            end;
end; // ErreurForward

Function CompileLigneG(NumLigne : integer;
          var posErreur,longErreur : integer) : boolean;
var NomLu : string;
    LigneCourante : string;

Procedure VerifCrochets;
var posOuvre : integer;
begin // identifier z et z[i] ou z[i+1]
        posOuvre := pos('[i]',nomLu);
        if (posOuvre>1) and
           (posOuvre=length(nomLu)-2) then begin
            nomLu := copy(nomLu,1,pred(posOuvre));
            exit;
        end;
        posOuvre := pos('[i+1]',nomLu);
        if (posOuvre>1) and
           (posOuvre=length(nomLu)-4) then result := false;
end;

Procedure VerifValeurInit;
var posOuvre,index : integer;
    newNom : string;
    newAddr : tgrandeur;
    k : char;
begin // z[0]
    for k := '0' to '2' do begin
    posOuvre := pos('['+k+']',nomLu);
    if (posOuvre>1) and
       (posOuvre=length(nomLu)-2) then begin
        newNom := copy(nomLu,1,pred(posOuvre));
        index := IndexNom(newNom);
        if (index<>GrandeurInconnue) and
           (grandeurs[index].fonct.genreC=g_forward) then exit;
        if nomCorrect(newNom,grandeurInconnue) then begin
             newAddr := tgrandeur.Create;
             newAddr.Init(newNom,'','',variable);
             newAddr.fonct.genreC := g_forward;
             ajouteGrandeurE(newAddr);
         end;
    end;
    end;
end;

Procedure VerifLogique;
var ligneMaj : string;
    oper : ToperateurLogique;

procedure ChercheOperateur(op : string);
var posOp : integer;
begin
    op := ' '+op+' ';
    posOp := pos(op,ligneMaj);
    if posOp>0 then begin
       ligneCourante[posOp] := caracLogique;
       ligneCourante[posOp+length(op)-1] := caracLogique;
    end;
end;

begin
   ligneMaj := upperCase(ligneCourante);
   for oper := Low(ToperateurLogique) to High(ToperateurLogique) do
       chercheOperateur(nomOperateurLogique[oper]);
end;

function nomVide : boolean;
begin
    result := nomLu='';
    if result then begin
        longErreur := 1;
        codeErreurC := erNomGrandeurVide;
    end;
end;

var PosEgal : integer;
    expressionLu : string;
    AddrLu : tgrandeur;
    ordreEqua : integer;
    index,k : integer;
    oldNbre : integer;
begin
    PrevenirFonctionDeParam := false;
    ligneCourante := memo.lines[numLigne];
    posErreur := 1;
    longErreur := 1;
    oldNbre := NbreGrandeurs;
    result := true;
    if IsLigneComment(ligneCourante) then exit;
    verifLogique;
    trimComplet(ligneCourante);
    PosEgal := Pos('=',ligneCourante);
    nomLu := copy(ligneCourante,1,pred(posEgal)); // extrait le nom
    trimComplet(nomLu);
    if nomVide then begin // grandeur immediate
        grandeurImmediate.fonct.expression := ligneCourante;
        result := grandeurImmediate.compileG(posErreur,longErreur,0);
        exit;
    end;
    result := false;
    ordreEqua := 0;
    if nomLu[length(nomLu)]='''' then begin
       delete(nomLu,length(nomLu),1);
       if nomVide then exit;
       inc(ordreEqua);
       if nomLu[length(nomLu)]='''' then begin
           delete(nomLu,length(nomLu),1);
           inc(ordreEqua);
           if nomVide then exit;
       end;
    end;
    if nomLu[length(nomLu)]='"' then begin
       delete(nomLu,length(nomLu),1);
       ordreEqua := 2;
       if nomVide then exit;
    end;
    result := true;
    if VerifCreneau(ligneCourante) then memo.lines[numLigne] := ligneCourante;
    if ordreEqua=0 then verifCrochets;
    if not result then begin
       codeErreurC := erIndiceEuler;
       indexHelp :=  HELP_MethodedEulersimulation;
       longErreur := length(nomLu);
       exit;
    end;
    expressionLu := copy(ligneCourante,succ(posEgal),Length(ligneCourante)-posEgal);
    result := NomCorrect(nomLu,grandeurInconnue);
    if not result then begin
         longErreur := length(nomLu);
         exit;
    end;
    index := IndexNom(nomLu);
    if (index<>GrandeurInconnue) and
       (grandeurs[index].fonct.genreC=g_forward)
          then begin
               AddrLu := grandeurs[index];
               AddrLu.fonct.expression := expressionLu;
               while index<pred(NbreGrandeurs) do begin
                     TransfereVariabE(index,index+1);
                     inc(index);
// pour que le calcul d'un sytème se fasse dans l'ordre de définition des fonctions
               end;
          end
          else begin
               AddrLu := tgrandeur.Create;
               AddrLu.Init(nomLu,'',expressionLu,variable);
               ajouteGrandeurE(AddrLu);
          end;
    if AddrLu.compileG(posErreur,longErreur,ordreEqua)
       then VerifValeurInit
       else begin
           result := false;
           posEgal := Pos('=',ligneCourante);
           posErreur := posErreur+posEgal;
           for k := pred(NbreGrandeurs) downto oldNbre do libereGrandeurE(k);
// grandeur créée plus dérivée ou grandeur init éventuelle créée par équa diff
       end;
     if prevenirFonctionDeParam and
        ((numLigne=pred(memo.Lines.count)) or
         (pos(erParamModeleVersExp,memo.Lines[numLigne+1])<=0))
         then memo.Lines.Insert(numLigne+1,''''+erParamModeleVersExp);
end; // CompileLigneG

var posDebutLigne : integer;
    //longueurLigne : integer;
    posEgal : integer;
    ligne : string;
    nomLu : string;
    memoActif,compileOK,pbUnite : boolean;
    oldNbreGrandeurs : integer;
begin // CompileP
     memo.selStart := 1;
     memo.selLength := length(memo.text);
     memo.selAttributes.style := [];

     erreurDetectee := false;
     oldNbreGrandeurs := NbreGrandeurs;
     memoActif := active and (memo=activeControl);
     compilationEnCours := true;
     if MajSimulation
        then MajBtn.ImageIndex := 0
        else MajBtn.ImageIndex := 16;
     MajTimer.enabled := MajSimulation;
     DebutCompileG;
     Screen.Cursor := crHourGlass;
     Self.enabled := false;
     posErreur := 0;
     indexHelp := 0;
     codeErreurC := '';
     compileOK := true;
     while (memo.lines.count>0) and
           (memo.lines[0]='') do memo.lines.delete(0);
     while (memo.lines.count>2) and
           (memo.lines[memo.lines.count-1]='') and
           (memo.lines[memo.lines.count-2]='')
          do memo.lines.delete(memo.lines.count-1);
     i := 0;
     while i<memo.lines.count do begin
         ligne := memo.lines[i];
         if pos('for ',ligne)=1
            then compileOK := compileBoucle(ligne,posErreurLigne,longErreur)
            else if (pos('end',ligne)=1) and
                    ( (length(ligne)=3) or
                      (ligne[4]=';') or
                      (copy(ligne,4,3)='for'))
     // permettre end; end endfor; endfor ...
                 then if ListeBoucle.count>0
                      then compileOK := compileFinBoucle
                      else begin
                         codeErreurC := erFinBoucle;
                         compileOK := false;
                      end
                 else compileOK := compileLigneG(i,posErreurLigne,longErreur);
         if compileOK
            then posErreur := posErreur + length(ligne) + 1 // 1=CR+LF
            else begin
                 posErreur := posErreur + posErreurLigne;
                 break;
            end;
         inc(i);   
     end; // for memo.lines
     if compileOK then for i := 0 to pred(NbreGrandeurs) do
         if grandeurs[i].fonct.genreC=g_forward then
            codeErreurC := erForward;
     finCompileG;
     afficheTrigo;
     ResetListeGrandeur;
     Screen.Cursor := crDefault;
     MajGridVariab := true;
     self.enabled := true;
     recompiler := false;
     compilationEnCours := false;
     if compileOK
        then begin
          ErreurCompile := false;
          if NbreGrandeurs>FregressiMain.NbreGrandeursSauvees
             then FregressiMain.sauveEtatCourant;
          for i := 0 to pred(memo.lines.count) do begin
              ligne := memo.lines[i];
              PosEgal := Pos('=',ligne);
              if (PosEgal>0) and (ligne[1]<>'''') then begin
                  nomLu := copy(ligne,1,pred(posEgal));
                  trimComplet(nomLu);
               end; // x=expression
          end; // for i
          if uniteSiGlb then begin
             PbUnite := false;
             for i := 0 to pred(NbreGrandeurs) do begin
                 if grandeurs[i].PbUnite then begin
                    PbUnite := true;
                    break;
                 end;
             end;
             if pbUnite then begin
                uniteSIGlb := false;
                afficheSI;
             end;
          end;
          posDebutLigne := 0;
          memo.Lines.BeginUpdate;
          ConstGlbEdit.Lines.BeginUpdate;
          ConstGlbEdit.Lines.Clear;
          ConstGlbEdit.visible := false;
          memo.OnChange := nil;
          memo.selAttributes.style := [];
          for i := 0 to pred(memo.lines.count) do begin
              MajValeurConstGlb(i);
              posDebutLigne := posDebutLigne+length(memo.lines[i])+1; // 1=CR+LF
          end;
          memo.Lines.endUpdate;
          ConstGlbEdit.Lines.endUpdate;
          memo.OnChange := memoChange;
          if memoActif then begin // curseur en fin de mémo
             memo.setFocus;
             Memo.SelStart:=length(text)-1;
             Memo.Perform(EM_SCROLLCARET,0,0);
          end;
          memo.selLength := 0;
          memo.selAttributes.color := clBlack;
          memo.refresh;{??}
          MajTimer.enabled := false;
          MajBtn.ImageIndex := 16;
          if ErreurConstante or ErreurForward then exit;  // ??
          TraceGrid;
          if feuillets.ActivePage=ExpSheet then memo.setFocus;
          modifFichier := modifFichier or (NbreGrandeurs<>oldNbreGrandeurs);
          Application.MainForm.Perform(WM_Reg_Maj,MajGrandeur,0);
          FregressiMain.verifSauvegarde;
          AfficheDelta;
        end
        else begin // erreur not compileOK
             Fvaleurs.setFocus;
             afficheErreur(codeErreurC,indexHelp);
             ErreurDetectee := true;
             memo.show;
             memo.setFocus;
             memo.selStart := pred(posErreur);
             memo.selLength := longErreur;
             memo.selAttributes.color := clRed;
             memo.selAttributes.style := [fsBold,fsUnderLine];
             ErreurCompile := true;
        end;
     Screen.Cursor := crDefault;        
     recompiler := false;
// car modif du format du texte a remis recompiler à true
     RandomBtnBis.visible := bruitPresent;
     RandomItemBis.visible := bruitPresent;
     FgrapheVariab.RandomBtn.Visible := bruitPresent;
end; // CompileP

procedure TFvaleurs.MajValeurConstGlb(i : integer);
var nomLu,ligne : string;
    index,posEgal : integer;
    k : integer;
    posErreur,longErreur : integer;
begin
     ligne := memo.lines[i];
     if isLigneComment(ligne) then exit;
     PosEgal := Pos('=',ligne);
     for k := ConstGlbEdit.lines.count to i do
         ConstGlbEdit.lines.add('');
     if (PosEgal>0)
     then begin
          nomLu := copy(ligne,1,pred(posEgal));
          trimComplet(nomLu);
          index := IndexNom(nomLu);
          if (index<>grandeurInconnue) and
             (grandeurs[index].genreG=ConstanteGlb)
                  then begin // ajouter résultat si constanteGlb
                     ConstGlbEdit.visible := true;
                     with grandeurs[index] do
                        ConstGlbEdit.Lines[i] := FormatNomEtUnite(valeurCourante);;
                  end;
     end
     else with grandeurImmediate do begin // valeur immédiate globale
          fonct.expression := ligne;
          if compileG(posErreur,longErreur,0) then begin
             if not uniteDonnee then SetUnite;
             grandeurs[cIndice].valeurCourante := 0;
             valeurCourante := calcule(fonct.calcul);
             ConstGlbEdit.visible := true;
             ConstGlbEdit.lines[i] := FormatValeurEtUnite(valeurCourante);;
          end;
     end;
end;

procedure TFValeurs.WMRegMaj(var Msg : TWMRegMessage);

procedure AfficheSimulation;
begin
if pageCourante>0 then with pages[pageCourante] do begin
        SimulationBox.visible := true;
        NomEdit.text := grandeurs[0].nom;
        UniteEdit.text := grandeurs[0].nomUnite;
        if isNan(valeurVar[0,0]) or (nmes=0)
          then begin
             MiniSimulation := 0;
             MaxiSimulation := 1;
             LogSimulation := false;
             nmes := 256;
          end
          else begin
             MiniSimulation := valeurVar[0,0];
             MaxiSimulation := valeurVar[0,pred(nmes)];
             MaxiSimulation := MaxiSimulation+(maxiSimulation-miniSimulation)/pred(nmes);
          end;
        AfficheDelta;
     end;
end;

var sRect: TGridRect;
    Acol,Arow : integer;
begin
      case msg.TypeMaj of
          MajChangePage,MajGroupePage,MajSupprPage,MajAjoutPage : begin
             lecturePage := false;
             pages[pageCourante].AffecteVariableP(false);
             MajGridVariab := true;
             if modeAcquisition=AcqSimulation
                 then AfficheSimulation
                 else SimulationBox.visible := false;
             AfficheDelta;
             TraceGrid;
          end;
          MajModele : if Feuillets.ActivePage=ParamSheet then
               TraceGridParam;
          MajFichier : begin
             Feuillets.ActivePage := ExpSheet;
             if (WindowState=wsMinimized) and
                (pageCourante>0) and
                (dispositionFenetre<>dNone) then WindowState := wsNormal;
             AfficheTrigo;
             if modeAcquisition=AcqSimulation
                then AfficheSimulation
                else SimulationBox.visible := false;
             MajSimulation := false;
             Recompiler := false;
             MajTimer.enabled := false;
             MajBtn.ImageIndex := 16;
             if NbrePages>0 then MajBtnClick(nil);
             MajGridVariab := true;
             AfficheDelta;
             afficheSI;
             modifFichier := false;
          end;
          MajVide : begin
              Feuillets.ActivePage := ExpSheet;
              MajGridVariab := true;
              MesureCourante := 0;
              LogBox.checked := false;
              MajTimer.enabled := false;
              MajBtn.ImageIndex := 16;
              Memo.Clear;
           //   MemoSource.Clear;
           //   MemoSource.lines.Add('#Tapez votre code Python ici');
              MajTimer.Enabled := false;
              modifPython := false;
              DeltaBtn.Down := false;
          end;
          MajUnites,MajValeurAcq : MajGridVariab := true;
          MajValeur,MajValeurConst : begin
             MajGridVariab := true;
             if (Feuillets.ActivePage=ParamSheet) and
                FgrapheVariab.AnimBtn.down then traceGridParam;
             FregressiMain.AffValeurParametre;
             AfficheDelta;
          end;
          MajValeurGr : begin // Changement d'origine
             MajGridVariab := true;
             TraceGrid;
          end;
          MajAjoutValeur : ;
          MajPolice : begin
             VerifMemo(memo);
             VerifMemo(constGlbEdit);
          end;
          MajSupprPoints : begin
              MajGridVariab := true;
              TraceGrid;
          end;
          MajPreferences : begin
              ImprimeBtn.visible := imBoutonImpr in menuPermis;
              if Feuillets.ActivePage=variabSheet then begin
                 MajGridVariab := true; // format des nombres
                 traceGridVariab;
              end;
              if Feuillets.ActivePage=paramSheet then
                 traceGridParam;
              mathSheet.TabVisible := useMathPlayer;
              afficheSI;
          end;
          MajUnitesParam : if Feuillets.ActivePage=ParamSheet then begin
                 traceGridParam;
                 if active then GridParam.SetFocus;
          end;
          MajTri : begin
              MajGridVariab := true;
              grandeurs[cDeltat].nom := DeltaMaj+grandeurs[0].nom;
              if Feuillets.ActivePage=VariabSheet then begin
                 traceGridVariab;
                 if active then GridVariab.SetFocus;
              end;
          end;
          MajNumeroMesure : if GridVariab.showing and
                  (feuillets.ActivePage=VariabSheet) and
                  (msg.codeMaj<pages[pageCourante].Nmes) and
                  (msg.codeMaj>=0) then with gridVariab do begin
              MesureCourante := msg.codeMaj;
              MouseToCell(1+colWidths[0],1,Acol,Arow);
              if Acol<0 then col := 0 else col := Acol;
              row := MesureCourante+2;
              Srect.top := row;
              Srect.bottom := row;
              Srect.left := 0;
              Srect.right := pred(colCount);
              selection := Srect;
          end;
          MajIncertitude : ;
          else begin
              MajGridVariab := true;
              MesureCourante := 0;
              traceGrid;
          end;
      end;
end;

procedure TFValeurs.CompileItemClick(Sender: TObject);
begin
     CompileP
end;

Procedure TFvaleurs.SetValeurVariabCourante;
var index,i,ii,posFin : integer;
    vide,isPrec,ajoutValeur : boolean;
    precdx,dx1,dx2 : double;
    precStr : string;
    coeffDelta,colonne : integer;
begin with pages[PageCourante],GridVariab do begin
if (col<1) or (row<2) then exit;
if GridVariab.visible then begin
     if DeltaBtn.down then coeffDelta := 2 else coeffDelta := 1;
     AjoutValeur := false;
     isPrec := deltaBtn.down and (col mod 2=0);
     index := indexVariab[pred(col) div coeffDelta];
     if (index=grandeurInconnue) or (Row<=1) or
        (Cells[col,row]=FormatGridVariab(col,row)) then exit;
     if (grandeurs[index].fonct.genreC=g_texte) then begin
        TexteVar[index,row-2] := cells[col,row];
        exit;
     end;
     if (grandeurs[index].fonct.genreC in [g_experimentale,g_equation]) then begin
           try
           if isPrec
              then incertVar[index,row-2] := GetFloat(Cells[col,row])
              else valeurVar[index,row-2] := GetFloatDate(Cells[col,row],grandeurs[index].formatU);
           if not isPrec and (row=pred(RowCount)) and
              ((ModeAcquisition in [AcqClavier,AcqFichier,AcqClipBoard]) or
                DataCanModifiable) then begin
              vide := false;
              for i := 1 to NbreVariab do begin
                  ii := indexVariab[pred(i)];
                  if (grandeurs[ii].fonct.genreC=g_experimentale) and
                     isNan(ValeurVar[ii,row-2])
                     then vide := true;
              end;
              if not vide and (nmes<MaxMaxVecteur) then begin
                 nmes := nmes+1;
                 ModifFichier := true;
                 if nmes>(NbrePointsSauves+8) then FregressiMain.SauveEtatCourant;
                 AjoutValeur := true;
                 RowCount := nmes+3;
                 Cells[0,row+1] := intToStr(nmes);
                 for i := 0 to pred(NbreVariab) do begin
                     colonne := i*coeffDelta+1;
                     Cells[colonne,row+1] := '';
                     if (ModeAcquisition=AcqClavier) and
                        (nmes>2) and
                        AutoIncrementation then begin
                        precStr := Cells[colonne,row];
                        posFin := pos('E',precStr);
                        if posFin=0
                           then posFin := length(precStr)
                           else dec(posFin);
                        precStr[posFin] := '1';
                        dec(posFin);
                        for ii := 1 to posFin do
                            if charinset(precStr[ii],['1'..'9']) then precStr[ii] := '0';
                        precdX := StrToFloatWin(precStr)/2;
                        ii := indexVariab[i];
                        dx1 := valeurVar[ii,nmes-1]-valeurVar[ii,nmes-2];
                        dx2 := valeurVar[ii,nmes-2]-valeurVar[ii,nmes-3];
                        if abs(dx1-dx2)<precdx then begin
                           valeurVar[ii,nmes] := valeurVar[ii,nmes-1]+dx1;
                           Cells[colonne,row+1] := FormatGridVariab(colonne,row+1);
                           valeurVar[ii,nmes] := GetFloatDate(Cells[colonne,row+1],grandeurs[index].formatU);
                           break;
                         end;
                     end;
                 end;
              end;
           end;
           calculLigne(row-2);
           for i := col to pred(GridVariab.colCount) do
               Cells[i,row] := FormatGridVariab(i,row);
           if isPrec
               then Application.MainForm.Perform(WM_Reg_Maj,MajIncertitude,0)
               else if ajoutValeur
                  then Application.MainForm.Perform(WM_Reg_Maj,MajAjoutValeur,0)
                  else Application.MainForm.Perform(WM_Reg_Maj,MajValeur,0);
           except
              Cells[col,row] := FormatGridVariab(col,row);
              GridVariab.setFocus;
           end;
//           if fonctionGlb then tout recalculer
     end;
     if (ModeAcquisition=AcqSimulation) and (col in colPermise[TabVariab]) then begin
           try
           valeurVar[index,row-2] := GetFloatDate(Cells[col,row],fDefaut);
           if row=pred(RowCount) then begin
              vide := false;
              if not vide and (nmes<MaxMaxVecteur) then begin
                 nmes := nmes+1;
                 ModifFichier := true;
                 if nmes>(NbrePointsSauves+8) then FregressiMain.SauveEtatCourant;
                 AjoutValeur := true;
                 RowCount := nmes+3;
                 for i := 0 to pred(NbreVariab) do begin
                     colonne := i*coeffDelta+1;
                     Cells[colonne,row+1] := '';
                 end;
              end;
           end;
           calculLigne(row-2);
           for i := col to pred(GridVariab.colCount) do
               Cells[i,row] := FormatGridVariab(i,row);
           if ajoutValeur
               then Application.MainForm.Perform(WM_Reg_Maj,MajAjoutValeur,0)
               else Application.MainForm.Perform(WM_Reg_Maj,MajValeur,0);
           except
              Cells[col,row] := FormatGridVariab(col,row);
              GridVariab.setFocus;
           end;
     end;
end;
end end; // SetValeurVariabCourante

Procedure TFvaleurs.SetValeurVariab(c,r : integer;const value : string);
var index : integer;
    isPrec : boolean;
    coeffDelta : integer;
begin
if (c<1) or (r<2) or
   not(c in colPermise[TabVariab]) or
   not GridVariab.visible then exit;
with pages[PageCourante] do begin
     if DeltaBtn.down then coeffDelta := 2 else coeffDelta := 1;
     isPrec := deltaBtn.down and (c mod 2=0);
     index := indexVariab[pred(c) div coeffDelta];
     if index=grandeurInconnue then exit;
     try
     case grandeurs[index].fonct.genreC of
          g_texte : TexteVar[index,r-2] := value;
          g_experimentale,g_equation : if isPrec
              then incertVar[index,r-2] := GetFloat(value)
              else valeurVar[index,r-2] := GetFloatDate(value,grandeurs[index].formatU);
     end;
     except
     end;
end end; // SetValeurVariab

Procedure TFValeurs.RecalculIncertitude(index : TcodeGrandeur);
var p : TcodePage;
    k : integer;
begin
     for p := 1 to NbrePages do with pages[p] do begin
         affecteVariableP(false);
         affecteConstParam(false);
         for k := index to pred(NbreGrandeurs) do
             calculIncertG(k);
     end;
     MajGridVariab := true;
     Application.MainForm.Perform(WM_Reg_Maj,MajIncertitude,0);
end;

Procedure TFValeurs.SetValeurConstCourante;
var index,i,ii : integer;
    p : integer;
    valeur : double;
    vide,addPage,isPrec : boolean;
    coeffDelta : integer;
    creation : boolean;
begin with GridParam do begin
     if DeltaBtn.down then CoeffDelta := 2 else CoeffDelta := 1;
     if (col<1) or (col>CoeffDelta*NbreConst) or (row<2) or
        not(GridParam.visible)
            then exit;
     if Cells[col,row]=FormatGridConst(col,row) then exit;
     isPrec := DeltaBtn.down and (col mod 2=0);
     index := indexConst[pred(col) div coeffDelta];
     p := row-1;
     AddPage := (ModeAcquisition=AcqSimulation) and (p=NbrePages+1);
     if AddPage then begin
        if not ajoutePage then exit;
        pages[p].nmes := pages[1].nmes;
        pages[p].maxiSimulation := pages[1].maxiSimulation;
        pages[p].miniSimulation := pages[1].miniSimulation;
        copyVecteur(pages[p].valeurVar[0],pages[1].valeurVar[0]);
        if p<maxPages then begin
           rowCount := rowCount+1;
           Cells[0,row+1] := IntToStr(p+1);
           for i := 1 to pred(ColCount) do Cells[i,row+1] := '';
           col := 1;
        end;
     end;
     Creation := false;
     case grandeurs[index].fonct.genreC of
         g_texte : begin
            pages[p].texteConst[index] := Cells[col,row];
            pages[p].valeurConst[index] := 0;
         end;
         g_experimentale,g_equation : begin
           try
           valeur := GetFloatDate(Cells[col,row],grandeurs[index].formatU);
           if isPrec
              then pages[p].incertConst[index] := valeur
              else begin
                  creation := isIncorrect(pages[p].valeurConst[index]);
                  pages[p].valeurConst[index] := valeur;
              end;
           cells[col,row] := FormatGridConst(col,row);
           vide := false;
           for i := 0 to pred(NbreConst) do begin
               ii := indexConst[i];
               if (grandeurs[ii].fonct.genreC=g_experimentale) and
                  isIncorrect(pages[p].ValeurConst[ii])
                     then vide := true;
           end;
           creation := creation and not vide and erreurDetectee;
           if creation
              then CompileP
              else begin
           if not vide then begin
               MajGridVariab := true;
               pages[p].recalculP;
             // Reconstruire les unités : exposants ?
               for i := 0 to pred(GridParam.colCount) do
                   Cells[i,succ(p)] := FormatGridConst(i,succ(p));
           end;
           if AddPage
              then Application.MainForm.Perform(WM_Reg_Maj,MajAjoutPage,0)
              else Application.MainForm.Perform(WM_Reg_Maj,MajValeurConst,0);
           end;
           except
               on E:EGetFloatError do if E.message='chaine vide'
                 then begin
                    Cells[col,row] := '';
                    if grandeurs[index].fonct.genreC in [g_experimentale,g_equation] then
                      if isPrec
                         then pages[p].incertConst[index] := Nan
                         else pages[p].valeurConst[index] := Nan;
                 end
                 else Cells[col,row] := FormatGridConst(col,row);
               else Cells[col,row] := FormatGridConst(col,row);
               setFocus;
           end;
        end;// experimentale
     end;{ case }
end end; // SetValeurConstCourante

Procedure TFValeurs.SetValeurConstGlbCourante;
var valeur : double;
    index : integer;
begin with GridParamGlb do begin
     if (row=2) and deltaBtn.down and
        ((col mod 2)=1) and (col<NbreConstGlb*2) and
        (Cells[col,row]<>FormatGridConst(col,row)) then begin
           try
           index := indexConstGlb[col div 2];
           valeur := GetFloat(cells[col,row]);
           grandeurs[index].incertCourante := valeur;
           MajGridVariab := true;
           recalculIncertitude(index);
           except
               Cells[col,row] := FormatGridConstGlb(col,row);
               setFocus;
           end;
     end;
end end; // SetValeurConstGlbCourante

procedure TFValeurs.FeuilletsClick(Sender: TObject);
begin
    if pageCourante=0 then exit;
    with pages[pageCourante] do if modifiedP then begin
       RecalculP;
       MajGridVariab := true;
    end;
    traceGrid;
end;

procedure TFValeurs.NmesSpinClick(Down : boolean);
var Lnombre : integer;
const ChangeNmes125 = false;
begin
     LNombre := StrToInt(NmesEdit.Text);
     if ChangeNmes125
        then begin
             LNombre := valeur125(LNombre,down);
             if LNombre>20000 then LNombre := 20000;
             if LNombre<5 then LNombre := 5;
        end
        else begin
           if Down then LNombre := LNombre div 2 else LNombre := 2*LNombre;
           if LNombre<8 then LNombre := 8;
           if LNombre>MaxMaxVecteur then LNombre := MaxMaxVecteur;
        end;
     NmesEdit.Text := IntToStr(LNombre);
     MajNmes := true;
     SimulationChange(nil);
     VerifMinMax(nil);
end;

procedure TFValeurs.NmesSpinDownClick(Sender: TObject);
begin
     NmesSpinClick(true)
end;

procedure TFValeurs.NmesSpinUpClick(Sender: TObject);
begin
     NmesSpinClick(false)
end;

procedure TFValeurs.EditMinMaxKeyPress(Sender: TObject; var Key: Char);
begin
     if key=crCR
        then begin
           if verifMinMax(Sender)
              then MajBtnClick(sender);
           key := #0;
        end
        else if key<>crTab
             then VerifKeyGetFloat(key)
end;

procedure TFValeurs.effaceConsoleBtnClick(Sender: TObject);
begin
    MemoResultat.Lines.Clear;
end;

procedure TFValeurs.EditMinMaxExit(Sender: TObject);
begin
     if VerifMinMax(sender)
        then MajBtnClick(sender)
        else with Sender as Tedit do SetFocus
end;

function TFValeurs.VerifMinMax(Sender: TObject) : boolean;
var dt : double;
    N : integer;
begin
     result := true;
     try
     with pages[pageCourante] do begin
        if sender=MaxiEdit
           then maxiSimulation := GetFloat(MaxiEdit.text);
        if sender=miniEdit
           then miniSimulation := GetFloat(MiniEdit.text);
        if (sender=NmesEdit) or MajNmes then begin
            N := StrToInt(NmesEdit.text);
            N := abs(N);
            if N<16 then N := 16;
            Nmes := N;
            MajNmes := false;
        end;
        if sender=MiniEdit then begin
           valeurVar[0,0] := miniSimulation;
           if maxiSimulation<=miniSimulation
              then maxiSimulation := 2*miniSimulation;
           if maxiSimulation=miniSimulation
              then maxiSimulation := 1;
        end;
        if sender=MaxiEdit then begin
           if maxiSimulation<=miniSimulation
              then miniSimulation := maxiSimulation/2;
           if maxiSimulation=miniSimulation
              then miniSimulation := -1;
           valeurVar[0,pred(Nmes)] := maxiSimulation-(maxiSimulation-miniSimulation)/nmes;
        end;
        if sender=DeltaEdit then begin
            dt := GetFloat(DeltaEdit.text);
            dt := abs(dt);
            N := round((maxiSimulation-miniSimulation)/dt);
            if N<16 then N := 16;
            Nmes := N;
            MaxiSimulation := MiniSimulation+dt*N;
        end;
     end;// with pageCourante
     afficheDelta;
     SimulationChange(nil);
     except
         result := false
     end;
end;

procedure TFValeurs.NomEditExit(Sender: TObject);
begin
    if NomCorrect(NomEdit.text,0)
       then begin
          grandeurs[0].nom := NomEdit.Text;
          if not LogSimulation then begin
              grandeurs[cDeltat].nom := deltaMaj+NomEdit.Text;
              DeltaLabel.Caption := grandeurs[cDeltat].nom;
          end;    
          if MajTimer.enabled then MajBtnClick(sender)
       end
       else begin
            afficheErreur(codeErreurC,0);
            NomEdit.setFocus;
       end;
end;

procedure TFValeurs.NomEditKeyPress(Sender: TObject; var Key: Char);
begin
     case key of
        crCR,crTab : begin
             NomEditExit(Sender);
             key := #0
        end;
        crEsc : NomEdit.Text := grandeurs[0].nom;
        crSupprArr : ;
        else if not isCaracGrandeur(key) then key := #0;
     end;
end;

procedure TFValeurs.UniteEditExit(Sender: TObject);
begin
       grandeurs[0].NomUnite := UniteEdit.text;
       if pos('°', grandeurs[0].nomUnite)>0 then changeAngle(true);
       if pos('rad', grandeurs[0].nomUnite)>0 then changeAngle(false);
       if not grandeurs[0].correct and
          not OKReg(OkUniteInconnue,HELP_Unites) then
              UniteEdit.setFocus;
end;

procedure TFValeurs.UniteSIBtnClick(Sender: TObject);
var modif : boolean;
begin
     Modif := OKreg(OkUniteSI[uniteSIGlb],0);
     if modif then begin
        uniteSIGlb := not uniteSIGlb;
        PostMessage(handle,WM_Reg_Calcul,CalculCompile,1);
        afficheSI;
     end;
end;

procedure TFValeurs.TriBtnClick(Sender: TObject);
var index : integer;
begin
     if feuillets.activePage=paramSheet then begin
          triPageBtnClick(sender);
          exit;
     end;
     if suppressionDlg=nil then Application.CreateForm(TSuppressionDlg, SuppressionDlg);
     SuppressionDlg.operation := oTriVariable;
     index := grandeurInconnue;
     if feuillets.activePage=variabSheet then begin
        index := gridVariab.col-1;
        if DeltaBtn.down then index := index div 2;
        index := indexVariab[index];
     end;
     if index=grandeurInconnue then exit;
     SuppressionDlg.nomDefaut := grandeurs[index].nom;
     if SuppressionDlg.showModal=mrOK then traceGrid;
end;

procedure TFValeurs.FormCreate(Sender: TObject);
begin
   inherited;
   SauveLigne := TstringList.create;
   SauveLigneCourante := false;
   compilationEnCours := false;
   grandeursPC.activePage := grandeursTS;
   oldNmes := 0;
   MajGridVariab := true;
   MesureCourante := 0;
   Recompiler := false;
   MajSimulation := false;
   prevenirPi := true;
   AlertMatplotlib := true;
   AlertPyQt := true;
   perform(WM_REG_MAJ,MajPolice,0);
   ResizeButtonImagesforHighDPI(self);
   GridVariab.defaultColWidth := largeurUnCarac*8;
   GridParam.defaultColWidth := GridVariab.defaultColWidth;
   GridParamGlb.defaultColWidth := GridVariab.defaultColWidth;
end;  // formCreate

procedure TFValeurs.CopierBtnClick(Sender: TObject);
begin
     formDDE.RazRTF;
     formDDE.AjouteMemo(memo);
     formDDE.EnvoieRTF;
end;

procedure TFValeurs.CopierItemClick(Sender: TObject);
begin
  Memo.CopyToClipBoard
end;

procedure TFValeurs.Remplit;
var p,Nbre : integer;
    MiniSimul,MaxiSimul : double;
begin
     compilationEnCours := true;
     MajTimer.enabled := false;
     MajBtn.ImageIndex := 16;
     Nbre := StrToInt(NmesEdit.Text);
     try
     MiniSimul := GetFloat(MiniEdit.Text);
     except
     MiniSimul := pages[pageCourante].valeurVar[0,0];
     end;
     try
     MaxiSimul := GetFloat(MaxiEdit.Text);
     except
     MaxiSimul := pages[pageCourante].valeurVar[0,pred(pages[pageCourante].nmes)];
     MaxiSimul := MaxiSimul+(maxiSimul-miniSimul)/pred(pages[pageCourante].nmes);
     end;
     if pagesIndependantesCB.checked
        then with pages[pageCourante] do begin
           numero := pageCourante;
           nmes := Nbre;
           maxiSimulation := maxiSimul;
           miniSimulation := miniSimul;
        end
        else for p := 1 to NbrePages do with pages[p] do begin
           numero := p;
           nmes := Nbre;
           maxiSimulation := maxiSimul;
           miniSimulation := miniSimul;
        end;
     logSimulation := logBox.checked;
     MajSimulation := false;
     if recompiler
        then CompileP
        else begin
           if pagesIndependantesCB.checked
              then begin
                   pages[pageCourante].recalculP;
                   pages[pageCourante].changeAdresse := false
              end
              else for p := 1 to NbrePages do begin
                   pages[p].recalculP;
                   pages[p].changeAdresse := false;
              end;
              Application.MainForm.Perform(WM_Reg_Maj,MajValeur,0);
        end;
     compilationEnCours := false;
     MajNmes := false;
end;

procedure TFValeurs.WMRegCalcul(var msg : TWMRegMessage);
begin
      case msg.typeMaj of
           calculRemplit : remplit;
           calculCompile : compileP;
      end;
end;

procedure TFValeurs.MajBtnClick(Sender: TObject);
begin
  Memo.visible := true;
  if (sender=RazItem) or (sender=MajBtn) or (sender=nil)
    then compileP
    else if MajSimulation
       then Remplit
       else if ReCompiler
           then CompileP
           else begin
               if bruitPresent then RandomBtnClick(sender);
               MajTimer.enabled := false;
           end;
end; // Mise à jour


procedure TFValeurs.HelpBtnClick(Sender: TObject);
begin
    Aide(602)   { TODO : aide syntaxe }
end;

procedure TFValeurs.gridVariabExit(Sender: TObject);
begin
     if pageCourante=0 then exit;
     setValeurVariabCourante;
end;

procedure TFValeurs.gridVariabGetEditText(Sender: TObject; ACol, ARow: Integer;
  var Value: string);
begin
    if Arow>1 then value := FormatGridVariab(Acol,Arow)
end;

procedure TFValeurs.GridParamExit(Sender: TObject);
begin
     setValeurConstCourante
end;

procedure TFValeurs.gridVariabKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var i : integer;
    oldN : integer;
begin
if (key=vk_delete) and (sender=GridVariab) then
      with GridVariab.selection do
         if (top<bottom) or (right>left)
            then begin
                DelSelectItemClick(nil);
                key := 0;
            end;
if (key=vk_down) and
   (sender=GridVariab) and
   (GridVariab.row=pred(GridVariab.rowCount)) then
          setValeurVariabCourante;
if key=vk_return then begin
       if sender=GridParam then with GridParam do begin
          oldN := NbrePages;
          setValeurConstCourante;
  // if oldN<>NbrePages alors setValeurConst a affecté col
          if oldN<>NbrePages then begin
             row := row+1;
             editorMode := true;
             exit;
          end;
 //  colonne exp suivante
          for i := succ(GridParam.col) to pred(colCount) do
              if i in colPermise[TabParam] then begin
                 col := i;
                 editorMode := true;
                 exit;
              end;
       end;
       if sender=GridParamGlb then setValeurConstGlbCourante;
       if sender=GridVariab then with GridVariab do begin
          oldN := pages[pageCourante].nmes;
          setValeurVariabCourante;
          if (oldN<>pages[pageCourante].Nmes) and ((row+1)<rowCount) then begin
             col := 1;
             row := row+1;
             exit;
          end;
 // colonne exp suivante
          for i := succ(col) to pred(colCount) do
              if i in colPermise[TabVariab] then begin
                 col := i;
                 exit;
              end;
// if pas de colonne alors début ligne suivante
          if (row+1)<rowCount then begin
             row := row+1;
             for i := 1 to col do
                if i in colPermise[TabVariab] then begin
                   col := i;
                   break;
                end;
          end;
       end;
    end;
end;

procedure TFValeurs.MemoChange(Sender: TObject);
begin
     if (pageCourante=0) or
         LectureFichier or
         LecturePage then exit;
     MajBtn.ImageIndex := 0;
     MajTimer.enabled := true;
     Recompiler := true;
end;

procedure TFValeurs.DelSelectItemClick(Sender: TObject);
var j,k : integer;
begin
      if not OKreg(OkDelData,0) then exit;
      if ModeAcquisition=AcqClavier then with GridVariab do begin
         k := pred(rowCount);
         SauveLigne.clear;
         for j := 0 to pred(colCount) do
             SauveLigne.Add(Cells[j,k]);
         SauveLigneCourante := true;
      end;
      with GridVariab.selection do
         Pages[pageCourante].SupprimeLignes(top-2,bottom-2);
      Application.MainForm.Perform(WM_Reg_Maj,MajAjoutValeur,0);
      MajGridVariab := true;
      traceGridVariab;
      ModifFichier := true;
end;

procedure TFValeurs.FormDeactivate(Sender: TObject);
begin
                if not compilationEnCours and
        MajTimer.enabled and
        (pageCourante>0) then
         MajBtnClick(sender);
      if Feuillets.ActivePage=VariabSheet then
         GridVariabExit(Sender);
end;

procedure TFValeurs.SimulationChange(Sender: TObject);
begin
     MajSimulation := true;
     MajBtn.enabled := true;
     MajBtn.ImageIndex := 0;
     MajTimer.enabled := true;
     DeltaEdit.enabled := not LogBox.checked;
end;

procedure TFValeurs.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  ClipBoard.Astext := (sender as TspeedButton).caption;
  Memo.PasteFromClipboard;
  Memo.setFocus;
end;

procedure TFValeurs.CopierTableauItemClick(Sender: TObject);
begin
     if feuillets.ActivePage=paramSheet
        then CopyParamBtnClick(sender)
        else //  if feuillets.ActivePage=variabSheet then
            CopyGridBtnClick(sender)
end;

procedure TFValeurs.pageNewItemClick(Sender: TObject);
begin
     FregressiMain.PageAddClick(Sender)
end;

procedure TFValeurs.pageCopyItemClick(Sender: TObject);
begin
     FregressiMain.PageCopyItemClick(Sender)
end;

procedure TFValeurs.pageCalculeeItemClick(Sender: TObject);
begin
     FregressiMain.PageCalculerItemClick(Sender)
end;

procedure TFValeurs.FileAddItemClick(Sender: TObject);
begin
     FRegressiMain.FileAddItemClick(sender)
end;

procedure TFValeurs.ImprimeBtnClick(Sender: TObject);
var
  i,bas : integer;
begin
    screen.cursor := crHourGlass;
    enabled := false;
    Printer.Orientation := poPortrait;
    Printer.BeginDoc;
    try
    bas := 0;
    DebutImpressionTexte(bas);
    ImprimerLigne(DateToStr(Now)+'  '+NomFichierData,bas);
    for i := 0 to pred(Memo.Lines.Count) do
        ImprimerLigne(Memo.Lines[i],bas);
    if (NbrePages>1) and
       ((NbreConst+NbreParam[paramNormal])>0) then begin
          TraceGridParam;
          ImprimerGrid(GridParam,bas);
    end;
    if pages[pageCourante].nmes<60
      then begin if OKreg(OkImprTabVariab,0) then begin
             MajGridVariab := true;
             TraceGridVariab;
             ImprimerGrid(GridVariab,bas);
           end;
      end
      else afficheErreur(erGrandTableau,0);
    finally
        printer.endDoc;
        screen.cursor := crDefault;
        enabled := true;
    end;
end;

procedure TFValeurs.DeltaBtnClick(Sender: TObject);
begin
     if sender=DeltaParamBtn
        then DeltaBtn.down := DeltaParamBtn.down
        else DeltaParamBtn.down := DeltaBtn.down;
     MajGridVariab := true;
     if deltaBtn.Down then avecEllipse := true;
     TraceGrid;
end;

procedure TFValeurs.gridVariabMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     GridVariab.MouseToCell(X,Y,colClick,RowClick);
     SetSelectionGridVariab(colClick,rowClick);
end;

procedure TFValeurs.gridVariabMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var colUp,rowUp : longInt;
begin
     GridVariab.MouseToCell(X,Y,colUp,RowUp);
     setSelectionGridVariab(colUp,rowUp);
end;

procedure TFValeurs.gridVariabSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
     if (Acol<>gridVariab.col) or (Arow<>gridVariab.row) then
        setValeurVariabCourante;
     if ACol in colPermise[tabVariab]
        then GridVariab.Options:=GridVariab.Options+[goEditing]
        else GridVariab.Options:=GridVariab.Options-[goEditing];
end;

procedure TFValeurs.gridVariabMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var Acol,Arow : longInt;
    index : integer;
begin
     GridVariab.MouseToCell(X,Y,Acol,ARow);
     if ssLeft in Shift
       then SetSelectionGridVariab(Acol,Arow)
       else if Arow<2
            then begin
                GridVariab.hint := hRowUnit;
                if Acol>0 then begin
                  dec(Acol);
                  if DeltaBtn.down then Acol := Acol div 2;
                  index := indexVariab[Acol];
                  if (index<Nbrevariab) and (grandeurs[index].fonct.expression<>'')
                     then GridVariab.hint := hRowUnit+' ; '+grandeurs[index].fonct.expression;
                end;
                GridVariab.cursor := crHandPoint
            end
            else begin
               if Acol in ColPermise[TabVariab]
                 then GridVariab.hint := hGrid
                 else GridVariab.hint := '';
               GridVariab.cursor := crDefault
            end;
end;

procedure TFValeurs.SetSelectionGridVariab(Acol, Arow : Integer);
var SRect: TGridRect;
begin with Srect do
     if (Acol=colClick) and (Arow=rowClick)
       then begin
          if (colClick>0) and (Arow<2) then begin
              top := 2;
              bottom := pred(GridVariab.rowCount);
              left := colClick;
              right := colClick;
          end
          else if (colClick=0) and (Arow>2) then begin
              top := rowClick;
              bottom := rowClick;
              left := 1;
              right := GridVariab.colCount;
          end
          else exit; // sélection de cellule
       end
       else begin
          if Arow>rowClick
             then begin
                top := rowClick;
                bottom := Arow
             end
             else begin
                top := Arow;
                bottom := rowClick
             end;
          if top<2 then top := 2;
          if bottom<top then exit;
          left := 1;
          right := GridVariab.colCount;
     end;
     gridVariab.selection := srect;
     gridVariab.update;
end;

procedure TFValeurs.GridParamDblClick(Sender: TObject);
var iParam,Acol : integer;
begin
     if ((rowClick=0) or (rowClick=1)) and
        (colClick>0) then begin
       { modif du nom, de l'unité et du format }
        modifDlg := TmodifDlg.create(self);
        Acol := pred(colClick);
        if DeltaBtn.down then Acol := Acol div 2;
        if Acol<NbreConst
           then modifDlg.index := indexConst[Acol]
           else begin
              iParam := Acol+1-NbreConst;
              modifDlg.index := ParamToIndex(paramNormal,iParam);
              modifDlg.grandeurModif := Parametres[paramNormal,iParam];
           end;
        if modifDlg.showModal=mrOk then begin
            traceGridParam;
            resetListeGrandeur;
        end;
        modifDlg.free
     end;
end;

procedure TFValeurs.GridParamGetEditText(Sender: TObject; ACol, ARow: Integer;
  var Value: string);
begin
    if (Arow>1) then value := FormatGridConst(Acol,Arow);
end;

procedure TFValeurs.GridParamGlbDblClick(Sender: TObject);
var iParam,Acol : integer;
begin
    if (rowClick=0) or (rowClick=1) then begin
     // modif du nom, de l'unité et du format
    modifDlg := TmodifDlg.create(self);
    Acol := colClick;
    if DeltaBtn.down then Acol := Acol div 2;
    if Acol<NbreConstGlb
       then modifDlg.index := indexConstGlb[Acol]
       else begin
            iParam := Acol-NbreConstGlb+1;
            modifDlg.index := ParamToIndex(paramGlb,iParam);
            modifDlg.grandeurModif := Parametres[paramGlb,iParam];
       end;
       if modifDlg.showModal=mrOk then begin
           traceGridParam;
           resetListeGrandeur;
       end;
       modifDlg.free;
     end;
end;

procedure TFValeurs.gridVariabDblClick(Sender: TObject);
var Acol : integer;
begin
     if ((rowClick=0) or
        (rowClick=1)) and (colClick<>0) then begin
      // modif du nom, de l'unité et du format
        modifDlg := TmodifDlg.create(self);
        Acol := pred(colClick);
        if DeltaBtn.down then Acol := Acol div 2;
        modifDlg.index := indexVariab[Acol];
        if modifDlg.showModal=mrOk then begin
              MajGridVariab := true;
              if colClick=1 then definitGrandeurFrequence;
              if modifDlg.modification then compileP;
              traceGridVariab;
              resetListeGrandeur;
        end;
        modifDlg.free;
        // défaire GridVariab.Selection du à mouseup ?
     end;
end;

procedure TFValeurs.gridVariabDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
  var dim : integer;
begin
   if (Arow=0) and (Acol>0) then begin
        dec(Acol);
        if DeltaBtn.down then begin
           if (Acol mod 2)=1 then exit;
           Acol := Acol div 2;
        end;
        if not FichierTrie and (indexVariab[Acol]=indexTri) then begin
          // Indication de icone tri
          GridVariab.canvas.Brush.Style := bsSolid;
          GridVariab.canvas.Brush.Color := clRed;
          dim := Screen.PixelsPerInch div 12;
          with rect do
               GridVariab.Canvas.Ellipse(right-dim,top,right,top+dim);
        end;
   end;
end;

procedure TFValeurs.GridParamMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     (sender as TstringGrid).MouseToCell(X,Y,colClick,RowClick)
end;

procedure TFValeurs.GridParamMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var Acol,Arow : longInt;
begin with sender as tStringGrid do begin
     MouseToCell(X,Y,Acol,ARow);
     if Arow<2
        then begin
            hint := hRowUnit;
            GridParam.cursor := crHandPoint;
        end
        else begin
           if Acol in ColPermise[TabParam]
              then hint := hGrid
              else hint := '';
            GridParam.cursor := crDefault;
        end;
end end;

procedure TFValeurs.GridParamSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
   if (Acol<>GridParam.col) or (Arow<>gridParam.row) then
        setValeurConstCourante;
     if ACol in colPermise[tabParam]
        then GridParam.Options:=GridParam.Options+[goEditing]
        else GridParam.Options:=GridParam.Options-[goEditing];
end;

procedure TFValeurs.FeuilletsChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
     AllowChange := pageCourante<>0;
     if AllowChange and
        not compilationEnCours and
        (feuillets.ActivePage=expSheet) and
        majTimer.enabled then majBtnClick(sender)
end;

procedure TFValeurs.FeuilletsChange(Sender: TObject);

function verifPython : boolean;
var Py3264Glb : boolean;
    Py3264 : boolean;
    PyVersion : TPythonVersion;
begin
       result := true;
       if cbPyVersions.items.count = 0 then begin
          PyVersions := GetRegisteredPythonVersions;
          py3264Glb := false;
          for PyVersion in PyVersions do begin
               {$IFDEF Win32}
               py3264 := pos('64',PyVersion.DisplayName)>0;
               {$ELSE}
               py3264 := pos('32',PyVersion.DisplayName)>0;
               {$ENDIF}
               if not py3264 then cbPyVersions.Items.Add(PyVersion.DisplayName);
               py3264Glb := py3264Glb or py3264;
          end;
          if cbPyVersions.Items.Count > 0 then
              cbPyVersions.ItemIndex := 0;
          cbPyVersions.enabled := cbPyVersions.Items.Count > 1;
          if cbPyVersions.enabled
              then PythonVersionLabel.caption := 'Choix Python version :'
              else PythonVersionLabel.caption := 'Version de Python :';
          if cbPyVersions.Items.Count=0 then begin
             if Py3264Glb
                 then begin
                   {$IFDEF Win32}
                   PythonVersionLabel.caption := 'Python 64 bits (32 nécessaire)';
                   {$ELSE}
                   PythonVersionLabel.caption := 'Python 32 bits (64 nécessaire)';
                   {$ENDIF}
                 end
                 else PythonVersionLabel.caption := 'Python non trouvé ; installer une distribution 32 bits';
              result := false;
          end;
       end;
end;

Var tabs: Array [0..8] of Integer;
    i : integer;
//    nom0 : string;
begin
    if (feuillets.ActivePage=paramSheet) or (feuillets.ActivePage=variabSheet) then traceGrid;
    if feuillets.ActivePage = mathSheet then generateMath;
    if feuillets.ActivePage = PythonTS then begin
       NumerolIgneMemo.Font.Height := Screen.PixelsPerInch div 6;
       MemoSource.Font.Height := Screen.PixelsPerInch div 6;
       PythonEngine1.FatalAbort := false;
       PythonEngine1.DllPath := PythonDllDir;
       MajNumeroLigne;
       try
       if not(PythonEngine1.autoLoad) and
          not(PythonEngine1.isHandleValid) then PythonEngine1.LoadDll;
       except
          {$IFDEF Win32}
          afficheErreur('Python non trouvé ; installer une distribution 32 bits',0);
          {$ELSE}
          afficheErreur('Python non trouvé ; installer une distribution 64 bits',0);
          {$ENDIF}
          feuillets.activePage := expSheet;
          exit;
       end;
       if not verifPython then begin
          feuillets.activePage := expSheet;
          exit;
       end;
       (*
       if (memoSource.lines.Count=0) or (pos('#Tapez',memoSource.lines[0])>0) then begin
          if memoSource.lines.Count>0 then memoSource.Lines.Delete(0);
          nom0 := 'R.'+grandeurs[0].nom;
          memoSource.lines.Add('import Regressi as R');
          memoSource.lines.Add('import numpy as np');
          memoSource.lines.Add('from pylab import *');
          memoSource.lines.Add('import serial');
          memoSource.lines.Add('arduino = serial.Serial()');
          memoSource.lines.Add('arduino.port = "COM4"');
          memoSource.lines.Add('arduino.baudrate = 9600');
          memoSource.lines.Add('arduino.open()');
          memoSource.lines.Add('# ce qui suit est un exemple de création de grandeurs w,u et cte');
          memoSource.lines.Add('# X et C ne sont pas transmis à Regressi (pas de préfixe R.)');
          memoSource.lines.Add('N = len('+nom0+')');
          memoSource.lines.Add('for i in range(0,N,1):');
          memoSource.lines.Add(#9+'valeur = arduino.readline()');
          memoSource.lines.Add(#9+'valeur = valeur.decode(''utf-8'')');
          memoSource.lines.Add(#9+'valeurV = float(valeur)');
          memoSource.lines.Add(#9+'R.z[i] = valeurV');
          memoSource.lines.Add('arduino.close()');
          memoSource.lines.Add('X = np.linspace(-np.pi, np.pi, N)');
          memoSource.lines.Add('C = np.cos(X)');
          memoSource.lines.Add('plot(X,C,''go-'',label=''cos''),plot(X,S)');
          memoSource.lines.Add('axis()');
          memoSource.lines.Add('show()');
          memoSource.lines.Add('R.cte=0');
          memoSource.lines.Add('for i in range(0,N,1) :');
          memoSource.lines.Add(#9+'R.w[i] = 2*'+nom0+'[i]');
          memoSource.lines.Add(#9+'R.cte += '+nom0+'[i]');
          memoSource.lines.Add(#9+'R.u[i] = C[i]');
          memoSource.lines.Add('print(R.cte)');
       end;
       *)
       for i := 0 to 8 do tabs[i] := 4 * 4 * (1+i); // 4 caractères de tabulation
       {$IFDEF Win32}
       MemoSource.Perform(EM_SETTABSTOPS, 9, LongInt(@tabs));
       {$ELSE}
       MemoSource.Perform(EM_SETTABSTOPS, 9, Int64(@tabs));
       {$ENDIF}
       MemoSource.Refresh;
    end;
end;

procedure TFValeurs.PhaseItemClick(Sender: TObject);
var index : integer;
begin
     if suppressionDlg=nil then Application.CreateForm(TSuppressionDlg, SuppressionDlg);
     SuppressionDlg.operation := oPhase;
     index := pred(GridVariab.col);
     if DeltaBtn.down then index := index div 2;
     index := indexVariab[index];
     SuppressionDlg.nomDefaut := grandeurs[index].nom;
     if SuppressionDlg.showModal=mrOK then begin
        MajGridVariab := true;
        traceGridVariab;
     end;
end;

procedure TFValeurs.CalcPythonBtnClick(Sender: TObject);

// modules de base :
// sys,  time, math, array, cmath, itertools, mmap,  errno
// nt,  marshal, winreg, zipimport,  msvcrt, zlib,  binascii, atexit,  audioop,
// ultibytecodec, xxsubtype, gc, builtins, parser,  faulthandler

var indexPython,indexPythonConst : TsetGrandeur;

Procedure ConstruireIndexPython; // récupére les grandeurs Python déjà créées par "z=Python"
var i,index : integer;
begin
     indexPython := [];
     indexPythonConst := [];
     construireIndex;
     for i := 0 to pred(NbreVariab) do begin
         index := indexVariab[i];
         if (grandeurs[index].fonct.genreC=g_PythonVar) then
              include(indexPython,i);
     end;
     for i := 0 to pred(NbreConst) do begin
         index := indexConst[i];
         if (grandeurs[index].fonct.genreC=g_PythonConst) then
                include(indexPythonConst,i);
     end;
end;

function ajoutNomPython(const Anom,ligne : string;posDebut : integer;genreC : TgenreCalcul) : boolean;
var index : integer;
    presenceReg : boolean;
begin
      index := indexNom(Anom);
      presenceReg := copy(ligne,posDebut-Length(prefixeRegressiPython)+1,Length(prefixeRegressiPython))=prefixeRegressiPython;
      if presenceReg
         then begin
             result := (index = GrandeurInconnue);
             if not result and (grandeurs[index].fonct.genreC<>genreC) then
                 showMessage(erVarPythonExists);
         end
         else result := false
end;

procedure verifCreation; // récupére les grandeurs Python non déjà créées
var i,index : integer;
    ligne : string;
    nomPython : string;
    posCarac,posDebut,pos2Points,posEgal : integer;
begin
    for i := 0 to pred(memoSource.lines.Count) do begin
        ligne := memoSource.lines[i];
        posCarac := pos('=',ligne);
        posEgal := pos('==',ligne);
        if (posCarac>1) and (posCarac<>posEgal) then begin
           pos2Points := pos(':',ligne);
           repeat
              dec(posCarac);
           until (posCarac=pos2Points) or isCaracGrandeur(ligne[posCarac]) or (ligne[posCarac]=']');
           ligne := copy(ligne,pos2Points+1,posCarac-pos2Points);
           posCarac := length(ligne);
           if isCaracGrandeur(ligne[posCarac]) then begin // parametre
                posDebut := posCarac;
                repeat dec(posDebut)
                until (posDebut=0) or not isCaracGrandeur(ligne[posDebut]);
                nomPython := copy(ligne,posDebut+1,posCarac-posDebut);
                if ajoutNomPython(nomPython,ligne,posDebut,g_PythonConst) then begin
                       index := creerPythonConst(nomPython);
                       if (index<>GrandeurInconnue) then
                           memo.Lines.add(grandeurs[index].nom+'='+grandeurs[index].fonct.expression);
                end;
           end
           else begin
                posCarac := pos('[',ligne);
                if posCarac<1 then continue;
                posDebut := posCarac-1;
                while (posDebut>0) and isCaracGrandeur(ligne[posDebut]) do dec(posDebut);
                nomPython := copy(ligne,posDebut+1,posCarac-posDebut-1);
                if ajoutNomPython(nomPython,ligne,posDebut,g_pythonVar)
                   then begin
                      index := creerPythonVar(nomPython);
                      if (index<>GrandeurInconnue) then
                         memo.Lines.add(grandeurs[index].nom+'='+grandeurs[index].fonct.expression);
                   end;
                end;
           end;
    end;
end;

procedure verifMatplotlib;
var i : integer;
    ligne : string;
    posCarac : integer;
begin
    for i := 0 to pred(memoSource.lines.Count) do begin
        ligne := memoSource.lines[i];
        posCarac := pos('show()',ligne);
        if (posCarac>0) then begin
           showMessage(stMatplotlibBloc);
           AlertMatplotlib := false;
           break;
        end;
        posCarac := pos('PyQt',ligne);
        if (posCarac>0) then begin
           showMessage(stPyQtBloc);
           AlertPyQt := false;
           break;
        end;
    end;
end;

function ChercheRegressi : boolean;
var i : integer;
    ligne : string;
    posCarac,posFin : integer;
begin
    result := false;
    PrefixeRegressiPython := '';
    for i := 0 to pred(memoSource.lines.Count) do begin
        ligne := memoSource.lines[i];
        if length(ligne)<2 then continue; // ligne vide
        if ligne[1]='#' then continue; // commentaire
        posCarac := pos(stRegressi,ligne);
        result := posCarac>0;
        if result then begin
           posCarac := pos('*',ligne);
           if posCarac=0 then begin
              posCarac := pos('as',ligne);
              if posCarac>0 then begin
                 inc(posCarac,2);
                 while (posCarac<length(ligne)) and (ligne[posCarac]=' ') do inc(posCarac);
                 posFin := posCarac;
                 while (posFin<=length(ligne)) and isCaracGrandeur(ligne[posFin]) do inc(posFin);
                 PrefixeRegressiPython := copy(ligne,posCarac,posFin-posCarac);
              end;
           end
           else showMessage(stImportEtoile);
           break;
        end;
    end;
    if prefixeRegressiPython='' then prefixeRegressiPython := stRegressi;
    prefixeRegressiPython := prefixeRegressiPython+'.';
    resetListeGrandeur;
end;

function CalculerPage(p : integer) : boolean;
var i,j : integer;
    index : integer;
    Anom : AnsiString;
    aConstante,V : Variant;
    ComArray : array of Variant;
begin with pages[p] do begin
   setLength(ComArray,NbreVariab);
   for i := 0 to pred(NbreVariab) do begin
      ComArray[i] := VarArrayCreate([0, nmes-1], varDouble);
      index := indexVariab[i];
      Anom := AnsiString(grandeurs[index].nom);
      if i in indexPython
        then for j := 0 to pred(nmes) do
          ComArray[i][j] := 0
        else for j := 0 to pred(nmes) do
          ComArray[i][j] := valeurVar[index,j];
      PythonModule1.SetVarFromVariant(Anom, ComArray[i]);
   end;
   for i := 0 to pred(NbreConst) do begin
      index := indexConst[i];
      Anom := AnsiString(grandeurs[index].nom);
      if i in indexPythonConst
         then AConstante := 0.1
         else AConstante := valeurConst[index];
      PythonModule1.SetVarFromVariant(Anom, Aconstante);
   end;
   for i := 0 to pred(NbreConstGlb) do begin
      index := indexConstGlb[i];
      Anom := AnsiString(grandeurs[index].nom);
      AConstante := grandeurs[index].valeurCourante;
      PythonModule1.SetVarFromVariant(Anom, Aconstante);
   end;
   try
   PythonEngine1.ExecStrings(MemoSource.Lines);
   except
      ShowMessage(erPython);
      result := false;
      exit
   end;
   for i := 0 to pred(NbreVariab) do if i in indexPython then begin
       index := indexVariab[i];
       V := PythonModule1.GetVarAsVariant(AnsiString(grandeurs[index].nom));
       for j := 0 to pred(nmes) do
           valeurVar[index,j] :=  double(V[j]);
   end;
   for i := 0 to pred(NbreConst) do if i in indexPythonConst then begin
        index := indexConst[i];
        V := PythonModule1.GetVarAsVariant(AnsiString(grandeurs[index].nom));
        valeurConst[index] := double(V);
        if (p=pageCourante) then
           grandeurs[index].valeurCourante := valeurConst[index];
   end;
   ComArray := nil;
   result := true;
end end;

var p : integer;
begin // CalcPythonBtnClick
   MajNumeroLigne;
   modifPython := true;
   if not chercheRegressi then MessageDlg(stPythonRegressi,mtError,[mbOK],0);
   VerifCreation;
   if AlertMatplotlib then verifMatplotlib;
   construireIndexPython;
   try
   if calculerPage(pageCourante) then begin
      majGridVariab := true;
      for p := 1 to NbrePages do
          if (p<>pageCourante) then calculerPage(p);
   end;
   except
      ShowMessage('Problème Python non prévu !');
   end;
end; // CalcPythonBtnClick

procedure TFValeurs.cbPyVersionsSelect(Sender: TObject);
begin
  // Destroy Python for Delphi components
  FreeAndNil(PythonEngine1);
  FreeAndNil(PythonModule1);

 // TPythonEngine
  PythonEngine1 := TPythonEngine.Create(Self);
  PyVersions[cbPyVersions.ItemIndex].AssignTo(PythonEngine1);
  PythonEngine1.IO := PythonInputOutput1;

// TPythonModule
  PythonModule1 := TPythonModule.Create(Self);
  PythonModule1.Name := 'PythonModule1';
  PythonModule1.Engine := PythonEngine1;
  PythonModule1.ModuleName := ansiString(stRegressi);

  PythonEngine1.LoadDll;
end;

procedure TFValeurs.ChangeAngle(isDegre : boolean);
var i : integer;
begin
       if AngleEnDegre=isDegre then exit;
       AngleEnDegre := isDegre;
       AfficheTrigo;
       recalculE;
       MajGridVariab := true;
       for i := 0 to pred(NbreGrandeurs) do with grandeurs[i] do
           if fonct.genreC<>g_experimentale then setRadianDegre;
       TraceGrid;
       Application.MainForm.Perform(WM_Reg_Maj,MajValeur,805);
end;

procedure TFValeurs.TrigoBtnClick(Sender: TObject);
begin
     if OKreg(labelCaptionAngle[not angleEnDegre],0) then ChangeAngle(not AngleEnDegre);
end;

procedure TFValeurs.FormActivate(Sender: TObject);
// var i : integer;
begin
     inherited;
     ImprimeBtn.visible := imBoutonImpr in menuPermis;
     FregressiMain.GrandeursBtn.down := true;
     mathSheet.TabVisible := useMathPlayer;
     (*
     for i := 0 to grec.ControlCount-1 do begin
         if grec.Controls[i] IS TSpeedButton
             then SetFontSpeedButton(grec.Controls[i] as TSpeedButton,PixelsPerInch);
     end;
     for i := 0 to panelOperateurs.ControlCount-1 do begin
         if grec.Controls[i] IS TSpeedButton
             then SetFontSpeedButton(panelOperateurs.Controls[i] as TSpeedButton,PixelsPerInch);
     end;
     *)
     GrandeursPC.Width := 14*largeurUnCarac;
     afficheSI;
end;

procedure TFValeurs.NmesEditExit(Sender: TObject);
var newNmes : integer;
begin
    try
    NewNmes := StrToInt(NmesEdit.Text);
    if oldNmes<>newNmes then begin
        MajNmes := true;
        MajBtnClick(sender)
    end;
    except
    end;
end;

procedure TFValeurs.NmesEditEnter(Sender: TObject);
begin
     try
     oldNmes := StrToInt(NmesEdit.Text);
     except
        oldNmes := 0;
     end;
end;

Procedure TFvaleurs.ResetListeGrandeur;
var i : integer;
begin
     grandeursPC.Width := 14*largeurUnCarac;
     ListeGrandeur.clear;
     ListeGrandeurPython.clear;
     ListeGrandeur.Items.Add(grandeurs[cIndice].nom);
     ListeGrandeur.Items.Add(grandeurs[cNombre].nom);
     ListeGrandeur.Items.Add('['+grandeurs[cIndice].nom+']');
     ListeGrandeur.Items.Add('['+grandeurs[cIndice].nom+'+1]');
     ListeGrandeur.Items.Add('['+grandeurs[cIndice].nom+'-1]');
     if NbreGrandeurs>0 then begin
        ListeGrandeur.Items.Add(grandeurs[0].nom);
        ListeGrandeurPython.Items.Add(prefixeRegressiPython+grandeurs[0].nom);
     end;
     if modeAcquisition=AcqSimulation then
        ListeGrandeur.Items.Add(grandeurs[cDeltat].nom);
     for i := 1 to pred(NbreGrandeurs) do begin
        ListeGrandeur.Items.Add(grandeurs[i].nom);
        if (grandeurs[i].fonct.genreC=g_experimentale) or (modeAcquisition=AcqSimulation) then
           ListeGrandeurPython.Items.Add(prefixeRegressiPython+grandeurs[i].nom);
     end;
     NbreLabel.caption := grandeurs[cNombre].nom;        
end;

procedure TFValeurs.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if ssAlt in Shift then begin
        case key of
             ord('I') : ImprimeBtnClick(nil);
        end;
        exit;
     end;
     if (feuillets.activePage=expSheet) and
        majTimer.enabled and
        (key=vk_f2) then MajBtnClick(sender);
end;

procedure TFValeurs.FormResize(Sender: TObject);
begin
   if windowState=wsmaximized then dispositionFenetre := dMaxi;
end;

procedure TFValeurs.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
     if msg.charCode=vk_delete then
        if DelLinesBtn.visible and
          (Feuillets.activePage=VariabSheet) then
           with GridVariab.selection do
             if (top<bottom) or (right>left)
               then begin
                  DelSelectItemClick(nil);
                  Handled := true;
               end;
     if msg.charCode=vk_F4 then begin
         RandomBtnClick(nil);
         Handled := true;
     end;
end;

procedure TFValeurs.ImporterTraitementsClick(Sender: TObject);
begin
    FRegressiMain.FileCalcItemClick(Sender)
end;

procedure TFValeurs.CollerItemClick(Sender: TObject);
begin
     Memo.PasteFromClipBoard;
end;

procedure TFValeurs.FormDestroy(Sender: TObject);
begin
  SauveLigne.free;
  inherited
end;

procedure TFValeurs.AfficheDelta;
var Nchiffres : integer;
begin
  if ModeAcquisition=AcqSimulation then with pages[pageCourante] do begin
     NmesEdit.text := IntToStr(nmes);
     DeltaEdit.text := FloatToStrF(deltaSimulation,ffGeneral,4,2);
     if logSimulation
         then grandeurs[cDeltat].nom := NomCoeffSimul
         else grandeurs[cDeltat].nom := DeltaMaj+grandeurs[0].nom;
     DeltaLabel.caption := grandeurs[cDeltat].nom;
     FreqEchLabel.caption := stEchantillon+' : '+
           grandeurs[cFrequence].FormatNomEtUnite(1/deltaSimulation);
     NChiffres := round(log10(maxiSimulation/deltaSimulation))+1;
     if NChiffres<4 then NChiffres := 4;
     MiniEdit.text := FloatToStrF(MiniSimulation,ffGeneral,Nchiffres,2);
     MaxiEdit.text := FloatToStrF(MaxiSimulation,ffGeneral,NChiffres,2);
  end;   
end;

procedure TFValeurs.PageNewAcqItemClick(Sender: TObject);
begin
    FormDDE.FocusAcquisition
end;

procedure TFValeurs.GridParamGlbSelectCell(Sender: TObject; ACol, ARow: Integer;
          var CanSelect: Boolean);
begin
     if (Acol<>GridParamGlb.col) or (Arow<>GridParamGlb.row) then
        setValeurConstGlbCourante
end;

procedure TFValeurs.GridParamGlbExit(Sender: TObject);
begin
     setValeurConstGlbCourante
end;

procedure TFValeurs.GridParamGlbGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
    if (Arow=2) then value := FormatGridConstGlb(Acol,2);
end;

procedure TFValeurs.GridParamGlbKeyPress(Sender: TObject; var Key: Char);
begin 
     if (GridParamGlb.row=2) and deltaBtn.down and
        ((GridParamGlb.col mod 2)=1) and (GridParamGlb.col<NbreConstGlb*2)
        then VerifKeyGetFloat(key)
        else key := #0
end;

procedure TFValeurs.ListeGrandeurClick(Sender: TObject);
var caracSuivant : char;
    posC : TPoint;
begin
     ClipBoard.Astext := ListeGrandeur.Items[ListeGrandeur.ItemIndex];
     Memo.PasteFromClipboard;
     Memo.setFocus;
     caracSuivant := Memo.text[Memo.SelStart+Memo.SelLength+1];
     if charinset(caracSuivant,[',',')','*','+','-','/']) then begin
        posC := Memo.CaretPos;
        posC.X := posC.x+1;
        Memo.CaretPos := posC;
       // SendVirtualKey(vk_right);
     end;
end;

procedure TFValeurs.FonctionBtnClick(Sender: TObject);
var syntaxe : string;
    code,i : integer;
    posC : TPoint;
begin
   syntaxe := (sender as TtoolButton).caption;
   code := (sender as TtoolButton).tag;
   if code>0 then syntaxe := syntaxe +'(';
   for i := 2 to code do syntaxe := syntaxe + ',';
   if code>0 then syntaxe := syntaxe + ')';
   ClipBoard.Astext := syntaxe;
   Memo.PasteFromClipboard;
   Memo.setFocus;
   posC := Memo.CaretPos;
   posC.X := posC.x-code;
   Memo.CaretPos := posC;
 //  for i := 1 to code do SendVirtualKey(vk_left);
end;

procedure TFValeurs.ListeGrandeurMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var index,code : integer;
    Laide : string;
begin
  Index := ListeGrandeur.ItemAtPos(Point(X,Y), True);
  Laide := hClicInsere;
  if index>=0 then case index of
     0, 1 : Laide := format(hIndice,[grandeurs[cIndice].nom,grandeurs[cNombre].nom]);
     2,3,4 : Laide := 'x['+grandeurs[cIndice].nom+']'+hEuler
     else begin
          code := indexNom(ListeGrandeur.items[index]);
          Laide := ListeGrandeur.items[index];
          if code<>grandeurInconnue then with grandeurs[code] do begin
               if nomUnite<>'' then Laide := Laide+' ('+nomUnite+') ';
               Laide := Laide+NomGenreGrandeur[genreG]+' ';
               Laide := Laide+NomGenreCalcul[fonct.genreC]+' ';
               Laide := Laide+fonct.expression;
          end;
      end;
  end;
  statusBar.simpleText := Laide;
end;

procedure TFValeurs.ListeGrandeurPythonClick(Sender: TObject);
begin
     ClipBoard.Astext := ListeGrandeurPython.Items[ListeGrandeurPython.ItemIndex];
     MemoSource.PasteFromClipboard;
     MemoSource.setFocus;
end;

procedure TFValeurs.MajTimerTimer(Sender: TObject);
begin
     if MajBtn.imageIndex=0
          then MajBtn.ImageIndex := -1
          else MajBtn.ImageIndex := 0
end;

procedure TFValeurs.NewPageBtnClick(Sender: TObject);
begin
   (sender as TtoolButton).CheckMenuDropdown
end;

procedure TFValeurs.PageNewSimulItemClick(Sender: TObject);
begin
    FRegressiMain.PageNewSimulItemClick(sender)
end;

procedure TFValeurs.ToolButton1Click(Sender: TObject);
var syntaxe : string;
    code,i : integer;
    posC : TPoint;
begin
   syntaxe := (sender as TtoolButton).caption;
   code := (sender as TtoolButton).tag;
   if code>0 then begin
      syntaxe := syntaxe +'(';
      for i := 2 to code do syntaxe := syntaxe + ',';
      syntaxe := syntaxe + ')';
   end;
   ClipBoard.Astext := syntaxe;
   Memo.PasteFromClipboard;
   Memo.setFocus;
   posC := Memo.CaretPos;
   posC.X := posC.x-code;
   Memo.CaretPos := posC;
 //  for i := 1 to code do SendVirtualKey(vk_left);
end;

procedure TFValeurs.FonctionBtnMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
   statusBar.simpleText := (sender as TtoolButton).hint
end;

procedure TFValeurs.CopyGridBtnClick(Sender: TObject);
begin
     formDDE.RazRTF;
     formDDE.AjouteGrid(GridVariab);
     formDDE.EnvoieRTF;
end;

procedure TFValeurs.CopyParamBtnClick(Sender: TObject);
begin
     formDDE.RazRTF;
     formDDE.AjouteGrid(GridParam);
     if GridParamGlb.visible then begin
         formDDE.Editor.lines.Add('');
         formDDE.Editor.lines.Add('');
         formDDE.AjouteGrid(GridParamGlb);
     end;
     formDDE.EnvoieRTF;
end;

procedure TFValeurs.TriPageBtnClick(Sender: TObject);
var index : integer;
begin
     if suppressionDlg=nil then Application.CreateForm(TSuppressionDlg, SuppressionDlg);
     SuppressionDlg.operation := oTriPage;
     index := grandeurInconnue;
     if GridParam.col>0 then begin
          index := gridParam.col-1;
          if DeltaBtn.down then index := index div 2;
          if (index<NbreConst)
             then index := indexConst[index]
             else index := ParamToIndex(paramNormal,1);
          if DeltaBtn.down then index := index div 2;
     end;
     if index=grandeurInconnue then exit;
     SuppressionDlg.nomDefaut := grandeurs[index].nom;
     if SuppressionDlg.showModal=mrOK then traceGrid;
end;

procedure TFValeurs.AddPageBtnClick(Sender: TObject);
begin
     FregressiMain.PageAddBtnClick(Sender)
end;

procedure TFValeurs.ListConstanteUnivClick(Sender: TObject);
var numero : integer;
begin
   numero := ListConstanteUniv.ItemIndex;
   if numero<0 then exit;
   memo.lines.insert(0,ConstanteUnivDlg.exprConstante[numero]);
   memo.lines.insert(0,''''+ConstanteUnivDlg.hintConstante[numero]);
   compileP;
end;

procedure TFValeurs.ListConstanteUnivMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var index : integer;
begin
  Index := ListConstanteUniv.ItemAtPos(Point(X,Y), True);
  if (index>0) and (index<ConstanteUnivDlg.hintConstante.Count) then
     statusBar.simpleText := hClicInsere+' ; '+ConstanteUnivDlg.hintConstante[index];
end;

procedure TFValeurs.ConstanteTabSheetShow(Sender: TObject);
var i : integer;
begin
  ListConstanteUniv.clear;
  for i := 0 to pred(ConstanteUnivDlg.TitreConstante.count) do
      ListConstanteUniv.Items.add(ConstanteUnivDlg.TitreConstante[i]);
end;

procedure TFValeurs.PlusBtnClick(Sender: TObject);
begin
     ClipBoard.Astext := (sender as TspeedButton).hint;
     Memo.PasteFromClipboard;
     Memo.setFocus;
end;

procedure TFValeurs.PythonDllBtnClick(Sender: TObject);
var DllDir : String;
    AllUserInstall: Boolean;
    i : integer;
    trouve : boolean;
begin
  i := 12;
  repeat
      trouve := PythonEngine.IsPythonVersionRegistered('3.'+intToStr(i), DllDir,AllUserInstall);
      if trouve then begin
          MemoResultat.lines.add('Python DLL: '+DllDir+PythonEngine1.DllName);
          MemoResultat.lines.add('Lib and Dlls: '+PathPython);
          break;
      end
      else dec(i)
  until trouve or (i<4);
  if not trouve then
     ShowMessage('Aucune DLL Python (3.4 à 3.12) trouvée')
end;

procedure TFValeurs.PythonEngine1PathInitialization(Sender: TObject;
  var Path: string);
var index,count : integer;
begin
// define the path with the Lib and DLLs folders you have installed.
// Add your own folders that contain your python modules.
// Note that each folder must be separated with a semi-colon (;) in the path string.
   if (pythonDir<>'') then begin
      pythonDir := ';'+pythonDir;
      count := length(pythonDir);
      index := pos(pythonDir,Path);
      while index>0 do begin
         delete(Path,index,count);
         index := pos(pythonDir,Path);
      end;
      Path := Path+pythonDir;
   end;
   PathPython := Path;
end;

procedure TFValeurs.PythonInputOutput1SendUniData(Sender: TObject;
  const Data: string);
begin
     MemoResultat.lines.add(data)
end;

procedure TFValeurs.RandomBtnClick(Sender: TObject);
var posDebutLigne : integer;
    i : integer;
begin
    pages[pageCourante].RecalculP;
    MajGridVariab := true;
    if Feuillets.ActivePage=ParamSheet then TraceGridParam;
    if Feuillets.ActivePage=VariabSheet then TraceGrid;
    if Feuillets.ActivePage=ExpSheet then begin
       posDebutLigne := 0;
       for i := 0 to pred(memo.lines.count) do begin
           MajValeurConstGlb(i);
           posDebutLigne := posDebutLigne+length(memo.lines[i])+2; { +2=CR+LF }
       end;
       Memo.SelStart := posDebutLigne-1;
       Memo.Perform(EM_SCROLLCARET,0,0);
       memo.selLength := 0;
       memo.selAttributes.color := clBlack;
       Memo.Perform(EM_SCROLLCARET,0,0);
//       memo.refresh;
    end;
    Application.MainForm.Perform(WM_Reg_Maj,MajValeur,0);
    MajTimer.enabled := false;
    MajBtn.ImageIndex := 16;
end;

procedure TFValeurs.RazBtnClick(Sender: TObject);
begin
    if OKreg(OkDelAll,0) then begin
       pages[pageCourante].nmes := 0;
       Application.MainForm.Perform(WM_Reg_Maj,MajAjoutValeur,0);
       MajGridVariab := true;
       traceGridVariab;
       ModifFichier := true;
    end;
end;

Procedure TFValeurs.litConfig;
var imax,i : integer;
    zByte : byte;
    zInt : integer;
    lectureOK : boolean;
    choix21 : boolean;
begin
    while (Length(LigneWin)>0) and (ligneWin[1]=symbReg2) do begin
       imax := NbreLigneWin(ligneWin);
       choix21 := pos(stFenetre,ligneWin)<>0;
       lectureOK := true;
       if choix21
           then begin
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
              dispositionFenetre := dNone;
           end
           else for i := 1 to imax do readln(fichier);
       if lectureOK then litLigneWin;
    end;
end; // litConfig

Procedure TFValeurs.ecritConfig;
begin
   if dispositionFenetre=dNone then begin
      writeln(fichier,symbReg2,'5 '+stFenetre);
      writeln(fichier,ord(windowState));
      writeln(fichier,top);
      writeln(fichier,left);
      writeln(fichier,width);
      writeln(fichier,height);
   end;
end;

Procedure TFValeurs.AfficheTrigo;
begin
     TrigoBtn.imageIndex := indexAngle[angleEnDegre];
     TrigoBtn.caption := captionAngle[angleEnDegre];
     TrigoBtnBis.imageIndex := indexAngle[angleEnDegre];
     TrigoBtnBis.caption := captionAngle[angleEnDegre];
     TrigoItem.imageIndex := indexAngle[angleEnDegre];
     TrigoItem.caption := captionAngle[angleEnDegre];

     FGrapheVariab.TrigoBtn.imageIndex := indexAngleGr[angleEnDegre];
     FGrapheVariab.TrigoBtn.caption := captionAngle[angleEnDegre];
     FGrapheVariab.TrigoLabel.caption := labelcaptionAngle[angleEnDegre];
end;

Procedure TFValeurs.AfficheSI;
var AvecCoeff : boolean;
    k : integer;
begin
     UniteSIBtn.imageIndex := indexSI[uniteSIGlb];
     UniteSIBtn.hint := stDebutUniteSI[uniteSIGlb]+stfinUniteSI;
     UniteSIBtnBis.imageIndex := indexSI[uniteSIGlb];
     UniteSIBtnBis.hint := stDebutUniteSI[uniteSIGlb]+stfinUniteSI;
     avecCoeff := false;
     for k := 0 to pred(NbreGrandeurs) do
         if grandeurs[k].coeffSI<>1 then begin
           avecCoeff := true;
           break;
         end;
     UniteSILabelVariab.Visible := avecCoeff and not uniteSIglb;
end;

procedure TFValeurs.BitBtn1Click(Sender: TObject);
const FileName = 'http://www.dessci.com/en/products/mathplayer/';
// 'http://www.mathjax.org/download/';
begin
if ShellExecute(Handle, 'open', PChar(FileName), nil, nil, SW_SHOW) <= 32 then
     ShowMessage(stNoAcces+Filename)
end;

procedure TFValeurs.Button1Click(Sender: TObject);
begin
  inherited;
  feuillets.activePage := expSheet;
  mathSheet.tabVisible := false;
end;

procedure TFValeurs.AidePythonBtnClick(Sender: TObject);
begin
   //  Aide(Help_Python);
     AideStr('Python');
end;

Procedure TFValeurs.SupprimeGrandeurCalc(const anom : string);
var i,posN : integer;
    ligne : string;
begin
     for i := 0 to pred(memo.lines.count) do begin
         ligne := memo.lines[i];
         if (length(ligne)>1) and (ligne[1]<>'''') then begin
            posN := pos(anom,ligne);
            if (posN=1) and (ligne[posN+1]='=') then begin
                memo.Lines.delete(i);
                perform(WM_Reg_Calcul,calculCompile,0);
                break;
            end;
         end;
     end;
end;

procedure TFValeurs.GenerateMath;
var
    i : integer;
    nomFichier : string;
begin
    debutDoc(stRegressi);
    AjouteSection(stGrandeurs);
    for i := 0 to pred(NbreGrandeurs) do
        if (grandeurs[i].fonct.genreC in
            [g_fonction, g_derivee, g_deriveeSeconde,
             g_equation, g_diff1, g_diff2, g_filtrage,
             g_definitionFiltre,g_integrale]) then ajouteGrandeur(i);
    if (NbreModele+NbreFonctionSuper)>0 then begin
    AjouteSection(stModelisation);
    for i := 1 to NbreModele do AjouteModele(fonctionTheorique[i]);
    for i := 1 to NbreFonctionSuper do AjouteModele(fonctionSuperposee[-i]);
    end;
    finDoc;
    nomFichier := TPath.Combine(tempDirReg,'essai.html');
    SaveFile(nomFichier);
    WebBrowser1.Navigate(nomFichier);
end;

procedure TFvaleurs.PassageEnRadian;
begin
      if angleEnDegre then if force
      then begin
         if prevenirPi then afficheErreur(erRadian,0);
         changeAngle(false);
         prevenirPi := false;
      end
      else if prevenirPi then begin
          if OKReg(erVerifRadian,0) then changeAngle(false);
          prevenirPi := false;
      end;
end;

Procedure TFvaleurs.MajNumeroLigne;
var firstLine : integer;
    ligne : integer;
begin
   firstLine := memoSource.perform( EM_GETFIRSTVISIBLELINE, 0 , 0 );
   NumeroLigneMemo.lines.clear;
   for ligne := 0 to MemoSource.Lines.count+1 do
       NumeroLigneMemo.lines.add(intToStr(ligne+firstLine+1));
end;


//how to get both the first and last visible lines in the memo:
(*
firstline := memo1.perform( EM_GETFIRSTVISIBLELINE, 0 , 0 );
lastlineindex := memo1.perform( EM_LINEFROMCHAR, lastlineindex, 0 );
Last line is not as straightforward since there is no message for it.
  procedure lastlinevisible : integer;
  Var
    r: TRect;
    lastvisibleline, lastlineindex: Integer;
  Begin
    memo1.perform( EM_GETRECT, 0, longint( @r ));
    result := memo1.perform( EM_CHARFROMPOS, 0,  MakeLParam( r.left+1, r.bottom-2 ));
  end;
*)

end.


