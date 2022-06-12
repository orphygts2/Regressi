unit WavMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls, StdCtrls, graphKer, ComCtrls, MPlayer, inifiles, math,
  registry, mmsystem, clipbrd, ToolWin, ImgList, Spin,
  vcl.HtmlHelpViewer,
  System.ImageList, system.IOUtils,
  fft, compile, filerrr, grapheU, maths, regutil, constreg,
  Vcl.BaseImageCollection, Vcl.ImageCollection, Vcl.VirtualImageList;

type
  TWaveForm = class(TForm)
    BoutonsPanel: TPanel;
    PaintBox: TPaintBox;
    BoucleCB: TCheckBox;
    DureeTot: TLabel;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    FreqLabel: TLabel;
    Timer1: TTimer;
    PositionLabel: TLabel;
    MediaPlayer: TMediaPlayer;
    ToolBar: TToolBar;
    OpenFileBtn: TToolButton;
    SaveFileBtn: TToolButton;
    RegressiBtn: TToolButton;
    RecordBtn: TToolButton;
    StopBtn: TToolButton;
    ModeBtn: TToolButton;
    PlayBtn: TToolButton;
    ExitBtn: TToolButton;
    EnveloppeCB: TCheckBox;
    ZoomUD: TUpDown;
    DureeLabel: TLabel;
    FreqRegLabel: TLabel;
    PaintBoxZoom: TPaintBox;
    Splitter: TSplitter;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    procedure OpenFileBtnClick(Sender: TObject);
    procedure RegressiBtnClick(Sender: TObject);
    procedure ExitBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PaintBoxPaint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PaintBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBoxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDeactivate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SaveFileBtnClick(Sender: TObject);
    procedure RecordBtnClick(Sender: TObject);
    procedure ModeBtnClick(Sender: TObject);
    procedure MediaPlayerNotify(Sender: TObject);
    procedure PlayBtnClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
    procedure WaveSBChange(Sender: TObject);
    procedure PaintBoxZoomPaint(Sender: TObject);
    procedure ZoomUDChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Integer; Direction: TUpDownDirection);
    procedure EnveloppeCBClick(Sender: TObject);
  private
    graphe,grapheZoom : TgrapheSon;
    curseurT : TcurseurTemps;
    debutPB,finPB,positionPB : longInt;
    Xdeplace : integer;
    FDeviceID: Word;
    pasTrace : word;
    nomFichierWav : string;
    stopEnCours : boolean;
    startRecord : TdateTime;
    compteur, compteurMax :integer;
    vecteurSon : TvecteurSon;
    debut,fin : longInt;
    NomFichier : String;
    pasReg : word;
   // pour conversion mp3 wav
    cancelOp : boolean;
    percentdone : integer;
    bassOK,bass_aac_OK : boolean;
    // fin mp3
    Procedure TraceDebutFin;
    Procedure AffecteDebutFin;
    procedure StopLecture;
    Procedure TracePosition;
    procedure CloseMedia;
    procedure SaveMedia;
    procedure DecodeFileMP3(const SourceFileName : String;var DestFileName : String);
    Procedure ChercheFreqReg;
  public
     FreqEch : LongWord;
     NBits : byte;
     IndexMode : byte;
     stereo : boolean;
     procedure OuvreFichier(const Nom : String);
  protected
     procedure WMMajWav(var Msg: Tmessage); message WM_Maj_Wav;
  end;

var
  WaveForm: TWaveForm;

implementation

uses TestInWav, regdde, regmain, graphvar, dynamic_bass, dynamic_bassaac;

{$R *.DFM}

const
   ecartDebutFin = 50;
   precDebutFin = 5;

procedure TWaveForm.OpenFileBtnClick(Sender: TObject);
var filtre : string;
begin
  filtre := 'Fichiers WAV|*.wav';
  if bassOK then begin
     filtre := filtre + '|Fichier MP3|*.mp3';
  end;
  if bass_aac_OK then begin
     filtre := filtre + '|Fichier AAC|*.aac';
     filtre := filtre + '|Fichier MP4|*.mp4;*.m4a';
  end;
  if bassOK then if  bass_aac_OK
     then filtre := filtre + '|Tous|*.mp3;*.wav;*.aac;*.mp4;*.m4a'
     else filtre := filtre + '|Tous|*.mp3;*.wav';
  OpenDialog.filter := filtre;
  if OpenDialog.InitialDir='' then
      OpenDialog.InitialDir := WavDir;
  if OpenDialog.execute then begin
     ouvreFichier(openDialog.fileName);
     saveFileBtn.enabled := false;
     OpenDialog.InitialDir := extractFilePath(openDialog.fileName);
  end;
end;

procedure TWaveForm.OuvreFichier(const Nom : String);

