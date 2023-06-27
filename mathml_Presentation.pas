unit mathml_Presentation;

interface

uses sysutils, classes, Clipbrd, grids, regutil, compile, windows, constreg;

procedure AjouteGrandeur(index : integer);
Procedure AjouteModele(amodele : Tmodele);
procedure DebutDoc(const titre : string);
procedure FinDoc;
Procedure AjouteSection(const titre : string);
Procedure SaveFile(const nomFichier : string);

implementation

var latexStr : TstringList;
    avecExposant : boolean;

const
    parF = '<m:mo>)</m:mo>)';
    parO = '<m:mo>(</m:mo>)';

Function UnicodeToLatexMath(carac : char) : string;
var j : integer;
begin
     avecExposant := false;
     case carac of
                      alpha : result := '&#945;';
                      beta : result := '&#946;';
                      gammaMin: result := '&#947;' ;
                      gammaMaj: result := '&#915;';
                      deltaMin: result := '&#948;';
                      deltaMaj: result := '&#916;';
                      epsilon: result := '&#949;';
                      zeta: result := '&#950;';
                      eta: result := '&#951;';
                      kappa: result := '&#1008;';
                      lambdaMin: result := '&#955;';
                      lambdaMaj: result := '&#923;';
                      mu: result := '&#956;';
                      nu: result := '&#957;';
                      xi: result := '&#958;';
                      xiMaj: result := '&#926;'; // '&#982;'	?
                      pimin: result := '&#960;';
                      piMaj: result := '&#928;';
                      rho: result := '&#1009;';
                      sigmaMin: result := '&#963;';
                      sigmaMaj: result := '&#931;';
                      tau: result := '&#964;';
                      theta: result := '&#952;';
                      thetaMaj: result := '&#920;';
                      phiMin: result := '&#981;'; //&#966;	?
                      phiMaj: result := '&#934;';
                      chi: result := '&#967;';
                      psi: result := '&#968;';
                      psiMaj: result := '&#936;';
                      omegamin: result := '&#969;';
                      omegaMaj: result := '&#911;';
                      upsilonMaj : result := '&#910;';
                      'é' : result := '\eacute';
                      'è' : result := '\egrave';
                      'ê' : result := '\ecirc';
                      'ë' : result := '\euml';
                      'ï' : result := '\iuml';
                      'à' : result := '\agrave';
                      'â' : result := '\acirc';
                      'ù' : result := '\uuml';
                      'û' : result := '\ucirc';
                      'ü' : result := '\uuml';
                      'ô' : result := '\ocirc';
                      '&' : result := '&&';
                      '#' : result := '&#';
                      '°' : result := '\degres';
                      '±' : result := '\pm';
                      '%' : result := '&%';
                      MoinsExp : result := '-';
                      PlusExp : result := '+';
                      InfEgal : result := '\leq';
                      SupEgal : result := '\geq';
                      else begin
                         result := carac;
                         for j := 0 to 9 do
                            if carac=ChiffreExp[j] then begin
                               result := intToStr(j);
                               break;
                            end;
                      end;
     end;
end;

function TranslateNomMath(const anom : string) : string;
var i : integer;
begin
    if length(anom)>1
       then result := '<m:mi mathvariant=''italic''>'
       else result := '<m:mi>';
    for i := 1 to length(anom) do
        result := result+unicodeToLatexMath(anom[i]);
    result := result + '</m:mi>';
end;

(*
normal ; bold ; italic ; bolditalic ; double-struck ; bold-fraktur
script ; bold-script ; fraktur ; sansserif ; bold-sans-serif;
sans-serif-italic ; sans-serif-bold-italic ; monospace ; initial
tailed ; looped ; stretched
*)

Function TranslateExpression(F:Pelement) : string;
// renvoie le code MathML d'un arbre pointé par F

Function calcIf(ff : Pelement): string;
begin with ff^ do begin
   result := '<m:mtext mathvariant=''bold''> &ThickSpace; if &ThickSpace; </m:mtext>'+TranslateExpression(test);
   result := result + '<m:mtext mathvariant=''bold''>,&ThickSpace; then &ThickSpace; </m:mtext>'+TranslateExpression(positif);
   result := result + '<m:mtext mathvariant=''bold''>,&ThickSpace; else &ThickSpace;</m:mtext>'+TranslateExpression(negatif);
end end;

