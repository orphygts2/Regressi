unit choixmodele;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ComCtrls, ImgList,
  Vcl.htmlHelpViewer,
  constreg, maths, regutil, uniteKer, compile, graphker,
  modelegr, aidekey, System.ImageList, Vcl.VirtualImageList,
  Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TChoixModeleDlg = class(TForm)
    AjouteBtn: TBitBtn;
    CancelBtn: TBitBtn;
    PageControl: TPageControl;
    ModManuel: TTabSheet;
    DeriveeLabel: TLabel;
    GenreModeleRG: TRadioGroup;
    yEdit: TEdit;
    CalculetteBtn: TBitBtn;
    ModMagnum: TTabSheet;
    DroiteBtn: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton1: TSpeedButton;
    NouveauBtn: TBitBtn;
    helpMagnumBtn: TBitBtn;
    ModFiltres: TTabSheet;
    DecibelCB: TCheckBox;
    SpeedButton6: TSpeedButton;
    SpeedButton10: TSpeedButton;
    PasseBandeBtn: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton14: TSpeedButton;
    QualiteRG: TRadioGroup;
    SpeedButton15: TSpeedButton;
    ModSinus: TTabSheet;
    SinusBtn: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton3: TSpeedButton;
    CoordRG: TRadioGroup;
    cosinusCB: TCheckBox;
    ModSpecial: TTabSheet;
    SpeedButton11: TSpeedButton;
    SpeedButton16: TSpeedButton;
    SpeedButton17: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton18: TSpeedButton;
    ImageCollectionModele: TImageCollection;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    VirtualImageList2: TVirtualImageList;
    procedure GenreModeleRGClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure CalculetteBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure AjouteBtnClick(Sender: TObject);
    procedure ModeleBtnClick(Sender: TObject);
    procedure NouveauBtnClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure helpMagnumBtnClick(Sender: TObject);
    procedure ModeleBtnDblClick(Sender: TObject);
    procedure CoordRGClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    Procedure MajTexte;
  public
    ModeleChoisi : TgenreModeleGr;
    EffaceModele : boolean;
    AppelMagnum : boolean;
    coordonnee : TlisteY;
  end;

var
    ChoixModeleDlg: TChoixModeleDlg;

implementation

uses regmain;

{$R *.DFM}

const
    iFonction = 0;
    iEquaDiff1 = 1;
    iEquaDiff2 = 2;


procedure TChoixModeleDlg.GenreModeleRGClick(Sender: TObject);
begin
      MajTexte;
      PageControlChange(sender);
end;