Procedure ErreurMediaPlayer;
begin
        Caption := CaptionWav;
        NomFichier := '';
        MediaPlayer.Notify := false;
        try
        MediaPlayer.close;
        except
        end;
        MediaPlayer.FileName := '';
        PlayBtn.enabled := false;
end;

procedure CopierFichier(const NomSource,NomDest : string);
var src,dest : Pchar;
begin
        src := strAlloc(length(NomSource)+1);
        dest := strAlloc(length(NomDest)+1);
        strPCopy(src,nomSource);
        strPCopy(dest,nomDest);
        copyFile(src,dest,true);
        strDispose(src);
        strDispose(dest);
end;

var extension : string;
begin // ouvreFichier
     try
     RegressiBtn.enabled := false;
     PlayBtn.enabled := false;
     extension := UpperCase(extractFileExt(nom));
     if extension='.WAV'
        then nomFichier := nom
        else decodeFileMP3(nom,nomFichier);
     vecteurSon.lit(NomFichier);
     if vecteurSon.nbrePoints=0 then
        raise EWavError.create(erLecturewav);
     if vecteurSon.NbrePoints<=0 then raise EWavError.Create('');
     FreqEch := vecteurSon.freqAudio;
     Caption := CaptionWav+' ['+ExtractFileName(NomFichier)+']';
     if vecteurSon.fichierTronque then caption := caption + erTronque;
     debut := 0;
     fin := pred(vecteurSon.NbrePoints);
     pasTrace := puiss2Sup(vecteurSon.NbrePoints div PaintBox.width);
     DureeTot.caption := TrDuree+FloatToStrF(vecteurSon.NbrePoints/FreqEch,ffFixed,5,2)+' s';
     DureeLabel.Caption := dureeTot.Caption;
     stopLecture;
     if MediaPlayer.FileName<>'' then MediaPlayer.Close;
     if vecteurSon.nbrePoints<44100 then begin
        RegressiBtnClick(nil); // 1 seconde => on envoie tout
        exit;
     end;
     try
        if nomFichier<>nomFichierWav then // MediaPlayer plante avec 32 bits PCM d'Audacity
           vecteurSon.ecrit(nomFichierWav); // donc on force 16 bits
        MediaPlayer.FileName := NomFichierWav;
        MediaPlayer.open;
        if not (mediaPlayer.timeFormat in [tfSamples,tfMilliSeconds]) then
           mediaPlayer.timeFormat := tfSamples;
     except
        MediaPlayer.FileName := '';
     end;
     AffecteDebutFin;
     PaintBox.invalidate;
     PaintBoxZoom.invalidate;
     ChercheFreqReg;
     RegressiBtn.enabled := true;
     PlayBtn.enabled := MediaPlayer.FileName<>'';
     FreqLabel.caption := trFreqEch+intToStr(FreqEch)+' Hz';
     except
        on E:Exception do begin
           showMessage(E.Message);
           ErreurMediaPlayer;
        end;
     end;
end; // ouvreFichier

procedure TWaveForm.RegressiBtnClick(Sender: TObject);
var dt : double;
    ligne : String;
    tampon : TstringList;

procedure SauveSon;
var i : integer;
begin
     for i := debut to fin do if (i mod pasReg=0) then begin
         Ligne := FloatToStrF((i-debut)*dt,ffGeneral,7,1);
         Ligne := Ligne+crTab+
                  FloatToStrF(vecteurSon.valeur[i],ffGeneral,5,1);
         if vecteurSon.stereo then ligne := ligne+crTab+
                  FloatToStrF(vecteurSon.valeurBis[i],ffGeneral,5,1);
         tampon.add(Ligne);
     end;
end;

procedure direct;

procedure SauveSonDirect;
var i,j,imax : integer;
    deltat : double;
begin
     imax := (fin-debut) div pasReg;
     deltat := pasReg*dt;
     pages[pageCourante].nmes := imax+1;
     for i := 0 to imax do begin
         j := debut+i*pasReg;
         pages[pageCourante].valeurVar[0,i] := i*deltat;
         pages[pageCourante].valeurVar[1,i] := vecteurSon.valeur[j];
         if vecteurSon.stereo then
            pages[pageCourante].valeurVar[2,i] := vecteurSon.valeurBis[j];
     end;
end;

procedure setGraphe;
begin
 if vecteurSon.stereo
 then begin
     FgrapheVariab.graphes[1].Coordonnee[1].nomX := 't';
     FgrapheVariab.graphes[1].Coordonnee[2].nomX := 't';
     FgrapheVariab.graphes[1].Coordonnee[1].nomY := 'sG';
     FgrapheVariab.graphes[1].Coordonnee[2].nomY := 'sD';
     FgrapheVariab.graphes[1].Coordonnee[1].trace := [trLigne];
     FgrapheVariab.graphes[1].Coordonnee[2].trace := [trLigne];
 end
 else begin
     FgrapheVariab.graphes[1].Coordonnee[1].nomX := 't';
     FgrapheVariab.graphes[1].Coordonnee[1].nomY := 'sG';
     FgrapheVariab.graphes[1].Coordonnee[1].trace := [trLigne];
 end;
