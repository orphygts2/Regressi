unit fileFits;

interface

uses windows, sysUtils, clipBrd, classes, forms, controls, strUtils,
     constreg, maths, regutil, uniteker, compile, math, dialogs,
     valeurs, graphker, graphvar, graphFFT,
     Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc,
     DeLaFitsCommon, DeLaFitsString, DeLaFitsGraphics;

Function LitFichierFITS(const NomFichier : String) : boolean;
Function AjouteFichierFITS(const NomFichier : String) : boolean;

var codeErreurF : string;

implementation

function LitFichierFITS(const NomFichier : String) : boolean;
var FFit: TFitsFileBitmap;
    lambda,intensite : Tspectre;
    i,imax : integer;
    coeff : double;
begin
   result := false;
   try
   ModeAcquisition := AcqFichier;
   FFit := TFitsFileBitmap.CreateJoin(NomFichier, cFileRead);
   if FFIT.HduCore.isSpectre then begin
      FFit.SpectreRead(lambda,intensite);
      imax := length(intensite);
      AjouteExperimentale('λ',variable);
      grandeurs[0].fonct.expression := 'Longueur d''onde';
      grandeurs[0].nomUnite := FFit.HduCore.uniteX;
      coeff := 1;
      if (pos('ANG', grandeurs[0].nomUnite)>0) or
         (pos('Ang', grandeurs[0].nomUnite)>0) or
         (grandeurs[0].nomUnite='') then begin
         grandeurs[0].nomUnite := 'nm';
         coeff := 0.1;
      end;
      if ('um'=grandeurs[0].nomUnite) then begin
         grandeurs[0].nomUnite := 'nm';
         coeff := 1000;
      end;
      AjouteExperimentale('I',variable);
      grandeurs[1].fonct.expression := 'Intensite';
      grandeurs[1].nomUnite := FFit.HduCore.uniteY;
      result := ajoutePage;
      if not result then exit;
      pages[pageCourante].nmes := imax;
      for i := 0 to imax do begin
         pages[pageCourante].ValeurVar[0,i] := lambda[i]*coeff;
         pages[pageCourante].ValeurVar[1,i] := intensite[i];
      end;
      result := true;
   end
   else showMessage('N''est pas un fichier de spectre');
   FFit.Free;
   except
      result := false;
      codeErreurF := erFileLoad;
   end;
end;



Function AjouteFichierFITS(const NomFichier : String) : boolean;
var FFit: TFitsFileBitmap;
    lambda,intensite : Tspectre;
    i,imax : integer;
    coeff : double;
begin
   result := false;
   try
   FFit := TFitsFileBitmap.CreateJoin(NomFichier, cFileRead);
   if FFIT.HduCore.isSpectre then begin
      FFit.SpectreRead(lambda,intensite);
      imax := length(intensite);
      coeff := 1;
      if (pos('ANG', FFit.HduCore.uniteX)>0) or
         (pos('Ang',  FFit.HduCore.uniteX)>0) or
         (grandeurs[0].nomUnite='') then begin
         coeff := 0.1;
      end;
      if ('um'=FFit.HduCore.uniteX) then begin
         coeff := 1000;
      end;
      result := ajoutePage;
      if not result then exit;
      pages[pageCourante].nmes := imax;
      for i := 0 to imax do begin
         pages[pageCourante].ValeurVar[0,i] := lambda[i]*coeff;
         pages[pageCourante].ValeurVar[1,i] := intensite[i];
      end;
      result := true;
   end
   else showMessage('N''est pas un fichier de spectre');
   FFit.Free;
   except
      codeErreurF := erFileLoad;
   end;
end;


end.
