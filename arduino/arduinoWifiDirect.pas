unit arduinoWifiDirect;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.ImageList, system.dateUtils,
  Vcl.Graphics, Vcl.Grids, Vcl.ComCtrls, Vcl.ToolWin,  Vcl.ImgList,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.OleCtrls,
  Vcl.htmlHelpViewer,
  inifiles, constreg, aidekey,
  arduinoGraphe, arduinoWifiDirectCfg, compile, regutil,
  nduWlanAPI, nduWlanTypes, SHDocVw,
  Vcl.BaseImageCollection, Vcl.ImageCollection, Vcl.VirtualImageList;

type
  TModeTemporel = (mDeclenche,mRelaxe,mRoll);
  TArduinoWifiDirectForm = class(TForm)
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
    ConnectBtn: TToolButton;
    WebBrowser1: TWebBrowser;
    HelpBtn: TToolButton;
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
    procedure Button2Click(Sender: TObject);
    procedure RazBtnClick(Sender: TObject);
    procedure TimerAcqTimer(Sender: TObject);
    procedure ConnectBtnClick(Sender: TObject);
    procedure WebBrowser1DocumentComplete(ASender: TObject;
      const pDisp: IDispatch; const URL: OleVariant);
    procedure HelpBtnClick(Sender: TObject);
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
    Tech : integer; // milliseconde
    host : string;
    data : TStringList;
    arduinoGuid : PGUID;
    arduinoConnected : boolean;
    arduinoClient : Thandle;
    modeTemps : TmodeTemporel;
    pointparpoint : boolean;
    SendBtn : array[1..3] of TButton;
    procedure TriggerData(chaineLue : string);
    procedure envoieCommand(const aCommande : string);
    function Scan : boolean;
    function connectTo(aNetWork : Tndu_WLAN_AVAILABLE_NETWORK) : boolean;
  public
  end;

var
  ArduinoWifiDirectForm: TArduinoWifiDirectForm;

implementation

{$R *.dfm}

uses regmain, regdde;

procedure TArduinoWifiDirectForm.StopBtnClick(Sender: TObject);
begin
   tempsActif := false;
   razBtn.Enabled := true;
   stopBtn.enabled := false;
   startBtn.Enabled := true;
   PanelVoies.Visible := pointParPoint;
   graphe.nbrePointsNew := 0;
   timerGrapheTimer(nil);
end;

procedure TArduinoWifiDirectForm.StartBtnClick(Sender: TObject);
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
        graphe.monde[mondeX].maxi := dureeMax;
        tempsActif := true;
        PanelVoies.Visible := false;
        timerAcq.Interval := Tech;
        timerAcq.Enabled := true;
    end;
end;

procedure TArduinoWifiDirectForm.TimerAcqTimer(Sender: TObject);
begin
      webBrowser1.navigate(host+'/'+getCommand);
end;

procedure TArduinoWifiDirectForm.TimerGrapheTimer(Sender: TObject);
begin
      graphe.modePoint := pointParPoint;
      paintBox.Invalidate;
end;

procedure TArduinoWifiDirectForm.RazBtnClick(Sender: TObject);
begin
    graphe.nbrePoints := 0;
    graphe.nbrePointsNew := 0;
    paintBox.Invalidate;
end;

