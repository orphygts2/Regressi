unit supprdlg;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, dialogs,
  vcl.HtmlHelpViewer,
  constreg, regutil, maths, compile, ComCtrls;

type
  Toperation = (oSuppression,oTriVariable,oTriPage,oPhase,oFFT);

  TSuppressionDlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    ListeVariableBox: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    TriCB: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
  private
  public
     nomDefaut : string;
     Operation : Toperation;
  end;

var
  SuppressionDlg: TSuppressionDlg;

implementation

uses valeurs;

{$R *.DFM}

procedure TSuppressionDlg.FormActivate(Sender: TObject);
var i : TcodeGrandeur;
    ajoute : boolean;
begin
     inherited;
     TriCB.Visible := operation=oTriVariable;
     TriCB.Checked := FichierTrie;
     ListeVariableBox.Items.Clear;
     ListeVariableBox.multiSelect := false;
     label2.caption := '';
     case operation of
              oTriVariable : begin
                 caption := stTriVariab;
                 label1.caption := hTriDataDlg;
                 label2.caption := hTriVariab;
              end;
              oSuppression : begin
                  caption := stSupprGrandeur;
                  label1.caption := hSupprCalc;
                  label2.caption := hSupprLigne;
              end;
              oTriPage : begin
                  caption := stTriPages;
                  label1.caption := hTriPageDlg;
                  label2.caption := hTriParam;
              end;
              oPhase : begin
                  caption := stPhaseContinue;
                  label1.caption := hTriPhase;
                  label2.caption := hMod2Pi;
              end;
              oFFT : begin
                 caption := 'Fourier';
                 ListeVariableBox.multiSelect := true;
                 label1.caption := 'Fourier';
              end;
     end;
     for i := 0 to pred(NbreGrandeurs) do with grandeurs[i] do begin
         case operation of
              oTriVariable : ajoute := (genreG=variable);
              oSuppression : begin
                 ajoute := (fonct.genreC=g_experimentale) or
                           (fonct.genreC=g_texte);
                 if ModeAcquisition=AcqSimulation
                    then ajoute := ajoute and (genreG<>variable);
              end;
              oTriPage : ajoute := genreG=constante;
              oPhase : ajoute := (genreG=variable) and
                                 ((fonct.genreC=g_experimentale) or
                                  (isAngle));
              oFFT : ajoute := (genreG=variable) and
                               (fonct.genreC<>g_texte);
              else ajoute := false;
         end; // case operation
         if ajoute then ListeVariableBox.Items.add(nom);
     end;
     if operation=oTriPage then
        for i := 1 to NbreParam[paramNormal] do
             ListeVariableBox.Items.add(Parametres[paramNormal,i].nom);
     ListeVariableBox.itemIndex := ListeVariableBox.Items.indexOf(NomDefaut);
     ListeVariableBox.upDate;
end;

procedure TSuppressionDlg.OKBtnClick(Sender: TObject);
var i,index : integer;
    p : TcodePage;
    sauveGrandeur : Tgrandeur;
    DeuxPi : double;
    g : tgrandeur;
    posErreur,longErreur : integer;
    indexNew : integer;
begin
     try
     index := indexNom(ListeVariableBox.items[ListeVariableBox.itemIndex]);
     except
     index := grandeurInconnue;
     end;
     if index<>grandeurInconnue then
     case operation of
          oSuppression : if OKformat(trSupprVar,[grandeurs[index].nom]) then begin
              for i := succ(index) to pred(NbreGrandeurs) do with grandeurs[i].fonct do
                  if (genreC<>g_experimentale) and
                     (index in depend) then expression := '';
// désactiver toutes les grandeurs calculées fonction de grandeurs[index]
             SupprimeGrandeurE(index);
             ModifFichier := true;
             Application.MainForm.perform(WM_Reg_Maj,MajGrandeur,0);
          end;
          oTriPage : begin
               if index<NbreGrandeurs
                   then triConst(index)
                   else begin
                      index := indexToParam(paramNormal,index);
                      if index<>grandeurInconnue then triParam(indexToParam(paramNormal,index));
                   end;
               Application.MainForm.Perform(WM_Reg_Maj,MajTri,0);
          end;
          oPhase : if grandeurs[index].fonct.genreC=g_experimentale then begin
               if angleEnDegre then deuxPi := 360 else DeuxPi := 2*pi;
               for p := 1 to NbrePages do with Pages[p] do begin
                   for i := 1 to pred(nmes) do
                       ValeurVar[index,i] := ValeurVar[index,i]-
                             round((ValeurVar[index,i]-ValeurVar[index,pred(i)])/DeuxPi)*DeuxPi
              end;
          end
          else begin
              G := Tgrandeur.create;
              G.Init( grandeurs[index].nom+'C', grandeurs[index].nomUnite,'PhaseC('+grandeurs[index].nom+')',variable);
              include(G.fonct.depend,index);
              G.compileG(posErreur,longErreur,0);
              indexNew := ajouteGrandeurE(G);
              ReCalculE;
              FValeurs.Memo.Lines.Add(grandeurs[indexNew].nom+'='+grandeurs[indexNew].fonct.expression);
              Application.MainForm.perform(WM_Reg_Maj,MajGrandeur,0);
              ModifFichier := true;
          end; // phase
          oTriVariable : begin
               FichierTrie := false;
               if index<>0 then case grandeurs[index].fonct.genreC of
                  g_experimentale : begin
                     NomGrandeurTri := '';
                     sauveGrandeur := grandeurs[0];
                     grandeurs[0] := grandeurs[index];
                     grandeurs[index] := sauveGrandeur;
                     for p := 1 to NbrePages do
                         pages[p].TransfereVariabP(0,index);
                  end;
                  else begin
                     NomGrandeurTri := grandeurs[index].nom;
                     indexTri := index;
                  end;
               end;
               for p := 1 to NbrePages do begin
                   pages[p].TriAfaire := true;
                   pages[p].tri;
               end;
               FichierTrie := TriCB.checked;
               Application.MainForm.Perform(WM_Reg_Maj,MajTri,0);
          end; // TriVariable
     end; // case
end;

procedure TSuppressionDlg.CancelBtnClick(Sender: TObject);
begin
  if TriCB.visible then FichierTrie := TriCB.checked
end;

end.
