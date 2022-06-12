unit identPagesU;

interface

uses SysUtils, Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, CheckLst, Spin,
  vcl.HtmlHelpViewer,
  regutil, compile;

type
  TChoixIdentPagesDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    CommentaireCB: TCheckBox;
    ParamGB: TGroupBox;
    ListeConstBox: TCheckListBox;
    NewIdentPageCB: TCheckBox;
  private
  public
    procedure InitParam;
  end;

var
  ChoixIdentPagesDlg: TChoixIdentPagesDlg;

implementation

{$R *.DFM}

procedure TChoixIdentPagesDlg.InitParam;
var i : integer;
    sauve : TstringList;
begin with ListeConstBox do begin
     sauve := TstringList.create;
     for i := 0 to pred(count) do
         if checked[i] then
            sauve.add(items[i]);
     Items.Clear;
     for i := 0 to pred(NbreConst) do
         Items.add(grandeurs[indexConst[i]].nom);
     for i := 1 to NbreParam[paramNormal] do
         Items.add(Parametres[paramNormal,i].nom);
     for i := 0 to pred(count) do
         checked[i] := sauve.IndexOf(items[i])>=0;
     sauve.Free;
end end;

end.
