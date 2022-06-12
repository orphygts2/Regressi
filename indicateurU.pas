unit indicateurU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  vcl.graphUtil,
  Dialogs, ExtCtrls, math, StdCtrls, inifiles, contnrs, Buttons,
  maths, regutil, Vcl.Mask;

type
  Tindicateur = class
      private
      FcouleurBase,FcouleurAcide : Tcolor;
      FincoloreA,FincoloreB,Fincolore : boolean;
      Ha,Sa,La,Hb,Sb,Lb : word; // Hue Saturation Luminance
      constructor create;
      procedure setCouleurBase(Acouleur : Tcolor);
      procedure setCouleurAcide(Acouleur : Tcolor);
      function getABincolore : boolean;
      public
      nom : string;
      pKa,dpka : double;
      property couleurBase : tcolor read FcouleurBase write setCouleurBase;
      property AcideBaseIncolore : boolean read getABincolore;
      property incolore : boolean read Fincolore;
      property couleurAcide : tcolor read FcouleurAcide write setCouleurAcide;
      function couleurph(ph : double) : Tcolor;
      procedure charge(ini : TMemInifile;const section : string);
      procedure sauve(ini : TMemInifile);
  end;
  TindicateurDlg = class(TForm)
    PaintBox1: TPaintBox;
    acideCB: TColorBox;
    baseCB: TColorBox;
    Label2: TLabel;
    Label3: TLabel;
    nomEdit: TLabeledEdit;
    IndicateurCB: TComboBox;
    pkaEdit: TLabeledEdit;
    SaveBtn: TBitBtn;
    AddBtn: TBitBtn;
    Bevel: TBevel;
    dpkaEdit: TLabeledEdit;
    BitBtn1: TBitBtn;
    ResetBtn: TBitBtn;
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AddClick(Sender: TObject);
    procedure IndicateurCBChange(Sender: TObject);
    procedure acideCBChange(Sender: TObject);
    procedure baseCBChange(Sender: TObject);
    procedure pkaseChange(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure dpkaEditChange(Sender: TObject);
    procedure nomEditChange(Sender: TObject);
    procedure nomEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ResetBtnClick(Sender: TObject);
    procedure ecritFichierIndic(const nom : string);
  private
    indicateur : Tindicateur;
    nomIni,nomIniBis : string;
  public
    indicateurs : TobjectList;
  end;

var
  indicateurDlg: TindicateurDlg;

implementation

{$R *.dfm}

type
 TindicateurRecord = Record
      n : string;
      p,dp : double;
      cA,cB : Tcolor;
  end;

const
Nindic = 10;
IndicateurDefaut : array[0..Nindic] of TIndicateurRecord = (
(n: 'Bleu de thymol A';    p: 2;   dp: 0.8;  cA : 65535;   cB: 1000959),
(n: 'Jaune de méthyle';    p: 3.5; dp: 0.6;  cA: 65535;    cB: 1000959),   // rouge jaune
(n: 'Hélianthine';         p: 3.8; dp: 0.7;  cA: 65535;    cB: 1000959),
(n: 'Bleu de bromophénol'; p: 4.1; dp: 0.8;  cA: 65535;    cB: 1000959),  // jaune bleu
(n: 'Vert de bromocresol'; p: 4.6; dp: 0.8;  cA: 16776960; cB: 65535),
(n: 'Rouge de méthyle';    p: 5.4; dp: 1;    cA: 65535;    cB: 1000959),
(n: 'Bleu de bromothymol'; p: 6.6; dp: 0.8;  cA: 16776960; cB: 65535),
(n: 'Rouge de phénol';     p: 7.6; dp: 0.8;  cA: 4281598;  cB: 65535),
(n: 'Bleu de thymol B';    p: 8.8; dp: 0.8;  cA: 16711680; cB: 16711935),
(n: 'Phénolphtaléine';     p: 9.1; dp: 0.9;  cA: 16711935; cB: 16777215),
(n: 'Jaune d''alizarine';  p: 11.1; dp: 0.9;  cA: 65535;    cB: 1000959) // jaune rouge
);


procedure TindicateurDlg.PaintBox1Paint(Sender: TObject);
var coeff : double;
    i : integer;
begin
  coeff := 14/paintBox1.width;
  for i := 0 to paintBox1.width do with paintBox1.canvas do begin
      pen.color := indicateur.couleurph(i*coeff);
      moveto(i,0);
      lineto(i,paintBox1.height);
  end;
end;

function Tindicateur.couleurph(ph : double) : Tcolor;
var acide,base : double;
    H,L,S:  INTEGER;
begin
    if ph<pka-dpka
       then begin
          result := FcouleurAcide;
          Fincolore := FincoloreA;
       end
       else if ph>pka+dpka
       then begin
          result := FcouleurBase;
          Fincolore := FincoloreB;
       end
       else begin
         acide := (pKa+dpka*1.1-ph)/(dpka*2.2);
         base := 1 - acide;
         h := round(base*Hb+acide*Ha);
         h := h mod 240; // h 0..240
         s := round(base*Sb+acide*Sa);
         l := round(base*Lb+acide*La);
         Fincolore := (s<16) and (l>200);
         result := ColorHLSToRGB(H,L,S);
    end;
end;

procedure TindicateurDlg.FormCreate(Sender: TObject);

procedure litFichier(const nom : string);
var nomIndic : TstringList;
    ini : tmeminifile;
    i : integer;
begin
  if FileExists(Nom) then begin
     ini := tMemInifile.create(nom);
     nomIndic := TstringList.create;
     ini.readSections(nomIndic);
     for i := 0 to pred(nomIndic.count) do begin
        indicateur := Tindicateur.create;
        indicateur.charge(ini,nomIndic[i]);
        if indicateurCB.items.indexOf(indicateur.nom)<0 then begin
           indicateurs.add(indicateur);
           indicateurCB.AddItem(indicateur.nom,indicateur);
        end
        else indicateur.free;
     end;
     ini.Free;
     nomIndic.Free;
  end;
end;

var i : integer;
begin
{$IFDEF Debug}
   ecritDebug('Début formCreate indicateur');
{$ENDIF}
  nomIni := extractFilePath(application.ExeName)+'indicateur.ini';
  nomIniBis := mesDocsDir+'indicateur.ini';
  indicateurs := TobjectList.create;
  litFichier(NomIni);
  litFichier(NomIniBis);
  if indicateurs.count=0 then begin
     for I := 0 to Nindic do begin
         indicateur := Tindicateur.create;
         indicateur.nom := IndicateurDefaut[i].n;
         indicateur.pKa := IndicateurDefaut[i].p;
         indicateur.dPka := IndicateurDefaut[i].dp;
         indicateur.CouleurBase := IndicateurDefaut[i].cB;
         indicateur.CouleurAcide := IndicateurDefaut[i].cA;
         indicateurs.add(indicateur);
         indicateurCB.AddItem(indicateur.nom,indicateur);
     end;
  end;
  indicateurCB.ItemIndex := 0;
  ResizeButtonImagesforHighDPI(self);
end;

procedure TindicateurDlg.nomEditChange(Sender: TObject);
begin
    indicateur.nom := nomEdit.text;
end;

procedure TindicateurDlg.nomEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key=ord(crCR) then nomEditChange(sender)
end;

procedure Tindicateur.setCouleurBase(Acouleur : Tcolor);
begin
  FcouleurBase := Acouleur;
  ColorRGBToHLS(Acouleur,Hb,Lb,Sb);
  if abs(Ha-Hb)>120 then if Ha>Hb then Hb := Hb+240 else Ha := Ha+240;
 // il faut prendre la couleur pondérée dans l'angle rentrant
  FincoloreB := (sB<16) and (lB>200);
end;

procedure Tindicateur.setCouleurAcide(Acouleur : Tcolor);
begin
  FcouleurAcide := Acouleur;
  ColorRGBToHLS(Acouleur,Ha,La,Sa);
  if abs(Ha-Hb)>120 then if Ha<Hb then Ha := Ha+240 else Hb := Hb+240;
  FincoloreA := (sA<16) and (lA>200);
end;

procedure Tindicateur.charge(ini : TMemInifile;const section : string);
begin
     nom := section;
     pKa := iniReadFloat(ini,section,'pka',7);
     dpKa := iniReadFloat(ini,section,'dpka',1);
     couleurBase := Ini.readInteger(section,'CouleurBase',clRed);
     couleurAcide := Ini.readInteger(section,'CouleurAcide',clBlue);
end;

procedure Tindicateur.sauve(ini : TMemInifile);
begin
     Ini.writeFloat(nom,'pka',pka);
     Ini.writeFloat(nom,'dpka',dpka);     
     Ini.writeInteger(nom,'CouleurBase',FcouleurBase);
     Ini.writeInteger(nom,'CouleurAcide',FcouleurAcide);
end;

constructor Tindicateur.create;
begin
     nom := 'BBT';
     pKa := 7;
     dpka := 1;
     couleurBase := clYellow;
     couleurAcide := clBlue;
end;

procedure TindicateurDlg.AddClick(Sender: TObject);
begin
    indicateur := Tindicateur.create;
    pkaEdit.text := floatToStrF(indicateur.pka,ffFixed,3,1);
    dpkaEdit.text := floatToStrF(indicateur.dpka,ffFixed,3,1);
    baseCB.selected := indicateur.couleurBase;
    acideCB.selected := indicateur.couleurAcide;
    nomEdit.text := indicateur.nom;
    indicateurs.add(indicateur);
    indicateurCB.OnChange := nil;
    indicateurCB.AddItem(indicateur.nom,indicateur);
    indicateurCB.ItemIndex := indicateurCB.items.count-1;
    indicateurCB.OnChange := indicateurCBChange;
end;

procedure TindicateurDlg.IndicateurCBChange(Sender: TObject);
begin
  indicateur := Tindicateur(indicateurCB.items.objects[indicateurCB.itemIndex]);
  pkaEdit.text := floatToStrF(indicateur.pka,ffFixed,3,1);
  dpkaEdit.text := floatToStrF(indicateur.dpka,ffFixed,3,1);
  baseCB.selected := indicateur.couleurBase;
  acideCB.selected := indicateur.couleurAcide;
  nomEdit.text := indicateur.nom;
  paintBox1.Repaint
end;

procedure TindicateurDlg.acideCBChange(Sender: TObject);
begin
    indicateur.couleurAcide := acideCB.selected;
    paintBox1.Repaint
end;

procedure TindicateurDlg.baseCBChange(Sender: TObject);
begin
    indicateur.couleurBase := baseCB.selected;
    paintBox1.Repaint
end;

procedure TindicateurDlg.pkaseChange(Sender: TObject);
begin
    try
    indicateur.pKa := strToFloatWin(pkaEdit.text);
    paintBox1.Repaint;
    except
    pkaEdit.text := floatToStrF(indicateur.pka,ffFixed,3,1);
    end;
end;

procedure TindicateurDlg.ResetBtnClick(Sender: TObject);
var i : integer;
begin
     indicateurs.Clear;
     for i := 0 to Nindic do begin
         indicateur := Tindicateur.create;
         indicateur.nom := IndicateurDefaut[i].n;
         indicateur.pKa := IndicateurDefaut[i].p;
         indicateur.dPka := IndicateurDefaut[i].dp;
         indicateur.CouleurBase := IndicateurDefaut[i].cB;
         indicateur.CouleurAcide := IndicateurDefaut[i].cA;
         indicateurs.add(indicateur);
         indicateurCB.AddItem(indicateur.nom,indicateur);
     end;
     indicateurCB.ItemIndex := 0;
     try
     ecritFichierIndic(nomIni);
     except
     ecritFichierIndic(nomIniBis);
     end;
end;

procedure TindicateurDlg.SaveBtnClick(Sender: TObject);
begin
    try
    ecritFichierIndic(nomIni);
    except
    ecritFichierIndic(nomIniBis);
    end;
end;

function Tindicateur.GetABincolore : boolean;
begin
     result := FincoloreA or FincoloreB
end;

procedure TindicateurDlg.dpkaEditChange(Sender: TObject);
begin
    try
    indicateur.dpKa := strToFloatWin(dpkaEdit.text);
    paintBox1.Repaint;
    except
    dpkaEdit.text := floatToStrF(indicateur.dpka,ffFixed,3,1);
    end;
end;

procedure TindicateurDlg.ecritFichierIndic(const nom : string);
var ini : tmeminifile;
    i : integer;
begin
    ini := tMemInifile.create(nom);
    try
    for i := 0 to pred(indicateurs.count) do
        Tindicateur(indicateurs[i]).sauve(ini);
    ini.updateFile;
    finally
      ini.free
    end;
end;

end.
