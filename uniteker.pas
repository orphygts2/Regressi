unit uniteker;

interface

uses Math, SysUtils, constreg, regutil, maths;

type
   TuniteDeBase = (_metre,_kilogramme,_seconde,_ampere,_kelvin,_mole,_candela);

   EUniteError = class(Exception);
   TuniteSansDim = (tuVide, tuDegre, tuRadian, tuDecibel, tuTour, tuPourCent);
   TunitePart = (_jour,_heure,_minute,_tour,_degre,_ua);

   Tunite = class
   private
      FnomUnite: string;
      procedure SetNomUnite(const nu: string);
   protected
   public
      Dimension:     array[TuniteDeBase] of shortInt;
      puissance:     shortInt;
      coeffSI:       double;
      sansDim:       TuniteSansDim;
      nom:           string;
      PuissAff:      shortInt;
      CoeffAff:      double;
      Correct:       boolean;
      Adaptable:     boolean;
      UniteDonnee:   boolean; // donn�e par l'utilisateur
      UnitePart:     boolean; // ua jour ...
      UniteImposee:  boolean; // Prefixe impose ou non SI ex: heure, bar
      FormatU:       TnombreFormat;
      PrecisionU:    integer;
      DimensionPart:  array[TunitePart] of shortInt;
      isCelsius :    boolean;
      FnomComplet :  string;
      UniteGrapheImposee:  boolean;
      UniteGraphe :  string;
      property nomUnite: string Read FnomUnite Write setNomUnite;
      constructor Create;
      procedure setUniteComplet(const nu,nc: string;
         p: shortint; d1, d2, d3, d4, d5, d6, d7: shortint);
      procedure Init;
      procedure RecopieUnite(U: Tunite);
      procedure Assign(U: Tunite);
      function NomAff(puissValeur: shortInt): string;
      procedure MulUnite(op: char; U0: Tunite; puiss: shortInt);
      procedure AdUnite(op: char; Ug, Ud: Tunite);
      procedure PlusUnite(U0: Tunite);
      procedure MoinsUnite(U0: Tunite);
      procedure InverseUnite;
      procedure PuissUnite(op: char; puiss: shortint);
      procedure VerifUniteEgale(u1, u2: Tunite);
      function UniteEgale(U: Tunite): boolean;
      function UniteAxe(exposant: double): string;
      procedure UniteDerivee(ux, uy: Tunite; gx, gy: Tgraduation);
      procedure setErreurUnite;
      procedure setRadianDegre;
      function formatNomEtUnite(const Anombre: double): string;
      function formatNomPrecisionUnite(const Anombre,U95: double): string;
      function formatValeurEtUnite(const Anombre: double): string;
      function formatNombre(const Anombre: double): string;
      function formatIncert(const Anombre: double): string;
      procedure VerifTaux(grandeurY, grandeurX: Tunite);
// si unite=uniteY/uniteX forcer l'unit� � uniteY/uniteX
      function FormatNomPente(x: double): string;
      function FormatNomPenteUnite(x: double): string;
      function FormatValeurPente(x: double): string;
      procedure assignAngle;
      function isAngle : boolean;
      procedure imposeNomUnite(const nu : string);
      function nomIncertitude : string;
      function PbUnite : boolean;
   end;

const
   NbreUniteToleree = 15;
   IndexRadian      = 2;
   IndexDegre       = 6;

var
   UniteToleree: array[1..NbreUniteToleree] of Tunite;
   UniteNulle:   Tunite;
   UniteSIglb:   boolean = False;

function UnitesEgales(u1, u2: Tunite): boolean;

implementation

const
    SymbolePart: array[TunitePart] of string =
      ('j','h','min','tr','�','ua');
  //  NomUnitePart: array[TunitePart] of string = ('jour','heure','minute','tour','degr�','ua');
    NomBase: array[TuniteDeBase] of string =
      ('m', 'kg', 's', 'A', 'K', 'mol', 'cd');
    SymboleSansDim: array[TuniteSansDim] of string =
      ('', '�', 'rad', 'dB', 'tr', '%');
    caracDebutUnite: TSysCharSet =
      ['b', 'c', 'd', 'g', 'h', 'l', 'm', 'r', 's', 't',
       'A', 'C', 'F', 'H', 'J', 'K', 'L', 'N', 'P', 'S', 'T', 'V', 'W', '�'];
    NbreUniteConnue  = 35;
    Digits : array[0..$F] of Char = '0123456789ABCDEF';
    IndexCelsius     = 3;
    indexKelvin      = 4;

var
    UniteConnue:  array[1..NbreUniteConnue] of Tunite;

procedure Tunite.assignAngle;
begin
   if angleEnDegre
      then Assign(uniteToleree[indexDegre])
      else Assign(uniteToleree[indexRadian]);
end;

function Tunite.isAngle : boolean;
var i: TuniteDeBase;
begin
   result := sansDim in [tuDegre,tuRadian];
   if not result then begin
      result := true;
      for i := _Metre to _Candela do
          result := result and (dimension[i]=0);
   end;
end;

procedure Tunite.InverseUnite;
var
   i: TuniteDeBase;
   j: TUnitePart;
begin
   if not correct then exit;
   puissance := -puissance;
   for i := _Metre to _Candela do
      dimension[i] := -dimension[i];
   for j := low(TunitePart) to high(TunitePart) do
      dimensionPart[j] := -dimensionPart[j];
   sansDim := tuVide;
   coeffSI := dix(puissance);
end; // InverseUnite

procedure Tunite.PlusUnite(U0: Tunite);
var
   i: TuniteDeBase;
   j: TUnitePart;
begin
   correct := correct and U0.correct;
   if not correct then
      exit;
   puissance := puissance + U0.puissance;
   for i := _Metre to _Candela do
      dimension[i] := dimension[i] + U0.dimension[i];
   if U0.sansDim <> tuVide then
      if sansDim = tuVide
         then sansDim := U0.sansDim
         else sansDim := tuVide;
   Adaptable := Adaptable or U0.Adaptable;
   for j := low(TunitePart) to high(TunitePart) do
      dimensionPart[j] := dimensionPart[j] + U0.dimensionPart[j];
   coeffSI := dix(puissance);
end; // PlusUnite

procedure Tunite.MoinsUnite(U0: Tunite);
var
   i: TuniteDeBase;
   j: TunitePart;
begin
   correct := correct and U0.correct;
   if not correct then exit;
   puissance := puissance - U0.puissance;
   for i := _Metre to _Candela do
      dimension[i] := dimension[i] - U0.dimension[i];
   Adaptable := Adaptable or U0.Adaptable;
   if U0.sansDim <> tuVide then
      sansDim := tuVide;
   for j := low(TunitePart) to high(TunitePart) do
       dimensionPart[j] := dimensionPart[j] - U0.dimensionPart[j];
   coeffSI := dix(puissance);
end; // MoinsUnite

procedure Tunite.AdUnite(op: char; Ug, Ud: Tunite);
// TODO : Prise en compte des unit�s tol�r�es
var
   i: TuniteDeBase;
   j: TunitePart;
begin
   correct := Ug.correct and Ud.correct;
   coeffSI := 1;
   if not correct then exit;
   sansDim := tuVide;
   case op of
      '+': begin
         puissance := Ug.puissance + Ud.puissance;
         for i := _Metre to _Candela do
            dimension[i] := Ug.dimension[i] + Ud.dimension[i];
         for j := low(TunitePart) to high(TunitePart) do
            dimensionPart[j] := Ug.dimensionPart[j] + Ud.dimensionPart[j];
         if (Ug.sansDim <> tuVide) and (Ud.sansDim = tuVide) then
            sansDim := Ug.sansDim;
         if (Ud.sansDim <> tuVide) and (Ug.sansDim = tuVide) then
            sansDim := Ud.sansDim;
      end;
      '-': begin
         puissance := Ug.puissance - Ud.puissance;
         for i := _Metre to _Candela do
            dimension[i] := Ug.dimension[i] - Ud.dimension[i];
         for j := low(TunitePart) to high(TunitePart) do
            dimensionPart[j] := Ug.dimensionPart[j] - Ud.dimensionPart[j];
         if Ud.sansDim = tuVide then
            sansDim := Ug.sansDim;
      end;
   end;
   Adaptable := Ud.Adaptable or Ug.Adaptable;
   UniteImposee := False;
   coeffSI := dix(puissance);
