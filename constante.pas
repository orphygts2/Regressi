unit constante;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  SysUtils, StdCtrls, Grids, printers, inifiles, ComCtrls,
  vcl.HtmlHelpViewer,
  constreg, regutil, compile, aidekey;

type
  TConstanteUnivDlg = class(TForm)
    HelpBtn: TBitBtn;
    Tableau: TStringGrid;
    SaveBtn: TBitBtn;
    DefautBtn: TBitBtn;
    Memo1: TMemo;
    procedure HelpBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure DefautBtnClick(Sender: TObject);
  private
  public
    titreConstante,exprConstante,hintConstante : TstringList;
  end;

var
  ConstanteUnivDlg: TConstanteUnivDlg;

implementation

{$R *.DFM}

const
     NbreConstDefault = 12;

     titreConstanteDef : array[1..NbreConstDefault] of string =
     ('g',
      'c',
      mu+'0',
      epsilon+'0',
      'kB',
      'h',
      'F',
      'e',
      'Na',
      'R',
      'jour',
      'ua');

     exprConstanteDef : array[1..NbreConstDefault] of string =
     ('g=9.809_m/s2',
      'c=299792458_m/s',
      mu+'0=4*'+piMin+'*1e-7_H/m',
      epsilon+'0=8.85418782e-12_F/m',
      'kB=1.38066e-23_J/K',
      'h=6.62e-34_Js',
      'F=96485.309_C/mol',
      'e=1.60217733e-19_C',
      'Na=6.022137e23_mol-1',
      'R=8.314_J.mol-1.K-1',
      'jour=86400_s',
      'ua=149597870700_m');

     hintConstanteDef : array[1..NbreConstDefault] of string =
     ('intensité de la pesanteur à Paris',
      'vitesse de la lumière dans le vide',
      'perméabilité du vide',
      'permittivité du vide',
      'constante de Boltzmann',
      'constante de Planck',
      'constante de Faraday',
      'charge élémentaire',
      'constante d''Avogadro',
      'constante des gaz parfaits',
      'jour exprimé en secondes',
      'unité astronomique');


procedure TConstanteUnivDlg.HelpBtnClick(Sender: TObject);
begin
    Aide(HELP_Constantes)
end;

procedure TConstanteUnivDlg.FormCreate(Sender: TObject);
var nomIni : string;

procedure FichierIni;
var nomConst : TstringList;
    ini : tmeminifile;
    section : string;
    i : integer;
begin
  nomConst := TstringList.create;
  ini := tMemInifile.create(nomIni);
  ini.readSections(nomConst);
  if nomConst.count>tableau.RowCount then
       tableau.RowCount := nomConst.count+1;
  for i := 0 to pred(nomConst.count) do begin
      section := nomConst[i];
      tableau.Cells[0,i+1] := section;
      tableau.Cells[1,i+1] := ini.readString(section,'hint','');
      tableau.Cells[2,i+1] := ini.readString(section,'valeur','');
      titreConstante.add(section);
      hintConstante.add(tableau.Cells[1,i+1]);
      exprConstante.add(tableau.Cells[2,i+1]);
  end;
  ini.Free;
end;

begin
  tableau.Cells[0,0] := 'Titre';
  tableau.Cells[1,0] := 'Aide';
  tableau.Cells[2,0] := 'Valeur';
  nomIni := extractFilePath(application.ExeName)+'constante.ini';
  titreConstante := TstringList.create;
  exprConstante :=  TstringList.create;
  hintConstante :=  TstringList.create;
  if FileExists(nomIni)
     then FichierIni
     else DefautBtnClick(nil);
//  tableau.DefaultRowHeight := hauteurColonne;
  ResizeButtonImagesforHighDPI(self);
end;

procedure TConstanteUnivDlg.SaveBtnClick(Sender: TObject);
var nomIni : string;
    ini : tmeminifile;
    i,j : integer;
    section : string;
    OK : boolean;
begin
  nomIni := extractFilePath(application.ExeName)+'constante.ini';
  ini := tMemInifile.create(nomIni);
  titreConstante.clear;
  hintConstante.clear;
  exprConstante.clear;
  ini.clear;
  for i := 1 to pred(tableau.RowCount) do begin
      OK := true;
      for j := 0 to 2 do
          OK := OK and (tableau.Cells[j,i]<>'');
      if OK then begin
         section := tableau.Cells[0,i];
         ini.writeString(section,'hint',tableau.Cells[1,i]);
         ini.writeString(section,'valeur',tableau.Cells[2,i]);
         titreConstante.add(tableau.Cells[0,i]);
         hintConstante.add(tableau.Cells[1,i]);
         exprConstante.add(tableau.Cells[2,i]);
      end;
  end;
  ini.updateFile;
  ini.Free;
end;

procedure TConstanteUnivDlg.DefautBtnClick(Sender: TObject);
var i : integer;
begin
  titreConstante.clear;
  hintConstante.clear;
  exprConstante.clear;
  for i := 1 to NbreConstDefault do begin
      tableau.Cells[0,i] := titreConstanteDef[i];
      tableau.Cells[1,i] := hintConstanteDef[i];
      tableau.Cells[2,i] := exprConstanteDef[i];
      titreConstante.add(titreConstanteDef[i]);
      hintConstante.add(hintConstanteDef[i]);
      exprConstante.add(exprConstanteDef[i]);
  end;
  for i := succ(NbreConstDefault) to pred(tableau.RowCount) do begin
      tableau.Cells[0,i] := '';
      tableau.Cells[1,i] := '';
      tableau.Cells[2,i] := '';
  end;
end;

end.