end;

procedure AjouteData;
begin
     if vecteurSon.stereo and (NbreVariabExp=2)
        then AjouteExperimentale('sD',variable);
     ajoutePage;
     sauveSonDirect;
     Pages[pageCourante].commentaireP := 'Acquisition à fech='+IntToStr(round(1/pasReg/dt))+' Hz';
     pages[pageCourante].recalculP;
     Application.MainForm.perform(WM_Reg_Maj,MajAjoutPage,0);
     FgrapheVariab.show;
     FgrapheVariab.setFocus;
end; // AjouteData

procedure GetData;
begin
     AjouteExperimentale('t',variable);
     grandeurs[0].nomUnite := 's';
     if vecteurSon.stereo
        then begin
           AjouteExperimentale('sG',variable);
           AjouteExperimentale('sD',variable);
        end
        else AjouteExperimentale('s',variable);
     FichierTrie := DataTrieGlb;
     AjoutePage;
     sauveSonDirect;
     pages[1].CommentaireP := 'Acquisition à fech='+IntToStr(round(1/pasReg/dt))+' Hz';
     pageCourante := 1;
     NomFichierData := '';
     ModeAcquisition := AcqSon;
     setGraphe;
     FregressiMain.FinOuvertureFichier(true);
     FregressiMain.sauveEtatCourant;
end; // GetData

begin
     if pageCourante=0
        then GetData
        else AjouteData;
     ModifFichier := true;
     screen.cursor := crDefault;
     close;
end;

begin
   if SaveFileBtn.Enabled and
      (application.MessageBox('Sauvegarde préliminaire des données dans un fichier Wav ?','Regavi',mb_yesno)=idYes)
      and saveDialog.Execute then saveFileBtnClick(sender);
   Screen.Cursor := crHourGlass;
   dt := 1/FreqEch;
   ChercheFreqReg;
   direct;
end; // RegressiBtnClick

procedure TWaveForm.EnveloppeCBClick(Sender: TObject);
begin
    graphe.enveloppe := enveloppeCB.checked;
    grapheZoom.enveloppe := enveloppeCB.checked;
    paintBox.Invalidate;
    paintBoxZoom.Invalidate;
end;

procedure TWaveForm.ExitBtnClick(Sender: TObject);
begin
    Close
end;

{
0..3 "RIFF"
4..7 taille en octets poids faible en premier
8..14 "WAVEfmt " (espace pour finir)
16 18 ou 16
17..21 0,0,0,1,0
22 1 ou 2 nombre de voies
23 0
24..27 fréquence poids faible en premier
28..31 fréquence double poids faible en premier seconde voie
32..33 2,0 ou 4,0
34 8 ou 16 Nombre de bits
35 0
36 à 37 0 0 0
36..39 "data"
40..43 nbre échantillon
?? 38..41 "fact"
?? 42..45 4 0 0 0
?? 46..49 "data"
?? 50..53 nbre échantillon
ensuite les données
}

procedure TWaveForm.FormCreate(Sender: TObject);
var ini : TInifile;
begin
    vecteurSon := TvecteurSon.create;
    graphe := TgrapheSon.create;
    graphe.canvas := PaintBox.canvas;
    graphe.vecteurSon := vecteurSon;
    grapheZoom := TgrapheSon.create;
    grapheZoom.canvas := PaintBoxZoom.canvas;
    grapheZoom.vecteurSon := vecteurSon;
    NomFichierWav := TPath.Combine(tempDirReg,'regavi.wav');
    NomFichier := '';
    Ini := TIniFile.create(nomFichierIni);
    FreqEch := ini.readInteger(stWav,'freq',11025);
    openDialog.filterIndex := ini.readInteger(stWav,'filterIndex',0);
    Nbits := ini.readInteger(stWav,'bits',16);
    indexMode := ini.readInteger(stWav,'Mode',0);
    Ini.Free;
    PlayBtn.Enabled := false;
    RegressiBtn.enabled := false;
    BoutonsPanel.Color := clMenuBar;
    BoutonsPanel.Font.Color := clWindowText;
    try
    BassOK := Load_BASSDLL('bass.dll');
    if BassOK then
       BassOK := BASS_Init(-1, 44100, Bass_unicode, Application.Handle, nil);
    except
       BassOK := false;
    end;
    try
    Bass_aac_OK := Load_BASSAACDLL('bass_aac.dll');
    except
       Bass_aac_OK := false;
    end;
    ResizeButtonImagesforHighDPI(self);