Function calcPW(ff : Pelement): string;  // non reconnu danw webEq 3
begin
// non reconnu danw webEq 3
(*
   result := '<m:piecewise>';
   repeat
       result := result + '<m:piece>'+translateExpression(ff.PWtest)+' '+ translateExpression(ff.PWthen)+'</m:piece>';
       ff := ff.PWtestElse;
       if ff.typeElement<>Piecewise then begin
          result := result + '<m:piece> <m:mo> else </m:mo>'+ translateExpression(ff)+'</m:piece>';
          ff := nil;
       end;
   until ff=nil;
   result := result+'</m:piecewise>';
*)
   result := '<m:mo>{</m:mo><m:mrow><m:mtable>';
   repeat
       result := result + '<m:mtr>'+
       '<m:mtd>'+translateExpression(ff.PWtest)+'</m:mtd>'+
       '<m:mtd>'+ translateExpression(ff.PWthen)+'</m:mtd>'+
       '</m:mtr>';
       ff := ff.PWtestElse;
       if ff.typeElement<>Piecewise then begin
          result := result + '<m:mtr>'+
          '<m:mtd><m:mtext>else</m:mtext></m:mtd>'+
          '<m:mtd>'+ translateExpression(ff)+'</m:mtd>'+
          '</m:mtr>';
          ff := nil;
       end;
   until ff=nil;
   result := result+'</m:mtable></m:mrow>';
end;

Function calculFonctionGlb(F : Pelement): string;

Function CalcIntegrale : String; // intégrale operandGlb / varMuette de a à b
var a,b,sigma,vm : string;
begin with F^ do begin
        a := translateExpression(operandDebut);
        b := translateExpression(operandFin);
        vm := translateNomMath(Grandeurs[cMuette].nom);
        sigma := translateExpression(operandGlb);
        result := '<m:msubsup><m:mo>&int;</m:mo>'+a+b+'</m:msubsup>'
           +sigma+
           '<m:mrow><m:mo>d</m:mo>'+vm+'</m:mrow>';
end end; // CalcIntegrale

var freqLoc,rapportCyclique,anom,anomY : string;
begin with F^ do begin // calculFonctionGlb
    result := '';
    aNom := translateNomMath(varX.nom);
    if CodeFglb in [maximum,position,minimum,moyenne,moyenneAll,somme,efficace,frequence,
                    ecartType,surface,phase,initial] then begin
                     result := LowerCase(nomFonctionGlb[CodeFglb])+parO+aNom+parF;
                     exit;
    end;
    if CodeFglb in [pente,origine] then begin
        aNomY := translateNomMath(varY.nom);
        result := LowerCase(nomFonctionGlb[CodeFglb])+parO+aNom+','+anomY+parF;
        exit;
    end;
    if CodeFglb=derivee then begin
        aNomY := translateNomMath(varY.nom);
 // content MathML
(*        result := '<m:apply><m:diff/> <m:bvar><m:mi>'+aNom+'</m:mi></m:bvar>'+
                  '<m:apply><m:mi type="fn">'+anomY+'</m:mi><m:mi>'+aNom+'</m:mi>'+
    	            '</m:apply></m:apply>';*)
// presentation MathML
        result := '<m:mfrac>'+
            '<m:mrow><m:mo>d</m:mo>'+anomY+'</m:mrow> '+
            '<m:mrow><m:mo>d</m:mo>'+aNom+'</m:mrow>'+
            '</m:mfrac>';
        exit;
    end;
    if CodeFglb=deriveeSeconde then begin
        aNomY := translateNomMath(varY.nom);
        exit;
    end;
    freqLoc := translateExpression(OperandGlb);
    rapportCyclique := translateExpression(OperandDebut);
    aNom := translateNomMath(varX.nom);
    case CodeFglb of
         equation : CalculFonctionGlb := freqLoc;
         integraleDefinie,integraleMuette : CalculFonctionGlb := CalcIntegrale;
         fonctionPage : CalculFonctionGlb := stPage;
         cCreneau : CalculFonctionGlb := 'Creneau'+parO+freqLoc+','+rapportCyclique+parF;
         cCnp : CalculFonctionGlb := 'C <m:msup>'+freqLoc+'</m:msup><m:minf>'+rapportCyclique+'</m:minf>';
         cTriangle : CalculFonctionGlb := 'Triangle'+parO+freqLoc+','+rapportCyclique+parF;
         cGauss : CalculFonctionGlb := 'Gauss'+parO+freqLoc+','+rapportCyclique+parF;
         cPhaseModulo : CalculFonctionGlb := 'PhaseModulo'+parO+anom+freqLoc+','+rapportCyclique+parF;
         cPoisson : CalculFonctionGlb := 'Poisson'+parO+anom+','+freqLoc+parF;
         cBessel : CalculFonctionGlb := 'BesselJ'+parO+rapportCyclique+','+freqLoc+parF;
         cPeigne : CalculFonctionGlb := 'Peigne'+parO+rapportCyclique+','+freqLoc+parF;
     end; { case }
