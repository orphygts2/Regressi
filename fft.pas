Unit fft;

interface

uses windows, math, maths, sysUtils, classes, constreg, regutil,
     System.Generics.Collections;

// algorithme FFT fourni par Claude Cance, groupe Evariste

type Tfenetre = (rectangulaire,Hamming,FlatTop,Blackman,AjusteRect);
     TcalculFFT = (c_spectre,c_correlation,c_enveloppe);
     TordonneeFFT = (oAmplitude,oPuissance,oReduite);

const
      NbrePointsSonagramme = 1024;
      NbreMaxSonagramme = 1024;
      NbreHarmoniqueAffMax = 32;

var
      fenetre : Tfenetre = rectangulaire;
      ZeroPadding : boolean = false;
      avecReglagePeriode : boolean = false;
      avecPeriode : boolean = false;
      PrecisionFFT: double;
      NbreHarmoniqueAff: integer;

type
        EWavError = class(Exception);
        TformatWave = (f8,f16,f24,f32);
        TarraySon = array of single;
        TvecteurSon = class
             private
             FNbrePoints : longInt;
             public
             stereo : boolean;
             formatWave : TformatWave;
             freqAudio : longWord;
             valeur,valeurBis : TarraySon;
             fichierTronque : boolean;
             property NbrePoints : longInt read FNbrePoints;
             procedure lit(const NomFichier : string);
             procedure ecrit(const NomFichier : string);
             destructor Destroy; override;
        end;

        TmatriceSonagramme = array[0..NbreMaxSonagramme,0..NbrePointsSonagramme] of single;
        PmatriceSonagramme = ^TmatriceSonagramme;

  TlistePic = class
      private
      function getNbreAff : integer;
      function getNbre : integer;
      public
      picsH,picsF : TList<double>;
      index : integer;
      procedure Nettoie(fMax : double);
      procedure TriFrequence;
      procedure TriValeur;
      procedure Add(valF,valH : double);
      function proche(x,y : double;xmax : double) : integer;
      procedure Clear;
      Procedure CherchePicEnv(AA,AF : Tvecteur;FreqMax : double);
      property nbre : integer read getNbre;
      property nbreAff : integer read getNbreAff;
      constructor Create;
      destructor Destroy; override;
  end;


var son : PmatriceSonagramme;
    pasFreqSonagramme : double;
    PasSonagrammeAff : double;
    PasSonCalcul,pasSonCalculMax : integer;
    ZeroPaddingPermis : boolean;
    NbrePointsSonagrammeAff : integer;
    FreqMaxSonagramme : double;
    NbreSonagramme : integer;

Procedure Fourier(Debut,Fin,Maxi : integer;var NbreF : integer;var periode : double;
          T,X,F,Tlisse,Xlisse,Xr,Xi,Xa : Tvecteur;calculFFT : tcalculFFT);
Procedure FourierInverse(Nbre,NbreF,debutFFT : integer;periode : double;
          T,X,Xr,Xi : Tvecteur;calculFFT : tcalculFFT);
Procedure SpectrePhase(var ph : Tvecteur;Xr,Xi : Tvecteur;nb : integer);
Procedure EnveloppeFourier(Nbre,NbreMax : integer;Periode : double;X,F,A : Tvecteur);
Procedure Sonagramme(Nbre : integer;X : Tvecteur;FreqEch : double);
Function GetFondamental(Nbre : integer;Xa : Tvecteur) : integer;
Function GetMaxiFFT(Nbre : integer;Xa : Tvecteur) : double;
Procedure EnveloppeReelle(Nbre,NbreF : integer;periode : double;
                T,X,Xr,Xi : Tvecteur);// Norme du signal analytique

Implementation

const
    MaxVecteurSon = 4194304; // 2¨22  = 4 MaxMaxVecteur ; 4 Mo ; 1,5 minute à 44100 Hz

var
    coeffZeroPadding,coeffFenetrage : double;
    nbreFcourant : integer;
    fenetreCourante : Tfenetre;

Function PuissInt(X,N:integer) : integer; // X^N avec N>=0
var Y,i : integer;
begin
    Y := 1;
    for i := 1 to N do Y := Y*X;
    PuissInt := Y;
end;

var tbi : TvecteurInt;
    wr,wi,kf : Tvecteur;

Procedure spectrePhase(var ph : Tvecteur;Xr,Xi : Tvecteur;nb : integer);
var i : integer;
begin
    if high(ph)<nb then setLength(ph,nb);
    for i:=1 to pred(nb) do
        ph[i] := atan2(xi[i],xr[i]);
end;

procedure fenetrer(tableau,Xr,Xi : Tvecteur;nb : integer);
var j : integer;
    xx : double;
begin
     for j:=0 to pred(nb) do begin
         xx := kf[j]*tableau[j]; // fenêtrage
         tableau[j] := xx;
         xr[tbi[j]] := xx;
// rangement avec permutation des mesures tableau fenêtrées dans xr[]
         xi[j]:=0;
     end;
     try
     case fenetre of
           Hamming : coeffFenetrage := 1.852;
           Blackman : coeffFenetrage := 2.381;
           FlatTop : coeffFenetrage := 4.638;
           else coeffFenetrage := 1.0;
     end;
     if not(fenetre in [rectangulaire,AjusteRect]) then
        for j:=0 to pred(nb) do begin // renormaliser
           xr[j] := xr[j]*coeffFenetrage;
           tableau[j] := tableau[j]*coeffFenetrage;
        end;
      except
      end;  
end;

procedure fenetrerInverse(xr,xi : Tvecteur;nb : integer);
var j : integer;
    xxr,xxi : Tvecteur;
