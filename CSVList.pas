unit CSVList;

(*
Unité contenant une surcharge gÃ©nÃ©rale de la classe TStringList, qui permet de prendre en charge du texte (simple ligne ou fichier complet) au format CSV (Coma Separated Values / Valeurs sÃ©parÃ©es par des virgules). 

D'utilisation simple, il suffit de dÃ©clarer l'unitÃ© CSVList dans les Uses de votre projet aprÃ¨s l'unitÃ© Classe (important !) :
uses Windows, SysUtils, ..., Classes, ..., CSVList;

Il suffirat ensuite de crÃ©er un objet TStringList avec son constructeur CreateAsCSV pour beneficier des rÃ©glages pour traiter vos donnÃ©es/fichiers CSV, le reste de la gestion de passe avec les propriÃ©tÃ©s CSV*.
Le fonctionnement est fait pour que TStringList garde son fonctionnement normal malgrÃ© la surcharge.
*)

interface


uses
  Windows, SysUtils, Classes, Dialogs, StrUtils;

const
  CSVNoProtector = #0;
  CSVDefaultSeparator = ';';

type
  { TStringList }

  TStringList = class(Classes.TStringList)
  private { variables }
    fNoProtection  : boolean;
    fFirstRowNames : boolean;

  private { methods }
    function getCSV: string;
    procedure setCSV(const Value: string);

    function getField(row, col: integer): string;
    procedure setField(row, col: integer; const Value: string);

    function getProtector: char;
    procedure setProtector(const Value: char);

    function getSeparator: char;
    procedure setSeparator(const Value: char);

  public { properties }
    property CSVFieldNoProtect            : boolean read fNoProtection  write fNoProtection;
    property CSVFirstRowAsNames           : boolean read fFirstRowNames write fFirstRowNames;

    property CSVProtector                 : char    read getProtector   write setProtector;
    property CSVSeparator                 : char    read getSeparator   write setSeparator;
    property CSV                          : string  read getCSV         write setCSV;

    property CSVFields[row, col: integer] : string  read getField       write setField;

  public { functions }
    procedure ClearEmpty;

  public { constructors }
    constructor Create; reintroduce;
    constructor CreateAsCSV(aProtector, aDelimiter: char); reintroduce; virtual;
  end;


implementation

{ TStringList }

constructor TStringList.CreateAsCSV(aProtector, aDelimiter: char);
begin
  inherited;
  fNoProtection   := aProtector = CSVNoProtector;
  fFirstRowNames  := false;
  Delimiter       := aDelimiter;
  QuoteChar       := aProtector;
  StrictDelimiter := true;
end;

