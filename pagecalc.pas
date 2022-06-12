unit pagecalc;

interface

uses Windows, Classes, Graphics, Forms, Controls, Buttons,
   StdCtrls, ExtCtrls, Dialogs, SysUtils,
   vcl.HtmlHelpViewer,
   constreg, maths, regutil, compile, filerrr, aidekey;

type
   TPageCalcDlg = class(TForm)
      OKBtn:         TBitBtn;
      CancelBtn:     TBitBtn;
      HelpBtn:       TBitBtn;
      CalculRG:      TRadioGroup;
      GroupBox:      TGroupBox;
      EditExp:       TEdit;
      LabelFonction: TLabel;
      VariabExpGB:   TGroupBox;
      EditFixe:      TLabel;
      Label1:        TLabel;
      procedure OKBtnClick(Sender: TObject);
      procedure HelpBtnClick(Sender: TObject);
      procedure CalculRGClick(Sender: TObject);
      procedure FormActivate(Sender: TObject);
      procedure CancelBtnClick(Sender: TObject);
   private
      dependPage: array[TcodePage] of boolean;
      function compileExp: boolean;
   public
   end;

var
   PageCalcDlg: TPageCalcDlg;

implementation

type
   EcompileError = class(Exception);

{$R *.DFM}

function TpageCalcDlg.CompileExp: boolean;

   procedure chercheDependPage(ff: Pelement);
   var
      numeroPage: integer;
   begin
      with FF^ do
         case typeElement of
            operateur: begin
               chercheDependPage(operG);
               chercheDependPage(operD);
            end;
            fonction: chercheDependPage(operand);
            fonctionGlb: if codeFglb = fonctionPage then begin
                  numeroPage := round(OperandGlb.valeur);
                  if (numeroPage > 0) and
                     (numeroPage <= NbrePages) then
                     dependPage[numeroPage] := True;
               end
               else if OperandGlb <> nil then
                  chercheDependPage(operandGlb);
            ifThenElse: begin
               chercheDependPage(positif);
               chercheDependPage(negatif);
               chercheDependPage(test);
            end;
            else;
         end;{case}
   end;

var
   posVirgule: integer;
   texte: String;
   posErreur, LongErreur, i: integer;
begin // compileExp
   texte := AnsiLowerCase(EditExp.Text);
   trimComplet(texte);
   posVirgule := pos(',', texte);
   while posVirgule > 0 do
   begin
      texte[posVirgule] := '.';
      posVirgule := pos(',', texte);
   end;
   Grandeurs[cPage].fonct.expression := EditExp.Text;
   Result := Grandeurs[cPage].compileG(posErreur, LongErreur, 0);
   if not Result then
      afficheErreur(codeErreurC, 0);
   for i := 1 to NbrePages do
      dependPage[i] := False;
   if Result then
      chercheDependPage(grandeurs[cPage].fonct.calcul);
end; // compileExp

