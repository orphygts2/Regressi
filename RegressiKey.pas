// Project: Regressi
// Generated by HelpNDoc - http://www.helpndoc.com

unit Regressi;

interface

const
  // Format: HELP_help-id = help-context
  HELP_Calculs = 70; 				 // Topic: "Calculs"
  HELP_Fonctionsdegestiondesdates = 35; 				 // Topic: "Fonctions de gestion des dates"
  HELP_Complexes = 8; 				 // Topic: "Complexes"
  HELP_Deriveeetintegrale = 12; 				 // Topic: "Dérivée et intégrale"
  HELP_Fonctionsparticulieres = 36; 				 // Topic: "Fonctions particulières"
  HELP_Fonctions = 34; 				 // Topic: "Fonctions"
  HELP_Equations = 19; 				 // Topic: "Equations"
  HELP_Trigonometrie = 66; 				 // Topic: "Trigonomètrie"
  HELP_Filtres = 33; 				 // Topic: "Filtres"
  HELP_MethodedEulersimulation = 22; 				 // Topic: "Méthode d'Euler (simulation)"
  HELP_Incertitudes = 48; 				 // Topic: "Incertitudes"
  HELP_Fourier = 73; 				 // Topic: "Fourier"
  HELP_OptionsFourier = 53; 				 // Topic: "Options Fourier"
  HELP_FenetreFourier = 23; 				 // Topic: "Fenêtre Fourier"
  HELP_Modelisation1 = 71; 				 // Topic: "Modélisation"
  HELP_Sauvegardedelamodelisation = 61; 				 // Topic: "Sauvegarde de la modélisation"
  HELP_Optionsdemodelisation = 55; 				 // Topic: "Options de modélisation"
  HELP_Modelisation = 49; 				 // Topic: "Modélisation"
  HELP_Bornes = 5; 				 // Topic: "Bornes"
  HELP_Residus = 60; 				 // Topic: "Résidus"
  HELP_Divergencedunemodelisation = 13; 				 // Topic: "Divergence d´une modélisation"
  HELP_Erreurdedomainededefinition = 20; 				 // Topic: "Erreur de domaine de définition"
  HELP_Ecartmodelisationexperience = 17; 				 // Topic: "Ecart modélisation expérience"
  HELP_Modelisationgraphique = 42; 				 // Topic: "Modélisation graphique"
  HELP_Timeout = 65; 				 // Topic: "Time-out"
  HELP_Tableau = 69; 				 // Topic: "Tableau"
  HELP_Parametrevolatil = 68; 				 // Topic: "Paramètre "volatil""
  HELP_Statistiques = 74; 				 // Topic: "Statistiques"
  HELP_Optionsstatistique = 56; 				 // Topic: "Options statistique"
  HELP_Fenetrestatistique = 27; 				 // Topic: "Fenêtre statistique"
  HELP_Fonctionsstatistiques = 37; 				 // Topic: "Fonctions statistiques"
  HELP_Graphique = 72; 				 // Topic: "Graphique"
  HELP_Optionsgraphe = 54; 				 // Topic: "Options graphe"
  HELP_Outilsgraphiques = 59; 				 // Topic: "Outils graphiques"
  HELP_Optionstexte = 57; 				 // Topic: "Options texte"
  HELP_Optionsdesvecteurs = 58; 				 // Topic: "Options des vecteurs"
  HELP_SauvegardePosition = 62; 				 // Topic: "Sauvegarde Position"
  HELP_Coordonnees = 9; 				 // Topic: "Coordonnées"
  HELP_Fenetregraphe = 25; 				 // Topic: "Fenêtre graphe"
  HELP_Animation = 2; 				 // Topic: "Animation"
  HELP_Origine = 6; 				 // Topic: "Origine"
  HELP_MethodedeCornishBowden = 11; 				 // Topic: "Méthode de Cornish-Bowden"
  HELP_Suppressiondepoints = 64; 				 // Topic: "Suppression de points"
  HELP_Incertitudes1 = 50; 				 // Topic: "Incertitudes"
  HELP_Fenetregrandeurs = 78; 				 // Topic: "Fenêtre grandeurs"
  HELP_Valeurs = 16; 				 // Topic: "Valeurs"
  HELP_Grandeurs = 38; 				 // Topic: "Grandeurs"
  HELP_Constantes = 15; 				 // Topic: "Constantes"
  HELP_Expressions = 14; 				 // Topic: "Expressions"
  HELP_Entreededonneesauclavier = 29; 				 // Topic: "Entrée de données au clavier"
  HELP_General = 76; 				 // Topic: "Général"
  HELP_IndexRegressi = 40; 				 // Topic: "Index Regressi"
  HELP_MenuFichier = 44; 				 // Topic: "Menu Fichier"
  HELP_Barredoutils = 3; 				 // Topic: "Barre d´outils"
  HELP_MenuEdition = 43; 				 // Topic: "Menu Edition"
  HELP_Barredetat = 4; 				 // Topic: "Barre d´état"
  HELP_Unites = 67; 				 // Topic: "Unités"
  HELP_Options = 52; 				 // Topic: "Options"
  HELP_EditionCollerdonnees = 7; 				 // Topic: "Edition|Coller données"
  HELP_Editeur = 18; 				 // Topic: "Editeur"
  HELP_Fenetregrandeurs1 = 24; 				 // Topic: "Fenêtre grandeurs"
  HELP_FichierOuvrir = 31; 				 // Topic: "Fichier|Ouvrir"
  HELP_Fenetreparametres = 26; 				 // Topic: "Fenêtre paramètres"
  HELP_Liens = 41; 				 // Topic: "Liens"
  HELP_FichierNouveauSimulation = 30; 				 // Topic: "Fichier|Nouveau|Simulation"
  HELP_FichierFusionner = 28; 				 // Topic: "Fichier|Fusionner"
  HELP_Impression = 39; 				 // Topic: "Impression"
  HELP_FichierImprimer = 32; 				 // Topic: "Fichier|Imprimer"
  HELP_Pages = 75; 				 // Topic: "Pages"
  HELP_Pagecalculee = 1; 				 // Topic: "Page calculée"
  HELP_Pagecopiee = 10; 				 // Topic: "Page copiée"
  HELP_MenuPages = 45; 				 // Topic: "Menu Pages"
  HELP_Acquisition = 0; 				 // Topic: "Acquisition"
  HELP_Video = 21; 				 // Topic: "Video"
  HELP_Son = 46; 				 // Topic: "Son"
  HELP_Images = 47; 				 // Topic: "Images"

implementation

end.