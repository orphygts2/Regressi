unit couleurLambda;

interface

uses Graphics, Windows, Classes,  math;

Function couleurWL(WL : double) : Tcolor;

//     RGB VALUES FOR VISIBLE WAVELENGTHS   by Dan Bruton (astro@tamu.edu)
//     http://www.isc.tamu.edu/~astro/color.html
//     This program will create a ppm (portable pixmap) image of a spectrum.
//     The spectrum is generated using approximate RGB values for visible
//     wavelengths between 380 nm and 780 nm. for GAMMA=1
//     NetPBM Software: ftp://ftp.cs.ubc.ca/ftp/archive/netpbm/

implementation

const GAMMA=0.80;

Function couleurWL(WL : double) : Tcolor;
var R,G,B,sss : double;
    RR,GG,BB : byte;
    WLi : integer;
begin
      if WL<1 then WL := 1000*WL; // en micromètre ?
      WLi := round(WL);
      IF (WLi<380) THEN begin
           R := 0;
           G := 0;
           B := 0;
      end
      else IF (WLi<=440) THEN begin
              R := (440-WL)/(440-380);
              G := 0;
              B := 1;
      END
      else IF (WLi<=490) THEN begin
              R := 0;
              G := (WL-440)/(490-440);
              B := 1;
      END
      else IF (WLi<=510) THEN begin
              R := 0;
              G := 1;
              B := (510-WL)/(510-490);
      END
      else IF (WLi<=580) THEN begin
              R := (WL-510)/(580-510);
              G := 1;
              B := 0;
      END
      else IF (WLi<=645) THEN begin
              R := 1;
              G := (645-WL)/(645-580);
              B := 0;
      END
      else IF (WLi<=800) THEN begin
              R := 1;
              G := 0;
              B := 0;
      END
      else begin
           R := 0;
           G := 0;
           B := 0;
      end;
//      LET THE INTENSITY SSS FALL OFF NEAR THE VISION LIMITS
      IF (WL>700) THEN
            SSS:=0.3+0.7* (780-WLi)/(780-700)
         ELSE IF (WL<420) THEN
            SSS:=0.3+0.7*(WLi-380)/(420-380)
         ELSE
            SSS:=1;
//      GAMMA ADJUST
      RR:=round(power(SSS*R,GAMMA)*255);
      GG:=round(power(SSS*G,GAMMA)*255);
      BB:=round(power(SSS*B,GAMMA)*255);
      result := RGB(RR,GG,BB);
END;

end.