begin
     affecteVecteur(xxr,xr);
     affecteVecteur(xxi,xi);
     xr[0]:=2*xr[0];
     xi[0]:=2*xi[0];
     for j:=1 to pred(nb) do begin
         xr[tbi[j]]:=xxr[j];
         xi[tbi[j]]:=xxi[j];
// rangement avec permutation des mesures xr,xi dans xxr,xxi
     end;
     finalize(xxr);
     finalize(xxi);
end;

PROCEDURE tfd(nb : integer;xr,xi : Tvecteur;Normalise : boolean);
// Transformation proprement dite
var a,i,j,k,k0,nbbloc,tbloc,r,r0,p0,nombre0 : integer;
    zr,zi,c : double;
begin
  nbbloc:=nb;
  tbloc:=1;
  r:=trunc(0.5+Ln(nb)/ln(2));
  FOR i:=1 TO r do begin
          tbloc:=2*tbloc;
          nbbloc:=nbbloc div 2;
          FOR j:=1 TO nbbloc do begin
             nombre0:=(nb div nbbloc -1) div 2;
             r0:=0;
             FOR k0:=0 TO nombre0 do begin
                    k:=k0+(pred(j))*tbloc;
                    p0:=k+tbloc div 2;
                    a:=r0;
                    zr:=xr[p0]*wr[a]-xi[p0]*wi[a];
                    zi:=xr[p0]*wi[a]+xi[p0]*wr[a];
                    xr[p0]:=xr[k]-zr;
                    xi[p0]:=xi[k]-zi;
                    xr[k]:=xr[k]+zr;
                    xi[k]:=xi[k]+zi;
                    r0:=r0+nbbloc;
             end; {k0}
          end; {j}
  end; {i}
  if normalise
     then begin
         c:=2/nb;
         xr[0]:=xr[0]/2;
     end
     else c := 1/2;
  for i:= 0 to pred(nb) do begin
         xr[i]:=c*xr[i];
         xi[i]:=c*xi[i];
  end;
end;

PROCEDURE inverserIndices(nb : integer);
// Table de l'ordre inverse des bits
var i,j,k,r,p0,q,tiroir : integer;
    dpsn : double;
    Langle : double;
begin
  if (nbreFcourant=nb) and (fenetre=fenetreCourante) then exit;
  if high(wr)<nb then begin
     setLength(tbi,nb);
     setLength(wr,nb);
     setLength(wi,nb);
     setLength(kf,nb);
  end;
  dpsn:=-2*pi/nb;
  FOR i:=0 TO pred(nb) do begin
         Langle := dpsn*i;
         wr[i]:=cos(Langle);
         wi[i]:=sin(Langle);
// ATTENTION : les indices ne sont pas permutés
// la permutation selon tbi[] sera faite dans le fenêtrage
         case fenetre of
              Hamming : kf[i]:=0.54-0.46*cos(i*dpsn);
              Blackman : kf[i]:=0.42-0.5*cos(i*dpsn)+0.08*cos(2*i*dpsn);
              FlatTop : kf[i]:=0.2156-0.416*cos(i*dpsn)
                                     +0.2781*cos(2*i*dpsn)
                                     -0.0836*cos(3*i*dpsn)
                                     +0.069*cos(4*i*dpsn);
              else kf[i]:=1.0;
         end;
    end;
    for i:=0 to pred(nb) do tbi[i]:=i;
    r:=trunc(0.5+Ln(nb)/ln(2));
    for i:=0 to pred(nb) do begin
      p0:=r;
      q:=1;
      k:=0;
      for j:=1 to r do begin
           if (i and puissInt(2,pred(p0)))<>0 then k:=k+q;
           q:=2*q;
           dec(p0);
      end;
      if k>i then begin
            tiroir:=tbi[k];
            tbi[k]:=tbi[i];
            tbi[i]:=tiroir;
      end;
    end;
    nbreFcourant := nb;
    fenetreCourante := fenetre;
end; // inverserIndices

PROCEDURE inverserIndicesInverse(nb : integer);
// Table de l'ordre inverse des bits
var i,j,k,r,p0,q,tiroir : integer;
    dpsn : double;
begin
  if high(wr)<nb then begin
     setLength(tbi,nb);
     setLength(wr,nb);
     setLength(wi,nb);
     setLength(kf,nb);
  end;
  dpsn:=2*pi/nb;
  FOR i:=0 TO pred(nb) do begin
         wr[i]:=COS(dpsn*i);
         wi[i]:=SIN(dpsn*i);
  end;
  FOR i:=0 TO pred(nb) do tbi[i]:=i;
  r:=trunc(0.5+Ln(nb)/ln(2));
  FOR i:=0 TO pred(nb) do begin
      p0:=r;
      q:=1;
      k:=0;
      FOR j:=1 TO r do begin
           IF (i AND puissInt(2,pred(p0)))<>0 then k:=k+q;
           q:=2*q;
           dec(p0);
      end;
      IF k>i then begin
            tiroir:=tbi[k];
            tbi[k]:=tbi[i];
            tbi[i]:=tiroir;
      end;
  end;
  nbreFcourant := 0;
end; // inverserIndicesInverse

Procedure corrigeAmplitude(var freq,ampli,Yr,Yi : Tvecteur;var periode : double;NbreFFT : integer);
var i,imax,i0,iRef : integer;
    valeurMax,deltaF,maxA : double;
// En entrée freq et ampl les valeurs issues d'une FFT avec fenêtre rectangulaire
// En sortie on a remplacé les raies excentrées par non synchronisation par la "vraie" raie

function AjusteFrequence(var j1 : integer) : boolean;
var i,j2,j3 : integer;
    F0,A0 : double;
    phase0,argument,A : double;

