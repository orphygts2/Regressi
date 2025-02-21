unit TestInWav;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  vcl.HtmlHelpViewer, inifiles, regutil,
  ExtCtrls, mmSystem, StdCtrls, ComCtrls, Buttons, ConstReg, Vcl.MPlayer;

const
     iMaxiMaxi = 32;
type
    Tmode = record
        stereo : boolean;
        frequence,bits : integer
    end;

    TTestWavDlg = class(TForm)
    ModeRG: TRadioGroup;
    Panel1: TPanel;
    OKBtn: TBitBtn;
    BitBtn2: TBitBtn;
    Panel2: TPanel;
    CourantB: TBevel;
    VolumePB: TProgressBar;
    SourceRG: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ModeRGClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure SourceRGClick(Sender: TObject);
    private
         HwaveIn : PHWaveIn;
         Header : PWaveHdr;
         WaveFormat : PWaveFormatEx;
         close_invoked,mode_change,source_change,close_complete : boolean;
         is8bits : boolean;
         modes : array[0..16] of Tmode;
         oldMaxi : array[0..iMaxiMaxi] of integer;
         iMaxi : integer;
         indexMode : integer;
         LindexAudio : Uint;
         procedure MMInDone(var msg:Tmessage);message MM_WIM_DATA;
         procedure MaJMode;
         procedure OpenWaveIn;
         procedure RazHeader;
         procedure Erreur;
      public
  end;

var
  TestWavDlg: TTestWavDlg;

implementation

uses WavMain;

{$R *.DFM}

const
    memBlockLength = 4096;  { 0,37 s à 11 kHz 8 bits }
type
    Tmemblock8 = array[0..memBlockLength] of byte;
    PmemBlock8 = ^TmemBlock8;
    Tmemblock16 = array[0..memBlockLength div 2] of smallInt;
    PmemBlock16 = ^TmemBlock16;

procedure TTestWavDlg.FormCreate(Sender: TObject);
var memoire : PmemBlock8;
    ini : TInifile;
begin // create
     modeRG.items.clear;
     new(WaveFormat);
     with WaveFormat^ do begin
          WFormatTag:=WAVE_FORMAT_PCM; // PCM format - the only option!
          NChannels:=1; // mono
          NSamplesPerSec:=11025; // 11kHz sampling
          NAvgBytesPerSec:=11025; // un octet à 11 kHz
          NBlockAlign:=1; // only one byte in each sample
          wBitsPerSample:=8; // 8 bits in each sample
     end;
     new(Memoire);
     new(Header);
     with header^ do begin
           lpdata:=pointer(memoire);
           dwbufferlength:=memblocklength;
           dwbytesrecorded:=0;
           dwUser:=0;
           dwflags:=0;
           dwloops:=0;
     end;
     Ini := TIniFile.create(nomFichierIni);
     indexMode := ini.readInteger(stWav,'IndexMode',0);
     Ini.Free;
end; // formCreate

procedure TTestWavDlg.RazHeader;
var  memoire8 : PmemBlock8;
     memoire16 : PmemBlock16;
     i : integer;
begin
     if is8Bits
        then begin
             memoire8 := PmemBlock8(header^.lpdata);
             for i := 0 to pred(memBlockLength) do
                 memoire8[i] := 128;
        end
        else begin
             memoire16 := PmemBlock16(header^.lpdata);
             for i := 0 to pred(memBlockLength div 2) do
                 memoire16[i] := 0;
        end
end; // RazHeader

procedure TTestWavDlg.SourceRGClick(Sender: TObject);
begin
     if (sourceRG.itemIndex>=0) and (sourceRG.Tag=0) then begin
       LindexAudio := sourceRG.ItemIndex;
       source_change := true;
     end;
end;

procedure TTestWavDlg.Erreur;
begin
      if not close_complete then begin
         dispose(HwaveIn);
         HwaveIn := nil;
         showMessage(stPbSon);
         close_complete := true;
         waveForm.indexAudio := 0;
      end;
      close;
end;

procedure TTestWavDlg.OpenWaveIn;
var i,coeff : integer;
    channels : byte;
