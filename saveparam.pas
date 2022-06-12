unit saveparam;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, CheckLst,
  vcl.HtmlHelpViewer,
  math, maths, regutil, compile, constreg, aidekey;

type
  TSaveParamDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    GroupBox1: TGroupBox;
    HelpBtn: TBitBtn;
    ParamListBox: TCheckListBox;
    Memo1: TMemo;
    procedure FormActivate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
  private
  public
  end;

var
  SaveParamDlg: TSaveParamDlg;

implementation

uses Valeurs, Graphvar;

{$R *.DFM}

procedure TSaveParamDlg.FormActivate(Sender: TObject);
var i,j : integer;
    p : integer;
begin
     inherited;
     with ParamListBox do begin
        Clear;
        for i := 1 to NbreParam[paramNormal] do
            Items.add(Parametres[paramNormal,i].nom);
        if modelePagesIndependantes then
           for p := 1 to NbrePages do with pages[p] do
              for j := 1 to MaxParametres do
                  if (nomParam[j]<>'') and
                     (Items.indexOf(nomParam[j])<0) then
                      Items.add(nomParam[j]);
        for i := 0 to pred(items.count) do
            checked[i] := true;
     end;
end;

procedure TSaveParamDlg.OKBtnClick(Sender: TObject);
var p : integer;
    indexC : integer;
    i,j,k : integer;
begin
     for i := 0 to pred(ParamListBox.count) do
         if ParamListBox.checked[i] then begin
          indexC := indexNomVariab(ParamListBox.items[i]);
          if indexC=grandeurInconnue then
             indexC := AjouteExperimentale(ParamListBox.items[i],constante);
          for p := 1 to NbrePages do with pages[p] do begin
              if modelePagesIndependantes then begin
                 j := 1;
                 k := 0;
                 repeat
                    if nomParam[j]=ParamListBox.items[i]
                       then k := j
                       else inc(j);
                 until (nomParam[j]='') or (k>0) or (j>MaxParametres);
              end
              else k := i+1;
              if k=0 then begin
                 valeurConst[indexC] := Nan;
                 incertConst[indexC] := Nan;
              end
              else begin
                 valeurConst[indexC] := valeurParam[paramNormal,k];
                 incertConst[indexC] := incertParam[k];
                 grandeurs[indexC].nomUnite := parametres[paramNormal,k].nomUnite;
                 grandeurs[indexC].fonct.expression := parametres[paramNormal,k].fonct.expression;
              end;
          end;
     end;
end;

procedure TSaveParamDlg.HelpBtnClick(Sender: TObject);
begin
     Aide(HELP_SauvegardedelaModelisation)
end;

end.
