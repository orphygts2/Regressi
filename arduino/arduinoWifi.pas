unit arduinoWifi;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.ImageList, system.dateUtils,
  Vcl.Graphics, Vcl.Grids, Vcl.ComCtrls, Vcl.ToolWin,  Vcl.ImgList,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.htmlHelpViewer,
  inifiles, registry, constreg, aidekey,
  regutil, arduinoGraphe, arduinoWifiCfg, compile,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient, Vcl.BaseImageCollection,
  Vcl.ImageCollection, Vcl.VirtualImageList;

type
  TModeTemporel = (mDeclenche,mRelaxe,mRoll);
  TReadingThread = class(TThread)
  private
    FClient: TIdUDPClient;
  protected
    procedure Execute; override;
  public
    constructor Create(AClient: TIdUDPClient); reintroduce;
  end;
  TArduinoWifiForm = class(TForm)
    grid: TStringGrid;
    GroupBox1: TGroupBox;
    Button1: TButton;
    CommandeEdit: TEdit;
    ToolBar: TToolBar;
    ToolsBtn: TToolButton;
    StartBtn: TToolButton;
    StopBtn: TToolButton;
    RegressiBtn: TToolButton;
    TimerSauve: TTimer;
    PaintBox: TPaintBox;
    Splitter: TSplitter;
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
    TimerAcq: TTimer;
    UDPClient: TIdUDPClient;
    UdpConnectBtn: TToolButton;
    ToolButton1: TToolButton;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
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
    procedure TimerAcqTimer(Sender: TObject);
    procedure UdpConnectBtnClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
  private
    indiceCourant : integer;
    liste : TstringList;
    tempsActif : boolean;
    graphe : TgrapheArduino;
    indexFichier : integer;
    premiereLigne : boolean; // à sauter car non complète par défaut de synchro
    NbreColonnes : integer;
    tZero : TTime; // temps PC
    PremierAppel : boolean;
    dureeMax : integer;
    getCommand : string;
    labelVoie : array[TindiceAxes] of Tlabel;
    UdpThread : TReadingThread;
    Tech : integer; // milliseconde
    modeTemps : TmodeTemporel;
    pointparpoint : boolean;
    procedure UdpTriggerData(chaineLue : string);
    Procedure Sauvegarde;
    procedure envoieCommand(const aCommande : string);
  public
    sendCommand  : array[0..3] of string;
    SendBtn : array[0..3] of TButton;
  end;

var
  ArduinoWifiForm: TArduinoWifiForm;

implementation

{$R *.dfm}

uses regmain, regdde;

procedure TArduinoWifiForm.StopBtnClick(Sender: TObject);
begin
   tempsActif := false;
   razBtn.Enabled := true;
   stopBtn.enabled := false;
   startBtn.Enabled := true;
   timerSauve.Enabled := false;
   PanelVoies.Visible := pointParPoint;
   graphe.nbrePointsNew := 0;
   timerGrapheTimer(nil);
   sauvegarde;
end;

procedure TArduinoWifiForm.Button1Click(Sender: TObject);
begin
   envoieCommand(commandeEdit.Text);
end;

procedure TArduinoWifiForm.StartBtnClick(Sender: TObject);
var i : integer;
begin
    graphe.indexRoll := 0;
    for i := 0 to mondeYmax do begin
        graphe.monde[i].minMaxData := true;
        graphe.monde[i].minMaxCourant := true;
    end;
    if pointParPoint
    then begin
      for i := 0 to nbreColonnes do
          graphe.monde[i].valeur[indiceCourant] := graphe.monde[i].valeurC;
      inc(indiceCourant);
      startBtn.Enabled := indiceCourant<MaxvecteurArduino;
      graphe.nbrePoints := indiceCourant;
      regressiBtn.Enabled := indiceCourant>4;
      razBtn.Enabled := regressiBtn.Enabled;
      stopBtn.enabled := false;
      PanelVoies.Visible := true;
    end
    else begin
        indiceCourant := 0;
        graphe.NbrePoints := 0;
        graphe.NbrePointsNew := 0;
        premiereLigne := true;
        stopBtn.enabled := true;
        startBtn.Enabled := False;
        timerSauve.Enabled := true;
        premierAppel := true;
        tZero := getTime;
        graphe.monde[mondeX].minMaxData := false;
        graphe.monde[mondeX].minMaxCourant := false;
        graphe.monde[mondeX].maxiStr := IntToStr(round(dureeMax));
        grid.cells[1,3] := IntToStr(round(dureeMax));
        tempsActif := true;
        PanelVoies.Visible := false;
        timerAcq.Interval := Tech;
        timerAcq.Enabled := true;
    end;