procedure TArduinoWifiDirectForm.ToolsBtnClick(Sender: TObject);
var j : integer;
begin
     if ArduinoWifiDirectDlg=nil then Application.CreateForm(TArduinoWifiDirectDlg,ArduinoWifiDirectDlg);
     ArduinoWifiDirectDlg.dureeMaxSE.Value := dureeMax;
     ArduinoWifiDirectDlg.getEdit.Text := getCommand;
     for j := 1 to 3 do begin
          ArduinoWifiDirectDlg.sendGrid.Cells[j,1] := sendCommand[j];
          ArduinoWifiDirectDlg.sendGrid.Cells[j,2] := captionCommand[j];
     end;
     ArduinoWifiDirectDlg.modeTempsRG.ItemIndex := ord(modeTemps);
     ArduinoWifiDirectDlg.TechSE.value := Tech;
     ArduinoWifiDirectDlg.HostEdit.Text := host;
     if pointParPoint
        then ArduinoWifiDirectDlg.modeRG.ItemIndex := 0
        else ArduinoWifiDirectDlg.modeRG.ItemIndex := 1;
     for j := 1 to mondeYmax do begin
         ArduinoWifiDirectDlg.grid.Cells[0,j] := graphe.monde[j].nom;
         ArduinoWifiDirectDlg.grid.Cells[1,j] := graphe.monde[j].unite;
         ArduinoWifiDirectDlg.grid.Cells[2,j] := graphe.monde[j].mini.toString;
         ArduinoWifiDirectDlg.grid.Cells[3,j] := graphe.monde[j].maxi.toString;
     end;
     if ArduinoWifiDirectDlg.ShowModal=mrOK then begin
         host := ArduinoWifiDirectDlg.HostEdit.Text;
         dureeMax := ArduinoWifiDirectDlg.dureeMaxSE.Value;
         getCommand := ArduinoWifiDirectDlg.getEdit.Text;
         Tech := ArduinoWifiDirectDlg.TechSE.value;
         for j := 1 to 3 do begin
            sendCommand[j] := ArduinoWifiDirectDlg.sendGrid.Cells[j,1];
            captionCommand[j] := ArduinoWifiDirectDlg.sendGrid.Cells[j,2];
            sendBtn[j].caption :=  captionCommand[j];
            sendBtn[j].visible := sendCommand[j]<>'';
            if (sendBtn[j].caption='') then sendBtn[j].caption := sendCommand[j];
         end;
         for j := 1 to mondeYmax do with graphe.monde[j] do begin
             nom := ArduinoWifiDirectDlg.grid.Cells[0,j];
             unite := ArduinoWifiDirectDlg.grid.Cells[1,j];
             mini := StrToFloatWin(ArduinoWifiDirectDlg.grid.Cells[2,j]);
             maxi := StrToFloatWin(ArduinoWifiDirectDlg.grid.Cells[3,j]);
         end;
         pointParPoint := ArduinoWifiDirectDlg.modeRG.ItemIndex=0;
         modeTemps := TModeTemporel(ArduinoWifiDirectDlg.modeTempsRG.ItemIndex);
     end;
     PanelVoies.Visible := pointParPoint;
end;

procedure TArduinoWifiDirectForm.Button2Click(Sender: TObject);
begin
    envoieCommand(sendCommand[(sender as TButton).tag])
end;

procedure TArduinoWifiDirectForm.FormActivate(Sender: TObject);
begin
    NbreColonnes := 0; // pas de données
    PanelVoies.Visible := pointParPoint;
end;

procedure TArduinoWifiDirectForm.FormClose(Sender: TObject; var Action: TCloseAction);
var Rini : TMemInifile;
begin
     Rini := TMemIniFile.create(NomFichierIni);
     Rini.WriteString(stArduino,'WifiDirectGet',getCommand);
     Rini.WriteString(stArduino,'WifiDirectHost',host);
     Rini.WriteInteger(stArduino,'DureeMax',dureeMax);
     Rini.WriteInteger(stArduino,'Mode',ord(modeTemps));
     Rini.WriteBool(stArduino,'PointParPoint',pointParPoint);
     Rini.updateFile;
     Rini.Free;
     graphe.ecritIni;
     tempsActif := false;
     if ArduinoConnected then begin
         WlanDisconnect(arduinoClient,arduinoGuid,nil);
         WlanCloseHandle(arduinoClient, nil)
     end;
end;  // formClose

procedure TArduinoWifiDirectForm.FormCreate(Sender: TObject);
var j : integer;
    Rini : TMemIniFile;
    gbvoie : TGroupBox;
begin
     data := TstringList.Create;
     host := '192.168.4.1';
     graphe := TgrapheArduino.create;
     graphe.paintbox := paintBox;
     for j := 0 to pred(sendGB.ControlCount) do
         if sendGB.Controls[j] is Tbutton then
            sendBtn[sendGB.Controls[j].Tag] := Tbutton(sendGB.Controls[j]);
     indexFichier := 0;
     Rini := TMemIniFile.create(NomFichierIni);
     host := Rini.ReadString(stArduino,'WifiDirectHost',host);
     getCommand := Rini.ReadString(stArduino,'WifiDirectGet','L');
     if getCommand='' then  getCommand := 'L';
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
     VirtualImageList1.height := VirtualImageListSize;
     VirtualImageList1.width := VirtualImageListSize;
end; // formCreate

procedure TArduinoWifiDirectForm.FormDestroy(Sender: TObject);
begin
     Graphe.free;
     data.Free;
end;

procedure TArduinoWifiDirectForm.FormShortCut(var Msg: TWMKey;
  var Handled: Boolean);
begin
    if msg.charCode=vk_space then StartBtnClick(nil);
end;

procedure TArduinoWifiDirectForm.FormShow(Sender: TObject);
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

procedure TArduinoWifiDirectForm.HelpBtnClick(Sender: TObject);
begin
   Aide(Help_Arduino);
end;