end; // AdUnite

procedure Tunite.PuissUnite(op: char; puiss: shortint);
var
   i: TuniteDeBase;
   j: TunitePart;
begin
   if not (correct) then
      exit;
   if Puiss <> 1 then
      sansDim := tuVide;
   case op of
      '*': begin
         puissance := puissance * puiss;
         for i := _Metre to _Candela do
            dimension[i] := dimension[i] * puiss;
         for j := low(TunitePart) to high(TunitePart) do
            dimensionPart[j] := dimensionPart[j]*puiss;
      end;
      '/': begin
         if (puissance mod puiss <> 0) then
            setErreurUnite;
         puissance := puissance div puiss;
         for i := _Metre to _Candela do begin
            if (dimension[i] mod puiss <> 0) then
               setErreurUnite;
            dimension[i] := dimension[i] div puiss;
         end;
         for j := low(TunitePart) to high(TunitePart) do
             dimensionPart[j] := dimensionPart[j] div puiss;
      end;
   end; { case }
   coeffSI := dix(puissance);
end; // PuissUnite

procedure Tunite.MulUnite(op: char; U0: Tunite; puiss: shortint);
var
   i: TuniteDeBase;
   j: TunitePart;
begin
   correct := correct and U0.correct;
   if not (correct) then
      exit;
   if puiss <> 1 then
      sansDim := tuVide;
   case op of
      '*': begin
         puissance := U0.Puissance * puiss;
         for i := _Metre to _Candela do
            dimension[i] := U0.dimension[i] * puiss;
        for j := low(TunitePart) to high(TunitePart) do
            dimensionPart[j] := U0.dimensionPart[j] * puiss;
      end;
      '/': begin
         if (U0.puissance mod puiss <> 0) then
            setErreurUnite;
         puissance := U0.Puissance div puiss;
         for i := _Metre to _Candela do begin
            if (U0.dimension[i] mod puiss <> 0) then
               setErreurUnite;
            dimension[i] := U0.dimension[i] div puiss;
         end;
         for j := low(TunitePart) to high(TunitePart) do begin
             if (U0.dimensionPart[j] mod puiss <> 0) then
                 setErreurUnite;
             dimensionPart[j] := U0.dimensionPart[j] div puiss;
         end;
      end;
   end; { case }
   adaptable := adaptable or U0.adaptable;
   coeffSI := dix(puissance);
end; // MulUnite

procedure Tunite.SetNomUnite(const nu: string);
// Pour les unit�s dont le nomUnite est impos� par l'utilisateur
var
   Ucourant: Tunite;
   Inverse:  boolean;
   LongUnite: integer;

   procedure AnalysePrefixe(var index: integer);
   begin
      if FnomUnite[index] = '/' then begin
         Inc(index);
         inverse := True;
      end;
      if (index < LongUnite) and
         (charInSet(FnomUnite[index],caracPrefixe) or
           (FnomUnite[index]=mu)) and
         (charInSet(FnomUnite[succ(index)],caracDebutUnite) or
           (FnomUnite[succ(index)]=OmegaMaj)) then begin
         case FnomUnite[index] of
            'a': Ucourant.puissance  := -18;
            'f': Ucourant.puissance  := -15;
            'p': Ucourant.puissance  := -12;
            'n': Ucourant.puissance  := -9;
            '�': Ucourant.puissance := -6;
            mu: Ucourant.puissance := -6;
            'm': Ucourant.puissance  := -3;
            'c': Ucourant.puissance  := -2;
            'd': Ucourant.puissance  := -1;
            'h': Ucourant.puissance  := +2;
            'k': Ucourant.puissance  := +3;
            'M': Ucourant.puissance  := +6;
            'G': Ucourant.puissance  := +9;
            'T': Ucourant.puissance  := +12;
            'P': Ucourant.puissance  := +15;
            'E': Ucourant.puissance  := +18;
         end;
         Ucourant.coeffSI := dix(Ucourant.puissance);
         Inc(index);
      end;
   end; // AnalysePrefixe

   procedure AnalyseCode(var index: integer);
   var
      trouve: boolean;
      j: integer;
      nomCourant: string;
      indexInit: integer;

      procedure OubliSeparateur;
      var
         j:  integer;
         UU: Tunite;
      begin
         index := indexInit;
         nomCourant := '';
         repeat
            nomCourant := nomCourant + FnomUnite[index];
            Inc(index);
            for j := 1 to NbreUniteConnue do begin
               UU := UniteConnue[j];
               trouve := nomCourant = UU.FnomUnite;
               if trouve then begin
                  Ucourant.PlusUnite(UU);
                  exit;
               end;
            end;
            for j := 1 to NbreUniteToleree do begin
               UU := UniteToleree[j];
               trouve := nomCourant = UU.FnomUnite;
               if trouve then begin
                  Ucourant.PlusUnite(UU);
                  exit;
               end;
            end;
         until (index > LongUnite) or
               not charInSet(FnomUnite[index],Majuscule + Minuscule);
      end; // OubliSeparateur

   var
      UU: Tunite;
   begin // AnalyseCode
      nomCourant := '';
      indexInit  := index;
      repeat
         nomCourant := nomCourant + FnomUnite[index];
         Inc(index);
      until (index > longUnite) or
            not charInSet(FnomUnite[index],Majuscule + Minuscule);
      for j := 1 to NbreUniteConnue do begin
         UU := UniteConnue[j];
         trouve := nomCourant = UU.FnomUnite;
         if trouve then begin
            Ucourant.PlusUnite(UU);
            exit;
         end;
      end;
      for j := 1 to NbreUniteToleree do begin
         UU := UniteToleree[j];
         trouve := nomCourant = UU.FnomUnite;
         if trouve then begin
            Ucourant.PlusUnite(UU);
            exit;
         end;
      end;
      oubliSeparateur;
      if not Trouve and (FnomUnite <> '') then
         setErreurUnite;
   end; // AnalyseCode

   procedure AnalyseSuffixe(var index: integer);
   var
      negatif, kilogramme: boolean;
      z: shortint;
      i: TuniteDeBase;
      numero : integer;
      caracCourant : char;
   begin
      if index > longUnite then begin
         if inverse then
            Ucourant.inverseUnite;
         exit;
      end;
      if FnomUnite[index] = '^' then begin
         Inc(index);
         if (index > LongUnite) then
            setErreurUnite;
      end;
      negatif := False;
      caracCourant := FnomUnite[index];
      if (caracCourant='-') or
         (caracCourant='+') or
         (caracCourant=moinsExp) or
         (caracCourant=plusExp) then begin
         negatif := (caracCourant='-') or (caracCourant=moinsExp);
         if caracCourant = '-' then
            FnomUnite[index] := moinsExp;
         if caracCourant = '+' then
            FnomUnite[index] := plusExp;
         Inc(index);
         if (index > LongUnite) then
            setErreurUnite;
      end;
      kilogramme := True;
      for i := _Metre to _Candela do
         if i = _kilogramme
            then kilogramme := kilogramme and (Ucourant.dimension[_kilogramme] <> 0)
            else kilogramme := kilogramme and (Ucourant.dimension[i] = 0);
      if charInSet(FnomUnite[index],chiffre) then begin
         numero := strToInt(FnomUnite[index]);
         FnomUnite[index] := chiffreExp[numero];
      end;
      if (pos(FnomUnite[index],chiffreExpStr)>0) then begin
         z := caracToChiffre(FnomUnite[index]);
         if negatif then z := -z;
         Inc(index);
      end
      else
         z := 1;
      if inverse then
         z := -z;
      Ucourant.MulUnite('*', Ucourant, z);
   end; // AnalyseSuffixe

var
   i: TuniteDeBase;
   index, j : integer;
   stValeur: string;
   k: TunitePart;
