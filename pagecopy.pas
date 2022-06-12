unit pagecopy;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls,Dialogs, sysutils, Spin,
  vcl.HtmlHelpViewer,
  constreg, math, maths, regutil, fft, compile, uniteker, filerrr, aidekey;

type
  TPageCopyDlg = class(TForm)
    LabelY: TLabel;
    LabelX: TLabel;
    NumPageLabel: TLabel;
    EditX: TEdit;
    EditY: TEdit;
    PageSE: TSpinEdit;
    BoutonsPanel: TPanel;
    HelpBtn: TBitBtn;
    CancelBtn: TBitBtn;
    OKBtn: TBitBtn;
    OptionsGB: TGroupBox;
    Label2: TLabel;
    NmesSpin: TSpinButton;
    NewNmesEdit: TEdit;
    OldNmesEdit: TEdit;
    Label1: TLabel;
    UnsurNSE: TSpinEdit;
    UnsurNCB: TCheckBox;
    NbrePageSE: TSpinEdit;
    Label3: TLabel;
    procedure OKBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure NmesSpinDownClick(Sender: TObject);
    procedure NmesSpinUpClick(Sender: TObject);
    procedure PageSEChange(Sender: TObject);
    procedure UnsurNCBClick(Sender: TObject);
    procedure UnsurNSEChange(Sender: TObject);
  private
    indexX,indexY : integer;
    pageCopiee : TcodePage;
    newNmes : integer;
    Procedure AjusteNombre;
    Procedure UnPointSurN;
    Procedure SurEchantillon;
    Procedure NmesSpinClick(Down : boolean);
    procedure MajCB;
  public
  end;

var
  PageCopyDlg: TPageCopyDlg;

implementation

{$R *.DFM}

procedure TPageCopyDlg.OKBtnClick(Sender: TObject);
var i : integer;
    grandeurX,grandeurY : tGrandeur;
    index,g,j : integer;
    posErreur,longErreur : integer;
    co : double;
begin
     PageCopiee := PageSE.value;
     GrandeurX := Tgrandeur.create;
     GrandeurX.fonct.expression := editX.text;
     if GrandeurX.compileG(posErreur,longErreur,0)
        then begin
           GrandeurY := tgrandeur.create;
           GrandeurY.fonct.expression := editY.text;
           if not GrandeurY.compileG(posErreur,longErreur,0)
              then begin
                 afficheErreur(codeErreurC,0);
                 ModalResult := mrNone;
                 EditY.setFocus;
                 EditY.selStart := pred(posErreur);
                 EditY.selLength := longErreur;
                 GrandeurX.free;
                 GrandeurY.free;
                 exit;
              end;
        end
        else begin
          afficheErreur(codeErreurC,0);
          ModalResult := mrNone;
          EditX.setFocus;
          EditX.selStart := pred(posErreur);
          EditX.selLength := longErreur;
          GrandeurX.free;
          exit;
        end;
     for j := 1 to NbrePageSE.value do begin
         if not AjoutePage then exit;
         with pages[nbrePages] do begin
           pageCourante := pageCopiee;
           nmes := pages[pageCopiee].nmes;
           pages[pageCopiee].affecteVariableP(false);
           for i := 0 to pred(nmes) do begin
              affecteVariableE(i);
              valeurVar[indexX,i] := calcule(GrandeurX.fonct.calcul);
              valeurVar[indexY,i] := calcule(GrandeurY.fonct.calcul);
              for g := 2 to pred(NbreVariabExp) do begin
                 index := indexVariab[g];
                 valeurVar[index,i] := pages[pageCopiee].valeurVar[index,i];
              end;
           end;
           if uniteSIGlb then begin
              if (grandeurs[indexX].uniteImposee) and (grandeurs[indexX].coeffSI<>1) then begin
                 co := grandeurs[indexX].coeffSI;
                 for i := 0 to pred(nmes) do
                     valeurVar[indexX,i] := valeurVar[indexX,i]/co;
              end;
              if (grandeurs[indexY].uniteImposee) and (grandeurs[indexY].coeffSI<>1) then begin
                 co := grandeurs[indexY].coeffSI;
                 for i := 0 to pred(nmes) do
                     valeurVar[indexY,i] := valeurVar[indexY,i]/co;
              end;
           end;
           for g := 0 to pred(NbreConst) do begin
              index := indexConst[g];
              valeurConst[index] := pages[pageCopiee].valeurConst[index];
           end;
           NewNmes := StrToInt(NewNmesEdit.Text);
           if NewNmes>maxMaxVecteur then NewNmes := maxMaxVecteur;
           if newNmes<nmes
             then if UnSurNCB.checked
                 then UnPointSurN
                 else AjusteNombre
             else if newNmes>nmes then SurEchantillon;
           recalculP;
           commentaireP := stCopiePage+
              intToStr(PageCopiee)+' : '+
              LabelX.caption+GrandeurX.fonct.expression+' '+
              LabelY.caption+GrandeurY.fonct.expression;
        end;      
     end;
     pageCourante := NbrePages;
     Application.MainForm.perform(WM_Reg_Maj,MajAjoutPage,0);
     ModifFichier := true;
     if assigned(grandeurY) then GrandeurY.free;
     if assigned(grandeurX) then GrandeurX.free;
