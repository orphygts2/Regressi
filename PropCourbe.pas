unit PropCourbe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids,
  uniteker,graphker, StdCtrls, Spin, ExtCtrls,
  regutil, math, maths, compile, Buttons;

type
  TPropCourbeForm = class(TForm)
    Grid: TStringGrid;
    LissageGB: TGroupBox;
    OrdreLissageSE: TSpinEdit;
    DeriveGB: TGroupBox;
    Label1: TLabel;
    NbreEdit: TEdit;
    DegreRG: TRadioGroup;
    NbreSpinButton: TSpinButton;
    Label2: TLabel;
    SplineGB: TGroupBox;
    Label3: TLabel;
    OrdreSplineSE: TSpinEdit;
    ExitBtn: TBitBtn;
    TexteGB: TGroupBox;
    LabelTaille: TLabel;
    SpinEditHauteur: TSpinEdit;
    NbreLabel: TLabel;
    NbreSE: TSpinEdit;
    ExtrapoleDerCB: TCheckBox;
    CourbeEdit: TEdit;
    Panel1: TPanel;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure OrdreSplineSEChange(Sender: TObject);
    procedure NbreSpinButtonDownClick(Sender: TObject);
    procedure NbreSpinButtonUpClick(Sender: TObject);
    procedure DegreRGClick(Sender: TObject);
    procedure OrdreLissageSEChange(Sender: TObject);
    procedure ExitBtnClick(Sender: TObject);
    procedure SpinEditHauteurChange(Sender: TObject);
    procedure NbreSEChange(Sender: TObject);
    procedure ExtrapoleDerCBClick(Sender: TObject);
  private
    varF : Tunite;
    valeurEff, valeurMoy, valeurMin, valeurMax: double;
    periode:     double;
    procedure ModifDerivee;
    procedure Calcul;
  public
    Acourbe : TCoordonnee;
    tangenteEnCours : boolean;
    Agraphe : TgrapheReg;
    procedure MaJ;
  end;

var
  PropCourbeForm: TPropCourbeForm;

implementation

{$R *.dfm}

procedure TPropCourbeForm.FormDestroy(Sender: TObject);
begin
     varF.free;
     PropCourbeForm := nil;
     inherited 
end;

procedure TPropCourbeForm.Calcul;
var
  indexZero1, indexZero2,debut: integer;
  valY,valX : Tvecteur;
  finC : integer;

  procedure CherchePeriodeCourbe;
  var
    signe: double;
    iMax:  integer;
    t1,t2 : double;
    indexZero : integer;
  begin
    indexZero1 := debut;
    signe := valY[debut] - valeurMoy;
    if signe = 0 then signe := -1;
    iMax := finC div 2;
    while (indexZero1 < iMax) and
          ((valY[indexZero1] - valeurMoy) * signe >= 0) do
         Inc(indexZero1);
    // Premier passage par "zéro" (vers le bas par ex.)
    signe := valY[indexZero1] - valeurMoy;
    if signe = 0 then signe := -1;
    indexZero2 := indexZero1 + 8;
    while (indexZero2 < (finC - 8)) and
          ((valY[indexZero2] - valeurMoy) * signe >= 0) do
      Inc(indexZero2);
    // On repasse par "zéro" dans le sens opposé
    indexZero2 := indexZero2 + 7;
    while (indexZero2 < finC) and
          ((valY[indexZero2] - valeurMoy) * signe <= 0) do
      Inc(indexZero2);
    // On repasse par "zéro" dans le même sens
    if indexZero2 < finC then
       periode := valX[indexZero2] - valX[indexZero1];
    try
    if indexZero1>debut // pred possible
        then indexZero := pred(indexZero1)
        else indexZero := succ(indexZero1);
    t1 := valX[indexZero1] -
          (valX[indexZero1]-valX[indexZero])*
          (valY[indexZero1]-valeurMoy)/(valY[indexZero1]-valY[indexZero]);
    except
    t1 := Nan;
    end;
    try
    indexZero := pred(indexZero2);
    t2 := valX[indexZero2] -
           (valX[indexZero2]-valX[indexZero])*
           (valY[indexZero2]-valeurMoy)/(valY[indexZero2]-valY[indexZero]);
    except
    t2 := Nan
    end;
    if not isNan(t2) and  not isNan(t1) then periode := t2-t1;
  end;

var
  i, N : integer;
  sommeEff, sommeMoy, zz: double;
begin
  valX := grandeurs[ACourbe.codeX].valeur;
  valY := grandeurs[ACourbe.codeY].valeur;
  debut := 0;
  finC := pages[pageCourante].nmes-1;
  while (debut<finC) and isNan(valY[debut]) do inc(debut);
  N := succ(finC - debut);
  valeurEff := Nan;
  periode := Nan;
  valeurMax := valY[debut];
  valeurMin := valY[debut];
  for i := succ(debut) to finC do begin
    zz := valY[i];
    if zz > valeurMax then
      valeurMax := zz
    else if zz < valeurMin then
      valeurMin := zz;
  end;
  valeurMoy := (valeurMax + valeurMin) / 2;
  if N < 16 then
    exit;
  CherchePeriodeCourbe;
  if indexZero2 >= finC then
    exit;
  SommeEff := 0;
  SommeMoy := 0;
  N := succ(indexZero2 - indexZero1);
  for i := indexZero1 to indexZero2 do begin
    zz := valY[i];
    SommeEff := SommeEff + sqr(zz);
    SommeMoy := SommeMoy + zz;
  end;
  valeurEff := sqrt(SommeEff / N);
  valeurMoy := sommeMoy / N;
end; // Tcourbe.Calcul


