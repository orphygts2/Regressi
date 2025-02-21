unit curmodel;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Grids, ImgList, ExtCtrls, ComCtrls, inifiles,
  constreg, regutil, compile, aidekey, System.ImageList, Vcl.VirtualImageList,
  Vcl.BaseImageCollection, Vcl.ImageCollection,
  WinApi.messages;

type
  TCurseurModeleDlg = class(TForm)
    FermeBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Tableau: TStringGrid;
    RazBtn: TBitBtn;
    CopyBtn: TBitBtn;
    TriBtn: TBitBtn;
    LigneCombo: TComboBoxEx;
    ImageCollection1: TImageCollection;
    ImageLigne: TVirtualImageList;
    ColorBox1: TColorBox;
    RaztangenteBtn: TBitBtn;
    procedure FermeBtnClick(Sender: TObject);
    procedure TableauKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure RazBtnClick(Sender: TObject);
    procedure LigneComboClick(Sender: TObject);
    procedure CopyBtnClick(Sender: TObject);
    procedure TriBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ColorBox1Change(Sender: TObject);
    procedure RaztangenteBtnClick(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
  private
    procedure sauveOptions;
    procedure Raz(lr: TsetligneRappel);
  public
    isEquation : boolean;
    ligneXdeY : integer;
  end;

var
  CurseurModeleDlg: TCurseurModeleDlg;

implementation

uses GraphVar, GraphKer, Regdde;

{$R *.DFM}

procedure TCurseurModeleDlg.FermeBtnClick(Sender: TObject);
begin
     sauveOptions;
     Close
end;

procedure TCurseurModeleDlg.TableauKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin with tableau do
     if (LigneRappelCourante in [lrXdeY,lrEquivalence]) and
        (key=vk_return) and (col<2) then begin
         isEquation := col=1;
         ligneXdeY := row;
         FgrapheVariab.calculCurseurModele;
         if row<(rowCount-1) then row := row+1;
         FgrapheVariab.setFocus;
     end;
end;

procedure TCurseurModeleDlg.FormActivate(Sender: TObject);
begin
     inherited;
     if (ligneRappelCourante in [lrXdeY,lrEquivalence])
        then tableau.hint := hValeurModele
        else tableau.hint := '';
     case ligneRappelCourante of
          lrXdeY : if NbreModele>0
               then caption := stValeurModele
               else caption := stValeurReticule;
          lrEquivalence,lrEquivalenceManuelle : caption := stEquivalence;
          lrTangente : caption := stTangente;
          lrReticule : caption := stValeurReticule;
     end;
     if ligneRappelCourante in [lrEquivalence,lrTangente]
           then begin
               LigneCombo.itemIndex := ord(PstyleTangente);
               LigneCombo.hint := hTraitTangente;
               ColorBox1.Selected := PcolorTangente;
           end
           else begin
               LigneCombo.itemIndex := ord(PstyleReticule);
               LigneCombo.hint := hLigneRappel;
               ColorBox1.Selected := PcolorReticule;
           end;
end;

procedure TCurseurModeleDlg.SauveOptions;
var Rini : TMemIniFile;
begin
    try
    Rini := TMemIniFile.create(NomFichierIni);
    try
    Rini.WriteInteger(stPenStyle,stTangente,ord(PstyleTangente));
    Rini.WriteInteger(stColor,stTangente,pcolorTangente);
    Rini.WriteInteger(stColor,stMethTangente,CouleurMethodeTangente);
    Rini.WriteInteger(stPenStyle,stReticule,ord(PstyleReticule));
    Rini.WriteInteger(stColor,stReticule,pcolorReticule);
    Rini.UpdateFile;
    finally
    Rini.free;
    end;
    except
    end;
end;

procedure TCurseurModeleDlg.HelpBtnClick(Sender: TObject);
begin
     Aide(HELP_Modelisation)
end;

procedure TCurseurModeleDlg.Raz(lr: TsetligneRappel);
var p : TcodePage;
    j : integer;
begin
     with FgrapheVariab.graphes[1] do
         if paintBox.Visible then begin
            for p := 1 to maxPages do
            for j := pred(equivalences[p].count) downto 0 do
                if equivalences[p][j].ligneRappel in lr then
                   equivalences[p].remove(equivalences[p][j]);
             PaintBox.refresh;
     end;
     FgrapheVariab.graphes[1].remplitTableauEquivalence;
end;


procedure TCurseurModeleDlg.RazBtnClick(Sender: TObject);
begin
     Raz([lrXdeY,lrX,lrY,lrPente,lrReticule])
end;

procedure TCurseurModeleDlg.RazTangenteBtnClick(Sender: TObject);
begin
     Raz([lrEquivalence,lrEquivalenceManuelle,lrTangente])
end;

procedure TCurseurModeleDlg.LigneComboClick(Sender: TObject);
begin
     if ligneRappelCourante in [lrEquivalence,lrTangente,lrEquivalenceManuelle]
        then PstyleTangente := TpenStyle(LigneCombo.itemIndex)
        else PstyleReticule := TpenStyle(LigneCombo.itemIndex)        
end;

procedure TCurseurModeleDlg.ColorBox1Change(Sender: TObject);
begin
    if ligneRappelCourante in [lrEquivalence,lrTangente,lrEquivalenceManuelle]
        then PcolorTangente := ColorBox1.selected
        else PcolorReticule := ColorBox1.selected
end;

procedure TCurseurModeleDlg.CopyBtnClick(Sender: TObject);
begin
     formDDE.RazRTF;
     formDDE.AjouteGrid(Tableau);
     formDDE.EnvoieRTF;
end;

procedure TCurseurModeleDlg.TriBtnClick(Sender: TObject);
var p : TcodePage;
begin
     for p := 1 to maxPages do
         FgrapheVariab.Graphes[1].equivalences[p].Sort(TriEquivalence);
     FgrapheVariab.graphes[1].PaintBox.refresh;
     FgrapheVariab.graphes[1].remplitTableauEquivalence;
end;

procedure TCurseurModeleDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
var i : integer;
begin
  inherited;
  for i := 0 to pred(FgrapheVariab.graphes[1].equivalences[pageCourante].count) do
      with FgrapheVariab.graphes[1].equivalences[pageCourante][i] do
           if LigneRappel in [lrXdeY,lrX,lrY,lrReticule]
              then commentaire := tableau.cells[2,i+2]
end;

procedure TCurseurModeleDlg.FormCreate(Sender: TObject);
begin
   Tableau.DefaultRowHeight := hauteurColonne;
   ImageLigne.height := VirtualImageListSize;
   ImageLigne.width := VirtualImageListSize;
end;

procedure TCurseurModeleDlg.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
     FgrapheVariab.FormShortCut(Msg,Handled);
     if handled then FgrapheVariab.setFocus;
end;

end.