end;  // FormCreate

procedure TWaveForm.PaintBoxPaint(Sender: TObject);
begin
if NomFichier='' then exit;
with graphe do begin
        LimiteCourbe := PaintBox.ClientRect;
        inc(limiteCourbe.Left,2);
        dec(limiteCourbe.Right,2);
  // pour accéder plus facilement au réglage de debut/-fin à la souris
        debutS := 0;
        finS := pred(vecteurSon.NbrePoints);
        drawG;
        debutPB := Xecran(debut);
        finPB := Xecran(fin);
        TraceDebutFin;
end end;

procedure TWaveForm.PaintBoxZoomPaint(Sender: TObject);
begin with grapheZoom do begin
        if NomFichier='' then exit;
        LimiteCourbe := PaintBoxZoom.ClientRect;
        debutS := debut;
        finS := fin;
        pasS := succ((finS-debutS) div MaxMaxVecteur);
        canvas.Pen.Color := clBlack;
        canvas.Pen.width := 2;
        canvas.Pen.mode := pmCopy;
        canvas.Rectangle(limiteCourbe);
        drawG;
        curseurT := curNormal;
end end;

procedure TWaveForm.FormDestroy(Sender: TObject);
var ini : TIniFile;
begin
     if bassOK then begin
        Bass_Free;
        Unload_BASSDLL;
     end;
     if bass_aac_OK then begin
        //Unload_BASSAACDLL;
     end;
     graphe.free;
     grapheZoom.free;
     vecteurSon.destroy;
     try
     Ini := TIniFile.create(nomFichierIni);
     try
     Ini.writeInteger(stWav,'bits',Nbits);
     Ini.WriteInteger(stWav,'freq',FreqEch);
     Ini.writeInteger(stWav,'Mode',indexMode);
     ini.writeInteger(stWav,'filterIndex',openDialog.filterIndex);
     finally
     Ini.Free;
     end;
     except
     end;
     waveForm := nil;
end;

procedure TWaveForm.PaintBoxMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var dX : integer;
begin
     if NomFichier='' then exit;
     case curseurT of
         curNormal : if ((finPB-debutPB)<ecartDebutFin) and
           (x>=debutPB) and (x<=finPB)
              then PaintBox.cursor := crHandPoint
              else if (abs(X-debutPB)<precDebutFin) or (abs(X-finPB)<precDebutFin)
                 then PaintBox.cursor := crHsplit
                 else if (X>debutPB) and (X<finPB)
                     then PaintBox.cursor := crHandPoint
                     else PaintBox.cursor := crDefault;
         curDebut : if (X>graphe.limiteCourbe.left) and
                       (X<finPB) then begin
                   traceDebutFin; // efface l'ancien
                   debutPB := X;
                   traceDebutFin;
         end;
         curFin : if (X>debutPB) and
                     (X<graphe.limiteCourbe.right) then begin
            traceDebutFin;// efface l'ancien
            finPB := X;
            traceDebutFin;
         end;
         curDeplace : begin
            dX := X-Xdeplace;
            if ((debutPB+dX)>graphe.limiteCourbe.left) and
               ((finPB+dX)<graphe.limiteCourbe.right) then begin
                 traceDebutFin; // efface l'ancien
                 debutPB := debutPB + dX;
                 finPB := finPB + dX;
                 Xdeplace := X;
                 traceDebutFin;
             end;
         end;
     end;{case}
end; // TempsMouseMove

procedure TWaveForm.PaintBoxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var xx,yy : double;
begin with graphe do begin
      if NomFichier='' then exit;
      PaintBox.Cursor := crDefault;
      traceDebutFin;
      case curseurT of
           curDebut : begin
               if X<finPB then debutPB := X;
               mondeXY(debutPB,0,xx,yy);
               debut := round(xx)+debutS;
           end;
           curFin : begin
               if X>debutPB then finPB := X;
               mondeXY(finPB,0,xx,yy);
               fin := round(xx)+debutS;
           end;
           curDeplace : begin
                mondeXY(finPB,0,xx,yy);
                fin := round(xx)+debutS;
                mondeXY(debutPB,0,xx,yy);
                debut := round(xx)+debutS;
           end;
      end;
      if debut<debutS then begin
           debut := debutS;
           debutPB := Xecran(debut);
      end;
      if fin>=vecteurSon.NbrePoints then begin
           fin := pred(vecteurSon.NbrePoints);
           finPB := Xecran(fin);
      end;
      if fin>=debutS+paintBox.width*pasTrace then begin
           fin := debutS+paintBox.width*pasTrace-1;
           finPB := xecran(fin);
      end;
      curseurT := curNormal;
      traceDebutFin;
      AffecteDebutFin;
end end;

