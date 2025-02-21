unit regprint;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons, inifiles,
  StdCtrls, ExtCtrls, Spin, Dialogs, grids, printers, sysutils, constreg,
  vcl.HtmlHelpViewer,
  regutil, compile, graphker, graphvar, valeurs, aidekey;

type
  TPrintDlg = class(TForm)
    PanelOption: TPanel;
    PrintBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
    PanelOptions: TPanel;
    PrintGB: TGroupBox;
    DateCB: TCheckBox;
    NomFichierCB: TCheckBox;
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
    EnteteGB: TGroupBox;
    EnteteEdit: TEdit;
    CopiesLabel: TLabel;
    CopiesSE: TSpinEdit;
    PanelPages: TPanel;
    GraphePageRG: TRadioGroup;
    PagesBtn: TSpeedButton;
    PrintCB: TComboBox;
    ImprimanteGB: TGroupBox;
    PrinterBtn: TSpeedButton;
    GridPrintCB: TCheckBox;
    PrinterSetupDialog: TPrinterSetupDialog;
    procedure PrintBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure PagesBtnClick(Sender: TObject);
    procedure GraphePageRGClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PrintCBChange(Sender: TObject);
    procedure PrinterBtnClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
  public
  end;

var
  PrintDlg: TPrintDlg;

implementation

uses Options, Graphpar, Graphfft, Statisti, Curmodel, Selpage, regmain;

{$R *.DFM}

procedure TPrintDlg.PrintBtnClick(Sender: TObject);
var
  debutImp : integer;
  p,sauvePageCourante : TcodePage;

Procedure ImprimeParam;
var i : integer;
begin
    if GrapheParamCB.visible and GrapheParamCB.checked then
         FgrapheParam.ImprimerGraphe(debutImp);
    if ModeleParamCB.checked then begin
         VerifOrpheline(FgrapheParam.MemoModele.Lines.Count+FgrapheParam.MemoResultat.Lines.Count+1,debutImp);
         ImprimerLigne(stModelisation,debutImp);
         for i := 0 to pred(FgrapheParam.MemoModele.Lines.count) do
             ImprimerLigne(FgrapheParam.MemoModele.Lines[i],debutImp);
         for i := 0 to pred(FgrapheParam.MemoResultat.Lines.Count) do
             ImprimerLigne(FgrapheParam.MemoResultat.Lines[i],debutImp);
    end;
    if TableauParamCB.checked then begin
        Fvaleurs.TraceGridParam;
        VerifOrpheline(Fvaleurs.GridParam.RowCount,debutImp);
        ImprimerGrid(Fvaleurs.GridParam,debutImp);
        if Fvaleurs.GridParamGlb.visible then begin
           VerifOrpheline(Fvaleurs.GridParamGlb.RowCount,debutImp);
           ImprimerGrid(Fvaleurs.GridParamGlb,debutImp);
        end;
    end;
end;

Procedure ImprimeStat;
begin
      if GrapheStatCB.checked then
          Fstatistique.ImprimerGraphe(debutImp);
      if TableauStatCB.checked then begin
         ImprimerGrid(Fstatistique.StatGrid,debutImp);
         ImprimerGrid(Fstatistique.DistGrid,debutImp)
      end;
end;

Procedure ImprimeFourier;
begin
        if GrapheFourierCB.checked then
             FgrapheFFT.ImprimerGraphe(debutImp);
        if TableauFourierCB.checked then
             ImprimerGrid(FgrapheFFT.ValeursGrid,debutImp);
end;

Procedure ImprimerTableauVariab;
var i,index : integer;
    texte : string;
begin
      Fvaleurs.MajGridVariab := true;
      Fvaleurs.TraceGridVariab;
      ImprimerLigne(pages[pageCourante].TitrePage,debutImp);
      if ListeConstAff.count>0 then begin
         texte := '';
         for i := 0 to pred(ListeConstAff.count) do begin
           index := indexNom(ListeConstAff[i]);
           texte := texte+grandeurs[index].FormatNomEtUnite(pages[pageCourante].valeurConst[index]);
         end;
         ImprimerLigne(texte,debutImp);
      end;   
      ImprimerGrid(Fvaleurs.GridVariab,debutImp);
end;

Procedure ImprimerModele(p : TcodePage);
var i : integer;
begin with pages[p] do begin
      DebutImpressionTexte(debutImp);
      ImprimerLigne(TitrePage,debutImp);
      for i := 0 to pred(TexteResultatModele.Count) do
          ImprimerLigne(TexteResultatModele[i],debutImp);
end end;

Procedure ImprimerModeles;
var p : TcodePage;
begin
   if ModeleVariabCB.checked then
      if (GraphePageRG.itemIndex=0)
           then ImprimerModele(pageCourante)
           else for p := 1 to NbrePages do
                    if pages[p].active then
                          ImprimerModele(P);
