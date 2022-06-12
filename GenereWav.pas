procedure GenereFichierWav(NomFichier : string;stereo : boolean;
    N : integer;FreqEch : integer;
    gauche,droite : array[0..Maximum] of smallInt);
// smallInt : 16 bits signés
// freqEch 44.100 kHz Qualité CD
// 22.050 kHz taux d'échantillonnage habituel Windows
// 11.025 kHz lecture Windows

var Hfichier : integer;

Procedure EcritFichier(stereo : boolean);

Procedure EcritTexte(texte : String);
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

var j : integer;
    sampleSize : integer;
begin
     if stereo then sampleSize := 4 else sampleSize := 2;
{ 0..3 riff }
     ecritTexte('RIFF');
{ 4..7 taille en octets poids faible en premier }
     ecritLongMot(LongWord(N*sampleSize+36));
{ taille de ce qui suit d'où
  +36 = 44 octets de codage - les 8 précédents
  *sampleSize = octets par échantillon }
{ 8..15 WAVEFMT }
     ecritTexte('WAVEfmt ');
{ 16..19 16,0,0,0 : size les 16 octets qui suivent }
     ecritLongMot(16); // taille de ce qui suit (16 pour PCM)
{ 20..23 1,0,1,0 ou 1,0,2,0 (4) }
     ecritMot(1); { PCM sinon compression }
     if stereo then ecritMot(2) else ecritMot(1); { nombre de voies }
{ 24..27 fréquence poids faible en premier en échantillons (8) }
     ecritLongMot(word(FreqEch));
{ 28..31 fréquence poids faible en premier en octets (12) }
     ecritLongMot(word(FreqEch*sampleSize));
{ 32..33  block align sur sampleSize octets (14) }
{ 34..35 8 ou 16 ou 32 Nombre de bits (16) }
     ecritMot(sampleSize);
     ecritMot(16);
{ 36 39 "data" }
     EcritTexte('data');
{ 40..43 nbre échantillon }
     ecritLongMot(LongWord(N*sampleSize));
     for j := 0 to pred(N) do begin
         FileWrite(Hfichier,droite[j],2);
         if stereo then FileWrite(Hfichier,gauche[j],2);
     end;
end;

var F : TextFile;
begin
     if not FileExists(NomFichier) then begin
        AssignFile(F,NomFichier);
        Rewrite(F);
        write(F,'RIFF');
        CloseFile(F);
     end; { un truc tordu je ne sais plus pourquoi }
     Hfichier := FileOpen(NomFichier,fmOpenWrite);
     if HFichier>0 then begin
         EcritFichier;
         FileClose(Hfichier);
     end
end;