procedure TWaveForm.TraceDebutFin;
begin with graphe,PaintBox.Canvas do begin
      Pen.Color := clTeal;
      Brush.Color := clSilver;
      Pen.mode := pmNotXOR;
      Pen.width := 3;
      Rectangle(debutPB,-2,finPB,Height);
end end;

procedure TWaveForm.PaintBoxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if NomFichier='' then exit;
   curseurT := curNormal;
   if ((finPB-debutPB)<ecartDebutFin) and
      (x>=debutPB) and
      (x<=finPB)
   then curseurT := curDeplace
   else if abs(x-debutPB)<precDebutFin
      then curseurT := curDebut
      else if abs(x-finPB)<precDebutFin
         then curseurT := curFin
         else if (curseurT=curNormal) and
                 (x>debutPB) and
                 (x<finPB) then curseurT := curDeplace;
   case curseurT of
       curNormal : PaintBox.Cursor := crDefault;
       curDeplace : PaintBox.Cursor := crHandPoint;
       else PaintBox.Cursor := crHsplit;
   end;
   Xdeplace := X;
end;

procedure TWaveForm.AffecteDebutFin;

Function GetPos(posInt : integer) : LongInt;
begin
   if mediaPlayer.timeFormat=tfMilliseconds
      then result := round(posInt*1000.0/FreqEch)
      else result := posInt;
end;

begin
   if not PlayBtn.enabled then exit;
   try
   MediaPlayer.StartPos := getPos(debut);
   MediaPlayer.EndPos := getPos(fin);
   except
   end;
   DureeLabel.caption := TrDuree+FloatToStrF((fin-debut)/FreqEch,ffFixed,5,2)+' s';
   ChercheFreqReg;
   paintBoxZoom.invalidate;
end;

procedure TWaveForm.FormDeactivate(Sender: TObject);
begin
     if MediaPlayer.FileName<>'' then begin
     try
     MediaPlayer.close
     except
     end;
     end;
end;

procedure TWaveForm.FormActivate(Sender: TObject);
begin
    if (NomFichier<>'') and PlayBtn.enabled then MediaPlayer.open
end;

procedure TWaveForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     if (NomFichier<>'') then begin
        stopLecture;
        if MediaPlayer.FileName<>'' then begin
           try
           MediaPlayer.Close;
           MediaPlayer.FileName := '';
           except
           end;
        end;
        nomFichier := '';
     end;
     inherited;
end;

procedure TWaveForm.StopLecture;
begin
    if StopBtn.enabled and (MediaPlayer.FileName<>'') then begin
        timer1.Enabled := false;
        MediaPlayer.Notify := false;
        PositionLabel.visible := false;
        StopBtn.enabled := false;
        RecordBtn.enabled := true;
        try
           MediaPlayer.Stop;
        except
        end;
        MediaPlayer.Notify := false;
    end;
end;

procedure TWaveForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var P : Tpoint;
begin
     try
     P := Mouse.CursorPos;
     except
         exit;
     end;
     case key of
          vk_left : dec(P.X);
          vk_right : inc(P.X);
          vk_down : inc(P.Y);
          vk_up : dec(P.Y);
          vk_prior : if ssShift in shift
              then dec(P.X,10)
              else dec(P.Y,10);
          vk_next : if ssShift in shift
              then inc(P.X,10)
              else inc(P.Y,10);
          vk_delete : ;
          else exit;
     end;
     key := 0;
     Mouse.CursorPos := P;
end;

procedure TWaveForm.SaveFileBtnClick(Sender: TObject);
var src,dest : Pchar;
begin
    if saveDialog.Execute then begin
        src := strAlloc(length(mediaPlayer.FileName)+1);
        dest := strAlloc(length(saveDialog.FileName)+1);
        strPCopy(src,mediaPlayer.FileName);
        strPCopy(dest,saveDialog.FileName);
        copyFile(src,dest,true);
        strDispose(src);
        strDispose(dest);
        mediaPlayer.close;
        mediaPlayer.FileName := saveDialog.FileName;
        saveFileBtn.enabled := false;
    end
end;

procedure TWaveForm.CloseMedia;
var
    MyGenParms: TMCI_Generic_Parms;
    MyError,Flags : LongInt;
begin
    if FDeviceID <> 0 then begin
      Flags:=0;
      MyGenParms.dwCallback:=Handle; // Form
      MyError:=mciSendCommand(FDeviceID,mci_Close,Flags,LongWord(@MyGenParms));
      if MyError = 0 then FDeviceID:=0;
    end;
end;

procedure TWaveForm.RecordBtnClick(sender : Tobject);

procedure OpenMedia;
var
    MyOpenParms: TMCI_Open_Parms;
    MyWaveParms : TMCI_WAVE_SET_PARMS;
    Flags : longWord;
    MyError : LongInt;