begin // SetNomUnite
   try // Erreur Unite
      if nu='d:m:s'
         then FnomUnite := '�'
         else FnomUnite := nu;
      UniteImposee := False;
      coeffSI := 1;
      index := pos(' ', FnomUnite);
      while index > 0 do begin
         Delete(FnomUnite, index, 1);
         index := pos(' ', FnomUnite);
      end;
      puissance := 0;
      correct := True;
      for k := low(TunitePart) to high(TunitePart) do
         dimensionPart[k] := 0;
      for i := _Metre to _Candela do
         dimension[i] := 0;
      longUnite := Length(FnomUnite);
      sansDim := tuVide;
      UniteDonnee := longUnite>0;
      if not UniteDonnee then exit;
      for j := 1 to NbreUniteConnue do begin
         Ucourant := UniteConnue[j];
         if FnomUnite = Ucourant.FnomUnite then begin
            RecopieUnite(Ucourant);
            exit;
         end;
         if (Ucourant.FnomComplet<>'') and
            (AnsiLowerCase(FnomUnite) = Ucourant.FnomComplet) then begin
            RecopieUnite(Ucourant);
            exit;
         end;
      end;
      for j := 1 to NbreUniteToleree do begin
         Ucourant := UniteToleree[j];
         if FnomUnite = Ucourant.FnomUnite then begin
            RecopieUnite(Ucourant);
            exit;
         end;
      end;
      index := 1;
      inverse := False;
      if Pos('1E', FnomUnite) = 1 then begin
         index := 3;
         while (index < LongUnite) and
            charInSet(FnomUnite[index],Chiffre + ['-', '+']) do
            Inc(index);
         if index > 3 then begin
            stValeur := copy(FnomUnite, 1, pred(index));
            puissance := StrToInt(StValeur);
            coeffSI := dix(puissance);
         end;
         if FnomUnite[index] = ' ' then
            Inc(index);
      end; { 1E+xx }
      Ucourant := Tunite.Create;
      try
      while (index <= LongUnite) do begin
         Ucourant.init;
         AnalysePrefixe(index);
         AnalyseCode(index);
         AnalyseSuffixe(index);
         PlusUnite(Ucourant);
         if (index < LongUnite) and
            charInSet(FnomUnite[index],['.', '*',' ']) then
            Inc(index); // s�parateur type multiplicateur
      end;
      finally
        Ucourant.Free;
      end;
      for j := 1 to NbreUniteConnue do begin
         Ucourant := UniteConnue[j];
         if uniteEgale(Ucourant) then begin
            UniteImposee := (FnomUnite <> Ucourant.FnomUnite) and
                            (FnomUnite <> 'kg');
            exit;
         end;
      end;
      for j := 1 to NbreUniteToleree do begin
         Ucourant := UniteToleree[j];
         if uniteEgale(Ucourant) then begin
            UniteImposee  := (FnomUnite <> Ucourant.FnomUnite);
            exit;
         end;
      end;
   except
      on EUniteError do begin
         correct := False;
         puissance := 0;
         coeffSI := 1;
      end;
   end;
end;// SetNomUnite

function AjoutePuissDix(const nom: string; puiss: shortInt): string;
var
   dest: string;
begin
   if puiss = 0
   then ajoutePuissDix := nom
   else begin
      dest := '10' + puissToStr(puiss) + ' ';
      if length(dest) + Length(nom) > LongNom
         then ajoutePuissDix := dest + 'S.I.'
         else ajoutePuissDix := dest + nom;
   end;
end;

function Tunite.NomAff(puissValeur: shortInt): string;
// unit� dont on connait le d�veloppement en puissance

   function PrefixeConnu(p: shortInt): boolean;
   begin
      PrefixeConnu := (p >= -18) and (p <= 18) and ((p mod 3 = 0) or
         (p = -2) or (p = -1) or (p = 2));
   end;

   function AjoutePrefixe(Nom: string; P: shortInt): string;
   var prefixe: char;
   begin
      if (nom = '') then begin
         ajoutePrefixe := AjoutePuissDix(nom, P);
         exit;
      end;
      if (length(nom) > 1) and
         (charInSet(nom[1],caracPrefixe) or
           (nom[1]=mu)) and
         (charInSet(nom[2],caracDebutUnite) or
         (nom[2]=OmegaMaj)) then begin
         case FnomUnite[1] of
            'a': P  := P - 18;
            'f': P  := P - 15;
            'p': P  := P - 12;
            'n': P  := P - 9;
            '�': P := P - 6;
            mu: P := P - 6;
            'm': P  := P - 3;
            'c': P  := P - 2;
            'd': P  := P - 1;
            'h': P  := P + 2;
            'k': P  := P + 3;
            'M': P  := P + 6;
            'G': P  := P + 9;
            'T': P  := P + 12;
            'P': P  := P + 15;
            'E': P  := P + 18;
         end;
         nom := copy(nom, 2, length(nom));
      end;
      case P of
         -18: prefixe := 'a';
         -15: prefixe := 'f';
         -12: prefixe := 'p';
         -9: prefixe  := 'n';
         -6: prefixe  := '�';
         -3: prefixe  := 'm';
         -2: prefixe  := 'c';
         -1: prefixe  := 'd';
         0: begin
            ajoutePrefixe := nom;
            exit;
         end;
         +2: prefixe  := 'h';
         +3: prefixe  := 'k';
         +6: prefixe  := 'M';
         +9: prefixe  := 'G';
         +12: prefixe := 'T';
         +15: prefixe := 'P';
         +18: prefixe := 'E';
         else begin
            ajoutePrefixe := AjoutePuissDix(nom, P);
            exit;
         end;
      end;
      ajoutePrefixe := prefixe + nom;
   end;

procedure CasParticulier;
var NomNegatif: string;
    NegatifCompose : boolean;

procedure AjouteNegatif(dim : integer;const nomU : string);
var long : integer;
begin
         if NomNegatif <> '' then begin
            long := length(nomNegatif);
            if not charInSet(nomNegatif[long],chiffre)
               then NomNegatif := NomNegatif + puissToStr(-1)
               else insert('-',nomNegatif,long);
            NomNegatif := NomNegatif + '.';
            NomNegatif := NomNegatif + NomU;
            NomNegatif := NomNegatif + PuissToStr(dim);
            NegatifCompose := true;
         end
         else begin
              NomNegatif := NomU;
              if (dim<-1) then
                 NomNegatif := NomNegatif + PuissToStr(-dim);
         end;
end;

var i: TuniteDeBase;
    k: TunitePart;
    NomPositif: string;
    dim : integer;
    UniteBase : set of TuniteDeBase;
begin
   FNomUnite := '';
   NomPositif := '';
   NomNegatif := '';
   NegatifCompose := false;
   uniteBase := [_kilogramme,_ampere,_kelvin,_mole,_candela];
   for k := low(TunitePart) to high(TunitePart) do
      if dimensionPart[k] > 0 then begin
         if NomPositif <> '' then
            NomPositif := NomPositif + '.';
         NomPositif := NomPositif + SymbolePart[k];
         if dimensionPart[k] > 1 then
            NomPositif := NomPositif + PuissToStr(dimensionPart[k]);
      end
      else if dimensionPart[k] < 0 then
           ajouteNegatif(dimensionPart[k],SymbolePart[k]);
   if (dimensionPart[_ua]<>0) and
      (dimension[_metre]<>dimensionPart[_ua]) then begin
      setErreurUnite;
      FnomUnite := '';
      exit;
   end;
   if (dimensionPart[_ua]=0) then include(UniteBase,_metre);
   dim := dimensionPart[_heure]+dimensionPart[_jour]+dimensionPart[_minute];
   if (dim<>0) and
      (dimension[_seconde]<>dim) then begin
      setErreurUnite;
      FnomUnite := '';
      exit;
   end;
   if (dim=0) then include(UniteBase,_seconde);
   for i in UniteBase do
      if dimension[i] > 0 then begin
         if NomPositif <> '' then
            NomPositif := NomPositif + '.';
         NomPositif := NomPositif + NomBase[i];
         if dimension[i] > 1 then
            NomPositif := NomPositif + PuissToStr(dimension[i]);
      end
      else if dimension[i] < 0 then
           ajouteNegatif(dimension[i],NomBase[i]);
   if NegatifCompose then begin
      if (NomPositif <> '') then
          NomPositif := NomPositif + '.';
   end
   else if nomNegatif<>'' then begin
        if NomPositif='' then NomPositif := '1';
        NomPositif := NomPositif + '/';
   end;
   FnomUnite := NomPositif + NomNegatif;
   UnitePart := true;