Function sinCard(x : double) : double;
begin
   try
      if isZero(x,1e-6)
         then result := 1
         else result := sin(x)/x;
   except
      result := 1
   end;
end;

Function MyArcTan2(im,re:double) : double;
// z = re + j*im
begin
   if re=0
      then if im<0
          then result := -pi/2
          else result := pi/2
      else result := arcTan2(im,re);
end;

begin
    repeat
       inc(j1)
    until (j1>=imax) or
          ((ampli[j1+1]<ampli[j1]) and
           (ampli[j1]>valeurMax)); // maximum  local en j1
    result := j1<imax;
    if not result then exit;
    if ampli[j1-1]>ampli[j1+1] then j2 := j1-1 else j2 := j1+1;
    F0 := 1-(ampli[j1]/(ampli[j2]+ampli[j1]));
// F0>0 est ici l'écart / maxi du sinc
    A0 := ampli[j1]/sinCard(pi*F0);
    phase0 := MyArcTan2(Yi[j1],Yr[j1]);
// la non synchronisation crée également un déphasage de pi*(f0-f)*T
// T = 1/deltaf = 1 en numéro
    if j1>j2
       then begin
          phase0 := phase0+pi*F0;
          F0 := j1-F0
       end else begin
          phase0 := phase0-pi*F0;
          F0 := j1+F0;
       end;
 // F0 en numéro
    j2 := j1;
    repeat dec(j2)
    until (j2<=2) or (ampli[j2]<=ampli[j2-1]);
    j3 := j1;
    repeat inc(j3)
    until (j3>=imax) or (ampli[j3]<=ampli[j3+1]);
    for i := j2 to j3 do begin
       argument := pi*(F0-i);
       A := A0*sinCard(argument);
       argument := phase0+argument;
       Yr[i] := Yr[i]-A*cos(argument);
       Yi[i] := Yi[i]-A*sin(argument);
       ampli[i] := sqrt(sqr(Yr[i])+sqr(Yi[i]));
       freq[i] := (F0+i-j1)*deltaF; // F0 en Hz
       if Ampli[i]>maxA then begin
           iref := i;
           maxA := ampli[i];
       end;
    end;
    ampli[j1] := A0;
    Yr[j1] := A0*cos(phase0);
    Yi[j1] := A0*sin(phase0);
    freq[j1] := F0*deltaF; // F0 en Hz
    if A0>maxA then begin
       iref := j1;
       maxA := A0;
    end;
    j1 := j3;
end; // AjusteFrequence

begin
     deltaF := freq[1];
// ne marche pas dans le cas où fréquence signal de l'ordre du pas
     imax := (NbreFFT div 2) - 2;
     i0 := 0;
     repeat inc(i0)
     until (ampli[i0]>ampli[i0-1]) or (i0>=imax); // on évite le continu
     valeurMax := 0;
     maxA := 0;
     for i:= i0 to imax do
         if ampli[i]>valeurMax then valeurMax := ampli[i];
     valeurMax := valeurMax / 50;
     iRef := i0;
     while AjusteFrequence(i0) do;
     periode := iRef/Freq[iRef];
end; // corrigeAmplitude

Procedure Fourier(Debut,Fin,Maxi : integer;var NbreF : integer;var periode : double;
   T,X,F,Tlisse,Xlisse,Xr,Xi,Xa : Tvecteur;calculFFT : TcalculFFT);
var Nbre : integer;

Procedure SetZero;
var deltat : double;
    i : integer;
begin
     NbreF := Puiss2Sup(Nbre);
     if (calculFFT=c_correlation) and
        (2*NbreF<=Maxi) then NbreF := 2*NbreF;
// Interdit pour spectre car on obtient le spectre du signal discrétisé 
     Deltat := Periode/Nbre;
     Periode := NbreF*deltat;
     for i := 0 to pred(Nbre) do begin
           Xlisse[i] := X[i+debut];
           Tlisse[i] := T[i+debut];
     end;
     for i := Nbre to pred(NbreF) do begin
           Xlisse[i] := 0;
           Tlisse[i] := Tlisse[0]+i*deltat;
     end;
     ZeroPadding := true;
end;

Procedure setInterp;
begin
      NbreF := Puiss2Sup(Nbre);
//      if sincPermis then CalculIntSinc(T,X,Debut,Fin,NbreF,TLisse,XLisse)
      CalculIntLineaire(T,X,Debut,Fin,NbreF,Tlisse,Xlisse);
      ZeroPadding := false;
      coeffZeroPadding := 1;
end;

var i : integer;
    Df : double;
begin // Fourier
     Nbre := Fin-Debut+1;
     Periode := (T[fin-1]-T[debut])/(fin-1-debut)*Nbre;
     case calculFFT of
          c_spectre : if zeroPaddingPermis
             then setZero
             else setInterp;
          c_correlation : setZero; // zeroPadding obligatoire pour corrélation
          c_enveloppe : setInterp;
     end;
     inverserIndices(NbreF);
     fenetrer(Xlisse,xr,xi,NbreF);
  { TODO : Gérer fenétrage ET zéro padding }
     tfd(NbreF,xr,xi,true);
     Df := 1/periode;
     if zeroPadding then begin
          coeffZeroPadding := NbreF/Nbre;
          for i := 0 to NbreF div 2 do begin
              xr[i] := xr[i]*coeffZeroPadding;
              xi[i] := xi[i]*coeffZeroPadding;
          end;
     end;
     if high(Xa)<NbreF div 2 then setLength(Xa,NbreF div 2);
     for i := 0 to (NbreF div 2) do begin
         F[i] := i*Df;
         Xa[i]:=sqrt(sqr(xr[i])+sqr(xi[i]));
     end;
     if fenetre=AjusteRect then corrigeAmplitude(f,Xa,xr,xi,periode,NbreF);
