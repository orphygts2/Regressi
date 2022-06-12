unit statcalc;

interface

uses sysUtils, math, fspec,
     constreg, maths, regutil;

Const
      MaxConfiance  = 1;
      MinConfiance  = 2;
      MaxPrediction = 3;
      MinPrediction = 4;
      MaxHisto = 256;
// Les bornes vont de 0 à MaxHisto et les classes de 1 à MaxHisto
//  Classe i = entre bornes(pred(i)) et bornes(i)

type
  TClasseStat = (csAuto,csNombreImpose,csEcartImpose,csEffectifDonne,csFrequenceDonnee,csSigma);

  TcalculStatistique = class
      private
      FNbre : integer;
      FNbreTotal : integer;
      FpourCent : boolean;
      procedure setNbre(Anbre : integer);
      public
      Min,Max,Moyenne,Mediane,Sigma,t95,t99,ecartMoyen : double;
      ClasseStat : TclasseStat;
      Donnees,Effectif : Tvecteur;
      Cible,EcartDist,DebutDist,maxDist : double;
      NbreClasse : integer;
      MoyDist,NbreDist,BornesDist,DistPourCent : Tvecteur;
      StatOK,avecTri,DataInteger : boolean;
      property Nbre : integer read Fnbre write setNbre;
      property Ntotal : integer read FNbreTotal;
      constructor Create;
      destructor Destroy; override;
      Procedure TestDataEntier;
      Function TestEffectif : boolean;
      Function TestFrequence : boolean;
      Procedure Calcul;
      Procedure SetValeur(Valeur : Tvecteur;Nmes : integer;withTri : boolean);
      Procedure SetValeurEffectif(Valeur,valEff : Tvecteur;Nmes : integer);
      procedure setTaille(ataille : integer);
  end;

   TcalculStatistiqueResidu = class
      private
      FNbre : integer;
      FNbreParam : integer;
      public
      Min,Max : double;
      Residus,X,Incertitudes,ResidusStudent,ResidusNormalises : Tvecteur;
      StatOK : boolean;
      avecIncert : boolean;
      t95 : double;
      property Nbre : integer read Fnbre;
      constructor Create;
      destructor Destroy; override;
      Procedure Calcul;
      Procedure SetValeur(ANbre,NParam : integer);
  end;

  TStatistiqueDeuxVar = class
      private
      Sy,Sy2,Sx,Sx2,Sxx,Syy,sigma : double;
      U95Pente,U95Y0,covariance95PenteY0 : double;
      SSE,SSR : double;
      xmoyen,ymoyen : double;
      X,Y : Tvecteur;
      Fcorrelation : double;
      FFisher : double;
   //   FFisherZ : double;
      FpvalueFisher : double;
      FNbre : integer;
      public
      covariance,pente,Y0 : double;
      sigmaPente,sigmaY0 : double;
      covariancePenteY0 : double;
      Property Correlation : double read Fcorrelation;
      Property Fisher : double read FFisher;
      Property pValueFisher : double read FpValueFisher;
      Procedure Init(ax,ay : Tvecteur;debut,fin : integer);
      Procedure GenereBande(Xmin,Ymin,Xmax,Ymax : Tvecteur;Fin : integer;confiance : boolean);
      property Nbre : integer read Fnbre;
  end;

Procedure CalcCornish(X,Y : Tvecteur;N : integer;var K,V : Tvecteur;var ANbre : integer);
Procedure CalcCornishInters(X,Y : Tvecteur;N : integer;var Km,Vm : double);

implementation

const
  MaxVecteurStat = 2048;

constructor TcalculStatistique.Create;
begin
   inherited create;
   setTaille(MaxHisto);
   ClasseStat := csAuto;
   Cible := Nan;
   StatOK := false;
   setLength(Effectif,MaxVecteurStat+1);
end;

procedure TcalculStatistique.setTaille(ataille : integer);
begin
   inc(aTaille);
   if aTaille<maxHisto then aTaille := MaxHisto;
   setLength(MoyDist,aTaille);
   setLength(NbreDist,aTaille);
   setLength(DistPourCent,aTaille);
   setLength(BornesDist,aTaille);
end;