end;

procedure TArduinoWifiForm.TimerAcqTimer(Sender: TObject);
begin
      UdpClient.Send(getCommand);
end;

procedure TArduinoWifiForm.TimerGrapheTimer(Sender: TObject);
var i : integer;
begin
      for i := 1 to pred(grid.ColCount) do with graphe.monde[i-1] do begin
          nom := grid.Cells[i,0];
          unite := grid.Cells[i,1];
          miniStr := grid.Cells[i,2];
          maxiStr := grid.Cells[i,3];
      end;
      graphe.modePoint := pointParPoint;
      paintBox.Invalidate;
end;

procedure TArduinoWifiForm.TimerSauveTimer(Sender: TObject);
begin
    Sauvegarde;
end;

procedure TArduinoWifiForm.RazBtnClick(Sender: TObject);
begin
    graphe.nbrePoints := 0;
    graphe.nbrePointsNew := 0;
    paintBox.Invalidate;
end;

procedure TArduinoWifiForm.ToolButton1Click(Sender: TObject);
begin
   Aide(Help_Arduino);
end;

procedure TArduinoWifiForm.ToolsBtnClick(Sender: TObject);
var j : integer;
begin
     if ArduinoWifiDlg=nil then Application.CreateForm(TArduinoWifiDlg,ArduinoWifiDlg);
     ArduinoWifiDlg.dureeMaxSE.Value := dureeMax;
     ArduinoWifiDlg.getEdit.Text := getCommand;
     for j := 1 to 3 do begin
          ArduinoWifiDlg.sendGrid.Cells[j,1] := sendCommand[j];
          ArduinoWifiDlg.sendGrid.Cells[j,2] := sendBtn[j].caption;
     end;
     ArduinoWifiDlg.modeTempsRG.ItemIndex := ord(modeTemps);
     ArduinoWifiDlg.TechSE.value := Tech;
     ArduinoWifiDlg.HostEdit.Text := UdpClient.host;
     ArduinoWifiDlg.PortEdit.Text := UdpClient.port.toString;
     if pointParPoint
        then ArduinoWifiDlg.modeRG.ItemIndex := 0
        else ArduinoWifiDlg.modeRG.ItemIndex := 1;
     if ArduinoWifiDlg.ShowModal=mrOK then begin
         UdpClient.host := ArduinoWifiDlg.HostEdit.Text;
         UdpClient.port := StrToInt(ArduinoWifiDlg.PortEdit.Text);
         dureeMax := arduinoWifiDlg.dureeMaxSE.Value;
         getCommand := ArduinoWifiDlg.getEdit.Text;
         Tech := ArduinoWifiDlg.TechSE.value;
         for j := 0 to 3 do begin
            sendCommand[j] := ArduinoWifiDlg.sendGrid.Cells[j,1];
            sendBtn[j].caption := ArduinoWifiDlg.sendGrid.Cells[j,2];
            sendBtn[j].visible := sendCommand[j]<>'';
            if (sendBtn[j].caption='') then sendBtn[j].caption := sendCommand[j];
         end;
         pointParPoint := ArduinoWifiDlg.modeRG.ItemIndex=0;
         modeTemps := TModeTemporel(ArduinoWifiDlg.modeTempsRG.ItemIndex);
     end;
     PanelVoies.Visible := pointParPoint;
     if pointParPoint then begin
        Grid.Cells[1,0] := 'index';
        Grid.Cells[1,1] := '';
     end
     else begin
        Grid.Cells[1,0] := stTemps;
        Grid.Cells[1,1] := 's';
     end
