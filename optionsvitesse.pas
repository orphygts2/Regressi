unit optionsVitesse;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, Buttons, ExtCtrls, constreg,
  regutil, compile, graphker, aidekey;

type
  TOptionsVitesseDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    Panel1: TPanel;
    GroupBox3: TGroupBox;
    LabelX: TLabel;
    LabelY: TLabel;
    Label4: TLabel;
    NbreLabel: TLabel;
    EchelleVecteurSE: TSpinEdit;
    NbreSE: TSpinEdit;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label5: TLabel;
    AccelerationX: TComboBox;
    AccelerationY: TComboBox;
    ProlongeCB: TCheckBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    VitesseX: TComboBox;
    VitesseY: TComboBox;
    UseSelectCB: TCheckBox;
    CouleurVitesse: TColorBox;
    CouleurAcceleration: TColorBox;
    CouleurPointCB: TCheckBox;
    ProjeteCB: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure CouleurVitesseClick(Sender: TObject);
    procedure CouleurAccelerationClick(Sender: TObject);
  private
    ListeVar : TstrListe;
  public
     grandeurX,grandeurY : Tgrandeur;
  end;

var
  OptionsVitesseDlg: TOptionsVitesseDlg;

implementation

{$R *.DFM}

procedure TOptionsVitesseDlg.FormActivate(Sender: TObject);

procedure Ajoute(Avariable : Tgrandeur;Acombo : TcomboBox;Agenre : TgenreMecanique);
var code,index : integer;
begin
     ACombo.items := listeVar;
     Case Agenre of
        gm_Vitesse : index := IndexVitesse(Avariable.nom);
        gm_acceleration : index := IndexAcceleration(Avariable.nom)
        else exit;
     end;
     if index=grandeurInconnue then exit;
     code := ListeVar.MyIndexOf(grandeurs[index].nom);
     Acombo.itemIndex := code;
end;

var i : integer;
begin
     inherited;
     EchelleVecteurSE.value := round(echelleVecteur*100);
     ProlongeCB.checked := ProlongeVecteur;
     ProjeteCB.checked := ProjeteVecteur;
     NbreSE.value := NbreVecteurVitesseMax;
     CouleurVitesse.selected := couleurMecanique[mondeVitesse];
     CouleurAcceleration.selected := couleurMecanique[mondeAcc];
     UseSelectCB.checked := UseSelect;
     CouleurPointCB.checked := not couleurVitesseImposee;
     ListeVar.Clear;
     for i := 1 to pred(NbreGrandeurs) do with grandeurs[i] do
         if genreG=variable then ListeVar.add(nom);
     labelX.caption := stAbscisse+' = '+grandeurX.nom;
     labelY.caption := stOrdonnee+' = '+grandeurY.nom;
     Ajoute(grandeurX,vitesseX,gm_Vitesse);
     Ajoute(grandeurY,vitesseY,gm_Vitesse);
     Ajoute(grandeurX,accelerationX,gm_Acceleration);
     Ajoute(grandeurY,accelerationY,gm_Acceleration);
end;

procedure TOptionsVitesseDlg.OKBtnClick(Sender: TObject);

Procedure Ajoute(Agenre : TgenreMecanique;Liste : TcomboBox;Avariable : Tgrandeur);
var code,i : integer;
begin
    code := indexNom(Liste.text);
    if code<>grandeurInconnue then begin
       with grandeurs[code] do begin
          GenreMecanique := Agenre;
          nomvarPosition := Avariable.nom;
       end;
       for i := 1 to pred(NbreGrandeurs) do with grandeurs[i] do
          if (i<>code) and
             (genreMecanique=Agenre) and
             (nomvarPosition=Avariable.nom) then
               genreMecanique := gm_position;
    end;           
end;

begin
    echelleVecteur := EchelleVecteurSE.value/100;
    NbreVecteurVitesseMax := round(NbreSE.value);
    couleurVitesseImposee := not CouleurPointCB.checked; 
    ProlongeVecteur := ProlongeCB.checked;
    ProjeteVecteur := ProjeteCB.checked;
    UseSelect := UseSelectCB.checked;
    couleurMecanique[mondeVitesse] := CouleurVitesse.selected;
    couleurMecanique[mondeAcc] := CouleurAcceleration.selected;
    Ajoute(gm_vitesse,vitesseX,grandeurX);
    Ajoute(gm_vitesse,vitesseY,grandeurY);
    Ajoute(gm_acceleration,accelerationX,grandeurX);
    Ajoute(gm_acceleration,accelerationY,grandeurY);
end;

procedure TOptionsVitesseDlg.FormCreate(Sender: TObject);
begin
    ListeVar := TstrListe.create;
end;

procedure TOptionsVitesseDlg.FormDestroy(Sender: TObject);
begin
    ListeVar.free;
    inherited
end;

procedure TOptionsVitesseDlg.HelpBtnClick(Sender: TObject);
begin
       Aide(HELP_OptionsdesVecteurs)
end;

procedure TOptionsVitesseDlg.CouleurVitesseClick(Sender: TObject);
begin
    couleurMecanique[mondeVitesse] := CouleurVitesse.selected
end;

procedure TOptionsVitesseDlg.CouleurAccelerationClick(Sender: TObject);
begin
     couleurMecanique[mondeAcc] := CouleurAcceleration.selected
end;

end.
