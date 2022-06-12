unit zoomman;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Grids, ExtCtrls, sysUtils, math,
  Vcl.htmlHelpViewer,
  constreg, regutil, maths, compile, graphker;

type
  TZoomManuelDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    MinMaxGrid: TStringGrid;
    AutoTickCB: TCheckBox;
    MemeZeroCB: TCheckBox;
    ZoomAutoBtn: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure MinMaxGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MinMaxGridKeyPress(Sender: TObject; var Key: Char);
    procedure MinMaxGridExit(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure AutoTickCBClick(Sender: TObject);
    procedure ZoomAutoBtnClick(Sender: TObject);
    procedure MinMaxGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure MinMaxGridGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure FormCreate(Sender: TObject);
  private
    X : array[1..4,1..6] of double;
    Ligne : array[TindiceMonde] of integer;
    LigneTemps : integer;
  public
    Echelle : TgrapheReg;
  end;

var
  ZoomManuelDlg: TZoomManuelDlg;

implementation

{$R *.DFM}

procedure TZoomManuelDlg.FormActivate(Sender: TObject);
var m : TindiceMonde;
    ACol,ARow : integer;
    AjouterTemps : boolean;
begin
inherited;
with minMaxGrid do begin
    visible := false;
    Arow := 0;
    Cells[1,0] := stMinimum;
    Cells[2,0] := stMaximum;
    Cells[3,0] := stGrad;
    Cells[4,0] := stSubdiv;
    AutoTickCB.checked  := echelle.autoTick;
    AjouterTemps := true;
    LigneTemps := -1;
    ZoomAutoBtn.visible := echelle.useDefault;
    for m := mondeX to high(TindiceMonde) do with echelle.monde[m] do if defini then begin
       inc(Arow);
       ligne[m] := Arow;
       rowCount := Arow+1;
       if axe<>nil
          then begin
            Cells[0,Arow] := axe.nom;
            AjouterTemps := AjouterTemps and (indexNom(axe.nom)<>0);
          end
          else Cells[0,Arow] := '';
       X[1,Arow] := Mini;
       X[2,Arow] := Maxi;
       X[3,Arow] := deltaAxe*Nticks;
       X[4,Arow] := Nticks;
       case Graduation of
            gLog : begin
                 X[1,Arow] := power(10,X[1,Arow]);
                 X[2,Arow] := power(10,X[2,Arow]);
            end;
            gInv : begin
                 X[1,Arow] := 1/X[1,Arow];
                 X[2,Arow] := 1/X[2,Arow];
            end;
       end; { case }
       for Acol := 1 to 2 do
           Cells[ACol,ARow] := formatReg(X[Acol,Arow]);
       if AutoTickCB.checked
           then begin
              cells[3,ARow] := stAuto;
              cells[4,ARow] := stAuto
           end
           else begin
              cells[3,ARow] := formatReg(X[3,Arow]);
              cells[4,ARow] := intToStr(NTicks);
           end;
    end; { monde }
    if OgPolaire in echelle.OptionGraphe then begin
       Cells[0,1] := stAbscisse;
       Cells[0,2] := stOrdonnee;
    end;
    col := 1;
    row := 1;
    visible := true;
    MemeZeroCB.visible :=
      not(OgAnalyseurLogique in echelle.OptionGraphe) and
      not(OgPolaire in echelle.OptionGraphe);
    MemeZeroCB.checked := OgMemeZero in echelle.OptionGraphe;
    if ajouterTemps then begin
       inc(Arow);
       ligneTemps := Arow;
       rowCount := Arow+1;
       Cells[0,Arow] := grandeurs[0].nom+' (Mod)';
       X[1,Arow] := echelle.MiniTemps;
       X[2,Arow] := echelle.MaxiTemps;
       X[3,Arow] := 0;
       X[4,Arow] := 0;
       for Acol := 1 to 2 do
           Cells[ACol,ARow] := formatReg(X[Acol,Arow]);
       Cells[3,ARow] := '';
       Cells[4,ARow] := '';
    end;
end end;

procedure TZoomManuelDlg.FormCreate(Sender: TObject);
begin
 //  MinMaxGrid.DefaultRowHeight := hauteurColonne;
   ResizeButtonImagesforHighDPI(self);
end;

procedure TZoomManuelDlg.OKBtnClick(Sender: TObject);

Procedure verif(m : TindiceMonde);
var Arow : integer;
begin with echelle.monde[m] do begin
   Arow := ligne[m];
   if abs(x[1,Arow]-x[2,Arow])<(abs(x[1,Arow])+abs(x[2,Arow]))/100 then exit;
   if Graduation=gdB
      then SetMinMaxDefaut(power(10,x[1,Arow]/20),power(10,x[2,Arow]/20))
      else SetMinMaxDefaut(x[1,Arow],x[2,Arow]);
   try
   NTicks := strToInt(MinMaxGrid.cells[4,ARow]);
   except
       NTicks := 2;
   end;
   if NTicks<1 then NTicks := 1;
   if NTicks>5 then NTicks := 5;
   deltaAxe := x[3,Arow]/NTicks;
end end; // verif

var m : TindiceMonde;
begin with echelle do begin
    MinMaxGridExit(nil);
    autoTick := AutoTickCB.checked;
    useDefault := true;
    for m := mondeX to high(TindiceMonde) do begin
        if Monde[m].defini then verif(m);
         Monde[m].zeroInclus := false;
    end;
    if ogOrthonorme in OptionGraphe
       then for m := mondeY to high(TindiceMonde) do with monde[m] do
            if defini then deltaAxe := monde[mondeX].deltaAxe;
    if ligneTemps>0 then begin
       miniTemps := x[1,ligneTemps];
       maxiTemps := x[2,ligneTemps];
    end;
    UseDefault := true;
    if MemeZeroCB.visible then if MemeZeroCB.checked
        then include(echelle.OptionGraphe,OgMemeZero)
        else exclude(echelle.OptionGraphe,OgMemeZero)
end end; // OKBtnClick

procedure TZoomManuelDlg.MinMaxGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if ToucheValidation(key) then with MinMaxGrid do begin
       if (col>0) and (row>0) then begin
           try
           x[col,row] := GetFloat(cells[col,row]);
           except
              cells[col,row] := FloatToStr(x[col,row]);
           end;
     end;
end end;

procedure TZoomManuelDlg.MinMaxGridKeyPress(Sender: TObject;var Key: Char);
begin with MinMaxGrid do
    if (col>0) and (row>0)
        then VerifKeyGetFloat(key)
        else key := #0
end;


procedure TZoomManuelDlg.MinMaxGridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
     MinMaxGridExit(Sender);
     if AutoTickCB.checked
        then CanSelect := Acol<3
        else CanSelect := true
end;

procedure TZoomManuelDlg.MinMaxGridExit(Sender: TObject);
begin with MinMaxGrid do
       if (col>0) and (row>0) then
           try
           x[col,row] := GetFloat(cells[col,row]);
           except
              if col<4
                 then cells[col,row] := FloatToStr(x[col,row])
                 else cells[col,row] := intToStr(round(x[col,row]))
           end;
end;

procedure TZoomManuelDlg.MinMaxGridGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
   if (Acol>0) and (Arow>0) then
         case Acol of
            3 : if AutoTickCB.checked
                  then value := stAuto
                  else value := FormatReg(x[Acol,Arow]);
            4 : if AutoTickCB.checked
                  then value := stAuto
                  else value := intToStr(round(x[Acol,Arow]));
            else value := FormatReg(x[Acol,Arow])
         end;
end;

procedure TZoomManuelDlg.HelpBtnClick(Sender: TObject);
begin
     Aide(812)  { TODO : aide zoom manuel }
end;

procedure TZoomManuelDlg.AutoTickCBClick(Sender: TObject);
var Arow : integer;
    S : String;
begin
     for Arow := 1 to pred(MinMaxGrid.rowCount) do begin
         MinMaxGridGetEditText(sender,3,Arow,S);
         MinMaxGrid.cells[3,Arow] := S;
         MinMaxGridGetEditText(sender,4,Arow,S);
         MinMaxGrid.cells[4,Arow] := S;
     end;
     MinMaxGrid.refresh
end;

procedure TZoomManuelDlg.ZoomAutoBtnClick(Sender: TObject);
begin
     echelle.useDefault := false;
     echelle.autoTick := true;
end;

end.
