unit pageDistrib;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls,Dialogs, sysutils, Spin,
  Vcl.htmlHelpViewer,
  constreg, math, maths, regutil, fft, compile, filerrr, aidekey, Vcl.CheckLst;

type
  TPageDistribDlg = class(TForm)
    LabelY: TLabel;
    LabelX: TLabel;
    Panel1: TPanel;
    HelpBtn: TBitBtn;
    CancelBtn: TBitBtn;
    OKBtn: TBitBtn;
    ParamListBox: TCheckListBox;
    Label1: TLabel;
    procedure OKBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
  public
  end;

var
  PageDistribDlg: TPageDistribDlg;

implementation

{$R *.DFM}

procedure TPageDistribDlg.OKBtnClick(Sender: TObject);
var index,indexNew,i,j,k : integer;
    nbrePagesCrees : integer;
    pageCopiee,NbrePagesInit : TcodePage;
begin
  NbrePagesInit := nbrePages;
  NbrePagesCrees := NbreVariabExp;
  for j := 0 to pred(ParamListBox.Items.count) do
      if ParamListBox.checked[j]
         then dec(NbrePagesCrees);
  if NbrePagesCrees=NbreVariabExp then begin
      ParamListBox.checked[0] := true;
      dec(NbrePagesCrees);
  end;
  indexNew := AjouteExperimentale('XXX',variable);
  for pageCopiee := 1 to NbrePagesInit do begin
     i := 0;
     for j := 1 to NbrePagesCrees do begin
         if not AjoutePage then exit;
         while ParamListBox.checked[i] do inc(i); // la grandeur à garder
         pages[nbrePages].nmes := pages[1].nmes;
         for k := 0 to pred(ParamListBox.Items.count) do begin
             index := indexVariabExp[k];
             if ParamListBox.checked[k]
                  then copyVecteur(pages[nbrePages].valeurVar[index],pages[1].valeurVar[index])
                  else if k=i then begin
                       copyVecteur(pages[nbrePages].valeurVar[indexNew],pages[1].valeurVar[index]);
                       pages[nbrePages].commentaireP := pages[1].commentaireP+' grandeur='+grandeurs[index].nom;
                  end;
           end;
           for k := 0 to pred(NbreConst) do begin
              index := indexConst[k];
              pages[nbrePages].valeurConst[index] := pages[1].valeurConst[index];
           end;
           inc(i);
     end;
     supprimePage(1,false);
  end;
  for j := 0 to pred(ParamListBox.count) do
      if not ParamListBox.checked[j] then
         SupprimeGrandeurE(indexNom(ParamListBox.items[j]));
  Application.MainForm.perform(WM_Reg_Maj,MajAjoutPage,0);
  ModifFichier := true;
end;

procedure TPageDistribDlg.HelpBtnClick(Sender: TObject);
begin
     Aide(HELP_PageCopiee)
end;

procedure TPageDistribDlg.FormActivate(Sender: TObject);
var j,index : integer;
begin
       inherited;
       ParamListBox.clear;
       for j := 0 to pred(NbreVariabExp) do begin
           index := indexVariabExp[j];
           ParamListBox.Items.Add(grandeurs[index].nom);
       end;
       ParamListBox.checked[0] := true;
end;

end.
