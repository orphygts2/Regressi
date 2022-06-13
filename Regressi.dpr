program Regressi;


uses
  Forms,
  oneinst in 'oneinst.pas',
  constreg in 'constreg.pas',
  maths in 'maths.pas',
  regutil in 'regutil.pas',
  uniteker in 'uniteker.pas',
  fft in 'fft.pas',
  statcalc in 'statcalc.pas',
  systdiff in 'systdiff.pas',
  regmain in 'regmain.pas' {FRegressiMain},
  optcolordlg in 'optcolordlg.pas' {OptionCouleurDlg},
  optfft in 'optfft.pas' {OptionsFFTDlg},
  supprdlg in 'supprdlg.pas' {SuppressionDlg},
  lecttext in 'lecttext.pas' {LectureTexteDlg},
  optline in 'optline.pas' {OptionLigneDlg},
  zoomman in 'zoomman.pas' {ZoomManuelDlg},
  newvar in 'newvar.pas' {NewVarDlg},
  graphker in 'graphker.pas',
  statisti in 'statisti.pas' {Fstatistique},
  filerrr in 'filerrr.pas',
  curmodel in 'curmodel.pas' {CurseurModeleDlg},
  options in 'options.pas' {OptionsDlg},
  modelegr in 'modelegr.pas',
  choixtang in 'choixtang.pas' {ChoixTangenteDlg},
  graphpar in 'graphpar.pas' {fgrapheParam},
  graphvar in 'graphvar.pas' {FgrapheVariab},
  cursdata in 'cursdata.pas' {ReticuleDataDlg},
  pagecopy in 'pagecopy.pas' {PageCopyDlg},
  selpage in 'selpage.pas' {SelectPageDlg},
  pagecalc in 'pagecalc.pas' {PageCalcDlg},
  varkeyb in 'varkeyb.pas' {NewClavierDlg},
  regprint in 'regprint.pas' {PrintDlg},
  identPagesU in 'identPagesU.pas' {ChoixIdentPagesDlg},
  statopt in 'statopt.pas' {StatOptDlg},
  modif in 'modif.pas' {ModifDlg},
  valeurs in 'valeurs.pas' {FValeurs},
  choixmodeleGlb in 'choixmodeleGlb.pas' {ChoixModeleGlbDlg},
  choixparamanim in 'choixparamanim.pas' {AnimParamDlg},
  coordphys in 'coordphys.pas' {FcoordonneesPhys},
  affectenom in 'affectenom.pas' {AffecteNomDlg},
  saveparam in 'saveparam.pas' {SaveParamDlg},
  optionsvitesse in 'optionsvitesse.pas' {OptionsVitesseDlg},
  regdde in 'regdde.pas' {FormDDE},
  selparam in 'selparam.pas' {selParamDlg},
  origineu in 'origineu.pas' {OrigineDlg},
  cornish in 'cornish.pas' {Fcornish},
  cornopt in 'cornopt.pas' {CornishOptDlg},
  choixmodele in 'choixmodele.pas' {ChoixModeleDlg},
  optModele in 'optModele.pas' {OptionModeleDlg},
  compile in 'compile.pas',
  addPageExp in 'addPageExp.pas' {AddPageExpDlg},
  ZoomManuelFFT in 'ZoomManuelFFT.pas' {ZoomManuelFFTdlg},
  indicateurU in 'indicateurU.pas' {indicateurDlg},
  saveHarm in 'saveHarm.pas' {SaveHarmoniqueDlg},
  constante in 'constante.pas' {ConstanteUnivDlg},
  savePosition in 'savePosition.pas' {SavePositionDlg},
  PropCourbe in 'PropCourbe.pas' {PropCourbeForm},
  about in 'about.pas' {AboutBox},
  graphfft in 'graphfft.pas' {FGrapheFFT},
  Latex in 'Latex.pas',
  latexreg in 'latexreg.pas' {LatexDlg},
  aidekey in 'aidekey.pas',
  OptionsAffModeleU in 'OptionsAffModeleU.pas' {OptionsAffModeleDlg},
  grapheu in 'Images\grapheu.pas',
  FusionU in 'FusionU.pas' {FusionDlg},
  selColonne in 'selColonne.pas' {SelectColonneDlg},
  pageechant in 'pageechant.pas' {PageEchantillonDlg},
  savemodele in 'savemodele.pas' {SaveModeleDlg},
  graph3D in 'graph3D.pas' {fgraphe3D},
  coord3D in 'coord3D.pas' {Fcoordonnees3D},
  pagedistrib in 'pagedistrib.pas' {PageDistribDlg},
  coordEuler in 'coordEuler.pas' {FcoordonneesEuler},
  graphEuler in 'graphEuler.pas' {FgrapheEuler},
  mathml_Presentation in 'mathml_Presentation.pas',
  hdf5dll in 'hdf5dll.pas',
  modeleNum in 'modeleNum.pas',
  RollingShutterCalc in 'Images\RollingShutterCalc.pas',
  EphemerU in 'EphemerU.pas' {EphemerForm},
  filerw3U in 'filerw3U.pas',
  arduinoGraphe in 'arduino\arduinoGraphe.pas',
  FormBaseU in 'FormBaseU.pas' {FormBase},
  arduinoOscillo in 'arduinoOscillo.pas' {ArduinoOscilloForm},
  ArduinoOscilloCfg in 'ArduinoOscilloCfg.pas' {ArduinoOscilloDlg},
  arduinoU in 'arduinoU.pas' {ArduinoForm},
  arduinoWifi in 'arduinoWifi.pas' {ArduinoWifiForm},
  ArduinoWifiCfg in 'ArduinoWifiCfg.pas' {ArduinoWifiDlg},
  arduinoWifiDirect in 'arduinoWifiDirect.pas' {ArduinoWifiDirectForm},
  ChronoBitmap in 'ChronoBitmap.pas' {ChronoForm},
  ChronoEch in 'ChronoEch.pas' {EchelleMecaBmpDlg},
  ChronoU in 'ChronoU.pas' {VideoChronoForm},
  courbesEch in 'courbesEch.pas' {EchelleBmpDlg},
  CourbesU in 'CourbesU.pas' {CourbesForm},
  interfMain in 'interfMain.pas' {OptiqueForm},
  loupeU in 'loupeU.pas' {LoupeForm},
  RollingShutterU in 'RollingShutterU.pas' {RollingShutterForm},
  TestInWav in 'TestInWav.pas' {TestWavDlg},
  WavMain in 'WavMain.pas' {WaveForm},
  Videoffmpeg in 'Videoffmpeg.pas' {ffmpegForm},
  captureCamera in 'captureCamera.pas' {VideoForm};