end;

var
   i: TuniteDeBase;
   k: TunitePart;
   OKnulle, OKconnue, OKpart: boolean;
   j,puissSeconde:  integer;
   UU: Tunite;
   NomPositif, NomNegatif: string;
   CasDuMetre: boolean;
   premierCarac : char;
begin // NomAff
   UnitePart := false;
   if FnomUnite = '1' then begin
      result := AjoutePuissDix('', puissValeur);
      exit;
   end;
//   (UniteDonnee or (FnomUnite=''))
   if UniteDonnee and (puissValeur = 0) then begin
      result := FnomUnite;
      exit;
   end;
   if UniteImposee then begin
      if (length(nomUnite)>1) then PremierCarac := FnomUnite[1] else premierCarac := #0;
      if CharInSet(premierCarac,['M','k','G','�','n','p']) and (puissValeur<>0)
      then begin
           case premierCarac of
                'k' : inc(puissValeur,3);
                'M' : inc(puissValeur,6);
                'G' : inc(puissValeur,9);
                //'T' : inc(puissValeur,12); // pb avec Tesla
                //'P' : inc(puissValeur,15); // on oublie ...
                //'E' :inc(puissValeur,18); // on oublie ...
                //'Z' :inc(puissValeur,21); // on oublie ...
                //'Y' :inc(puissValeur,24); // on oublie ...
                //'m' : dec(puissValeur,3); // pb avec m�tre
                '�' : dec(puissValeur,6);
                'n' : dec(puissValeur,9);
                'p' : dec(puissValeur,12);
                //'f' : dec(puissValeur,15); // on oublie ...
                //'y' : dec(puissValeur,23); // on oublie ...
                //'z' : dec(puissValeur,24); // on oublie ...
                //'a' : dec(puissValeur,18); // on oublie ...
           end;
           result := AjoutePuissDix(copy(FnomUnite,2,length(nomUnite)),puissValeur);
      end
      else result := AjoutePuissDix(FnomUnite, puissValeur);
      exit;
   end;
   if not correct then begin
      if not UniteDonnee then
         FnomUnite := '';
      result := AjoutePuissDix(FnomUnite, puissValeur);
      exit;
   end;
   OKpart := true;
   for k := low(TunitePart) to high(TunitePart) do
       OKpart := OKpart and (dimensionPart[k] = 0);
   if not OKpart then begin
      CasParticulier;
      puissValeur := puissance + puissValeur;
      result := AjoutePrefixe(FnomUnite, PuissValeur);
      exit;
   end;
   OKnulle := True;
   for i := _Metre to _Candela do
      OKnulle := OKnulle and (dimension[i] = 0);
   if OKnulle then begin
      if UniteDonnee // or (FnomUnite='')
      then result := AjoutePrefixe(FnomUnite, PuissValeur)
      else begin
        puissValeur := puissance + puissValeur;
        FnomUnite := symboleSansDim[sansDim];  // Pb !!
        // if sansDim in [tuRadian,tuTour,tuDecibel] then
        // (tuVide, tuDegre, tuRadian, tuDecibel, tuTour, tuPourCent);
          result := AjoutePrefixe(FnomUnite, PuissValeur)
        // else result := AjoutePuissDix(FnomUnite, PuissValeur)+'?';
      end;
      exit;
   end;
   puissValeur := puissance + puissValeur;
   CasDuMetre  := Correct and (dimension[_metre] <> 0) and (dimension[_metre] <> 1);
   for i := _KiloGramme to _Candela do
       CasDuMetre := CasDuMetre and (dimension[i] = 0);
(*  // ???
   CasDuMetre := false;
   i0 := _Metre; // pour le compilateur
   for i := _Metre to _Candela do
       if dimension[i]<>0 then
          if CasDuMetre then begin
             CasDuMetre := false;
             break;
          end
          else begin
            CasDuMetre := true;
            i0 := i;
          end;
   CasDuMetre := CasDuMetre and Correct and (dimension[i0] <> 1);
      if CasDuMetre and
      (puissValeur mod dimension[i0] = 0) and
      prefixeConnu(puissValeur div dimension[i0]) then begin // 10^-6 m^2 = (mm)^2
      NomPositif := AjoutePrefixe(NomBase[i0], puissValeur div dimension[i0]);
      NomAff := NomPositif + PuissToStr(dimension[i0]);
      exit;
   end;
*)
   if CasDuMetre and (puissValeur mod dimension[_metre] = 0) and
      prefixeConnu(puissValeur div dimension[_metre]) then begin // 10^-6 m^2 = (mm)^2
      NomPositif := AjoutePrefixe('m', puissValeur div dimension[_metre]);
      NomAff := NomPositif + PuissToStr(dimension[_metre]);
      exit;
   end;
   for j := 1 to NbreUniteConnue do begin
      UU := UniteConnue[j];
      for i := _Metre to _Candela do begin
         OKconnue := dimension[i] = UU.dimension[i];
         if not OKconnue then
            break;
      end;
      if OKconnue and (sansDim = tuVide) then begin
         if isCelsius and (puissValeur=UU.puissance)
            then Result := uniteToleree[indexCelsius].nomUnite
            else Result := AjoutePrefixe(UU.FnomUnite, puissValeur - UU.puissance);
         exit;
      end;
   end;
   for j := 1 to pred(NbreUniteConnue) do begin // pas le 1 = sans dim
      UU := UniteConnue[j];
      for i := _Metre to _Candela do begin
         if i = _Seconde then
            OKconnue :=
               (dimension[_seconde] = UU.dimension[_seconde] - 1) or
               (dimension[_seconde] = UU.dimension[_seconde] - 2)
         else
            OKconnue := dimension[i] = UU.dimension[i];
         if not OKconnue then break;
      end;
      if OKconnue and isCelsius and (UU=uniteConnue[indexKelvin])
         then UU := UniteToleree[indexCelsius];
      if OKconnue and (sansDim = tuVide) and (UU.FnomUnite <> 'Hz') then begin
         Result := AjoutePrefixe(UU.FnomUnite, puissValeur - UU.puissance);
         puissSeconde := dimension[_seconde] - UU.dimension[_seconde];
         if Result=''
            then if puissSeconde=-1
               then Result := 'Hz'
               else Result := 's' + PuissToStr(puissSeconde)
            else if (puissSeconde>0) or (pos('/',result)>0)
               then Result := Result + ' s' + PuissToStr(puissSeconde)
               else begin
                  Result := Result + '/s';
                  if puissSeconde<>-1 then
                      Result := Result + PuissToStr(-puissSeconde);
               end;
            exit;
      end;
   end;
   if UniteDonnee then begin
      result := AjoutePuissDix(FnomUnite, puissValeur - puissance);
      exit;
   end;
   NomPositif := symboleSansDim[sansDim];
   NomNegatif := '';
   for i := _Metre to _Candela do
      if dimension[i] > 0 then begin
         if NomPositif <> '' then
            NomPositif := NomPositif + '.';
         NomPositif := NomPositif + NomBase[i];
         if dimension[i] > 1 then
            NomPositif := NomPositif + PuissToStr(dimension[i]);
      end
      else if dimension[i] < 0 then begin
         if NomNegatif <> '' then
            NomNegatif := NomNegatif + '.';
         NomNegatif := NomNegatif + NomBase[i];
         NomNegatif := NomNegatif + PuissToStr(dimension[i]);
      end;
   if (NomPositif <> '') and (NomNegatif <> '') then
      NomPositif := NomPositif + '.';
   FnomUnite := NomPositif + NomNegatif;
   result := AjoutePuissDix(FnomUnite, puissValeur);
end; // NomAff

