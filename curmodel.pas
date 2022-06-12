unit curmodel;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Grids, printers, ImgList, ExtCtrls, ComCtrls,
  constreg, regutil, compile, aidekey, System.ImageList, Vcl.VirtualImageList,
  Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TCurseurModeleDlg = class(TForm)
    FermeBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Tableau: TStringGrid;
    GroupBox1: TGroupBox;
    Memo: TMemo;
    RazBtn: TBitBtn;
    PrintBtn: TBitBtn;
    CopyBtn: TBitBtn;
    TriBtn: TBitBtn;
    LigneCombo: TComboBoxEx;
    ImageCollection1: TImageCollection;
    ImageLigne: TVirtualImageList;
    procedure FermeBtnClick(Sender: TObject);
    procedure TableauKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure RazBtnClick(Sender: TObject);
    procedure PrintBtnClick(Sender: TObject);
    procedure LigneComboClick(Sender: TObject);
    procedure CopyBtnClick(Sender: TObject);
    procedure TriBtnClick(Sender: TObject);
    procedure TableauKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
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
     Close
end;

procedure TCurseurModeleDlg.TableauKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin with tableau do
     if (LigneRappelCourante=lrXdeY) and (key=vk_return) and (col<2) then begin
         isEquation := col=1;
         ligneXdeY := row;
         FgrapheVariab.calculCurseurModele;
         if row<(rowCount-1) then row := row+1;
     end;
end;

procedure TCurseurModeleDlg.FormActivate(Sender: TObject);
begin
     inherited;
     if (ligneRappelCourante=lrXdeY) and (NbreModele>0)
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
           end
           else begin
               LigneCombo.itemIndex := ord(PstyleReticule);
               LigneCombo.hint := hLigneRappel;
           end;
end;

procedure TCurseurModeleDlg.HelpBtnClick(Sender: TObject);
begin
     Aide(HELP_Modelisation)
end;

procedure TCurseurModeleDlg.RazBtnClick(Sender: TObject);
var p : TcodePage;
    i : integer;
begin
     for i := 1 to 3 do if FgrapheVariab.graphes[i].paintBox.Visible then 
     for p := 1 to maxPages do begin
         FgrapheVariab.Graphes[i].equivalences[p].clear;
         FgrapheVariab.graphes[i].PaintBox.refresh;
     end;
     with tableau do begin
         rowCount := 3;
         for i := 0 to 2 do cells[i,2] := '';
     end;
     refresh;
end;

procedure TCurseurModeleDlg.PrintBtnClick(Sender: TObject);
var
  i,bas : Integer;
begin
          try
          DebutImpressionGr(poPortrait,bas);
          for i := 1 to 3 do if FgrapheVariab.graphes[i].paintBox.visible then
              FgrapheVariab.graphes[i].versImprimante(hautGrapheGr,bas);
          debutImpressionTexte(bas);
          for i := 0 to pred(Memo.Lines.Count) do
              ImprimerLigne(Memo.Lines[i],bas);
          ImprimerLigne(Caption,bas);
          for i := 0 to pred(TexteModele.count) do
              if TexteModele[i]<>'' then
                 ImprimerLigne(TexteModele[i],bas);
          ImprimerGrid(Tableau,bas);
          finImpressionGr;
                    except

          end;

end;

procedure TCurseurModeleDlg.LigneComboClick(Sender: TObject);
begin
     if ligneRappelCourante in [lrEquivalence,lrTangente]
        then PstyleTangente := TpenStyle(LigneCombo.itemIndex)
        else PstyleReticule := TpenStyle(LigneCombo.itemIndex)        
end;

procedure TCurseurModeleDlg.CopyBtnClick(Sender: TObject);
begin
     formDDE.RazRTF;
     formDDE.AjouteMemo(memo);
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

procedure TCurseurModeleDlg.TableauKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  (*if (tableau.row>1) and
     ((tableau.col=0) or (tableau.col=1)) then
       VerifKeyGetFloat(key);*)
end;

procedure TCurseurModeleDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
var i : integer;
begin
  inherited;
  for i := 0 to pred(FgrapheVariab.graphes[1].equivalences[pageCourante].count) do
      with FgrapheVariab.graphes[1].equivalences[pageCourante][i] do
           if LigneRappel in [lrXdeY,lrReticule]
              then commentaire := tableau.cells[2,i+2]
end;

procedure TCurseurModeleDlg.FormCreate(Sender: TObject);
begin
 //  Tableau.DefaultRowHeight := hauteurColonne;
   ResizeButtonImagesforHighDPI(self);
end;

end.


