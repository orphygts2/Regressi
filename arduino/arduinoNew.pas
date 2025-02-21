unit arduinoNew;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.ImageList, system.dateUtils,
  Vcl.Graphics, Vcl.Grids, Vcl.ComCtrls, Vcl.ToolWin,  Vcl.ImgList,
  Vcl.htmlHelpViewer,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  OOmisc, adport, lnswin32, awuser, constreg, aidekey,
  inifiles,
  regutil, arduinoGraphe, arduinoCfgNew, compile, Vcl.BaseImageCollection,
  Vcl.ImageCollection, Vcl.VirtualImageList, Vcl.Mask;

type
  TmodeAcq = (aTemps,aClavier,aBarre);
  TArduinoNewForm = class(TForm)
    ToolBar: TToolBar;
    ToolsBtn: TToolButton;
    StartBtn: TToolButton;
    StopBtn: TToolButton;
    RegressiBtn: TToolButton;
    PaintBox: TPaintBox;
    Splitter: TSplitter;
    Timer: TTimer;
    PanelVoies: TPanel;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    GroupBox4: TGroupBox;
    Label3: TLabel;
    GroupBox5: TGroupBox;
    Label4: TLabel;
    GroupBox6: TGroupBox;
    Label5: TLabel;
    RazBtn: TToolButton;
    VoieSerie: TApdComPort;
    HelpBtn: TToolButton;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    ClavierPanel: TPanel;
    ClavierEdit: TLabeledEdit;
    ExitBtn: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure ToolsBtnClick(Sender: TObject);
    procedure RegressiBtnClick(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
    procedure StartBtnClick(Sender: TObject);
    procedure PaintBoxPaint(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RazBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure VoieSerieTriggerAvail(CP: TObject; Count: Word);
    procedure VoieSerieTriggerData(CP: TObject; TriggerHandle: Word);
    procedure FormHide(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure ExitBtnClick(Sender: TObject);
    procedure ClavierEditKeyPress(Sender: TObject; var Key: Char);
    procedure ClavierEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    indiceCourant : integer;
    chaineLue : ansiString;
    tempsActif : boolean;
    avecDemande : boolean;
    crTrigger : word;
    indexFichier : integer;
    NbreColonnes : integer;
    tZero : TTime; // temps PC
    tOrigine : double; // premier point
    PremierAppel : boolean;
    dureeMax,deltat : integer;
    labelVoie : array[TindiceAxes] of Tlabel;
    GBVoie : array[TindiceAxes] of TgroupBox;
    graphe : TgrapheArduino;
    nomClavier,uniteClavier : string;
    procedure openVoieSerie;
    procedure majBoutons;
  public
    modeAcq : TmodeAcq;
  end;

var
  ArduinoNewForm: TArduinoNewForm;

implementation

{$R *.dfm}

uses regmain, regdde;

procedure TArduinoNewForm.StopBtnClick(Sender: TObject);

Procedure Sauvegarde;
var nomFichier,ligne : string;
    i,k : integer;
    fichier : textFile;
begin
     NomFichier := MesDocsDir+'RegressiArduino'+intToStr(indexFichier)+'.csv';
     inc(indexFichier);
     if indexFichier>32 then indexFichier := 0;
     AssignFile(fichier,NomFichier);
     Rewrite(fichier);
     for i := 0 to pred(graphe.NbrePoints) do begin
         ligne := '';
         for k := 0 to NbreColonnes do
             Ligne := ligne+FloatToStrPoint(graphe.monde[k].Valeur[i])+',';
         writeln(fichier,Ligne);
     end;
     CloseFile(fichier);
end;

begin
   tempsActif := false;
   razBtn.Enabled := true;
   stopBtn.enabled := false;
   stopBtn.imageIndex := -1;
   startBtn.Enabled := true;
   timer.enabled := avecDemande;
   graphe.nbrePointsNew := 0;
   if timer.enabled then timerTimer(nil);
   if regressiBtn.Enabled then sauvegarde;
end;

procedure TArduinoNewForm.StartBtnClick(Sender: TObject);
var i : integer;
begin
    timer.enabled := avecDemande;
    graphe.indexRoll := 0;
    for i := 0 to mondeYmax do begin
        graphe.monde[i].minMaxData := true;
        graphe.monde[i].minMaxCourant := true;
    end;
    case modeAcq of
    aBarre : begin
      startBtn.Enabled := indiceCourant<MaxVecteurArduino;
      regressiBtn.Enabled := indiceCourant>4;
      razBtn.Enabled := regressiBtn.Enabled;
      stopBtn.enabled := false;
      stopBtn.visible := false;
      for i := 0 to nbreColonnes do
          graphe.monde[i].valeur[indiceCourant] := graphe.monde[i].valeurC;
      inc(indiceCourant);
      graphe.nbrePoints := indiceCourant;
      graphe.monde[mondeX].minMaxData := true;
      graphe.monde[mondeX].minMaxCourant := true;
    end;
    aClavier : begin
      startBtn.Enabled := indiceCourant<MaxVecteurArduino;
      regressiBtn.Enabled := indiceCourant>4;
      razBtn.Enabled := regressiBtn.Enabled;
      stopBtn.enabled := false;
      stopBtn.visible := false;
      try
         graphe.monde[mondeX].valeurC := strToFloat(clavierEdit.Text);
      except
         graphe.monde[mondeX].valeurC := indiceCourant;
      end;
      for i := 0 to nbreColonnes do
          graphe.monde[i].valeur[indiceCourant] := graphe.monde[i].valeurC;
      inc(indiceCourant);
      graphe.nbrePoints := indiceCourant;
      graphe.monde[mondeX].minMaxData := true;
      graphe.monde[mondeX].minMaxCourant := true;
    end;
    aTemps : begin
        indiceCourant := 0;
        graphe.NbrePoints := 0;
        graphe.NbrePointsNew := 0;
        stopBtn.enabled := true;
        stopBtn.ImageIndex := 10;
        stopBtn.visible := true;
        startBtn.Enabled := False;
        premierAppel := true;
        tZero := getTime;
        tOrigine := 0;
        graphe.monde[mondeX].minMaxData := not avecDemande;
        graphe.monde[mondeX].minMaxCourant := false;
        graphe.monde[mondeX].maxi := dureeMax;
        voieSerie.flushInBuffer;
        chaineLue := '';
        tempsActif := true;
        timer.Enabled := false;
        timerTimer(sender);
    end;
    end;
end;

procedure TArduinoNewForm.TimerTimer(Sender: TObject);
begin
     if voieSerie.Open then begin
        voieSerie.Output := '?';
        timer.Enabled := true;
     end;
end;

procedure TArduinoNewForm.RazBtnClick(Sender: TObject);
begin
    graphe.nbrePoints := 0;
    graphe.nbrePointsNew := 0;
    indiceCourant := 0;
    paintBox.Invalidate;
end;

procedure TArduinoNewForm.HelpBtnClick(Sender: TObject);
begin
   //Aide(Help_Arduino);
    AideStr('Arduino');
end;

procedure TArduinoNewForm.ToolsBtnClick(Sender: TObject);
var j : integer;
    oldModeAcq : TmodeAcq;
begin
     if crTrigger>0 then begin
        voieSerie.RemoveTrigger(crTrigger);
        crTrigger := 0;
        {$IFDEF Debug}
        voieSerie.Tracing := tlDump;
        voieSerie.Logging := tlDump;
        {$ENDIF}
     end;
     VoieSerie.Open := False;
     if ArduinoNewDlg=nil then Application.CreateForm(TArduinoNewDlg,ArduinoNewDlg);
     ArduinoNewDlg.dureeMaxSE.Value := dureeMax;
     ArduinoNewDlg.deltatSE.Value := deltat;
     for j := 0 to indexVitesseMax do begin
         ArduinoNewDlg.baudRG.items[j] := intToStr(vitesseBaud[j]);
         if voieSerie.Baud=vitesseBaud[j] then ArduinoNewDlg.BaudRG.ItemIndex := j;
     end;
     ArduinoNewDlg.Comports.items.clear;
     for j := 1 to MaxComHandles do
        if IsPortAvailable(j) then begin
           ArduinoNewDlg.Comports.Items.Add('COM'+IntToStr(j));
           NumeroCom[ArduinoNewDlg.Comports.items.count-1] := j;
           if j=voieSerie.comNumber then
              ArduinoNewDlg.Comports.ItemIndex := ArduinoNewDlg.Comports.items.count-1;
        end;
     if ArduinoNewDlg.comports.Items.count=0 then begin
        showMessage('Pas de voie série');
        exit;
     end;
     if (ArduinoNewDlg.Comports.ItemIndex<0) then
        ArduinoNewDlg.Comports.itemIndex := 0;
     ArduinoNewDlg.modeRG.ItemIndex := ord(modeAcq);
     ArduinoNewDlg.avecdemandeRG.ItemIndex := ord(avecDemande);
     oldModeAcq := modeAcq;
     for j := 1 to mondeYmax do begin
         ArduinoNewDlg.grid.Cells[0,j] := graphe.monde[j].nom;
         ArduinoNewDlg.grid.Cells[1,j] := graphe.monde[j].unite;
         ArduinoNewDlg.grid.Cells[2,j] := graphe.monde[j].mini.toString;
         ArduinoNewDlg.grid.Cells[3,j] := graphe.monde[j].maxi.toString;
     end;
     ArduinoNewDlg.nomClavierEdit.text := nomClavier;
     ArduinoNewDlg.uniteClavierEdit.text := uniteClavier;
     if ArduinoNewDlg.ShowModal=mrOK then begin
         dureeMax := arduinoNewDlg.dureeMaxSE.Value;
         deltat := arduinoNewDlg.deltatSE.Value;
         modeAcq := TmodeAcq(ArduinoNewDlg.modeRG.ItemIndex);
         voieSerie.comNumber := NumeroCom[ArduinoNewDlg.Comports.ItemIndex];
         voieSerie.baud := strToInt(ArduinoNewDlg.baudRG.items[ArduinoNewDlg.BaudRG.ItemIndex]);
         for j := 1 to mondeYmax do with graphe.monde[j] do begin
             nom := ArduinoNewDlg.grid.Cells[0,j];
             unite := ArduinoNewDlg.grid.Cells[1,j];
             mini := strToFloatWin(ArduinoNewDlg.grid.Cells[2,j]);
             maxi := strToFloatWin(ArduinoNewDlg.grid.Cells[3,j]);
         end;
         nomClavier := ArduinoNewDlg.nomClavierEdit.text;
         uniteClavier := ArduinoNewDlg.uniteClavierEdit.text;
         avecDemande := ArduinoNewDlg.avecdemandeRG.ItemIndex=1;
         if oldModeAcq<>modeacq then RazBtnClick(sender);
     end;
     openVoieSerie;
     majBoutons;
     timer.Enabled := voieSerie.Open and avecDemande;
     PanelVoies.Visible := voieSerie.Open;
     clavierPanel.Visible := modeAcq=aClavier;
     case modeAcq of
        aClavier : begin
            //  graphe.monde[mondeX].mini := 0;
            //  graphe.monde[mondeX].maxi := 32;
              graphe.monde[mondeX].nom := nomClavier;
              graphe.monde[mondeX].unite := uniteClavier;
        end;
        aBarre : begin
              graphe.monde[mondeX].mini := 0;
              graphe.monde[mondeX].maxi := 32;
              graphe.monde[mondeX].nom := 'k';
              graphe.monde[mondeX].unite := '';
         end;
         aTemps : begin
            graphe.monde[mondeX].mini := 0;
            graphe.monde[mondeX].maxi := dureeMax;
            graphe.monde[mondeX].nom := 't';
            graphe.monde[mondeX].unite := 's';
         end;
     end;
end;

procedure TArduinoNewForm.ClavierEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key=vk_return then StartBtnClick(sender);
end;

procedure TArduinoNewForm.ClavierEditKeyPress(Sender: TObject; var Key: Char);
begin
   VerifKeyGetFloat(key);
end;

procedure TArduinoNewForm.ExitBtnClick(Sender: TObject);
begin
  close
end;

procedure TArduinoNewForm.FormActivate(Sender: TObject);
begin
    openVoieSerie;
    NbreColonnes := 0; // pas de données
    timer.Enabled := voieSerie.Open and avecDemande;
    PanelVoies.Visible := voieSerie.Open;
    majBoutons;
end;

procedure TArduinoNewForm.FormClose(Sender: TObject; var Action: TCloseAction);
var Rini : TMemInifile;
begin
     Rini := TMemIniFile.create(NomFichierIni);
     Rini.WriteInteger(stArduino,'Com',voieSerie.comNumber);
     Rini.WriteInteger(stArduino,'DureeMax',dureeMax);
     Rini.WriteInteger(stArduino,'Deltat',deltat);
     Rini.WriteInteger(stArduino,'Baud',voieSerie.baud);
     Rini.WriteInteger(stArduino,'ModeAcq',ord(modeAcq));
     Rini.writeString(stArduino,'NomCl',nomClavier);
     Rini.writeBool(stArduino,'AvecDemande',avecDemande);
     Rini.writeString(stArduino,'UnitCl',uniteClavier);
     Rini.updateFile;
     Rini.Free;
     graphe.ecritIni;
     if crTrigger<>0 then begin
        voieSerie.RemoveTrigger(crTrigger);
        crTrigger := 0;
     end;
     {$IFDEF Debug}
     voieSerie.Tracing := tlDump;
     voieSerie.Logging := tlDump;
     {$ENDIF}
     VoieSerie.Open := false;
     tempsActif := false;
     timer.Enabled := false;
end;  // formClose

procedure TArduinoNewForm.FormCreate(Sender: TObject);
var j : integer;
    Rini : TMemIniFile;
    baudOK : boolean;
begin
     graphe := TgrapheArduino.create;
     graphe.paintbox := paintBox;
     graphe.modePoint := true;
     indexFichier := 0;
     avecDemande := true;
     Rini := TMemIniFile.create(NomFichierIni);
     VoieSerie.ComNumber := Rini.ReadInteger(stArduino,'Com',3);
     if not IsPortAvailable(VoieSerie.ComNumber) then begin
        for j := 1 to MaxComHandles do
        if IsPortAvailable(j) then begin
            VoieSerie.ComNumber := j;
            break;
        end;
     end;
     if not IsPortAvailable(VoieSerie.ComNumber) then showMessage('Pas de voie série');
     VoieSerie.Baud := Rini.ReadInteger(stArduino,'Baud',9600);
     dureeMax := Rini.ReadInteger(stArduino,'DureeMax',15);
     deltat := Rini.ReadInteger(stArduino,'Deltat',1);
     modeAcq := TmodeAcq(Rini.ReadInteger(stArduino,'modeAcq',0));
     avecDemande := Rini.readBool(stArduino,'AvecDemande',true);
     j := 0;
     repeat
         baudOK := voieSerie.Baud=vitesseBaud[j];
         inc(j)
     until baudOK or (j>indexVitesseMax);
     if not baudOK then VoieSerie.Baud := 9600;
     nomClavier := Rini.readString(stArduino,'NomCl','X');
     uniteClavier := Rini.readString(stArduino,'UnitCl','');
     Rini.Free;
     graphe.litIni;
     indiceCourant := 0;
     nbreColonnes := 0;
     tempsActif := false;
     crTrigger := 0;
     with PanelVoies do
     for j := 0 to pred(controlCount) do begin
         GBVoie[j] := TGroupBox(controls[j]);
         LabelVoie[j] := Tlabel(GBvoie[j].controls[0]);
         LabelVoie[j].Font.color := clWhite;
         LabelVoie[j].tag := j;
         GBVoie[j].Tag := j;
         GBVoie[j].color := couleurArduino[j];
     end;
     VirtualImageList1.height := VirtualImageListSize;
     VirtualImageList1.width := VirtualImageListSize;
end; // formCreate

procedure TArduinoNewForm.FormDestroy(Sender: TObject);
begin
     VoieSerie.Free;
     Graphe.free;
end;

procedure TArduinoNewForm.FormHide(Sender: TObject);
begin
   voieSerie.Open := false;
end;

procedure TArduinoNewForm.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
    if msg.charCode=vk_space then StartBtnClick(nil);
end;

procedure TArduinoNewForm.FormShow(Sender: TObject);
begin
    openVoieSerie;
end;

procedure TArduinoNewForm.PaintBoxPaint(Sender: TObject);
begin
      graphe.mondeMax := nbreColonnes;
      if modeAcq=aTemps then begin
         graphe.Monde[mondex].mini := 0;
         graphe.Monde[mondex].maxi := dureeMax;
      end;
      graphe.drawG;
end;

procedure TArduinoNewForm.RegressiBtnClick(Sender: TObject);
var i,k : integer;
    Ligne : String;
begin
     FormDDE.donnees.Clear;
     FormDDE.donnees.add(Application.exeName);
     FormDDE.donnees.add('');
     ligne := '';
     for k := 0 to nbreColonnes do // noms
         Ligne := ligne+graphe.monde[k].nom+crTab;
     FormDDE.donnees.add(Ligne);
     ligne := '';
     for k := 0 to nbreColonnes do // unités
         Ligne := ligne+graphe.monde[k].unite+crTab;
     FormDDE.donnees.add(ligne);
     for i := 0 to pred(graphe.nbrePoints) do begin // data
         ligne := '';
         for k := 0 to nbreColonnes do
             Ligne := ligne+floatToStrPoint(graphe.monde[k].valeur[i])+crTab;
         FormDDE.donnees.add(Ligne);
     end;
     if pageCourante=0
         then with FregressiMain do begin
             grandeursOpen;
             grapheOpen;
             if FormDDE.ImporteDonnees then begin
                ModifConfigAcq := SaveConfigAcq;
                FocusAcquisitionBtn.visible := true;
             end
         end
         else FormDDE.AjouteDonnees;
     modeAcquisition := acqArduino;
     Close;
end; // RegressiBtnClick

procedure TArduinoNewForm.VoieSerieTriggerAvail(CP: TObject; Count: Word);
var
   i: word;
   carac: ansiChar;
begin
    for i := 1 to Count do begin
       if voieSerie.CharReady then begin
          carac := voieSerie.GetChar;
          if (carac > ' ') then chaineLue := chaineLue + carac;
          if charInSet(carac,caracArduino)
             then panelVoies.caption  := ''
             else panelVoies.caption  := 'Vérifier vitesse voie série';
       end;
    end
end;// TriggerAvail

procedure TArduinoNewForm.VoieSerieTriggerData(CP: TObject; TriggerHandle: Word);

procedure TriggerDataPoint;
begin
      razBtn.Enabled := regressiBtn.Enabled;
      graphe.nbrePoints := indiceCourant;
      startBtn.Enabled := indiceCourant<MaxVecteurArduino;
end; // TriggerDataPoint

procedure TriggerDataTemps(t : double);
var i : integer;
begin
          if t>indiceCourant*deltat  then begin
             if indiceCourant=0 then begin
                tOrigine := t;
                graphe.monde[mondeX].valeurC := 0;
             end;
             for i := 0 to nbreColonnes do with graphe.monde[i] do
                 valeur[indiceCourant] := valeurC;
             inc(indiceCourant);
             graphe.nbrePoints := indiceCourant;
          end;
          if avecDemande
             then begin
                if (graphe.monde[mondeX].valeurC>dureeMax) then stopBtnClick(nil);
             end
             else begin
                 if (indiceCourant>4096) then stopBtnClick(nil);
             end;
end; // triggerDataTemps

var i : integer;
    liste : TstringList;
    t : double;
begin
      liste := TstringList.Create;
      liste.commaText := string(chaineLue);
      chaineLue := '';
      if liste.Count<1 then exit;
      nbreColonnes := liste.Count; // index en plus
      if nbreColonnes>mondeYMax then nbreColonnes := mondeYMax;
      for i := 1 to nbreColonnes do
          graphe.monde[i].valeurC := strToFloatWin(liste[i-1]);
      t := 0;// pour le compilateur
      case modeAcq of
           aClavier : begin
               graphe.monde[mondeX].valeurC := strToFloat(clavierEdit.Text);
               labelVoie[0].Caption := nomClavier+'='+
                  formatCourt(graphe.monde[mondeX].valeurC)+' '+
                  uniteClavier;
           end;
           aTemps : if tempsActif then begin
                 t := milliSecondsBetween(getTime,tZero)/1000.0;
                 graphe.monde[mondeX].valeurC := t-tOrigine;
                 labelVoie[0].Caption := 't='+formatCourt(graphe.monde[mondeX].valeurC)+' s';
               end
               else begin
                  graphe.monde[mondeX].valeurC := 0;
                  labelVoie[0].Caption := '';
               end;
           aBarre : begin
              graphe.monde[mondeX].valeurC := indiceCourant;
              labelVoie[0].Caption := 'n°='+intToStr(indiceCourant);
           end;
      end;
      case modeAcq of
         aTemps : if tempsActif then triggerDataTemps(t)
         else TriggerDataPoint;
      end;
      regressiBtn.Enabled := indiceCourant>5;
      for i := 1 to NbreColonnes do begin
          labelVoie[i].visible := true;
          GBVoie[i].color := couleurArduino[i];
          labelVoie[i].Caption := graphe.monde[i].nom+'='+liste[i-1]+' '+graphe.monde[i].unite;
      end;
      for i := succ(NbreColonnes) to mondeYmax do begin
          labelVoie[i].visible := false;
          GBVoie[i].color := PanelVoies.color;
      end;
      paintBox.invalidate;
      liste.Free;
end; // voieSerieTriggerData

Procedure TArduinoNewForm.OpenVoieSerie;
begin
     if not voieSerie.Open and isPortAvailable(voieSerie.ComNumber) then begin
         try
         VoieSerie.Open := True;
         {$IFDEF Debug}
         voieSerie.Tracing := tlOn;
         voieSerie.Logging := tlOn;
         {$ELSE}
         voieSerie.Tracing := tlOff;
         voieSerie.Logging := tlOff;
         {$ENDIF}
         if crTrigger=0 then crTrigger := voieSerie.addDataTrigger(crCR,true);
         except
         ShowMessage('Problème voie série');
         end;
     end;
end;

procedure TArduinoNewForm.majBoutons;
begin
   stopBtn.visible := modeAcq=aTemps;
   if modeAcq=aTemps
   then begin
      caption := 'Acquisition temporelle par Arduino pour Regressi';
      startBtn.hint := 'Lancer l''acquisition';
   end
   else begin
      caption := 'Acquisition point par point par Arduino pour Regressi';
      startBtn.hint := 'Acquérir un point';
   end
end;

end.