constructor TcalculStatistiqueResidu.Create;
begin
   inherited create;
   setLength(Residus,MaxVecteurStat+1);
   setLength(ResidusStudent,MaxVecteurStat+1);
   setLength(ResidusNormalises,MaxVecteurStat+1);
   setLength(incertitudes,MaxVecteurStat+1);
   setLength(X,MaxVecteurStat+1);
   StatOK := false;
end;

procedure TcalculStatistique.Calcul;

Procedure CalculStat;
var i,imilieu : integer;
    total : double;
begin
   min := Donnees[0];
   max := Donnees[pred(FNbre)];
   moyenne := 0;
   mediane := Donnees[0];
   Sigma := 0;
   if FNbre<2 then exit;
   iMilieu := FNbre div 2;
   if odd(FNbre)
          then Mediane := Donnees[iMilieu]
          else Mediane := (Donnees[iMilieu]+Donnees[pred(iMilieu)])/2;
   for i := 0 to pred(FNbre) do begin
       moyenne := moyenne+Donnees[i];
       sigma := sigma+sqr(Donnees[i]);
       if Donnees[i]<Min then Min := Donnees[i];
       if Donnees[i]>Min then Max := Donnees[i];
   end;
   sigma := sqrt((sigma-sqr(moyenne)/FNbre)/pred(FNbre));
   moyenne := moyenne/FNbre;
   t99 := Sigma*Student99(FNbre-1)/sqrt(FNbre);
   t95 := Sigma*Student95(FNbre-1)/sqrt(FNbre);
   FNbreTotal := Fnbre;
   total := 0;
   for i := 0 to pred(FNbre) do
       total := total+abs(Donnees[i]-moyenne);
   ecartMoyen := total/Fnbre;
end;

Procedure CalculStatEffectif;
var i,imilieu,n : integer;
begin
   min := Donnees[0];
   max := Donnees[pred(FNbre)];
   moyenne := 0;
   FNbreTotal := 0;
   mediane := Donnees[0];
   Sigma := 0;
   maxDist := 0;
   if FNbre<2 then exit;
   for i := 0 to pred(FNbre) do begin
       FNbreTotal := FNbreTotal+round(effectif[i]);
       moyenne := moyenne+Effectif[i]*Donnees[i];
       sigma := sigma+Effectif[i]*sqr(Donnees[i]);
       if Donnees[i]<Min then Min := Donnees[i];
       if Donnees[i]>Min then Max := Donnees[i];
       NbreDist[i] := Effectif[i];
       BornesDist[i] := Donnees[i];
       MoyDist[i] := Donnees[i];
       if Effectif[i]>maxDist then maxDist := Effectif[i];
   end;
   for i := 0 to pred(FNbre) do
       DistPourCent[i] := 100*NbreDist[i]/FNbreTotal;
   for i := FNbre to MaxHisto do begin
        NbreDist[i] := 0;
        MoyDist[i] := 0;
        DistPourCent[i] := 0;
   end;
   iMilieu := FNbreTotal div 2;
   i := 0;
   n := 0;
   repeat
       n := n+round(effectif[i]);
       if n>=iMilieu
         then Mediane := Donnees[i]
         else inc(i);
   until n>=iMilieu;
   sigma := sqrt((sigma-sqr(moyenne)/FNbreTotal)/pred(FNbreTotal));
   moyenne := moyenne/FNbreTotal;
   t99 := Sigma*Student99(FNbreTotal-1)/sqrt(FNbreTotal);
   t95 := Sigma*Student95(FNbreTotal-1)/sqrt(FNbreTotal);
end;

Procedure CalculStatFrequence;
var i : integer;
begin
   min := Donnees[0];
   max := Donnees[pred(FNbre)];
   moyenne := 0;
   FNbreTotal := 1;
   Sigma := 0;
   if FNbre<2 then exit;
   for i := 0 to pred(FNbre) do begin
       moyenne := moyenne+Effectif[i]*Donnees[i];
       sigma := sigma+Effectif[i]*sqr(Donnees[i]);
       if Donnees[i]<Min then Min := Donnees[i];
       if Donnees[i]>Min then Max := Donnees[i];
   end;
   if FpourCent then begin
      moyenne := moyenne/100;
      sigma := sigma/100;
      FNbreTotal := 100;
   end;
   sigma := sqrt(sigma-sqr(moyenne));
   t99 := 3*Sigma;
   t95 := 2*Sigma;
   mediane := moyenne;
end;