procedure TPageCalcDlg.OKBtnClick(Sender: TObject);
var
   mini, maxi: double;
   NbrePagesExp: integer;
   Yinter:  array[TcodePage] of Tvecteur;
   IndiceInter: array[TcodePage] of TvecteurInt;
   pageMax: TcodePage;

   procedure calculeY;
   var
      index: integer;
      p: TcodePage;

      procedure InterpoleLineaire;
      var
         t: double;
         i, i1, i2: integer;
         X, Y: Tvecteur;
      begin
         X := pages[p].valeurVar[0];
         Y := pages[p].valeurVar[index];
         for i := 0 to pred(pages[NbrePages].nmes) do begin
            t  := pages[NbrePages].valeurVar[0, i];
            i2 := indiceInter[p, i];
            if i2 = 0 then
               Yinter[p, i] := y[i2]
            else begin
               i1 := i2 - 1;
               try
                  Yinter[p, i] := y[i2] + (t - x[i2]) * (Y[i2] - Y[i1]) / (x[i2] - x[i1]);
               except
                  Yinter[p, i] := y[i2];
               end;
            end;
            pages[p].valeurCourante[index] := Yinter[p, i];
         end; { for i }
      end; { CalculIntLineaire }

   var
      commun: double;
      IndicePremierePage: integer;
      i, j, iDebut, iFin: integer;
      g: integer;
      z, z2: double;
   begin // calculeY
       with pages[NbrePages] do begin
         IndicePremierePage := 0;
         for p := 1 to pred(NbrePages) do
            if dependPage[p] then
            begin
               if IndicePremierePage = 0 then
                  IndicePremierePage := p;
               setLength(indiceInter[p], NmesMax + 1);
            end;
         if indicePremierePage > 0 then begin
            iDebut := 0;
            while pages[indicePremierePage].valeurVar[0, iDebut] < mini do
               Inc(iDebut);
            iFin := pred(pages[indicePremierePage].nmes);
            while pages[indicePremierePage].valeurVar[0, iFin] > maxi do
               Dec(iFin);
            nmes := iFin - iDebut + 1;
            for i := 0 to pred(nmes) do begin
               commun := pages[indicePremierePage].valeurVar[0, iDebut + i];
               valeurVar[0, i] := commun;
               indiceInter[indicePremierePage, i] := iDebut + i;
               for p := 1 to pred(NbrePages) do
                  if (p > indicePremierePage) and dependPage[p] then begin
                     if i = 0
                        then j := 0
                        else j := indiceInter[p, pred(i)];
                     while pages[p].valeurVar[0, j] < commun do
                        Inc(j);
                     indiceInter[p, i] := j;
                  end;
            end;
         end;
         for g := 1 to pred(NbreVariabExp) do begin
            index := indexVariab[g];
            for p := 1 to pred(NbrePages) do
               if dependPage[p] then
                  InterpoleLineaire;
            for i := 0 to pred(nmes) do begin
               z2 := 0;
               case calculRG.ItemIndex of
                  2: z := -maxReal;
                  3: z := maxReal;
                  else z := 0;
               end;
               for p := 1 to pred(NbrePages) do
                  if dependPage[p] then
                     case calculRG.ItemIndex of
                        0, 1: z := z + Yinter[p, i];
                        2: if Yinter[p, i] > z then
                              z := Yinter[p, i];
                        3: if Yinter[p, i] < z then
                              z := Yinter[p, i];
                        4: begin
                           z  := z + Yinter[p, i];
                           z2 := z2 + sqr(Yinter[p, i]);
                        end;
                        5: Grandeurs[cPage].valeur[p] := Yinter[p, i];
                     end;
               case calculRG.ItemIndex of
                  1: z := z / NbrePagesExp;
                  4: z := sqrt((z2 - sqr(z) / NbrePagesExp) / pred(NbrePagesExp));
                  5: z := calcule(Grandeurs[cPage].fonct.calcul);
               end;
               valeurVar[index, i] := z;
            end;
         end;
         for p := 1 to pred(NbrePages) do
            if dependPage[p] then
               finalize(indiceInter[p]);
      end;
   end; { calculeY }

var
   p: TcodePage;
label
   fin;
begin
   FonctionPagePermise := True;
   case calculRG.ItemIndex of
      5: if not compileExp then begin
            ModalResult := mrNone;
            exit;
         end;
      else
         for p := 1 to NbrePages do
            dependPage[p] := pages[p].experimentale;
   end;
   pageMax := 1;
   for p := 1 to nbrePages do
      if dependPage[p] then begin
         pages[p].tri;
         PageMax := p;
      end;
   mini := -maxReal;
   maxi := maxReal;
   NbrePagesExp := 0;
   for p := 1 to nbrePages do
      if dependPage[p] then
         with pages[p] do begin
            setLength(Yinter[p], NmesMax + 1);
            if valeurVar[0, 0] > mini then
               mini := valeurVar[0, 0];
            if valeurVar[0, pred(nmes)] < maxi then
               maxi := valeurVar[0, pred(nmes)];
            Inc(NbrePagesExp);
         end;
   if maxi < mini then begin // pas de zone commune
      afficheErreur(erPageCalc, 0);
      goto fin;
   end;
   if not AjoutePage then
      goto fin;
   with pages[nbrePages] do begin
      experimentale := False;
      calculeY;
      case calculRG.ItemIndex of
         5: commentaireP := editExp.Text;
         else
            commentaireP := calculRG.items[calculRG.ItemIndex] +
               '(1..' + IntToStr(pageMax) + ')';
      end;
   end;
   pages[NbrePages].recalculP;
   Application.MainForm.Perform(WM_Reg_Maj, MajAjoutPage, 0);
   ModifFichier := True;
   fin:
      for p := 1 to pred(nbrePages) do
         if dependPage[p] then
            finalize(Yinter[p]);
   FonctionPagePermise := False;
end;

procedure TPageCalcDlg.HelpBtnClick(Sender: TObject);
begin
   Aide(HELP_PageCalculee);
end;

procedure TPageCalcDlg.CalculRGClick(Sender: TObject);
begin
   GroupBox.Visible := CalculRG.ItemIndex = 5;
end;

procedure TPageCalcDlg.FormActivate(Sender: TObject);
begin
   inherited;
   GroupBox.Visible := CalculRG.ItemIndex = 5;
   EditFixe.Caption := grandeurs[0].nom;
   EditExp.Text := '';
end;

procedure TPageCalcDlg.CancelBtnClick(Sender: TObject);
begin
   FonctionPagePermise := False;
end;

end.