begin
     new(HwaveIn);
     with modes[modeRG.itemIndex] do begin
             if stereo then channels := 2 else channels := 1;
             WaveFormat^.Nchannels:=channels;
             WaveFormat^.NSamplesPerSec:=frequence;
             WaveFormat^.NAvgBytesPerSec:=frequence*(bits div 8)*channels;
             WaveFormat^.NBlockAlign:=(bits div 8)*channels;
             WaveFormat^.wBitsPerSample:=bits;
             is8bits := bits=8;
             iMaxi := iMaxiMaxi;
             if is8bits then iMaxi := iMaxi div 2;
             coeff := 44100 div frequence;
             iMaxi := iMaxi div coeff;
     end;
     i:=waveInOpen(HWaveIn,LindexAudio,PwaveFormatEx(WaveFormat),handle,0,CALLBACK_WINDOW);
     if i<>0 then erreur; // 'Problem creating record handle'
// prepare the new block
     razHeader;
     i:=waveInPrepareHeader(HWaveIn^,Header,sizeof(TWavehdr));
     if i<>0 then erreur; // 'In Prepare error'
// add it to the buffer
     i:=waveInAddBuffer(HWaveIn^,Header,sizeof(TWaveHdr));
     if i<>0 then erreur; // 'Add buffer error'
// finally start recording
     i:=waveInStart(HwaveIn^);
     if i<>0 then erreur; // 'Start error'
     close_invoked := false;
     source_change := false;
     mode_change := false;
     close_complete := false;
end; // OpenWaveIn

procedure TTestWavDlg.MMInDone(var msg:Tmessage);
var
   i : integer;
   memoire8 : PmemBlock8;
   memoire16 : PmemBlock16;
   z,maxi : integer;
begin
     try
// block has been recorded
// HeaderLoc := PWaveHdr(msg.lparam);
     i := waveInUnPrepareHeader(HWaveIn^,Header,sizeof(TWavehdr));
     if i<>0 then erreur;
     with header^ do begin
          maxi := 0;
          if is8bits
             then begin
                memoire8 := PmemBlock8(lpdata);
                for i := 0 to pred(dwbytesRecorded) do begin
                    z := memoire8[i]-128;
                    if z>maxi then maxi := z;
                end;
                { 0..128 }
             end
             else begin
                memoire16 := PmemBlock16(lpdata);
                for i := 0 to pred(dwbytesRecorded div 2) do begin
                    z := abs(memoire16[i]);
                    if z>maxi then maxi := z;
                end;
                {0..32000}
                 maxi := maxi div 256;
                {0..128}
             end;
             for i := 0 to pred(iMaxi) do
                 oldMaxi[i] := oldMaxi[succ(i)];
             oldMaxi[iMaxi] := maxi;
             CourantB.Left := volumePB.left+maxi*2-2;
             for i := 0 to pred(iMaxi) do
                 if oldMaxi[i]>maxi then maxi := oldMaxi[i];
             volumePB.position := maxi;
     end;
     if not(close_invoked) and not(mode_change) and not(source_change) then begin
// prepare the new block
          razHeader;
          i:=waveInPrepareHeader(HWaveIn^,Header,sizeof(TWavehdr));
          if i<>0 then erreur;
          // add it to the buffer
          i := waveInAddBuffer(HWaveIn^,Header,sizeof(TWaveHdr));
          if i<>0 then erreur;
     end;
     if mode_change then begin
            WaveInClose(HWaveIn^);
            dispose(HWaveIn);
            HwaveIn := nil;
            OpenWaveIn;
     end;
     if source_change then begin
            WaveInClose(HWaveIn^);
            dispose(HWaveIn);
            HwaveIn := nil;
            MajMode;
            OpenWaveIn;
     end;
     if close_invoked then begin
          WaveInClose(HWaveIn^);
          dispose(HwaveIn);
          HwaveIn := nil;
          close_complete := true;
          close;
     end;
     except
          erreur;
     end;
end; // MMInDone

procedure TTestWavDlg.FormActivate(Sender: TObject);
var i : Integer;
    iMax : Integer;
    tWIC : PWaveInCaps;
    S : string;
begin
    LindexAudio := waveForm.indexAudio;
    sourceRG.Tag := 1;
    sourceRG.items.clear;
    iMax := waveInGetNumDevs()-1;
    new(tWIC);
    For i := 0 to iMax do
        If waveInGetDevCaps(i,PwaveInCapsW(tWIC), SizeOf(waveIncaps)) = 0
        Then begin
            s := string(tWIC.szPname); // limité au 32 premiers caractères
            SourceRG.items.Add(s+'...');
        end
        else SourceRG.items.Add('Erreur');
    dispose(tWIC);
    sourceRG.visible := SourceRG.items.count>1;
    if LindexAudio<SourceRG.items.count
       then sourceRG.itemIndex := LindexAudio
       else begin
          sourceRG.itemIndex := 0;
          LindexAudio := 0;
       end;
    sourceRG.Tag := 0;
    MajMode;
    OpenWaveIn;
