unit TestInWav;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  vcl.HtmlHelpViewer,
  ExtCtrls, mmSystem, StdCtrls, ComCtrls, Buttons, ConstReg;

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
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel2: TPanel;
    CourantB: TBevel;
    VolumePB: TProgressBar;
       procedure FormCreate(Sender: TObject);
       procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
       procedure ModeRGClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    private
         HwaveIn:PHWaveIn;
         Header : PWaveHdr;
         WaveFormat:PWaveFormatEx;
         close_invoked,change_invoked,close_complete:boolean;
         NbreMode : integer;
         is8bits : boolean;
         modes : array[0..16] of Tmode;
         oldMaxi : array[0..iMaxiMaxi] of integer;
         iMaxi : integer;
         procedure MMInDone(var msg:Tmessage);message MM_WIM_DATA;
         procedure OpenWavIn;
         procedure RazHeader;
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
var
   WaveCaps : PWAVEINCAPS;
   i : integer;
   memoire : PmemBlock8;

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

begin // create
     new(waveCaps);
     NbreMode := 0;
     modeRG.items.clear;
     caption := 'Choix du mode d''enregistrement '+wavecaps^.szPname;
     i := waveInGetDevCaps(0,PwaveInCapsW(WAVECAPS),sizeof(waveIncaps));
     if i<>0 then begin
         showMessage('Pas d''entrée son');
         close;
     end;
{ mono }
     test(WAVE_FORMAT_1M08,11025,8,false);
     test(WAVE_FORMAT_1M16,11025,16,false);
     test(WAVE_FORMAT_2M08,22050,8,false);
     test(WAVE_FORMAT_2M16,22050,16,false);
     test(WAVE_FORMAT_4M08,44100,8,false);
     test(WAVE_FORMAT_4M16,44100,16,false);
{ stéréo }
     test(WAVE_FORMAT_1S08,11025,8,true);
     test(WAVE_FORMAT_1S16,11025,16,true);
     test(WAVE_FORMAT_2S08,22050,8,true);
     test(WAVE_FORMAT_2S16,22050,16,true);
     test(WAVE_FORMAT_4S08,44100,8,true);
     test(WAVE_FORMAT_4S16,44100,16,true);
     new(WaveFormat);
     with WaveFormat^ do begin
          WFormatTag:=WAVE_FORMAT_PCM; {PCM format - the only option!}
          NChannels:=1; {mono}
          NSamplesPerSec:=11025; {11kHz sampling}
          NAvgBytesPerSec:=11025; { un octet à 11 kHz }
          NBlockAlign:=1; {only one byte in each sample}
          wBitsPerSample:=8; {8 bits in each sample}
     end;
//     i:=waveInOpen(nil,0,PWaveFormatEx(WaveFormat),0,0,WAVE_FORMAT_QUERY);
     if ModeRG.itemIndex<0 then modeRG.itemIndex := WaveForm.indexMode;
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
(*     auxGetVolume(0,@volume); { output }
     volume := volume mod high(word);
     volumeTB.position := volume;*)
     OpenWavIn;
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

procedure TTestWavDlg.OpenWavIn;
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
     i:=waveInOpen(HWaveIn,0,PwaveFormatEx(WaveFormat),handle,0,CALLBACK_WINDOW);
     if i<>0 then begin
        showMessage('Problem creating record handle');
        close;
     end;
{prepare the new block}
     razHeader;
     i:=waveInPrepareHeader(HWaveIn^,Header,sizeof(TWavehdr));
     if i<>0 then begin
        showMessage('In Prepare error');
        close;
     end;
{add it to the buffer}
     i:=waveInAddBuffer(HWaveIn^,Header,sizeof(TWaveHdr));
     if i<>0 then begin
        showMessage('Add buffer error');
        close;
     end;   
{finally start recording}
     i:=waveInStart(HwaveIn^);
     if i=0
        then
        else begin
          showMessage('Start error');
          close;
        end;
     close_invoked := false;
     change_invoked := false;
     close_complete := false;
end; // OpenWaveIn

procedure TTestWavDlg.MMInDone(var msg:Tmessage);
var
   i : integer;
   enCours : boolean;
   memoire8 : PmemBlock8;
   memoire16 : PmemBlock16;
   z,maxi : integer;
begin
     enCours := false;
{block has been recorded}
(*     HeaderLoc := PWaveHdr(msg.lparam);*)
     i:=waveInUnPrepareHeader(HWaveIn^,Header,sizeof(TWavehdr));
     if i<>0 then begin
        showMessage('In UnPrepare error');
        close;
     end;
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
     if not(close_invoked) and not(change_invoked) then begin
{prepare the new block}
          razHeader;
          i:=waveInPrepareHeader(HWaveIn^,Header,sizeof(TWavehdr));
          if i<>0 then begin
             showMessage('In Prepare error');
             close;
          end;
          {add it to the buffer}
          i:=waveInAddBuffer(HWaveIn^,Header,sizeof(TWaveHdr));
          if i<>0 then begin
             showMessage('Add buffer error');
             close;
          end;
          enCours := true;
     end;
     if change_invoked
        then begin
            WaveInClose(HWaveIn^);
            dispose(HWaveIn);
            HwaveIn := nil;            
            OpenWavIn;
        end
        else {if there's no more blocks being recorded}
     if not EnCours then begin
          WaveInClose(HWaveIn^);
          dispose(HwaveIn);
          HwaveIn := nil;
          close_complete:=true;
          close;
     end;
end; // MMInDone

procedure TTestWavDlg.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
     if HwaveIn<>nil then WaveInReset(HWaveIn^);
     close_invoked:=true;
     canClose:=close_complete;
end;

procedure TTestWavDlg.ModeRGClick(Sender: TObject);
begin
     if modeRG.itemIndex>=0 then change_invoked := true
end;

procedure TTestWavDlg.BitBtn1Click(Sender: TObject);
begin
     WaveForm.FreqEch := modes[modeRG.itemIndex].frequence;
     WaveForm.Nbits := modes[modeRG.itemIndex].bits;
     WaveForm.stereo := modes[modeRG.itemIndex].stereo;
end;

procedure TTestWavDlg.FormDestroy(Sender: TObject);
begin
  inherited;
  dispose(PmemBlock8(header^.lpdata));
  dispose(header);
end;

end.
