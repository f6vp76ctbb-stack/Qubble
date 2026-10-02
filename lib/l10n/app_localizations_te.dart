// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class L10nTe extends L10n {
  L10nTe([String locale = 'te']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'ఆడు';

  @override
  String get commonLater => 'తర్వాత';

  @override
  String get commonNotNow => 'ఇప్పుడు వద్దు';

  @override
  String get commonCancel => 'రద్దు చేయి';

  @override
  String get commonBuy => 'కొను';

  @override
  String get commonSave => 'సేవ్ చేయి';

  @override
  String get commonCollect => 'తీసుకో';

  @override
  String get nameNewName => 'కొత్త పేరు';

  @override
  String get nameFieldLabel => 'పేరు';

  @override
  String get piggyFullTitle => 'హుండీ నిండింది!';

  @override
  String get piggyKeepSaving => 'పొదుపు కొనసాగించండి';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$coins / $capacity సేకరించబడ్డాయి.';
  }

  @override
  String get homeContinueRun => 'కొనసాగించు';

  @override
  String get homeVideo => 'వీడియో';

  @override
  String get commonGotIt => 'సరే';

  @override
  String get commonHome => 'హోమ్';

  @override
  String get commonScore => 'స్కోరు';

  @override
  String get commonBest => 'అత్యుత్తమం';

  @override
  String commonLevelShort(int level) {
    return 'స్థాయి $level';
  }

  @override
  String get homeNewRun => 'కొత్త ఆట ప్రారంభించు';

  @override
  String get homeBackToExit => 'బయటకు వెళ్లడానికి మళ్లీ వెనుకకు నొక్కండి';

  @override
  String get homeEnableLeaderboard => 'లీడర్‌బోర్డ్‌లో చేరండి';

  @override
  String get homeBestScore => 'అత్యుత్తమ స్కోరు';

  @override
  String get homeDailyChallenge => 'రోజువారీ సవాలు';

  @override
  String get homeDailyOpenToday => 'ఈరోజు తెరిచి ఉంది';

  @override
  String homeDailyNextIn(String time) {
    return 'తదుపరి సవాలు: $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '$streak రోజుల వరుస',
      one: '$streak రోజు వరుస',
    );
    return '$_temp0';
  }

  @override
  String get homeLeaderboard => 'లీడర్‌బోర్డ్';

  @override
  String get homePuzzleMode => 'పజిల్ మోడ్';

  @override
  String get homeHowToPlay => 'Qubble ఎలా ఆడాలి';

  @override
  String get homeWeekendBonus => 'వారాంతం: రెట్టింపు నాణేలు!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'స్థాయి $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'పేరు మార్చు';

  @override
  String get nameChangeExplainer =>
      'మీ పేరే లీడర్‌బోర్డ్‌లో మీ గుర్తింపు, అందుకే అది స్థిరంగా ఉంటుంది. ఒకసారి పేరు మార్పును కొనవచ్చు.';

  @override
  String get nameChangeAfterPurchase =>
      'కొన్న తర్వాత, మార్చడానికి మీ పేరును మళ్లీ నొక్కండి.';

  @override
  String get nameJoinedLeaderboard => 'ఇప్పుడు మీరు లీడర్‌బోర్డ్‌లో ఉన్నారు.';

  @override
  String nameProblemTooShort(int min) {
    return 'కనీస అక్షరాలు: $min.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'గరిష్ఠ అక్షరాలు: $max.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'లాటిన్ అక్షరాలు (ఉదా. A–Z, é), అంకెలు, ఖాళీలు, _ మరియు - మాత్రమే.';

  @override
  String get nameProblemOffensive => 'దయచేసి వేరే పేరు ఎంచుకోండి.';

  @override
  String get piggyTitle => 'హుండీ';

  @override
  String get piggyFillingHint =>
      'మీరు వరుసలను క్లియర్ చేస్తున్నప్పుడు మీ హుండీ నిండుతుంది.';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins నాణేలను ఉచితంగా తీసుకోండి.',
      one: '$coins నాణేన్ని ఉచితంగా తీసుకోండి.',
    );
    return '$_temp0';
  }

  @override
  String get piggyEarlyOpenHint =>
      'నిండిన తర్వాత ఉచితంగా ఖాళీ చేయవచ్చు — లేదా బోనస్ వీడియోతో ముందే తెరవవచ్చు.';

  @override
  String get piggyOpenNow => 'ఇప్పుడే తెరువు';

  @override
  String get gameNewPiecesVideo => 'కొత్త ముక్కలు (వీడియో)';

  @override
  String get gameTapBoardCell => 'బోర్డులో ఒక గడిని నొక్కండి';

  @override
  String get gameDailyChallengeLabel => 'రోజువారీ సవాలు';

  @override
  String get gameOver => 'ఆట ముగిసింది';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'బాంబుకు కావాల్సిన అదనపు నాణేలు: $missing.';
  }

  @override
  String get gameBombNotHere => 'బాంబు ఇప్పుడు ఇక్కడ పనిచేయదు.';

  @override
  String gameNeedsCoins(String missing) {
    return 'దీనికి కావాల్సిన అదనపు నాణేలు: $missing.';
  }

  @override
  String get gameNotRightNow => 'ఇప్పుడు సాధ్యం కాదు.';

  @override
  String get gameRunSaved => 'ఆట సేవ్ అయింది — మెనూలో \"కొనసాగించు\".';

  @override
  String get gameOverNoFit => 'మీ ముక్కలు ఏవీ ఇక బోర్డులో సరిపోవు.';

  @override
  String get gameOverNoFitNoRotations =>
      'ఏ ముక్కా సరిపోదు — తిప్పే అవకాశాలూ అయిపోయాయి.';

  @override
  String get gameStarterOfferUnavailable => 'ఇప్పుడు అందుబాటులో లేదు';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — పొందండి';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'కాంబో x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'విజయం: $title';
  }

  @override
  String get gameBestSubmitted => 'కొత్త అత్యుత్తమం — పంపబడింది';

  @override
  String get gameReviveFor => 'ఆడటం కొనసాగించు · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'అన్‌లాక్ అయింది: $name';
  }

  @override
  String get gameStarterOfferTitle => 'స్టార్టర్ ప్యాక్';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score పాయింట్లు',
      one: '$score పాయింట్',
    );
    return '$_temp0';
  }

  @override
  String get gameNewRecord => 'కొత్త రికార్డు!';

  @override
  String gameStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '$streak రోజుల వరుస',
      one: '$streak రోజు వరుస',
    );
    return '$_temp0';
  }

  @override
  String get gameDoubleCoins => 'నాణేలను రెట్టింపు చేయి';

  @override
  String get gameDoubleDaily => 'రోజువారీ బహుమతిని రెట్టింపు చేయి';

  @override
  String get gamePlayAgain => 'మళ్లీ ఆడు';

  @override
  String gameLevelReached(int level) {
    return 'స్థాయి $level చేరుకున్నారు!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '+$count స్థాయిలు — స్థాయి $level!',
      one: '+$count స్థాయి — స్థాయి $level!',
    );
    return '$_temp0';
  }

  @override
  String get gameStarterOfferReward => '1200 నాణేలు + చెక్క థీమ్';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours గంటలు మాత్రమే మిగిలాయి — ఒక్కసారే!',
      one: '$hours గంట మాత్రమే మిగిలింది — ఒక్కసారే!',
    );
    return '$_temp0';
  }

  @override
  String get boosterUndo => 'వెనక్కి';

  @override
  String get boosterSwap => 'మార్చు';

  @override
  String get boosterBomb => 'బాంబు';

  @override
  String get boosterNoRotationsLeft =>
      'తిప్పే అవకాశాలు లేవు — మళ్లీ పొందడానికి వరుసలను క్లియర్ చేయండి!';

  @override
  String get onboardingDragPiece => 'ఒక బ్లాక్‌ను గ్రిడ్‌పైకి లాగండి';

  @override
  String get onboardingFillLine => 'పూర్తి వరుస లేదా నిలువు వరుసను నింపండి';

  @override
  String get onboardingLinesClear => 'నిండిన లైన్లు మాయమవుతాయి — పాయింట్లు!';

  @override
  String get coachHintCombo =>
      'కాంబో! దాన్ని నిలుపుకోవడానికి 3 కదలికల్లో మళ్లీ క్లియర్ చేయండి';

  @override
  String get coachHintFever => 'ఫీవర్! మెరుస్తున్నంత వరకు రెట్టింపు పాయింట్లు';

  @override
  String get coachHintRotation =>
      'తిప్పడానికి ఒక ఛార్జ్ ఖర్చవుతుంది — క్లియర్ చేస్తే అది నిండుతుంది';

  @override
  String get coachHintBooster => 'చిట్కా: కింద బూస్టర్లను వాడవచ్చు';

  @override
  String get coachHintStrategy =>
      'చిట్కా: అన్ని లైన్లనూ ఒకేసారి కాదు — పెద్ద ముక్కలకు చోటు ఉంచండి';

  @override
  String get dailyStreakLabel => 'వరుస';

  @override
  String get dailyBestLabel => 'రోజువారీ అత్యుత్తమం';

  @override
  String dailyHistoryNote(int days) {
    return 'చివరి $days రోజులు భద్రపరచబడతాయి.';
  }

  @override
  String dailyDayPlayed(int day) {
    return 'రోజు $day: ఆడారు';
  }

  @override
  String dailyDayMissed(int day) {
    return 'రోజు $day: ఆడలేదు';
  }

  @override
  String get homeDailyCalendar => 'క్యాలెండర్';

  @override
  String get dailyShareButton => 'ఫలితాన్ని పంచుకోండి';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · రోజువారీ సవాలు $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'పాయింట్లు: $score · ఉత్తమ కాంబో x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'ఆడండి: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'కాంబో: ఇంకా $moves కదలికలు',
      one: 'కాంబో: ఇంకా $moves కదలిక',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'ఫలితం క్లిప్‌బోర్డ్‌కు కాపీ అయింది';

  @override
  String get adNotAvailable =>
      'ఇప్పుడు వీడియో అందుబాటులో లేదు — కాసేపటి తర్వాత మళ్లీ ప్రయత్నించండి';

  @override
  String get howToPlaySpeedTitle => 'వేగ బోనస్';

  @override
  String get howToPlaySpeedBody =>
      'వేగంగా ఉంచడం ప్రతి క్లియర్‌కు 30 % వరకు జోడిస్తుంది. బోనస్ 1.5 నుంచి 4 సెకన్ల మధ్య తగ్గుతుంది, దానికి పరిమితి ఉంది; కాబట్టి వేగం ఫలితాన్నిస్తుంది కానీ ఆటను నిర్ణయించదు — జాగ్రత్తగా నెమ్మదిగా ఆడిన ఆట తొందరపాటు ఆటను ఇంకా ఓడించగలదు.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'వేగ బోనస్ $percent శాతం';
  }

  @override
  String get iapDiamondsSmall => '100 వజ్రాలు';

  @override
  String get iapDiamondsMedium => '350 వజ్రాలు';

  @override
  String get iapDiamondsLarge => '1,000 వజ్రాలు';

  @override
  String get howToPlayTitle => 'Qubble ఎలా ఆడాలి';

  @override
  String get howToPlayIntroHeadline =>
      'ప్రారంభించడం సులభం.\nముందుచూపుకు ప్రతిఫలం.';

  @override
  String get howToPlayIntroBody =>
      'బోర్డును ఖాళీగా ఉంచి మీ రికార్డును బద్దలు కొట్టండి.';

  @override
  String get howToPlayIntroSemantics =>
      'ఆట లక్ష్యం. బోర్డును ఖాళీగా ఉంచి మీ రికార్డును బద్దలు కొట్టండి.';

  @override
  String get howToPlayDragTitle => 'లాగి ఉంచండి';

  @override
  String get howToPlayDragBody =>
      'మూడు ముక్కల్లో ఒకదాన్ని ఖాళీ గడులపైకి లాగండి. మూడూ వాడిన తర్వాత, ఆటోమేటిక్‌గా మూడు కొత్తవి వస్తాయి.';

  @override
  String get howToPlayClearTitle => 'లైన్లను క్లియర్ చేయండి';

  @override
  String get howToPlayClearBody =>
      'పూర్తి వరుస లేదా నిలువు వరుసను నింపండి. నిండిన లైన్లు మాయమై తదుపరి కదలికకు చోటిస్తాయి.';

  @override
  String get howToPlayComboTitle => 'కాంబోలను జత చేయండి';

  @override
  String get howToPlayComboBody =>
      'మూడు కదలికల్లో మరో లైన్‌ను క్లియర్ చేయండి. ప్రతి అదనపు కాంబో మీ పాయింట్ గుణకాన్ని పెంచుతుంది. కాంబో సెకన్లను కాదు, కదలికలను లెక్కిస్తుంది; కాబట్టి మీరు ఆలోచిస్తున్నప్పుడు అది ముగిసిపోదు.';

  @override
  String get howToPlayFeverTitle => 'ఫీవర్‌ను రగిలించండి';

  @override
  String get howToPlayFeverBody =>
      'క్లియర్‌లు ఫీవర్ మీటర్‌ను నింపుతాయి. అది నిండగానే, తదుపరి పేలుడు రెట్టింపుగా లెక్కించబడుతుంది — పెద్ద క్లియర్‌లను ముందే ప్లాన్ చేయండి.';

  @override
  String get howToPlayBoosterTitle => 'బూస్టర్లను తెలివిగా వాడండి';

  @override
  String get howToPlayBoosterBody =>
      'బూస్టర్లు కష్టమైన ఆటలను కాపాడతాయి. కింద ఉన్న ముక్కను నొక్కి దాన్ని తిప్పవచ్చు కూడా.';

  @override
  String get howToPlayDailyTitle => 'రోజువారీ సవాలు & వరుస';

  @override
  String get howToPlayDailyBody =>
      'రోజువారీ సవాలులో అందరికీ ఒకే ముక్కలు. మీ వరుసను, బోనస్‌ను పెంచుకోవడానికి ప్రతిరోజూ ఆడండి.';

  @override
  String get howToPlayPiggyTitle => 'హుండీని నింపండి';

  @override
  String get howToPlayPiggyBody =>
      'క్లియర్ అయిన ప్రతి లైన్ మీ హుండీని నింపుతుంది. అది నిండగానే, నాణేలను ఉచితంగా తీసుకోవచ్చు.';

  @override
  String get leaderboardTitle => 'లీడర్‌బోర్డ్';

  @override
  String get leaderboardUnreachable =>
      'లీడర్‌బోర్డ్ అందుబాటులో లేదు.\nఇంటర్నెట్ కనెక్షన్‌తో మళ్లీ ప్రయత్నించండి.';

  @override
  String get leaderboardEmpty => 'ఇంకా ఎంట్రీలు లేవు.\nమొదటివారు మీరే అవ్వండి!';

  @override
  String leaderboardSubmitting(int score) {
    return 'మీ అత్యుత్తమ స్కోరు ($score) పంపబడుతోంది …';
  }

  @override
  String get leaderboardAutoSubmit =>
      'మీ అత్యుత్తమ స్కోరు ఆటోమేటిక్‌గా పంపబడుతుంది.';

  @override
  String get puzzleModeTitle => 'పజిల్ మోడ్';

  @override
  String puzzleLevelTitle(int level) {
    return 'పజిల్ $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'కదలికలు: $moves   •   లక్ష్యం: 3 నక్షత్రాలకు $target';
  }

  @override
  String get puzzleSolved => 'పరిష్కారమైంది!';

  @override
  String get puzzleLeaveTitle => 'పజిల్ నుంచి బయటకు వెళ్లాలా?';

  @override
  String get puzzleLeaveBody => 'ఈ పజిల్‌లో మీ ప్రగతి పోతుంది.';

  @override
  String get puzzleKeepPlaying => 'ఆడటం కొనసాగించు';

  @override
  String get puzzleLeave => 'బయటకు వెళ్లు';

  @override
  String get puzzleStuckTitle => 'చిక్కుకుపోయారు';

  @override
  String get puzzleRestart => 'మళ్లీ ప్రారంభించు';

  @override
  String get commonActive => 'యాక్టివ్';

  @override
  String get commonRestore => 'పునరుద్ధరించు';

  @override
  String get skinsExchangeGold => 'బంగారాన్ని మార్చు';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'ముక్కను తిప్పు';

  @override
  String get puzzleNextLevel => 'తదుపరి స్థాయి';

  @override
  String get puzzleBackToOverview => 'జాబితాకు తిరిగి';

  @override
  String get puzzleUnsolvable => 'ఇక్కడి నుంచి బోర్డును ఇక ఖాళీ చేయలేరు.';

  @override
  String get puzzleExtraMoveVideo => 'అదనపు కదలిక (వీడియో)';

  @override
  String puzzleSolvedCount(int solved) {
    return 'పరిష్కరించినవి: $solved';
  }

  @override
  String get settingsTitle => 'సెట్టింగ్‌లు';

  @override
  String get storageFailureTitle =>
      'Qubble మీ సేవ్ చేసిన ఆటను లోడ్ చేయలేకపోయింది';

  @override
  String get storageFailureBody =>
      'దయచేసి యాప్‌ను రీస్టార్ట్ చేయండి. లోపం కొనసాగితే, మళ్లీ ఇన్‌స్టాల్ చేయడమే మార్గం. సెట్టింగ్‌లు › అభిప్రాయం ద్వారా దీన్ని తెలియజేయవచ్చు.';

  @override
  String get iapUnavailable => 'ఈ ఆఫర్ ఇప్పుడు అందుబాటులో లేదు.';

  @override
  String get iapFailed => 'కొనుగోలు పూర్తి కాలేదు. ఏమీ వసూలు చేయలేదు.';

  @override
  String get settingsResetProgress => 'ప్రగతిని రీసెట్ చేయి';

  @override
  String get settingsResetProgressSubtitle =>
      'స్కోరు, నాణేలు, స్థాయి, ప్రగతి మొదటికి వస్తాయి. కొనుగోళ్లు, పేరు, అలంకరణలు ఉంటాయి.';

  @override
  String get settingsResetConfirmTitle => 'ప్రగతిని రీసెట్ చేయాలా?';

  @override
  String get settingsResetConfirmBody =>
      'అత్యుత్తమ స్కోరు, నాణేలు, స్థాయి, వరుస, మొత్తం ప్రగతి తొలగించబడతాయి. దీన్ని వెనక్కి తీసుకోలేరు.\n\nమీ కొనుగోళ్లు, మీ పేరు, అన్‌లాక్ చేసిన థీమ్‌లు, స్కిన్‌లు ఉంటాయి.';

  @override
  String get settingsResetConfirmAction => 'రీసెట్';

  @override
  String get settingsResetDone => 'ప్రగతి రీసెట్ అయింది.';

  @override
  String get settingsSectionGame => 'ఆట';

  @override
  String get settingsSectionSoundHaptics => 'శబ్దం & వైబ్రేషన్';

  @override
  String get settingsSectionReminders => 'రిమైండర్‌లు';

  @override
  String get settingsSectionPurchases => 'కొనుగోళ్లు';

  @override
  String get settingsSectionHelpOut => 'సహాయం చేయండి';

  @override
  String get settingsSectionLegal => 'చట్టపరమైన';

  @override
  String get settingsSectionLanguage => 'భాష';

  @override
  String get settingsGuide => 'ఎలా ఆడాలి';

  @override
  String get settingsGuideSubtitle => 'నియమాలు, కాంబోలు, ఫీవర్ & బూస్టర్లు';

  @override
  String get settingsSound => 'శబ్దం';

  @override
  String get settingsMusic => 'సంగీతం';

  @override
  String get settingsHaptics => 'వైబ్రేషన్';

  @override
  String get settingsHapticsOff => 'ఆఫ్';

  @override
  String get settingsHapticsLight => 'తేలిక';

  @override
  String get settingsHapticsStrong => 'బలంగా';

  @override
  String get settingsSectionAccessibility => 'సౌకర్యం';

  @override
  String get settingsReducedEffects => 'తక్కువ ఎఫెక్ట్‌లు';

  @override
  String get settingsReducedEffectsHint =>
      'తక్కువ కణాలు, స్క్రీన్ కదలిక లేదు, మెరుపు లేదు';

  @override
  String get settingsNotifications => 'నోటిఫికేషన్‌లు';

  @override
  String get settingsNotificationsSubtitle => 'రోజువారీ రిమైండర్ & వరుస రక్షణ';

  @override
  String get settingsNotificationsSystemHint =>
      'సిస్టమ్ సెట్టింగ్‌లలో అనుమతించండి.';

  @override
  String get settingsLanguageSystem => 'సిస్టమ్ భాష';

  @override
  String get settingsSupporterThanks => 'మద్దతుదారు — ధన్యవాదాలు!';

  @override
  String get settingsSupporterPack => 'మద్దతుదారు ప్యాక్';

  @override
  String get settingsSupporterPackSubtitle =>
      'ప్రత్యేక థీమ్ & స్కిన్ + 1,500 నాణేలు';

  @override
  String get settingsRestorePurchases => 'కొనుగోళ్లను పునరుద్ధరించు';

  @override
  String get settingsRestoring => 'కొనుగోళ్లు పునరుద్ధరించబడుతున్నాయి…';

  @override
  String get settingsRateApp => 'యాప్‌కు రేటింగ్ ఇవ్వండి';

  @override
  String get settingsRateAppSubtitle => 'స్టోర్‌లో రేటింగ్ ఇవ్వండి';

  @override
  String get settingsStoreUnavailable => 'ఈ పరికరంలో స్టోర్ అందుబాటులో లేదు.';

  @override
  String get settingsFeedback => 'అభిప్రాయం పంపండి';

  @override
  String get settingsFeedbackSubtitle => 'ఆలోచనలు & లోపాలు (GitHub ద్వారా)';

  @override
  String get settingsAdPrivacy => 'ప్రకటనల గోప్యత';

  @override
  String get settingsAdPrivacySubtitle =>
      'మీ ప్రకటన సమ్మతిని చూడండి లేదా మార్చండి';

  @override
  String get settingsAdPrivacyUnavailable =>
      'ఈ పరికరంలో ప్రకటన ఎంపికలు అవసరం లేదు.';

  @override
  String get settingsPrivacy => 'గోప్యతా విధానం';

  @override
  String get settingsImprint => 'చట్టపరమైన సమాచారం';

  @override
  String get settingsPageOpenFailed => 'పేజీని తెరవలేకపోయాం.';

  @override
  String get settingsFooter => 'Qubble • ఆఫ్‌లైన్ బ్లాక్ పజిల్';

  @override
  String get settingsAdminSection => 'అడ్మిన్ (పరీక్ష)';

  @override
  String get settingsAdminEnabled => 'అడ్మిన్ మోడ్ ఆన్ అయింది';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'అడ్మిన్ మోడ్ కోసం మరో $count సార్లు నొక్కండి';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins నాణేలు',
      one: '$coins నాణెం',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'పరీక్షకు మాత్రమే — విడుదల స్క్రీన్‌షాట్‌లలో ఎప్పుడూ కాదు';

  @override
  String settingsAdminAddCoins(int amount) {
    String _temp0 = intl.Intl.pluralLogic(
      amount,
      locale: localeName,
      other: '$amount నాణేలు',
      one: '$amount నాణెం',
    );
    return '+$_temp0';
  }

  @override
  String get settingsAdminResetCoins => 'నాణేలను 0 చేయి';

  @override
  String get feedbackTitle => 'అభిప్రాయం';

  @override
  String get feedbackIntroShort =>
      'మీకు ఏది నచ్చింది, ఏది చికాకు పెడుతోంది, ఏం లేదు? చిన్న విషయాలూ సహాయపడతాయి — ఎంత స్పష్టంగా ఉంటే అంత మంచిది.';

  @override
  String feedbackAttachmentNote(String build) {
    return '$build, మీ పరికర రకం మాత్రమే జతచేయబడతాయి — మీరు ఏ వెర్షన్ గురించి చెబుతున్నారో నాకు తెలియడానికి.';
  }

  @override
  String get feedbackSendByMail => 'ఈమెయిల్ ద్వారా పంపండి';

  @override
  String get feedbackPreferGithub => 'GitHub issue ఇష్టపడతాను';

  @override
  String get feedbackThanksMail => 'ధన్యవాదాలు! సందేశాన్ని పంపితే చాలు.';

  @override
  String get feedbackNoMailApp =>
      'ఈమెయిల్ యాప్ కనబడలేదు. కింద ఉన్న GitHub మార్గాన్ని ప్రయత్నించండి.';

  @override
  String get feedbackEmptyHint => 'దయచేసి ముందు ఏదైనా రాయండి.';

  @override
  String get leaderboardRefresh => 'రిఫ్రెష్';

  @override
  String get leaderboardRetry => 'మళ్లీ ప్రయత్నించు';

  @override
  String get feedbackHint => 'మీ అభిప్రాయం…';

  @override
  String get feedbackSubmit => 'అభిప్రాయం పంపండి';

  @override
  String get feedbackOpenFailed =>
      'GitHubను తెరవలేకపోయాం. తర్వాత ప్రయత్నించండి.';

  @override
  String get feedbackGithubNote =>
      'GitHub తెరుచుకుంటుంది — అక్కడ \"Submit new issue\" నొక్కండి. (ఒకసారి GitHub లాగిన్ అవసరం.)';

  @override
  String get shopTitle => 'షాప్';

  @override
  String get shopWebDemoNote =>
      'కొనుగోళ్లు Play Store యాప్‌లో మాత్రమే అందుబాటులో ఉంటాయి. ఈ వెబ్ వెర్షన్ ఉచిత డెమో — అయినా ఇక్కడ మొత్తం ఆడవచ్చు.';

  @override
  String get shopSupporterExplainer =>
      'Qubble బలవంతపు ప్రకటనలు చూపదు — మీరు ఏదీ కొనాల్సిన అవసరం లేదు. మద్దతుదారు ప్యాక్ (అరోరా థీమ్, క్రిస్టల్ స్కిన్, 1,500 నాణేలు, మద్దతుదారు బ్యాడ్జ్) ఆటకు మద్దతిచ్చినందుకు కృతజ్ఞత. కొనుగోళ్లు మీ స్టోర్ ఖాతాకు లింక్ అయి ఉంటాయి, ఎప్పుడైనా పునరుద్ధరించవచ్చు.';

  @override
  String get shopSupporterContents =>
      'అరోరా థీమ్ + క్రిస్టల్ స్కిన్ + 1,500 నాణేలు';

  @override
  String get themesTitle => 'థీమ్‌లు';

  @override
  String get themesSupporterOnly =>
      'మద్దతుదారు ప్యాక్‌లో మాత్రమే (షాప్ చూడండి)';

  @override
  String get skinsTitle => 'బ్లాక్ స్కిన్‌లు';

  @override
  String get skinsNotEnoughCoins => 'తగినన్ని నాణేలు లేవు';

  @override
  String get skinsNotEnoughGold => 'తగినంత బంగారం లేదు.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold బంగారం = 1 వజ్రం. వజ్రాలు అత్యంత అందమైన స్కిన్‌లను అన్‌లాక్ చేస్తాయి — నెమ్మదిగా సేకరించండి.';
  }

  @override
  String get statsTitle => 'గణాంకాలు';

  @override
  String get statsAverageScore => 'సగటు స్కోరు';

  @override
  String get statsBestCombo => 'ఉత్తమ కాంబో';

  @override
  String get statsGames => 'ఆటలు';

  @override
  String get statsLinesCleared => 'క్లియర్ చేసిన వరుసలు';

  @override
  String get statsPiecesPlaced => 'ఉంచిన ముక్కలు';

  @override
  String get statsCoins => 'నాణేలు';

  @override
  String questCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'x$countString కాంబో సాధించండి';
  }

  @override
  String questScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ఒకే ఆటలో $countString పాయింట్లను దాటండి',
      one: 'ఒకే ఆటలో $countString పాయింట్‌ను దాటండి',
    );
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'విజయాలు';

  @override
  String get achievementFirstGameTitle => 'తొలి ఆట';

  @override
  String get achievementFirstGameBody => 'మీ తొలి ఆట ఆడండి';

  @override
  String get achievementGames25Title => 'రెగ్యులర్';

  @override
  String get achievementGames25Body => '25 ఆటలు ఆడండి';

  @override
  String get achievementGames100Title => 'అలవాటుపడ్డారు';

  @override
  String get achievementGames100Body => '100 ఆటలు ఆడండి';

  @override
  String get achievementScore1kTitle => 'అధిరోహకుడు';

  @override
  String get achievementScore1kBody => '1,000 పాయింట్లు చేరండి';

  @override
  String get achievementScore5kTitle => 'ప్రో';

  @override
  String get achievementScore5kBody => '5,000 పాయింట్లు చేరండి';

  @override
  String get achievementScore10kTitle => 'మాస్టర్';

  @override
  String get achievementScore10kBody => '10,000 పాయింట్లు చేరండి';

  @override
  String get achievementScore25kTitle => 'లెజెండ్';

  @override
  String get achievementScore25kBody => '25,000 పాయింట్లు చేరండి';

  @override
  String get achievementLines100Title => 'చక్కనివారు';

  @override
  String get achievementLines100Body => 'మొత్తం 100 వరుసలను క్లియర్ చేయండి';

  @override
  String get achievementLines1000Title => 'గొప్ప శుభ్రత';

  @override
  String get achievementLines1000Body => 'మొత్తం 1,000 వరుసలను క్లియర్ చేయండి';

  @override
  String get achievementCombo5Title => 'కాంబో ఆరంభం';

  @override
  String get achievementCombo5Body => 'x5 కాంబో సాధించండి';

  @override
  String get achievementCombo10Title => 'కాంబో రాజు';

  @override
  String get achievementCombo10Body => 'x10 కాంబో సాధించండి';

  @override
  String get achievementLevel10Title => 'అనుభవజ్ఞులు';

  @override
  String get achievementLevel10Body => 'స్థాయి 10 చేరండి';

  @override
  String get achievementLevel20Title => 'వెటరన్';

  @override
  String get achievementLevel20Body => 'స్థాయి 20 చేరండి';

  @override
  String get achievementStreak7Title => 'వారపు వరుస';

  @override
  String get achievementStreak7Body => '7 రోజుల రోజువారీ వరుస';

  @override
  String get achievementStreak30Title => 'నెల వరుస';

  @override
  String get achievementStreak30Body => '30 రోజుల రోజువారీ వరుస';

  @override
  String get achievementPuzzles10Title => 'పజిలర్';

  @override
  String get achievementPuzzles10Body => '10 పజిల్స్ పరిష్కరించండి';

  @override
  String get achievementPieces5000Title => 'నిర్మాత';

  @override
  String get achievementPieces5000Body => '5,000 ముక్కలను ఉంచండి';

  @override
  String streakRepairTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '$streak రోజుల వరుస ప్రమాదంలో ఉంది!',
      one: '$streak రోజు వరుస ప్రమాదంలో ఉంది!',
    );
    return '$_temp0';
  }

  @override
  String get streakRepairBody => 'నిన్న ఆడలేదు — మీ వరుసను కాపాడుకోండి:';

  @override
  String get streakRepairFailed => 'సరిచేయడం సాధ్యం కాదు.';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins నాణేలు',
      one: '$coins నాణెం',
    );
    return 'మళ్లీ స్వాగతం! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'రిమైండర్‌లు?';

  @override
  String get notificationsOptInBody =>
      'మీ రోజువారీ పజిల్‌ను గుర్తు చేసి, మీ వరుసను కాపాడమంటారా? దీన్ని ఎప్పుడైనా సెట్టింగ్‌లలో మార్చవచ్చు.';

  @override
  String get notificationsOptInAccept => 'అవును, దయచేసి';

  @override
  String get notificationChannelDescription =>
      'రోజువారీ రిమైండర్, వరుస హెచ్చరిక, తిరిగి రావడం';

  @override
  String get notificationDailyTitle => 'మీ రోజువారీ పజిల్ ఎదురుచూస్తోంది 🧩';

  @override
  String get notificationDailyBody => 'ఈరోజు సవాలును ఆడండి!';

  @override
  String notificationStreakTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: '$streak రోజుల వరుస ప్రమాదంలో ఉంది!',
      one: '$streak రోజు వరుస ప్రమాదంలో ఉంది!',
    );
    return '🔥 $_temp0';
  }

  @override
  String get notificationStreakBody => 'దాన్ని నిలుపుకోవడానికి ఈరోజు ఆడండి.';

  @override
  String get notificationComebackTitle => 'మీ బ్లాక్‌లు ఎదురుచూస్తున్నాయి 🧩';

  @override
  String get notificationComebackBody => 'తిరిగి వచ్చి బహుమతి తీసుకోండి!';

  @override
  String get iapSupporterPack => 'మద్దతుదారు ప్యాక్';

  @override
  String get iapCoinsSmall => '500 నాణేలు';

  @override
  String get iapCoinsMedium => '2,000 నాణేలు';

  @override
  String get iapCoinsLarge => '6,000 నాణేలు';

  @override
  String get iapStarterPack => 'స్టార్టర్ ప్యాక్';

  @override
  String get iapRename => 'పేరు మార్పు';

  @override
  String get iapNeonTheme => 'నియాన్ థీమ్';

  @override
  String get settingsLeaderboardDelete => 'లీడర్‌బోర్డ్ ఎంట్రీని తొలగించు';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'మీ పేరు, స్కోరును పబ్లిక్ జాబితా నుంచి తీసివేస్తుంది';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'మీ ఎంట్రీని తొలగించాలా?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'మీ పేరు, స్కోరు లీడర్‌బోర్డ్ నుంచి తీసివేయబడతాయి. మీ ఆట ప్రగతి మారదు. ఎప్పుడైనా లీడర్‌బోర్డ్‌లో మళ్లీ చేరవచ్చు.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'మీ లీడర్‌బోర్డ్ ఎంట్రీ తొలగించబడింది.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'ఎంట్రీని తొలగించలేకపోయాం. మీ కనెక్షన్‌ను తనిఖీ చేసి మళ్లీ ప్రయత్నించండి.';

  @override
  String get leaderboardReport => 'ఈ పేరును రిపోర్ట్ చేయి';

  @override
  String get leaderboardBlock => 'దాచు';

  @override
  String leaderboardBlocked(String name) {
    return '$name మీకు దాచబడింది';
  }

  @override
  String get leaderboardUndo => 'రద్దు చేయి';

  @override
  String leaderboardBlockedCount(int count) {
    return 'మీరు దాచిన ఎంట్రీలు: $count';
  }

  @override
  String get leaderboardUnblockAll => 'మళ్లీ చూపించు';

  @override
  String get leaderboardReportUnavailable => 'ఇప్పుడు రిపోర్ట్ చేయలేరు.';

  @override
  String get leaderboardReportSent => 'ధన్యవాదాలు — మీ రిపోర్ట్ పంపబడింది.';

  @override
  String get leaderboardRules =>
      'పేర్లు పబ్లిక్. అవమానాలు, దూషణలు, నిజమైన వ్యక్తిని గుర్తించే ఏదీ వద్దు. ఈ నియమాన్ని ఉల్లంఘించే పేర్లు తీసివేయబడతాయి.';

  @override
  String get leaderboardRulesAccept => 'అర్థమైంది';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return 'అన్‌లాక్ అయినవి: $unlocked / $total';
  }

  @override
  String get settingsSectionData => 'సేవ్ చేసిన డేటా';

  @override
  String get gameRotatePiece => 'ముక్కను తిప్పు';

  @override
  String get themeClassic => 'క్లాసిక్';

  @override
  String get themeFade => 'పాస్టెల్';

  @override
  String get themeNeon => 'నియాన్';

  @override
  String get themeOcean => 'సముద్రం';

  @override
  String get themeWood => 'చెక్క';

  @override
  String get themeSunset => 'సూర్యాస్తమయం';

  @override
  String get themeForest => 'అడవి';

  @override
  String get themeAurora => 'అరోరా';

  @override
  String get skinClassic => 'క్లాసిక్';

  @override
  String get skinGradient => 'గ్రేడియంట్';

  @override
  String get skinOutline => 'అవుట్‌లైన్';

  @override
  String get skinGlossy => 'మెరుపు';

  @override
  String get skinStripe => 'చారలు';

  @override
  String get skinBevel => 'వాలు';

  @override
  String get skinGlow => 'కాంతి';

  @override
  String get skinCrystal => 'క్రిస్టల్';

  @override
  String rewardThemeName(String name) {
    return '$name థీమ్';
  }

  @override
  String rewardSkinName(String name) {
    return '$name స్కిన్';
  }

  @override
  String get skinPulse => 'స్పందన';

  @override
  String get skinShimmer => 'మెరుపు';

  @override
  String get skinWave => 'అల';

  @override
  String get skinEmber => 'నిప్పుకణిక';

  @override
  String get skinPrism => 'ప్రిజం';

  @override
  String get skinStardust => 'నక్షత్ర ధూళి';

  @override
  String get skinCircuit => 'సర్క్యూట్';

  @override
  String get skinRipple => 'తరంగం';

  @override
  String achievementRewardSkin(String name) {
    return 'యానిమేటెడ్ స్కిన్: $name';
  }

  @override
  String skinsAchievementReward(String achievement) {
    return 'విజయ బహుమతి: $achievement';
  }

  @override
  String get achievementBackpay =>
      'విజయాలకు ఇప్పుడు బహుమతులు ఉన్నాయి — మీవి జోడించబడ్డాయి.';

  @override
  String get namePromptBody =>
      'ఒక పేరు ఎంచుకోండి, అప్పుడు మీ ఉత్తమ స్కోరు లీడర్‌బోర్డ్‌లోకి వెళ్తుంది. పేరు లేకుండా మీరు అనామకంగా ఆడుతూనే ఉంటారు.';

  @override
  String get nameTaken =>
      'ఈ పేరు ఇప్పటికే తీసుకోబడింది. వేరొకటి ప్రయత్నించండి.';

  @override
  String get nameCheckFailed =>
      'పేరును తనిఖీ చేయలేకపోయాం. మీరు ఆన్‌లైన్‌లో ఉన్నారా? కొద్దిసేపటి తర్వాత మళ్లీ ప్రయత్నించండి.';

  @override
  String nameLost(String name) {
    return '$name ఇప్పుడు మరో ఆటగాడిది. ఉచితంగా కొత్త పేరు ఎంచుకోండి.';
  }

  @override
  String get themeCandy => 'క్యాండీ';

  @override
  String get themeVolcano => 'అగ్నిపర్వతం';

  @override
  String get themeGlacier => 'హిమానీనదం';

  @override
  String get skinPixel => 'పిక్సెల్';

  @override
  String get skinMarble => 'పాలరాయి';

  @override
  String get skinJelly => 'జెల్లీ';

  @override
  String get skinLiquid => 'ద్రవం';

  @override
  String get skinFizz => 'బుడగలు';

  @override
  String get skinPlasma => 'ప్లాస్మా';

  @override
  String get designsTitle => 'డిజైన్‌లు';

  @override
  String get designsNotEnoughDiamonds => 'తగినన్ని వజ్రాలు లేవు.';

  @override
  String get designsOwned => 'మీది';

  @override
  String get designsAchievementOnly => 'విజయం';

  @override
  String get designsSupporterOnly => 'మద్దతుదారు';

  @override
  String get designsPreview => 'ముందుచూపు';

  @override
  String get designsGetDiamonds => 'వజ్రాలు పొందండి';

  @override
  String get shopDealTitle => 'నేటి ఆఫర్';

  @override
  String get shopAnimatedSkins => 'యానిమేటెడ్ స్కిన్‌లు';

  @override
  String get shopNewDesigns => 'కొత్త డిజైన్‌లు';

  @override
  String get shopDiamonds => 'వజ్రాలు';

  @override
  String get shopPacks => 'ప్యాక్‌లు';

  @override
  String get shopPopular => 'ప్రజాదరణ';

  @override
  String get shopBestValue => 'ఉత్తమ విలువ';

  @override
  String get shopDiamondsBlurb => 'యానిమేటెడ్ స్కిన్‌లు, కొత్త డిజైన్‌ల కోసం.';

  @override
  String get shopCoinsBlurb => 'థీమ్‌లు, స్కిన్‌లు, బూస్టర్ల కోసం.';

  @override
  String get shopNeonBlurb => 'నియాన్ థీమ్‌ను వెంటనే అన్‌లాక్ చేస్తుంది.';

  @override
  String get shopRenameBlurb => 'లీడర్‌బోర్డ్‌లో మీ పేరు మార్చండి.';

  @override
  String shopHoursLeft(int hours) {
    return 'ఇంకా $hours గం';
  }

  @override
  String shopNewDealIn(String time) {
    return 'కొత్త ఆఫర్ $timeలో';
  }

  @override
  String shopDesignUnlocked(String name) {
    return '$name అన్‌లాక్ అయింది!';
  }

  @override
  String get questsTitle => 'క్వెస్ట్‌లు';

  @override
  String get questsDaily => 'రోజువారీ';

  @override
  String get questsWeekly => 'వారపు';

  @override
  String get questsMonthly => 'నెలవారీ';

  @override
  String questsNewIn(String time) {
    return 'కొత్త క్వెస్ట్‌లు $timeలో';
  }

  @override
  String get questsBonus => 'అన్నింటికీ బోనస్';

  @override
  String get questsBonusEarned => 'బోనస్ లభించింది';

  @override
  String get questRounds => 'రౌండ్లు ఆడండి';

  @override
  String get questLines => 'వరుసలు క్లియర్ చేయండి';

  @override
  String get questPieces => 'ముక్కలు ఉంచండి';

  @override
  String get questDailyChallenge => 'రోజువారీ సవాలు ఆడండి';

  @override
  String get questPuzzles => 'కొత్త పజిల్స్ పరిష్కరించండి';

  @override
  String get questDays => 'వేర్వేరు రోజుల్లో ఆడండి';

  @override
  String get questDailySets => 'అన్ని రోజువారీ క్వెస్ట్‌లు పూర్తి చేయండి';

  @override
  String get questsSetDaily => 'అన్ని రోజువారీ క్వెస్ట్‌లు పూర్తి!';

  @override
  String get questsSetWeekly => 'అన్ని వారపు క్వెస్ట్‌లు పూర్తి!';

  @override
  String get questsSetMonthly => 'అన్ని నెలవారీ క్వెస్ట్‌లు పూర్తి!';

  @override
  String get leaderboardTabScore => 'అత్యుత్తమ స్కోరు';

  @override
  String get leaderboardTabPuzzle => 'పజిల్ నక్షత్రాలు';

  @override
  String get leaderboardPuzzleAutoSubmit =>
      'మీ పజిల్ నక్షత్రాలు ఆటోమేటిక్‌గా పంపబడతాయి.';

  @override
  String leaderboardPuzzleSubmitting(int stars) {
    return 'మీ పజిల్ నక్షత్రాలు ($stars) పంపబడుతున్నాయి …';
  }

  @override
  String get dailyGoalTitle => 'నేటి లక్ష్యం';

  @override
  String dailyGoalPoints(String points) {
    return '$points పాయింట్లు';
  }

  @override
  String get dailyChestOpened => 'వరుస పెట్టె తెరుచుకుంది!';

  @override
  String dailyNextChest(int day) {
    return 'తదుపరి పెట్టె: వరుసలో $dayవ రోజు';
  }

  @override
  String get dailyExplainer =>
      'ఈ రోజు అందరూ ఒకే బోర్డుపై ఆడతారు, మీ మొదటి రౌండ్ లెక్కలోకి వస్తుంది. అదనపు నాణేల కోసం నక్షత్ర గుర్తులను చేరుకోండి, వజ్రాల పెట్టెల కోసం మీ వరుసను కొనసాగించండి, ఈ రోజు మీ స్థానం ఏమిటో చూడండి.';

  @override
  String dailyRank(int rank, int total) {
    return 'ఈ రోజు $total మందిలో స్థానం $rank';
  }

  @override
  String get dailyRankNeedsName =>
      'ర్యాంకింగ్‌లో కనిపించడానికి పేరు ఎంచుకోండి.';

  @override
  String get dailyRankingButton => 'నేటి ర్యాంకింగ్';

  @override
  String get leaderboardTabDaily => 'నేటి సవాలు';

  @override
  String get leaderboardDailyFooter =>
      'అందరికీ ఒకే బోర్డు, మొదటి రౌండ్ లెక్కలోకి వస్తుంది. ప్రతి రోజు కొత్త ర్యాంకింగ్.';

  @override
  String notificationChestBody(int diamonds) {
    return 'నేటి సవాలు ఆడి వరుస పెట్టెను తెరవండి: $diamonds 💎';
  }

  @override
  String get themePumpkin => 'గుమ్మడికాయ';

  @override
  String get skinGhost => 'దెయ్యం';

  @override
  String get halloweenTitle => 'హాలోవీన్';

  @override
  String get halloweenBody =>
      'గుమ్మడికాయ థీమ్, దెయ్యం స్కిన్ — అక్టోబర్‌లో మాత్రమే.';

  @override
  String get designsBackInOctober => 'అక్టోబర్‌లో మళ్లీ';

  @override
  String get shopFreeTitle => 'ఉచిత బోనస్';

  @override
  String get shopFreeWatch => 'వీడియో చూడండి';

  @override
  String shopFreeToday(int left, int total) {
    return 'ఈ రోజు: $left/$total';
  }

  @override
  String get shopFreeTomorrow => 'రేపు మళ్లీ';

  @override
  String get designsAccessories => 'యాక్సెసరీలు';

  @override
  String get designsBursts => 'పేలుళ్లు';

  @override
  String get accessoryNone => 'ఏదీ లేదు';

  @override
  String get accessoryCobweb => 'సాలెగూడు';

  @override
  String get accessorySnowCap => 'మంచు టోపీ';

  @override
  String get accessoryCrown => 'కిరీటం';

  @override
  String get accessoryFlower => 'పువ్వు';

  @override
  String get accessorySparkle => 'మెరుపు';

  @override
  String get accessoryDewdrop => 'మంచు బిందువు';

  @override
  String get burstClassic => 'క్లాసిక్';

  @override
  String get burstConfetti => 'కాన్ఫెట్టి';

  @override
  String get burstFire => 'మంట';

  @override
  String get burstPixels => 'పిక్సెల్స్';

  @override
  String get burstStars => 'నక్షత్రాలు';

  @override
  String get burstBubbles => 'బుడగలు';
}