function Tunite.UniteAxe(exposant: double): string;
begin
   if formatU in [fLongueDuree, fDateTime, fDate, fTime]
      then Result := ''
      else Result := nomAff(round(log10(exposant)));
   if Result <> '' then if uniteParenthese or (pos('/',result)>0)
      then Result := '(' + Result + ')'
      else Result := '/' + Result;
end;

constructor Tunite.Create;
begin
   inherited Create;
   Init;
   UniteGrapheImposee := false;
   UniteGraphe := '';
end;

procedure InitUnite;
begin
   UniteConnue[1] := Tunite.Create;
   UniteConnue[1].setUniteComplet('m','meter', 0, 1, 0, 0, 0, 0, 0, 0);
   UniteConnue[2] := Tunite.Create;
   UniteConnue[2].setUniteComplet('A','ampere', 0, 0, 0, 0, 1, 0, 0, 0);
   UniteConnue[3] := Tunite.Create;
   UniteConnue[3].setUniteComplet('g','gramme', -3, 0, 1, 0, 0, 0, 0, 0);
   UniteConnue[4] := Tunite.Create;
   UniteConnue[4].setUniteComplet('K','kelvin', 0, 0, 0, 0, 0, 1, 0, 0);
   UniteConnue[5] := Tunite.Create;
   UniteConnue[5].setUniteComplet('mol','mole', 0, 0, 0, 0, 0, 0, 1, 0);
   UniteConnue[6] := Tunite.Create;
   UniteConnue[6].setUniteComplet('cd','candela', 0, 0, 0, 0, 0, 0, 0, 1);
   UniteConnue[7] := Tunite.Create;
   UniteConnue[7].setUniteComplet('H','henry', 0, 2, 1, -2, -2, 0, 0, 0);
   UniteConnue[8] := Tunite.Create;
   UniteConnue[8].setUniteComplet('mol/L','', +3, -3, 0, 0, 0, 0, 1, 0);
   UniteConnue[8].uniteImposee := true; // � cause de litre
   UniteConnue[9] := Tunite.Create;
   UniteConnue[9].setUniteComplet('F','farad', 0, -2, -1, 4, 2, 0, 0, 0);
   UniteConnue[10] := Tunite.Create;
   UniteConnue[10].setUniteComplet('N','newton', 0, 1, 1, -2, 0, 0, 0, 0);
   UniteConnue[11] := Tunite.Create;
   UniteConnue[11].setUniteComplet(omegaMaj,'ohm', 0, 2, 1, -3, -2, 0, 0, 0);
   UniteConnue[12] := Tunite.Create;
   UniteConnue[12].setUniteComplet('S','siemens', 0, -2, -1, 3, 2, 0, 0, 0);
   UniteConnue[13] := Tunite.Create;
   UniteConnue[13].setUniteComplet('T','tesla', 0, 0, 1, -2, -1, 0, 0, 0);
   UniteConnue[14] := Tunite.Create;
   UniteConnue[14].setUniteComplet('V','volt', 0, 2, 1, -3, -1, 0, 0, 0);
   UniteConnue[15] := Tunite.Create;
   UniteConnue[15].setUniteComplet('Hz','hertz', 0, 0, 0, -1, 0, 0, 0, 0);
   UniteConnue[16] := Tunite.Create;
   UniteConnue[16].setUniteComplet('s','second', 0, 0, 0, 1, 0, 0, 0, 0);
   UniteConnue[17] := Tunite.Create;
   UniteConnue[17].setUniteComplet('Pa','pascal', 0, -1, 1, -2, 0, 0, 0, 0);
   UniteConnue[18] := Tunite.Create;
   UniteConnue[18].setUniteComplet('J','joule', 0, 2, 1, -2, 0, 0, 0, 0);
   UniteConnue[19] := Tunite.Create;
   UniteConnue[19].setUniteComplet('W','watt', 0, 2, 1, -3, 0, 0, 0, 0);
   UniteConnue[20] := Tunite.Create;
   UniteConnue[20].setUniteComplet('C','coulomb', 0, 0, 0, 1, 1, 0, 0, 0);
   UniteConnue[21] := Tunite.Create;
   UniteConnue[21].setUniteComplet('Wb','weber', 0, 2, 1, -2, -1, 0, 0, 0);
   UniteConnue[22] := Tunite.Create;
   UniteConnue[22].setUniteComplet('lm','lumen', 0, 0, -2, 0, 0, 0, 0, 1);
   UniteConnue[23] := Tunite.Create;
   UniteConnue[23].setUniteComplet('N/m','', 0, 0, 1, -2, 0, 0, 0, 0);
   UniteConnue[24] := Tunite.Create;
   UniteConnue[24].setUniteComplet('J/K','', 0, 2, 1, -2, 0, -1, 0, 0);
   UniteConnue[25] := Tunite.Create;
   UniteConnue[25].setUniteComplet('J/kg.K','', 0, 2, 0, -2, 0, -1, 0, 0);
   UniteConnue[26] := Tunite.Create;
   UniteConnue[26].setUniteComplet('V/m','', 0, 1, 1, -3, -1, 0, 0, 0);  // S/cm ??
   UniteConnue[27] := Tunite.Create;
   UniteConnue[27].setUniteComplet('S/m','', 0, -3, -1, 3, 2, 0, 0, 0);
   UniteConnue[28] := Tunite.Create;
   UniteConnue[28].setUniteComplet('W/m.K)','', 0, 1, 1, -3, 0, -1, 0, 0);
   UniteConnue[29] := Tunite.Create;
   UniteConnue[29].setUniteComplet('C.m','', 0, 1, 0, 0, 0, 0, 0, 0);
   UniteConnue[30] := Tunite.Create;
   UniteConnue[30].setUniteComplet(OmegaMaj + 'm','', 0, 3, 1, -3, -2, 0, 0, 0);
   UniteConnue[31] := Tunite.Create;
   UniteConnue[31].setUniteComplet('N.m','', 0, 1, 0, 1, 1, 0, 0, 0);
   UniteConnue[32] := Tunite.Create;
   UniteConnue[32].setUniteComplet('A/m','', 0, -1, 0, 0, 1, 0, 0, 0);
   UniteConnue[33] := Tunite.Create; // sans dimension
   UniteConnue[33].setUniteComplet('1','', 0, 0, 0, 0, 0, 0, 0, 0);
   UniteConnue[34] := Tunite.Create;
   UniteConnue[34].setUniteComplet('Bq','becquerel', 0, 0, -1, 0, 0, 0, 0, 0);
   UniteConnue[35] := Tunite.Create; // poiseuille = Pa.s
   UniteConnue[35].setUniteComplet('Pl','poiseuille', 0, -1, 1, -1, 0, 0, 0, 0);

   UniteToleree[1] := Tunite.Create;
   UniteToleree[1].setUniteComplet('L','litre', -3, 3, 0, 0, 0, 0, 0, 0);
   UniteToleree[1].uniteImposee := true;
   UniteToleree[2] := Tunite.Create;
   UniteToleree[2].setUniteComplet('rad','radian', 0, 0, 0, 0, 0, 0, 0, 0);
   UniteToleree[2].sansDim := tuRadian;
   UniteToleree[3] := Tunite.Create;
   UniteToleree[3].setUniteComplet('�C','celsius', 0, 0, 0, 0, 0, 1, 0, 0);
   UniteToleree[3].isCelsius := true;
   UniteToleree[4] := Tunite.Create;
   UniteToleree[4].setUniteComplet('bar','bar', 5, -1, 1, -2, 0, 0, 0, 0);
   UniteToleree[5] := Tunite.Create;
   UniteToleree[5].uniteImposee := true;
   UniteToleree[5].setUniteComplet('dB','decibel', 0, 0, 0, 0, 0, 0, 0, 0);
   UniteToleree[5].sansDim := tuDecibel;
   UniteToleree[6] := Tunite.Create;
   UniteToleree[6].setUniteComplet('�','degr�', 0, 0, 0, 0, 0, 0, 0, 0);
   UniteToleree[6].sansDim := tuDegre;
   UniteToleree[7] := Tunite.Create;
   UniteToleree[7].setUniteComplet('h','heure', 0, 0, 0, 1, 0, 0, 0, 0);
   UniteToleree[7].dimensionPart[_heure] := 1;
   UniteToleree[7].uniteImposee := true;
   UniteToleree[7].unitePart := true;
   UniteToleree[8] := Tunite.Create;
   UniteToleree[8].setUniteComplet('t','tonne', 3, 0, 1, 0, 0, 0, 0, 0);
   UniteToleree[8].uniteImposee := true;
   UniteToleree[9] := Tunite.Create;
   UniteToleree[9].setUniteComplet('tr','tour', 0, 0, 0, 0, 0, 0, 0, 0);
   UniteToleree[9].dimensionPart[_tour] := 1;
   UniteToleree[9].sansDim := tuTour;
   UniteToleree[10] := Tunite.Create;
   UniteToleree[10].setUniteComplet('%','', -2, 0, 0, 0, 0, 0, 0, 0);
   UniteToleree[10].sansDim := tuPourCent;
   UniteToleree[11] := Tunite.Create;
   UniteToleree[11].setUniteComplet(deltaMin,'dioptrie', 0,-1, 0, 0, 0, 0, 0, 0);
   UniteToleree[12] := Tunite.Create;
   UniteToleree[12].setUniteComplet('ua','', 0,1, 0, 0, 0, 0, 0, 0);
   UniteToleree[12].dimensionPart[_ua] := 1;
   UniteToleree[12].unitePart := true;
   UniteToleree[13] := Tunite.Create;
   UniteToleree[13].setUniteComplet('j','jour', 0, 0, 0, 1, 0, 0, 0, 0);
   UniteToleree[13].dimensionPart[_jour] := 1;
   UniteToleree[13].unitePart := true;
   UniteToleree[14] := Tunite.Create;
   UniteToleree[14].setUniteComplet('min','minute', 0, 0, 0, 1, 0, 0, 0, 0);
   UniteToleree[14].dimensionPart[_minute] := 1;
   UniteToleree[14].unitePart := true;
   UniteToleree[15] := Tunite.Create;
   UniteToleree[15].setUniteComplet(symboleAngstrom,'angstr�m', -10, 1, 0, 0, 0, 0, 0, 0);
   UniteToleree[15].unitePart := true;
   UniteToleree[15].uniteImposee := true;

   UniteNulle := Tunite.Create;
   UniteNulle.setUniteComplet('',' ', 0, 0, 0, 0, 0, 0, 0, 0);
