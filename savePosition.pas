unit savePosition;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls,CheckLst,
  vcl.HtmlHelpViewer,
  maths, regutil, uniteker, compile, constreg, graphker, aidekey;

type
  TSavePositionDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    GroupBox1: TGroupBox;
    HelpBtn: TBitBtn;
    ParamListBox: TCheckListBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    edit : array[ToptionCurseur] of Tedit;
    signif : array[ToptionCurseur] of Tedit;
    nomVariable : array[ToptionCurseur] of string;
  public
    curseur : Tcurseur;
    graphe : TgrapheReg;
    curseurData : array[1..5] of TcurseurDonnees;
    unitePente : Tunite;
  end;

var
  SavePositionDlg: TSavePositionDlg;

implementation

uses Valeurs, Graphvar;

const
  nomGenre : array[ToptionCurseur] of string =
     ('Valeur ','Valeur ','Pente','Ecart ','Ecart ');
  indexReticule : array[ToptionCurseur] of integer =
     (1,2,0,3,4);


{$R *.DFM}

procedure TSavePositionDlg.FormActivate(Sender: TObject);
var suffixe : string;

procedure Ajoute(genre : ToptionCurseur);
var j : integer;
    actif : boolean;
    index : integer;
begin
       edit[genre].text := '';
       case curseur of
            curReticuleData : actif := genre in graphe.optionCurseur;
            curReticule : actif := genre<>coPente;
            else actif := true;
       end;
       if actif
          then ParamListBox.Items.add(nomGenre[genre]+nomVariable[genre])
          else ParamListBox.Items.add(nomGenre[genre]);
       ParamListBox.itemEnabled[ord(genre)] := actif;
       edit[genre].visible := actif;
       signif[genre].text := '';
       signif[genre].visible := actif;
       for j := 0 to pred(NbreConst) do begin
           index := indexConst[j];
           if Grandeurs[index].isCurseur and
             (Grandeurs[index].optionCurseur=genre) then begin
                 edit[genre].text := Grandeurs[index].nom;
                 signif[genre].text := Grandeurs[index].fonct.expression;
                 ParamListBox.checked[ord(genre)] := actif;
                 break;
           end;
       end;
       if edit[genre].text='' then
          case genre of
               coX : edit[genre].text := FgrapheVariab.varXPos.nom+suffixe;
               coY : edit[genre].text := FgrapheVariab.varYPos.nom+suffixe;
               coPente : edit[genre].text := stPente;
               coDeltax : edit[genre].text := 'ƒ'+FgrapheVariab.varXPos.nom;
               coDeltaY : edit[genre].text := 'ƒ'+FgrapheVariab.varYPos.nom;
          end;
end;

var i : integer;
    un : boolean;
    genre,genreMax : ToptionCurseur;
begin
       inherited;
       NomVariable[coX] := FgrapheVariab.varXPos.nom;
       NomVariable[coY] := FgrapheVariab.varYPos.nom;
       NomVariable[coPente] := '';
       NomVariable[coDeltaX] := FgrapheVariab.varXPos.nom;
       NomVariable[coDeltaY] := FgrapheVariab.varYPos.nom;
       ParamListBox.Clear;
       genreMax := coY;
       if curseur=curEquivalence then genreMax := coPente;
       if (curseur=curReticule) and
           FgrapheVariab.mesureDelta then genreMax := coDeltaY;
       for genre := low(ToptionCurseur) to high(ToptionCurseur) do begin
           edit[genre].visible := false;
           signif[genre].visible := false;
           if curseur=curReticuleData then
              if (genre in graphe.optionCurseur) then genreMax := genre;
        end;
        if curseur=curEquivalence
           then suffixe := 'eq'
           else suffixe := '0';
        for genre := low(ToptionCurseur) to genreMax do Ajoute(genre);
        Un := false;
        for i := 0 to pred(ParamListBox.items.count) do
            Un :=  Un or ParamListBox.checked[i];
        if not Un then
           for i := 0 to 1 do
               ParamListBox.checked[i] := true;
end;

procedure TSavePositionDlg.OKBtnClick(Sender: TObject);
var indexP : integer;
    i : integer;
    optCurseur : ToptionCurseur;
begin
     for i := 0 to pred(ParamListBox.count) do
          if ParamListBox.checked[i] then begin
             optCurseur := ToptionCurseur(i);
             indexP := IndexNom(edit[optCurseur].text);
             if indexP=grandeurInconnue then begin
                indexP := AjouteExperimentale(edit[optCurseur].text,constante);
                if indexP=grandeurInconnue then begin
                   afficheErreur(erNomVide,0);
                   edit[optCurseur].SetFocus;
                   modalResult := MrNone;
                end;
                grandeurs[indexP].fonct.expression := signif[optCurseur].text;
                case optCurseur of
                     coX,coDeltaX : grandeurs[indexP].nomUnite := FgrapheVariab.varXPos.nomUnite;
                     coPente : grandeurs[indexP].nomUnite := unitePente.nomUnite;
                     coY,coDeltaY : grandeurs[indexP].nomUnite := FgrapheVariab.varYPos.nomUnite;
                end;
             end;
          grandeurs[indexP].optionCurseur := optCurseur;
          grandeurs[indexP].isCurseur := true;          
          pages[pageCourante].valeurConst[indexP] := graphe.valeurCurseur[optCurseur];
     end;
end;

procedure TSavePositionDlg.HelpBtnClick(Sender: TObject);
begin
     Aide(HELP_SauvegardePosition)
end;

procedure TSavePositionDlg.FormCreate(Sender: TObject);
begin
  inherited;
  edit[coX] := edit1;
  edit[coY] := edit2;
  edit[coPente] := edit3;
  edit[coDeltaX] := edit4;
  edit[coDeltaY] := edit9;
  signif[coX] := edit5;
  signif[coY] := edit6;
  signif[coPente] := edit7;
  signif[coDeltaX] := edit8;
  signif[coDeltaY] := edit10;
end;

end.
