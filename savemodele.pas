unit savemodele;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, math, sysUtils, Vcl.Grids,
  Vcl.htmlHelpViewer,

  aidekey, maths, regutil, compile, constreg;

type
  TSaveModeleDlg = class(TForm)
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    SauveValeurBtn: TBitBtn;
    SauveParamBtn: TBitBtn;
    SauveParamGlbBtn: TBitBtn;
    ModeleGrid: TStringGrid;
    BtnPanel: TPanel;
    procedure FormActivate(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure SauveValeurBtnClick(Sender: TObject);
    procedure SauveParamBtnClick(Sender: TObject);
    procedure SauveParamGlbBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure ecritModele(j : TcodeIntervalle);
  public
  end;

var
  SaveModeleDlg: TSaveModeleDlg;

implementation

uses Valeurs, Graphvar;

{$R *.DFM}

procedure TSaveModeleDlg.FormActivate(Sender: TObject);
var j : integer;
begin
    ModeleGrid.rowCount := NbreModele+1;
    for j := 1 to NbreModele do
    with FonctionTheorique[j] do begin
         ModeleGrid.cells[0,j] := enTete+' = '+expression;
         ModeleGrid.cells[1,j] := grandeurs[indexY].nom+'th';
    end;
    ModeleGrid.height := ModeleGrid.DefaultRowHeight*ModeleGrid.rowCount+8;
    ClientHeight := ModeleGrid.height+BtnPanel.height;
end;

procedure TSaveModeleDlg.FormCreate(Sender: TObject);
begin
   ModeleGrid.cells[0,0] := 'Modèle';
   ModeleGrid.cells[1,0] := 'Nom';
   ModeleGrid.colWidths[1] := abs(ModeleGrid.font.height)*6;
   ModeleGrid.colWidths[0] := ModeleGrid.width-4-ModeleGrid.colWidths[1];
end;

procedure TSaveModeleDlg.HelpBtnClick(Sender: TObject);
begin
     Aide(HELP_Sauvegardedelamodelisation)
end;

procedure TSaveModeleDlg.SauveValeurBtnClick(Sender: TObject);
var IndexGrandeurModele : byte;
    ModeleRempli : array[TcodeIntervalle] of boolean;

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
       modeleRempli[i] := true;
end end;

function Affecte(i : TcodeIntervalle) : boolean;
var j : integer;
    g : Tgrandeur;
    Nom : string;
    correct,existeDeja : boolean;
    p : TcodePage;
    ModeleAremplir : array[TcodeIntervalle] of boolean;
begin with FonctionTheorique[i] do begin
      ExisteDeja := false;
      ModeleAremplir[i] := true;
      for j := succ(i) to NbreModele do
          ModeleAremplir[j] :=
           (fonctionTheorique[j].indexX=fonctionTheorique[i].indexX) and
           (fonctionTheorique[j].indexY=fonctionTheorique[i].indexY);
      Nom := ModeleGrid.Cells[1,i];
      correct := NomCorrect(Nom,grandeurInconnue);
      if not correct then
            if (codeErreurC=erNomExistant) and
               (Grandeurs[IndexNom(nom)].genreG=variable) and
               (Grandeurs[IndexNom(nom)].fonct.genreC=g_experimentale)
               then begin
                  ExisteDeja := OKformat(OkDelVariab,[Nom]);
                  if not existeDeja then begin
                     result := false;
                     exit;
                  end;
               end
               else begin
                  afficheErreur(codeErreurC,0);
                  result := false;
                  exit;
               end;
      result := true;
      if existeDeja
        then indexGrandeurModele := indexNom(nom)
        else begin
           G := Tgrandeur.create;
           G.init(nom,grandeurs[indexY].nomUnite,'',variable);
           G.fonct.genreC := g_experimentale;
           indexGrandeurModele := AjouteGrandeurE(G);
        end;
    for p := 1 to NbrePages do
        for j := i to NbreModele do
            if ModeleAremplir[j] then remplitModele(p,j);
end end; //affecte

var j : TCodeIntervalle;
begin
      for j := 1 to NbreModele do modeleRempli[j] := false;
      if affecte(1)
      then begin
         for j := 2 to NbreModele do
             if not modeleRempli[j] then affecte(j);
         ModalResult := mrOK;
         Application.MainForm.perform(WM_Reg_Maj,MajGrandeur,0)
      end
      else begin
          modalResult := crNone;
          modeleGrid.Col := 1;
          modeleGrid.Row := 1;
          modeleGrid.setFocus;
      end;
end; // SauveValeurBtnClick

procedure TSaveModeleDlg.SauveParamBtnClick(Sender: TObject);
var i,indexC : integer;
    p : TcodePage;
begin
   for i := 1 to NbreModele do
       ecritModele(i);
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
   for i := 1 to NbreModele do
       ecritModele(i);
end;

Procedure TSaveModeleDlg.EcritModele(j : TcodeIntervalle);
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

begin with fonctionTheorique[j] do begin
      case genreC of
           g_fonction : Fvaleurs.Memo.Lines.Add(ModeleGrid.Cells[1,j]+'='+expression);
           g_equation : ;
           g_diff1 : begin
              expr := expression;
              remplace(grandeurs[indexY].nom,ModeleGrid.Cells[1,j]);
              Fvaleurs.Memo.Lines.Add(ModeleGrid.Cells[1,j]+'''='+expr);
           end;
           g_diff2 : begin
               expr := expression;
               remplace(grandeurs[indexY].nom+'''',ModeleGrid.Cells[1,j]+'''');
               remplace(grandeurs[indexY].nom,ModeleGrid.Cells[1,j]);
               Fvaleurs.Memo.Lines.Add(ModeleGrid.Cells[1,j]+'"='+expr);
           end;
      end
end end; // ecritModele

end.