end;

procedure TTestWavDlg.MajMode;
var WaveCaps : PWAVEINCAPS;
    nbreMode : integer;

Procedure Test(wf,f : longWord;b : integer;s : boolean);
var texte : String;
begin
     if ((WaveCaps^.dwFormats and WF) = WF) then begin
        with modes[nbreMode] do begin
           frequence := f;
           bits := b;
           stereo := s;
           texte := intToStr(f)+' Hz '+intToStr(b)+' bits';
           if s then texte := texte + ' stéréo';
           ModeRG.items.Add(texte);
           if (WaveForm.FreqEch=f) and
              (WaveForm.Nbits=b) then ModeRG.itemIndex := pred(ModeRG.items.count);
        end;
        inc(NbreMode);
     end;
end; // test

procedure testAll;
begin
 // mono
     test(WAVE_FORMAT_1M08,11025,8,false);
     test(WAVE_FORMAT_1M16,11025,16,false);
     test(WAVE_FORMAT_2M08,22050,8,false);
     test(WAVE_FORMAT_2M16,22050,16,false);
     test(WAVE_FORMAT_4M08,44100,8,false);
     test(WAVE_FORMAT_4M16,44100,16,false);
// stéréo
     test(WAVE_FORMAT_1S08,11025,8,true);
     test(WAVE_FORMAT_1S16,11025,16,true);
     test(WAVE_FORMAT_2S08,22050,8,true);
     test(WAVE_FORMAT_2S16,22050,16,true);
     test(WAVE_FORMAT_4S08,44100,8,true);
     test(WAVE_FORMAT_4S16,44100,16,true);
end;

begin
     new(waveCaps);
     NbreMode := 0;
     modeRG.Tag := 1;
     modeRG.items.clear;
     if waveInGetDevCaps(LindexAudio,PwaveInCapsW(WAVECAPS),sizeof(waveIncaps))=0
        then testAll
        else begin
           showMessage('Pas d''entrée son sur '+sourceRG.items[LindexAudio]);
           if sourceRG.Items.Count>1 then begin
              if LindexAudio=0
                 then LindexAudio := sourceRG.Items.Count-1
                 else LindexAudio := 0;
              if waveInGetDevCaps(LindexAudio,PwaveInCapsW(WAVECAPS),sizeof(waveIncaps))=0
                 then begin
                    sourceRG.Tag := 1;
                    testAll;
                    sourceRG.ItemIndex := LindexAudio;
                    sourceRG.Tag := 0;
                 end
                 else showMessage('Pas d''entrée non plus sur '+sourceRG.items[LindexAudio]);
           end;
        end;
     modeRG.itemIndex := indexMode;
     if (ModeRG.itemIndex<0) or (ModeRG.itemIndex>=ModeRG.items.count) then modeRG.itemIndex := 0;
     dispose(wavecaps);
     modeRG.Tag := 0;
end; // Maj

procedure TTestWavDlg.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
     if HwaveIn<>nil then WaveInReset(HWaveIn^);
     close_invoked := true;
     canClose := close_complete;
end;

procedure TTestWavDlg.ModeRGClick(Sender: TObject);
begin
     if (modeRG.itemIndex>=0) and (modeRG.Tag=0) then begin
         indexMode := modeRG.itemIndex;
         mode_change := true
     end;
end;

procedure TTestWavDlg.OKBtnClick(Sender: TObject);
begin
     WaveForm.FreqEch := modes[modeRG.itemIndex].frequence;
     WaveForm.Nbits := modes[modeRG.itemIndex].bits;
     WaveForm.stereo := modes[modeRG.itemIndex].stereo;
     waveForm.indexAudio := LindexAudio;
end;

procedure TTestWavDlg.FormDestroy(Sender: TObject);
var ini : TInifile;
begin
  inherited;
  dispose(PmemBlock8(header^.lpdata));
  dispose(header);
  Ini := TIniFile.create(nomFichierIni);
  Ini.writeInteger(stWav,'IndexMode',indexMode);
  Ini.Free;
end;

end.
