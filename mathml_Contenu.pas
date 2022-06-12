unit mathml_Contenu;


interface

uses sysutils, classes, Clipbrd, grids, regutil, compile, windows;

procedure AjouteGrandeur(index : integer);
procedure DebutDoc;
procedure FinDoc;
Function TranslateExpression(F:Pelement) : string;
Procedure AjouteParagraphe;
Procedure SaveFile(nomFichier : string);

implementation

var latexStr : TstringList;
    avecExposant : boolean;

Function UnicodeToLatexMath(carac : char) : string;
var j : integer;
begin
     avecExposant := false;
     case carac of
                      alpha : result := '\alpha ';
                      beta : result := '\beta ';
                      gamma: result := '\gamma ' ;
                      gammaMaj: result := '\Gamma ';
                      delta: result := '\delta ';
                      deltaMaj: result := '\Delta ';
                      epsilon: result := '\epsilon ';
                      zeta: result := '\zeta ';
                      eta: result := '\eta ';
                      kappa: result := '\kappa ';
                      lambda: result := '\lambda ';
                      lambdaMaj: result := '\Lambda ';
                      mu: result := '\mu ';
                      nu: result := '\nu ';
                      xi: result := '\xi ';
                      xiMaj: result := '\Xi ';
                      pimin: result := '\pi ';
                      piMaj: result := '\Pi ';
                      rho: result := '\rho ';
                      sigmaMin: result := '\sigma ';
                      sigmaMaj: result := '\Sigma ';
                      tau: result := '\tau ';
                      theta: result := '\theta ';
                      thetaMaj: result := '\Theta ';
                      phi: result := '\phi ';
                      phiMaj: result := '\Phi ';
                      chi: result := '\chi ';
                      psi: result := '\psi ';
                      psiMaj: result := '\Psi ';
                      omega: result := '\omega ';
                      omegaMaj: result := '\Omega ';
(*
                      'é' : result := '\''e'; // non nécessaire UTF-8 ?
                      'è' : result := '\`e';
                      'ê' : result := '\^e';
                      'ë' : result := '\''e';
                      'ï' : result := '\"\i';
                      'à' : result := '\`a';
                      'â' : result := '\^a';
                      'ù' : result := '\''u';
                      'û' : result := '\^u';
                      'ü' : result := '\"u';
                      'ô' : result := '\^o';
                      *)
                      '§' : result := '\S';
                      '&' : result := '\&';
                      '#' : result := '\#';
                      '°' : result := '\degres';
                      '±' : result := '\pm';
                      '%' : result := '\%';
                      pourmille : result := '\textperthousand';
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

function TranslateNomMath(anom : string) : string;
var i : integer;
begin
    result := '<m:mi> ';
    for i := 1 to length(anom) do
        result := result+unicodeToLatexMath(anom[i]);
    result := result + ' </m:mi>';
end;

Function TranslateExpression(F:Pelement) : string;
// renvoie le code MathML d'un arbre pointé par F

Function calcIf(ff : Pelement): string;
begin with ff^ do begin
   result := 'if';
   result := result + TranslateExpression(positif);
   result := result + TranslateExpression(negatif);
end end;

Function calculFonctionGlb(F : Pelement): string;

Function CalcIntegrale : String; // intégrale operandGlb / varMuette de a à b
var a,b,sigma,vm : string;
begin with F^ do begin
        a := translateExpression(operandDebut);
        b := translateExpression(operandFin);
        vm := translateNomMath(Grandeurs[cMuette].nom);
        sigma := translateExpression(operandGlb);
        result := '\m:int'+'_{'+a+'}'+'^{'+b+'}'+sigma+'\, d'+vm;
end end; // CalcIntegrale

