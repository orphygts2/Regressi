unit selColonne;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, sysutils, ExtCtrls, Messages, dialogs,
  compile, CheckLst, ComCtrls,Generics.Collections;

type
  TSelectColonneDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    GrandeursListBox: TCheckListBox;
    CSVCB: TCheckBox;
    ValeursSeulesCB: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
  public
     SelVariab: TList<Integer>;
  end;

var
  SelectColonneDlg: TSelectColonneDlg;

implementation

uses regutil, Regmain;

{$R *.DFM}

procedure TSelectColonneDlg.FormActivate(Sender: TObject);
var p : integer;
    hauteur : integer;
    iCalc : TcodeGrandeur;
begin
     inherited;
     SelVariab := TList<Integer>.Create();
     GrandeursListBox.clear;
     for p := 0 to pred(NbreVariab) do begin
         iCalc := indexVariab[p];
         with grandeurs[iCalc] do begin
            GrandeursListBox.Items.Add(nom+' : '+fonct.expression);
            GrandeursListBox.checked[p] := active;
         end;
     end;
     hauteur := NbrePages*22+60;
     if hauteur<240 then hauteur := 240;
     if hauteur>420
         then height := 420
         else height := hauteur;
end;

procedure TSelectColonneDlg.FormDestroy(Sender: TObject);
begin
     SelVariab.Free;
end;

procedure TSelectColonneDlg.OKBtnClick(Sender: TObject);
var p : TcodeGrandeur;
begin
     for p := 0 to pred(NbreVariab) do
         if GrandeursListBox.checked[p] then
            selVariab.Add(indexVariab[p]);
end;

end.
