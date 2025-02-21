unit latexreg;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, Spin, Dialogs, grids, sysutils, inifiles,
  constreg, regutil, compile, graphker, graphvar, valeurs;

type
  TLatexDlg = class(TForm)
    PanelOption: TPanel;
    HelpBtn: TBitBtn;
    Panel1: TPanel;
    GrandeursCB: TCheckBox;
    VariabGB: TGroupBox;
    TableauVariabCB: TCheckBox;
    ModeleVariabCB: TCheckBox;
    GrapheVariabCB: TCheckBox;
    TangenteCB: TCheckBox;
    ParamGB: TGroupBox;
    GrapheParamCB: TCheckBox;
    TableauParamCB: TCheckBox;
    ModeleParamCB: TCheckBox;
    FourierGB: TGroupBox;
    TableauFourierCB: TCheckBox;
    GrapheFourierCB: TCheckBox;
    StatistiqueGB: TGroupBox;
    TableauStatCB: TCheckBox;
    GrapheStatCB: TCheckBox;
    GroupBox2: TGroupBox;
    EnteteEdit: TEdit;
    Panel2: TPanel;
    GraphePageRG: TRadioGroup;
    PagesBtn: TSpeedButton;
    SaveBtn: TBitBtn;
    SaveDialog: TSaveDialog;
    CancelBtn: TBitBtn;
    EditorGB: TGroupBox;
    LanceEditorCB: TCheckBox;
    EditorDirBtn: TSpeedButton;
    PathEditorEdit: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure PagesBtnClick(Sender: TObject);
    procedure GraphePageRGClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EditorDirBtnClick(Sender: TObject);
    procedure PathEditorEditExit(Sender: TObject);
  private
    procedure SauveLatex(NomFichier : string);
  public
    LatexEditor : string;
  end;

var
  LatexDlg: TLatexDlg;

implementation

uses Graphpar, Graphfft, Statisti, Curmodel, Regmain, options, Selpage,
     latex, aideKey, uniteker;

{$R *.DFM}

procedure TLatexDlg.SauveLatex(NomFichier : string);
var p,sauvePageCourante : TcodePage;

Procedure ImprimeParam;
var i : integer;
begin
    if GrapheParamCB.checked then
         FgrapheParam.versLatex(NomFichier);
    if ModeleParamCB.visible and ModeleParamCB.checked then begin
         AjouteParagraphe(stModelisation);
         AjouteLigne('\begin{itemize}[label=]');
         for i := 0 to pred(FgrapheParam.MemoModele.Lines.count) do
             AjouteLigneItem(FgrapheParam.MemoModele.Lines[i]);
         for i := 0 to pred(FgrapheParam.MemoResultat.Lines.Count) do
             AjouteLigneItem(FgrapheParam.MemoResultat.Lines[i]);
         AjouteLigne('\end{itemize}');
    end;
    if TableauParamCB.checked then begin
        Fvaleurs.TraceGridParam;
        AjouteGrid(Fvaleurs.GridParam)
    end;
end;

Procedure ImprimeStat;
begin
      if GrapheStatCB.checked then
          Fstatistique.versLatex(NomFichier);
      if TableauStatCB.checked then begin
         AjouteGrid(Fstatistique.StatGrid);
         AjouteGrid(Fstatistique.DistGrid)
      end;
end;

Procedure ImprimeFourier;
begin
        if GrapheFourierCB.checked then
             FgrapheFFT.versLatex(NomFichier);
        if TableauFourierCB.checked then
             AjouteGrid(FgrapheFFT.ValeursGrid);
end;

Procedure ImprimerTableauVariab;
var i,index : integer;
begin
      Fvaleurs.MajGridVariab := true;
      Fvaleurs.TraceGridVariab;
      AjouteParagraphe(pages[pageCourante].TitrePage);
      for i := 0 to pred(ListeConstAff.count) do begin
          index := indexNom(ListeConstAff[i]);
          AjouteLigne(grandeurs[index].FormatNomEtUnite(pages[pageCourante].valeurConst[index]));
      end;
      AjouteGrid(Fvaleurs.GridVariab);