end; // Fourier

(*
Procedure FourierFiltre(Nbre : integer;var periode : double;
   T,X,Xr,Xi : vecteur);
begin
     Periode := (T[Nbre-1]-T[0])/pred(Nbre)*Nbre;
     inverserIndices(Nbre);
     fenetrer(X,xr,xi,Nbre);
     tfd(Nbre,xr,xi,true);
end;
*)

Procedure FourierInverse(Nbre,NbreF,debutFFT : integer;Periode : double;
      T,X,Xr,Xi : Tvecteur;calculFFT : tcalculFFT);
var i : integer;
    iAvant,iApres : integer;
    deltat,ecart : double;
    xxr,xxi : Tvecteur;
begin
     affecteVecteur(xxr,xr);
     affecteVecteur(xxi,xi);
     inverserIndicesInverse(NbreF);
     fenetrerInverse(xxr,xxi,NbreF);
     tfd(NbreF,xxr,xxi,false);
     case calculFFT of
          c_spectre : zeroPadding := true;
          c_correlation : zeroPadding := true;
          c_enveloppe : zeroPadding := false;
     end;
     if zeroPadding then begin
          coeffZeroPadding := Nbre/NbreF;
          for i := 0 to pred(NbreF) do
              xxr[i] := xxr[i]*coeffZeroPadding;
     end
     else coeffZeroPadding := 1;
     if not(fenetre in [Rectangulaire,AjusteRect]) then
        for i := 0 to pred(NbreF) do
            xxr[i] := xxr[i]/kf[i]/coeffFenetrage;
     deltat := Periode/NbreF; // NbreF et non Nbre à cause choix de période et interpolation
     for i := 0 to pred(Nbre) do begin
         iAvant := trunc((T[i]-T[debutFFT])/deltat);
         ecart := T[i]-T[debutFFT]-iAvant*deltat;
         iAvant := iAvant mod NbreF; // périodiser
         if iAvant<0 then inc(iAvant,NbreF);
         iApres := succ(iAvant) mod NbreF;
         x[i] := xxr[iAvant]+(xxr[iApres]-xxr[iAvant])*ecart/deltat; // interpoler
     end;
     finalize(xxr);finalize(xxi);
end;

Procedure EnveloppeFourier(Nbre,NbreMax : integer;Periode : double;X,F,A : Tvecteur);
var i : integer;
    Df,coeff : double;
    xr,xi : Tvecteur;
    xLisse : Tvecteur;
    sauveFenetre : Tfenetre;
begin
     setLength(xLisse,NbreMax);
     setLength(xr,NbreMax);
     setLength(xi,NbreMax);
     sauveFenetre := fenetre;
     fenetre := rectangulaire;
     affecteVecteur(Xlisse,X);
     for i := Nbre to pred(NbreMax) do Xlisse[i] := 0;
     inverserIndices(NbreMax);
     fenetrer(Xlisse,xr,xi,NbreMax);
     tfd(NbreMax,xr,xi,true);
     Df := Nbre/NbreMax/Periode;
     coeff := NbreMax/Nbre;
     zeroPadding := true;
     coeff := coeff*coeffZeroPadding;
     for i := 0 to NbreMax div 2 do begin
         F[i] := i*Df;
         A[i] := sqrt(sqr(Xr[i])+sqr(Xi[i]))*coeff;
     end;
     fenetre := sauveFenetre;
     finalize(Xlisse);
     finalize(Xr);
     finalize(Xi);
end;

Procedure Sonagramme(Nbre : integer;X : Tvecteur;FreqEch : double);
var Xlisse : Tvecteur;
    Xr,Xi,Xa,coeffWin : Tvecteur;
    NbreCalcul,pas : integer;
  //decalage : integer;

PROCEDURE fenetrageSon; // Hamming
var i,N : longInt;
    dpsn : double;
begin
  N := NbreCalcul div pas;
  dpsn := -2*pi/N;
  for i := 0 to pred(N) do
      coeffWin[i] := 0.54-0.46*cos(i*dpsn);
 // donc 0,08 sur les bords et 1 au centre
end;

Procedure FourierSonagramme(debut : longInt);
var i,j,N : longInt;
  //  decale : longInt;
begin
     N := NbreCalcul div pas;
    // decale := debut-decalage;
    // if decale<0 then decale := 0;
     if (N*pas+debut)>Nbre then N := (Nbre-debut) div pas;
     for i := 0 to pred(N) do
         Xlisse[i] := coeffWin[i]*X[i*pas+debut];
     for i := N to pred(NbrePointsSonagramme) do
         Xlisse[i] := 0;
     for j:=0 to pred(NbrePointsSonagramme) do begin
         xr[tbi[j]] := Xlisse[j];
// rangement avec permutation des mesures tableau fenêtrées dans xr[]
         xi[j]:=0;
     end;
     tfd(NbrePointsSonagramme,xr,xi,false);
     for i := 0 to (NbrePointsSonagramme div 2) do
         Xa[i]:=sqrt(sqr(xr[i])+sqr(xi[i]));
end; // FourierSonagramme

var i,j : integer;
    sonMax : double;