end;

procedure TPageCopyDlg.HelpBtnClick(Sender: TObject);
begin
     Aide(HELP_PageCopiee)
end;

procedure TPageCopyDlg.FormActivate(Sender: TObject);
begin
       inherited;
       indexY := indexVariab[1];
       EditY.text := grandeurs[indexY].nom;
       indexX := indexVariab[0];
       EditX.text := grandeurs[indexX].nom;
       LabelY.caption :=  grandeurs[indexY].nom+'=';
       LabelX.caption :=  grandeurs[indexX].nom+'=';
       PageSE.MaxValue := NbrePages;
       PageSE.Value := 1;
       PageSE.visible := NbrePages>1;
       NumPageLabel.visible := NbrePages>1;
       NewNmesEdit.text := IntToStr(pages[1].nmes);
       OldNmesEdit.text := IntToStr(pages[1].nmes);
       MajCB;
end;

Procedure TPageCopyDlg.AjusteNombre;
var
    j : integer;
    voie : integer;
    Coeff : array[TcodeGrandeur] of double;
    VarOK : array[TcodeGrandeur] of boolean;
    oldValeurVar : array[TcodeGrandeur] of Tvecteur;

Procedure Recopie(j : integer);
var voie : integer;
begin with pages[nbrePages] do begin
    Nmes := Nmes+1;
    for voie := 0 to pred(NbreGrandeurs) do
        if varOK[voie] then valeurVar[voie,Nmes] := oldValeurVar[voie,j];
end end;

var maxi,mini : double;
    oldNmes,pas : integer;
begin with pages[NbrePages] do begin
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

Procedure TPageCopyDlg.UnPointSurN;
var j,N : integer;
    voie : integer;
    VarOK : array[TcodeGrandeur] of boolean;
begin with pages[NbrePages] do begin
   for voie := 0 to pred(NbreGrandeurs) do with grandeurs[voie] do
       varOK[voie] := (genreG=variable) and
                      (fonct.genreC=g_experimentale);
   N := UnsurNSE.value;
   Nmes := Nmes div N;
   for voie := 0 to pred(NbreGrandeurs) do if varOK[voie] then
       for j := 1 to pred(nmes) do
           valeurVar[voie,j] := ValeurVar[voie,j*N];
end end; { UnPointSurN }

Procedure TPageCopyDlg.SurEchantillon;
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
begin with pages[NbrePages] do begin
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
end end;

var  i,j,k : integer;
     v0,dv : double;
     tampon : Tvecteur;
begin with pages[NbrePages] do begin
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

procedure TPageCopyDlg.NmesSpinDownClick(Sender: TObject);
begin
     NmesSpinClick(true)
end;

procedure TPageCopyDlg.NmesSpinUpClick(Sender: TObject);
begin
     NmesSpinClick(false)
end;

procedure TPageCopyDlg.NmesSpinClick(Down : boolean);
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

procedure TPageCopyDlg.MajCB;
var oldNbre : integer;
begin
     NmesSpin.visible := not UnsurNCB.checked;
     NewNmesEdit.enabled := not UnsurNCB.checked;
     UnSurNSE.visible := UnSurNCB.checked;
     oldNbre := StrToInt(OldNmesEdit.Text);
     if unSurNCB.checked then NewNmesEdit.text :=
         IntToStr(oldNbre div UnsurNSE.value);
end;

procedure TPageCopyDlg.PageSEChange(Sender: TObject);
begin
     OldNmesEdit.text := IntToStr(pages[pageSE.value].nmes);
     MajCB;
end;

procedure TPageCopyDlg.UnsurNCBClick(Sender: TObject);
begin
    MajCB
end;

procedure TPageCopyDlg.UnSurNSEChange(Sender: TObject);
begin
    MajCB
end;

end.