end;

procedure LibereUnite;
var
   i: integer;
begin
   for i := 1 to NbreUniteConnue do
      UniteConnue[i].Free;
   for i := 1 to NbreUniteToleree do
      UniteToleree[i].Free;
   UniteNulle.Free;
end;

procedure Tunite.SetUniteComplet(const nu,nc: string; p: shortInt;
   d1, d2, d3, d4, d5, d6, d7: shortInt);
begin
   FnomUnite := nu;
   FnomComplet := nc;
   puissance := p;
   Dimension[_metre] := d1;
   Dimension[_kilogramme] := d2;
   Dimension[_seconde] := d3;
   Dimension[_ampere] := d4;
   Dimension[_kelvin] := d5;
   Dimension[_mole] := d6;
   Dimension[_candela] := d7;
   UniteDonnee := True;
   UnitePart := false;
   isCelsius := false;
   coeffSI := dix(puissance);
end;

procedure Tunite.VerifUniteEgale(u1, u2: Tunite);
var
   i: TuniteDeBase;
begin
   if not (U1.correct) or not (U2.correct) then
      setErreurUnite;
   if U1.Adaptable then begin
      recopieUnite(U2);
      if not adaptable then U1.RecopieUnite(U2);
      exit;
   end;
   if U2.Adaptable then begin
      recopieUnite(U1);
      if not adaptable then U2.RecopieUnite(U1);
      exit;
   end;
   if (U1.puissance <> U2.puissance) and
       not UniteSIGlb then setErreurUnite;
   for i := _Metre to _Candela do
      if (U1.dimension[i] <> U2.dimension[i]) then
         setErreurUnite;
   recopieUnite(U1);
end;

procedure Tunite.setErreurUnite;
begin
   correct := False;
   raise EUniteError.Create(ErUnite);
end;

procedure Tunite.Init;
var
   i: TuniteDeBase;
   j: TunitePart;
begin
   FnomUnite := '';
   FnomComplet := '';
   puissance := 0;
   puissAff := 0;
   CoeffAff := 1;
   coeffSI := dix(puissance);
   sansDim  := tuVide;
   for i := _Metre to _Candela do
      Dimension[i] := 0;
   for j := low(TunitePart) to high(TunitePart) do
      DimensionPart[j] := 0;
   Correct := True;
   Adaptable := False;
   UniteDonnee := False;
   UniteImposee := False;
   FormatU := fDefaut;
   PrecisionU := Precision;
   nom := '';
   isCelsius := false;
end;

procedure Tunite.RecopieUnite(U: Tunite);
var
   i: TuniteDeBase;
   j: TunitePart;
begin
   FnomUnite := U.FnomUnite;
   puissance := U.puissance;
   sansDim := U.sansDim;
   coeffSI := U.coeffSI;
   for i := _Metre to _Candela do
      Dimension[i] := U.dimension[i];
   for j := low(TunitePart) to high(TunitePart) do
      DimensionPart[j] := U.dimensionPart[j];
   Correct := U.correct;
   Adaptable := U.adaptable;
   UniteDonnee := U.UniteDonnee;
   UniteImposee := U.UniteImposee;
   isCelsius := U.isCelsius;
end;

procedure Tunite.Assign(U: Tunite);
begin
   RecopieUnite(U);
   Nom := U.Nom;
end;

function UnitesEgales(u1, u2: Tunite): boolean;
var
   i: TuniteDeBase;
begin
   Result := False;
   if not (U1.correct) or not (U2.correct) then
      exit;
   if (U1.puissance <> U2.puissance) then
      exit;
   for i := _Metre to _Candela do
      if (U1.dimension[i] <> U2.dimension[i]) then
         exit;
   Result := True;
end;

procedure Tunite.UniteDerivee(ux, uy: Tunite; gx, gy: Tgraduation);
var j : integer;
    xSimple,ySimple : boolean;
   // ySansDim : boolean;
    nomy : string;
begin
   nom := '';
   try
      case gy of
         gLog: begin
            uy.recopieUnite(UniteNulle);
            nom := 'dlog(';
         end;
         gdB: begin
            uy.setNomUnite('dB');
            nom := 'd(';
         end;
         gLin: nom := 'd' + uy.nom;
         gInv: begin
            uy.InverseUnite;
            nom := 'd(1/';
         end;
      end;
      if gy <> gLin then
         nom := nom + uy.nom + ')';
      nom := nom + '/';
      case gx of
         gLog: begin
            ux.recopieUnite(UniteNulle);
            nom := nom + 'dlog(';
         end;
         gdB: begin
            ux.setNomUnite('dB');
            nom := nom + 'd(';
         end;
         gLin: nom := nom + 'd' + ux.nom;
         gInv: begin
            ux.InverseUnite;
            nom := nom + 'd(1/';
         end;
      end;
      if gx <> gLin then
         nom := nom + ux.nom + ')';
      if (gx = gLog) and (gy = gdB) then
         setNomUnite(stdBDecade)
      else begin
         AdUnite('-', uy, ux);
         if (gx=gLin) and (gy=glin) and (ux.puissance=0) then begin
             xSimple := false;ySimple := false;
             for j := 1 to NbreUniteConnue do begin
                 if ux.uniteEgale(UniteConnue[j]) then xSimple := true;
                 if uy.uniteEgale(UniteConnue[j]) and
                    (pos('/',UniteConnue[j].nomUnite)=0) then ySimple := true;
             end;
             if xSimple and ySimple then begin
                if uy.nomUnite='' then nomy := '1' else nomy := uy.nomUnite;
                if ux.nomUnite='' then nomUnite := nomy else nomUnite := nomy+'/'+ux.nomUnite;
                uniteImposee := true;
             end;
         end;
      end;
   except
      RecopieUnite(UniteNulle);
      nom := '';
   end;
end;