begin
    Flags := mci_Wait or mci_Open_Element or mci_Open_Type;
    with MyOpenParms do  begin
      dwCallback:=Handle; // Form
      lpstrDeviceType:=PChar('WaveAudio');
      lpstrElementName:=PChar('');
    end;
    MyError := mciSendCommand(0,mci_Open,Flags,LongWord(@MyOpenParms));
    if MyError = 0 then FDeviceID:=MyOpenParms.wDeviceID;
    with MyWaveParms do begin
          dwCallback := handle;
          if stereo then nChannels := 2 else nChannels := 1;
          nSamplesPerSec := freqEch;
          nAvgBytesPerSec := freqEch*(Nbits div 8)*nChannels;
          nBlockAlign := (Nbits div 8)*nChannels;
          wBitsPerSample := Nbits;
    end;
    Flags := MCI_WAIT or
             MCI_WAVE_SET_BITSPERSAMPLE or
             MCI_WAVE_SET_CHANNELS or
             MCI_WAVE_SET_SAMPLESPERSEC or
             MCI_WAVE_SET_AVGBYTESPERSEC or
             MCI_WAVE_SET_BLOCKALIGN;
    mciSendCommand(FdeviceId, MCI_SET,Flags,longWord(@MyWaveParms));
end;

procedure RecordMedia;
var
    MyRecordParms: TMCI_Record_Parms;
    Flags : LongInt;
begin
    Flags:=mci_Notify;
    with MyRecordParms do  begin
        dwCallback:=Handle;  // Form
        dwFrom:=0;
        dwTo:=0;
    end;
    try
    mciSendCommand(FDeviceID,mci_Record,Flags,LongWord(@MyRecordParms));
    except;
        CloseMedia;
    end;
end;

procedure StopMedia;
var
    MyGenParms: TMCI_Generic_Parms;
    Flags : LongInt;
begin
  if FDeviceID <> 0 then  begin
      Flags:=mci_Wait;
      MyGenParms.dwCallback:=Handle;  // Form
      try
      mciSendCommand(FDeviceID,mci_Stop,Flags,LongWord(@MyGenParms));
      except
          CloseMedia;
      end;
    end;
end;

begin
          MediaPlayer.Notify := false;
          if MediaPlayer.FileName<>'' then begin
             try
             MediaPlayer.close;
             MediaPlayer.FileName := '';
             except
             end;
          end;
          NomFichier := '';
          PlayBtn.enabled := false;
          StopBtn.enabled := true;
          RecordBtn.enabled := false;
          deleteFile(nomFichierWav);// pour éviter pb de protection en écriture
          OpenMedia;
          RecordMedia;
          startRecord := now;
end; // record

procedure TWaveForm.ModeBtnClick(Sender: TObject);
begin
   TestWavDlg := TtestWavDlg.create(self);
   TestWavDlg.showModal;
   TestWavDlg.free;
end;

procedure TWaveForm.MediaPlayerNotify(Sender: TObject);
begin
  if boucleCB.checked
     then begin
         AffecteDebutFin;
         mediaPlayer.notify := true;
         mediaPlayer.play;
     end
     else begin
         PlayBtn.enabled := true;
         StopBtn.enabled := false;
         RecordBtn.enabled := true;
         Timer1.enabled := false;
         PositionLabel.visible := false;
         TracePosition;
     end;
end;

procedure TWaveForm.PlayBtnClick(Sender: TObject);
var duree : double;
begin
  AffecteDebutFin;
  Duree := (fin-debut)/FreqEch;
  Timer1.Enabled := Duree>0.55;
  PositionLabel.visible := true;
  PositionPB := debutPB;
  TracePosition;
  PlayBtn.enabled := false;
  StopBtn.enabled := true;
  RecordBtn.enabled := false;
  MediaPlayer.notify := true;
  MediaPlayer.Play;
end;

procedure TWaveForm.Timer1Timer(Sender: TObject);
var posSec : double;
begin
    if StopEnCours then begin
       inc(compteur);
       if compteur>compteurMax then begin
          stopEnCours := false;
          stopBtn.enabled := false;
          recordBtn.enabled := true;          
          Timer1.enabled := false;
          saveMedia;
        end;
        exit;
    end;
    if MediaPlayer.FileName<>'' then begin
         TracePosition; // efface
         if mediaPlayer.timeFormat=tfMilliseconds
            then PosSec := mediaPlayer.position/1000.0
            else PosSec := mediaPlayer.position/FreqEch;
         positionPB := graphe.Xecran(posSec*FreqEch);
         PositionLabel.Caption := FloatToStrF(PosSec,ffFixed,5,1)+' s';
         TracePosition; // retrace
    end;
end;

procedure TWaveForm.TracePosition;
begin with paintBox.canvas do begin
         pen.mode := pmNotXor;
         pen.color := clRed;
         pen.Width := 1;
         moveTo(positionPB,0);
         lineTo(positionPB,paintBox.height);