Procedure TChoixModeleDlg.MajTexte;
begin
   with fonctionTheorique[succ(nbreModele)] do begin
      deriveeLabel.visible := GenreModeleRG.itemIndex=2;
      enTete := grandeurs[indexY].nom;
      case GenreModeleRG.itemIndex of
            iEquaDiff2 : begin
                enTete:=enTete+'''''';
                indexYp := indexDerivee(grandeurs[indexY],grandeurs[0],false,true);
                deriveeLabel.caption := stDerivee+'='+grandeurs[indexYp].nom;
            end;
            iEquaDiff1 : enTete:=enTete+'''';
            iFonction : enTete:=enTete+'('+grandeurs[indexX].nom+')';
      end;
      yedit.text := enTete+'='+expression;
      if pageControl.ActivePage=ModManuel then begin
         yedit.setFocus;
         yedit.selStart := length(yedit.text);
         yedit.selLength := 0;
      end;
end end;

procedure TChoixModeleDlg.AjouteBtnClick(Sender: TObject);
var posErreur,longErreur : integer;

Procedure SetErreur;
begin
   modalResult := mrNone;
   with fonctionTheorique[succ(NbreModele)] do begin
        afficheErreur(codeErreurC,0);
        with yedit do begin
             setFocus;
             selStart := pred(posErreur);
             selLength := longErreur;
        end;
   end;
end;

begin
    EffaceModele := false;
    ModeleFacteurQualite := QualiteRG.ItemIndex>0;
    modeleCosinus := cosinusCB.Checked;
    if pageControl.ActivePage=modManuel then begin
        ModeleChoisi := mgManuel;
        posErreur := 0;
        longErreur := 0;
        codeErreurC := '';
        EffaceModele := false;
        if fonctionTheorique[succ(NbreModele)].compileM(yedit.text,posErreur,longErreur)
           then inc(NbreModele)
           else setErreur;
    end
    else begin
       inc(NbreModele);
       modeleDecibel := decibelCB.checked;
    end;
end;

procedure TChoixModeleDlg.HelpBtnClick(Sender: TObject);
begin
     if PageControl.activePage=ModManuel
        then Aide( HELP_Modelisation)
        else Aide( HELP_ModelisationGraphique)
end;

procedure TChoixModeleDlg.CalculetteBtnClick(Sender: TObject);
begin
     Aide(HELP_Modelisation)
end;

procedure TChoixModeleDlg.FormActivate(Sender: TObject);

function Verif(Apage : TtabSheet) : boolean;
var i : integer;
begin
     verif := false;
     for i := 0 to pred(Apage.controlCount) do
            if (Apage.controls[i] is TspeedButton) and
               ((Apage.controls[i] as TspeedButton).tag=ord(modeleChoisi))
                   then begin
                        (Apage.controls[i]as TspeedButton).down := true;
                        verif := true;
                        break;
                    end;
end;

procedure VerifCoordonnee;
var i,nbre : integer;
begin
    for i := 1 to maxOrdonnee do with coordonnee[i] do begin
        codeY := indexNom(nomY);
        if (codeY<>grandeurInconnue) and
           (grandeurs[codeY].genreG<>variable)
           then codeY := grandeurInconnue;
        codeX := indexNom(nomX);
        if (codeX<>grandeurInconnue) and
           (grandeurs[codeX].genreG<>variable)
           then codeX := grandeurInconnue;
    end;
    nbre := 0;
    for i := 1 to maxOrdonnee do with coordonnee[i] do
        if (codeX<>grandeurInconnue) and
           (codeY<>grandeurInconnue)
           then begin
              inc(nbre);
              coordonnee[nbre] := coordonnee[i];
           end;
    for i := succ(Nbre) to maxOrdonnee do with coordonnee[i] do begin
         codeX := grandeurInconnue;
         nomX := '';
         codeY := grandeurInconnue;
         nomY := '';
    end;
    if nbre=0 then with coordonnee[1] do begin
          codeX := indexVariab[0];
          nomY := grandeurs[0].nom;
          codeY := indexVariab[1];
          nomY := grandeurs[1].nom;
          nbre := 1;
    end; // nbre=0
    CoordRG.Visible := nbre>1;
    CoordRG.Items.Clear;
    for i := 1 to nbre do with coordonnee[i] do
        CoordRG.Items.Add(nomY+'('+nomX+')');
    CoordRG.itemIndex := 0;
end;

begin
     inherited;
     if NbreModele>0 then with fonctionTheorique[1] do begin
           if genreC=g_fonction then genreModeleRG.itemIndex := 0;
           if genreC=g_diff1 then genreModeleRG.itemIndex := 1;
           if genreC=g_diff2 then genreModeleRG.itemIndex := 2;
     end;
     if NbreModele>0
        then if AppelMagnum
             then begin
                 AjouteBtn.caption := stAddModele;
                 NouveauBtn.caption := stReplaceModele;
                 NouveauBtn.visible := true;
                 AjouteBtn.visible := NbreModele<4;
             end
             else begin
                 AjouteBtn.caption := '&OK';
                 AjouteBtn.visible := true;
                 NouveauBtn.visible := false;
             end
        else begin
            genreModeleRG.itemIndex := 0;
            AjouteBtn.visible := false;
            NouveauBtn.caption := '&OK';
            NouveauBtn.visible := true;
        end;
     QualiteRG.ItemIndex := ord(ModeleFacteurQualite);
     cosinusCB.checked := modeleCosinus;
     decibelCB.checked := modeleDecibel;
     if appelMagnum then if verif(ModMagnum)
           then PageControl.ActivePage := ModMagnum
           else if verif(ModSinus)
           then PageControl.ActivePage := ModSinus
           else if verif(ModFiltres)
           then PageControl.ActivePage := ModFiltres
           else if PageControl.ActivePage=ModManuel
           then PageControl.ActivePage := ModMagnum;
     VerifCoordonnee;
     MajTexte;
end;

procedure TChoixModeleDlg.FormCreate(Sender: TObject);
begin
      VirtualImageList1.height := VirtualImageListSize;
      VirtualImageList1.width := VirtualImageListSize;
end;

procedure TChoixModeleDlg.ModeleBtnClick(Sender: TObject);
begin
     ModeleChoisi := TgenreModeleGr((sender as Tcomponent).tag)
end;

procedure TChoixModeleDlg.NouveauBtnClick(Sender: TObject);
var posErreur,longErreur : integer;

Procedure SetErreur;
begin
   modalResult := mrNone;
   with fonctionTheorique[succ(NbreModele)] do begin
        afficheErreur(codeErreurC,0);
        with yedit do begin
             setFocus;
             selStart := pred(posErreur);
             selLength := longErreur;
        end;
   end;
end;

begin
    EffaceModele := true;
    ModeleFacteurQualite := QualiteRG.ItemIndex>0;
    modeleCosinus := cosinusCB.Checked;
    if pageControl.ActivePage=ModManuel
       then begin
          ModeleChoisi := mgManuel;
          posErreur := 0;
          longErreur := 0;
          fonctionTheorique[1].indexY := fonctionTheorique[succ(NbreModele)].indexY;
          fonctionTheorique[1].indexX := fonctionTheorique[succ(NbreModele)].indexX;           
          if fonctionTheorique[1].compileM(yedit.text,posErreur,longErreur)
             then NbreModele := 1
             else setErreur
      end
      else begin
         NbreModele := 1;
         modeleDecibel := decibelCB.checked;
      end;
end;

procedure TChoixModeleDlg.PageControlChange(Sender: TObject);
var i : integer;
    trouve : boolean;
begin
      with fonctionTheorique[1] do
      AjouteBtn.visible := (NbreModele>0) and
                           (NbreModele<maxIntervalles) and
          ((genreC=g_fonction) and
           ((pageControl.activePage<>modManuel) or (genreModeleRG.itemIndex=0)) or
           ((genreC=g_diff1) and
            (pageControl.activePage=modManuel) and
            (genreModeleRG.itemIndex=1)) or
           ((genreC=g_diff2) and
            (pageControl.activePage=modManuel) and
            (genreModeleRG.itemIndex=2)));
     if pageControl.ActivePage<>ModManuel then begin
        trouve := false;
        for i := 0 to pred(pageControl.ActivePage.controlCount) do
            if (pageControl.ActivePage.controls[i] is TspeedButton) and
               ((pageControl.ActivePage.controls[i] as TspeedButton).tag=ord(modeleChoisi))
                   then begin
                        (pageControl.ActivePage.controls[i] as TspeedButton).down := true;
                        trouve := true;
                        break;
                    end;
         if not trouve then
            for i := 0 to pred(pageControl.ActivePage.controlCount) do
            if (pageControl.ActivePage.controls[i] is TspeedButton) and
               (pageControl.ActivePage.controls[i] as TspeedButton).down
                   then begin
                        ModeleChoisi := TgenreModeleGr((pageControl.ActivePage.controls[i] as TspeedButton).tag);
                        break;
                    end;
     end;
end;

procedure TChoixModeleDlg.helpMagnumBtnClick(Sender: TObject);
begin
     if pageControl.ActivePage=ModManuel
        then Aide(HELP_Modelisation)
        else Aide(HELP_ModelisationGraphique)
end;

procedure TChoixModeleDlg.ModeleBtnDblClick(Sender: TObject);
begin
     ModeleChoisi := TgenreModeleGr((sender as Tcomponent).tag);
     NouveauBtnClick(sender);
     modalResult := mrOK;
end;

procedure TChoixModeleDlg.CoordRGClick(Sender: TObject);
var i : integer;
begin
   with fonctionTheorique[succ(nbreModele)] do begin
        i := CoordRG.itemIndex+1;
        with coordonnee[i] do begin
           indexY := codeY;
           indexX := codeX;
        end;
        MajTexte;        
   end;
end;

end.