end;

Procedure ImprimerGrapheVariab;
begin
      FgrapheVariab.ImprimerGraphe(debutImp);
      if not(FgrapheVariab.graphes[1].superposePage) and
          ModeleVariabCB.checked then
            ImprimerModele(pageCourante);
end;

var i : integer;
    titre : string;
begin
          printer.copies := CopiesSE.value;
          GridPrint := GridPrintCB.checked;
          screen.cursor := crHourGlass;
          enabled := false;
          Printer.title := stRegressi+' '+NomFichierData;
try
          Printer.BeginDoc;
          debutImp := 0;
          DebutImpressionTexte(debutImp);
          userName := enTeteEdit.text;
          titre := enTeteEdit.text;
          if dateCB.checked then
             titre := titre+' '+DateToStr(Now);
          if titre<>'' then ImprimerLigne(Titre,debutImp);
          if NomFichierCB.checked then ImprimerLigne(NomFichierData,debutImp);
// Grandeurs
          if GrandeursCB.checked then
             for i := 0 to pred(Fvaleurs.memo.lines.count) do
                 ImprimerLigne(Fvaleurs.Memo.lines[i],debutImp);
// Valeurs des variables
           if (modeAcquisition=AcqSimulation) and
              not(Fvaleurs.PagesIndependantesCB.checked) then with grandeurs[0] do
                ImprimerLigne(nom+'='+
                    formatValeurEtUnite(pages[1].MiniSimulation)+'..'+
                    formatValeurEtUnite(pages[1].MaxiSimulation),debutImp);
          if TableauVariabCB.visible and
             TableauVariabCB.checked then if GraphePageRG.itemIndex=0
             then ImprimerTableauVariab
             else begin
                 SauvePageCourante := pageCourante;
                 for p := 1 to NbrePages do if pages[p].active then begin
                     pageCourante := p;
                     if (modeAcquisition=AcqSimulation) and
                        (Fvaleurs.PagesIndependantesCB.checked) then with grandeurs[0] do
                              ImprimerLigne(nom+'='+
                                   formatValeurEtUnite(pages[p].MiniSimulation)+'..'+
                                   formatValeurEtUnite(pages[p].MaxiSimulation),debutImp);
                     if pages[p].commentaireP<>''
                         then ImprimerLigne(pages[p].commentaireP,debutImp);
                     ImprimerTableauVariab;
                 end;
                 PageCourante := SauvePageCourante;
                 Fvaleurs.MajGridVariab := true;
             end;
// Modélisation
          if ModeleVariabCB.checked then begin
             ImprimerLigne(stModelisation,debutImp);
             for i := 0 to pred(TexteModele.count) do
                   ImprimerLigne(TexteModele[i],debutImp);
          end;
// Graphe et valeurs modélisation
      if GrapheVariabCB.checked
         then if GraphePageRG.itemIndex=0
              then ImprimerGrapheVariab
              else if FgrapheVariab.graphes[1].superposePage
                  then begin
                     ImprimerModeles;
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
                             if commentaireP<>'' then ImprimerLigne(titrePage,debutImp);
                             ImprimerGrapheVariab;
                          end;
                      PageCourante := SauvePageCourante;
                      for i := 1 to 3 do with FgrapheVariab.Graphes[i] do
                          if paintBox.visible then begin
                             Modif := [gmPage];
                             PaintBox.Refresh;
                          end;
              end // GrapheVariabCB.checked
         else ImprimerModeles;
      if TangenteCB.visible and TangenteCB.checked then begin
           FgrapheVariab.graphes[1].RemplitTableauEquivalence;
           if curseurModeleDlg<>nil then begin
               ImprimerGrid(curseurModeleDlg.tableau,debutImp);
               (*
               for i := 0 to pred(curseurModeleDlg.memo.Lines.Count) do
                   ImprimerLigne(curseurModeleDlg.memo.Lines[i],debutImp);
               *)
           end;
      end;
      if FourierGB.visible then ImprimeFourier;
      if StatistiqueGB.visible then ImprimeStat;
      if ParamGB.visible then ImprimeParam;
      Printer.EndDoc;
      except
             on E: Exception do begin
                showMessage(E.message);
                try
                Printer.Abort;
                except
                end;
             end;
      end;
      screen.cursor := crDefault;
      enabled := true;
      printer.copies := 1;
      Fvaleurs.MajGridVariab := true;
end;