end;

procedure TArduinoWifiForm.Button2Click(Sender: TObject);
begin
    envoieCommand(sendCommand[(sender as TButton).tag])
end;

procedure TArduinoWifiForm.CommandeEditExit(Sender: TObject);
begin
    sendCommand[0] := commandeEdit.Text;
    sendBtn[0].Visible := sendCommand[0]<>'';
end;

procedure TArduinoWifiForm.FormActivate(Sender: TObject);
begin
    NbreColonnes := -1; // pas de données
    PanelVoies.Visible := pointParPoint;
end;

procedure TArduinoWifiForm.FormClose(Sender: TObject; var Action: TCloseAction);
var Rini : TMemInifile;
    j : integer;
    indexM : integer;
begin
     Rini := TMemIniFile.create(NomFichierIni);
     for j := 0 to 3 do begin
         Rini.WriteString(stArduino,'Commande'+intToStr(j),sendCommand[j]);
         Rini.WriteString(stArduino,'Caption'+intToStr(j),sendBtn[j].caption);
     end;
     Rini.WriteString(stArduino,'Get',getCommand);
     Rini.WriteString(stArduino,'UdpHost',UdpClient.host);
     Rini.WriteInteger(stArduino,'UdpPort',UdpClient.port);
     Rini.WriteInteger(stArduino,'DureeMax',dureeMax);
     Rini.WriteInteger(stArduino,'Mode',ord(modeTemps));
     Rini.WriteBool(stArduino,'PointParPoint',pointParPoint);
     for j := 1 to pred(grid.colCount) do begin
         indexM := j-1;
         if grid.cells[j,0]<>'' then
            Rini.writeString(stArduino,stNom+intToStr(indexM),grid.cells[j,0]);
         if grid.cells[j,1]<>'' then
            Rini.writeString(stArduino,stUnite+intToStr(indexM),grid.cells[j,1]);
         if grid.cells[j,2]<>'' then
            Rini.writeString(stArduino,stMini+intToStr(indexM),grid.cells[j,2]);
         if grid.cells[j,3]<>'' then
            Rini.writeString(stArduino,stMaxi+intToStr(indexM),grid.cells[j,3]);
     end;
     Rini.updateFile;
     Rini.Free;
     timerSauve.Enabled := false;
     tempsActif := false;
     if UdpClient.Connected then UdpClient.Disconnect;
     UdpClient.Active := false;
end;  // formClose

procedure TArduinoWifiForm.FormCreate(Sender: TObject);
const nomDefaut : array[TindiceAxes] of string  = ('t','X','Y','Z','aX','aY','aZ');
      uniteDefaut : array[TindiceAxes] of string  = ('s','','','','','','');
var j : integer;
    Rini : TMemIniFile;
    gbvoie : TGroupBox;
    indexM : integer;