begin
    try
    if son=nil then new(son);                             
    inverserIndices(NbrePointsSonagramme);
    sonMax := 0;
    if FreqMaxSonagramme>FreqEch/2 then FreqMaxSonagramme := FreqEch/2;
    NbrePointsSonagrammeAff := round(pasSonagrammeAff*FreqEch);
    if NbrePointsSonagrammeAff<32 then NbrePointsSonagrammeAff := 32;
    pasSonCalculMax := NbrePointsSonagramme div NbrePointsSonagrammeAff;
    if pasSonCalculMax>8 then pasSonCalculMax := 8;
    if pasSonCalculMax<1 then pasSonCalculMax := 1;
    NbreCalcul := pasSonCalcul*NbrePointsSonagrammeAff;
//    Decalage := (NbreCalcul-NbrePointsSonagrammeAff) div 2;
    pas := succ(NbreCalcul div NbrePointsSonagramme);
// si trop de points, prendre un point sur pas
    NbreSonagramme := (Nbre-1) div NbrePointsSonagrammeAff;
    if NbreSonagramme>NbreMaxSonagramme then NbreSonagramme := NbreMaxSonagramme;
    setLength(Xr,NbrePointsSonagramme);
    setLength(Xi,NbrePointsSonagramme);
    setLength(Xa,NbrePointsSonagramme);
    setLength(coeffWin,NbrePointsSonagramme);
    setLength(Xlisse,NbrePointsSonagramme);
    fenetrageSon;
    for i := 0 to pred(NbreSonagramme) do begin
        FourierSonagramme(i*NbrePointsSonagrammeAff);
        son[i,0] := Xa[0]; // continu non pris en compte
        for j := 1 to pred(NbrePointsSonagramme div 2) do begin
            if Xa[j]>sonMax then sonMax := Xa[j];
            son[i,j] := Xa[j];
        end;
    end;
    pasFreqSonagramme := NbrePointsSonagrammeAff/NbrePointsSonagramme/pasSonagrammeAff/pas;
    for i := 0 to pred(NbreSonagramme) do
       for j := 1 to pred(NbrePointsSonagramme div 2) do
           son[i,j] := son[i,j]/sonMax; // entre 0 et 1
    finalize(Xr);finalize(Xi);finalize(Xa);
    finalize(Xlisse);
    NbreFcourant := 0;
    except
    end;
end;// Sonagramme

Function GetFondamental(Nbre : integer;Xa : Tvecteur) : integer;

function affine(i : integer) : integer;
var maxi : double;
    j : integer;
begin
    result := i;
    if i<4 then exit;
    maxi := Xa[i];
    for j := i-3 to i+3 do
        if Xa[j]>maxi then begin
           result := j;
           maxi := Xa[j];
        end;
end;

var i,i0,imax,imin : integer;
    maxi,s : double;
begin
   maxi := 0;
   imax := Nbre div 4; // i à ne pas dépasser
   imin := Nbre div 64; // i à ne pas dépasser
   i0 := 1;
   for i := imin to imax do
       if Xa[i]>maxi then begin
          maxi := Xa[i];
          i0 := i;
       end;
   if i0>=2 then begin // on a en fait trouvé l'harmonique 2 ?
       s := Xa[i0 div 2]+Xa[3*i0 div 2]+Xa[5*i0 div 2];
   { en fait i0=harm2 3*i0/2=harm3 ; i0/2 fondamental ; 5*i0/2 harm5
     on ne teste pas 4*i0/2 qui est hamr2 de i0 }
       if s>maxi/2 then i0 := affine(i0 div 2);
   end;
   if i0>=3 then begin // on a en fait trouvé l'harmonique 3 ?
       s := Xa[i0 div 3]+Xa[2*i0 div 3]+Xa[4*i0 div 3];
   { en fait i0=harm3 2*i0/3=harm2 ; i0/3 fondamental ; 4*i0/3 harm4 }
       if s>maxi/2 then i0 := affine(i0 div 3);
   end;
   if i0>=4 then begin // on a en fait trouvé l'harmonique 4 ?
       s := Xa[i0 div 4]+Xa[2*i0 div 4]+Xa[3*i0 div 4];
   { en fait i0=harm4 i0/4=harm1 ; 2*i0/4 harm2 ; 3*i0/4 harm3 }
       if s>maxi/2 then i0 := affine(i0 div 4);
   end;
   if i0>=imax then i0 := 1;
   result := i0;
end;

Function GetMaxiFFT(Nbre : integer;Xa : Tvecteur) : double; // sans prendre en compte le continu
var i,idebut,imax : integer;
    maxi : double;
    termine,secondEssai : boolean;
    i0 : integer;
begin
   maxi := 0;
   idebut := 0;
   repeat inc(idebut) until (idebut>(nbre)) or (Xa[idebut]>Xa[idebut-1]);
   for i := idebut to pred(Nbre) do
       if Xa[i]>maxi then maxi := Xa[i];
   maxi := maxi/2;
   i := idebut;
   imax := Nbre div 3;
   repeat inc(i)
   until (i=imax) or (Xa[i]>maxi);
// début du premier pic
   i0 := i;
   maxi := Xa[i];
   secondEssai := true;
   repeat
      inc(i);
      if Xa[i]>maxi
         then begin
           i0 := i;
           maxi := Xa[i];
           secondEssai := true;
           termine := false;
         end
         else begin
           termine := not secondEssai;
           secondEssai := false;
         end;
   until (i>imax) or termine;
// maxi du pic
   if i>=imax then i0 := 1;
   result := Xa[i0];
end;

Procedure EnveloppeReelle(Nbre,NbreF : integer;Periode : double;
                T,X,Xr,Xi : Tvecteur);
var i : integer;
    iAvant,iApres : integer;
    deltat,ecart : double;
    xxr,xxi : Tvecteur;
    xre,xim,continu : double;
