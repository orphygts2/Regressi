unit arduinoU;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.ImageList, system.dateUtils,
  Vcl.Graphics, Vcl.Grids, Vcl.ComCtrls, Vcl.ToolWin,  Vcl.ImgList,
  Vcl.htmlHelpViewer,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  OOmisc, adport, lnswin32, awuser, constreg, aidekey,
  inifiles,
  regutil, arduinoGraphe, arduinoCfg, compile, Vcl.BaseImageCollection,
  Vcl.ImageCollection, Vcl.VirtualImageList;

type
  TModeTemporel = (mDeclenche,mRelaxe,mRoll);
  TTrigger = (tMontant,tDescendant,tClavier);
  tTerminateur = (tNone,tCR,tLF,tCRLF);
  TArduinoForm = class(TForm)
    sendGB: TGroupBox;
    ToolBar: TToolBar;
    ToolsBtn: TToolButton;
    StartBtn: TToolButton;
    StopBtn: TToolButton;
    RegressiBtn: TToolButton;
    PaintBox: TPaintBox;
    Splitter: TSplitter;
    TimerGraphe: TTimer;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    RazBtn: TToolButton;
    TriggerTB: TTrackBar;
    TimerCarac: TTimer;
    ErreurCaracLabel: TLabel;
    VoieSerie: TApdComPort;
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
    procedure TriggerTBChange(Sender: TObject);
    procedure TimerCaracTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure VoieSerieTriggerAvail(CP: TObject; Count: Word);
    procedure VoieSerieTriggerData(CP: TObject; TriggerHandle: Word);
    procedure FormHide(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure ExitBtnClick(Sender: TObject);
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
    attenteTrigger : boolean;
    seuilTrigger : double;
    voieTrigger : TindiceAxes;
    precedent : double;
    terminateur : Tterminateur;
    tempsArduino : boolean;
    SendBtn : array[1..3] of TButton;
    procedure openVoieSerie;
    procedure envoieCommand(const aCommande : string);
  public
    modeTemps : TmodeTemporel;
    trigger : TTrigger;
    monocoup : boolean;
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
   timerGraphe.enabled := false;
   graphe.nbrePointsNew := 0;
   timerGrapheTimer(nil);
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
    indiceCourant := 0;
    graphe.NbrePoints := 0;
    graphe.NbrePointsNew := 0;
    premiereLigne := true;
    stopBtn.enabled := true;
    stopBtn.visible := true;
    startBtn.Enabled := False;
    premierAppel := true;
    tZero := getTime;
    graphe.monde[mondeX].minMaxData := false;
    graphe.monde[mondeX].minMaxCourant := false;
    graphe.monde[mondeX].maxi := dureeMax;
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

procedure TArduinoForm.TimerCaracTimer(Sender: TObject);
begin
    timerCarac.Enabled := false;
    ErreurCaracLabel.visible := false;
end;

procedure TArduinoForm.TimerGrapheTimer(Sender: TObject);
var i : integer;
begin
      graphe.modePoint := false;
      for i := mondeY to mondeYmax do
          graphe.monde[i].minMaxCourant := true;
      graphe.monde[mondeX].minMaxCourant := tempsActif;
      paintBox.Invalidate;
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
          ArduinoDlg.sendGrid.Cells[j,2] := captionCommand[j];
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
     ArduinoDlg.triggerRG.ItemIndex := ord(trigger);
     ArduinoDlg.modeTempsRG.ItemIndex := ord(modeTemps);
     if ArduinoDlg.ShowModal=mrOK then begin
         dureeMax := arduinoDlg.dureeMaxSE.Value;
         startCommand := ArduinoDlg.startEdit.Text;
         stopCommand := ArduinoDlg.stopEdit.Text;
         terminateur := Tterminateur(ArduinoDlg.TerminateurRG.ItemIndex);
         for j := 1 to 3 do begin
            sendCommand[j] := ArduinoDlg.sendGrid.Cells[j,1];
            captionCommand[j] := ArduinoDlg.sendGrid.Cells[j,2];
            sendBtn[j].caption := captionCommand[j];
            sendBtn[j].visible := sendCommand[j]<>'';
            if (sendBtn[j].caption='') then sendBtn[j].caption := sendCommand[j];
         end;
         trigger := TTrigger(ArduinoDlg.triggerRG.ItemIndex);
         modeTemps := TModeTemporel(ArduinoDlg.modeTempsRG.ItemIndex);
         voieSerie.comNumber := NumeroCom[ArduinoDlg.Comports.ItemIndex];
         voieSerie.baud := strToInt(ArduinoDlg.baudRG.items[ArduinoDlg.BaudRG.ItemIndex]);
         monocoup := ArduinoDlg.monocoupCB.checked;
         tempsArduino := ArduinoDlg.tempsArduinoCB.checked;
         triggerTB.Visible := (modeTemps=mDeclenche) and (trigger<>tClavier);
     end;
     openVoieSerie;
     timerGraphe.Enabled := false;
end;

procedure TArduinoForm.Button2Click(Sender: TObject);
begin
    envoieCommand(sendCommand[(sender as TButton).tag])
end;

procedure TArduinoForm.FormActivate(Sender: TObject);
begin
    openVoieSerie;
    NbreColonnes := -1; // pas de données
    timerGraphe.Enabled := false;
end;

procedure TArduinoForm.FormClose(Sender: TObject; var Action: TCloseAction);
var Rini : TMemInifile;
begin
     Rini := TMemIniFile.create(NomFichierIni);
     Rini.WriteInteger(stArduino,'Com',voieSerie.comNumber);
     Rini.WriteString(stArduino,'Start',startCommand);
     Rini.WriteString(stArduino,stStop,stopCommand);
     Rini.WriteInteger(stArduino,'DureeMax',dureeMax);
     Rini.WriteInteger(stArduino,'Baud',voieSerie.baud);
     Rini.WriteInteger(stArduino,'Terminateur',ord(terminateur));
     Rini.WriteBool(stArduino,'TempsArduino',TempsArduino);
     Rini.WriteInteger(stArduino,'Mode',ord(modeTemps));
     Rini.WriteInteger(stArduino,'Trigger',ord(trigger));
     Rini.WriteBool(stArduino,'Monocoup',monocoup);
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
     timerGraphe.Enabled := false;
end;  // formClose

procedure TArduinoForm.FormCreate(Sender: TObject);
var j : integer;
    Rini : TMemIniFile;
    baudOK : boolean;
begin
     voieTrigger := mondeY;
     graphe := TgrapheArduino.create;
     graphe.paintbox := paintBox;
     for j := 0 to pred(sendGB.ControlCount) do
         if sendGB.Controls[j] is Tbutton then
            sendBtn[sendGB.Controls[j].Tag] := Tbutton(sendGB.Controls[j]);
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
     startCommand := Rini.ReadString(stArduino,'Start','');
     stopCommand := Rini.ReadString(stArduino,stStop,'');
     dureeMax := Rini.ReadInteger(stArduino,'DureeMax',15);
     modeTemps := TmodeTemporel(Rini.ReadInteger(stArduino,'Mode',0));
     TempsArduino := Rini.ReadBool(stArduino,'TempsArduino',false);
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
     {$ELSE}
     voieSerie.Tracing := tlOff;
     voieSerie.Logging := tlOff;
     {$ENDIF}
     liste := TstringList.Create;
     Rini.Free;
     indiceCourant := 0;
     nbreColonnes := -1;
     tempsActif := false;
     crTrigger := 0;
     graphe.litIni;
     triggerTB.Visible := (modeTemps=mDeclenche) and (trigger<>tClavier);
     VirtualImageList1.height := VirtualImageListSize;
     VirtualImageList1.width := VirtualImageListSize;
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
var j : integer;
    vis : boolean;
begin
    openVoieSerie;
    vis := false;
    for j := 1 to 3 do begin
        sendBtn[j].visible := sendCommand[j]<>'';
        vis := vis or sendBtn[j].visible;
    end;
    sendGB.Visible := vis;
end;

procedure TArduinoForm.PaintBoxPaint(Sender: TObject);
begin
      graphe.mondeMax := nbreColonnes;
      graphe.Monde[mondex].mini := 0;
      graphe.Monde[mondex].maxi := dureeMax;
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
     for k := 0 to graphe.mondeMax do
         Ligne := ligne+graphe.monde[k].nom+crTab;
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
          if not(TimerCarac.enabled)  and not(charInSet(carac,caracArduino)) then begin
               TimerCarac.enabled := true;
               ErreurCaracLabel.visible := true;
          end;
       end;
    end
end;// TriggerAvail

procedure TArduinoForm.VoieSerieTriggerData(CP: TObject; TriggerHandle: Word);

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

var i : integer;
    m : TindiceAxes;
    seuilAtteint : boolean;
begin
      liste.commaText := string(chaineLue);
      chaineLue := '';
      if liste.Count<1 then exit;
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
end; // triggerData

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

Procedure TArduinoForm.OpenVoieSerie;
begin
     if not voieSerie.Open and isPortAvailable(voieSerie.ComNumber) then begin
         try
         {$IFDEF Debug}
           VoieSerie.Tracing := tlOn;
           VoieSerie.Logging := tlOn;
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

procedure TArduinoForm.ExitBtnClick(Sender: TObject);
begin
  close
end;

end.

