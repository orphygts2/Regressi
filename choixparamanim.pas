unit choixparamanim;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, Grids, math,
  constreg, regutil, maths, compile;

type
  TAnimParamDlg = class(TForm)
    ParamGrid: TStringGrid;
    BitBtn1: TBitBtn;
    DesactiveBtn: TBitBtn;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure ParamGridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ParamGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ParamGridGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
  private
  public
  end;

var
  AnimParamDlg: TAnimParamDlg;

implementation

uses Graphvar, Valeurs;

{$R *.DFM}

procedure TAnimParamDlg.FormCreate(Sender: TObject);
begin
     ParamGrid.cells[1,0] := 'Début';
     ParamGrid.cells[2,0] := 'Fin';
     ParamGrid.cells[3,0] := 'Pas';
     ParamGrid.cells[4,0] := 'Actif';
     ParamGrid.cells[5,0] := 'Exp.';
 //    paramGrid.DefaultRowHeight := hauteurColonne;
     paramGrid.colWidths[4] := largeurUnCarac*3;
     paramGrid.colWidths[5] := largeurUnCarac*3;
     //ResizeButtonImagesforHighDPI(self);
end;

procedure TAnimParamDlg.FormActivate(Sender: TObject);
var i : integer;
begin
    inherited;
    ParamGrid.RowCount := NbreParamAnim+1;
    for i := 1 to pred(ParamGrid.rowCount) do
    with paramAnimManuelle[pred(i)] do begin
       ParamGrid.cells[1,i] := FormatReg(debutA);
       ParamGrid.cells[2,i] := FormatReg(finA);
       ParamGrid.cells[3,i] := FormatReg(pasA);
       ParamGrid.cells[0,i] := nomA;
       ParamGrid.cells[4,i] := stOuiNon[active];
       ParamGrid.cells[5,i] := stOuiNon[variationLog];
    end;
end;

procedure TAnimParamDlg.OKBtnClick(Sender: TObject);
var i : integer;
    UnActif : boolean;
begin
    for i := 1 to pred(ParamGrid.rowCount) do
    with paramAnimManuelle[pred(i)] do begin
        try
        DebutA := GetFloat(ParamGrid.cells[1,i]);
        except end;
        try
        FinA := GetFloat(ParamGrid.cells[2,i]);
        except end;
        try
        PasA := GetFloat(ParamGrid.cells[3,i]);
        except end;
        PasA := abs(PasA);
    end;
    UnActif := false;
    for i := 0 to pred(NbreParamAnim) do
        UnActif := UnActif or paramAnimManuelle[i].active;
    if not UnActif then paramAnimManuelle[pred(NbreParamAnim)].active := true;
    for i := 0 to pred(NbreParamAnim) do with paramAnimManuelle[i] do begin
        codeA := indexConstExp[i];
        if variationLog
              then begin
                try
                  DebutA := abs(DebutA);
                  FinA := abs(FinA);
                  VerifMinMaxReal(DebutA,FinA);
                  if pasA<=1 then pasA := 1.05;
                  if (log10(finA/debutA)/log10(pasA))>MaxPasAnim then
                     pasA := power(10,log10(finA/debutA)/MaxPasAnim);
                  if (log10(finA/debutA)/log10(pasA))<4 then
                     pasA := power(10,log10(finA/debutA)/4);
                  except
                     pasA := power(10,2/MaxPasAnim);
                     debutA := finA/100;
                     AfficheErreur(erRemplitLog,0);
                  end;
                  if valeurA<debutA then valeurA := debutA;
                  if valeurA>finA then valeurA := finA;
             end
             else begin { linéaire }
                 VerifMinMaxReal(DebutA,FinA);
                 if (finA-debutA)/pasA>MaxPasAnim
                    then pasA := (finA-debutA)/MaxPasAnim;
                 if (finA-debutA)/pasA<2 then pasA := (finA-debutA)/5;
                 if valeurA<debutA then valeurA := debutA;
                 if valeurA>finA then valeurA := finA;
             end;
       end;
end;

procedure TAnimParamDlg.ParamGridMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var ACol, ARow : Longint;
begin
     ParamGrid.MouseToCell(X,Y,ACol,ARow);
     if (ACol=4) and (ARow>0) then begin
        with paramAnimManuelle[pred(ARow)] do begin
          active := not active;
          ParamGrid.cells[4,ARow] := stOuiNon[active];
        end;
     end;
     if (Acol=5) and (Arow>0) then begin
        with paramAnimManuelle[pred(ARow)] do begin
          variationLog := not variationLog;
          ParamGrid.cells[5,ARow] := stOuiNon[variationLog];
        end;
     end;
end;

procedure TAnimParamDlg.ParamGridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
     CanSelect := (Arow>0) and
        ((ACol=1) or (ACol=2) or (ACol=3))
end;

procedure TAnimParamDlg.ParamGridGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
   if (ACol=4) and (ARow>0) then
       value := stOuiNon[paramAnimManuelle[pred(ARow)].active];
   if (ACol=5) and (ARow>0) then
       value := stOuiNon[paramAnimManuelle[pred(ARow)].variationLog];
end;

end.