function TStringList.getCSV: string;
var F,L: integer;
begin
  L := count-1;
  result := '';
  for F := 0 to L do
  begin
    if fNoProtection or (quoteChar=#0) then
      result := result + Strings[F]
    else
      result := result + quoteChar + strings[F] + quoteChar;
    if F < L then
      result := result + Delimiter;
  end;
end;

function TStringList.getField(row, col: integer): string;
var T: TStringList;
begin
  T := TStringList.CreateAsCSV(QuoteChar, Delimiter);
  try
    T.CSV  := Strings[row];
    result := T[Col];
  finally
    T.Free;
  end;
end;

function TStringList.getProtector: char;
begin
  result := QuoteChar;
end;

function TStringList.getSeparator: char;
begin
  result := Delimiter;
end;

procedure TStringList.setCSV(const Value: string);
begin
  delimitedText := Value;
end;

procedure TStringList.setField(row, col: integer; const Value: string);
var T: TStringList;
begin
  T := TStringList.CreateAsCSV(QuoteChar, Delimiter);
  try
    T.CSV        := Strings[row];
    T[Col]       := value;
    Strings[Row] := T.CSV;
  finally
    T.Free;
  end;
end;

procedure TStringList.setProtector(const Value: char);
begin
  QuoteChar := Value;
  fNoProtection := value = CSVNoProtector;
end;

procedure TStringList.setSeparator(const Value: char);
begin
  Delimiter := Value;
end;

procedure TStringList.ClearEmpty;
var X: integer;
begin
  BeginUpdate;
  try
    for X := Count - 1 downto 0 do
      if Trim(Strings[X]) = emptyStr then
        Delete(X);
  finally
    EndUpdate;
  end;
end;

constructor TStringList.Create;
begin
  inherited;
  fNoProtection := false;
  fFirstRowNames:= false;
end;


end.

(*
CSVSeparator : Char
property TStringList.CSVSeparator: char;
Permet de dÃ©finir le caractÃ¨re qui servira Ã  sÃ©parer les champs CSV.
Vous pouvez lui assigner CSVDefaultSeparator (;) ou n'importe quel autre sÃ©parateur (Tabulation, Virgule, etc).

Exemple :

CSVL := TStringList.CreateAsCSV('"', ';');
try
  CSVL.CSV := '"bonjour";"Comment Ã§a vas ?";"Hello";"World !"';

  showMessage(CSVL[0]+', '+CSVL[1]);   // Bonjour, Comment Ã§a vas ?
  showMessage(CSVL[2]+' '+CSVL[3]);   // Hello World !
finally
  CSVL.Free;
end;
Exemple :

CSVL := TStringList.CreateAsCSV('"', ';');
try
  CSVL.CSV := '"bonjour";"Comment Ã§a vas ?";"Hello";"World !"';

  showMessage(CSVL.CSV);   // "Bonjour";"Comment Ã§a vas ?";"Hello";"World !"

  CSVL.CSVSeparator := '|';

  showMessage(CSVL.CSV);   // "Bonjour"|"Comment Ã§a vas ?"|"Hello"|"World !"
finally
  CSVL.Free;
end;



CSVProtector : Char
property TStringList.CSVProtector: char;
Permet de dÃ©finir le caractÃ¨re qui servira Ã  proteger les champs CSV.
Vous pouvez lui assigner la valeur #0 ou CSVNoProtector pour dÃ©sactiver la protection des champs.

Exemple :

CSVL := TStringList.CreateAsCSV('"', ';');
try
  CSVL.CSV := '"bonjour";"Comment Ã§a vas ?";"Hello";"World !"';

  showMessage(CSVL[0]+', '+CSVL[1]);   // Bonjour, Comment Ã§a vas ?
  showMessage(CSVL[2]+' '+CSVL[3]);   // Hello World !
finally
  CSVL.Free;
end;
Exemple :

CSVL := TStringList.CreateAsCSV('"', ';');
try
  CSVL.CSV := '"bonjour";"Comment Ã§a vas ?";"Hello";"World !"';

  showMessage(CSVL.CSV);   // "Bonjour";"Comment Ã§a vas ?";"Hello";"World !"

  CSVL.CSVProtector := CSVNoProtector;

  showMessage(CSVL.CSV);   // Bonjour;Comment Ã§a vas ?;Hello;World !
finally
  CSVL.Free;
end;

CSVFirstRowAsNames : Boolean
property TStringList.CSVFirstRowAsNames: boolean;
Cette propriÃ©tÃ© n'est pas utilisÃ©e en interne dans la gestion CSV. Vous pouvez par contre l'utiliser Ã  l'instar de la propriÃ©tÃ© Tag de certains composant, vous pouvez l'utiliser pour vos propre traitements CSV.

Exemple :

if MyStringList.CSVFirstRowAsNames then
  iStart := 1
else
  iStart := 0;
for i := iStart to MyStringList.Count-1 do
  {...}


CreateAsCSV : Constructeur

constructor TStringList.CreateAsCSV(aProtector, aDelimiter: char);
Permet de crÃ©er une TStringList initialisÃ©e pour revecoir du texte au format CSV.
ParamÃ¨tres

- aProtector : char, caractÃ¨re de protection de champs CSV (#0 pour dÃ©sactiver la protection des champs).

- aDelimiter : char, caractÃ¨re de sÃ©paration des champs CSV (peut Ãªtre Tab, virgule, point virguel etc).


CSV

PropriÃ©tÃ©

String
property TStringList.CSV: string;
La propriÃ©tÃ© permet d'injecter une ligne CSV ou de rÃ©cuperer les lignes contenus dans TStringList comme etant les champs d'une ligne CSV.
Uniquement fait pour traiter un seule ligne CSV, chaque champ sera placÃ© dans les lignes de la TStringList, l'index de ligne correspondant ainsi Ã  l'index de la colone du champ CSV.

Exemple :

CSVL := TStringList.CreateAsCSV('"', ';');
try
  CSVL.CSV := '"bonjour";"Comment Ã§a vas ?";"Hello";"World !"';

  showMessage(CSVL[0]+', '+CSVL[1]);   // Bonjour, Comment Ã§a vas ?
  showMessage(CSVL[2]+' '+CSVL[3]);   // Hello World !
finally
  CSVL.Free;
end;
Exemple :

CSVL := TStringList.CreateAsCSV('"', ';');
try
  CSVL.add('Bonjour');
  CSVL.add('Comment Ã§a vas ?');
  CSVL.add('Hello');
  CSVL.add('World !');

  showMessage(CSVL.CSV);   // "Bonjour";"Comment Ã§a vas ?";"Hello";"World !"
finally
  CSVL.Free;
end;

ClearEmpty : Fonction

procedure TStringList.ClearEmpty;
ClearEmpty permet de vider les lignes vides (espaces, tabulations, fin de lignes ...) prÃ©sentent dans un TStringList.

Attention, avec l'utilisation de donnÃ©es CSV, ClearEmpty supprimera les champs vides.

CSVFieldNoProtect : Boolean
property TStringList.CSVFieldNoProtect: boolean;
Vous pouvez dÃ©finir cette propriÃ©tÃ© Ã  True ou False si vous dÃ©sirez activer ou dÃ©sactiver la protection des champs CSV.
Si vous avez dÃ©finit CSVProtector avec la valeur #0 ou CSVNoProtector (ou Ã  la crÃ©ation) cette propriÃ©tÃ© sera mise Ã  False automatiquement.
Vous n'avez pas besoin de gÃ©rer ces protections (habituellement des guillemets) quand vous lisez les champs CSV.


CSVFields : String
property TStringList.CSVFields[row, col: integer]: string;
CSVFields permet de lire ou d'Ã©crire un champ dans les donnÃ©es CSV multilignes contenues dans la TStringList.
Uniquement fait pour lire les champs dans plusieurs lignes CSV.

Le paramÃ¨tre "row" correspond Ã  l'index de la ligne (0 Ã  count-1)
Le paramÃ¨tre "col" correspond Ã  l'index de la colone CSV de la ligne (0 Ã  n) 
Exemple :

CSVL := TStringList.CreateAsCSV('"', ';'); // Notez que l'on crÃ©e quand mÃªme une liste CSV
try
  CSVL.LoadFromFile('flux.csv');

  showMessage(CSVL.CSVFields[0, 1]);
  showMessage(CSVL.CSVFields[0, 2]);

finally
  CSVL.Free;
end;


Une seule ligne CSV

Exemple1 :

CSVL := TStringList.CreateAsCSV('"', ';');
try
  CSVL.CSV := '"bonjour";"Comment Ã§a vas ?";"Hello";"World !"';

  showMessage(CSVL[0]+', '+CSVL[1]);   // Bonjour, Comment Ã§a vas ?
  showMessage(CSVL[2]+' '+CSVL[3]);   // Hello World !
finally
  CSVL.Free;
end;
Exemple :

CSVL := TStringList.CreateAsCSV('"', ';');
try
  CSVL.add('Bonjour');
  CSVL.add('Comment Ã§a vas ?');
  CSVL.add('Hello');
  CSVL.add('World !');

  showMessage(CSVL.CSV);   // "Bonjour";"Comment Ã§a vas ?";"Hello";"World !"
finally
  CSVL.Free;
end;


Un fichier CSV

Exemple 2 :

CSVL := TStringList.CreateAsCSV('"', ';'); // Notez que l'on crÃ©e quand mÃªme une liste CSV
try
  CSVL.LoadFromFile('flux.csv');

  showMessage(CSVL.CSVFields[0, 1]);
  showMessage(CSVL.CSVFields[0, 2]);

finally
  CSVL.Free;
end;
*)