Procedure CalculDistFrequence;
var i : integer;
begin
    NbreClasse := FNbre;
    ecartDist := (Max-Min)/(NbreClasse-1);
    DebutDist := Donnees[0];
    maxDist := 0;
    for i := 0 to pred(FNbre) do begin
          NbreDist[i] := Effectif[i];
          BornesDist[i] := Donnees[i];
          MoyDist[i] := Donnees[i];
          if Effectif[i]>maxDist then maxDist := Effectif[i];
          DistPourCent[i] := 100*NbreDist[i]/Ntotal;
    end;
    for i := FNbre to MaxHisto do begin
        NbreDist[i] := 0;
        MoyDist[i] := 0;
        DistPourCent[i] := 0;
    end;
end;

Procedure CalculDist;
var i,j : integer;
    k : integer;
    trouve : boolean;
    c,m : double;
begin
   if ClasseStat=csNombreImpose
      then begin
           ecartDist := (Max-Min)/NbreClasse;
           k := floor(log10(abs(ecartDist)));
           C := dix(1-k); // 2 chiffres pour l'amplitude
           EcartDist := floor(EcartDist*C)/C;
           M := round(Min*C)/C;
           DebutDist := M-ecartDist;
           if DataInteger then debutDist := ceil(debutDist)-0.5;
           for i := 0 to MaxHisto do
               BornesDist[i] := DebutDist+ecartDist*i;
      end
      else begin
         if ClasseStat=csAuto then begin
            EcartDist := sigma/2;
            if (ecartDist>2) then ecartDist := trunc(ecartDist);
            try
            k := floor(log10(abs(ecartDist)));
            C := dix(1-k); // 2 chiffres pour l'amplitude
            except
                C := 1;
            end;
            EcartDist := floor(EcartDist*C)/C;
            M := round(Moyenne*C)/C;
            DebutDist := (M-ecartDist/2)-ecartDist*(MaxHisto div 2);
            if ecartDist>=2 then DebutDist := round(debutDist);
         end;
         if ClasseStat=csSigma then begin
            EcartDist := sigma;
            DebutDist := (Moyenne-ecartDist/2)-ecartDist*(MaxHisto div 2);
         end;
         if dataInteger then debutDist := ceil(debutDist)-0.5;
         for i := 0 to MaxHisto do
             BornesDist[i] := DebutDist+ecartDist*i;
      end;
   for i := 0 to MaxHisto do begin
        NbreDist[i] := 0;
        MoyDist[i] := 0;
        DistPourCent[i] := 0;
   end;
   i := 0;
   for k := 0 to pred(FNbre) do begin
// rangement des données dans les intervalles
       trouve := Donnees[k]<=BornesDist[i];
       while (i<MaxHisto) and not trouve do begin
           inc(i);
           trouve := Donnees[k]<=BornesDist[i];
       end;
       if trouve then begin
           NbreDist[i] := NbreDist[i] + 1;
           MoyDist[i] := MoyDist[i]+Donnees[k];
       end;
   end;
   if ClasseStat<>csNombreImpose then begin
       i := 0;
       While NbreDist[i]=0 do inc(i);
       j := MaxHisto;
       While NbreDist[j]=0 do dec(j);
       NbreClasse := succ(j-i);
       if NbreClasse<3 then NbreClasse := 3;
   end;
   maxDist := 0;
   DistPourCent[0] := 100*NbreDist[0]/Ntotal;
   for i := 1 to MaxHisto do begin
       if NbreDist[i]>0
           then MoyDist[i] := MoyDist[i]/NbreDist[i]
           else MoyDist[i] := (BornesDist[pred(i)]+BornesDist[i])/2;
       if NbreDist[i]>maxDist then maxDist := round(NbreDist[i]);
       DistPourCent[i] := 100*NbreDist[i]/Ntotal;
   end;
   if (MaxDist<0.2*FNbre) and
      (ClasseStat<>csEcartImpose) then MaxDist := ceil(0.2*FNbre);
end; // CalculDist

Procedure CalculDistEffectif;
var i : integer;
begin
    NbreClasse := FNbre;
    ecartDist := (Max-Min)/(NbreClasse-1);
    DebutDist := Donnees[0];
    maxDist := 0;
    for i := 0 to pred(FNbre) do begin
        NbreDist[i] := Effectif[i];
        BornesDist[i] := Donnees[i];
        MoyDist[i] := Donnees[i];
        if Effectif[i]>maxDist then maxDist := ceil(Effectif[i]);
        DistPourCent[i] := 100*NbreDist[i]/Ntotal;
   end;
   for i := FNbre to MaxHisto do begin
        NbreDist[i] := 0;
        MoyDist[i] := 0;
        DistPourCent[i] := 0;
   end;
