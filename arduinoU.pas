unit arduinoU;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.ImageList, system.dateUtils,
  Vcl.Graphics, Vcl.Grids, Vcl.ComCtrls, Vcl.ToolWin,  Vcl.ImgList,
  Vcl.htmlHelpViewer,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  OOmisc, adport, lnswin32, awuser, constreg, aidekey,
  inifiles, registry,
  regutil, arduinoGraphe, arduinoCfg, compile, Vcl.BaseImageCollection,
  Vcl.ImageCollection, Vcl.VirtualImageList;

type
  TModeTemporel = (mDeclenche,mRelaxe,mRoll);
  TTrigger = (tMontant,tDescendant,tClavier);
  tTerminateur = (tNone,tCR,tLF,tCRLF);
  TArduinoForm = class(TForm)
    grid: TStringGrid;
    CommandGB: TGroupBox;
    EnvoiBtn: TButton;
    CommandeEdit: TEdit;
    ToolBar: TToolBar;
    ToolsBtn: TToolButton;
    StartBtn: TToolButton;
    StopBtn: TToolButton;
    RegressiBtn: TToolButton;
    TimerSauve: TTimer;
    PaintBox: TPaintBox;
    Splitter: TSplitter;
    TimerGraphe: TTimer;
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
    GroupBox7: TGroupBox;
    Label6: TLabel;
    GroupBox8: TGroupBox;
    Label7: TLabel;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    RazBtn: TToolButton;
    TriggerTB: TTrackBar;
    TimerCarac: TTimer;
    ErreurCaracLabel: TLabel;
    VoieSerie: TApdComPort;
    HelpBtn: TToolButton;
    Label8: TLabel;
    StartStopBtn: TToolButton;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    procedure FormCreate(Sender: TObject);
    procedure EnvoiBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure ToolsBtnClick(Sender: TObject);
    procedure RegressiBtnClick(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
    procedure StartBtnClick(Sender: TObject);
    procedure TimerSauveTimer(Sender: TObject);
    procedure PaintBoxPaint(Sender: TObject);
    procedure TimerGrapheTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure gridGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure Button2Click(Sender: TObject);
    procedure CommandeEditExit(Sender: TObject);
    procedure RazBtnClick(Sender: TObject);
    procedure TriggerTBChange(Sender: TObject);
    procedure TimerCaracTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure VoieSerieTriggerAvail(CP: TObject; Count: Word);
    procedure VoieSerieTriggerData(CP: TObject; TriggerHandle: Word);
    procedure FormHide(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure StartStopBtnClick(Sender: TObject);
  private
    indiceCourant : integer;
    chaineLue : ansiString;
    liste : TstringList;
    tempsActif : boolean;
    crTrigger : word;
    graphe : TgrapheArduino;
    indexFichier : integer;
    premiereLigne : boolean; // à sauter car non complète par défaut de synchro
    NbreColonnes : integer;
    tZero : TTime; // temps PC
    tempsZero : double; // temps Arduino
    PremierAppel : boolean;
    dureeMax : integer;
    startCommand,stopCommand : string;
    labelVoie : array[TindiceAxes] of Tlabel;
    attenteTrigger : boolean;
    seuilTrigger : double;
    voieTrigger : TindiceAxes;
    precedent : double;
    terminateur : Tterminateur;
    tempsArduino : boolean;
    userData : boolean;
    Procedure Sauvegarde;
    procedure openVoieSerie;
    procedure envoieCommand(const aCommande : string);
    procedure majBoutons;
  public
    sendCommand  : array[0..3] of string;
    SendBtn : array[0..3] of TButton;
    modeTemps : TmodeTemporel;
    trigger : TTrigger;
    monocoup : boolean;
    pointparpoint : boolean;
  end;

var
  ArduinoForm: TArduinoForm;

implementation

{$R *.dfm}

uses regmain, regdde;

const
    terminateurStr : array[tTerminateur] of ansiString = ('',crCR,crLF,crCR+crLF);

procedure TArduinoForm.StopBtnClick(Sender: TObject);
begin
   tempsActif := false;
   if stopCommand<>'' then envoieCommand(stopCommand);
   razBtn.Enabled := true;
   stopBtn.enabled := false;
   startBtn.Enabled := true;
   timerSauve.Enabled := false;
   timerGraphe.enabled := pointParPoint;
   graphe.nbrePointsNew := 0;
   timerGrapheTimer(nil);
   sauvegarde;
end;

procedure TArduinoForm.EnvoiBtnClick(Sender: TObject);
begin
    if commandeEdit.Text=''
      then showMessage('Rien à envoyer')
      else envoieCommand(commandeEdit.Text);
end;

procedure TArduinoForm.StartBtnClick(Sender: TObject);
var i : integer;
begin
    timerGraphe.enabled := true;
    graphe.indexRoll := 0;
    for i := 0 to mondeYmax do begin
        graphe.monde[i].minMaxData := true;
        graphe.monde[i].minMaxCourant := true;
    end;
    if pointParPoint
    then begin
      startBtn.Enabled := indiceCourant<MaxVecteurArduino;
      regressiBtn.Enabled := indiceCourant>4;
      razBtn.Enabled := regressiBtn.Enabled;
      stopBtn.enabled := false;
      stopBtn.visible := false;
      if userData then begin
         try
             graphe.monde[mondeX].valeurC := strToFloat(commandeEdit.Text);
         except
             graphe.monde[mondeX].valeurC := indiceCourant;
         end;
      end;
      if startCommand<>''
         then envoieCommand(startCommand) // acquisition au retour
         else begin
            for i := 0 to nbreColonnes do
                graphe.monde[i].valeur[indiceCourant] := graphe.monde[i].valeurC;
            inc(indiceCourant);
            graphe.nbrePoints := indiceCourant;
         end;
    end
    else begin
        indiceCourant := 0;
        graphe.NbrePoints := 0;
        graphe.NbrePointsNew := 0;
        premiereLigne := true;
        stopBtn.enabled := true;
        stopBtn.visible := true;
        startBtn.Enabled := False;
        timerSauve.Enabled := true;
        premierAppel := true;
        tZero := getTime;
        graphe.monde[mondeX].minMaxData := false;
        graphe.monde[mondeX].minMaxCourant := false;
        graphe.monde[mondeX].maxiStr := IntToStr(round(dureeMax));
        grid.cells[1,4] := IntToStr(round(dureeMax));
        voieSerie.flushInBuffer;
        chaineLue := '';
        if startCommand<>'' then envoieCommand(startCommand);
        tempsActif := true;
        if (modeTemps=mDeclenche) and (trigger<>tClavier) then begin
            attenteTrigger := true;
            if trigger=tMontant
               then precedent := graphe.monde[voieTrigger].maxi
               else precedent := graphe.monde[voieTrigger].mini
        end;
    end;
end;

procedure TArduinoForm.StartStopBtnClick(Sender: TObject);
const
    codeImage : array[boolean] of byte = (9,10);
    captionB : array[boolean] of string = ('Connect.','Stop');
begin
    startStopBtn.caption := captionB[startStopBtn.Down];
    startStopBtn.imageIndex := codeImage[startStopBtn.Down];
end;

procedure TArduinoForm.TimerCaracTimer(Sender: TObject);
begin
    timerCarac.Enabled := false;
    ErreurCaracLabel.visible := false;
end;

procedure TArduinoForm.TimerGrapheTimer(Sender: TObject);
var i : integer;
begin
      if pointParPoint and startStopBtn.Down then begin
           labelVoie[0].Caption := graphe.monde[mondeX].nom+'='+
               formatCourt(graphe.monde[mondeX].valeurC)+' '+
               graphe.monde[mondeX].unite;
           for i := 1 to NbreColonnes do
               labelVoie[i].Caption := graphe.monde[i].nom+'='+liste[i-1]+' '+graphe.monde[i].unite;
           for i := succ(NbreColonnes) to mondeYmax do
               labelVoie[i].Caption := '';
      end;
      for i := 1 to pred(grid.ColCount) do with graphe.monde[i-1] do begin
          nom := grid.Cells[i,1];
          unite := grid.Cells[i,2];
          miniStr := grid.Cells[i,3];
          maxiStr := grid.Cells[i,4];
      end;
      graphe.modePoint := pointParPoint;
      for i := mondeX to mondeYmax do
          graphe.monde[i].minMaxCourant := startStopBtn.Down;
      paintBox.Invalidate;
end;

procedure TArduinoForm.TimerSauveTimer(Sender: TObject);
begin
    Sauvegarde;
end;

procedure TArduinoForm.RazBtnClick(Sender: TObject);
begin
    graphe.nbrePoints := 0;
    graphe.nbrePointsNew := 0;
    indiceCourant := 0;
    paintBox.Invalidate;
end;

procedure TArduinoForm.HelpBtnClick(Sender: TObject);
begin
   //Aide(Help_Arduino);
    AideStr('Arduino');
end;

procedure TArduinoForm.ToolsBtnClick(Sender: TObject);
var j : integer;
begin
     if crTrigger>0 then begin
        voieSerie.RemoveTrigger(crTrigger);
        crTrigger := 0;
     end;
     VoieSerie.Open := False;
     if ArduinoDlg=nil then Application.CreateForm(TArduinoDlg,ArduinoDlg);
     ArduinoDlg.dureeMaxSE.Value := dureeMax;
     ArduinoDlg.startEdit.Text := startCommand;
     ArduinoDlg.stopEdit.Text := stopCommand;
     ArduinoDlg.TerminateurRG.ItemIndex := ord(terminateur);
     for j := 1 to 3 do begin
          ArduinoDlg.sendGrid.Cells[j,1] := sendCommand[j];
          ArduinoDlg.sendGrid.Cells[j,2] := sendBtn[j].caption;
     end;
     for j := 0 to indexVitesseMax do begin
         ArduinoDlg.baudRG.items[j] := intToStr(vitesseBaud[j]);
         if voieSerie.Baud=vitesseBaud[j] then ArduinoDlg.BaudRG.ItemIndex := j;
     end;
     ArduinoDlg.Comports.items.clear;
     for j := 1 to MaxComHandles do
        if IsPortAvailable(j) then begin
           ArduinoDlg.Comports.Items.Add('COM'+IntToStr(j));
           NumeroCom[ArduinoDlg.Comports.items.count-1] := j;
           if j=voieSerie.comNumber then
              ArduinoDlg.Comports.ItemIndex := ArduinoDlg.Comports.items.count-1;
        end;
     if ArduinoDlg.comports.Items.count=0 then begin
        showMessage('Pas de voie série');
        exit;
     end;
     if (ArduinoDlg.Comports.ItemIndex<0) then
        ArduinoDlg.Comports.itemIndex := 0;
     ArduinoDlg.monocoupCB.Checked := monocoup;
     ArduinoDlg.tempsArduinoCB.Checked := tempsArduino;
     ArduinoDlg.userDataCB.Checked := userData;
     ArduinoDlg.triggerRG.ItemIndex := ord(trigger);
     ArduinoDlg.modeTempsRG.ItemIndex := ord(modeTemps);
     if pointParPoint
        then ArduinoDlg.modeRG.ItemIndex := 0
        else ArduinoDlg.modeRG.ItemIndex := 1;
     if ArduinoDlg.ShowModal=mrOK then begin
         dureeMax := arduinoDlg.dureeMaxSE.Value;
         startCommand := ArduinoDlg.startEdit.Text;
         stopCommand := ArduinoDlg.stopEdit.Text;
         terminateur := Tterminateur(ArduinoDlg.TerminateurRG.ItemIndex);
         for j := 0 to 3 do begin
            sendCommand[j] := ArduinoDlg.sendGrid.Cells[j,1];
            sendBtn[j].caption := ArduinoDlg.sendGrid.Cells[j,2];
            sendBtn[j].visible := sendCommand[j]<>'';
            if (sendBtn[j].caption='') then sendBtn[j].caption := sendCommand[j];
         end;
         pointParPoint := ArduinoDlg.modeRG.ItemIndex=0;
         trigger := TTrigger(ArduinoDlg.triggerRG.ItemIndex);
         modeTemps := TModeTemporel(ArduinoDlg.modeTempsRG.ItemIndex);
         voieSerie.comNumber := NumeroCom[ArduinoDlg.Comports.ItemIndex];
         voieSerie.baud := strToInt(ArduinoDlg.baudRG.items[ArduinoDlg.BaudRG.ItemIndex]);
         monocoup := ArduinoDlg.monocoupCB.checked;
         tempsArduino := ArduinoDlg.tempsArduinoCB.checked;
         userData := ArduinoDlg.userDataCB.checked;
         if userData and
         ((graphe.monde[mondeX].nom='index') or
          (graphe.monde[mondeX].nom='k')) then
              graphe.monde[mondeX].nom := 'd';
     end;
     openVoieSerie;
     majBoutons;
     timerGraphe.Enabled := pointParPoint;
end;

procedure TArduinoForm.Button2Click(Sender: TObject);
begin
    envoieCommand(sendCommand[(sender as TButton).tag])
end;

procedure TArduinoForm.CommandeEditExit(Sender: TObject);
begin
    sendCommand[0] := commandeEdit.Text;
    sendBtn[0].Visible := sendCommand[0]<>'';
end;

procedure TArduinoForm.FormActivate(Sender: TObject);
begin
    openVoieSerie;
    NbreColonnes := -1; // pas de données
    timerGraphe.Enabled := voieSerie.Open and pointParPoint;
    PanelVoies.Visible := timerGraphe.Enabled;
    majBoutons;
end;

procedure TArduinoForm.FormClose(Sender: TObject; var Action: TCloseAction);
var Rini : TMemInifile;
    j : integer;
    indexM : integer;
begin
     Rini := TMemIniFile.create(NomFichierIni);
     Rini.WriteInteger(stArduino,'Com',voieSerie.comNumber);
     for j := 0 to 3 do begin
         Rini.WriteString(stArduino,'Commande'+intToStr(j),sendCommand[j]);
         Rini.WriteString(stArduino,'Caption'+intToStr(j),sendBtn[j].caption);
     end;
     Rini.WriteString(stArduino,'Start',startCommand);
     Rini.WriteString(stArduino,stStop,stopCommand);
     Rini.WriteInteger(stArduino,'DureeMax',dureeMax);
     Rini.WriteInteger(stArduino,'Baud',voieSerie.baud);
     Rini.WriteInteger(stArduino,'Terminateur',ord(terminateur));
     Rini.WriteBool(stArduino,'TempsArduino',TempsArduino);
     Rini.WriteBool(stArduino,'UserData',UserData);
     Rini.WriteInteger(stArduino,'Mode',ord(modeTemps));
     Rini.WriteInteger(stArduino,'Trigger',ord(trigger));
     Rini.WriteBool(stArduino,'Monocoup',monocoup);
     Rini.WriteBool(stArduino,'PointParPoint',pointParPoint);
     for j := 1 to pred(grid.colCount) do begin
         indexM := j-1;
         if grid.cells[j,1]<>'' then
            Rini.writeString(stArduino,'Nom'+intToStr(indexM),grid.cells[j,1]);
         if grid.cells[j,2]<>'' then
            Rini.writeString(stArduino,'Unit'+intToStr(indexM),grid.cells[j,2]);
         if grid.cells[j,3]<>'' then
            Rini.writeString(stArduino,stMini+intToStr(indexM),grid.cells[j,3]);
         if grid.cells[j,4]<>'' then
            Rini.writeString(stArduino,stMaxi+intToStr(indexM),grid.cells[j,4]);
     end;
     Rini.updateFile;
     Rini.Free;
     if crTrigger<>0 then begin
        voieSerie.RemoveTrigger(crTrigger);
        crTrigger := 0;
     end;
     {$IFDEF Debug}
     voieSerie.Tracing := tlDump;
     voieSerie.Logging := tlDump;
     {$ENDIF}
     VoieSerie.Open := false;
     timerSauve.Enabled := false;
     tempsActif := false;
     timerGraphe.Enabled := false;
end;  // formClose

procedure TArduinoForm.FormCreate(Sender: TObject);
const nomDefaut : array[TindiceAxes] of string  = ('t','X','Y','Z','aX','aY','aZ');
      uniteDefaut : array[TindiceAxes] of string  = ('s','','','','','','');
var j : integer;
    Rini : TMemIniFile;
    baudOK : boolean;
    gbvoie : TGroupBox;
    indexM : integer;
begin
     voieTrigger := mondeY;
     graphe := TgrapheArduino.create;
     graphe.isOscillo := false;
     graphe.canvas := paintBox.canvas;
     for j := 0 to pred(commandGB.ControlCount) do
         if commandGB.Controls[j] is Tbutton then
            sendBtn[commandGB.Controls[j].Tag] := Tbutton(commandGB.Controls[j]);
     indexFichier := 0;
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
     terminateur := Tterminateur(Rini.readInteger(stArduino,'Terminateur',0));
     VoieSerie.Baud := Rini.ReadInteger(stArduino,'Baud',9600);
     for j := 1 to 3 do begin
         sendCommand[j] := Rini.ReadString(stArduino,'Commande'+intToStr(j),'');
         sendBtn[j].caption := Rini.ReadString(stArduino,'Caption'+intToStr(j),'');
         sendBtn[j].visible := sendCommand[j]<>'';
     end;
     for j := 2 to pred(grid.ColCount) do grid.Cells[j,0] := 'Arduino'+intToStr(j-2);
     startCommand := Rini.ReadString(stArduino,'Start','');
     stopCommand := Rini.ReadString(stArduino,stStop,'');
     dureeMax := Rini.ReadInteger(stArduino,'DureeMax',15);
     modeTemps := TmodeTemporel(Rini.ReadInteger(stArduino,'Mode',0));
     pointParPoint := Rini.ReadBool(stArduino,'PointParPoint',true);
     TempsArduino := Rini.ReadBool(stArduino,'TempsArduino',false);
     UserData := Rini.ReadBool(stArduino,'UserData',false);
     trigger := TTrigger(Rini.ReadInteger(stArduino,'Trigger',0));
     monocoup := Rini.ReadBool(stArduino,'Monocoup',true);
     j := 0;
     repeat
         baudOK := voieSerie.Baud=vitesseBaud[j];
         inc(j)
     until baudOK or (j>indexVitesseMax);
     if not baudOK then VoieSerie.Baud := 9600;
     {$IFDEF Debug}
     voieSerie.Tracing := tlOn;
     voieSerie.Logging := tlOn;
     voieSerie.TraceName := changeFileExt(application.ExeName,'.trc');
     voieSerie.LogName := changeFileExt(application.ExeName,'.log');
     //voieSerie.TraceName := 'c:\temp\arduino.trc';
     //voieSerie.LogName := 'c:\temp\arduino.log';
     {$ELSE}
     voieSerie.Tracing := tlOff;
     voieSerie.Logging := tlOff;
     {$ENDIF}
     liste := TstringList.Create;
 //    grid.DefaultRowHeight := hauteurColonne;
     grid.Cells[0,1] := stNom;
     grid.Cells[0,2] := stUnite;
     grid.Cells[0,3] := stMini;
     grid.Cells[0,4] := stMaxi;
     for j := 1 to pred(grid.colCount) do begin
         indexM := j-1;
         grid.Cells[j,1] := Rini.readString(stArduino,'Nom'+intToStr(indexM),nomDefaut[indexM]);
         graphe.monde[indexM].nom := grid.Cells[j,1];
         grid.Cells[j,2] := Rini.readString(stArduino,'Unit'+intToStr(indexM),uniteDefaut[indexM]);
         graphe.monde[indexM].unite := grid.Cells[j,2];
         grid.Cells[j,3] := Rini.readString(stArduino,stMini+intToStr(indexM),'');
         graphe.monde[indexM].miniStr := grid.Cells[j,3];
         grid.Cells[j,4] := Rini.readString(stArduino,stMaxi+intToStr(indexM),'');
         graphe.monde[indexM].maxiStr := grid.Cells[j,4];
     end;
     Rini.Free;
     indiceCourant := 0;
     nbreColonnes := -1;
     tempsActif := false;
     crTrigger := 0;
     with PanelVoies do
     for j := 0 to pred(controlCount) do begin
         GBVoie := TGroupBox(controls[j]);
         LabelVoie[j] := Tlabel(GBvoie.controls[0]);
         LabelVoie[j].Font.color := clWhite;
         LabelVoie[j].tag := j;
         GBVoie.Tag := j;
         GBVoie.Font.color := clWhite;
         GBVoie.color := couleurArduino[j];
     end;
     ResizeButtonImagesforHighDPI(self);
end; // formCreate

procedure TArduinoForm.FormDestroy(Sender: TObject);
begin
     VoieSerie.Free;
     Graphe.free;
end;

procedure TArduinoForm.FormHide(Sender: TObject);
begin
   voieSerie.Open := false;
end;

procedure TArduinoForm.FormShow(Sender: TObject);
begin
    openVoieSerie;
end;

procedure TArduinoForm.gridGetEditText(Sender: TObject; ACol, ARow: Integer;
  var Value: string);
begin
    if ACol=0 then exit;
    case Arow of
        1 : graphe.monde[ACol-1].nom := value;
        2 : graphe.monde[ACol-1].unite := value;
        3 : graphe.monde[ACol-1].miniStr := value;
        4 : graphe.monde[ACol-1].maxiStr := value;
    end;
end;

procedure TArduinoForm.PaintBoxPaint(Sender: TObject);
begin
      graphe.mondeMax := nbreColonnes;
      if not pointParPoint then begin
         graphe.Monde[mondex].miniStr := '0';
         graphe.Monde[mondex].maxiStr := dureeMax.toString;
      end;
      graphe.drawG;
end;

procedure TArduinoForm.RegressiBtnClick(Sender: TObject);
var i,k : integer;
    Ligne : String;
    t : double;
begin
     FormDDE.donnees.Clear;
     FormDDE.donnees.add(Application.exeName);
     FormDDE.donnees.add('');
     ligne := '';
     for k := 0 to graphe.mondeMax do begin  // noms
         if grid.Cells[k+1,1]='' then grid.Cells[k+1,1] := 'x'+intToStr(k);
         Ligne := ligne+grid.Cells[k+1,1]+crTab;
     end;
     FormDDE.donnees.add(Ligne);
     ligne := '';
     for k := 0 to graphe.mondeMax do // unités
         Ligne := ligne+grid.Cells[k+1,2]+crTab;
     FormDDE.donnees.add(ligne);
     if modeTemps=mRoll
     then if graphe.deltatRoll>0
        then begin
          t := 0;
          for i := graphe.indexRoll to pred(graphe.nbrePoints) do begin // data
             ligne := floatToStrPoint(t);
             t := t + graphe.deltatRoll;
             for k := 1 to graphe.mondeMax do
                Ligne := ligne+floatToStrPoint(graphe.monde[k].valeur[i])+crTab;
             FormDDE.donnees.add(Ligne);
          end;
          for i := 0 to graphe.indexRoll-1  do begin // data
            ligne := floatToStrPoint(t)+crTab;
            t := t + graphe.deltatRoll;
            for k := 1 to graphe.mondeMax do
              Ligne := ligne+floatToStrPoint(graphe.monde[k].valeur[i])+crTab;
            FormDDE.donnees.add(Ligne);
          end;
        end
        else begin
           for i := graphe.indexRoll to pred(graphe.nbrePoints) do begin // data
             ligne := '';
             for k := 0 to graphe.mondeMax do
                 Ligne := ligne+floatToStrPoint(graphe.monde[k].valeur[i])+crTab;
             FormDDE.donnees.add(Ligne);
          end;
          for i := 0 to graphe.indexRoll-1  do begin // data
             ligne := '';
             for k := 0 to graphe.mondeMax do
                Ligne := ligne+floatToStrPoint(graphe.monde[k].valeur[i])+crTab;
             FormDDE.donnees.add(Ligne);
          end;
        end
     else begin
       for i := 0 to pred(indiceCourant) do begin // data
         ligne := '';
         for k := 0 to graphe.mondeMax do
             Ligne := ligne+floatToStrPoint(graphe.monde[k].valeur[i])+crTab;
         FormDDE.donnees.add(Ligne);
       end;
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

procedure TArduinoForm.TriggerTBChange(Sender: TObject);
begin
 seuilTrigger := graphe.monde[voieTrigger].mini+
    (triggerTB.max-triggerTB.position)*(graphe.monde[voieTrigger].maxi-graphe.monde[voieTrigger].mini)/triggerTB.max;
end;

procedure TArduinoForm.VoieSerieTriggerAvail(CP: TObject; Count: Word);
var
   i: word;
   carac: ansiChar;
begin
    for i := 1 to Count do begin
       if voieSerie.CharReady then begin
          carac := voieSerie.GetChar;
          if (carac > ' ') then chaineLue := chaineLue + carac;
          if not TimerCarac.enabled  and (ord(carac)>ord(';')) then begin
                 TimerCarac.enabled := true;
                 ErreurCaracLabel.visible := true;
          end;
       end;
    end
end;// TriggerAvail

procedure TArduinoForm.VoieSerieTriggerData(CP: TObject; TriggerHandle: Word);

procedure TriggerDataPoint;
var i : integer;
begin
      nbreColonnes := liste.Count; // index en plus
      if nbreColonnes>mondeYMax then nbreColonnes := mondeYMax;
      for i := 1 to nbreColonnes do
          graphe.monde[i].valeurC := strToFloatWin(liste[i-1]);
      if userData then begin
         try
             graphe.monde[mondeX].valeurC := strToFloat(commandeEdit.Text);
         except
             graphe.monde[mondeX].valeurC := indiceCourant;
         end;
      end
      else graphe.monde[mondeX].valeurC := indiceCourant;
      if startCommand<>'' then begin
         for i := 0 to nbreColonnes do
             graphe.monde[i].valeur[indiceCourant] := graphe.monde[i].valeurC;
         inc(indiceCourant);
         graphe.nbrePoints := indiceCourant;
      end;
      regressiBtn.Enabled := indiceCourant>5;
      razBtn.Enabled := regressiBtn.Enabled;
      startBtn.Enabled := indiceCourant<MaxVecteurArduino;
end;

procedure Stop;
var Timer : EventTimer;
begin
        tempsActif := false;
        envoieCommand(stopCommand);
        newTimer(timer,3); // 165 ms
        ToolBar.Enabled := false;
        repeat
             application.ProcessMessages;
        until timerExpired(timer);
        ToolBar.Enabled := true;
        VoieSerie.flushInBuffer;
        chaineLue := '';
        tempsActif := true;
end;

procedure TriggerDataTemps;
var i : integer;
    m : TindiceAxes;
    seuilAtteint : boolean;
begin
      if not tempsActif then exit;
      if premiereLigne then begin
         premiereLigne := false;
         tZero := getTime;
         exit;
      end;
      if tempsArduino
         then begin
            nbreColonnes := liste.Count-1;
            if nbreColonnes>mondeYMax then nbreColonnes := mondeYMax;
            for i := 0 to nbreColonnes do
                graphe.monde[i].valeurC := strToFloatWin(liste[i]);
            if (indiceCourant=0) then if modeTemps=mRoll
                then begin
                   if premierAppel then tempsZero := graphe.monde[mondeX].valeurC;
                end
                else tempsZero := graphe.monde[mondeX].valeurC;
            graphe.monde[mondeX].valeurC := graphe.monde[mondeX].valeurC-tempsZero;
         end
         else begin
            nbreColonnes := liste.Count; // temps en plus
            if nbreColonnes>mondeYMax then nbreColonnes := mondeYMax;
            graphe.monde[mondeX].valeurC := milliSecondsBetween(getTime,tZero)/1000.0;
            for i := 1 to nbreColonnes do
                graphe.monde[i].valeurC := strToFloatWin(liste[i-1]);
         end;
      try
      for i := 0 to nbreColonnes do with graphe.monde[i] do begin
          if premierAppel or (modeTemps=mRoll)
             then valeur[indiceCourant] := valeurC
             else valeurNew[indiceCourant] := valeurC;
      end;
      case modeTemps of
          mDeclenche : case trigger of
             tClavier : begin
                inc(indiceCourant);
                graphe.nbrePoints := indiceCourant;
             end;
             tMontant,tDescendant : if attenteTrigger
                 then begin
                      if trigger=tMontant
                         then seuilAtteint := (graphe.monde[voieTrigger].valeurC>=seuilTrigger) and
                                                (precedent<seuilTrigger)
                         else seuilAtteint := (graphe.monde[voieTrigger].valeurC<=seuilTrigger) and
                                                (precedent>seuilTrigger);
                      if seuilAtteint then begin
                         tZero := getTime;
                         graphe.nbrePoints := 1;
                         indiceCourant := 1;
                         attenteTrigger := false;
                      end;
                      Precedent := graphe.monde[voieTrigger].valeurC;
                 end
                 else begin
                   inc(indiceCourant);
                   graphe.nbrePoints := indiceCourant;
                 end;
          end;
          mRelaxe : begin
            inc(indiceCourant);
            if premierAppel
               then graphe.nbrePoints := indiceCourant
               else graphe.NbrePointsNew := indiceCourant;
          end;
          mRoll : begin
            inc(indiceCourant);
            if premierAppel
               then graphe.nbrePoints := indiceCourant
               else graphe.indexRoll := indiceCourant;
          end;
      end;
      except
      end;
      if (modeTemps=mRoll) and not premierAppel
         then graphe.monde[mondeX].valeurC := dureeMax; // le temps Courant en mode Roll est toujours la fin
      if (indiceCourant>=MaxVecteurArduino) or
         (graphe.monde[mondeX].valeurC>dureeMax) then begin
         tZero := getTime;
         case modeTemps of
            mDeclenche : case trigger of
              tClavier : stopBtnClick(nil);
              tmontant,tdescendant : if monocoup
              then stopBtnClick(nil)
              else begin
                  if not premierAppel then begin
                    graphe.nbrePoints := graphe.NbrePointsNew;
                    for m := mondeX to graphe.mondeMax do
                        graphe.monde[m].valeur := graphe.monde[m].valeurNew;
                  end;
                  indiceCourant := 0;
                  premierAppel := false;
                  graphe.nbrePointsNew := 0;
                  tZero := getTime;
                  attenteTrigger := true;
                  if trigger=tMontant
                      then precedent := graphe.monde[voieTrigger].maxi
                      else precedent := graphe.monde[voieTrigger].mini
              end;
            end;// case
            mRelaxe : begin
              if not premierAppel then begin
                graphe.nbrePoints := graphe.NbrePointsNew;
                for m := mondeX to graphe.mondeMax do
                      graphe.monde[m].valeur := graphe.monde[m].valeurNew;
              end;
              indiceCourant := 0;
              premierAppel := false;
              premiereLigne := true;
              graphe.nbrePointsNew := 0;
              if stopCommand<>'' then stop;
              if startCommand<>'' then envoieCommand(startCommand);  // RàZ du temps
            end;
            mRoll : begin
              premierAppel := false;
              graphe.indexRoll := 0;
              if tempsArduino
                 then graphe.deltatRoll := 0
                 else graphe.deltatRoll := (graphe.monde[mondeX].valeur[indiceCourant-1]-
                                           graphe.monde[mondeX].valeur[0])/(indiceCourant-1);
              indiceCourant := 0;
            end;
         end;
      end;
      regressiBtn.Enabled := (indiceCourant>5) or (graphe.NbrePoints>5);
end; // triggerDataTemps

begin
      liste.commaText := string(chaineLue);
      chaineLue := '';
      if liste.Count<1 then exit;
      if pointParPoint
         then triggerDataPoint
         else TriggerDataTemps;
end;

(*
procedure TArduinoForm.LockGrid;
begin
    Grid.Perform(WM_SETREDRAW, 0, 0);
end;

procedure TArduinoForm.UnLockGrid;
begin
     Grid.Perform(WM_SETREDRAW, 1, 0);
     Grid.Invalidate; // important! to force repaint after all
end;
*)

Procedure TArduinoForm.Sauvegarde;
var nomFichier,ligne : string;
    i,k : integer;
begin
     if not regressiBtn.Enabled then exit;
     NomFichier := MesDocsDir+'RegressiArduino'+intToStr(indexFichier)+'.csv';
     inc(indexFichier);
     if indexFichier>128 then indexFichier := 0;
     AssignFile(fichier,NomFichier);
     Rewrite(fichier);
     for i := 0 to pred(graphe.NbrePoints) do begin
         ligne := '';
         for k := 0 to NbreColonnes do
             Ligne := ligne+FloatToStrPoint(graphe.monde[k].Valeur[i])+',';
         writeln(fichier,Ligne);
     end;
     try
     CloseFile(fichier);
     except
         CloseFile(fichier);
     end;
end;

Procedure TArduinoForm.OpenVoieSerie;
begin
     if not voieSerie.Open and isPortAvailable(voieSerie.ComNumber) then begin
         try
         {$IFDEF Debug}
           VoieSerie.Tracing := tlOn;
           VoieSerie.Logging := tlOn;
           VoieSerie.TraceName := MesDocsDir+'arduino.trc';
           VoieSerie.LogName := MesDocsDir+'arduino.log';
         {$ENDIF}
         VoieSerie.Open := True;
         if crTrigger=0 then crTrigger := voieSerie.addDataTrigger(crCR,true);
         except
         ShowMessage('Problème voie série');
         end;
     end;
end;

procedure TArduinoForm.envoieCommand(const aCommande : string);
begin
    voieSerie.Output := ansiString(aCommande)+terminateurStr[terminateur]
end;

procedure TArduinoForm.majBoutons;
begin
   commandGB.Caption := 'Commande à envoyer à Arduino';
   commandeEdit.Hint := 'Commande à envoyer à Arduino';
   grid.FixedCols := 2;
   stopBtn.visible := not pointParPoint;
   startStopBtn.visible := pointParPoint;
   if pointParPoint
   then begin
      caption := 'Acquisition point par point par Arduino/Micro:bit pour Regressi';
      if startCommand=''
         then begin
            startBtn.hint := 'Enregistrer le point courant';
         end
         else begin
            startBtn.hint := 'Acquérir un point';
            commandeEdit.Hint := 'Valeur de la donnée utilisateur';
            commandGB.Caption := 'Donnée utilisateur';
            grid.FixedCols := 1;
         end;
      PanelVoies.Visible := true;
      if userData then begin
         Grid.Cells[1,0] := 'Donnée';
         Grid.Cells[1,1] := graphe.monde[mondeX].nom;
         Grid.Cells[1,2] := graphe.monde[mondeX].unite;
      end
      else begin
         Grid.Cells[1,0] := 'index';
         Grid.Cells[1,1] := 'k';
         Grid.Cells[1,2] := '';
      end;
      triggerTB.Visible := false;
   end
   else begin
      caption := 'Acquisition temporelle par Arduino/Micro:bit pour Regressi';
      startBtn.hint := 'Lancer l''acquisition';
      PanelVoies.Visible := false;
      Grid.Cells[1,0] := stTemps;
      Grid.Cells[1,1] := 't';
      Grid.Cells[1,2] := 's';
      triggerTB.Visible := (modeTemps=mDeclenche) and (trigger<>tClavier);
   end;

end;

end.

