unit pageechant;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls,Dialogs, sysutils, Spin,
  vcl.HtmlHelpViewer,
  constreg, math, maths, regutil, fft, compile, filerrr, aidekey;

type
  TPageEchantillonDlg = class(TForm)
    LabelY: TLabel;
    LabelX: TLabel;
    EditX: TEdit;
    Panel1: TPanel;
    HelpBtn: TBitBtn;
    CancelBtn: TBitBtn;
    OKBtn: TBitBtn;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    NmesSpin: TSpinButton;
    NewNmesEdit: TEdit;
    OldNmesEdit: TEdit;
    Label1: TLabel;
    UnsurNSE: TSpinEdit;
    UnsurNCB: TCheckBox;
    EditComment: TEdit;
    Label3: TLabel;
    LabelPage: TLabel;
    procedure OKBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure NmesSpinDownClick(Sender: TObject);
    procedure NmesSpinUpClick(Sender: TObject);
    procedure UnsurNCBClick(Sender: TObject);
    procedure UnsurNSEChange(Sender: TObject);
  private
    newNmes : integer;
    Procedure AjusteNombre;
    Procedure UnPointSurN;
    Procedure SurEchantillon;
    Procedure NmesSpinClick(Down : boolean);
    procedure MajCB;
  public
  end;

var
  PageEchantillonDlg: TPageEchantillonDlg;

implementation

{$R *.DFM}

procedure TPageEchantillonDlg.OKBtnClick(Sender: TObject);
begin
     with pages[pageCourante] do begin
          NewNmes := StrToInt(NewNmesEdit.Text);
          if NewNmes>maxMaxVecteur then NewNmes := maxMaxVecteur;
          if newNmes<nmes
             then if UnSurNCB.checked
                 then UnPointSurN
                 else AjusteNombre
           else SurEchantillon;
           recalculP;
     end;
     Application.MainForm.perform(WM_Reg_Maj,MajAjoutPage,0);
     ModifFichier := true;
end;

procedure TPageEchantillonDlg.HelpBtnClick(Sender: TObject);
begin
   Aide(HELP_PageEchantillon)
end;

procedure TPageEchantillonDlg.FormActivate(Sender: TObject);
begin
       inherited;
       EditX.text := grandeurs[indexVariab[0]].nom;
       editComment.text := pages[pageCourante].titrePage;
       editComment.Visible := nbrePages>1;
       labelPage.Visible := nbrePages>1;
       NewNmesEdit.text := IntToStr(pages[pageCourante].nmes);
       OldNmesEdit.text := IntToStr(pages[pageCourante].nmes);
       MajCB;
end;

Procedure TPageEchantillonDlg.AjusteNombre;
var
    j : integer;
    voie : integer;
    Coeff : array[TcodeGrandeur] of double;
    VarOK : array[TcodeGrandeur] of boolean;
    oldValeurVar : array[TcodeGrandeur] of Tvecteur;

Procedure Recopie(j : integer);
var voie : integer;
begin with pages[PageCourante] do begin
    Nmes := Nmes+1;
    for voie := 0 to pred(NbreGrandeurs) do
        if varOK[voie] then valeurVar[voie,Nmes] := oldValeurVar[voie,j];
end end;

var maxi,mini : double;
    oldNmes,pas : integer;
begin with pages[PageCourante] do begin
   for voie := 0 to pred(NbreGrandeurs) do with grandeurs[voie] do begin
       varOK[voie] := (genreG=variable) and
                      (fonct.genreC=g_experimentale);
       if varOK[voie] then begin
          GetMinMax(ValeurVar[voie],Nmes,mini,maxi);
          Coeff[voie] := 1/(maxi-mini);
          setlength(oldValeurVar[voie],NmesMax+1);
          copyVecteur(oldValeurVar[voie],valeurVar[voie]);
       end;
   end;
   Pas := (Nmes div NewNmes)+1;
   oldNmes := Nmes;
   Nmes := 0;
   Recopie(0);
   for j := pas to (oldNmes-pas) do if (j mod pas)=0 then
      Recopie(j);
   Recopie(oldNmes-1);
   for voie := 0 to pred(NbreGrandeurs) do
      if varOK[voie] then
         finalize(oldValeurVar[voie]);
end end; // AjusteNombre

Procedure TPageEchantillonDlg.UnPointSurN;
var j,N : integer;
    voie : integer;
    VarOK : array[TcodeGrandeur] of boolean;