end;

Procedure TriDonnees;
// Tri Shell Meyer-Baudoin p 456
// origine vecteur en 0 ?
var increment,k : integer;
    cle : double;
    i,j : integer;
Begin
   increment := 1;
   while (increment<(FNbre div 3)) do increment := succ(3*increment);
   repeat
     for k := 0 to pred(increment) do begin
       	  i := increment+k;
   	  while (i<FNbre) do begin
	  	  cle := Donnees[i];
	  	  j := i-increment;
	  	  while (j>=0) and (donnees[j]>cle) do begin
               Donnees[j+increment] := Donnees[j];
               dec(j,increment);
  		  end;
        Donnees[j+increment] := cle;
	  	  inc(i,increment);
	   end; { i>=nmes }
      end; { for k }
      increment := increment div 3;
   Until increment=0;
end; // triDonnees

Procedure TriDonneesEffectif;
// Tri Shell Meyer-Baudoin p 456
// origine vecteur en 0 ?
var increment,k : integer;
    cle,sauveEffectif : double;
    i,j : integer;
Begin
   increment := 1;
   while (increment<(FNbre div 3)) do increment := succ(3*increment);
   repeat
     for k := 0 to pred(increment) do begin
       	  i := increment+k;
   	  while (i<FNbre) do begin
	  	  cle := Donnees[i];
        sauveEffectif := Effectif[i];
	  	  j := i-increment;
	  	  while (j>=0) and (donnees[j]>cle) do begin
               Donnees[j+increment] := Donnees[j];
               Effectif[j+increment] := Effectif[j];
               dec(j,increment);
  		  end;
        Donnees[j+increment] := cle;
        Effectif[j+increment] := sauveEffectif;
	  	  inc(i,increment);
	   end; { i>=nmes }
      end; { for k }
      increment := increment div 3;
   Until increment=0;
end; // triDonnees

var SauveData,SauveEff : Tvecteur;
begin
     if statOK then exit;
     statOK := FNbre>2;
     if not StatOK then exit;
     if not avecTri then begin
        copyVecteur(sauveData,Donnees);
        if classeStat in [csEffectifDonne,csFrequenceDonnee]
            then copyVecteur(sauveEff,Effectif);
     end;
     try
     if classeStat=csEffectifDonne
        then begin
           statOK := TestEffectif;
           if statOK
              then begin
                TriDonneesEffectif;
                setTaille(Fnbre);
                calculStatEffectif;
                calculDistEffectif;
             end
             else afficheErreur(erEffectifNotInt,0);
        end
        else if classeStat=csFrequenceDonnee
        then begin
           statOK := TestFrequence;
           if statOK
              then begin
                setTaille(Fnbre);
                TriDonneesEffectif;
                calculStatFrequence;
                calculDistFrequence;
             end
             else afficheErreur(erPourCent,0);
        end
        else begin
           testDataEntier;
           setTaille(MaxHisto);
           TriDonnees;
           calculStat;
           calculDist;
        end;
     if not avecTri then begin
         copyVecteur(Donnees,sauveData);
         finalize(SauveData);
         if classeStat in [csEffectifDonne,csFrequenceDonnee] then begin
              copyVecteur(Effectif,sauveEff);
              finalize(SauveEff);
         end;
     end;
     except
        statOK := false;
        t99 := 1;
        t95 := 1;
     end;
end; // Calcul

procedure TcalculStatistiqueResidu.Calcul;

Procedure CalculStat;
var i : integer;
    MCE,Sxx,sigma,hii,tii : double;
    xMoyen : double;