procedure TPropCourbeForm.FormCreate(Sender: TObject);
begin with Grid do begin
       cells[0,0] := 'Période';
       cells[0,1] := 'Fréquence';
       cells[0,2] := 'Crête à crête';
       cells[0,3] := 'Efficace';
       cells[0,4] := 'Moyenne';
       varF := Tunite.create;
  //     DefaultRowHeight := hauteurColonne;
     //  ResizeButtonImagesforHighDPI(self);
end end;

procedure TPropCourbeForm.MaJ;
begin with aCourbe do begin
   courbeEdit.text := 'Caractéristiques de '+nomX+'('+nomY+')';
   courbeEdit.font.Color := acourbe.couleur;
   calcul;
   varF.RecopieUnite(grandeurs[codeX]);
   varF.uniteDonnee := false;
   varF.uniteImposee := false;
   varF.InverseUnite;
   if isNan(periode)
      then begin
           Grid.cells[1,0] := '?';
           Grid.cells[1,1] := '?';
           Grid.cells[1,3] := '';
      end
      else begin
          Grid.cells[1,0] := grandeurs[codeX].formatValeurEtUnite(periode);
          Grid.cells[1,1] := varF.formatValeurEtUnite(1/periode);
          Grid.cells[1,3] := grandeurs[codeY].formatValeurEtUnite(ValeurEff);
      end;
   Grid.cells[1,2] := grandeurs[codeY].formatValeurEtUnite(ValeurMax-ValeurMin);
   Grid.cells[1,4] := grandeurs[codeY].formatValeurEtUnite(ValeurMoy);
end end;

procedure TPropCourbeForm.FormActivate(Sender: TObject);
var Gder : Tsetgrandeur;
    i : integer;
begin
    inherited;
    with ACourbe do begin
    spinEditHauteur.Value := texteGrapheSize;
    ExtrapoleDerCB.checked := ExtrapoleDerivee;
    NbreSE.value := NbreTexteMax;
    splineGB.Visible := (trLigne in Acourbe.trace)
                    and (Acourbe.Ligne=LiSpline);
    ordreSplineSE.MaxValue := ordreMaxSpline;
    lissageGB.Visible := (grandeurs[codeY].fonct.genreC in [g_lissageGlissant,g_lissageCentre]) and
                         (grandeurs[codeY].fonct.calcul.OperandDebut=nil);
    OrdreLissageSE.Value := OrdreFiltrage;
    OrdreSplineSE.Value := OrdreLissage;
    TexteGB.visible := (grandeurs[codeY].fonct.genreC=g_texte) or
                       (trTexte in Acourbe.trace);
    NbreEdit.text := IntToStr(NbrePointDerivee);
    DegreRG.itemIndex := DegreDerivee-1;
    Gder := [];
    for i := 1 to pred(NbreGrandeurs) do begin
        if grandeurs[i].fonct.genreC=g_derivee then include(GDer,i);
        if grandeurs[i].fonct.genreC=g_enveloppe then include(GDer,i);
    end;
    deriveGB.visible := (codeX in Gder) or
                        (codeY in Gder) or
                        ((grandeurs[codeX].fonct.depend * Gder)<>[]) or
                        ((grandeurs[codeY].fonct.depend * Gder)<>[]) or
                        (trVitesse in trace) or
                        (trAcceleration in trace) or
                        tangenteEnCours;
    end;
end;

procedure TPropCourbeForm.OrdreSplineSEChange(Sender: TObject);
begin
    OrdreLissage := OrdreSplineSE.Value;
    Agraphe.paintBox.refresh;
end;

procedure TPropCourbeForm.ModifDerivee;
begin
    OrdreFiltrage := OrdreLissageSE.Value;
    NbreEdit.text := IntToStr(NbrePointDerivee);
    recalculE;
    Application.MainForm.Perform(WM_Reg_Maj,MajValeur,0);
    Application.MainForm.Perform(WM_Reg_Maj,MajEquivalence,0);
end;

procedure TPropCourbeForm.NbreSpinButtonDownClick(Sender: TObject);
begin
    if NbrePointDerivee>MinPointsDerivee then begin
        dec(NbrePointDerivee,2);
        ModifDerivee;
    end;
end;

procedure TPropCourbeForm.NbreSpinButtonUpClick(Sender: TObject);
begin
     if NbrePointDerivee<MaxPointsDerivee
             then begin
                inc(NbrePointDerivee,2);
                ModifDerivee;
             end;
end;

procedure TPropCourbeForm.DegreRGClick(Sender: TObject);
begin
    DegreDerivee := 1+DegreRG.itemIndex;
    if (degreDerivee=3) and (NbrePointDerivee<5)
         then begin
              NbrePointDerivee := 5;
              NbreEdit.Text := '5';
         end;
    ModifDerivee
end;

procedure TPropCourbeForm.OrdreLissageSEChange(Sender: TObject);
begin
    ModifDerivee;
end;

procedure TPropCourbeForm.ExitBtnClick(Sender: TObject);
begin
   close
end;

procedure TPropCourbeForm.SpinEditHauteurChange(Sender: TObject);
begin
     TexteGrapheSize := spinEditHauteur.value;
     Application.MainForm.Perform(WM_Reg_Maj,MajValeur,0)
end;

procedure TPropCourbeForm.NbreSEChange(Sender: TObject);
begin
     NbreTexteMax := NbreSE.value;
     Application.MainForm.Perform(WM_Reg_Maj,MajValeur,0)
end;

procedure TPropCourbeForm.ExtrapoleDerCBClick(Sender: TObject);
begin
    ExtrapoleDerivee := ExtrapoleDerCB.checked;
    ModifDerivee
end;

end.

