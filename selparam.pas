unit selparam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  vcl.HtmlHelpViewer,
  StdCtrls, Buttons, CheckLst, compile;

type
  TselParamDlg = class(TForm)
    ParamListBox: TCheckListBox;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
  private
  public
  end;

var
  selParamDlg: TselParamDlg;

implementation

{$R *.DFM}

procedure TselParamDlg.FormActivate(Sender: TObject);
var p : integer;
    index : integer;
    hauteur : integer;
begin
     inherited;
     ParamListBox.clear;
     for p := 0 to pred(NbreConst) do begin
         index := indexConst[p];
         ParamListBox.Items.Add(grandeurs[index].nom);
         ParamListBox.checked[p] := ListeConstAff.indexOf(grandeurs[index].nom)>=0;
     end;
     hauteur := ParamListBox.Count*(paramListBox.itemHeight+1)+30;
     if hauteur>180 then height := hauteur;

end;

procedure TselParamDlg.OKBtnClick(Sender: TObject);
var p : integer;
begin
     ListeConstAff.clear;
     for p := 0 to pred(ParamListBox.items.count) do begin
         if ParamListBox.checked[p] then
             ListeConstAff.add(ParamListBox.items[p])
     end;
end;

end.