var freqLoc,rapportCyclique,anom,anomY : string;
begin with F^ do begin // calculFonctionGlb
    result := '';
    aNom := translateNomMath(varX.nom);
    if CodeFglb in [maximum,position,minimum,moyenne,somme,efficace,frequence,
                    ecartType,surface,phase,initial] then begin
                     result := LowerCase(nomFonctionGlb[CodeFglb])+'('+aNom+')';
                     exit;
    end;
    if CodeFglb in [pente,origine] then begin
        aNomY := translateNomMath(varY.nom);
        result := LowerCase(nomFonctionGlb[CodeFglb])+'('+aNom+','+anomY+')';
        exit;
    end;
    if CodeFglb=derivee then begin
        aNomY := translateNomMath(varY.nom);
        result := '\m:frac{d\; '+anomY+'}{d\; '+aNom+'}';
        exit;
    end;
    freqLoc := translateExpression(OperandGlb);
    rapportCyclique := translateExpression(OperandDebut);
    aNom := translateNomMath(varX.nom);
    case CodeFglb of
         equation : CalculFonctionGlb := freqLoc;
         integraleDef : CalculFonctionGlb := CalcIntegrale;
         fonctionPage : CalculFonctionGlb := 'page';
         cCreneau : CalculFonctionGlb := 'Creneau('+freqLoc+','+rapportCyclique+')';
         cCnp : CalculFonctionGlb := 'C_{'+freqLoc+'}{'+rapportCyclique+'}';
         cTriangle : CalculFonctionGlb := 'Triangle('+freqLoc+','+rapportCyclique+')';
         cGauss : CalculFonctionGlb := 'Gauss('+freqLoc+','+rapportCyclique+')';
         cPhaseModulo : CalculFonctionGlb := 'PhaseModulo'+anom+freqLoc+','+rapportCyclique+')';
         cPoisson : CalculFonctionGlb := 'Poisson('+anom+','+freqLoc+')';
         cBessel : CalculFonctionGlb := 'BesselJ('+rapportCyclique+','+freqLoc+')';
         cPeigne : CalculFonctionGlb := 'Peigne('+rapportCyclique+','+freqLoc+')';
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
            if parX then X := '('+X+')';
            Y := translateExpression(OperD);
            parY := (OperD.TypeElement=Operateur) and
                    charInSet(OperD.CodeOp,['+','-']) and
                    charInSet(CodeOp,['*','&','#','@']);
            if parY then Y := '<m:mfenced>'+Y+'</m:mfenced>';
            Case CodeOp of
                 '+' : result := '<apply> <m:plus/> '+X+Y +' </apply>';
                 '<' : ;
                 '-' : result := '<<apply> <m:minus/> '+X+Y+' </apply>';
                 '>' : ;
                 '=' :;
                 '*' : result := '<apply> <m:plus/> '+X+Y+'</apply>';
                 '/' : result := '<m:mfrac> '+'<m:mrow> '+X+'</mrow> <m:mrow>'+Y+'</m:mrow>'+' </m:mfrac>';
                 '@' : result := 'arg('+X+'+j'+Y+')';
                 '#' : result := 'arg('+X+'-j'+Y+')';
                 '^' : result := '<apply> <power/>' +X+Y+ '</apply>';
                 '&' : result := 'arg('+X+'+j'+Y+')';
             end;{case codeOp}
       end;{operateur}
       Fonction: Begin
             X := translateExpression(Operand);
             result := LowerCase(nomFonction[codeF])+'('+X+')';
       End;{Fonction}
       FonctionGlb : result := calculFonctionGlb(F);
       IfThenElse : result := calcIf(F);
       grandeur : result := translateNomMath(Pvar.nom);
       grandeurIndicee,IncertIndicee : result := translateNomMath(Pvariab.nom)+
                '<m:mfenced>'+'<m:mn> '+intToStr(round(numero))+'</m:mn> '+'</m:mfenced>';
       Nombre,RacineMoinsUn : result := '<m:mn> '+floatTostr(valeur)+' </m:mn>';
     	 Incert : result := '';
  End;{case}
End; //  TranslateExpression

procedure AjouteGrandeur(index : integer);
begin with grandeurs[index] do
     LatexStr.Add('<m:math  display=''block''>  <m:semantics>'+
               translateNomMath(nom)+'='+translateExpression(fonct.calcul)+
               ' </m:semantics> </m:math>');
end;

<m:math display='block'>
 <m:semantics>
  <m:mrow>
   <m:mi>&zeta;</m:mi><m:mrow><m:mo>(</m:mo>
    <m:mrow>
     <m:mi>s</m:mi><m:mo>,</m:mo><m:mi>a</m:mi>
    </m:mrow>
   <m:mo>)</m:mo></m:mrow><m:mo>&equiv;</m:mo><m:munderover>
    <m:mo>&sum;</m:mo>
    <m:mrow>
     <m:mi>k</m:mi><m:mo>=</m:mo><m:mn>0</m:mn>
    </m:mrow>
    <m:mi>&infin;</m:mi>
   </m:munderover>
   <m:mrow>
    <m:mfrac>
     <m:mn>1</m:mn>
     <m:mrow>
      <m:msup>
       <m:mrow>
        <m:mrow><m:mo>(</m:mo>
         <m:mrow>
          <m:mi>k</m:mi><m:mo>+</m:mo><m:mi>a</m:mi>
         </m:mrow>
        <m:mo>)</m:mo></m:mrow>
       </m:mrow>
       <m:mi>s</m:mi>
      </m:msup>

     </m:mrow>
    </m:mfrac>

   </m:mrow>

  </m:mrow>
  </m:semantics>
</m:math>


procedure DebutDoc(titre : string);
begin
    latexStr.clear;
    latexStr.add('<?xml version="1.0" encoding="UTF-8" ?>');
    latexStr.add('<!DOCTYPE HTML PUBLIC "-//W3C//DTD W3 HTML//EN">');
    latexStr.add('<html xmlns:m="http://www.w3.org/1998/Math/MathML" lang="en">');
    latexStr.add('<head>');
    latexStr.add('<OBJECT ID=MathPlayer CLASSID="clsid:32F66A20-7614-11D4-BD11-00104BD3F987"'+
    'title="MathPlayer"><img alt="" src="" longdesc="http://www.dessci.com/en/products/mathplayer/longdesc.htm"></OBJECT>');
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

Procedure SaveFile(nomFichier : string);
begin
   latexStr.saveToFile(nomFichier,TEncoding.UTF8);
end;

Procedure AjouteParagraphe;
begin
  latexStr.add('<br/>');
end;

initialization
     latexStr := TstringList.create

finalization
     latexStr.free

end.
