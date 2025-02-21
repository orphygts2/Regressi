unit arduinoOscillo;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.ImageList,
  system.DateUtils,
  Vcl.Graphics, Vcl.Grids, Vcl.ComCtrls, Vcl.ToolWin,  Vcl.ImgList,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Samples.Spin,
  Vcl.htmlHelpViewer,
  OOmisc, adport, lnswin32, awuser, constreg,
  parser10, inifiles, math, aidekey,
  regutil, arduinoGraphe, arduinoOscilloCfg, compile, maths, uniteker,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient, Vcl.VirtualImageList,
  Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  tResolution = (r8bits,r10bits,r12bits,r14bits); // Due Zero 12 bits
  TArduinoOscilloForm = class(TForm)
    ToolBar: TToolBar;
    ToolsBtn: TToolButton;
    StartBtn: TToolButton;
    RegressiBtn: TToolButton;
    PaintBox: TPaintBox;
    ParamToolBar: TToolBar;
    intervalle: TLabel;
    SingleCB: TCheckBox;
    TriggerTB: TTrackBar;
    DureeLabel: TLabel;
    FechList: TComboBox;
    SynchroCB: TComboBox;
    StopBtn: TToolButton;
    UneVoieRB: TRadioButton;
    DeuxVoiesRB: TRadioButton;
    separeBtn: TToolButton;
    VoieSerie: TApdComPort;
    ProgressBar: TProgressBar;
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
    procedure FechSEClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SynchroLBClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure UneVoieRBClick(Sender: TObject);
    procedure VoieSerieTriggerAvail(CP: TObject; Count: Word);
    procedure VoieSerieTriggerData(CP: TObject; TriggerHandle: Word);
    procedure TriggerTBChange(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure ExitBtnClick(Sender: TObject);
  private
    chaineLue : ansiString;
    liste : TstringList;
    lectureEnCours : boolean;
    crTrigger : word;
    graphe : TgrapheArduino;
    Parser : Tparser;
    NbrePointsCourant : integer;
    ValeurReal : array[0..2] of TvecteurArduino; // sortie CAN
    FechOK,NvoiesOK,synchroOK,seuilOK : boolean;
    uniteTemps : TUnite;
    NbrePointsArduino : integer;
    NbreVoies : integer;
    resolution : Tresolution;
    attenteAck : boolean;  // attente accusé de réception Udp
    function valeurPeriode : integer;
    procedure relance;
    procedure Stop;
    procedure envoieSerie(const z: string);
    procedure openVoieSerie;
  public
  end;

var
  ArduinoOscilloForm: TArduinoOscilloForm;

implementation

{$R *.dfm}

uses regmain, regdde;

const
  MaxResol : array[Tresolution] of integer = (255,1023,4095,16383);
  // 8 bits pour aller vite ; 10 bits usuel ; 12 bits Due Zero ; 14 en prévision
  PauseRS232 = 25;  // 5*waitSerial = 5 ms dans script Arduino
  Term = crLF; // Terminateur

procedure TArduinoOscilloForm.StopBtnClick(Sender: TObject);
begin
   startBtn.Enabled := true;
   stopBtn.Enabled := false;
   stop;
end;

procedure TArduinoOscilloForm.SynchroLBClick(Sender: TObject);
begin
    synchroOK := false;
    if lectureEnCours
       then relance
       else triggerTB.Visible := synchroCB.ItemIndex>0;
end;

procedure TArduinoOscilloForm.StartBtnClick(Sender: TObject);
var m : TindiceAxes;
begin
    nbrePointsCourant := 0;
    lectureEnCours := false;
    startBtn.Enabled := false;
    stopBtn.Enabled := false;
    for m := mondeY to mondeYmax do
        graphe.monde[m].maxi := MaxResol[resolution];
    TriggerTB.Max := MaxResol[resolution];
    if (crTrigger=0) then crTrigger := voieSerie.AddDataTrigger(crCR,true);
    if not FechOK then begin
       envoieSerie('T'+intToStr(ValeurPeriode));
       FechOK := true;
    end;
    if not NvoiesOK then begin
       if deuxVoiesRB.checked
          then begin
             envoieSerie('C2');
             NbreVoies := 2;
          end
          else begin
             envoieSerie('C1');
             NbreVoies := 1;
          end;
       NVoiesOK := true;
    end;
    if not synchroOK then begin
       envoieSerie('H'+intToStr(SynchroCB.itemIndex));
       synchroOK := true;
    end;
    if not seuilOK and (synchroCB.ItemIndex<>0) then begin
       envoieSerie('G'+intToStr(round(TriggerTB.max)-round(TriggerTB.position)));
       seuilOK := true;
    end;
    triggerTB.Visible := synchroCB.ItemIndex>0;
    ProgressBar.max := NbrePointsArduino;
    ProgressBar.position := 0;
    lectureEnCours := true;
    envoieSerie('Start');
    stopBtn.Enabled := true;
end;

procedure TArduinoOscilloForm.ToolsBtnClick(Sender: TObject);
var duree : double;
    j : integer;
begin
     if crTrigger>0 then begin
        voieSerie.RemoveTrigger(crTrigger);
        crTrigger := 0;
     end;
     if voieSerie.Open then voieSerie.Open := False;
     if ArduinoOscilloDlg=nil then Application.CreateForm(TArduinoOscilloDlg,ArduinoOscilloDlg);
     ArduinoOscilloDlg.sincCB.checked := graphe.avecSinc;
     ArduinoOscilloDlg.ordreSincSE.value := graphe.ordreSinc;
     ArduinoOscilloDlg.ResolutionRG.itemIndex := ord(resolution);
     for j := 0 to pred(ArduinoOscilloDlg.NbreRG.items.count) do
         if nbrePointsArduino.toString=ArduinoOscilloDlg.nbreRG.items[j] then
            ArduinoOscilloDlg.nbreRG.ItemIndex := j;
     ArduinoOscilloDlg.Comports.items.clear;

     for j := 1 to MaxComHandles do
        if IsPortAvailable(j) then begin
           ArduinoOscilloDlg.Comports.Items.Add('COM'+IntToStr(j));
           NumeroCom[ArduinoOscilloDlg.Comports.items.count-1] := j;
           if j=voieSerie.comNumber then
              ArduinoOscilloDlg.Comports.ItemIndex := ArduinoOscilloDlg.Comports.items.count-1;
        end;
     if (ArduinoOscilloDlg.Comports.ItemIndex<0) then
        ArduinoOscilloDlg.Comports.itemIndex := 0;
     for j := 0 to indexVitesseMax do begin
         ArduinoOscilloDlg.baudRG.items[j] := intToStr(vitesseBaud[j]);
         if voieSerie.Baud=vitesseBaud[j] then ArduinoOscilloDlg.BaudRG.ItemIndex := j;
     end;
     for j := 1 to mondeYmax do begin
         ArduinoOscilloDlg.grid.Cells[0,j] := graphe.monde[j].nom;
         ArduinoOscilloDlg.grid.Cells[1,j] := graphe.monde[j].unite;
         ArduinoOscilloDlg.grid.Cells[2,j] := graphe.monde[j].conversion;
     end;
     if ArduinoOscilloDlg.ShowModal=mrOK then begin
        resolution := Tresolution(ArduinoOscilloDlg.ResolutionRG.itemIndex);
        graphe.avecSinc := ArduinoOscilloDlg.sincCB.checked;
        graphe.ordreSinc := ArduinoOscilloDlg.ordreSincSE.value;
        nbrePointsArduino := strToInt(ArduinoOscilloDlg.nbreRG.items[ArduinoOscilloDlg.nbreRG.ItemIndex]);
        duree := ValeurPeriode*NbrePointsArduino;
        dureeLabel.Caption := ' Durée '+uniteTemps.formatValeurEtUnite(duree/1e6);
        graphe.monde[mondeX].maxi := duree;
        voieSerie.baud := StrToInt(ArduinoOscilloDlg.baudRG.items[ArduinoOscilloDlg.BaudRG.ItemIndex]);
        voieSerie.comNumber := NumeroCom[ArduinoOscilloDlg.Comports.ItemIndex];
        for j := 1 to mondeYmax do with graphe.monde[j] do begin
             nom := ArduinoOscilloDlg.grid.Cells[0,j];
             unite := ArduinoOscilloDlg.grid.Cells[1,j];
             conversion := ArduinoOscilloDlg.grid.Cells[2,j];
        end;
     end;
     openVoieSerie;
end; // toolsBtnClick

procedure TArduinoOscilloForm.FechSEClick(Sender: TObject);
var duree : double;
begin
    duree := valeurPeriode*NbrePointsArduino;
    dureeLabel.Caption := ' Durée : '+uniteTemps.formatValeurEtUnite(duree/1e6);
    graphe.monde[mondeX].maxi := duree;
    FechOK := false;
    if lectureEnCours then relance;
end;

procedure TArduinoOscilloForm.FormActivate(Sender: TObject);
begin
    openVoieSerie;
end;

procedure TArduinoOscilloForm.FormClose(Sender: TObject; var Action: TCloseAction);
var Rini : TMemInifile;
begin
     Rini := TMemIniFile.create(NomFichierIni);
     Rini.WriteInteger(stArduino,'Com',voieSerie.comNumber);
     Rini.WriteInteger(stArduino,'Baud',voieSerie.baud);
     Rini.WriteInteger(stArduino,'NbreOscillo',NbrePointsArduino);
     Rini.WriteInteger(stArduino,'Seuil',triggerTB.position);
     Rini.WriteInteger(stArduino,'Synchro',synchroCB.itemIndex);
     Rini.WriteInteger(stArduino,'Resolution',ord(resolution));
     Rini.WriteBool(stArduino,'Monocoup',singleCB.checked);
     Rini.WriteBool(stArduino,'Sinc',graphe.avecSinc);
     if DeuxVoiesRB.Checked
         then Rini.WriteInteger(stArduino,'NbreVoies',2)
         else Rini.WriteInteger(stArduino,'NbreVoies',1);
     Rini.WriteInteger(stArduino,'OrdreSinc',graphe.ordreSinc);
     Rini.writeInteger(stArduino,'Fech',FechList.ItemIndex);
     Rini.updateFile;
     Rini.Free;
     graphe.ecritIni;
     if crTrigger>0 then begin
        voieSerie.RemoveTrigger(crTrigger);
        crTrigger := 0;
     end;
     VoieSerie.Open := false;
end;

procedure TArduinoOscilloForm.FormCreate(Sender: TObject);
var j : integer;
    Rini : TMemIniFile;
    duree : double;
begin
// VoieSerie
     {$IFDEF Debug}
     voieSerie.Tracing := tlOn;
     voieSerie.Logging := tlOn;
     {$ELSE}
     voieSerie.Tracing := tlOff;
     voieSerie.Logging := tlOff;
     {$ENDIF}

// Création
     uniteTemps := Tunite.Create;
     uniteTemps.nomUnite := 's';
     graphe := TgrapheArduino.create;
     for j := 0 to mondeYmax do begin
        graphe.monde[j].minMaxData := false;
        graphe.monde[j].minMaxCourant := false;
     end;
     liste := TstringList.Create;
     Parser := Tparser.create(nil);

// Inifile
     Rini := TMemIniFile.create(NomFichierIni);
     graphe.avecSinc := Rini.ReadBool(stArduino,'Sinc',false);
     graphe.ordreSinc := Rini.ReadInteger(stArduino,'OrdreSinc',2);
     VoieSerie.ComNumber := Rini.ReadInteger(stArduino,'Com',3);
     VoieSerie.Baud := Rini.ReadInteger(stArduino,'Baud',57600);
     NbrePointsArduino := Rini.ReadInteger(stArduino,'NbreOscillo',300);
     TriggerTB.position := Rini.ReadInteger(stArduino,'Seuil',512);
     synchroCB.itemIndex := Rini.ReadInteger(stArduino,'Synchro',0);
     DeuxVoiesRB.Checked := Rini.ReadInteger(stArduino,'NbreVoies',2)=2;
     if DeuxVoiesRB.Checked
        then NbreVoies := 2
        else begin
          NbreVoies := 1;
          UneVoieRB.Checked := true;
        end;
     triggerTB.Visible := synchroCB.ItemIndex>0;
     singleCB.checked := Rini.ReadBool(stArduino,'Monocoup',true);
     resolution := Tresolution(Rini.readInteger(stArduino,'Resolution',1)); // 10 bits par défaut
     if not IsPortAvailable(VoieSerie.ComNumber) then begin
        for j := 1 to MaxComHandles do
        if IsPortAvailable(j) then begin
            VoieSerie.ComNumber := j;
            break;
        end;
     end;
     if not IsPortAvailable(VoieSerie.ComNumber) then ; // showMessage('Pas de voie série => Wifi');
     FechList.ItemIndex := Rini.readInteger(stArduino,'Fech',5);
     for j := 1 to mondeYmax do with graphe.monde[j] do begin
         maxi := 1024;
         mini := 0;
     end;
     Rini.Free;
     graphe.litIni;
     lectureEnCours := false;
     crTrigger := 0;
     graphe.paintbox := paintBox;
     graphe.nbrePoints := 0;
     graphe.monde[mondeX].mini := 0;
     graphe.monde[mondeX].nom := 't';
     graphe.monde[mondeX].unite := 's';
     if deuxVoiesRB.checked
          then graphe.mondeMax := mondeY+1
          else graphe.mondeMax := mondeY;
     duree := valeurPeriode*NbrePointsArduino;
     dureeLabel.Caption := 'Durée : '+uniteTemps.formatValeurEtUnite(duree/1e6);
     graphe.monde[mondeX].maxi := duree;

     progressBar.Max := NbrePointsArduino;
     progressBar.position := 0;
     VirtualImageList1.height := VirtualImageListSize;
     VirtualImageList1.width := VirtualImageListSize;
end;

procedure TArduinoOscilloForm.FormDestroy(Sender: TObject);
begin
   parser.free;
   uniteTemps.Free;
end;

procedure TArduinoOscilloForm.FormShow(Sender: TObject);
begin
    openVoieSerie;
end;

procedure TArduinoOscilloForm.HelpBtnClick(Sender: TObject);
begin
   Aide(Help_Arduino);
end;

procedure TArduinoOscilloForm.PaintBoxPaint(Sender: TObject);
begin
      graphe.drawG;
end;

procedure TArduinoOscilloForm.RegressiBtnClick(Sender: TObject);
var i,imax : integer;
    Ligne : String;
    m : TindiceAxes;

    procedure AffecteValeur;
    var m : TindiceAxes;
        i : integer;
    begin
     imax := pred(graphe.nbrePoints);
     for m := mondeY to graphe.mondeMax do with graphe.monde[m] do
         if conversion<>'' then begin
            Parser.expression := conversion;
            for i := 0 to imax do begin // conversion
                try
                   Parser.V := valeur[i];
                   valeurReal[m,i] :=  Parser.Value;
                except
                   valeurReal[m,i] := valeur[i];
                end;
            end;
         end
         else for i := 0 to imax do
             valeurReal[m,i] := valeur[i];
     for i := 0 to imax do // data
          valeurReal[0,i] := graphe.monde[0].valeur[i]/1e6;
    end;

    procedure AffecteSinc;
    var m : TindiceAxes;
        i : integer;
    begin
     imax := pred(graphe.nbreSinc);
     for m := mondeY to graphe.mondeMax do with graphe.monde[m] do
         if conversion<>'' then begin
            Parser.expression := conversion;
            for i := 0 to imax do begin // conversion
                try
                   Parser.V := valeurSinc[i];
                   valeurReal[m,i] :=  Parser.Value;
                except
                   valeurReal[m,i] := valeurSinc[i];
                end;
            end;
         end
         else for i := 0 to imax do
             valeurReal[m,i] := valeurSinc[i];
     for i := 0 to imax do // data
         valeurReal[0,i] := graphe.monde[0].valeurSinc[i]/1e6;
    end;

begin
     startBtn.Enabled := true;
     stopBtn.Enabled := false;
     stop;
     FormDDE.donnees.Clear;
     FormDDE.donnees.add(Application.exeName);
     FormDDE.donnees.add('');
     ligne := '';
     for m := 0 to graphe.mondeMax do with graphe.monde[m] do begin
         if nom='' then nom := 'x'+intToStr(m);
         Ligne := ligne+nom+crTab;
     end;
     FormDDE.donnees.add(Ligne);  // noms
     ligne := '';
     for m := 0 to graphe.mondeMax do
         Ligne := ligne+graphe.monde[m].unite[m]+crTab;  // unités
     FormDDE.donnees.add(ligne);
     if graphe.avecSinc then AffecteSinc else AffecteValeur;
     for i := 0 to imax do begin // data
         ligne := '';
         for m := mondeX to graphe.mondeMax do
             Ligne := ligne+FloatToStrPoint(valeurReal[m,i])+crTab;
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
     modeAcquisition := acqOscilloArduino;
     graphe.nbrePoints := 0;
     Close;
end; // RegressiBtnClick

procedure TArduinoOscilloForm.TriggerTBChange(Sender: TObject);
begin
    seuilOK := false;
    if lectureEnCours then relance
end;

procedure TArduinoOscilloForm.UneVoieRBClick(Sender: TObject);
begin
     if deuxVoiesRB.checked
       then graphe.mondeMax := mondeY+1
       else graphe.mondeMax := mondeY;
     NVoiesOK := false;
     if lectureEnCours then relance;
end;

function TArduinoOscilloForm.valeurPeriode : integer;
var chaine,intStr : string;
    i : integer;
    coeff : integer;
    carac : char;
begin
   chaine := FechList.text;
   i := 1;
   intStr := '';
   coeff := 1;
   while i<=length(chaine) do begin
       carac := chaine[i];
       if charInSet(carac,['0'..'9'])
          then intStr := intStr+carac
          else if carac='k' then coeff := 1000;
       inc(i);
   end;
   result := strToInt(intStr)*coeff;
   result := round(1e6/result);
end;

procedure TArduinoOscilloForm.VoieSerieTriggerAvail(CP: TObject; Count: Word);
var
   i: word;
   carac: ansiChar;
begin // TriggerAvail
   for i := 1 to Count do begin
      if voieSerie.CharReady then begin
         carac := voieSerie.GetChar;
         if (carac >= ' ') then chaineLue := chaineLue + carac;
      end;
    end
end;

procedure TArduinoOscilloForm.VoieSerieTriggerData(CP: TObject;
  TriggerHandle: Word);
var i : integer;
    m : TindiceAxes;
begin
      if not lectureEnCours then begin
         chaineLue := '';
         exit;
      end;
      liste.commaText := string(chaineLue);
      chaineLue := '';
      if (NbrePointsCourant=0) and (liste.Count<(NbreVoies+1)) then begin
         graphe.monde[0].valeurNew[0] := 0;
         for i := 1 to NbreVoies do
             graphe.monde[i].valeurNew[0] := 512;
         for i := 0 to liste.Count-1 do begin
            try
            graphe.monde[i].valeurNew[0] := strToInt(liste[i]);
            except
            end;
         end;
         NbrePointsCourant := 1; // premier point incomplet
      end;
      if liste.Count<>(NbreVoies+1) then exit;
      if (NbrePointsCourant=0) and (liste[0]<>'0') then begin
          graphe.monde[0].valeurNew[0] := 0;
          for i := 1 to liste.Count-1 do begin
            try
            graphe.monde[i].valeurNew[0] := strToInt(liste[i]);
            except
            graphe.monde[i].valeurNew[0] := 512;
            end;
          end;
      // premier point perdu ?
          NbrePointsCourant := 1;
      end;
      for i := 0 to liste.Count-1 do begin
          try
          graphe.monde[i].valeurNew[nbrePointsCourant] := strToInt(liste[i]);
          except
          if i=0
             then graphe.monde[i].valeurNew[nbrePointsCourant] := NbrePointsCourant*valeurPeriode
             else graphe.monde[i].valeurNew[nbrePointsCourant] := 512;
          end;
      end;
      {$IFDEF Debug}
      if nbrePointsCourant=0 then ecritDebug('début '+liste.text);
      if nbrePointsCourant=1 then ecritDebug('premier '+liste.text);
      {$ENDIF}
      inc(nbrePointsCourant);
      if (ProgressBar.position+32) < nbrePointsCourant then begin
         ProgressBar.position := nbrePointsCourant;
         {$IFDEF Debug}
         ecritDebug(nbrePointsCourant.toString+' '+liste.text);
         {$ENDIF}
         ProgressBar.update;
      end;
      if (nbrePointsCourant>=NbrePointsArduino) then begin
            regressiBtn.Enabled := true;
            {$IFDEF Debug}
            ecritDebug('fin');
            {$ENDIF}
            ProgressBar.position := nbrePointsArduino;
            ProgressBar.update;
            graphe.nbrePoints := nbrePointsArduino;
            for m := mondeX to graphe.mondeMax do
                  graphe.monde[m].valeur := graphe.monde[m].valeurNew;
            paintBox.Invalidate;
            lectureEnCours := false;
            if singleCB.Checked
               then begin
                  startBtn.Enabled := True;
                  stopBtn.Enabled := false;
               end
               else StartBtnClick(nil); // Arduino s'arrête après chaque lecture => Start nécessaire
      end;
end;

procedure TArduinoOscilloForm.relance;
begin
       stop;
       startBtnClick(nil);
end;

procedure TArduinoOscilloForm.Stop;
var Timer : EventTimer;
begin
        cursor := crHourGlass;
        envoieSerie('Stop');
        if lectureEnCours then begin
           lectureEnCours := false;
           newTimer(timer,3); // 165 ms
           ParamToolBar.Enabled := false;
           ToolBar.Enabled := false;
           repeat
              application.ProcessMessages;
           until timerExpired(timer);
           ParamToolBar.Enabled := true;
           ToolBar.Enabled := true;
           VoieSerie.flushInBuffer;
        end
        else lectureEnCours := false;
        cursor := crDefault;
        voieSerie.FlushInBuffer;
        chaineLue := '';
end;

procedure TArduinoOscilloForm.envoieSerie(const z: string);
begin
    voieSerie.outPut := AnsiString(z)+term;
    {$IFDEF Debug}
    ecritDebug(z);
    {$ENDIF}
    attenteAck := true;
    sleep(PauseRS232);
end;

procedure TArduinoOscilloForm.ExitBtnClick(Sender: TObject);
begin
  close
end;

procedure TArduinoOscilloForm.openVoieSerie;
begin
  if not voieSerie.Open and
     IsPortAvailable(VoieSerie.ComNumber) then begin
           try
           voieSerie.Open := True;
           startBtn.Enabled := true;
           stopBtn.Enabled := false;
           if crTrigger=0 then crTrigger := voieSerie.AddDataTrigger(crCR,true);
            // désactivation de la voie série a réinitialisé Arduino
           FechOK := false;
           NVoiesOK := false;
           synchroOK := false;
           seuilOK := false;
           except
              ShowMessage('Problème voie série');
           end;
     end;
end;


end.