function Tunite.FormatNomPente(x: double): string;
begin
   Result := nom + '=';
   if isNan(x)
      then Result := Result + '?'
      else Result := Result + FormatGeneral(x * coeffAff, precisionMin);
end;

function Tunite.FormatNomPenteUnite(x: double): string;
var
   Lpuissance: integer;
   absx: double;
begin
    try
    absx := abs(x);
    Lpuissance := 3 * floor(log10(absx) / 3);
    Result := nom + '=' + FormatGeneral(
         x * dix(-LPuissance), precisionMin) + ' ' + NomAff(LPuissance);
    except
        result := '';
    end;
end;

function Tunite.FormatValeurPente(x: double): string;
var
   Lpuissance: integer;
   absx: double;
begin
    try
    absx := abs(x);
    Lpuissance := 3 * floor(log10(absx) / 3);
    Result := FormatGeneral(
         x * dix(-LPuissance), precisionMin) + ' ' + NomAff(LPuissance);
    except
        result := '';
    end;
end;

 (*
Procedure CorrigePrecision(var valeur : string);
var posV,i,Nexp : integer;
begin
     posV := pos(FormatSettings.decimalSeparator,valeur);
     if posV=0
        then begin
           Nexp := precision-length(valeur);
           if Nexp>0 then begin
              valeur := valeur+FormatSettings.decimalSeparator;
              for i := 1 to Nexp do valeur := valeur+'0';
           end;
        end
        else begin
           Nexp := precision-length(valeur)+1;
           if valeur[1]='-' then begin
             inc(Nexp);
             if valeur[2]='0' then inc(Nexp);
           end
           else if valeur[1]='0' then inc(Nexp);
           for i := 1 to Nexp do valeur := valeur+'0';
        end;
end;
 *)

Function MyFormat(const ANombre : double;Format : TnombreFormat;Precision : integer) : string;

  function formatHexa : string; // Return hex string for word
  var masque,i,j,W : word;
  begin
    W := round(Anombre);
    Masque := 0;
    j := 1;
    for i := 1 to Precision do begin
        Masque := Masque+j;
        j := j*2;
    end;
    W := W and masque;
    result := Digits[lo(W) and $F]+'h';
    if Precision>4 then
       result := Digits[lo(W) shr 4]+result;
    if Precision>8 then
       result := Digits[hi(W) and $F]+result;
    if Precision>12 then
       result := Digits[hi(W) shr 4]+result;
  end;

  function formatBinary : string; // Return binary string for word
  var
    I,N,W : Word;
  begin
    W := round(Anombre);
    N := 1;
    setLength(result,Precision);
    for i := pred(Precision) downto 0 do begin
      result[N] := Digits[Ord(W and (1 shl I) <> 0)]; {0 or 1}
      Inc(N);
    end;
  end;

Function FormatLongueDuree : string;
// dur�e en seconde exprim�e sous forme d hh:mm:ss
var t : longInt;
    sec,min,hour,day : integer;
    zz : string;
begin
    t := round(Anombre);
    day := t div UnJour;
    if day>0
       then result := intToStr(day)+'j '
       else result := '';
    t := t-day*UnJour;
    hour := t div UneHeure;
    zz := IntToStr(hour);
    if length(zz)=1 then zz := '0'+zz;
    result := result+zz+':';
    t := t-hour*UneHeure;
    min := t div UneMinute;
    zz := IntToStr(min);
    if length(zz)=1 then zz := '0'+zz;
    result := result+zz;
    if day=0 then begin // ajout des secondes
       sec := t-min*UneMinute;
       zz := IntToStr(sec);
       if length(zz)=1 then zz := '0'+zz;
       result := result+':'+zz;
    end;
end;

function degreToStr : string;
var degre,minute,seconde : integer;
    valeur : double;