end;

Procedure ImprimerModele(p : TcodePage);
var i : integer;
begin with pages[p] do begin
      if NbrePages>1
         then AjouteParagraphe(TitrePage)
         else AjouteLigne('');
      FgrapheVariab.MajResultatLatex(p); // pour mettre au format Latex
      AjouteLigne('\begin{itemize}[label=]');
      for i := 0 to pred(TexteResultatModele.Count) do
          AjouteLigneItem(TexteResultatModele[i]);
      AjouteLigne('\end{itemize}');
      AjouteLigne('');
end end;

Procedure ImprimerGrapheVariab;
begin
      FgrapheVariab.versLatex(NomFichier);
      if not(FgrapheVariab.graphes[1].superposePage) and
          ModeleVariabCB.visible and
          ModeleVariabCB.checked then
            ImprimerModele(pageCourante);
end;

function LanceExe(nomExe : string) : boolean;
Var  StartInfo   : TStartupInfo;
     ProcessInfo : TProcessInformation;
begin
// Mise à zéro de la structure StartInfo
  FillChar(StartInfo,SizeOf(StartInfo),#0);
// Seule la taille est renseignée, toutes les autres options
// laissées à zéro prendront les valeurs par défaut
  StartInfo.cb := SizeOf(StartInfo);
// Lancement de la ligne de commande
  result := CreateProcess(Nil, PWideChar(nomExe), Nil, Nil, False,
                0, Nil, Nil, StartInfo,ProcessInfo);
End;

var i : integer;
    aligne,nomLu : string;
    posEgal : integer;
    posErreur,longErreur : integer;
    index,NbreItem : integer;
    avecCouleur : boolean;
begin // sauveLatex
          enabled := false;
          uniteKer.isUniteLatex := true;
          debutDoc(enTeteEdit.text);
          try
//  Grandeurs
          if GrandeursCB.checked then begin
             for i := 0 to pred(Fvaleurs.memo.lines.count) do begin
                 aligne := Fvaleurs.Memo.lines[i];
                 if IsLigneComment(aligne)
                    then AjouteLigne(copy(aligne,2,length(aligne)))
                    else begin
                        PosEgal := Pos('=',aligne);
                        if PosEgal=0 then begin
                           grandeurImmediate.fonct.expression := aligne;
                           if grandeurImmediate.compileG(posErreur,longErreur,0) then begin
                              AjouteGrandeur(cImmediate);
                              grandeurImmediate.valeurCourante := calcule(grandeurImmediate.fonct.calcul);
                              AjouteLigne(grandeurImmediate.FormatNombre(grandeurImmediate.valeurCourante));
                            end;
                         end
                         else begin
                             nomLu := copy(aligne,1,pred(posEgal)); // extrait le nom
                             aligne := copy(aligne,succ(posEgal),length(aligne));// pour test forward
                             trimComplet(nomLu);
                             if nomLu[length(nomLu)]='''' then delete(nomLu,length(nomLu),1);
                             if nomLu[length(nomLu)]='''' then delete(nomLu,length(nomLu),1);
                             index := IndexNom(nomLu);
                             if (index<>GrandeurInconnue) and (aligne<>'') then AjouteGrandeur(index);
                          end;
                    end; // ligneCalcul
             end; // for i memo
             NbreItem := 0;
             for i := 0 to pred(NbreVariab) do with grandeurs[i] do
                 if (fonct.genreC=g_experimentale) and
                 (fonct.expression<>'') then
                    inc(NbreItem);
              if NbreItem>0 then begin
                 if NbreItem>1 then AjouteLigne('\begin{itemize}') else ajouteLigne('');
                 for i := 0 to pred(NbreVariab) do with grandeurs[i] do
                    if (fonct.genreC=g_experimentale) and
                       (fonct.expression<>'') then
                      if NbreItem>1
                         then AjouteLigneItem(nom+' : '+fonct.expression)
                         else AjouteLigne(nom+' : '+fonct.expression);
                 if NbreItem>1 then ajouteLigne('\end{itemize}') else ajouteLigne('');
              end;
          end;
// Valeurs des variables
          if (modeAcquisition=AcqSimulation) and
              not(Fvaleurs.PagesIndependantesCB.checked) then begin with grandeurs[0] do
                AjouteLigne(nom+'='+
                    formatValeurEtUnite(pages[1].MiniSimulation)+'..'+
                    formatValeurEtUnite(pages[1].MaxiSimulation));
                AjouteLigne('');
          end;
          if TableauVariabCB.visible and
             TableauVariabCB.checked then if GraphePageRG.itemIndex=0
             then ImprimerTableauVariab
             else begin
                 SauvePageCourante := pageCourante;
                 for p := 1 to NbrePages do if pages[p].active then begin
                     pageCourante := p;
                     if (modeAcquisition=AcqSimulation) and
                        (Fvaleurs.PagesIndependantesCB.checked) then begin with grandeurs[0] do
                              AjouteLigne(nom+'='+
                                   formatValeurEtUnite(pages[p].MiniSimulation)+'..'+
                                   formatValeurEtUnite(pages[p].MaxiSimulation));
                              AjouteLigne('');
                     end;
                     ImprimerTableauVariab;
                 end;
                 PageCourante := SauvePageCourante;
                 Fvaleurs.MajGridVariab := true;
             end;
// Modélisation
          if  ModeleVariabCB.visible and ModeleVariabCB.checked then begin
             AjouteParagraphe(stModelisation);
             for i := 0 to pred(TexteModele.count) do begin
                   aligne := TexteModele[i];
                   if IsLigneComment(aligne)
                      then AjouteLigne(copy(aligne,2,length(aligne)))
             end;
             avecCouleur := (NbreModele+NbreFonctionSuper)>1;
             for i := 1 to NbreModele do AjouteModele(fonctionTheorique[i],avecCouleur);
             for i := 1 to NbreFonctionSuper do AjouteModele(fonctionSuperposee[i],avecCouleur);
          end;
// Graphe et valeurs modélisation
      if GrapheVariabCB.checked
         then if GraphePageRG.itemIndex=0
                 then begin
                     if FgrapheVariab.graphes[1].superposePage and
                        ModeleVariabCB.visible and
                        ModeleVariabCB.checked then
                        for p := 1 to NbrePages do
                            if pages[p].active then ImprimerModele(p);
                     ImprimerGrapheVariab;
                 end
                 else begin
                      SauvePageCourante := pageCourante;
                      for p := 1 to NbrePages do with pages[p] do
                          if active then begin
                             pageCourante := p;
                             for i := 1 to 3 do with FgrapheVariab.Graphes[i] do
                                 if paintBox.Visible then begin
                                    Modif := [gmPage];
                                    PaintBox.Refresh;
                                 end;
                             ImprimerGrapheVariab;
                          end;
                      PageCourante := SauvePageCourante;
                      for i := 1 to 3 do with FgrapheVariab.Graphes[i] do
                          if paintBox.visible then begin
                             Modif := [gmPage];
                             PaintBox.Refresh;
                          end;
          end
          else if ModeleVariabCB.checked and  ModeleVariabCB.visible then
              if (GraphePageRG.itemIndex=0) and
                 not(FgrapheVariab.graphes[1].superposePage)
                 then ImprimerModele(pageCourante)
                 else for p := 1 to NbrePages do
                      if pages[p].active then
                         ImprimerModele(P);
          if TangenteCB.visible and TangenteCB.checked then begin
             FgrapheVariab.graphes[1].RemplitTableauEquivalence;
             if curseurModeleDlg<>nil then
                 AjouteGrid(curseurModeleDlg.tableau);
             end;
          if FourierGB.visible then ImprimeFourier;
          if StatistiqueGB.visible then ImprimeStat;
          if GrapheParamCB.visible and
             (GrapheParamCB.checked or
              ModeleParamCB.checked or
              TableauParamCB.checked) then ImprimeParam;
          FinDoc;
          except
             on E: Exception do begin
                showMessage(E.message);
             end;
          end;
          Fvaleurs.MajGridVariab := true;
          saveFile(NomFichier);
          if LanceEditorCB.checked then LanceExe(LatexEditor+' '+NomFichier);
          enabled := true;
          uniteker.isUniteLatex := false;
          Fvaleurs.MajGridVariab := true;
          Fvaleurs.traceGrid;
end; // sauveLatex

procedure TLatexDlg.EditorDirBtnClick(Sender: TObject);
begin
  SaveDialog.DefaultExt := 'exe';
  SaveDialog.filter := 'Exécutable |*.exe';
  if SaveDialog.execute then begin
     LatexEditor := SaveDialog.FileName;
     PathEditorEdit.text := LatexEditor;
  end;
end;

procedure TLatexDlg.FormActivate(Sender: TObject);
begin
    TableauParamCB.visible := (NbreConst+NbreParam[paramNormal])>0;
    GrapheParamCB.visible := FgrapheParam<>nil;
    ModeleParamCB.visible := (FgrapheParam<>nil) and
              (FgrapheParam.PanelModele.visible);
    ParamGB.visible := TableauParamCB.visible;
    FourierGB.visible := FgrapheFFT<>nil;
    StatistiqueGB.visible := Fstatistique<>nil;
    TangenteCB.caption := stTableau+NomLigneRappel[LigneRappelCourante];
    TangenteCB.visible := FgrapheVariab.graphes[1].equivalences[pageCourante].count>0;
    ModeleVariabCB.visible := not(FgrapheVariab.splitterModele.snapped) or
            (ModeleDefini in FgrapheVariab.etatModele);
    TableauVariabCB.visible := imTableauImpr in MenuPermis;
    GraphePageRG.visible := (NbrePages>1) and
        not(FgrapheVariab.graphes[1].superposePage);
    GraphePageRG.itemIndex := 0;
    PagesBtn.visible := false;
end;

procedure TLatexDlg.HelpBtnClick(Sender: TObject);
begin
     Aide(HELP_Latex) { TODO : aide latex }
end;

procedure TLatexDlg.PagesBtnClick(Sender: TObject);
begin
    if selectPageDlg=nil then Application.CreateForm(TselectPageDlg, selectPageDlg);
    SelectPageDlg.caption := 'Choix des pages à sauver';
    SelectPageDlg.showModal
end;

procedure TLatexDlg.PathEditorEditExit(Sender: TObject);
begin
    LatexEditor := PathEditorEdit.text;
end;

procedure TLatexDlg.GraphePageRGClick(Sender: TObject);
begin
    PagesBtn.visible := graphePageRG.itemIndex=1
end;

procedure TLatexDlg.FormCreate(Sender: TObject);
var Rini : TInifile;
begin
  inherited;
  Rini := TIniFile.create(NomFichierIni);
  LatexEditor := Rini.ReadString('Latex','Editor','C:\Program Files (x86)\Texmaker\texmaker.exe');
  PathEditorEdit.text := LatexEditor;
  LanceEditorCB.checked := Rini.ReadBool('Latex','LanceEditor',false);
  RIni.Free;
end;

procedure TLatexDlg.FormDestroy(Sender: TObject);
var Rini : TMemInifile;
begin
     Rini := TMemIniFile.create(NomFichierIni);
     Rini.WriteString('Latex','Editor',LatexEditor);
     Rini.WriteBool('Latex','LanceEditor',LanceEditorCB.checked);
     RIni.free;
end;

procedure TLatexDlg.SaveBtnClick(Sender: TObject);
begin
  SaveDialog.DefaultExt := 'tex';
  SaveDialog.filter := 'Fichier TeX|*.tex';
  if SaveDialog.execute then begin
     sauveLatex(SaveDialog.FileName);
     close;
  end;
end;

end.

