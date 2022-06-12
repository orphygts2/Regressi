unit constreg;

interface

uses
  Windows;

const
   crCRLF = #13+#10;
   labelCaptionAngle : array[boolean] of string = ('Angle en radian','Angle en degr�');
   stOuiNon : array[boolean] of string = ('Non','Oui');
   stDebutUniteSI : array[boolean] of string = ('calcul SANS','calcul AVEC');
   stPageActive : array[boolean] of string = ('|Page inactive','|Page active');
   OkUniteSI : array[boolean] of string = ('Prise en compte des coeff. d''unit�',
                                           'Non prise en compte des coeff. d''unit�');

resourcestring

stFinUniteSI=' prise en compte des coefficients d''unit�';
stNewPage= 'Nouvelle page';
stIntervalle95='Intervalle de confiance � 95%';
stIncertitudeType='Incertitude-type';
erProgAcqDialog='Impossible de dialoguer (DDE) avec ';
okPageVersCol='Transformer les pages en colonnes';
okNonNum='Utilisation d''une grandeur non num�rique';
erNotExists=' n''existe plus';
erFileExists='Le fichier n''existe pas';
erNonNum='Variable non num�rique';
erEffectifNotInt='Effectif non entier !';
erPourCent='Somme des fr�quences diff�rente de 100 !';
erFrameRate='Nombre de trames par seconde incorrecte';
stAuto='Auto';
stLongitude ='Longitude';
stEllipse='Ellipse';
stJouer='Jouer';
stRegressi='Regressi';
stPenStyle='PenStyle';
stPointStyle='PointStyle';
stFFT = 'FFT';
stRepertoire = 'Repertoire';
stFormat = 'Format';
stFilDeFer = 'FilDeFer';
stLigne = 'LIGNE';
stMonde = 'MONDE';
stFenetre = 'FENETRE';
stModele = 'MODELE';
stDessin = 'DESSIN';
stImprimante = 'Imprimante';
stGrille = 'Grille';
erSonagramme = 'Indisponible pour le sonagramme';
stAvi = 'AVI';
stWav = 'WAV';
stCaptureCB = 'CameraCB';
stCaptureTB = 'CameraTB';
stSauvegarde = 'Sauvegarde';
stImportEtoile = 'Eviter syntaxe from Regressi import *';
stMatplotlibBloc = 'L''utilisation de show() de matplotlib est bloquante'+crCRLF+
                   'Fermer la fen�tre graphique ouverte pour continuer';
stPyQtBloc = 'L''utilisation de show() de PyQt est bloquante'+crCRLF+
             'Fermer la fen�tre graphique ouverte pour continuer';
stPythonRegressi = 'Pour r�cup�rer les donn�es de Regressi'+crCRLF+'import Regressi';

identAcceleration='Acceleration';
identVitesse='Vitesse';