begin
     affecteVecteur(xxr,xr);
     affecteVecteur(xxi,xi);
     continu := xxr[0];
     for i := 1 to pred(NbreF div 16) do begin
         xxr[i] := 2*xxr[i];
         xxi[i] := 2*xxi[i];
     end;
     for i := (NbreF div 16) to pred(NbreF) do begin
     // signal analytique f>0 ; composantes f<0 nulles
     // on en profite pour filtrer les HF : 7/8 * Fmax
         xxr[i] := 0;
         xxi[i] := 0;
     end;
     xxr[0] := 0;
     xxi[0] := 0;
     inverserIndicesInverse(NbreF);
     fenetrerInverse(xxr,xxi,NbreF);
     tfd(NbreF,xxr,xxi,false);
     if zeroPadding then begin
        coeffZeroPadding := Nbre/NbreF;
        for i := 0 to pred(NbreF div 2) do begin
           xxr[i] := xxr[i]*coeffZeroPadding;
           xxi[i] := xxi[i]*coeffZeroPadding;
        end;
     end
     else coeffZeroPadding := 1;
     deltat := Periode/NbreF;
// NbreF et non Nbre à cause choix de période et interpolation
     for i := 0 to pred(Nbre) do begin
         iAvant := trunc((T[i]-T[0])/deltat);
         ecart := T[i]-T[0]-iAvant*deltat;
         iAvant := iAvant mod NbreF; // périodiser
         if iAvant<0 then inc(iAvant,NbreF);
         iApres := succ(iAvant) mod NbreF;
         xre := xxr[iAvant]+(xxr[iApres]-xxr[iAvant])*ecart/deltat; // interpoler
         xim := xxi[iAvant]+(xxi[iApres]-xxi[iAvant])*ecart/deltat;// interpoler
         X[i] := sqrt(sqr(xre)+sqr(xim))+continu;
     end;
     finalize(xxr);finalize(xxi);
end;

Procedure TVecteurSon.lit(const NomFichier : string);

var taille,N : longInt;
    Nbits,Nvoie : byte;
    texte : ansiString;
    i,j : integer;
    octet : byte;
    Hfichier : integer;
    son8 : array of byte;
    son16 : array of smallInt;
    son32 : array of single;
    testPCM : byte;

begin
     FNbrePoints := 0;
     if not(FileExists(NomFichier)) then
        raise EWavError.create(erFileExists);
     Hfichier := FileOpen(NomFichier,fmOpenRead);
     if HFichier<0 then
        raise EWavError.create(erOuverturewav);
     son8 := nil;
     son16 := nil;
     son32 := nil;
     valeur := nil;
     valeurBis := nil;
     FileSeek(Hfichier,16,0);
     FileRead(Hfichier,testPCM,1);
     if testPCM<>16 then begin
         FileClose(Hfichier);
         raise EWavError.create(erFormatPCM);
     end;
     FileSeek(Hfichier,20,0);
     FileRead(Hfichier,testPCM,1);
     if not (testPCM in [1,3]) then begin
        FileClose(Hfichier);
        raise EWavError.create(erFormatPCM);
     end;
     FileSeek(Hfichier,4,0);
     FileRead(Hfichier,taille,4);
     FileSeek(Hfichier,24,0);
     FileRead(Hfichier,FreqAudio,4);
     FileSeek(Hfichier,34,0);
     FileRead(Hfichier,Nbits,1);
     if Nbits=8
        then formatWave := f8
        else if Nbits=16
             then formatWave := f16
             else if Nbits=24
                 then formatWave := f24
             else if Nbits=32
                 then formatWave := f32
                 else begin
                    FileClose(Hfichier);
                    raise EWavError.create(erFormatPCM+' 8/16/24/32 bits');
                 end;
     FileSeek(Hfichier,22,0);
     FileRead(Hfichier,Nvoie,1);
     stereo := Nvoie=2;
     FileSeek(Hfichier,36,0);
     texte := '';
     for i := 1 to 4 do begin
         FileRead(Hfichier,octet,1);
         texte := texte+ansiChar(octet);
     end;
     i := 40;
     while (i<taille) and (texte<>'data') do begin
          delete(texte,1,1);
          FileRead(Hfichier,octet,1);
          texte := texte+ansiChar(octet);
          inc(i);
     end;
     if i>=taille then begin
         FileClose(Hfichier);
         raise EWavError.create(erLecturewav);
     end;
    FileRead(Hfichier,FNbrePoints,4); // Nombre de points en octets
    N := FNbrePoints;
    case formatWave of
        f8 : if stereo
           then begin if FNbrePoints>2*MaxVecteurSon then FNbrePoints := 2*MaxVecteurSon end
           else if FNbrePoints>MaxVecteurSon then FNbrePoints := MaxVecteurSon;
        f16 : if stereo
           then begin if FNbrePoints>4*MaxVecteurSon then FNbrePoints := 4*MaxVecteurSon end
           else if FNbrePoints>2*MaxVecteurSon then FNbrePoints := 2*MaxVecteurSon;
        f24 : if stereo
           then begin if FNbrePoints>6*MaxVecteurSon then FNbrePoints := 6*MaxVecteurSon end
           else if FNbrePoints>3*MaxVecteurSon then FNbrePoints := 3*MaxVecteurSon;
        f32 : if stereo
           then begin if FNbrePoints>8*MaxVecteurSon then FNbrePoints := 8*MaxVecteurSon end
           else if FNbrePoints>4*MaxVecteurSon then FNbrePoints := 4*MaxVecteurSon;
    end;
    FichierTronque := FNbrePoints<N;
    case formatWave of
        f8 : setLength(son8,FNbrePoints);
        f16 : setLength(son16,FNbrePoints div 2);
        f24 : setLength(son8,FNbrePoints);
        f32 : setLength(son32,FNbrePoints div 4); // single 4 octets
    end;
    case formatWave of
        f8 : begin
           FNbrePoints := FileRead(Hfichier, son8[0], FNbrePoints);
        end;
        f16 : begin
           FNbrePoints := FileRead(Hfichier, son16[0], FNbrePoints);
           FNbrePoints := FNbrePoints div 2;
        end;
        f24 : begin
           FNbrePoints := FileRead(Hfichier, son8, FNbrePoints);
           FNbrePoints := FNbrePoints div 3;
        end;
        f32 : begin
           FNbrePoints := FileRead(Hfichier, son32[0], FNbrePoints);
           FNbrePoints := FNbrePoints div 4;
        end;
     end;
     if stereo then FNbrePoints := FNbrePoints div 2;
     setLength(valeur,FNbrePoints);
     if stereo then setLength(valeurBis,FNbrePoints);
     case formatWave of
        f8 : if stereo
          then for i := 0 to FNbrePoints-1 do begin
            valeur[i] := (son8[2*i]-128)/128;
            valeurBis[i] := (son8[2*i+1]-128)/128;
          end
          else for i := 0 to FNbrePoints-1 do
            valeur[i] := (son8[i]-128)/128;
        f16 : if stereo
           then for i := 0 to FNbrePoints-1 do begin
            valeur[i] := son16[2*i]/32768;
            valeurBis[i] := son16[2*i+1]/32768;
           end
           else for i := 0 to FNbrePoints-1 do
            valeur[i] := son16[i]/32768;
        f24 : if stereo
           then for i := 0 to FNbrePoints-1 do begin
                j := 6*i;
                valeur[i] := (son8[j]+256*(son8[j+1]+256*son8[j+2]))/8388608;
                valeurBis[i] := (son8[j+3]+256*(son8[j+4]+256*son8[j+5]))/8388608;
           end
           else for i := 0 to FNbrePoints do begin
                j := 3*i;
                valeur[i] := (son8[j]+256*(son8[j+1]+256*son8[j+2]))/8388608;
           end;
         f32 : if stereo
           then for i := 0 to FNbrePoints-1 do begin
                valeur[i] := son32[2*i];
                valeurBis[i] := son32[2*i+1];
           end
           else for i := 0 to FNbrePoints do
                valeur[i] := son32[i];
     end;
     FileClose(Hfichier);
     son8 := nil;
     son16 := nil;
     son32 := nil;