begin
    degre := round(int(Anombre));
    valeur := abs(Anombre-degre);
    result := intToStr(degre)+'�';
    if valeur>0 then begin
        minute := trunc(60*valeur);
        valeur := valeur-minute/60;
        result := result + intToStr(minute)+'''';
        seconde := round(60*60*valeur);
        if seconde>0 then result := result + intToStr(seconde)+'"';
    end;
end;

Function FormatExposant : string;
var Nexp,posV,posE,i,puiss : integer;
begin
    if abs(ANombre)<1e-10
       then Nexp := 2
       else if abs(aNombre)<1e+10
           then Nexp := 1
           else Nexp := 2;
     result := FloatToStrF(anombre,ffExponent,Precision,Nexp);
     posV := pos(FormatSettings.decimalSeparator,result);
     if posV=0
        then begin
           posE := pos('E',result);
           if posE>0
              then begin
                 puiss  := StrToInt(copy(result, succ(posE), length(result) - posE));
                 result := copy(result,1,posE-1);
                 Nexp := precision-posE+1;
              end
              else begin
                 puiss := 0;
                 Nexp := precision-length(result);
              end;
           if Nexp>0 then begin
              result := result+FormatSettings.decimalSeparator;
              for i := 1 to Nexp do result := result+'0';
           end;
           if puiss<>0 then result := result + pointMedian + '10' + puissToStr(puiss);
        end
        else begin
           posE := pos('E',result);
           if posE>0
              then begin
                 puiss  := StrToInt(copy(result, succ(posE), length(result) - posE));
                 result := copy(result,1,posE-1);
                 Nexp := precision-posE+2;
              end
              else begin
                 puiss := 0;
                 Nexp := precision-length(result)+1;
              end;
           if result[1]='-' then begin
              inc(Nexp);
              if result[2]='0' then inc(Nexp);
           end
           else if result[2]='0' then inc(Nexp);
           for i := 1 to Nexp do result := result+'0';
           if puiss<>0 then result := result + pointMedian + '10' + puissToStr(puiss);
        end;
end;

var posV,i,precLoc : integer;
begin // Function MyFormat
     if isNan(ANombre)
        then result := ''
        else case format of
            fDefaut   : result := FormatReg(ANombre);
            fExponent : result := FormatExposant;
            fFixed    : begin // precision = nombre de d�cimales
               result := FloatToStrF(Anombre,ffFixed,longNombre,Precision);
               posV := pos(FormatSettings.decimalSeparator,result);
               if posV=0 then if precision=0 then
                 else begin
                  result := result+FormatSettings.decimalSeparator;
                  for i := 1 to precision do result := result+'0';
               end
               else begin
                  precLoc := precision-length(result)+posV;
                  for i := 1 to precLoc do result := result+'0';
               end;
            end;
            fBinary   : result := formatBinary;
            fHexa     : result := formatHexa;
            fLongueDuree : result := FormatLongueDuree;
            fDateTime : result := DateTimeToStr(Anombre);
            fDate : result := DateToStr(Anombre);
            fTime : result := TimeToStr(Anombre);
            fDegreMinute : result := degreToStr;
        end;
end; // Function MyFormat

function Tunite.FormatValeurEtUnite(const ANombre: double): string;
var
   negatif: boolean;
   unite:  TcoefUnite;
   absNombre: double;
   posE, puiss, i, imax: integer;
   tampon,tamponU: string;
begin
   Result := '';
   tamponU := nomAff(0);
   if tamponU<>'' then tamponU := ' '+tamponU;
   if isNan(Anombre) then exit;
   case formatU of
      fBinary, fHexa,
      fLongueDuree, fDateTime, fDate, fTime,
      fDegreMinute : begin
         Result := MyFormat(ANombre, formatU, PrecisionU);
         exit;
      end;
      fFixed: begin
         Result := MyFormat(ANombre, fFixed, PrecisionU) + tamponU;
         exit;
      end;
   end;
   if FnomUnite = '�C' then begin
      Result := FloatToStrF(ANombre, ffFixed, longNombre, PrecisionU) + ' �C';
      exit;
   end;
   AbsNombre := abs(Anombre);
   if (absNombre <= valUnite[zero]) or (absNombre >= valUnite[infini]) then begin
      if formatU = fDefaut
         then tampon := FloatToStrF(ANombre, ffGeneral, Precision, 2)
         else tampon := FloatToStrF(ANombre, ffGeneral, PrecisionU, 2);
      posE := pos('E', tampon);
      if posE > 0 then begin
         puiss  := StrToInt(copy(tampon, succ(posE), length(tampon) - posE));
         tampon := copy(tampon, 1, pred(posE)) + pointMedian+'10' + puissToStr(puiss);
      end;
      Result := tampon+tamponU;
      exit;
   end;
   negatif := Anombre < 0;
   unite := nulle;
   while (AbsNombre >= 999) and (unite < infini) do begin
      AbsNombre := AbsNombre / 1000;
      Inc(unite);
   end; // abs(nombre)<1000 ou infini
   while (AbsNombre < 0.999) and (unite > zero) do begin
      AbsNombre := AbsNombre * 1000;
      Dec(unite);
   end; // abs(nombre)>=1 ou zero
   if formatU = fDefaut
      then begin
         tampon := FloatToStrF(AbsNombre, ffGeneral, Precision, 0);
         imax := precision-length(tampon)+1;
      end
      else begin
         tampon := FloatToStrF(AbsNombre, ffGeneral, PrecisionU, 0);
         imax := precisionU-length(tampon)+1; // +1=decimalSeparator
      end;
   if negatif then tampon := '-' + tampon;
   if (imax>0) and
      (pos(FormatSettings.decimalSeparator,tampon)>0) and
      (pos('E',result)<=0) then begin
           for i := 1 to imax do
               tampon := tampon+'0';
   end;
   tamponU := nomAff(puissanceUnite[unite]);
   if tamponU<>'' then tamponU := ' '+tamponU;
   Result := tampon+tamponU;
end;

function Tunite.FormatNomEtUnite(const Anombre: double): string;
begin
   Result := nom + '=' + formatValeurEtUnite(ANombre);
end;

function Tunite.formatNombre(const Anombre: double): string;
begin
   Result := MyFormat(Anombre, formatU, PrecisionU);
end;

Function Tunite.FormatIncert(const Anombre : double) : string;
var longueur,i,posE : integer;
    puiss : string;
begin
     if Anombre<1e-4
       then result := FloatToStrF(Anombre,ffExponent,3,2)
       else result := FloatToStrF(Anombre,ffFixed,2,18);
     posE := pos('E',result);
     longueur := length(result);
     if posE>0 then begin
          puiss := copy(result,posE+1,longueur-posE);
          i := strToInt(puiss);
          puiss := pointMedian+'10'+puissToStr(i);
          result := copy(result,1,posE-1);
          longueur := length(result);
     end
     else puiss := '';
     i := 0;
     repeat inc(i);
     until charinset(result[i],['1'..'9']) or (i=longueur);
     if i<longueur then begin
        i := i+1; // on garde deux chiffres
        if Result[i]=formatSettings.DecimalSeparator
           then i := i+1;// on saute la virgule
     end;
     result := copy(result,1,i)+puiss;
end;

procedure Tunite.setRadianDegre;
const
   Code: array [boolean] of string = ('rad', '�');
var
   posAngle: integer;
begin
   posAngle := pos(Code[not AngleEnDegre], FnomUnite); // l'ancien
   if posAngle > 0 then begin
      Delete(FNomUnite, posAngle, length(code[not AngleEnDegre]));
      Insert(code[AngleEnDegre], FNomUnite, posAngle); // le nouveau
   end;
   if not UniteDonnee and not UniteImposee then
      if AngleEnDegre then begin
         if sansDim = tuRadian then
            sansDim := tuDegre;
      end
      else begin
         if sansDim = tuDegre then
            sansDim := tuRadian;
      end;
end;

function Tunite.UniteEgale(U: Tunite): boolean;
var
   i: TuniteDeBase;
begin
   Result := U.sansDim = sansDim;
   for i := _Metre to _Candela do
      Result := Result and (U.dimension[i] = dimension[i]);
end;

procedure Tunite.VerifTaux(grandeurY, grandeurX: Tunite);
var
   i, iX: TuniteDeBase; // unite = grandeurY/grandeurX ?
   taux,simple: boolean; // simple = m�me unit� haut et bas
begin
   if not (grandeurY.correct) or
      not (grandeurX.correct) or
      not (correct) or
      grandeurY.UniteEgale(grandeurX) then
      exit;
   if uniteEgale(UniteConnue[19]) then exit; // W et non J/s
   Taux := False;
   iX := _Candela; // pour le compilateur
// X unit� fondamentale kg m s donc taux Y/s Y/m Y/kg
   for i := _Metre to _Candela do
      if grandeurX.dimension[i] = 1
        then if taux
          then exit // combinaison deux unit�s fondamentales
          else begin
             iX := i;
             taux := True;
          end
          else if grandeurX.dimension[i] <> 0 then exit;
   taux := taux and (iX<=_seconde);
   taux := taux and (pos('/',grandeurY.nomUnite)=0);
   taux := taux and (pos('.',grandeurY.nomUnite)=0);
   taux := taux and (grandeurY.puissance=0);
   if not taux then exit;
   simple := true;
   for i := _Metre to _Candela do
      if i = iX then begin
         if (grandeurY.dimension[i] - 1) <> dimension[i] then
            taux := False;
      end
      else begin
         if (grandeurY.dimension[i] <> dimension[i]) then
            taux := False;
         if (grandeurY.dimension[i] <> 0) then simple := false;
      end;
   if simple then exit;     // s/s ; m/m ; kg/kg
   if taux then if not uniteSIGlb and grandeurX.UniteDonnee and grandeurY.unitedonnee
      then nomUnite := grandeurY.nomUnite + '/' + grandeurX.nomUnite
      else nomUnite := grandeurY.nomAff(-puissance) + '/' + NomBase[iX]
end;

procedure Tunite.imposeNomUnite(const nu : string);
begin
  FnomUnite := nu;
end;

function Tunite.nomIncertitude : string;
begin
     result := 'u('+nom+')'; // Incertitude type u, �largie U
end;

function Tunite.formatNomPrecisionUnite(const Anombre,U95: double): string;
var CoeffValeur : double;
    Decimales : integer;
    tampon,tamponPrec : String;
    PrecOk : boolean;
    valeurLoc : double;
    premierChiffre,expPrec,expValeur,expValeurIng : integer;
begin
   tampon := '';
   valeurLoc := Anombre;
   expValeurIng := 3*floor(log10(abs(valeurLoc))/3);
   CoeffValeur := dix(-expValeurIng);
   try
        expPrec := floor(log10(U95));
        expValeur := floor(log10(valeurLoc));
        Decimales := expValeur-expPrec;
        premierChiffre := floor(U95*dix(-expPrec));
        if premierChiffre<3 then inc(decimales); // deux chiffres pour 0,13 ou 0,24
        if Decimales>precisionMaxIncert then Decimales := PrecisionMaxIncert;
        decimales := decimales - expValeur + expValeurIng;
        if decimales<0 then decimales := 0;
        precOK := true;
   except
        precOK := false;
        Decimales := precisionMaxIncert;
        expValeurIng := 0;
        CoeffValeur := 1;
   end;
   valeurLoc := valeurLoc*CoeffValeur;
   tampon := FloatToStrF(valeurLoc,ffFixed,Decimales+3,Decimales);
   if precOK
      then begin
         tamponPrec := FloatToStrF(U95*CoeffValeur,ffFixed,Decimales+3,Decimales);
         tampon := tampon+' �'+tamponPrec;
      end
      else tampon := tampon+' ??';
   tampon := '('+tampon+')';
   if correct
      then tampon := tampon+NomAff(expValeurIng)
      else begin
          if expValeurIng<>0 then
             tampon:=tampon+'10'+puissToStr(expValeurIng);
          tampon:=tampon+' S.I.';
      end;
  result := nom+'='+tampon
end; // NomPrecisionUnite

function Tunite.PbUnite : boolean;
const
   iMax = 6;
   nomPb : array[0..imax] of string =
     ('h','heure','min','minute','j','jour','ua');
var i : integer;
begin
    for i := 0 to imax do begin
        result := nomUnite = nomPb[i];
        if result then exit;
    end;
end;

initialization
{$IFDEF Debug}
   ecritDebug('initialization uniteker');
{$ENDIF}
   InitUnite

finalization
   LibereUnite
end.

