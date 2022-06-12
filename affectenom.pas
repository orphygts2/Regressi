unit affectenom;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, Buttons, inifiles, constreg,
  regutil, compile, keysU, aidekey;

type
  TAffecteNomDlg = class(TForm)
    StringGrid: TStringGrid;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    TriCB: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure StringGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
  private
      IniMeteo : TIniFile;
      NomRef,NomMeteo,UniteMeteo,SignifMeteo : TstringList;
      IndexMeteo : array[TcodeGrandeur] of TcodeGrandeur;
  public
  end;

var
  AffecteNomDlg: TAffecteNomDlg;

implementation

{$R *.DFM}

procedure TAffecteNomDlg.FormCreate(Sender: TObject);
var i : integer;
    zzz : string;
begin
     NomRef := TstringList.create;
     NomMeteo := TstringList.create;
     UniteMeteo := TstringList.create;
     SignifMeteo := TstringList.create;
     try
     IniMeteo := TIniFile.create(NomFichierIni);
     IniMeteo.ReadSection('NomMeteo',NomRef);
     for i := 0 to pred(NomRef.count) do begin
         zzz := IniMeteo.ReadString('NomMeteo',NomRef[i],'');
         NomMeteo.add(zzz);
         zzz := IniMeteo.ReadString('UniteMeteo',NomRef[i],'');
         UniteMeteo.add(zzz);
         zzz := IniMeteo.ReadString('SignifMeteo',NomRef[i],'');
         SignifMeteo.add(zzz);
     end;
     except
     end;
     stringGrid.ColWidths[0] := largeurUnCarac*14;
     stringGrid.ColWidths[1] := largeurUnCarac*8;
     stringGrid.ColWidths[2] := largeurUnCarac*8;
     stringGrid.cells[0,0] := 'Signification';
     stringGrid.cells[1,0] := stNom;
     stringGrid.cells[2,0] := stUnite;
end;

procedure TAffecteNomDlg.FormActivate(Sender: TObject);
var i,j,ligne,imax : integer;
    trouve : boolean;
begin
     inherited;
     StringGrid.rowCount := succ(NbreVariab);
     TriCB.Checked := DataTrieGlb;
     if grandeurs[0].nom='var1'
        then begin
            stringGrid.FixedCols := 0;
            if nbreVariab<nomMeteo.count
               then imax := (NbreVariab-1)
               else imax := nomMeteo.count-1;
            for i := 0 to imax do with grandeurs[i] do
                if nomMeteo[i]<>'' then nom := nomRef[i];
        end
        else stringGrid.FixedCols := 1;
     for i := 0 to pred(NbreVariab) do with grandeurs[i] do begin
         ligne := succ(i);
         trouve := false;
         for j := 0 to pred(NomRef.count) do
             if nom=nomRef[j] then begin
                nom := nomMeteo[j];
                nomUnite := uniteMeteo[j];
                fonct.expression := signifMeteo[i];
                indexMeteo[i] := j;
                trouve := true;
                break;
             end;
         if not trouve then begin
            NomRef.add(nom);
            NomMeteo.add(nom);
            UniteMeteo.add(nomUnite);
            SignifMeteo.add(fonct.expression);
            indexMeteo[i] := pred(NomRef.count);
         end;
         stringGrid.cells[1,ligne] := nom;
         stringGrid.cells[2,ligne] := nomUnite;
         stringGrid.cells[0,ligne] := fonct.expression;
     end;
end;

procedure TAffecteNomDlg.OKBtnClick(Sender: TObject);
var i,j,ligne : integer;
    Lnom : string;
begin
     for i := 0 to pred(NbreVariab) do with grandeurs[i] do begin
         ligne := succ(i);
         Lnom := stringGrid.cells[1,ligne];
         trimAscii127(Lnom);
         if not NomCorrect(Lnom, i) then begin
            afficheErreur(codeErreurC,0);
            modalResult := mrNone;
            exit;
         end;
         nom := Lnom;
         Lnom := stringGrid.cells[2,ligne];
         trimAscii127(Lnom);
         nomUnite := Lnom;
         if stringGrid.FixedCols=0 then fonct.expression := stringGrid.cells[0,ligne];
         j := indexMeteo[i];
// Sauvegarde pour effectuer modif auto la prochaine fois
         IniMeteo.WriteString('NomMeteo',NomRef[j],nom);
         nomMeteo[j] := nom;
         IniMeteo.WriteString('UniteMeteo',NomRef[j],nomUnite);
         uniteMeteo[j] := nomUnite;
         IniMeteo.WriteString('SignifMeteo',NomRef[j],fonct.expression);
         signifMeteo[j] := fonct.expression;
     end;
     FichierTrie := TriCB.checked;
end;

procedure TAffecteNomDlg.StringGridSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
     sendVirtualKey(vk_F2)
end;

procedure TAffecteNomDlg.FormDestroy(Sender: TObject);
begin
     NomRef.free;
     NomMeteo.free;
     UniteMeteo.free;
     SignifMeteo.free;
     IniMeteo.free;
     inherited
end;

procedure TAffecteNomDlg.HelpBtnClick(Sender: TObject);
begin
     Aide(0)  { TODO : aide modif nom }
end;

end.