end;

destructor TvecteurSon.Destroy;
begin
    valeur := nil;
    valeurBis := nil;
    inherited
end;

constructor TlistePic.create;
begin
   picsF := TList<double>.create;
   picsH := TList<double>.create;
end;

destructor TlistePic.destroy;
begin
   picsF.Free;
   picsH.Free;
   inherited
end;

Procedure TlistePic.Nettoie(fMax : double);
var deltaf : double;

procedure supprime(k : integer);
begin
     picsH.Delete(k);
     picsF.Delete(k);
end;

var k : integer;
    picmax : double;
    fMaxHarm : double;
begin
    if picsF.Count=0 then exit;
    deltaf := fMax / 100;
    fMaxHarm := fMax;
    picmax := picsH[0];
    for k := 1 to pred(picsF.Count) do
        if picsH[k]>picmax then begin
           picmax := picsH[k];
           fMaxHarm := picsF[k];
        end;
    if deltaf>fmaxHarm/4 then deltaf := fmaxHarm/4;
    k := 0;
    while (k<(picsF.Count-2)) do begin
        if (picsF[k+1]-picsF[k])<deltaf
           then if (picsH[k+1]>picsH[k])
               then supprime(k)
               else supprime(k+1)
        else inc(k);
    end;
end;

Procedure TlistePic.TriValeur;
// Tri Shell Meyer-Baudoin p 456 selon valeurH
var increment : integer;
    cle : double;
    sauvePicH,sauvePicF : double;
    i,j,k,FNbre : integer;
Begin
   increment := 1;
   FNbre := picsH.Count;
   while ( increment<(FNbre div 3) ) do increment := succ(3*increment);
   repeat
	  for k := 0 to pred(increment) do begin
		  i := increment+k;
		  while (i<Nbre) do begin
			  sauvePicH := picsH[i];
        sauvePicF := picsF[i];
			  cle := picsH[i];
			  j := i-increment;
			  while (j>=0) and (picsH[j]<cle) do begin
				  picsH[j+increment] := picsH[j];
          picsF[j+increment] := picsF[j];
				  dec(j,increment);
			  end;
			  picsH[j+increment] := sauvePicH;
        picsF[j+increment] := sauvePicF;
			  inc(i,increment);
		   end;
	  end;
	  increment := increment div 3;
   Until increment=0;
   if FNbre>128 then begin // supprimer l'excédent
      for i := pred(Fnbre) downto 128 do begin
          picsH.Delete(i);
          picsF.Delete(i);
      end;
   end;
end; // triValeur

Procedure TlistePic.TriFrequence;
// Tri Shell Meyer-Baudoin p 456 selon valeurH
var increment : integer;
    cle : double;
    sauvePicH,sauvePicF : double;
    i,j,k,FNbre : integer;
Begin
   increment := 1;
   FNbre := picsH.Count;
   while ( increment<(Nbre div 3) ) do increment := succ(3*increment);
   repeat
	  for k := 0 to pred(increment) do begin
		  i := increment+k;
		  while (i<FNbre) do begin
			  sauvePicH := picsH[i];
        sauvePicF := picsF[i];
			  cle := picsF[i];
			  j := i-increment;
			  while (j>=0) and (picsF[j]<cle) do begin
				  picsH[j+increment] := picsH[j];
          picsF[j+increment] := picsF[j];
				  dec(j,increment);
			  end;
			  picsH[j+increment] := sauvePicH;
        picsF[j+increment] := sauvePicF;
			  inc(i,increment);
		   end;
	  end;
	  increment := increment div 3;
   Until increment=0;