procedure TPrintDlg.FormActivate(Sender: TObject);
begin
    inherited;
    printCB.visible := (imPrinterSetUp in menuPermis) and
                       (printer.printers.Count>1);
    if printCB.visible then begin
       printCB.items := printer.printers;
       printCB.itemIndex := printer.printerIndex;
    end;
    GridPrintCB.checked := GridPrint;                     
    CopiesSE.value := 1;
    CopiesSE.MaxValue := MaxCopiesPrinter;
    CopiesSE.Visible := MaxCopiesPrinter>1;
    CopiesLabel.Visible := MaxCopiesPrinter>1;
    TableauParamCB.visible := (NbreConst+NbreParam[paramNormal])>0;
    GrapheParamCB.visible := FgrapheParam<>nil;
    ModeleParamCB.visible := (FgrapheParam<>nil) and
                             (FgrapheParam.PanelModele.visible);
    if not ModeleParamCB.visible then ModeleParamCB.checked := false;
    ParamGB.visible := TableauParamCB.visible;
    FourierGB.visible := FgrapheFFT<>nil;
    StatistiqueGB.visible := Fstatistique<>nil;
    TangenteCB.caption := NomLigneRappel[LigneRappelCourante];
    TangenteCB.visible := FgrapheVariab.graphes[1].equivalences[pageCourante].count>0;
    ModeleVariabCB.visible := ModeleDefini in FgrapheVariab.etatModele;
    if not ModeleVariabCB.visible then ModeleVariabCB.checked := false;
    TableauVariabCB.visible := imTableauImpr in MenuPermis;
    PanelPages.Visible := NbrePages>1;
    GraphePageRG.itemIndex := 0;
    enTeteEdit.text := UserName;
end;

procedure TPrintDlg.HelpBtnClick(Sender: TObject);
begin
    Aide(HELP_Impression)
end;

procedure TPrintDlg.PagesBtnClick(Sender: TObject);
begin
    if selectPageDlg=nil then Application.CreateForm(TselectPageDlg, selectPageDlg);
    SelectPageDlg.caption := 'Choix des pages à imprimer';
    SelectPageDlg.appelPrint := true;
    SelectPageDlg.showModal
end;

procedure TPrintDlg.GraphePageRGClick(Sender: TObject);
begin
    PagesBtn.visible := graphePageRG.itemIndex=1
end;

procedure TPrintDlg.FormCreate(Sender: TObject);
var Rini : TIniFile;
begin
  inherited;
  Rini := TIniFile.create(NomFichierIni);
  try
  with Rini do begin
       grandeursCB.checked := readBool(stPrint,'grandeurs',true);
       tableauVariabCB.checked := readBool(stPrint,'tabVar',false);
       grapheVariabCB.checked := readBool(stPrint,'grVar',true);
       grapheParamCB.checked := readBool(stPrint,'grPar',false);
       modeleVariabCB.checked := readBool(stPrint,'modVar',true);
       modeleParamCB.checked := readBool(stPrint,'modPar',false);
       tangenteCB.checked := readBool(stPrint,stTangente,true);
       tableauParamCB.checked := readBool(stPrint,'tabPar',false);
       grapheFourierCB.checked := readBool(stPrint,'grFFT',true);
       tableauFourierCB.checked := readBool(stPrint,'tabFFT',false);
       grapheStatCB.checked := readBool(stPrint,'grStat',true);
       tableauStatCB.checked := readBool(stPrint,'tabStat',false);
       dateCB.checked := readBool(stPrint,'date',true);
       nomFichierCB.checked := readBool(stPrint,'nomFile',false);
  end;
  finally
  Rini.free;
  end;
  enTeteEdit.text := userName;
end;

procedure TPrintDlg.PrintCBChange(Sender: TObject);
begin
   printer.PrinterIndex := printCB.itemIndex
end;

procedure TPrintDlg.PrinterBtnClick(Sender: TObject);
begin
   printerSetUpDialog.execute
end;

procedure TPrintDlg.FormDeactivate(Sender: TObject);
var Rini : TIniFile;
begin
  try
  Rini := TIniFile.create(NomFichierIni);
  with Rini do begin
       writeBool(stPrint,'grandeurs',grandeursCB.checked);
       writeBool(stPrint,'tabVar',tableauVariabCB.checked);
       writeBool(stPrint,'grVar',grapheVariabCB.checked);
       writeBool(stPrint,'grPar',grapheParamCB.checked);
       writeBool(stPrint,'modVar',modeleVariabCB.checked);
       writeBool(stPrint,'modPar',modeleParamCB.checked);
       writeBool(stPrint,stTangente,tangenteCB.checked);
       writeBool(stPrint,'tabPar',tableauParamCB.checked);
       writeBool(stPrint,'grFFT',grapheFourierCB.checked);
       writeBool(stPrint,'tabFFT',tableauFourierCB.checked);
       writeBool(stPrint,'grStat',grapheStatCB.checked);
       writeBool(stPrint,'tabStat',tableauStatCB.checked);
       writeBool(stPrint,'date',dateCB.checked);
       writeBool(stPrint,'nomFile',nomFichierCB.checked);
  end;
  except
  end;
  inherited;
end;

end.

