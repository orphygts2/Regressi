unit arduinoWifi;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.ImageList, system.dateUtils,
  Vcl.Graphics, Vcl.Grids, Vcl.ComCtrls, Vcl.ToolWin,  Vcl.ImgList,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.htmlHelpViewer,
  inifiles, constreg, aidekey,
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
    sendGB: TGroupBox;
    ToolBar: TToolBar;
    ToolsBtn: TToolButton;
    StartBtn: TToolButton;
    StopBtn: TToolButton;
    RegressiBtn: TToolButton;
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
    ExitBtn: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure ToolsBtnClick(Sender: TObject);
    procedure RegressiBtnClick(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
    procedure StartBtnClick(Sender: TObject);
    procedure PaintBoxPaint(Sender: TObject);
    procedure TimerGrapheTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure gridGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure Button2Click(Sender: TObject);
    procedure RazBtnClick(Sender: TObject);
    procedure TimerAcqTimer(Sender: TObject);
    procedure UdpConnectBtnClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure ExitBtnClick(Sender: TObject);
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
    sendBtn : array[1..3] of TButton;
    procedure UdpTriggerData(chaineLue : string);
    procedure envoieCommand(const aCommande : string);
  public
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
   PanelVoies.Visible := pointParPoint;
   graphe.nbrePointsNew := 0;
   timerGrapheTimer(nil);
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
        premierAppel := true;
        tZero := getTime;
        graphe.monde[mondeX].minMaxData := false;
        graphe.monde[mondeX].minMaxCourant := false;
        graphe.monde[mondeX].maxiStr := IntToStr(round(dureeMax));
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
begin
      graphe.modePoint := pointParPoint;
      paintBox.Invalidate;
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
          ArduinoWifiDlg.sendGrid.Cells[j,2] := captionCommand[j];
     end;
     ArduinoWifiDlg.modeTempsRG.ItemIndex := ord(modeTemps);
     ArduinoWifiDlg.TechSE.value := Tech;
     ArduinoWifiDlg.HostEdit.Text := UdpClient.host;
     ArduinoWifiDlg.PortEdit.Text := UdpClient.port.toString;
     if pointParPoint
        then ArduinoWifiDlg.modeRG.ItemIndex := 0
        else ArduinoWifiDlg.modeRG.ItemIndex := 1;
     for j := 1 to mondeYmax do begin
         ArduinoWifiDlg.grid.Cells[0,j] := graphe.monde[j].nom;
         ArduinoWifiDlg.grid.Cells[1,j] := graphe.monde[j].unite;
         ArduinoWifiDlg.grid.Cells[2,j] := graphe.monde[j].miniStr;
         ArduinoWifiDlg.grid.Cells[3,j] := graphe.monde[j].maxiStr;
     end;
     if ArduinoWifiDlg.ShowModal=mrOK then begin
         UdpClient.host := ArduinoWifiDlg.HostEdit.Text;
         UdpClient.port := StrToInt(ArduinoWifiDlg.PortEdit.Text);
         dureeMax := arduinoWifiDlg.dureeMaxSE.Value;
         getCommand := ArduinoWifiDlg.getEdit.Text;
         Tech := ArduinoWifiDlg.TechSE.value;
         for j := 1 to mondeYmax do with graphe.monde[j] do begin
             nom := ArduinoWifiDlg.grid.Cells[0,j];
             unite := ArduinoWifiDlg.grid.Cells[1,j];
             miniStr := ArduinoWifiDlg.grid.Cells[2,j];
             maxiStr := ArduinoWifiDlg.grid.Cells[3,j];
         end;
         for j := 1 to 3 do begin
            sendCommand[j] := ArduinoWifiDlg.sendGrid.Cells[j,1];
            captionCommand[j] := ArduinoWifiDlg.sendGrid.Cells[j,2];
            sendBtn[j].caption := captionCommand[j];
            sendBtn[j].visible := sendCommand[j]<>'';
            if (sendBtn[j].caption='') then sendBtn[j].caption := sendCommand[j];
         end;
         pointParPoint := ArduinoWifiDlg.modeRG.ItemIndex=0;
         modeTemps := TModeTemporel(ArduinoWifiDlg.modeTempsRG.ItemIndex);
     end;
     PanelVoies.Visible := pointParPoint;
end;

procedure TArduinoWifiForm.Button2Click(Sender: TObject);
begin
    envoieCommand(sendCommand[(sender as TButton).tag])
end;

procedure TArduinoWifiForm.FormActivate(Sender: TObject);
begin
    NbreColonnes := 0; // pas de données
    PanelVoies.Visible := pointParPoint;
end;

procedure TArduinoWifiForm.FormClose(Sender: TObject; var Action: TCloseAction);
var Rini : TMemInifile;
begin
     Rini := TMemIniFile.create(NomFichierIni);
     Rini.WriteString(stArduino,'Get',getCommand);
     Rini.WriteString(stArduino,'UdpHost',UdpClient.host);
     Rini.WriteInteger(stArduino,'UdpPort',UdpClient.port);
     Rini.WriteInteger(stArduino,'DureeMax',dureeMax);
     Rini.WriteInteger(stArduino,'Mode',ord(modeTemps));
     Rini.WriteBool(stArduino,'PointParPoint',pointParPoint);
     Rini.updateFile;
     Rini.Free;
     graphe.ecritIni;
     tempsActif := false;
     if UdpClient.Connected then UdpClient.Disconnect;
     UdpClient.Active := false;
end;  // formClose

procedure TArduinoWifiForm.FormCreate(Sender: TObject);
var j : integer;
    Rini : TMemIniFile;
    gbvoie : TGroupBox;
begin
     graphe := TgrapheArduino.create;
     graphe.paintbox := paintBox;
     for j := 0 to pred(sendGB.ControlCount) do
         if sendGB.Controls[j] is Tbutton then
            sendBtn[sendGB.Controls[j].Tag] := Tbutton(sendGB.Controls[j]);
     indexFichier := 0;
     Rini := TMemIniFile.create(NomFichierIni);
     UdpClient.host := Rini.ReadString(stArduino,'UdpHost',UdpClient.host);
     UdpClient.port := Rini.ReadInteger(stArduino,'UdpPort',UdpClient.port);
     getCommand := Rini.ReadString(stArduino,'Get','Get');
     if getCommand='' then getCommand := 'Get';

     dureeMax := Rini.ReadInteger(stArduino,'DureeMax',15);
     modeTemps := TmodeTemporel(Rini.ReadInteger(stArduino,'Mode',0));
     pointParPoint := Rini.ReadBool(stArduino,'PointParPoint',true);
     liste := TstringList.Create;
     Rini.Free;
     graphe.litIni;
     indiceCourant := 0;
     nbreColonnes := -1;
     tempsActif := false;
     for j := 1 to 3 do
         sendBtn[j].caption := captionCommand[j];
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
     UdpThread := TReadingThread.create(UDPClient);
     VirtualImageList1.height := VirtualImageListSize;
     VirtualImageList1.width := VirtualImageListSize;
end; // formCreate

procedure TArduinoWifiForm.FormDestroy(Sender: TObject);
begin
     Graphe.free;
     (*
     if Assigned(udpThread) then begin
        UdpThread.Terminate;
        UdpThread.WaitFor;
        FreeAndNil(UdpThread);
     end;
     *)
end;

procedure TArduinoWifiForm.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
    if msg.charCode=vk_space then StartBtnClick(nil);
end;

procedure TArduinoWifiForm.FormShow(Sender: TObject);
var j : integer;
    vis : boolean;
begin
    vis := false;
    for j := 1 to 3 do begin
        sendBtn[j].visible := sendCommand[j]<>'';
        vis := vis or sendBtn[j].visible;
    end;
    sendGB.Visible := vis;
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
begin
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
     for k := 0 to graphe.mondeMax do with graphe.monde[k] do begin  // noms
         if nom='' then nom := 'x'+intToStr(k);
         Ligne := ligne+nom+crTab;
     end;
     FormDDE.donnees.add(Ligne);
     ligne := '';
     for k := 0 to graphe.mondeMax do // unités
         Ligne := ligne+graphe.monde[k].unite+crTab;
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

procedure TArduinoWifiForm.ExitBtnClick(Sender: TObject);
begin
    close
end;

end.