begin
     graphe := TgrapheArduino.create;
     graphe.isOscillo := false;
     graphe.canvas := paintBox.canvas;
     for j := 0 to pred(GroupBox1.ControlCount) do
         if groupBox1.Controls[j] is Tbutton then
            sendBtn[groupBox1.Controls[j].Tag] := Tbutton(groupBox1.Controls[j]);
     indexFichier := 0;
     Rini := TMemIniFile.create(NomFichierIni);
     for j := 1 to 3 do begin
         sendCommand[j] := Rini.ReadString(stArduino,'Commande'+intToStr(j),'');
         sendBtn[j].caption := Rini.ReadString(stArduino,'Caption'+intToStr(j),'');
         sendBtn[j].visible := sendCommand[j]<>'';
     end;
     UdpClient.host := Rini.ReadString(stArduino,'UdpHost',UdpClient.host);
     UdpClient.port := Rini.ReadInteger(stArduino,'UdpPort',UdpClient.port);
     getCommand := Rini.ReadString(stArduino,'Get','Get');
     if getCommand='' then getCommand := 'Get';

     dureeMax := Rini.ReadInteger(stArduino,'DureeMax',15);
     modeTemps := TmodeTemporel(Rini.ReadInteger(stArduino,'Mode',0));
     pointParPoint := Rini.ReadBool(stArduino,'PointParPoint',true);
     liste := TstringList.Create;
     grid.Cells[0,0] := stNom;
     grid.Cells[0,1] := stUnite;
     grid.Cells[0,2] := stMini;
     grid.Cells[0,3] := stMaxi;
     for j := 1 to pred(grid.colCount) do begin
         indexM := j-1;
         grid.Cells[j,0] := Rini.readString(stArduino,stNom+intToStr(indexM),nomDefaut[indexM]);
         graphe.monde[indexM].nom := grid.Cells[j,0];
         grid.Cells[j,1] := Rini.readString(stArduino,stUnite+intToStr(indexM),uniteDefaut[j-1]);
         graphe.monde[indexM].unite := grid.Cells[j,1];
         grid.Cells[j,2] := Rini.readString(stArduino,stMini+intToStr(indexM),'');
         graphe.monde[indexM].miniStr := grid.Cells[j,2];
         grid.Cells[j,3] := Rini.readString(stArduino,stMaxi+intToStr(indexM),'');
         graphe.monde[indexM].maxiStr := grid.Cells[j,3];
     end;
     Rini.Free;
     indiceCourant := 0;
     nbreColonnes := -1;
     tempsActif := false;
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
     grid.DefaultRowHeight := hauteurColonne;
     UdpThread := TReadingThread.create(UDPClient);
     ResizeButtonImagesforHighDPI(self);
end; // formCreate

procedure TArduinoWifiForm.FormDestroy(Sender: TObject);
begin
     Graphe.free;
     if Assigned(udpThread) then begin
        UdpThread.Terminate;
        UdpThread.WaitFor;
        FreeAndNil(UdpThread);
     end;
end;

procedure TArduinoWifiForm.gridGetEditText(Sender: TObject; ACol, ARow: Integer;
  var Value: string);
begin
    if Acol=0 then exit;
    case Arow of
        0 : graphe.monde[Acol-1].nom := value;
        1 : graphe.monde[Acol-1].unite := value;
        2 : graphe.monde[Acol-1].miniStr := value;
        3 : graphe.monde[Acol-1].maxiStr := value;
    end;
end;

procedure TArduinoWifiForm.PaintBoxPaint(Sender: TObject);
var i : integer;
begin
      for i := 1 to pred(grid.ColCount) do with graphe.monde[i-1] do begin
          nom := grid.Cells[i,0];
          unite := grid.Cells[i,1];
          miniStr := grid.Cells[i,2];
          maxiStr := grid.Cells[i,3];
      end;
      graphe.modePoint := pointParPoint;
      graphe.mondeMax := nbreColonnes;
      if not pointParPoint then begin
         graphe.Monde[mondex].miniStr := '0';
         graphe.Monde[mondex].maxiStr := dureeMax.toString;
      end;
      graphe.drawG;
end;

procedure TArduinoWifiForm.RegressiBtnClick(Sender: TObject);
var i,k : integer;
    Ligne : String;
    t : double;
begin
     FormDDE.donnees.Clear;
     FormDDE.donnees.add(Application.exeName);
     FormDDE.donnees.add('');
     ligne := '';
     for k := 0 to graphe.mondeMax do begin  // noms
         if grid.Cells[k+1,0]='' then grid.Cells[k+1,0] := 'x'+intToStr(k);
         Ligne := ligne+grid.Cells[k+1,0]+crTab;
     end;
     FormDDE.donnees.add(Ligne);
     ligne := '';
     for k := 0 to graphe.mondeMax do // unités
         Ligne := ligne+grid.Cells[k+1,1]+crTab;
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

