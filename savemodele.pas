unit savemodele;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, math, sysUtils,
  Vcl.htmlHelpViewer, aidekey,
  maths, regutil, compile, constreg, CheckLst;

type
  TSaveModeleDlg = class(TForm)
    CancelBtn: TBitBtn;
    EditNom: TEdit;
    LabelExp: TLabel;
    HelpBtn: TBitBtn;
    Label1: TLabel;
    SauveValeurBtn: TBitBtn;
    SauveParamBtn: TBitBtn;
    SauveParamGlbBtn: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure SauveValeurBtnClick(Sender: TObject);
    procedure SauveParamBtnClick(Sender: TObject);
    procedure SauveParamGlbBtnClick(Sender: TObject);
  private
    ModeleAremplir : array[TcodeIntervalle] of boolean;
    procedure ecritModele;
  public
  end;

var
  SaveModeleDlg: TSaveModeleDlg;

implementation

uses Valeurs, Graphvar;

{$R *.DFM}

procedure TSaveModeleDlg.FormActivate(Sender: TObject);
var j,N : integer;
begin
     with FonctionTheorique[1] do begin
          labelExp.caption := enTete+' = '+expression;
          editNom.text := grandeurs[indexY].nom+'th';
     end;
    ModeleAremplir[1] := true;
    N := 1;
    for j := 2 to MaxIntervalles do ModeleAremplir[j] := false;
    for j := 2 to NbreModele do
        if (fonctionTheorique[j].indexX=fonctionTheorique[1].indexX) and
           (fonctionTheorique[j].indexY=fonctionTheorique[1].indexY) then begin
             ModeleAremplir[j] := true;
             inc(N);
        end;
     SauveParamGlbBtn.visible := (N=1) and (NbrePages>1);
     SauveParamBtn.visible := (N=1);
end;

procedure TSaveModeleDlg.OKBtnClick(Sender: TObject);
begin
   ecritModele;
end;

procedure TSaveModeleDlg.HelpBtnClick(Sender: TObject);
begin
     Aide(HELP_Sauvegardedelamodelisation)
end;

procedure TSaveModeleDlg.SauveValeurBtnClick(Sender: TObject);
var IndexGrandeurModele : byte;

Procedure RemplitModele(p : TcodePage;i : TcodeIntervalle);
var j,jdebut : integer;
    iX : TcodeGrandeur;
begin with pages[p] do begin
       if i=1
          then jdebut := 0
          else begin
              iX := fonctionTheorique[i].indexX;
              jdebut := debut[i];
              if not isNan(X_inter[i]) then
                  while (jdebut>0) and (jdebut>fin[pred(i)]) and
                        (valeurVar[iX,jdebut]>X_inter[i])
                     do dec(jdebut);
          end;
       for j := jdebut to pred(nmes) do
           valeurVar[indexGrandeurModele,j] := valeurTheorique[i,j];
end end;

var j : integer;
    g : tgrandeur;
    Nom : string;
    correct,existeDeja : boolean;
    p : TcodePage;
begin with FonctionTheorique[1] do begin
      ExisteDeja := false;
      Nom := EditNom.text;
      correct := NomCorrect(Nom,grandeurInconnue);
      if not correct then
            if (codeErreurC=erNomExistant) and
               (Grandeurs[IndexNom(nom)].genreG=variable) and
               (Grandeurs[IndexNom(nom)].fonct.genreC=g_experimentale)
               then begin
                  ExisteDeja := OKformat(OkDelVariab,[Nom]);
                  if not existeDeja then begin
                     ModalResult := mrNone;
                     editNom.setFocus;
                     exit;
                  end;
               end
               else begin
                  afficheErreur(codeErreurC,0);
                  editNom.setFocus;
                  ModalResult := mrNone;
                  exit;
               end;
      ModalResult := mrOK;               
      if existeDeja
        then indexGrandeurModele := indexNom(nom)
        else begin
           G := Tgrandeur.create;
           G.init(nom,grandeurs[indexY].nomUnite,'',variable);
           G.fonct.genreC := g_experimentale;
           indexGrandeurModele := AjouteGrandeurE(G);
        end;
    for p := 1 to NbrePages do
       for j := 1 to NbreModele do
           if ModeleAremplir[j] then remplitModele(p,j);
    Application.MainForm.perform(WM_Reg_Maj,MajGrandeur,0)
end end; // SauveModele

procedure TSaveModeleDlg.SauveParamBtnClick(Sender: TObject);
var i,indexC : integer;
    p : TcodePage;
begin
   ecritModele;
   for i := 1 to NbreParam[ParamNormal] do
       with parametres[paramNormal,i] do begin
          indexC := AjouteExperimentale(nom,constante);
          for p := 1 to NbrePages do with pages[p] do
              valeurConst[indexC] := valeurParam[paramNormal,i];
          grandeurs[indexC].nomUnite := nomUnite;
          grandeurs[indexC].fonct.expression := fonct.expression;
   end;
end;

procedure TSaveModeleDlg.SauveParamGlbBtnClick(Sender: TObject);
var i : integer;
    z : string;
begin
   for i := 1 to NbreParam[ParamNormal] do
       with parametres[paramNormal,i] do begin
          z := nom+'='+FormatNombre(valeurCourante);
          if nomUnite<>'' then z := z +'_'+nomUnite;
          Fvaleurs.Memo.Lines.Add(z);
   end;
   ecritModele;
end;

Procedure TSaveModeleDlg.EcritModele;
var expr : string;

procedure Remplace(const oldNom,newNom : string);
var debut,posVar,posFin : integer;
    caracSuivant : char;
begin
     debut := 1;
     repeat
        posVar := pos(oldNom,copy(expr,debut,length(expr)));
        posFin := debut+posVar+length(oldNom)-1;
        if posFin<=length(expr)
           then caracSuivant := expr[posFin]
           else caracSuivant := '*';
        if (posVar>0) and charInSet(caracSuivant,[')','*','+','-','/']) then
           expr :=
             copy(expr,1,debut+posVar-2)+
             newNom+
             copy(expr,posFin,length(expr));
        debut := posFin;
     until (posVar=0);
end;

begin with fonctionTheorique[1] do begin
      case genreC of
           g_fonction : Fvaleurs.Memo.Lines.Add(EditNom.text+'='+expression);
           g_equation : ;
           g_diff1 : begin
              expr := expression;
              remplace(grandeurs[indexY].nom,EditNom.text);
              Fvaleurs.Memo.Lines.Add(EditNom.text+'''='+expr);
           end;
           g_diff2 : begin
               expr := expression;
               remplace(grandeurs[indexY].nom+'''',EditNom.text+'''');
               remplace(grandeurs[indexY].nom,EditNom.text);
               Fvaleurs.Memo.Lines.Add(EditNom.text+'"='+expr);
           end;
      end
end end;

end.