end end; // calculFonctionGlb

Var X,Y : string;
    parX,parY : boolean; // parenthèse X Y
Begin // TranslateExpression
  result := '';
  if F=nil then exit;
  With F^ do Case TypeElement of
       Operateur: Begin
            X := translateExpression(OperG);
            parX := (Operg.TypeElement=Operateur) and
                    charInSet(OperG.CodeOp,['+','-']) and
                    charInSet(CodeOp,['*','^','&','#','@']);
            if parX then X := '<m:mo>(</m:mo>'+X+'<m:mo>)</m:mo>';
            Y := translateExpression(OperD);
            parY := (OperD.TypeElement=Operateur) and
                    charInSet(OperD.CodeOp,['+','-']) and
                    charInSet(CodeOp,['*','&','#','@']);
            if parY then Y := '<m:mfenced>'+Y+'</m:mfenced>';
            Case CodeOp of
                 '+','-','=' : result := '<m:mrow>'+X+'<m:mo>'+codeOp+'</m:mo>'+Y+'</m:mrow>';
                 // - &#x02212;
                 '*' : result := '<m:mrow>'+X+'<m:mo>&#x00B7;</m:mo>'+Y+'</m:mrow>';  // x = &#x000d7;
                 '<' : result := '<m:mrow>'+X+'<m:mo>&lt;</m:mo>'+Y+'</m:mrow>';
                 '>' : result := '<m:mrow>'+X+'<m:mo>&gt;</m:mo>'+Y+'</m:mrow>';
                 '/' : result := '<m:mfrac>'+X+Y+'</m:mfrac>'; // &#x000f7;
                 '@' : result := 'arg('+X+'<m:mo>+</m:mo><m:mi>&ImaginaryI;</m:mi>'+Y+')';
                 '#' : result := 'arg('+X+'<m:mo>-</m:mo><m:mi>&ImaginaryI;</m:mi>'+Y+')';
                 '^' : result := '<m:msup>'+X+Y+'</m:msup>';
                 '&' : result := '<m:mi type=''function''>arg</m:mi>('+X+'+<m:mi>&ImaginaryI;</m:mi>'+Y+')';
             end;{case codeOp}
       end;{operateur}
       Fonction: Begin
             X := translateExpression(Operand);
             case codeF of
               racine : result := '<m:msqrt><m:mrow>'+X+'</m:mrow></m:msqrt>';
               inverse : result := '<m:mfrac>'+'<m:mn>1</m:mn>'+X+'</m:mfrac>';
               oppose : result := '<m:mrow><m:mo>-</m:mo>'+Y+'</m:mrow>'; { TODO : syntaxe de opposé ? }
               carre : result := '<m:msup>'+X+'<m:mn>2</m:mn></m:msup>';
               absolue: result := '<m:mo>|</m:mo>'+X+'<m:mo>|</m:mo>';
               echelon: result := '<m:mo>&#910;</m:mo>'+parO+X+parF;
               codeGamma: result := '<m:mo>&#915;</m:mo>'+parO+X+parF;
               else result := '<m:mi type=''function''>'+LowerCase(nomFonction[codeF])+'</m:mi>'+
                            parO+X+parF;
             end;
       End;{Fonction}
       FonctionGlb : result := calculFonctionGlb(F);
       IfThenElse : result := calcIf(F);
       Piecewise : result := calcPW(F);
       grandeur : result := translateNomMath(Pvar.nom);
       grandeurIndicee,IncertIndicee : result := translateNomMath(Pvariab.nom)+
                '<m:mfenced><m:mn>'+intToStr(round(numero))+'</m:mn></m:mfenced>';
       Nombre : if F=pointeurPi
           then result := '<m:mi>&#960;</m:mi>'
           else result := '<m:mn>'+floatToStrPoint(valeur)+'</m:mn>';
       RacineMoinsUn : result := '<m:mi>&ImaginaryI;</m:mi>';
     	 Incert : result := '';
  End;{case}