begin
   min := Residus[0];
   max := Residus[pred(FNbre)];
   if FNbre<2 then exit;
   Sigma := 0;
   Sxx := 0;
   xMoyen := 0;
   for i := 0 to pred(FNbre) do begin
       sigma := sigma+sqr(Residus[i]);
       Sxx := Sxx+sqr(X[i]);
       xmoyen := xmoyen+X[i];
       if Residus[i]<Min then Min := Residus[i];
       if Residus[i]>Min then Max := Residus[i];
   end;
   xmoyen := xmoyen/FNbre;
   Sxx := Sxx-Fnbre*sqr(xmoyen);
   MCE := sigma/(Fnbre-2);
   for i := 0 to pred(FNbre) do begin
       hii := 1/Fnbre+sqr(X[i]-xmoyen)/Sxx;
       tii := Residus[i]/sqrt(MCE*(1-hii));
       ResidusStudent[i] := Residus[i]*sqrt((FNbre-1-FNbreParam)/(FNbre-2-sqr(tii)));
       if avecIncert then ResidusNormalises[i] := Residus[i]/Incertitudes[i];
   end;
   t95 := student95(Fnbre-1-FNbreParam);
   statOK := true;
end;

begin
     statOK := FNbre>2;
     if not StatOK then exit;
     try
     calculStat;
     except
        statOK := false;
     end;
end; // Calcul

destructor TcalculStatistique.Destroy;
begin
     finalize(MoyDist);
     finalize(NbreDist);
     finalize(DistPourCent);
     finalize(BornesDist);
     finalize(donnees);
     finalize(effectif);
     inherited destroy;
end;

destructor TcalculStatistiqueResidu.Destroy;
begin
     finalize(residus);
     finalize(residusStudent);
     finalize(residusNormalises);
     finalize(incertitudes);
     finalize(X);
     inherited destroy;
end;

Procedure TcalculStatistique.SetValeur(Valeur : Tvecteur;Nmes : integer;withTri : boolean);
begin
     Nbre := Nmes;
     CopyVecteur(Donnees,Valeur);
     statOK := false;
     AvecTri := withTri;
     Calcul;
end;

Procedure TcalculStatistiqueResidu.SetValeur(ANbre,NParam : integer);
begin
     FNbre := ANbre;
     FNbreParam := NParam;
     statOK := Fnbre<maxVecteurStat;
end;

Procedure CalcCornish(X,Y : Tvecteur;N : integer;var K,V : Tvecteur;var ANbre : integer);
var i,j,m : integer;
    Denom : double;
begin
    m := 0;
    setLength(K,N*N);
    setLength(V,N*N);
    for i := 0 to pred(N) do begin
        for j := succ(i) to pred(N) do begin
            try
            Denom := -X[i]*Y[j]+X[j]*Y[i];
            K[m] := X[i]*X[j]*(Y[j]-Y[i])/denom;
            V[m] := Y[i]*Y[j]*(X[j]-X[i])/denom;
            inc(m);
            if m=high(K) then break;
            except
            end;
        end;
        if m=high(K) then break;
    end;
    ANbre := m;
end;

Procedure TstatistiqueDeuxVar.Init(ax,ay : Tvecteur;debut,fin : integer);
var i : integer;
    xsigma,ysigma : double;
    Delta : double;
    elarg : double;
begin
    X := ax;
    Y := ay;
    try
    Sx := 0;Sy := 0;
    Sx2 := 0;Sy2 := 0;
    FNbre := succ(Fin-Debut);
    for i := Debut to Fin do begin
       Sx := Sx+X[i];Sy := Sy+Y[i];
       Sx2 := Sx2+sqr(X[i]);Sy2 := Sy2+sqr(Y[i]);
    end;
    Sxx := sx2-sqr(sx)/FNbre;
    Syy := sy2-sqr(sy)/FNbre;
    Xsigma := sqrt(Sxx/pred(FNbre));
    Ysigma := sqrt(Syy/pred(FNbre));
    Xmoyen := Sx/FNbre;Ymoyen := Sy/FNbre;
    Covariance := 0;
    for i := Debut to Fin do
      Covariance := Covariance+(X[i]-Xmoyen)*(Y[i]-Ymoyen);
    Covariance := Covariance/pred(FNbre);
    Fcorrelation := Covariance/Xsigma/Ysigma;
    FFisher := ln((1+Fcorrelation)/(1-Fcorrelation))/2;
    FpvalueFisher := PStudent(Fnbre-2,FFisher/sqrt(Fnbre-3));
    Pente := Fcorrelation*Ysigma/Xsigma;
    Y0 := Ymoyen-Pente*Xmoyen;
    SSR := sqr(Pente)*Sxx;
    SSE := Syy-SSR;
    sigma := sqrt(SSE/(FNbre-2));
    //FFisher := SSR*(FNbre-2)/SSE;
    // interprétable comme r^2*(n-2)/(1-r^2)
    Delta := FNbre*Sx2-sqr(Sx);
    sigmaY0 := sigma*sqrt(Sx2/Delta);
    sigmaPente := sigma*sqrt(FNbre/Delta);
    covariancePenteY0 := -sqr(sigma)*Sx/Delta;
    elarg := student95(FNbre-2);
    U95Y0 := elarg*sigmaY0;
    U95pente := elarg*sigmaPente;
    covariance95PenteY0 := covariancePenteY0*sqr(elarg)
    except
      Fcorrelation := Nan;
      FFisher := Nan;
    end;
