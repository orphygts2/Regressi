unit lecttext;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Spin, ExtCtrls, sysUtils,  ComCtrls,
  Messages, Dialogs, ImgList,
  regutil, constreg,compile, graphker, aidekey,
  system.UITypes;

type
  TLectureTexteDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    PageControl: TPageControl;
    TexteTab: TTabSheet;
    OptionsTab: TTabSheet;
    Edit: TMemo;
    PageGB: TGroupBox;
    Label4: TLabel;
    Memo: TMemo;
    CadreCB: TCheckBox;
    LigneRappelCB: TCheckBox;
    VerticalCB: TCheckBox;
    LabelTaille: TLabel;
    SpinEditHauteur: TSpinEdit;
    CouleurCombo: TColorBox;
    MotifRG: TRadioGroup;
    OpaqueCB: TCheckBox;
    OpaqueColorBox: TColorBox;
    TitreRG: TRadioGroup;
    CouleurComboLabel: TLabel;
    GroupBox2: TGroupBox;
    Xcb: TComboBox;
    Ycb: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    NumeroPageSE: TSpinEdit;
    Label3: TLabel;
    Label5: TLabel;
    penwidthSE: TSpinEdit;
    Label6: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure OpaqueCBClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    NotSousDessin : boolean;
    ListeVar : TstrListe;
  public
    DessinLoc : Tdessin;
    GrapheLoc : TgrapheReg;
  end;

var
  LectureTexteDlg: TLectureTexteDlg;

implementation

{$R *.DFM}

procedure TLectureTexteDlg.FormActivate(Sender: TObject);
var i : integer;
    code : integer;
begin
inherited;
with dessinLoc do begin
     NotSousDessin := identification<>identDroite;
     if notSousDessin
       then begin
          PageControl.ActivePage := TexteTab;
          Edit.lines.assign(texte);
          Edit.SetFocus;
       end
       else PageControl.ActivePage := OptionsTab;
     PageGB.visible := (NbrePages>1) and
                       (identification=identNone);
     CadreCB.checked := avecCadre;
     VerticalCB.checked := vertical;
     LigneRappelCB.checked := avecLigneRappel;
     MotifRG.itemIndex := ord(motifTexte);
     LigneRappelCB.visible := notSousDessin;
     MotifRG.Visible := notSousDessin;
     CouleurCombo.Visible := notSousDessin;
     CouleurComboLabel.Visible := notSousDessin;
     CouleurCombo.selected := pen.color;
     penwidthSE.value := pen.width;
     TexteTab.TabVisible := notSousDessin;
     SpinEditHauteur.text := IntToStr(hauteur);
     opaqueCB.checked := IsOpaque;
     OpaqueColorBox.selected := CouleurFond;
     OpaqueColorBox.visible := IsOpaque;
     TitreRG.itemIndex := ord(isTitre);

        ListeVar.Clear;
        ListeVar.add('souris');
        for i := 0 to pred(NbreGrandeurs) do with grandeurs[i] do begin
            if (genreG=constante) or (genreG=constanteGlb) then ListeVar.add(nom);
        end;
        for i := 1 to NbreParam[ParamNormal] do
            ListeVar.add(Parametres[paramNormal,i].nom);
        for i := 1 to NbreParam[ParamGlb] do
            ListeVar.add(Parametres[paramGlb,i].nom);
        Xcb.items := listeVar;
        Ycb.items := listeVar;
        code := listeVar.MyIndexOf(nomX);
        if code<0 then code := 0;
        Xcb.itemIndex := code;
        code := listeVar.MyIndexOf(nomY);
        if code<0 then code := 0;
        Ycb.itemIndex := code;
        NumeroPageSE.MaxValue := NbrePages;
        NumeroPageSE.Value := NumPage;
        PageGB.Visible := NbrePages>1;
end end;

procedure TLectureTexteDlg.FormCreate(Sender: TObject);
begin
    ListeVar := TstrListe.create;
end;

procedure TLectureTexteDlg.FormDestroy(Sender: TObject);
begin
    inherited;
    ListeVar.free;
end;

procedure TLectureTexteDlg.HelpBtnClick(Sender: TObject);
begin
     Aide(HELP_OptionsTexte)
end;

procedure TLectureTexteDlg.OKBtnClick(Sender: TObject);
begin with dessinLoc do begin
            pen.color := CouleurCombo.selected;
            pen.width := penwidthSE.value;
            IsOpaque := opaqueCB.checked;
            isTitre := TitreRG.itemIndex<>0;
            CouleurFond := colorToRGB(OpaqueColorBox.selected);
            hauteur := StrToInt(SpinEditHauteur.text);
            if notSousDessin then begin
               texte.assign(Edit.lines);
               //if numPage=0 then CouleurTexte := pen.color;
            end;
            avecCadre := CadreCB.checked;
            vertical := VerticalCB.checked;
            avecLigneRappel := LigneRappelCB.checked;
            motifTexte := tMotifTexte(MotifRG.itemIndex);
            with grapheLoc do if isTitre
               then with limiteFenetre do begin
                  x1 := (x1i-left)/(right-left);
                  y1 := (y1i-top)/(top-bottom);
                  x2 := (x2i-left)/(right-left);
                  y2 := (y2i-top)/(top-bottom);
               end
               else begin
                   MondeRT(x1i,y1i,iMonde,x1,y1);
                   MondeRT(x2i,y2i,iMonde,x2,y2);
               end;
       if repere<>nil then repere.Texte := texte[0];
       if Xcb.itemIndex>0 then nomX := listeVar[Xcb.itemIndex];
       if Ycb.itemIndex>0 then nomY := listeVar[Ycb.itemIndex];
       NumPage := NumeroPageSE.Value;
       if identification=identCoord then begin
          MotifIdent := motifTexte;
          hauteurIdent := hauteur;
          avecCadreIdent := avecCadre;
          isOpaqueIdent := isOpaque;
          couleurFondIdent := couleurFond;
       end;
end end;

procedure TLectureTexteDlg.OpaqueCBClick(Sender: TObject);
begin
   OpaqueColorBox.visible := OpaqueCB.checked;
end;

end.