End; //  TranslateExpression

procedure AjouteGrandeur(index : integer);
var debut,fin : string;
begin // U+2032 PRIME U+2033 DOUBLE PRIME
with grandeurs[index] do begin
     debut := '<m:math display=''block''><m:semantics>'+translateNomMath(nom);
     fin := '</m:semantics></m:math>';
     case fonct.genreC of
          g_fonction,g_derivee,g_equation,g_filtrage, g_definitionFiltre :
              LatexStr.Add(debut+'<m:mo>=</m:mo>'+translateExpression(fonct.calcul)+fin);
          g_diff1 : LatexStr.Add(debut+'<m:mi>&#2032;</m:mi>'+'<m:mo>=</m:mo>'+
              translateExpression(fonct.calcul)+fin);
          g_diff2 : LatexStr.Add(debut+'<m:mi>&#2033;</m:mi>'+'<m:mo>=</m:mo>'+
              translateExpression(fonct.calcul)+fin);
          g_integrale : LatexStr.Add(debut+'<m:mo>=</m:mo><m:mo>&int;</m:mo>'+
              translateExpression(fonct.calcul.OperandGlb)+
              '<m:mrow><m:mo>d</m:mo>'+translateNomMath(fonct.calcul^.varX.nom)+'</m:mrow>'+fin);
          g_a_affecter, g_forward : ;
          g_euler : ;
          else if fonct.expression<>'' then LatexStr.Add(debut+'<m:mo>=</m:mo>'+
             '<m:mtext>'+translateExpression(fonct.calcul)+'</m:mtext>'+fin);
     end;
end;
     LatexStr.add('<br/>');
end;

procedure DebutDoc(const titre : string);
begin
    latexStr.clear;
    //latexStr.add('<?xml version="1.0" encoding="utf-8"?>');
    latexStr.add('<!DOCTYPE HTML PUBLIC "-//W3C//DTD W3 HTML//EN">');
    latexStr.add('<html xmlns:m="http://www.w3.org/1998/Math/MathML" lang="en">');
    latexStr.add('<head>');
    latexStr.add('<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />');
    latexStr.add('<title>'+titre+'</title>');
    latexStr.add('<OBJECT ID=MathPlayer CLASSID="clsid:32F66A20-7614-11D4-BD11-00104BD3F987"'+
                 'title="MathPlayer"><img alt="" src="" '+
                 'longdesc="http://www.dessci.com/en/products/mathplayer/longdesc.htm"></OBJECT>');
    latexStr.add('<?import namespace="m" implementation="#MathPlayer" ?>');
    latexStr.add('<script language="javascript">');
    latexStr.add('<!--');
    latexStr.add('function IsMPInstalled()');
    latexStr.add('{');
    latexStr.add('  try {');
    latexStr.add('    var oMP = new ActiveXObject("MathPlayer.Factory.1");');
    latexStr.add('    return true;');
    latexStr.add('  }');
    latexStr.add('  catch(e) {');
    latexStr.add('    return false;');
    latexStr.add('  }');
    latexStr.add('}');
    latexStr.add('-->');
    latexStr.add('</script>');
    latexStr.add('</head>');
    latexStr.add('<body>');
end;

procedure FinDoc;
begin
   latexStr.add('</body>');
end;

Procedure SaveFile(const nomFichier : string);
begin
   latexStr.saveToFile(nomFichier,TEncoding.UTF8);
end;

(*
Procedure AjouteParagraphe;
begin
  latexStr.add('<br/>');
end;
 *)

Procedure AjouteModele(amodele : Tmodele);
begin
     with amodele do
          latexStr.add('<m:math display=''block''> <m:semantics>'+
              translateNomMath(addrY.nom)+'<m:mo>=</m:mo>'+translateExpression(calcul)+
              '</m:semantics></m:math>')
end;

Procedure AjouteSection(const titre : string);
begin
  latexStr.add('<p><b>'+titre+'</b></p>')
end;

initialization
{$IFDEF Debug}
   ecritDebug('initialization mathml');
{$ENDIF}
     latexStr := TstringList.create

finalization
     latexStr.free

end.