end end;

procedure TWaveForm.WMMajWav(var Msg: Tmessage);
begin
     OuvreFichier(NomFichierWav)
end;

procedure TWaveForm.ZoomUDChangingEx(Sender: TObject; var AllowChange: Boolean;
  NewValue: Integer; Direction: TUpDownDirection);
var centre,largeur : longInt;
begin
  inherited;
  centre := (debut+fin) div 2;
  largeur := fin-debut;
  case direction of
       updNone : exit;
       updUp : begin
           allowChange := (debut>0) and (fin<pred(vecteurSon.nbrePoints));
           if allowChange then begin
              largeur := puiss2Sup(largeur);
              debut := centre-largeur;
              if debut<0 then debut := 0;
              fin := centre+largeur;
              if fin>pred(vecteurSon.nbrePoints) then
                 fin := pred(vecteurSon.nbrePoints);
           end
           else exit;
       end;
       updDown : begin
           allowChange := largeur>512;
           if AllowChange then begin
              largeur := puiss2Inf(largeur);
              largeur := largeur div 4;
              debut := centre-largeur;
              fin := centre+largeur;
           end
           else exit;
       end;
  end;
  paintBox.invalidate;
  AffecteDebutFin;

end;

procedure TWaveForm.StopBtnClick(Sender: TObject);
var h,m,s,ms : word;
    dureeSec : double;
begin
   if nomFichier='' then begin // stop enregistrement
      StopBtn.enabled := false;
      RecordBtn.enabled := false;
      stopEnCours := true;
      decodeTime(now-startRecord,h,m,s,ms);
      DureeSec := m*60.0+s*1.0+ms*0.001;
      CompteurMax := ceil((1000*DureeSec-trunc(dureeSec))/Timer1.interval);
      Compteur := 0;
      Timer1.enabled := true;
   end
   else stopLecture
end;

procedure TWaveForm.WaveSBChange(Sender: TObject);
begin
  PaintBox.invalidate
end;

procedure TWaveForm.DecodeFileMP3(const SourceFileName : String;var DestFileName : String);
const longueur = 9600;
var
  chan: DWORD;
  frq: Single;
  buf : array [0..longueur-1] of BYTE;
  BytesRead : integer;
  temp : AnsiString;
  i : longint;
  RecStream : TFileStream;
  nChannels       : Word;   // number of channels (i.e. mono, stereo, etc.)
  nSamplesPerSec  : DWORD;  // sample rate
  nAvgBytesPerSec : DWORD;
  nBlockAlign     : Word;
  BitsPerSample  : Word;   // number of bits per sample of mono data
  chaninfo: BASS_CHANNELINFO;
  extension : string;
begin
  DestFileName := nomFichierWav;
  extension := UpperCase(extractFileExt(sourceFileName));
  deleteFile(nomFichierWav);// pour éviter pb de protection en écriture
  if extension = '.MP3'
     then chan := BASS_StreamCreateFile(FALSE, PChar(SourceFileName), 0, 0, BASS_STREAM_DECODE or BASS_UNICODE)
     else if extension = '.AAC' then chan := BASS_AAC_StreamCreateFile(FALSE, PChar(SourceFileName), 0, 0, BASS_STREAM_DECODE or BASS_UNICODE)
     else if extension = '.MP4' then chan := BASS_MP4_StreamCreateFile(FALSE, PChar(SourceFileName), 0, 0, BASS_STREAM_DECODE or BASS_UNICODE)
     else if extension = '.M4A' then chan := BASS_MP4_StreamCreateFile(FALSE, PChar(SourceFileName), 0, 0, BASS_STREAM_DECODE or BASS_UNICODE)
     else exit;
  if chan=0 then exit; // erreur
  CancelOp := False;
  caption := 'Conversion '+extension+' -> .WAV ...';

  BASS_ChannelGetInfo(chan, chaninfo);
	nChannels := chaninfo.chans;
  bitsPerSample := 16;
  if (chaninfo.flags and BASS_SAMPLE_8BITS > 0)
     then bitsPerSample := 8;
  if (chaninfo.flags and BASS_SAMPLE_FLOAT > 0)
     then bitsPerSample := 32;

	nBlockAlign := nChannels * bitsPerSample div 8;
	BASS_ChannelGetAttribute(chan, BASS_ATTRIB_FREQ, frq);
  nSamplesPerSec := Trunc(frq);
	nAvgBytesPerSec := nSamplesPerSec * nBlockAlign;