{$R *.RES}

begin
  Application.Title := 'Regressi';
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFRegressiMain, FRegressiMain);
  Application.CreateForm(TOptionsDlg, OptionsDlg);
  Application.CreateForm(TFormDDE, FormDDE);
  Application.CreateForm(TChoixModeleDlg, ChoixModeleDlg);
  Application.CreateForm(TindicateurDlg, indicateurDlg);
  Application.CreateForm(TConstanteUnivDlg, ConstanteUnivDlg);
  Application.CreateForm(TFcoordonneesPhys, FcoordonneesPhys);
  Application.CreateForm(TArduinoOscilloForm, ArduinoOscilloForm);
  Application.CreateForm(TArduinoOscilloDlg, ArduinoOscilloDlg);
  Application.CreateForm(TArduinoForm, ArduinoForm);
  Application.CreateForm(TArduinoWifiForm, ArduinoWifiForm);
  Application.CreateForm(TArduinoWifiDlg, ArduinoWifiDlg);
  Application.CreateForm(TArduinoWifiDirectForm, ArduinoWifiDirectForm);
  Application.CreateForm(TChronoForm, ChronoForm);
  Application.CreateForm(TEchelleMecaBmpDlg, EchelleMecaBmpDlg);
  Application.CreateForm(TVideoChronoForm, VideoChronoForm);
  Application.CreateForm(TEchelleBmpDlg, EchelleBmpDlg);
  Application.CreateForm(TCourbesForm, CourbesForm);
  Application.CreateForm(TOptiqueForm, OptiqueForm);
  Application.CreateForm(TLoupeForm, LoupeForm);
  Application.CreateForm(TRollingShutterForm, RollingShutterForm);
  Application.CreateForm(TTestWavDlg, TestWavDlg);
  Application.CreateForm(TWaveForm, WaveForm);
  Application.CreateForm(TffmpegForm, ffmpegForm);
  Application.CreateForm(TVideoForm, VideoForm);
  Application.Run;
end.