end; // Calcul stat deux variables

Procedure CalcCornishInters(X,Y : Tvecteur;N : integer;var Km,Vm : double);
var i,imax : integer;
    K,V : Tvecteur;
    Kmax,Vmax : double;
begin
    setLength(K,N+1);
    setLength(V,N+1);
    CalcCornish(X,Y,N,K,V,imax);
    Km := 0;
    Vm := 0;
    for i := 0 to pred(imax) do begin
        Km := Km + K[i];
        Vm := Vm + V[i];
    end;
    Kmax := 0;
    Vmax := 0;
    for i := 2 to imax-3 do begin
        if K[i]>Kmax then Kmax := K[i];
        if V[i]>Vmax then Vmax := V[i];
    end;
    Km := Km/imax;
    Vm := Vm/imax;
    if (Kmax-Km)<Km*0.4
       then Km := -Kmax
       else Km := -Km*1.2;
    if (Vmax-Vm)<Vm*0.4
       then Vm := -Vmax
       else Vm := -Vm*1.2;
    finalize(K);finalize(V);
end;

procedure TcalculStatistique.setNbre(Anbre : integer);
begin
     if (classeStat=csEffectifDonne) and
        (Anbre>MaxHisto) then Anbre := MaxHisto;
     if ANbre>MaxVecteurStat then ANbre := MaxVecteurStat;
     Fnbre := Anbre;
end;


Procedure TcalculStatistique.SetValeurEffectif(Valeur,ValEff : Tvecteur;Nmes : integer);
begin
     Nbre := Nmes;
     CopyVecteur(Donnees,Valeur);
     CopyVecteur(Effectif,ValEff);
     statOK := false;
     AvecTri := true;
     Calcul;
end;

Procedure TstatistiqueDeuxVar.GenereBande(Xmin,Ymin,Xmax,Ymax : Tvecteur;Fin : integer;confiance : boolean);
var i : integer;
    ecart,st,zz : double;
begin
   st := student95(FNbre-2)*sigma; // 95%
   for i := 0 to Fin do begin
       xMin[i] := xMax[i];
       zz := 1/FNbre+sqr(xMax[i]-xmoyen)/Sxx;
       if confiance
          then  ecart := st*sqrt(zz) // Confiance
          else  ecart := st*sqrt(1+zz); // Prédiction
       yMin[i] := yMax[i]-ecart;
       yMax[i] := yMax[i]+ecart;
   end;// for i
end; // GenereBande

Procedure TcalculStatistique.TestDataEntier;
Var i,n : integer;
begin
       DataInteger := true;
       for i := 0 to pred(Fnbre) do begin
           if not IsEntier(donnees[i],n) then begin
                DataInteger := false;
                break;
           end;     // indexEffectif non entier donc pas un effectif
      end;
end;

Function TcalculStatistique.TestEffectif : boolean;
Var i,j,n : integer;
begin
       result := true;
       for i := 0 to pred(Fnbre) do begin
           if not IsEntier(effectif[i],n) then begin
                result := false;
                break;
           end;
           for j := 0 to pred(i) do
               if donnees[i]=donnees[j] then begin
                  result := false;
                  break;
               end; // doublon indexStat donc pas une variable
       end;
end;

Function TcalculStatistique.TestFrequence : boolean;
Var i : integer;
    total : double;
begin
       result := false;
       total := 0;
       for i := 0 to pred(Fnbre) do
           total := total + effectif[i];
       if abs(total-1)<0.01 then begin
          result := true;
          FpourCent := false;
       end;
       if abs(total-100)<1 then begin
          result := true;
          FpourCent := true;
       end;
end;

end.