//  BASS_ChannelGetAttribute(chan, BASS_ATTRIB_BITRATE, frq);

  RecStream := TFileStream.Create(DestFileName, fmCreate);

 // Write header portion of wave file
    temp := 'RIFF'; RecStream.write(temp[1], length(temp));
    temp := #0#0#0#0; RecStream.write(temp[1], length(temp));   // File size: to be updated
    temp := 'WAVE'; RecStream.write(temp[1], length(temp));
    temp := 'fmt '; RecStream.write(temp[1], length(temp));
    temp := #$10#0#0#0; RecStream.write(temp[1], length(temp)); // Fixed
    temp := #1#0; RecStream.write(temp[1], length(temp));       // PCM format
    if nChannels = 1
       then temp := #1#0
       else temp := #2#0;
    RecStream.write(temp[1], length(temp));
    RecStream.write(nSamplesPerSec, 2);
    temp := #0#0; RecStream.write(temp[1], length(temp));   // SampleRate is given as dWord
    RecStream.write(nAvgBytesPerSec, 4);
    RecStream.write(nBlockAlign, 2);
    RecStream.write(BitsPerSample, 2);
    temp := 'data'; RecStream.write(temp[1],length(temp));
    temp := #0#0#0#0; RecStream.write(temp[1],length(temp)); // Data size: to be updated
	  while (BASS_ChannelIsActive(chan) > 0) do begin
          BytesRead := BASS_ChannelGetData(chan, @buf, longueur);
          RecStream.Write(buf, BytesRead);
          Application.ProcessMessages;
          if CancelOp then Break;
          PercentDone := Trunc(100 * (BASS_ChannelGetPosition(Chan, BASS_POS_BYTE) / BASS_ChannelGetLength(chan, BASS_POS_BYTE)));
          //ProgressBar.Position := PercentDone;
          caption := 'Conversion : ' + IntToStr(PercentDone) + '%';
	  end;
    BASS_StreamFree(chan); // free the stream
// complete WAV header, rewrite some fields of header
    i := RecStream.Size - 8;    // size of file
    RecStream.Position := 4;
    RecStream.write(i, 4);
    i := i - $24;               // size of data
    RecStream.Position := 40;
    RecStream.write(i, 4);
    RecStream.Free;
    caption := CaptionWav+' ['+ExtractFileName(NomFichier)+']';
end;

procedure TWaveForm.SaveMedia;
type    // not implemented by Delphi
    TMCI_Save_Parms = record
      dwCallback: DWord;
      lpstrFileName: PChar;  // name of file to save
    end;
var
    MySaveParms: TMCI_Save_Parms;
    Flags : LongInt;
begin
    if FDeviceID <> 0 then  begin
        // save the file...
      Flags:=mci_Save_File or mci_Wait;
      deleteFile(nomFichierWav);// pour éviter pb de protection en écriture
      with MySaveParms do begin
          dwCallback:=Handle;
          lpstrFileName:=PChar(NomFichierWav);
      end;
      try
      mciSendCommand(FDeviceID,mci_Save,Flags,LongWord(@MySaveParms));
      saveFileBtn.enabled := true;
      PostMessage(Handle,WM_Maj_Wav,0,0);
      except
          saveFileBtn.enabled := false;
          NomFichier := '';
      end;
      closeMedia;
      Cursor := crDefault;
    end;
end;

Procedure TWaveForm.ChercheFreqReg;
var ShannonOK : boolean;
    FreqReg : longWord;
begin
   { 44.100 kHz Qualité CD
     22.050 kHz taux d'échantillonnage habituel Windows
     11.025 kHz lecture Windows
     sinon 8 12 16 24 32 48 kHz }
   pasReg := succ((fin-debut) div MaxMaxVecteur);
   FreqReg := FreqEch div pasReg;
   shannonOK := true;
   if (FreqEch=44100) or
      (FreqEch=22050) or
      (FreqEch=11025) then begin
         ShannonOK :=
           (FreqReg=44100) or
           (FreqReg=22050) or
           (FreqReg=11025);
         if not ShannonOK and (FreqReg>11025) then begin { 44100/3 ? }
             FreqReg := 11025;
             pasReg := FreqEch div FreqReg;
             ShannonOK := true;
         end;
   end;
   if (FreqEch=8000) or (FreqEch=12000) or
      (FreqEch=16000) or (FreqEch=24000) or
      (FreqEch=32000) or (FreqEch=48000) then begin
          ShannonOK :=
            (FreqReg=8000) or (FreqReg=12000) or (FreqReg=16000) or
            (FreqReg=24000) or (FreqReg=32000) or (FreqEch=48000);
         if not ShannonOK and (FreqReg>8000) then begin { pasReg=3 par ex. }
             FreqReg := 8000;
             pasReg := FreqEch div FreqReg;
             ShannonOK := true;
         end;
   end;
   FreqRegLabel.caption := trFreqEchReg+intToStr(FreqReg)+' Hz';
   if not ShannonOK
      then FreqRegLabel.caption := FreqRegLabel.caption + ' ?!'
end;

end.

