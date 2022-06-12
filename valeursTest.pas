unit valeursTest;

interface

uses Windows, Classes, Graphics, Forms, Controls, StdCtrls, ShellApi,
  Buttons, ExtCtrls, Grids, sysUtils, Dialogs, Menus, Messages, printers,
  Spin, ComCtrls, ImgList, ToolWin, math, system.IOUtils,
  vcl.HtmlHelpViewer,
  OleCtrls, SHDocVw, Variants,
  system.Types, System.ImageList, system.UITypes,
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
    procedure DeleteBtnClick(Sender: TObject);
    procedure CompileItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MajBtnClick(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure gridVariabMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GridParamMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FeuilletsChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CollerItemClick(Sender: TObject);
    procedure CalcPythonBtnClick(Sender: TObject);
 private
     triTexte : boolean;
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
     isCaracDecimal : boolean;
     pathPython : string;
     LargeurUnCarac : integer;
     HauteurColonne : integer;
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
     function  VerifMinMax(Sender: TObject) : boolean;
     Procedure ResetListeGrandeur;
     procedure GenerateMath;
     procedure afficheSI;
  public
      MajGridVariab : boolean;
      MajWidthsVariab : boolean;
      prevenirPi : boolean;
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

uses clipBrd;

{$R *.DFM}

procedure ResizeButtonImagesforHighDPI(const container: TWinControl);
var
  b : TBitmap;
  i : integer;

 procedure ResizeGlyphSB(const sb : TSpeedButton);
  var
    ng : integer;
  begin
    if sb.Glyph.Empty then ng := 0 else ng := sb.NumGlyphs;
    if ng>0 then begin
      b := TBitmap.Create;
      try
        b.Height := MulDiv(20, Screen.PixelsPerInch, 96);
        b.Width := ng * b.Height;
        b.Canvas.FillRect(b.Canvas.ClipRect);
        b.Canvas.StretchDraw(Rect(0, 0, b.Width, b.Height), sb.Glyph) ;
        sb.Glyph.Assign(b);
      finally
        b.Free;
      end;
    end;
  end; //ResizeGlyphSB

  procedure ResizeGlyphBB(const bb : TBitBtn);
  var
    ng : integer;
  begin
    if bb.Glyph.Empty then ng := 0 else ng := bb.NumGlyphs;
    if ng>0 then begin
      b := TBitmap.Create;
      try
        b.Height := MulDiv(20, Screen.PixelsPerInch, 96);
        b.Width := ng * b.Height;
        b.Canvas.FillRect(b.Canvas.ClipRect);
        b.Canvas.StretchDraw(Rect(0, 0, b.Width, b.Height), bb.Glyph) ;
        bb.Glyph.Assign(b);
      finally
        b.Free;
      end;
    end;
  end; //ResizeGlyphBB

begin
  if Screen.PixelsPerInch = 96 then Exit;

  for i := 0 to -1 + container.ControlCount do begin
     if container.Controls[i] IS TBitBtn then ResizeGlyphBB(TBitBtn(container.Controls[i]));
     if container.Controls[i] IS TSpeedButton then ResizeGlyphSB(TSpeedButton(container.Controls[i]));
     if container.Controls[i] IS TSpinEdit then continue;
     if container.Controls[i] IS TSpinButton then continue;
     if container.Controls[i] is TWinControl then
        ResizeButtonImagesforHighDPI(TWinControl(container.Controls[i]));
  end;

end; // ResizeButtonImagesforHighDPI


const
     TabParam = 0;
     TabVariab = 1;
     TabExpressions = 2;

Function TFValeurs.FormatGridVariab(Acol,Arow : Integer) : string;
begin
end;

Function TFValeurs.FormatGridConst(Acol,Arow : Integer) : string;
begin
end;

Function TFValeurs.FormatGridConstGlb(Acol,Arow : Integer) : string;
begin
end;

procedure TFValeurs.TraceGridVariab;
var CoeffDelta : integer;

Procedure gestionUnitePage;
begin
end;// gestionUnitePage

Procedure AffichePage;
begin
end; // AffichePage

begin
end; // TraceGridVariab

procedure TFValeurs.TraceGridParam;
begin
end;// TraceGridParam

procedure TFValeurs.AddBtnClick(Sender: TObject);
begin
end; // AddBtn

procedure TFValeurs.TraceGrid;
begin
end;

procedure TFValeurs.DeleteBtnClick(Sender: TObject);
begin
end; // DeleteBtn

procedure TFValeurs.CompileP;
begin
end; // CompileP


procedure TFValeurs.CompileItemClick(Sender: TObject);
begin
     CompileP
end;

Procedure TFvaleurs.SetValeurVariabCourante;
begin
end; // SetValeurVariabCourante

Procedure TFvaleurs.SetValeurVariab(c,r : integer;const value : string);
begin
end; // SetValeurVariab

Procedure TFValeurs.SetValeurConstCourante;
begin
end; // SetValeurConstCourante

Procedure TFValeurs.SetValeurConstGlbCourante;
begin
end; // SetValeurConstGlbCourante

procedure TFValeurs.NmesSpinClick(Down : boolean);
begin
end;

function TFValeurs.VerifMinMax(Sender: TObject) : boolean;
begin
end;

procedure TFValeurs.FormCreate(Sender: TObject);
begin
   inherited;
   HauteurColonne := 10 * Screen.PixelsPerInch div 50;
   LargeurUnCarac := HauteurColonne*2 div 3;
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
   ResizeButtonImagesforHighDPI(self);
   GridVariab.defaultColWidth := largeurUnCarac*8;
   GridParam.defaultColWidth := GridVariab.defaultColWidth;
   GridParamGlb.defaultColWidth := GridVariab.defaultColWidth;
end;  // formCreate

procedure TFValeurs.Remplit;
begin
end;

procedure TFValeurs.MajBtnClick(Sender: TObject);
begin
end; // Mise à jour


procedure TFValeurs.gridVariabMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var Acol,Arow : longInt;
    index : integer;
begin
end;

procedure TFValeurs.SetSelectionGridVariab(Acol, Arow : Integer);
begin
end;

procedure TFValeurs.GridParamMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     (sender as TstringGrid).MouseToCell(X,Y,colClick,RowClick)
end;

procedure TFValeurs.FeuilletsChange(Sender: TObject);
begin
    if (feuillets.ActivePage=paramSheet) or (feuillets.ActivePage=variabSheet) then traceGrid;
    if feuillets.ActivePage = mathSheet then generateMath;
    if feuillets.ActivePage = PythonTS then begin
    end;
end;

procedure TFValeurs.CalcPythonBtnClick(Sender: TObject);
begin // CalcPythonBtnClick
end; // CalcPythonBtnClick

procedure TFValeurs.ChangeAngle(isDegre : boolean);
begin
end;

procedure TFValeurs.FormActivate(Sender: TObject);
begin
     inherited;
     mathSheet.TabVisible := true;
     GrandeursPC.Width := 14*largeurUnCarac;
     afficheSI;
end;

Procedure TFvaleurs.ResetListeGrandeur;
begin
end;

procedure TFValeurs.CollerItemClick(Sender: TObject);
begin
     Memo.PasteFromClipBoard;
end;


Procedure TFValeurs.litConfig;
begin
end; { litConfig }

Procedure TFValeurs.ecritConfig;
begin
end;


Procedure TFValeurs.AfficheSI;
begin
end;

Procedure TFValeurs.SupprimeGrandeurCalc(const anom : string);
begin
end;

procedure TFValeurs.GenerateMath;
begin
end;

procedure TFvaleurs.PassageEnRadian;
begin
end;


end.