procedure TArduinoWifiForm.UdpTriggerData(chaineLue : string);

procedure TriggerDataPoint;
var i : integer;
begin
      nbreColonnes := liste.Count; // index en plus
      if nbreColonnes>mondeYMax then nbreColonnes := mondeYMax;
      for i := 1 to nbreColonnes do
          graphe.monde[i].valeurC := strToFloatWin(liste[i-1]);
      graphe.monde[mondeX].valeurC := indiceCourant;
      regressiBtn.Enabled := indiceCourant>5;
      labelVoie[0].Caption := 'index='+intToStr(round(graphe.monde[0].valeurC));
      for i := 1 to NbreColonnes do
          labelVoie[i].Caption := graphe.monde[i].nom+'='+liste[i-1]+' '+graphe.monde[i].unite;
      for i := succ(NbreColonnes) to mondeYmax do
          labelVoie[i].Caption := '';
end;

procedure TriggerDataTemps;
var i : integer;
    m : TindiceAxes;
begin
      if not tempsActif then exit;
      if premiereLigne then begin
         premiereLigne := false;
         tZero := getTime;
         exit;
      end;
      nbreColonnes := liste.Count; // temps en plus
      if nbreColonnes>mondeYMax then nbreColonnes := mondeYMax;
      graphe.monde[mondeX].valeurC := milliSecondsBetween(getTime,tZero)/1000.0;
      for i := 1 to nbreColonnes do
          graphe.monde[i].valeurC := strToFloatWin(liste[i-1]);
      try
      for i := 0 to nbreColonnes do with graphe.monde[i] do begin
          if premierAppel or (modeTemps=mRoll)
             then valeur[indiceCourant] := valeurC
             else valeurNew[indiceCourant] := valeurC;
      end;
      case modeTemps of
          mDeclenche : begin
                inc(indiceCourant);
                graphe.nbrePoints := indiceCourant;
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
            mDeclenche : stopBtnClick(nil);
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
            end;
            mRoll : begin
              premierAppel := false;
              graphe.indexRoll := 0;
              graphe.deltatRoll := (graphe.monde[mondeX].valeur[indiceCourant-1]-
                                    graphe.monde[mondeX].valeur[0])/(indiceCourant-1);
              indiceCourant := 0;
            end;
         end;
      end;
      regressiBtn.Enabled := (indiceCourant>5) or (graphe.NbrePoints>5);
end;

begin
      liste.commaText := string(chaineLue);
      chaineLue := '';
      if liste.Count<1 then exit;
      if pointParPoint
         then triggerDataPoint
         else TriggerDataTemps;
end;

procedure TArduinoWifiForm.UdpConnectBtnClick(Sender: TObject);
begin
  UDPClient.Binding.Port := UDPClient.Port;
  UdpClient.Active := true;
  if not UdpClient.Connected then UdpClient.Connect;
  UdpConnectBtn.ImageIndex := 8;
  if pointParPoint
     then timerAcq.Interval := 100
     else timerAcq.Interval := Tech;
  timerAcq.Enabled := pointParPoint;
end;

Procedure TArduinoWifiForm.Sauvegarde;
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

constructor TReadingThread.Create(AClient: TIdUDPClient);
begin
  inherited Create(False);
  FClient := AClient;
  FreeOnTerminate:=false;
end;

procedure TReadingThread.Execute;
var FData: string;
begin
   while not Terminated do begin
       FData := FClient.ReceiveString();
       if FData<>'' then
          Synchronize(procedure
            begin
                ArduinoWifiForm.UdpTriggerData(Fdata)
            end);
   end;
end;

procedure TArduinoWifiForm.envoieCommand(const aCommande : string);
begin
     if aCommande<>'' then UDPClient.Send(aCommande)
end;

end.