erVarPythonExists = 'Tentative de recalculer une grandeur d�j� calcul�e';
erPython = 'Erreur dans le script Python'+crCRLF+'voir la console (fond noir)';
erFormatPCM='Format de fichier attendu : PCM';
erEchelle='Echelle incorrecte';
erPbImprimante='Impossible de se connecter (HP LaserJet 1600 ?)';
erPageModele='Syntaxe : y[numero de page]=f(x)';
erNomVide='Nom vide';
erNomGrandeurVide='Pas de nom de variable � affecter';
erDebutNom='Un nom doit commencer par une lettre';
erNomInterdit='Nom interdit (j^2=-1 pi=3.1416)';
erNomFonction='Nom interdit (nom de fonction : Im Re Arg Min Max...)';
erDoubleOperateur='Deux op�rateurs � la suite : ';
erNomExistant='Nom interdit (d�j� existant)';
erMuette='Nom interdit pour une variable muette (d�j� existant)';
erVarTexte='Calcul impossible avec une grandeur texte';
erUnite='Unit� incorrecte';
erAire='''->La fonction aire(x,y) d�termine l''aire d''une surface ferm�e';
erNbreVarInf2='Il faut au moins deux variables';
erFileNotExist='Fichier non trouv�';
erCaracNom='Caract�re interdit dans un nom';
erParamModeleVersExp='Utilisation d''un param�tre de mod�lisation (donc susceptible de dispara�tre)';
erNbreGradManuel='Nombre de graduations <2 ou >64 => retour au mode automatique';
erOrtho='V�rifier l''option "orthonorm�" (boite de dialogue coordonn�es)';
erInv='V�rifier la graduation inverse (boite de dialogue coordonn�es)';
erExpressionVide='Expression vide';
erTexteNotTest='Texte en dehors d''un IF';
erFonctionNil='Fonction non initialis�e';
erNombrePetit='Mod�lisation impossible : nombre de valeurs < nombre de param�tres';
erVide='Expression vide';
erNombre='Nombre mal �crit';
erTropLong='Identificateur trop long';
erInterne='Erreur interne';
erTropComplexe='Expression trop compliqu�e';
erParF='Manque )';
erParO='Manque (';
erParamSolve='Manque un param�tre : solve(equation,min,max)';
erParamMoyenne='Manque un param�tre : mean(variable,debut,fin)';
erVarInterdite='Variable interdite';
erParamInterdit='Param�tre interdit';
erTropParam='Trop de param�tres';
erVirgule='Manque ,';
erVarAttendue='Variable attendue';
erFonctNonCpx='Fonction interdite dans les complexes';
erOperNonCpx='Operateur interdit dans les complexes';
erReel='Le r�sultat doit �tre r�el (Re;Im;Arg;Abs)';
erSyntaxe='Erreur de syntaxe';
erCalcul='Erreur de calcul';
erSyntaxeModele='Syntaxe du mod�le : Y(X)=f(X)';
erSyntaxeIncert='Syntaxe de l''incertitude type : u(X)';
erVarInconnue='Variable non reconnue';
erDomaine='Fonction hors de son domaine de d�finition';
erDivergence='Divergence de la mod�lisation';
erTimeOut='Arr�t de la mod�lisation au bout de 32 it�rations';
erPageCalc='Pas de zone commune entre les diff�rentes pages';
erDerNonDef='D�riv�e non d�finie';
erSyst1Var='Syst�me d''�qua diff n�cessite la m�me variable explicative';
erNonInstallee ='Fonction non install�e';
erVarDef='Grandeur d�j� d�finie';
erMaxModele='Nombre maximum de mod�les : 4';
erEgalAbsent='Syntaxe des fonctions : nom=''expression';
erCaracInterdit='Caract�re interdit';
erGenreModele='Les mod�les doivent �tre de m�me type : fonction OU �qua. diff. d''ordre 1 OU 2';
erVarOrNombre='Doit �tre un param�tre ou une valeur num�rique';
erModeleGlb='Mod�lisation par fonction uniquement dans l''espace des param�tres';
erCrochet='[] interdit y[min] de Regressi DOS remplac� par min(y)';
erCurseurModele='Mod�lisation non accessible';
erNmesInf16='Nombre de points trop faibles <16';
erFormat='Format fichier incorrect';
erConst3D='Crochets non permis';
erFonctionPageNonPermis ='Fonction page[n] non permise';
erParamInconnu='Param�tre inconnu';
erGrandTableau='Impression de grand tableau interdite';
erXOR='Op�rateur interdit en dehors de IF';
erFileAdd='Erreur � la lecture du fichier';
erFileLoad='Impossible d''ajouter le fichier';
erModeleGr='Donn�es non coh�rentes avec le mod�le';
erInitAdefinir='Donnez une valeur initiale dans l''onglet param�tres';
erConstNonDef='Valeur de param�tre exp�rimental absente';
erParamAdefinir='Donnez une valeur aux param�tres';
erSuperGlb='Superposition de fonction en construction';
erCurseurTangente='Impossible : abscisse<>premi�re variable';
erGradNonLineaire='Impossible : graduations non lin�aires';
erPrimeRRR='Caract�re '' interdit dans les variables (r�serv� aux �qua. diff�rentielles)';
erDiffSimul='Le nombre maxi d''�quations dans un syst�me est de ';
erEcart='Ecart mod�le-exp�rience tr�s grand v�rifier vos param�tres';
erFonctionGlbIsole ='Les fonctions Intg Diff Harm Filtre ... doivent �tre utilis�es isol�ment';
erVarFreq='Nom r�serv� pour les s�ries de Fourier';
erPlotter='Installer un traceur dans le panneau de configuration d''imprimantes';
erColPrinter='Nombre de colonnes trop grand : penser au mode paysage ou au couper-coller';
erBadDataNom='Donn�es incompatibles : noms diff�rents';
erSuperposePage='Positionnement de l''origine une page � la fois';
erSyntaxeDDE='Syntaxe Macro DDE : Fonction(Param�tre)';
erDDEone='Un message DDE � la fois SVP';
erPuissEnt='Puissance non enti�re';
erPointModele='Un point non pris en compte : n�';
erDiff0='La variable explicative des �qua. diff. est la premi�re colonne';
erRemplitLog='Remplissage exponentiel avec valeur <= 0';
erModeleSystDiff='Syst�me diff. uniquement';
erFileData='Donn�es du fichier incorrectes';
erProgAcq='Programme d''acquisition inconnu';
erDDE='Liaison DDE impossible avec ';
erIndexNotVariab ='Interdit en dehors des variables';
erCrochetF='] attendu';
erPosMin='Posmin; posmax remplac�s par pos(variable;�quation;[up|down|mini|maxi])';
erTangenteAgauche='L''axe doit �tre � gauche';
erOrigineExp='Modification uniquement pour grandeur exp�rimentale';
erModeleIncorrect='D�sactiver le mode superposition de pages';
erWriteFile='Erreur d''�criture du fichier';
erReadFile='Erreur de lecture du fichier';
erReadVotable='N''est pas un fichier Votable';
erReadRegressiXML='N''est pas un fichier Regressi XML';
erDOMXML ='Parser XML non trouv�';
erFonctionPage='page(nombre)';
erOriginePage='N�cessite une seule page active';
erExposantCpx='Exposant uniquement entier � l''int�rieur des complexes';

OkDelFile='Ecraser le fichier existant';
OkImprGr='Impression du graphe';
OkImprTab='Impression des tableaux';
OkDelData='Suppression des donn�es s�lectionn�es';
OkDelAll='Effacement de la page courante';
OkUniteInconnue='Unit� non reconnue vous confirmez ?';
OkNoParamAuto='Pas d''expression. D�sactiver g�n�ration auto ?';
OkVarTri='Garder %s comme variable tri�e';
OkSauve='Sauvegarde de l''�tat courant ?';
OkMobile2='Deuxi�me mobile ?';
OkDelPage='Suppression de la page n�%s';
OkModifGr='Modification du graphe selon mod�le ?';
OkImprModele='Impression de la mod�lisation';
OkInitParam='Initialisation des param�tres ?';
OkDelVariab='Ecraser l''ancienne variable %s';
OkBadDataNom='Donn�es incompatibles (noms diff�rents) on continue ?';
OkBadDataNewFile='Donn�es incompatibles avec les donn�es courantes => Cr�er un nouveau fichier ?';
OkImprTabVariab='Impression du tableau des variables';
OkModifOrigine='Effectuer le changement d''origine ?';
OkImprCurseur='Impression des valeurs mod�lis�es';
OkPaysage='Impression avec orientation paysage';
okSupprIdentCoord='Suppression des identifications de courbes';

trFiltreModele ='Mod�lisation (*.mod)|*.mod';
trFiltreWMF='Metafichier Windows (*.emf)|*.emf';
trFiltreExe='Ex�cutable (*.exe)|*.exe|Batch (*.bat)|*.bat';
erPrefixe='Essayer de travailler en S.I. sans pr�fixe m k ... (sauf kg !)';
erUneLigneSurN ='Impression d''une ligne sur %s';
erAxeLog='Axe log. ou dB impossible : valeurs <= 0 ?';
erDiff2='Equation diff�rentielle d''ordre 1 ou 2';
hNbreharm = 'Nombre de valeurs d''harmoniques affich�es';
hFreqBasse = 'Indisponible : fr�quence �chantillonnage < 2 kHz';
hFreqHaute = 'Indisponible : fr�quence �chantillonnage > 100 kHz';
hFreqNulle = 'Indisponible : trop peu de points';
hSupprPointActif ='|Suppr : suppression du point cliqu� ; barre : d�sactivation du point';
hSupprPointNonActif ='|Suppr : suppression du point cliqu� ; barre : activation du point';
hMove ='|Cliquer-glisser pour modification de la position du zoom';
hValeurModele ='|Entrez une valeur et validez pour calculer';
hGlisser='|Glisser pour d�placer';
hOrigineTemps='Cliquer sur le point enregistr� qui sera l''origine des temps';
hDbleTexte='Clic droit pour modifier le texte ou supprimer';
hDbleCouleur='Clic droit pour choix de couleur/style de la ligne ou suppression';
hOrigineGraphe='|Positionner la verticale � la nouvelle origine puis cliquer';
hAxeX='Cliquer-glisser pour modifier l''orientation de l''axe "horizontal"';
hAxeY='Cliquer-glisser pour modifier l''orientation de l''axe "vertical"';
hSegment='|Cliquer � l''intersection du r�ticule puis faire glisser'+crCRLF+
         'F10:enregistre la position courante ; ESC=fin';
hCurseurFrequence='F10:enregistre la position courante ; ESC=fin';
hClicDroit='|Utiliser le clic droit pour ouvrir le menu local';
hHistoResidu='Histogramme des r�sidus';
hLectureAvi= 'Lecture du film et conversion en images BMP';
hExpFFT='|Tapez une expression fonction de %s uniquement';
hindice='%s va de 0 � %s-1';
hEuler=' signifie valeur de x au point i';
hMoyenne='Abscisse=moyenne ; ordonn�e=maximum';
hEcartType='Abscisse=moyenne+(ecart type)';
hDemiLargeur= 'Abscisse=moyenne+(demi largeur)';
hDebutModele='Mod�liser|Ouvrir le volet de mod�lisation';
hFinModele='Fin mod�lisation|Fermer le volet de mod�lisation';
trSupprVar='Suppression de %s';
hRowUnit='|Double-clic dans l''en-t�te pour modifier unit� ; incertitude';
hMovePoint ='|D�placer le point de r�f�rence';
hPeriode='|Abscisse=p�riode ordonn�e=d�calage de z�ro';
hMaxi='|Maximum du sinus : position et valeur';
hCteTemps='|Abscisse=constante de temps';
hAsymptote='; ordonn�e=asymptote';
hDirection= '|Direction';
hEchelle='|Echelle';
hValeur0='; ordonn�e=valeur initiale';
hClicPage ='(double clic sur le point pour changer l''�tat)';
hFreqCoupure ='abscisse : fr�quence caract�ristique';
hGainMax ='ordonn�e : gain maximal';
erMotdepasse='Suppression du mot de passe';
hValeurAsymptote=' 	Intersection des asymptotes';
erVttAdd ='Impossible de fusionner des fichiers LAB';
erBoucleFor='Syntaxe de boucle for i:=exp to exp do';
erFinBoucle='end permis en fin de boucle';
okSupprAutresPages='Suppresssion des points de toutes les pages actives';
erDataCan='Donn�es non modifiables (voir Options Acquisition)';
erChargeOldReg='Rechargement du dernier fichier';
okrazModele='Remise � 1 des param�tres';
okrazParam='Suppression de la mod�lisation';
erForward ='D�finir la grandeur pr�d�finie par x= ou x[0]=a';
okSauveOptions ='Sauvegarde des options pour tous les utilisateurs';
OkDataInf='Pas assez de variables ; on continue';
OkDataSup='Trop de variables : on continue';
ErGommeStat ='S�lectionnez les points sur l''axe des abscisses';
hFinGomme='Arr�t de suppression de points';
erLigneNulle ='D�finition de ligne par glisser';
erObjetGraphiqueIsole ='';
erNomObjetGraphique ='';
erFileCalc='Nom de variables non compatibles';
erNbreData='Pas assez de donn�es';
erIndiceEuler='Syntaxe : x[i]= et non x[i+1]=';
erPeigneSimul='Peigne disponible uniquement en mode simulation';
erParamIF='UN argument manquant � IF(condition,si vraie,sifausse)';
erParamPW='Syntaxe PieceWise([test,then],else)';
erRadian='Passage en radian';
erVerifRadian= 'Actuellement en degr�. Passage en radian ?';
erOneCol='Une seule colonne � la fois';
erValeurNoDef = 'Valeur non d�finie dans la page n� ';
erServeur='Impossible de dialoguer avec le serveur';
erSysLin= 'Erreur r�solution syst�me lin�aire';

trTempsLim = 'Dur�e impos�e';

stAddModele= '&Ajouter mod�le';
stReplaceModele = '&Remplacer mod�le';
stResiduStudent = 'R�sidu studentis� ';
stResiduNormalise = 'R�sidu normalis� ';
stResidusStudent = 'R�sidu studentis�s';
stResidusNormalises = 'R�sidu normalis�s';
stLimiteStudent95 = ' (limite de Student � 95% : ';
stMoyenne = 'Moyenne ';
stAnimation = 'Animation';
stFinAnimation = 'Fin animation';
stMediane= 'M�diane ';
stEcartType = 'Ecart-type ';
stMini= 'Mini';
stMaxi= 'Maxi';
stValeur= 'Valeur ';
stMinimum= 'Minimum';
stMaximum= 'Maximum';
stIntensite = 'Intensit� relative';
stCible= 'Cible ';
stTaille= 'Taille ';
stOuvrir= 'Ouvrir';
hInitialise= '|Initialise';
stUnGraphe='Un graphe';
stDeuxGraphes='Deux graphes';
stEtendue= 'Etendue : ';
stNom ='Nom';
stTemps='Temps';
stSymbole='Symbole';
stUnite='Unit�';
stSignif= 'Signification';
hBornes='Bornes PUIS expression|D�finir un nouveau mod�le par un rectangle (bornes) PUIS taper la fonction';
trBornesModele = 'Bornes et nouveau mod�le';
stPente='Pente';
stPvaleur='Valeur-p(';
stIntersection = 'Intersection' ;
stAngle ='Angle';
stRayon ='Rayon';
stAbscisse= 'Abscisse';
stOrdonnee= 'Ordonn�e';
stInexactitude = 'Inexactitude';
stEquivalence = 'Equivalence';
stTangente= 'Tangente';
stBorne = 'Bornes de ';
stBornes ='Bornes';
stCourbe ='Courbe ';
stReticule= 'R�ticule';
stStatistique = 'Statistique : ';
stTableau= 'Tableau ';
stNbrePas = 'Nombre de pas : ';
stPage= 'Page';
stIncertitude = 'Incertitude';
stIncert= 'Incert. sur ';
stOptions = 'OPTIONS';
stPhase= 'Phase';
stPhaseContinue = 'Phase continue';
stContinu = 'Continu ';
stCouleur = 'Couleur';
stTest1= 'R�sultat d''un r�glage manuel';
stTest2= 'des param�tres. Pour optimiser,';
stTest4= 'Optimisation des param�tres';
stTest5= '� effectuer';
stTest3= 'cliquer sur ajuster';
stTest6= 'cliquer sur le bouton "coche rouge"';
stVariables = 'Variables';
stGrandeurs = 'Grandeurs';
stModelisation = 'Mod�lisation';
stAxes= 'Axes';
stIteration = 'It�ration n�';
stIntervalle = '�me intervalle';
stDerivee= 'D�riv�e';
stGraphe= 'Graphe';
stAbsolue='absolue';
stRelative='relative';
stDbDecade = 'dB/d�cade';
stColor= 'Color';
stCouleurPoint= 'PointCl';
stNbreDec='Nombre de d�cimales';
stNbreChiffres ='Nombre de chiffres';
stNbreBits ='Nombre de bits';
stFreqreduite ='Fr�quence r�duite';
stDebutDe =' le d�but de ';
stFinDe = ' la fin de ';
stEcartQuad='Ecart quad. ';
stCoeffCorrel = 'Coeff. corr�lation';
stGrad = 'Grad.';
stSubdiv ='Nbre div.';
stClicVecteur = 'Cliquer sur un point pour tracer (ou effacer) un vecteur';
stClicIndicateur = 'Clic droit pour changer d''indicateur';
stCaracStat ='Caract�ristique statistique de ';
stNomVariab ='Nom des variables :';
stFinModele ='Fin mod�lisation';
stValeurReticule = 'Valeurs du r�ticule';
stValeurModele= 'Valeurs mod�lis�es';
stNomModele = 'Nom de la grandeur mod�lis�e';
stCommentaire= 'Commentaire';
stCalcVitesse = 'Calculer la vitesse !';
stCalcAcceleration = 'Calculer l''acc�l�ration !';
stCopiePage = 'Recopie de la page';
stGridValeurs = '&Tableau valeurs';
stRazValeurs = 'R�&Z des valeurs';
stGridTangente = '&Tableau tangentes';
stRazTangente = 'R�&Z des tangentes';
stResultModele = 'R�sultat de la mod�lisation';
stEcartRelatif = 'Ecart relatif donn�es-mod�le ';
stEcartTypeModele = 'Ecart-type donn�es-mod�le ';
stTriVariab = 'Tri des donn�es selon une variable';
stTriPages = 'Tri des pages selon un param�tre';
stSupprGrandeur = 'Suppression d''une grandeur';
stCadreGTS = 'Recadrage de donn�es acquises par Orphy GTS';
stBorneSelect = 'Bornes � la souris|D�finir les bornes en tra�ant un rectangle';
stBarreReticuleFFT = '|F10: enregistre position courante'+crCRLF+
                     'Barre d''espace: marque le pic proche';
stBarreReticule1 = 'F10:enregistre la position courante ; ESC=fin'+crCRLF+'Barre d''espace:laisse une trace (cf. clic droit tableau)'+crCRLF+'clic:mesure d''�cart';
stBarreReticule3 = 'F10:enregistre la position courante ; ESC=fin'+crCRLF+'clic:suppression deuxi�me curseur';
stBarreReticule2 = 'F10:enregistre la position courante ; ESC=fin'+crCRLF+'clic:fixe l''�cart';
stExper = ' exp�rimentale';
stCalcul = 'Calcul';
stVariable = 'Variable';
stConstante = 'Param�tre';
stParam = 'Param�tre de mod�lisation';
stTexte = ' texte';
stSigmaResidu = '(sigma des r�sidus)';
stEcart = '�cart = ';
stComment = 'Commentaires';
stAcqBy = 'Acquisition par ';
stNEuler = 'Nombre de points : N=';
stModif = 'modifications de ';
stData = 'donn�es';
stOrigine = 'Origine';
stSauve  = 'Sauvegarde des ';
stFinZoom =
'|Glisser puis rel�cher pour d�finir le deuxi�me point du rectangle d�limitant la zone concern�e';
stDebutZoom =
'|Cliquer pour d�finir le premier point du rectangle d�limitant la zone concern�e';
stChoixPagesGr = 'Choix des pages � regrouper en une seule';
stGroupeSuper = 'Attention : regroupe ne superpose pas';
stChoixPages = 'Choix des pages actives';
stUndoSuppr = '&Annuler suppression de ';
stNoAcces = 'Impossible d''acc�der � ';
stNoAccesInstall = 'Effectuer l''installation de Regressi pour acc�der � ';
stMajImpossible = 'Impossible d''acc�der au site de mise � jour';
stUndoGr = '&Annuler grouper';
stEchantillon = 'Echantillonnage';
stCaracde = 'Caract�ristiques de ';
stSigmay = 'Ecart-type sur ';
stImportCalc = 'Importer les traitements';
stUser='Utilisateur';
stName='Pr�nom nom';
stPrint='Impression';
stEnTete='En-t�te';
stArduino= 'Arduino';
stFonte='Fonte';
stStop='Stop';


hSonagramme = 'Sonagramme : repr�sentation fr�quence-intensit� en fonction du temps';
hNotSonagramme = 'Sonagramme non disponible : nombre de points < 8192';
hGommeStat= '|S�lectionner � la souris (cliquer-glisser) les points � supprimer (Ctrl enfonc�e pour recommencer)';
hTriDataDlg = 'Tri des donn�es';
hAideValide = '(validez avec Entr�e)';
hTriVariab= 'selon la variable s�lectionn�e';
hSupprCalc= 'les variables calcul�es sont supprim�es';
hSupprLigne = 'en supprimant la ligne du m�mo expression';
hTriPageDlg = 'tri des pages';
hTriParam= 'selon le param�tre s�lectionn�';
hTriPhase= 'rend continue la variable s�lectionn�e';
hMod2Pi= 'en effectuant un modulo 360�';
hTopSigmoide = 'Ordonn�e=plateau sup.';
hBottomSigmoide = 'Ordonn�e=plateau inf.';
hMidSigmoide = 'Point d''inflexion de la sigmo�de';
hPenteSigmoide = ' Ecart entre les deux points = pente';
hZoomManuelDebloq = 'Echelle bloqu�e|Modification de l''�chelle ou d�blocage de celle-ci';
hZoomManuelBloq = 'Echelle manuelle|D�finition manuelle de l''�chelle et blocage de celle-ci';
hZoomAutoBloq = 'Echelle bloqu�e => retour � l''�chelle automatique';
hCopyExpressions = 'Copier expressions|Copier l''ensemble du texte dans le presse-papiers';
hCopyGrid = 'Copier tableau|Copier le tableau dans le presse-papiers';
hTriData = 'Trier donn�es|Trier les donn�es selon la grandeur courante';
hDelta= 'Pr�cision|Affiche, si enfonc�, l''incertitude sur les ';
hTriPage = 'Trier page|Trier les pages selon un param�tre';
hAltTab = 'Utiliser Alt-Tab';
hGrid= '|Clic droit : menu local ; F2 : �dition d''une cellule'+crCRLF+
        'Double-clic dans l''en-t�te : modification unit�, incertitude';
hCurseurOrigine ='Placer le curseur sur la nouvelle origine';
hGainContinu ='ordonn�e : gain en continu';
hGainHF ='ordonn�e : gain � haute fr�quence';
hGainQ='ordonn�e : gain pour la fr�quence de coupure';
hSelectPageMod = 'Choix des pages prises en compte dans la mod�lisation';
hClicInsere = 'cliquer pour ins�rer';
hEchelleFreq = 'Cliquer-glisser les graduations pour changer l''�chelle';
hBasculeGTS = 'Pour basculer vers GTS utiliser Alt-Tab ou la barre des taches';
hLigneRappel='Ligne de rappel|Style de trait des lignes de rappel';
hTraitTangente='Tangente|Style de trait des tangentes';

   TitreBmp= 'Lecture de bitmap';
   hDeplacerPoint = '|D�placer le point';
   hRepererPoint= '|Cliquer pour enregistrer le point';
   hOrigineClick= 'Origine|Cliquer sur l''origine des axes';
   hCibleAuto = 'Cible|Cliquer sur la cible � suivre';
   trCible2Auto = 'Cliquer sur la deuxi�me cible � suivre';
   trCibleAuto = 'Cliquer sur la cible � suivre';
   trOrigineAuto = 'Cliquer sur l''origine � suivre';
   NoZoom = 'Taille r�elle';
   hTransfertRegressi = 'Transf�rer vers Regressi';
   hRepereBmp = 'Cliquer sur les points � rep�rer';
   hSerie2Bmp = 'Deuxi�me s�rie de points';

   stAcquisitionAvi = 'Acquisition � partir de video';
   erDuree = 'Dur�e incorrecte';
   erTronque = ' (trop long donc tronqu�)';
   Captionffmpeg = 'Lecture de fichier video par ffmpeg';

   hGlisserEchelle = '|Glisser jusqu''� la fin de l''�chelle';
   hMesureAviN = '|Cliquer sur le %di�me point de l''image n� %d';
   hMesureAvi1N = '|Cliquer sur le premier point de l''image n� %d';
   hMesureAvi1 = '|Cliquer sur le point � rep�rer (image n� %d)';
   hStartRecord = 'Enregistre|D�but de l''enregistrement';
   hStopRecord = 'Stop|Fin de l''enregistrement';
   hClicDroitAvi = 'Clic droit pour choix du curseur';
   hChronoEnCours = 'Patientez';
   hParamBtn = 'Cliquer sur le bouton Param�tres pour configurer';
   hOrigineI = '|Cliquer sur l''origine du point n�';
   hOrigineMobile = '|Il faudra indiquer l''origine avant chaque point';
   hOrigineMouse = '|Indique l''origine � l''aide de la souris';
   hStopMes = '|Arr�t des mesures';
   hStartMes = '|Commencer les mesures';
   hStopChrono = '|Arr�t de la Chronophotographie';
   hChrono = 'R�aliser une chronophotographie|La cible doit �tre constrast�e et les poistions successives distantes de moins d''un dixi�me de la taille de la video.';
   hOrigine1 = 'Origine du point n�1';
   hOrigineT = 'cliquer sur le point origine des temps';
   hClicPoint = 'cliquer sur le point � enregistrer';
   trEchelle= 'Echelle';
   trLmetre= 'Longueur en m�tre ?';

   hOrigineMove = 'D�placer l''origine';
   hNoZoom= 'Taille r�elle';
   hSupprPoint = '|Suppression du point';
   hReglerZoom = 'D�placer le rectangle de visualisation'+crCRLF+
                 'Taille r�glable par barre en bas � gauche.';
   hDebutX= 'D�but X|Cliquer sur le d�but de l''�chelle horizontale de ';
   hFinX= 'Fin X|Cliquer sur la fin de l''�chelle horizontale de ';
   hDebutY  = 'D�but Y|Cliquer sur le d�but de l''�chelle verticale de ';
   hFinY= 'Fin Y|Cliquer sur la fin de l''�chelle verticale de ';
   hDebutEchelle  = 'D�placer le d�but de l''�chelle';
   hFinEchelle  = 'D�placer la fin de l''�chelle';
   hMesureAviAngle1 = '|Cliquer sur la direction de r�f�rence (image n� %d)';
   hMesureAviAngle2 = '|Cliquer sur l''origine de l''angle (image n� %d)';
   hMesureAviAngle3 = '|Cliquer sur la direction � rep�rer (image n� %d)';

   trDimPixel= 'Dimension d''un pixel';
   trLongEchelle = 'Longueur de l''�chelle';
   trOrigineEchelle = 'Origine de l''�chelle';
   trDistance= 'distance=';

   erPointsProches = 'Points trop proches';
   erBass = 'Bass.dll non trouv�';

   erUnMobileAuto= 'Un seul mobile possible en mode automatique';
   trOrigineTemps= 'L''image courante sera l''origine des temps';
   trOrigineAxe= 'Cliquer sur le point � l''origine des axes';
   trAideEchelle= 'Cliquer sur le premier point puis sur le deuxi�me de l''�chelle';
   trAideAngle= 'Trois points par image'+crCRLF+
                 'point sur la base, sommet de l''angle, point final (dans cet ordre)';

   CaptionWav= 'Regressi : lecture de fichier son';
   erFormatWav= 'Format du fichier WAV non reconnu';
   erLectureWav= 'Probl�me de lecture du fichier .wav';
   erOuvertureWav= 'Probl�me d''ouverture du fichier .wav';
   TrDuree= 'Dur�e=';
   TrFrequence= 'Fech=';
   TrFreqEch= 'Fech=';
   TrFreqEchReg= 'FeReg=';
   TrDureeMax='Sous �chantillonnage si la dur�e exc�de ';

implementation

end.

