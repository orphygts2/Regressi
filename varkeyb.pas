unit varkeyb;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, Grids, sysUtils,
  vcl.HtmlHelpViewer,
  constreg, regutil, math, maths, uniteker, graphker, compile,
  valeurs, graphvar, aideKey;

type
  TNewClavierDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    VariabGB: TGroupBox;
    GridVariab: TStringGrid;
    ConstGB: TGroupBox;
    GridConst: TStringGrid;
    MemoGB: TGroupBox;
    MemoClavier: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    IncrementAutoCB: TCheckBox;
    Label3: TLabel;
    TriCB: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure GridVariabKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure HelpBtnClick(Sender: TObject);
    procedure IncrementAutoCBClick(Sender: TObject);
    procedure GridVariabKeyPress(Sender: TObject; var Key: Char);
  private
  public
    grapheMinMax : boolean;
  end;

var
  NewClavierDlg: TNewClavierDlg;

implementation

uses Regmain;

{$R *.DFM}

procedure TNewClavierDlg.FormCreate(Sender: TObject);
var i,Acol,Arow : integer;
begin
     with GridVariab do begin
         cells[0,0] := stSymbole;
         cells[2,0] := stSignif;
         cells[1,0] := stUnite;
         cells[3,0] := stMinimum;
         cells[4,0] := stMaximum;
         for i := 1 to 4 do begin
             cells[3,i] := '0';
             cells[4,i] := ''; // ou '1' ?
         end;
         for Acol := 0 to pred(colCount) do
             for Arow := 0 to pred(rowCount) do
                 cells[col,row] := '';
         col := 0;
         row := 1;
   //      DefaultRowHeight := hauteurColonne;
   //      defaultColWidth := largeurUnCarac*8;
     end;
     with gridConst do begin
         cells[0,0] := stSymbole;
         cells[1,0] := stUnite;
         cells[2,0] := stSignif;
         for Acol := 0 to pred(colCount) do
             for Arow := 0 to pred(rowCount) do
               cells[col,row] := '';
        col := 0;
        row := 1;
   //     DefaultRowHeight := hauteurColonne;
   //     defaultColWidth := largeurUnCarac*8;
     end;
     ResizeButtonImagesforHighDPI(self);
end;

procedure TNewClavierDlg.OKBtnClick(Sender: TObject);
var indexMondeMax : integer;

Function Ajoute(G : TstringGrid;i : integer) : boolean;
var j : integer;
    u : Tunite;
    uniteOK : boolean;
    v : TcodeGrandeur;
    newNom : string;
    indexMonde : integer;
begin
Result := false;
with G do if cells[0,i]<>''
       then begin
            NewNom := cells[0,i];
            trimComplet(NewNom);
            if NomCorrect(newNom,grandeurInconnue)
               then begin
                   U := Tunite.create;
                   try
                   U.nomUnite := cells[1,i];
                   UniteOK := U.correct;
                   if pos('°',U.nomUnite)>0 then AngleEnDegre := true;
                   if pos('rad',U.nomUnite)>0 then AngleEnDegre := false;
                   finally
                     U.free;
                   end;
                   if not UniteOK and not OKReg(OkUniteInconnue,HELP_Unites) then begin
                       row := i;
                       col := 1;
                       resetEnTete;
                       exit;
                   end;
                   if G=GridVariab
                      then with FgrapheVariab.Graphes[1] do begin
                          indexMonde := indexMondeMax;
                          for j := 2 to pred(i) do
                              if cells[1,i]=cells[1,j] then
                                   indexMonde := Coordonnee[pred(j)].iMondeC;
                          with monde[indexMonde] do begin
                            Graduation := gLin;                          
                            try
                              setMinMaxDefaut(getFloat(cells[3,i]),
                                              getFloat(cells[4,i]));
                            except
                              if i<=2 then grapheMinMax := false;
                            end;
                         end;
                         if i=1
                            then for j := 1 to 4 do
                                 Coordonnee[j].nomX := NewNom
                            else begin
                                 Coordonnee[pred(i)].nomY := NewNom;
                                 Coordonnee[pred(i)].iMondeC := indexMonde;
                            end;
                         if indexMonde=indexMondeMax then inc(indexMondeMax);
                         v := ajouteExperimentale(newNom,variable);
                         grandeurs[v].fonct.expression := cells[2,i];
                         monde[indexMonde].axe := grandeurs[v];
                      end
                      else v := ajouteExperimentale(newNom,constante);
                   grandeurs[v].NomUnite := cells[1,i];
                   if '°'=Grandeurs[v].nomUnite then AngleEnDegre := true;
                   if 'rad'=Grandeurs[v].nomUnite then AngleEnDegre := false;
               end
               else begin
                   resetEnTete;
                   afficheErreur(codeErreurC,0);
                   row := i;
                   col := 0;
                   exit;
               end;
        end;
    Result := true;
end;

var i : integer;
begin
     if not FregressiMain.verifSauve then begin
        modalResult := mrCancel;
        exit;
     end;
     grapheMinMax := true;
     FichierTrie := not TriCB.checked;
     NomFichierData := '';
     ModeAcquisition := AcqClavier;
     indexMondeMax := mondeX;
     for i := 1 to 4 do if not Ajoute(gridVariab,i) then begin
         modalResult := mrNone;
         gridVariab.setFocus;
         exit;
     end;
     for i := 1 to 2 do if not Ajoute(gridConst,i) then begin
         modalResult := mrNone;
         gridConst.setFocus;
         exit;
     end;
     for i := 0 to pred(MemoClavier.Lines.Count) do
         if MemoClavier.lines[i]<>'' then
            Fvaleurs.Memo.Lines.Add(''''+MemoClavier.lines[i]);
     modalResult := mrOK;            
end;

procedure TNewClavierDlg.FormActivate(Sender: TObject);
begin
     inherited;
     gridVariab.col := 0;
     gridVariab.row := 1;
     gridConst.col := 0;
     gridConst.row := 1;
     TriCB.Checked := not DataTrieGlb;
     MemoClavier.clear;
     GridVariab.SetFocus;
end;

procedure TNewClavierDlg.GridVariabKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if key=vk_return then  with (sender as TstringGrid) do
        if col<4
           then col := col+1
           else if (row+1)<rowCount then begin
                row := row+1;
                col := 0;
           end
end;

procedure TNewClavierDlg.GridVariabKeyPress(Sender: TObject; var Key: Char);
begin
    if (gridVariab.col=0) and not isCaracGrandeur(key) then key := #0;
end;

procedure TNewClavierDlg.HelpBtnClick(Sender: TObject);
begin
     Aide(HELP_EntreedeDonneesauClavier)
end;

procedure TNewClavierDlg.IncrementAutoCBClick(Sender: TObject);
begin
    autoIncrementation := IncrementAutoCB.checked
end;

end.