procedure TArduinoWifiDirectForm.PaintBoxPaint(Sender: TObject);
begin
      graphe.modePoint := pointParPoint;
      graphe.mondeMax := nbreColonnes;
      if not pointParPoint then begin
         graphe.Monde[mondex].mini := 0;
         graphe.Monde[mondex].maxi := dureeMax;
      end;
      graphe.drawG;
end;

procedure TArduinoWifiDirectForm.RegressiBtnClick(Sender: TObject);
var i,k : integer;
    Ligne : String;
    t : double;
begin
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

procedure TArduinoWifiDirectForm.TriggerData(chaineLue : string);

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

procedure TArduinoWifiDirectForm.ConnectBtnClick(Sender: TObject);
begin
  if Scan then begin
    ConnectBtn.ImageIndex := 8;
    if pointParPoint
       then timerAcq.Interval := 200
       else timerAcq.Interval := Tech;
    timerAcq.Enabled := pointParPoint;
  end;
end;

procedure TArduinoWifiDirectForm.WebBrowser1DocumentComplete(ASender: TObject;
  const pDisp: IDispatch; const URL: OleVariant);
begin
  Data.text := WebBrowser1.OleObject.Document.Body.InnerText;
  TriggerData(Data[0]);
end;

procedure TArduinoWifiDirectForm.envoieCommand(const aCommande : string);
begin
    if aCommande<>'' then  webBrowser1.navigate(host+'/'+aCommande);
end;

procedure TArduinoWifiDirectForm.ExitBtnClick(Sender: TObject);
begin
  close
end;

function  TArduinoWifiDirectForm.connectTo(aNetWork : Tndu_WLAN_AVAILABLE_NETWORK) : boolean;
var
    retour : Cardinal;
    connect : Tndu_WLAN_CONNECTION_PARAMETERS;
begin

zeroMemory(@connect, sizeof(Tndu_WLAN_CONNECTION_PARAMETERS));

with aNetWork do begin
  connect.wlanConnectionMode := wlan_connection_mode_discovery_unsecure;
  connect.strProfile := strProfileName;
  connect.dwFlags := 0;
  connect.pDot11Ssid := @dot11Ssid;
  connect.pDesiredBssidList := Nil;
  connect.dot11BssType := dot11BssType;
end;

result := false;
retour := WlanConnect(arduinoClient, arduinoGuid, @connect, Nil);
case retour of
     error_invalid_parameter : ;
     error_invalid_handle : ;
     error_access_denied : ;
     ERROR_SUCCESS : result := true;
     else ;
end;
end;

function TArduinoWifiDirectForm.Scan : boolean;
var
  dwVersion,ResultInt : Cardinal;
  pInterface          : Pndu_WLAN_INTERFACE_INFO_LIST;
  i,j,k               : Integer;
  pAvailableNetworkList: Pndu_WLAN_AVAILABLE_NETWORK_LIST;
  SDummy      : AnsiString;
begin
  result := false;
  ResultInt := WlanOpenHandle(1, nil, @dwVersion, @arduinoClient);
  if  ResultInt<> ERROR_SUCCESS then begin
     showMessage('Error Open CLient'+IntToStr(ResultInt));
     exit;
  end;

  ResultInt := WlanEnumInterfaces(arduinoClient, nil, @pInterface);
  if  ResultInt<> ERROR_SUCCESS then begin
     showMessage('Error Enum Interfaces '+IntToStr(ResultInt));
     exit;
  end;

  for i := 0 to pInterface^.dwNumberOfItems - 1 do begin
     arduinoGuid:= @pInterface^.InterfaceInfo[pInterface^.dwIndex].InterfaceGuid;
     ResultInt := WlanGetAvailableNetworkList(arduinoClient,arduinoGuid,
                WLAN_AVAILABLE_NETWORK_INCLUDE_ALL_ADHOC_PROFILES+
                WLAN_AVAILABLE_NETWORK_INCLUDE_ALL_MANUAL_HIDDEN_PROFILES,
                nil,pAvailableNetworkList);
     if  ResultInt<>ERROR_SUCCESS then exit;
     for j := 0 to pAvailableNetworkList^.dwNumberOfItems - 1 do
     with pAvailableNetworkList^.Network[j] do Begin
           SDummy := '';
           for k := 0 to dot11Ssid.uSSIDLength-1 do
               SDummy := SDummy+AnsiChar(dot11Ssid.ucSSID[k]);
           if Pos('ESP',string(SDummy))>0 then begin
              result := connectTo(pAvailableNetworkList^.Network[j]);
              arduinoConnected := result;
              if result then break;
           end;
     End; // for j
     if arduinoConnected then break;
  end;// for i
  if not arduinoConnected then WlanCloseHandle(arduinoClient, nil); // ??
end;

end.

