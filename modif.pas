unit modif;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Spin, sysutils, ComCtrls, strUtils, math,
  vcl.HtmlHelpViewer,
  maths, constreg, regutil, uniteker, compile, aideKey, Vcl.Mask;

type
  TModifDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    EditNom: TEdit;
    EditUnite: TEdit;
    PrecisionCB: TComboBox;
    Label4: TLabel;
    Bevel: TBevel;
    RazIncertitudeBtn: TBitBtn;
    AffSignifCB: TCheckBox;
    GenreLabel: TLabel;
    LabelPrecision: TLabel;
    PrecisionSE: TSpinEdit;
    CalculExpGB: TGroupBox;
    ExpressionEdit: TLabeledEdit;
    Memo1: TMemo;
    CalculVersExpCB: TCheckBox;
    Image2: TImage;
    EditComm: TLabeledEdit;
    EditIncertitude: TLabeledEdit;
    IncertitudeHelpBtn: TSpeedButton;
    EditIncertitude_TypeB: TLabeledEdit;
    procedure FormActivate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure PrecisionCBChange(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure RazIncertitudeBtnClick(Sender: TObject);
    procedure IncertitudeHelpBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure EditIncertitude_TypeBKeyPress(Sender: TObject; var Key: Char);
    procedure EditNomKeyPress(Sender: TObject; var Key: Char);
  private
      oldFormatU : TnombreFormat;
  public
      grandeurModif : Tgrandeur;
      index : integer;
      modification : boolean;
  end;

var
  ModifDlg: TModifDlg;

implementation

uses Valeurs, options, graphvar;

{$R *.DFM}

procedure TModifDlg.CancelBtnClick(Sender: TObject);
begin
      modification := false;
end;

procedure TModifDlg.EditIncertitude_TypeBKeyPress(Sender: TObject;
  var Key: Char);
begin
    if Key=',' then key := '.'
end;

procedure TModifDlg.EditNomKeyPress(Sender: TObject; var Key: Char);
begin
     case key of
        crCR,crTab : ;
        crEsc : ;
        crSupprArr : ;
        else if not isCaracGrandeur(key) then key := #0;
     end;
end;

procedure TModifDlg.FormActivate(Sender: TObject);
begin
inherited;
modification := false;
if index=cFrequence
   then grandeurModif := grandeurs[cFrequence]
   else if index<maxGrandeurs then
        grandeurModif := grandeurs[index];
with grandeurModif do begin
     EditNom.text := nom;
     EditNom.enabled := fonct.genreC=g_experimentale;
     CalculExpGB.visible := (fonct.genreC=g_experimentale) and (genreG=variable);
     if (modeAcquisition=AcqSimulation) and
        (index=0) then begin
           CalculExpGB.visible := false;
           GenreLabel.caption := 'Variable de contrôle de la simulation'
        end
        else GenreLabel.caption := NomGenreGrandeur[genreG]+' '+nomGenreCalcul[fonct.genreC];
     CalculVersExpCB.visible := (fonct.genreC=g_fonction) and (genreG=variable);
     CalculVersExpCB.checked := false;
     expressionEdit.Text := '';
     EditUnite.text := nomUnite;
     EditUnite.Enabled := fonct.genreC=g_experimentale;
     EditUnite.Visible := (fonct.genreC<>g_texte);
     EditComm.text := fonct.expression;
     EditComm.enabled := EditNom.enabled;
     PrecisionCB.itemIndex := ord(formatU);
     oldFormatU := formatU;     
     PrecisionSE.value := precisionU;
     PrecisionCBChange(nil);
     EditIncertitude.text := incertCalcA.expression;
     EditIncertitude_TypeB.text := incertCalcB.expression;
     EditIncertitude.visible := (index<maxGrandeurs) and
                                (fonct.genreC=g_experimentale);
     if (genreG=constanteGlb) and (fonct.depend=[]) then EditIncertitude.visible := true;
     RazIncertitudeBtn.visible := EditIncertitude.visible;
     EditIncertitude_TypeB.visible := EditIncertitude.visible;
     AffSignifCB.checked := AffSignif;
end end;

procedure TModifDlg.OKBtnClick(Sender: TObject);

Procedure SetNom;
var newNom,oldNom : string;
    longueurNom : integer;

Function ModifExpression(tampon : string) : string;
var posNom,suiteNom : integer;
    debutCorrect,FinCorrect : boolean;
begin
     posNom := PosEx(oldNom,tampon,0);
     while posNom>0 do begin
           debutCorrect := (posNom=1) or
               charinset(tampon[pred(posNom)],['=',' ','(','''','*','+','-','/']);
           suiteNom := posNom+LongueurNom;
           finCorrect := (suiteNom=length(tampon)+1) or
                  charinset(tampon[suiteNom],['*','+','-','/',':',')','^',',']);
           if debutCorrect and finCorrect then begin
                delete(tampon,posNom,LongueurNom);
                insert(NewNom,tampon,posNom);
           end;
           posNom := PosEx(oldNom,tampon,posNom);
      end;
      result := tampon;
end;

var i : integer;
begin
       oldNom := grandeurModif.nom;
       newNom := editNom.text;
       LongueurNom := length(oldNom);
       for i := 0 to pred(Fvaleurs.memo.lines.count) do
           Fvaleurs.memo.lines[i] := ModifExpression(Fvaleurs.memo.lines[i]);
       for i := 0 to pred(NbreGrandeurs) do with grandeurs[i] do begin
           incertCalcA.expression := ModifExpression(incertCalcA.expression);
           incertCalcB.expression := ModifExpression(incertCalcB.expression);
       end;
       modification := true;
       grandeurModif.nom := newNom;
       if index<MaxGrandeurs then begin
          Application.MainForm.Perform(WM_reg_maj,MajNom,index);
          oldFormatU := grandeurModif.formatU; { mise à jour faite }
       end;
end;

Function SetUnites : boolean;
var U : Tunite;
    UniteOK : boolean;
    i : integer;
begin
    result := true;
    if grandeurModif.nomUnite<>EditUnite.Text then begin
          U := Tunite.create;
          try
          U.NomUnite := editUnite.text;
          UniteOK := U.correct;
          finally
            U.free;
          end;
          if not UniteOK and not OKReg(OkUniteInconnue,HELP_Unites) then begin
             EditUnite.setFocus;
             result := false;
             ModalResult := mrNone;
             exit;
          end;
          modification := true;
          grandeurModif.NomUnite := EditUnite.text;
          if (Index<>cFrequence) and (imUnite in MenuPermis) then
             for i := 0 to pred(NbreGrandeurs) do with grandeurs[i] do
                 if (nomUnite='') or not uniteDonnee then SetUnite;
          if index>maxGrandeurs
             then Application.MainForm.Perform(WM_Reg_Maj,MajUnitesParam,0)
             else Application.MainForm.Perform(WM_Reg_Maj,MajUnites,0);
     end;
end; // SetUnites

Function SetIncertitude : boolean;
var p : TcodePage;
    k : integer;
begin
    result := true;
    if index=cFrequence then exit;
    if (index<maxGrandeurs) and
       ((grandeurModif.IncertCalcA.expression<>editIncertitude.text) or
        (grandeurModif.IncertCalcB.expression<>editIncertitude_TypeB.text))
        then begin
           grandeurModif.IncertCalcA.expression := editIncertitude.text;
           TrimComplet(grandeurModif.IncertCalcA.expression);
           ConvertitPrefixeExpression(grandeurModif.IncertCalcA.expression);
           grandeurModif.IncertCalcB.expression := editIncertitude_TypeB.text;
           TrimComplet(grandeurModif.IncertCalcB.expression);
           ConvertitPrefixeExpression(grandeurModif.IncertCalcB.expression);
           if grandeurModif.compileIncertitude
              then if grandeurModif.genreG=constanteGlb
                  then begin
                       grandeurModif.calculIncertitudeExp(grandeurModif.incertCourante);
                  end
                  else begin
                  for p := 1 to NbrePages do with pages[p] do begin
                     affecteVariableP(false);
                     affecteConstParam(false);
                     for k := index to pred(NbreGrandeurs) do
                         calculIncertG(k);
                  end;
                  Application.MainForm.Perform(WM_Reg_Maj,MajIncertitude,0)
              end
              else begin
                 afficheErreur(codeErreurC+' dans incertitudes',0);
                 editIncertitude.setFocus;
                 result := false;
                 ModalResult := mrNone;
              end;
       end;
end; // SetIncertitude

procedure remplir;
var posErreur,longErreur,i : integer;
begin with pages[pageCourante] do begin
    grandeurImmediate.fonct.expression := expressionEdit.Text;
    if grandeurImmediate.compileG(posErreur,longErreur,0) and
       (grandeurImmediate.fonct.calcul<>nil)
        then begin
             affecteConstParam(false);
             affecteVariableP(false);
             for i := 0 to pred(nmes) do begin
                 affecteVariableE(i);
                 try
                     valeurVar[index,i] :=  calcule(grandeurImmediate.fonct.calcul);
                 except
                 on E:exception do valeurVar[index,i] := Nan;
                 end;// except
             end; // for i
        end
        else afficheErreur('Erreur dans l''expression',0);
end end;

procedure convertirExp;
var zz : string;
    i : integer;
begin
     libere(grandeurModif.fonct.calcul);
     grandeurModif.fonct.genreC := g_experimentale;
     zz := grandeurModif.nom+'=';
     for i := 0 to Fvaleurs.memo.lines.Count - 1 do
         if pos(zz,Fvaleurs.memo.lines[i])=1 then begin
            Fvaleurs.Memo.lines.delete(i);
            break;
         end;
end;

begin
     modification := false;
     if not setIncertitude then exit;
     if not setUnites then exit;
     if (expressionEdit.Text<>'') and
        OKreg('Calcul d''une grandeur expérimentale ?!',0) then remplir;
     if calculVersExpCB.checked and
        OKreg('Conversion d''une grandeur calculée en grandeur expérimentale ?!',0) then convertirExp;
     with grandeurModif do begin
         formatU := TnombreFormat(PrecisionCB.itemIndex);
         if editNom.enabled and (nom<>EditNom.Text) then setNom;
         nom := EditNom.Text;
         fonct.expression := EditComm.text;
         precisionU := precisionSE.value;
         AffSignif := AffSignifCB.checked;
     end;
     if grandeurModif.formatU<>oldFormatU then
        FgrapheVariab.Perform(WM_Reg_Maj,MajNom,0);
     ModalResult := mrOK;
end; // OKbtnClick

procedure TModifDlg.PrecisionCBChange(Sender: TObject);
const
     texte : array[1..5] of string =
          ('chiffres','décimales','chiffres',
           'bits','bits');
     Min : array[1..5] of integer = (2,0,2,1,1);
     Max : array[1..5] of integer = (12,12,12,8,8);
begin
     LabelPrecision.visible := (PrecisionCB.itemIndex>0) and
                               (PrecisionCB.itemIndex<6);
     PrecisionSE.visible := LabelPrecision.visible;
     if LabelPrecision.visible then begin
         LabelPrecision.caption := 'Nombre de '+texte[PrecisionCB.itemIndex];
         PrecisionSE.minValue := min[PrecisionCB.itemIndex];
         PrecisionSE.maxValue := max[PrecisionCB.itemIndex];
     end;
end;

procedure TModifDlg.HelpBtnClick(Sender: TObject);
begin
     Aide(HELP_Grandeurs)
end;

procedure TModifDlg.IncertitudeHelpBtnClick(Sender: TObject);
begin
    Aide(Help_Incertitudes);
end;

procedure TModifDlg.RazIncertitudeBtnClick(Sender: TObject);
var p : TcodePage;
    j : integer;
begin
     if index>=maxGrandeurs then exit;
     grandeurModif.IncertCalcA.expression := '';
     grandeurModif.IncertCalcB.expression := '';
     editIncertitude.text := '';
     editIncertitude_TypeB.text := '';
     for p := 1 to NbrePages do with pages[p] do
         case grandeurModif.genreG of
              variable : for j := 0 to pred(nmes) do
                  incertVar[index,j] := Nan;
              constante : incertConst[index] := Nan;
              constanteGlb : grandeurModif.incertCourante := Nan;
         end;
end;

end.
