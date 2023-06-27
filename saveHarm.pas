unit saveHarm;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls,CheckLst,
  maths, regutil, uniteker, compile, constreg, graphker;

type
  TSaveHarmoniqueDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    GroupBox1: TGroupBox;
    ParamListBox: TCheckListBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label4: TLabel;
    Label2: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    edit : array[ToptionCurseurF] of Tedit;
    signif : array[ToptionCurseurF] of Tedit;
    valeurText : array[ToptionCurseurF] of Tedit;
  public
    Agrandeur : array[ToptionCurseurF] of Tgrandeur;
    valeur : array[ToptionCurseurF] of double;
  end;

var
  SaveHarmoniqueDlg: TSaveHarmoniqueDlg;

implementation

uses Valeurs, Graphfft;

{$R *.DFM}

procedure TSaveHarmoniqueDlg.FormActivate(Sender: TObject);
var ZeroCheck : boolean;

procedure Ajoute(genre : ToptionCurseurF);
var j : integer;
    index : integer;
begin
       edit[genre].text := '';
       signif[genre].text := '';
       valeurText[genre].text := Agrandeur[genre].formatNombre(valeur[genre]);
       for j := 0 to pred(NbreConst) do begin
           index := indexConst[j];
           if Grandeurs[index].isCurseur and
             (Grandeurs[index].optionCurseurF=genre) then begin
                 edit[genre].text := Grandeurs[index].nom;
                 signif[genre].text := Grandeurs[index].fonct.expression;
                 ParamListBox.checked[ord(genre)] := true;
                 zeroCheck := false;
                 break;
           end;
       end;
       if edit[genre].text='' then
          edit[genre].text := Agrandeur[genre].nom+'0';
end;

begin
     inherited;
     ZeroCheck := true;
     Ajoute(gFrequence);
     Ajoute(gAmplitude);
     if ZeroCheck then ParamListBox.checked[0] := true;
end;

procedure TSaveHarmoniqueDlg.OKBtnClick(Sender: TObject);
var indexP : integer;
    i : integer;
    optCurseur : ToptionCurseurF;
begin
     for i := 0 to pred(ParamListBox.count) do
          if ParamListBox.checked[i] then begin
             optCurseur := ToptionCurseurF(i);
             indexP := IndexNom(edit[optCurseur].text);
             if indexP=grandeurInconnue then begin
                indexP := AjouteExperimentale(edit[optCurseur].text,constante);
                if indexP=grandeurInconnue then begin
                   afficheErreur(erNomVide,0);
                   edit[optCurseur].SetFocus;
                   modalResult := MrNone;
                end;
                grandeurs[indexP].isCurseur := true;
                grandeurs[indexP].fonct.expression := signif[optCurseur].text;
                grandeurs[indexP].nomUnite := Agrandeur[optCurseur].nomAff(0);
             end;
             pages[pageCourante].valeurConst[indexP] := valeur[optCurseur];
             grandeurs[indexP].optionCurseurF := optCurseur;
     end;
end;

procedure TSaveHarmoniqueDlg.FormCreate(Sender: TObject);
begin
  inherited;
  edit[gFrequence] := edit1;
  edit[gAmplitude] := edit2;
  signif[gFrequence] := edit5;
  signif[gAmplitude] := edit6;
  valeurText[gFrequence] := edit3;
  valeurText[gAmplitude] := edit4;
end;

end.