begin with pages[PageCourante] do begin
   for voie := 0 to pred(NbreGrandeurs) do with grandeurs[voie] do
       varOK[voie] := (genreG=variable) and
                      (fonct.genreC=g_experimentale);
   N := UnsurNSE.value;
   NewNmes := Nmes div N;
   for voie := 0 to pred(NbreGrandeurs) do if varOK[voie] then
       for j := 1 to pred(NewNmes) do
           valeurVar[voie,j] := ValeurVar[voie,j*N];
   Nmes := newNmes;
end end; // UnPointSurN

Procedure TPageEchantillonDlg.SurEchantillon;
var pas : double;
    oldNmes : integer;
    kmax : integer;

procedure CalculSinc;
const MaxFiltre = 16; // soit sinc(pi*maxFiltre)=0.02
var i,j,k,l,jk : integer;
    coeff,centre : double;
    valeurC : array[0..5] of double;
    v : integer;
    tampon : array[0..5] of Tvecteur;
    indexLoc : array[0..5] of integer;
begin with pages[PageCourante] do begin
     l := 0;
     for v := 1 to pred(NbreGrandeurs) do
        if (grandeurs[v].genreG=variable) and
           (grandeurs[v].fonct.genreC=g_experimentale) then begin
             indexLoc[l] := v;
             copyVecteur(tampon[l],valeurVar[v]);
             inc(l);
             if l>5 then exit;         
     end;
     for i := 0 to pred(kmax) do begin
         j := round(i/pas); // point le plus proche
         centre := i/pas-j; // distance / centre
         for v := 0 to pred(l) do
             valeurC[v] := 0;
         for k := -MaxFiltre to MaxFiltre do begin
             jk := j+k;
             if jk<0 then continue;
             if jk>=oldNmes then break;
             coeff := sinc(pi*(centre-k));
             for v := 0 to pred(l) do
                 valeurC[v] := valeurC[v]+tampon[v,jk]*coeff;
         end;
         for v := 0 to pred(l) do
             valeurVar[indexLoc[v],i] := valeurC[v];
     end;
     for v := 0 to pred(l) do
         finalize(tampon[v]);
end end; // calculSinc

var  i,j,k : integer;
     v0,dv : double;
     tampon : Tvecteur;
begin with pages[PageCourante] do begin
    oldNmes := nmes;
    nmes := NewNmes;
    pas := newNmes/oldNmes;
    k := 1;
    dv := 1;
    copyVecteur(tampon,valeurVar[0]);
    for i := 0 to (oldNmes-2) do begin
        v0 := tampon[i];
        dv := (tampon[succ(i)]-v0)/pas;
        for j := 1 to floor(pas) do begin
            valeurVar[0,k] := v0+j*dv;
            inc(k);
        end;
    end;
    v0 := tampon[pred(oldNmes)];
    for j := 1 to floor(pas) do begin
        valeurVar[0,k] := v0+j*dv;
        inc(k);
    end;
    kmax := k;
    pas := kmax/oldNmes;
    CalculSinc;
    nmes := kmax;
end end; // SurEchantillon 

procedure TPageEchantillonDlg.NmesSpinDownClick(Sender: TObject);
begin
     NmesSpinClick(true)
end;

procedure TPageEchantillonDlg.NmesSpinUpClick(Sender: TObject);
begin
     NmesSpinClick(false)
end;

procedure TPageEchantillonDlg.NmesSpinClick(Down : boolean);
var Lnombre,NewNombre : integer;
begin
     LNombre := StrToInt(NewNmesEdit.Text);
     if Down
        then begin
           NewNombre := puiss2Inf(LNombre);
           if NewNombre=LNombre then newNombre := NewNombre div 2;
           if NewNombre<16 then newNombre := 16;
        end
        else begin
           NewNombre := puiss2Sup(LNombre);
           if NewNombre=LNombre then NewNombre := 2*NewNombre;
           if newNombre>MaxMaxVecteur then newNombre := MaxMaxVecteur;
        end;
     NewNmesEdit.Text := IntToStr(NewNombre);
     MajCB;
end;

procedure TPageEchantillonDlg.MajCB;
var oldNbre : integer;
begin
     NmesSpin.visible := not UnsurNCB.checked;
     NewNmesEdit.enabled := not UnsurNCB.checked;
     UnSurNSE.visible := UnSurNCB.checked;
     oldNbre := StrToInt(OldNmesEdit.Text);
     if unSurNCB.checked then NewNmesEdit.text :=
         IntToStr(oldNbre div UnsurNSE.value);
end;

procedure TPageEchantillonDlg.UnsurNCBClick(Sender: TObject);
begin
    MajCB
end;

procedure TPageEchantillonDlg.UnSurNSEChange(Sender: TObject);
begin
    MajCB
end;

end.