end;

function TlistePic.getNbreAff : integer;
begin
   if picsH.count>NbreHarmoniqueAff
      then result := NbreHarmoniqueAff
      else result := picsH.count;
end;

function TlistePic.getNbre : integer;
begin
   result := picsH.count
end;

Procedure TListePic.CherchePicEnv(AA,AF : Tvecteur;FreqMax : double);
var ligne,i0,FNbre : integer;
    z,zprecedent,zsuivant : double;
    maxiA : double;
    ligne0 : integer;
begin
      FNbre := picsH.Count;
      i0 := getFondamental(FNbre,Aa);
      maxiA := Aa[i0]*precisionFFT;
      ligne0 := i0 div 8;
      if ligne0=0 then ligne0 := 1;
      z := Aa[ligne0];
      zsuivant := Aa[ligne0+1];
      for ligne := succ(ligne0) to (FNbre-2) do begin
          zprecedent := z;
          z := zsuivant;
          zsuivant := Aa[ligne+1];
          if (z>maxiA) and
             (z>zprecedent) and
             (z>zsuivant) then begin
                Add(Af[ligne],Aa[ligne]);
             end;
      end;  // tous les pics plus grands que maxi*precision
      Nettoie(FreqMax);
      TriValeur;
end; // CherchePicEnv

procedure TListePic.Add(valF,valH : double);
begin
    picsF.Add(valF);
    picsH.Add(valH);
end;

procedure TListePic.Clear;
begin
  picsH.clear;
  picsF.Clear;
end;

function TListePic.proche(x,y : double;xmax : double) : integer;
var i,Fnbre : integer;
    ecart,ecartMin,coeffX : double;
begin
    result := -1;
    Fnbre := picsH.Count;
    coeffX := 1/xmax; // >0 !
    ecartMin := 0.02;
    for i := 0 to pred(Fnbre) do begin
        ecart := abs(x-picsF[i])*coeffX;
        if ecart<ecartMin then begin
           ecartMin := ecart;
           result := i;
        end;
    end;
end;

procedure TvecteurSon.ecrit(const nomFichier : string);
const sampleSize = 2; // 16 bits
var Hfichier : integer;

Procedure EcritFichier;

Procedure EcritTexte(const texte : shortString);
var i,z : byte;
begin
   for i := 1 to length(texte) do begin
       z := ord(texte[i]);
       FileWrite(Hfichier,z,1)
   end
end;

Procedure EcritOctet(octet : byte);
begin
   FileWrite(Hfichier,octet,1)
end;

Procedure EcritLongMot(mot : longWord);
begin
   FileWrite(Hfichier,mot,4)
end;

Procedure EcritMot(mot : Word);
begin
   FileWrite(Hfichier,mot,2)
end;

var i : LongInt;
    entier : smallInt;
begin
{ 0..3 riff }
     ecritTexte('RIFF');
{ 4..7 taille en octets poids faible en premier }
     ecritLongMot(LongWord(NbrePoints*sampleSize+36));
{ taille de ce qui suit d'où
  +36 = 44 octets de codage - les 8 précédents
  *sampleSize = octets par échantillon }
{ 8..15 WAVEFMT }
     ecritTexte('WAVEfmt ');
{ 16..19 16,0,0,0 : size les 16 octets qui suivent }
     ecritLongMot(16);
{ 20..23 1,0,1 ou 2,0 (4) }
     ecritOctet(1); { formatTag }
     ecritOctet(0);
     ecritOctet(1); { formatTag }
     ecritOctet(0);
{ 24..27 fréquence poids faible en premier en échantillons }
     ecritLongMot(FreqAudio);
{ 28..31 fréquence poids faible en premier en octets }
     ecritLongMot(LongWord(FreqAudio*sampleSize));
{ 32..33  block align sur sampleSize octets }
     ecritMot(sampleSize);
{ 34..35 8 ou 16 Nombre de bits }
     ecritMot(16);
{ 36 39 "data" }
     EcritTexte('data');
{ 40..43 nbre échantillon }
     ecritLongMot(LongWord(NbrePoints*sampleSize));
     for i := 0 to pred(NbrePoints) do begin
         entier := round(valeur[i]*32768); // double entre -1 +1 à convertir entre +-32768
         FileWrite(Hfichier,entier,2);
     end;
end;

var F : TextFile;
begin
     if not FileExists(nomFichier) then begin
        AssignFile(F,nomFichier);
        Rewrite(F);
        write(F,'RIFF');
        CloseFile(F);
     end;
     Hfichier := FileOpen(nomFichier,fmOpenWrite);
     if HFichier>0 then begin
         EcritFichier;
         FileClose(Hfichier);
     end
end;


initialization
{$IFDEF Debug}
   ecritDebug('initialization fft');
{$ENDIF}
     setLength(tbi,MaxVecteurDefaut);
     setLength(wr,MaxVecteurDefaut);
     setLength(wi,MaxVecteurDefaut);
     setLength(kf,MaxVecteurDefaut);
     PasSonagrammeAff := 0.03; // 30 ms
     PasSonCalcul := 1;
     nbreFcourant := 0;
     PrecisionFFT := 0.05;
     fenetreCourante := rectangulaire;
     FreqMaxSonagramme := 11000;
     PasFreqSonagramme := 100;

Finalization
     finalize(tbi);
     finalize(wr);
     finalize(wi);
     finalize(kf);
end.

