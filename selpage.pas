unit selpage;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, sysutils, ExtCtrls, Messages, dialogs,
  vcl.HtmlHelpViewer,
  compile, CheckLst, ComCtrls;

type
  TSelectPageDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    AllBtn: TBitBtn;
    OneBtn: TBitBtn;
    PageListBox: TCheckListBox;
    StatusBar: TStatusBar;
    AllOKBtn: TBitBtn;
    OneOKBtn: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure AllBtnClick(Sender: TObject);
    procedure OneBtnClick(Sender: TObject);
    procedure AllOKBtnClick(Sender: TObject);
    procedure OneOKBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
    appelPrint : boolean;
  end;

var
  SelectPageDlg: TSelectPageDlg;

implementation

uses regutil, Regmain;

{$R *.DFM}

procedure TSelectPageDlg.FormActivate(Sender: TObject);
var p : integer;
    hauteur,index,i : integer;
    LabelConst : string;
begin
     inherited;
     PageListBox.clear;
     for p := 1 to NbrePages do with pages[p] do begin
          labelConst := '';
          for i := 0 to pred(ListeConstAff.count) do begin
              index := indexNom(ListeConstAff[i]);
              if index<>grandeurInconnue then
                 labelConst := labelConst+grandeurs[index].FormatNomEtUnite(valeurConst[index])+';'
         end;
         PageListBox.Items.Add(IntToStr(p)+' : '+labelConst+commentaireP);
         PageListBox.checked[p-1] := active;
     end;
     hauteur := NbrePages*22+60;
     if statusBar.Visible
        then begin
           hauteur := hauteur + 30;
           if hauteur<260 then hauteur := 260;
        end
        else if hauteur<240 then hauteur := 240;
     if hauteur>420
         then height := 420
         else height := hauteur;
end;

procedure TSelectPageDlg.FormCreate(Sender: TObject);
begin
 ResizeButtonImagesforHighDPI(self);
end;

procedure TSelectPageDlg.OKBtnClick(Sender: TObject);
var p : TcodePage;
    N : integer;
begin
     N := 0;
     for p := 1 to NbrePages do begin
         pages[p].active := PageListBox.checked[p-1];
         if pages[p].active then inc(N);
     end;
     if N=0 then begin
        pages[pageCourante].active := true;
        N := 1;
     end;
     if not pages[pageCourante].active then begin
        p := 1;
        while (p<NbrePages) and not pages[p].active do inc(p);
        pageCourante := p;
     end;
     if appelPrint then N := 0;
     Application.MainForm.perform(WM_Reg_Maj,MajSelectPage,N);
end;

procedure TSelectPageDlg.AllBtnClick(Sender: TObject);
var p : TcodePage;
begin
     for p := 1 to NbrePages do
         PageListBox.checked[p-1] := true;
end;

procedure TSelectPageDlg.OneBtnClick(Sender: TObject);
var p : TcodePage;
begin
     for p := 1 to NbrePages do
         PageListBox.checked[p-1] := false;
     PageListBox.checked[pageCourante-1] := true;
end;

procedure TSelectPageDlg.AllOKBtnClick(Sender: TObject);
var p : TcodePage;
begin
     for p := 1 to NbrePages do pages[p].active := true;
     Application.MainForm.perform(WM_Reg_Maj,MajSelectPage,NbrePages);
end;

procedure TSelectPageDlg.OneOKBtnClick(Sender: TObject);
var p : TcodePage;
begin
     for p := 1 to NbrePages do pages[p].active := false;
     pages[pageCourante].active := true;
     Application.MainForm.perform(WM_Reg_Maj,MajSelectPage,1);
end;

end.
