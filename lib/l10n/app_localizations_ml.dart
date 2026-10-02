// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malayalam (`ml`).
class L10nMl extends L10n {
  L10nMl([String locale = 'ml']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'കളിക്കുക';

  @override
  String get commonLater => 'പിന്നീട്';

  @override
  String get commonNotNow => 'ഇപ്പോൾ വേണ്ട';

  @override
  String get commonCancel => 'റദ്ദാക്കുക';

  @override
  String get commonBuy => 'വാങ്ങുക';

  @override
  String get commonSave => 'സേവ് ചെയ്യുക';

  @override
  String get commonCollect => 'നേടുക';

  @override
  String get nameNewName => 'പുതിയ പേര്';

  @override
  String get nameFieldLabel => 'പേര്';

  @override
  String get piggyFullTitle => 'കുടുക്ക നിറഞ്ഞു!';

  @override
  String get piggyKeepSaving => 'സമ്പാദ്യം തുടരുക';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$coins / $capacity ശേഖരിച്ചു.';
  }

  @override
  String get homeContinueRun => 'തുടരുക';

  @override
  String get homeVideo => 'വീഡിയോ';

  @override
  String get commonGotIt => 'മനസ്സിലായി';

  @override
  String get commonHome => 'ഹോം';

  @override
  String get commonScore => 'സ്കോർ';

  @override
  String get commonBest => 'മികച്ചത്';

  @override
  String commonLevelShort(int level) {
    return 'ലെവൽ $level';
  }

  @override
  String get homeNewRun => 'പുതിയ കളി തുടങ്ങുക';

  @override
  String get homeBackToExit => 'പുറത്തുകടക്കാൻ വീണ്ടും ബാക്ക് അമർത്തുക';

  @override
  String get homeEnableLeaderboard => 'ലീഡർബോർഡിൽ ചേരുക';

  @override
  String get homeBestScore => 'മികച്ച സ്കോർ';

  @override
  String get homeDailyChallenge => 'പ്രതിദിന ചലഞ്ച്';

  @override
  String get homeDailyOpenToday => 'ഇന്ന് തുറന്നിരിക്കുന്നു';

  @override
  String homeDailyNextIn(String time) {
    return 'അടുത്ത ചലഞ്ച്: $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return '$streak ദിവസത്തെ സ്ട്രീക്ക്';
  }

  @override
  String get homeLeaderboard => 'ലീഡർബോർഡ്';

  @override
  String get homePuzzleMode => 'പസിൽ മോഡ്';

  @override
  String get homeHowToPlay => 'Qubble എങ്ങനെ കളിക്കാം';

  @override
  String get homeWeekendBonus => 'വാരാന്ത്യം: ഇരട്ടി നാണയങ്ങൾ!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'ലെവൽ $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'പേര് മാറ്റുക';

  @override
  String get nameChangeExplainer =>
      'നിങ്ങളുടെ പേരാണ് ലീഡർബോർഡിലെ നിങ്ങളുടെ ഐഡന്റിറ്റി, അതിനാൽ അത് സ്ഥിരമാണ്. ഒറ്റത്തവണ പേര് മാറ്റം വാങ്ങാം.';

  @override
  String get nameChangeAfterPurchase =>
      'വാങ്ങിയ ശേഷം, മാറ്റാൻ നിങ്ങളുടെ പേരിൽ വീണ്ടും ടാപ്പ് ചെയ്യുക.';

  @override
  String get nameJoinedLeaderboard => 'ഇപ്പോൾ നിങ്ങൾ ലീഡർബോർഡിലുണ്ട്.';

  @override
  String nameProblemTooShort(int min) {
    return 'കുറഞ്ഞത് അക്ഷരങ്ങൾ: $min.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'പരമാവധി അക്ഷരങ്ങൾ: $max.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'ലാറ്റിൻ അക്ഷരങ്ങൾ (ഉദാ. A–Z, é), അക്കങ്ങൾ, സ്പേസ്, _, - എന്നിവ മാത്രം.';

  @override
  String get nameProblemOffensive => 'ദയവായി മറ്റൊരു പേര് തിരഞ്ഞെടുക്കുക.';

  @override
  String get piggyTitle => 'കുടുക്ക';

  @override
  String get piggyFillingHint =>
      'വരികൾ മായ്ക്കുമ്പോൾ നിങ്ങളുടെ കുടുക്ക നിറയുന്നു.';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins നാണയങ്ങൾ സൗജന്യമായി നേടുക.',
      one: '$coins നാണയം സൗജന്യമായി നേടുക.',
    );
    return '$_temp0';
  }

  @override
  String get piggyEarlyOpenHint =>
      'നിറഞ്ഞാൽ സൗജന്യമായി കാലിയാക്കാം — അല്ലെങ്കിൽ ബോണസ് വീഡിയോ വഴി നേരത്തെ തുറക്കാം.';

  @override
  String get piggyOpenNow => 'ഇപ്പോൾ തുറക്കുക';

  @override
  String get gameNewPiecesVideo => 'പുതിയ കഷണങ്ങൾ (വീഡിയോ)';

  @override
  String get gameTapBoardCell => 'ബോർഡിലെ ഒരു കളത്തിൽ ടാപ്പ് ചെയ്യുക';

  @override
  String get gameDailyChallengeLabel => 'പ്രതിദിന ചലഞ്ച്';

  @override
  String get gameOver => 'കളി കഴിഞ്ഞു';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'ബോംബിന് വേണ്ട അധിക നാണയങ്ങൾ: $missing.';
  }

  @override
  String get gameBombNotHere => 'ബോംബ് ഇപ്പോൾ ഇവിടെ പ്രവർത്തിക്കില്ല.';

  @override
  String gameNeedsCoins(String missing) {
    return 'ഇതിന് വേണ്ട അധിക നാണയങ്ങൾ: $missing.';
  }

  @override
  String get gameNotRightNow => 'ഇപ്പോൾ സാധ്യമല്ല.';

  @override
  String get gameRunSaved => 'കളി സേവ് ചെയ്തു — മെനുവിൽ \"തുടരുക\".';

  @override
  String get gameOverNoFit => 'നിങ്ങളുടെ ഒരു കഷണവും ഇനി ബോർഡിൽ ഒതുങ്ങില്ല.';

  @override
  String get gameOverNoFitNoRotations =>
      'ഒരു കഷണവും ഒതുങ്ങില്ല — തിരിക്കാനുള്ള അവസരങ്ങളും തീർന്നു.';

  @override
  String get gameStarterOfferUnavailable => 'ഇപ്പോൾ ലഭ്യമല്ല';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — നേടുക';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'കോംബോ x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'നേട്ടം: $title';
  }

  @override
  String get gameBestSubmitted => 'പുതിയ മികച്ചത് — അയച്ചു';

  @override
  String get gameReviveFor => 'കളി തുടരുക · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'അൺലോക്ക് ചെയ്തു: $name';
  }

  @override
  String get gameStarterOfferTitle => 'സ്റ്റാർട്ടർ പായ്ക്ക്';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score പോയിന്റുകൾ',
      one: '$score പോയിന്റ്',
    );
    return '$_temp0';
  }

  @override
  String get gameNewRecord => 'പുതിയ റെക്കോർഡ്!';

  @override
  String gameStreakDays(int streak) {
    return '$streak ദിവസത്തെ സ്ട്രീക്ക്';
  }

  @override
  String get gameDoubleCoins => 'നാണയങ്ങൾ ഇരട്ടിയാക്കുക';

  @override
  String get gameDoubleDaily => 'പ്രതിദിന സമ്മാനം ഇരട്ടിയാക്കുക';

  @override
  String get gamePlayAgain => 'വീണ്ടും കളിക്കുക';

  @override
  String gameLevelReached(int level) {
    return 'ലെവൽ $level എത്തി!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return '+$count ലെവൽ — ലെവൽ $level!';
  }

  @override
  String get gameStarterOfferReward => '1200 നാണയങ്ങൾ + തടി തീം';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return '$hours മണിക്കൂർ മാത്രം ബാക്കി — ഒറ്റത്തവണ!';
  }

  @override
  String get boosterUndo => 'പിന്നോട്ട്';

  @override
  String get boosterSwap => 'മാറ്റുക';

  @override
  String get boosterBomb => 'ബോംബ്';

  @override
  String get boosterNoRotationsLeft =>
      'തിരിക്കാനുള്ള അവസരം ബാക്കിയില്ല — വീണ്ടും നേടാൻ വരികൾ മായ്ക്കുക!';

  @override
  String get onboardingDragPiece => 'ഒരു ബ്ലോക്ക് ഗ്രിഡിലേക്ക് വലിച്ചിടുക';

  @override
  String get onboardingFillLine => 'ഒരു മുഴുവൻ വരിയോ നിരയോ നിറയ്ക്കുക';

  @override
  String get onboardingLinesClear => 'നിറഞ്ഞ വരികൾ മായും — പോയിന്റുകൾ!';

  @override
  String get coachHintCombo =>
      'കോംബോ! നിലനിർത്താൻ 3 നീക്കങ്ങൾക്കുള്ളിൽ വീണ്ടും മായ്ക്കുക';

  @override
  String get coachHintFever => 'ഫീവർ! തിളങ്ങുന്നിടത്തോളം ഇരട്ടി പോയിന്റുകൾ';

  @override
  String get coachHintRotation =>
      'തിരിക്കാൻ ഒരു ചാർജ് ചെലവാകും — മായ്ക്കുമ്പോൾ അത് നിറയും';

  @override
  String get coachHintBooster => 'ടിപ്പ്: താഴെ ബൂസ്റ്ററുകൾ ഉപയോഗിക്കാം';

  @override
  String get coachHintStrategy =>
      'ടിപ്പ്: എല്ലാ വരികളും ഒരുമിച്ച് വേണ്ട — വലിയ കഷണങ്ങൾക്ക് ഇടം വിടുക';

  @override
  String get dailyStreakLabel => 'സ്ട്രീക്ക്';

  @override
  String get dailyBestLabel => 'പ്രതിദിന മികച്ചത്';

  @override
  String dailyHistoryNote(int days) {
    return 'കഴിഞ്ഞ $days ദിവസങ്ങൾ സൂക്ഷിക്കുന്നു.';
  }

  @override
  String dailyDayPlayed(int day) {
    return 'ദിവസം $day: കളിച്ചു';
  }

  @override
  String dailyDayMissed(int day) {
    return 'ദിവസം $day: കളിച്ചില്ല';
  }

  @override
  String get homeDailyCalendar => 'കലണ്ടർ';

  @override
  String get dailyShareButton => 'ഫലം പങ്കിടുക';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · പ്രതിദിന ചലഞ്ച് $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'പോയിന്റുകൾ: $score · മികച്ച കോംബോ x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'കളിക്കൂ: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'കോംബോ: ഇനി $moves നീക്കങ്ങൾ',
      one: 'കോംബോ: ഇനി $moves നീക്കം',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'ഫലം ക്ലിപ്പ്ബോർഡിലേക്ക് പകർത്തി';

  @override
  String get adNotAvailable =>
      'ഇപ്പോൾ വീഡിയോ ഇല്ല — അൽപ്പസമയത്തിന് ശേഷം വീണ്ടും ശ്രമിക്കുക';

  @override
  String get howToPlaySpeedTitle => 'വേഗ ബോണസ്';

  @override
  String get howToPlaySpeedBody =>
      'വേഗത്തിൽ വയ്ക്കുന്നത് ഓരോ മായ്ക്കലിനും 30 % വരെ ചേർക്കും. ബോണസ് 1.5 മുതൽ 4 സെക്കൻഡ് വരെയുള്ള സമയത്ത് കുറയുന്നു, അതിന് പരിധിയുമുണ്ട്; അതിനാൽ വേഗത ഗുണം ചെയ്യും, പക്ഷേ കളി തീരുമാനിക്കില്ല — ശ്രദ്ധയോടെ പതുക്കെ കളിക്കുന്ന കളിക്ക് തിടുക്കമുള്ള വേഗ കളിയെ ഇപ്പോഴും തോൽപ്പിക്കാം.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'വേഗ ബോണസ് $percent ശതമാനം';
  }

  @override
  String get iapDiamondsSmall => '100 വജ്രങ്ങൾ';

  @override
  String get iapDiamondsMedium => '350 വജ്രങ്ങൾ';

  @override
  String get iapDiamondsLarge => '1,000 വജ്രങ്ങൾ';

  @override
  String get howToPlayTitle => 'Qubble എങ്ങനെ കളിക്കാം';

  @override
  String get howToPlayIntroHeadline =>
      'തുടങ്ങാൻ എളുപ്പം.\nമുൻകൂട്ടി ചിന്തിച്ചാൽ നേട്ടം.';

  @override
  String get howToPlayIntroBody =>
      'ബോർഡ് ഒഴിവായി സൂക്ഷിച്ച് നിങ്ങളുടെ റെക്കോർഡ് തകർക്കുക.';

  @override
  String get howToPlayIntroSemantics =>
      'കളിയുടെ ലക്ഷ്യം. ബോർഡ് ഒഴിവായി സൂക്ഷിച്ച് നിങ്ങളുടെ റെക്കോർഡ് തകർക്കുക.';

  @override
  String get howToPlayDragTitle => 'വലിച്ചിടുക';

  @override
  String get howToPlayDragBody =>
      'മൂന്ന് കഷണങ്ങളിൽ ഒന്ന് ഒഴിഞ്ഞ കളങ്ങളിലേക്ക് വലിച്ചിടുക. മൂന്നും ഉപയോഗിച്ചു കഴിഞ്ഞാൽ, സ്വയമേവ മൂന്ന് പുതിയവ ലഭിക്കും.';

  @override
  String get howToPlayClearTitle => 'വരികൾ മായ്ക്കുക';

  @override
  String get howToPlayClearBody =>
      'ഒരു മുഴുവൻ വരിയോ നിരയോ നിറയ്ക്കുക. നിറഞ്ഞ വരികൾ മാഞ്ഞ് അടുത്ത നീക്കത്തിന് ഇടം നൽകും.';

  @override
  String get howToPlayComboTitle => 'കോംബോകൾ കോർക്കുക';

  @override
  String get howToPlayComboBody =>
      'മൂന്ന് നീക്കങ്ങൾക്കുള്ളിൽ മറ്റൊരു വരി മായ്ക്കുക. ഓരോ അധിക കോംബോയും നിങ്ങളുടെ പോയിന്റ് ഗുണകം കൂട്ടും. കോംബോ സെക്കൻഡുകളല്ല, നീക്കങ്ങളാണ് എണ്ണുന്നത്; അതിനാൽ നിങ്ങൾ ആലോചിക്കുമ്പോൾ അത് തീരില്ല.';

  @override
  String get howToPlayFeverTitle => 'ഫീവർ കത്തിക്കുക';

  @override
  String get howToPlayFeverBody =>
      'മായ്ക്കലുകൾ ഫീവർ മീറ്റർ നിറയ്ക്കും. അത് നിറയുമ്പോൾ, അടുത്ത പൊട്ടിത്തെറി ഇരട്ടിയായി എണ്ണും — വലിയ മായ്ക്കലുകൾ മുൻകൂട്ടി ആസൂത്രണം ചെയ്യുക.';

  @override
  String get howToPlayBoosterTitle => 'ബൂസ്റ്ററുകൾ ബുദ്ധിപൂർവ്വം ഉപയോഗിക്കുക';

  @override
  String get howToPlayBoosterBody =>
      'ബൂസ്റ്ററുകൾ ബുദ്ധിമുട്ടുള്ള കളികളെ രക്ഷിക്കും. താഴെയുള്ള കഷണത്തിൽ ടാപ്പ് ചെയ്ത് അത് തിരിക്കാനും കഴിയും.';

  @override
  String get howToPlayDailyTitle => 'പ്രതിദിന ചലഞ്ചും സ്ട്രീക്കും';

  @override
  String get howToPlayDailyBody =>
      'പ്രതിദിന ചലഞ്ചിൽ എല്ലാവർക്കും ഒരേ കഷണങ്ങൾ. നിങ്ങളുടെ സ്ട്രീക്കും ബോണസും വളർത്താൻ ദിവസവും കളിക്കുക.';

  @override
  String get howToPlayPiggyTitle => 'കുടുക്ക നിറയ്ക്കുക';

  @override
  String get howToPlayPiggyBody =>
      'മായ്ക്കുന്ന ഓരോ വരിയും നിങ്ങളുടെ കുടുക്ക നിറയ്ക്കും. അത് നിറയുമ്പോൾ, നാണയങ്ങൾ സൗജന്യമായി നേടാം.';

  @override
  String get leaderboardTitle => 'ലീഡർബോർഡ്';

  @override
  String get leaderboardUnreachable =>
      'ലീഡർബോർഡ് ലഭ്യമല്ല.\nഇന്റർനെറ്റ് കണക്ഷനോടെ വീണ്ടും ശ്രമിക്കുക.';

  @override
  String get leaderboardEmpty => 'ഇതുവരെ എൻട്രികളില്ല.\nആദ്യത്തെയാളാകൂ!';

  @override
  String leaderboardSubmitting(int score) {
    return 'നിങ്ങളുടെ മികച്ച സ്കോർ ($score) അയയ്ക്കുന്നു …';
  }

  @override
  String get leaderboardAutoSubmit =>
      'നിങ്ങളുടെ മികച്ച സ്കോർ സ്വയമേവ അയയ്ക്കും.';

  @override
  String get puzzleModeTitle => 'പസിൽ മോഡ്';

  @override
  String puzzleLevelTitle(int level) {
    return 'പസിൽ $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'നീക്കങ്ങൾ: $moves   •   ലക്ഷ്യം: 3 നക്ഷത്രങ്ങൾക്ക് $target';
  }

  @override
  String get puzzleSolved => 'പരിഹരിച്ചു!';

  @override
  String get puzzleLeaveTitle => 'പസിൽ വിടണോ?';

  @override
  String get puzzleLeaveBody => 'ഈ പസിലിലെ നിങ്ങളുടെ പുരോഗതി നഷ്ടമാകും.';

  @override
  String get puzzleKeepPlaying => 'കളി തുടരുക';

  @override
  String get puzzleLeave => 'വിടുക';

  @override
  String get puzzleStuckTitle => 'കുടുങ്ങി';

  @override
  String get puzzleRestart => 'വീണ്ടും തുടങ്ങുക';

  @override
  String get commonActive => 'സജീവം';

  @override
  String get commonRestore => 'പുനഃസ്ഥാപിക്കുക';

  @override
  String get skinsExchangeGold => 'സ്വർണം മാറ്റുക';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'കഷണം തിരിക്കുക';

  @override
  String get puzzleNextLevel => 'അടുത്ത ലെവൽ';

  @override
  String get puzzleBackToOverview => 'പട്ടികയിലേക്ക് മടങ്ങുക';

  @override
  String get puzzleUnsolvable => 'ഇവിടെ നിന്ന് ബോർഡ് ഇനി കാലിയാക്കാനാവില്ല.';

  @override
  String get puzzleExtraMoveVideo => 'അധിക നീക്കം (വീഡിയോ)';

  @override
  String get puzzleHintVideo => 'സൂചന (വീഡിയോ)';

  @override
  String get puzzleHintVideoCost => 'സൂചന (വീഡിയോ, ഒരു നക്ഷത്രം കുറയും)';

  @override
  String get puzzleNoHint =>
      'ഇവിടെ നിന്ന് സൂചന നൽകാനാവില്ല. പസിൽ വീണ്ടും തുടങ്ങുക.';

  @override
  String puzzleSolvedCount(int solved) {
    return 'പരിഹരിച്ചവ: $solved';
  }

  @override
  String get settingsTitle => 'ക്രമീകരണങ്ങൾ';

  @override
  String get storageFailureTitle =>
      'നിങ്ങളുടെ സേവ് ചെയ്ത കളി Qubble-ന് ലോഡ് ചെയ്യാനാവുന്നില്ല';

  @override
  String get storageFailureBody =>
      'ദയവായി ആപ്പ് റീസ്റ്റാർട്ട് ചെയ്യുക. പിശക് തുടർന്നാൽ, വീണ്ടും ഇൻസ്റ്റാൾ ചെയ്യുന്നത് മാത്രമാണ് പരിഹാരം. ക്രമീകരണങ്ങൾ › ഫീഡ്‌ബാക്ക് വഴി ഇത് അറിയിക്കാം.';

  @override
  String get iapUnavailable => 'ഈ ഓഫർ ഇപ്പോൾ ലഭ്യമല്ല.';

  @override
  String get iapFailed => 'വാങ്ങൽ പൂർത്തിയായില്ല. പണമൊന്നും ഈടാക്കിയിട്ടില്ല.';

  @override
  String get settingsResetProgress => 'പുരോഗതി റീസെറ്റ് ചെയ്യുക';

  @override
  String get settingsResetProgressSubtitle =>
      'സ്കോർ, നാണയങ്ങൾ, ലെവൽ, പുരോഗതി എന്നിവ തുടക്കത്തിലേക്ക്. വാങ്ങലുകൾ, പേര്, അലങ്കാരങ്ങൾ എന്നിവ നിലനിൽക്കും.';

  @override
  String get settingsResetConfirmTitle => 'പുരോഗതി റീസെറ്റ് ചെയ്യണോ?';

  @override
  String get settingsResetConfirmBody =>
      'മികച്ച സ്കോർ, നാണയങ്ങൾ, ലെവൽ, സ്ട്രീക്ക്, മുഴുവൻ പുരോഗതി എന്നിവ ഇല്ലാതാക്കും. ഇത് പഴയപടിയാക്കാനാവില്ല.\n\nനിങ്ങളുടെ വാങ്ങലുകൾ, പേര്, അൺലോക്ക് ചെയ്ത തീമുകൾ, സ്കിന്നുകൾ എന്നിവ നിലനിൽക്കും.';

  @override
  String get settingsResetConfirmAction => 'റീസെറ്റ്';

  @override
  String get settingsResetDone => 'പുരോഗതി റീസെറ്റ് ചെയ്തു.';

  @override
  String get settingsSectionGame => 'കളി';

  @override
  String get settingsSectionSoundHaptics => 'ശബ്ദവും വൈബ്രേഷനും';

  @override
  String get settingsSectionReminders => 'ഓർമ്മപ്പെടുത്തലുകൾ';

  @override
  String get settingsSectionPurchases => 'വാങ്ങലുകൾ';

  @override
  String get settingsSectionHelpOut => 'സഹായിക്കൂ';

  @override
  String get settingsSectionLegal => 'നിയമപരം';

  @override
  String get settingsSectionLanguage => 'ഭാഷ';

  @override
  String get settingsGuide => 'എങ്ങനെ കളിക്കാം';

  @override
  String get settingsGuideSubtitle => 'നിയമങ്ങൾ, കോംബോകൾ, ഫീവർ, ബൂസ്റ്ററുകൾ';

  @override
  String get settingsSound => 'ശബ്ദം';

  @override
  String get settingsMusic => 'സംഗീതം';

  @override
  String get settingsHaptics => 'വൈബ്രേഷൻ';

  @override
  String get settingsHapticsOff => 'ഓഫ്';

  @override
  String get settingsHapticsLight => 'ലഘു';

  @override
  String get settingsHapticsStrong => 'ശക്തം';

  @override
  String get settingsSectionAccessibility => 'സൗകര്യം';

  @override
  String get settingsReducedEffects => 'കുറഞ്ഞ ഇഫക്റ്റുകൾ';

  @override
  String get settingsReducedEffectsHint =>
      'കുറഞ്ഞ കണങ്ങൾ, സ്ക്രീൻ കുലുക്കമില്ല, തിളക്കമില്ല';

  @override
  String get settingsNotifications => 'അറിയിപ്പുകൾ';

  @override
  String get settingsNotificationsSubtitle =>
      'പ്രതിദിന ഓർമ്മപ്പെടുത്തലും സ്ട്രീക്ക് സംരക്ഷണവും';

  @override
  String get settingsNotificationsSystemHint =>
      'സിസ്റ്റം ക്രമീകരണങ്ങളിൽ അനുവദിക്കുക.';

  @override
  String get settingsLanguageSystem => 'സിസ്റ്റം ഭാഷ';

  @override
  String get settingsSupporterThanks => 'പിന്തുണയ്ക്ക് നന്ദി!';

  @override
  String get settingsSupporterPack => 'സപ്പോർട്ടർ പായ്ക്ക്';

  @override
  String get settingsSupporterPackSubtitle =>
      'പ്രത്യേക തീമും സ്കിന്നും + 1,500 നാണയങ്ങൾ';

  @override
  String get settingsRestorePurchases => 'വാങ്ങലുകൾ പുനഃസ്ഥാപിക്കുക';

  @override
  String get settingsRestoring => 'വാങ്ങലുകൾ പുനഃസ്ഥാപിക്കുന്നു…';

  @override
  String get settingsRateApp => 'ആപ്പ് റേറ്റ് ചെയ്യുക';

  @override
  String get settingsRateAppSubtitle => 'സ്റ്റോറിൽ റേറ്റിംഗ് നൽകുക';

  @override
  String get settingsStoreUnavailable => 'ഈ ഉപകരണത്തിൽ സ്റ്റോർ ലഭ്യമല്ല.';

  @override
  String get settingsFeedback => 'ഫീഡ്‌ബാക്ക് അയയ്ക്കുക';

  @override
  String get settingsFeedbackSubtitle =>
      'ആശയങ്ങളും പിശകുകളും അറിയിക്കുക (GitHub വഴി)';

  @override
  String get settingsAdPrivacy => 'പരസ്യ സ്വകാര്യത';

  @override
  String get settingsAdPrivacySubtitle =>
      'നിങ്ങളുടെ പരസ്യ സമ്മതം കാണുക അല്ലെങ്കിൽ മാറ്റുക';

  @override
  String get settingsAdPrivacyUnavailable =>
      'ഈ ഉപകരണത്തിൽ പരസ്യ ഓപ്ഷനുകൾ ആവശ്യമില്ല.';

  @override
  String get settingsPrivacy => 'സ്വകാര്യതാ നയം';

  @override
  String get settingsImprint => 'നിയമപരമായ വിവരങ്ങൾ';

  @override
  String get settingsPageOpenFailed => 'പേജ് തുറക്കാനായില്ല.';

  @override
  String get settingsFooter => 'Qubble • ഓഫ്‌ലൈൻ ബ്ലോക്ക് പസിൽ';

  @override
  String get settingsAdminSection => 'അഡ്മിൻ (ടെസ്റ്റ്)';

  @override
  String get settingsAdminEnabled => 'അഡ്മിൻ മോഡ് ഓൺ';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'അഡ്മിൻ മോഡിനായി ഇനി $count തവണ ടാപ്പ് ചെയ്യുക';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins നാണയങ്ങൾ',
      one: '$coins നാണയം',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'ടെസ്റ്റിംഗിന് മാത്രം — റിലീസ് സ്ക്രീൻഷോട്ടുകളിൽ ഒരിക്കലും വേണ്ട';

  @override
  String settingsAdminAddCoins(int amount) {
    String _temp0 = intl.Intl.pluralLogic(
      amount,
      locale: localeName,
      other: '$amount നാണയങ്ങൾ',
      one: '$amount നാണയം',
    );
    return '+$_temp0';
  }

  @override
  String get settingsAdminResetCoins => 'നാണയങ്ങൾ 0 ആക്കുക';

  @override
  String get feedbackTitle => 'ഫീഡ്‌ബാക്ക്';

  @override
  String get feedbackIntroShort =>
      'നിങ്ങൾക്ക് എന്ത് ഇഷ്ടമാണ്, എന്ത് അലോസരപ്പെടുത്തുന്നു, എന്ത് കുറവുണ്ട്? ചെറിയ കാര്യങ്ങളും സഹായിക്കും — എത്ര കൃത്യമാണോ അത്രയും നല്ലത്.';

  @override
  String feedbackAttachmentNote(String build) {
    return '$build, നിങ്ങളുടെ ഉപകരണ തരം എന്നിവ മാത്രം ചേർക്കും — ഏത് പതിപ്പിനെക്കുറിച്ചാണ് പറയുന്നതെന്ന് എനിക്ക് അറിയാൻ.';
  }

  @override
  String get feedbackSendByMail => 'ഇമെയിൽ വഴി അയയ്ക്കുക';

  @override
  String get feedbackPreferGithub => 'GitHub issue ആണ് താൽപ്പര്യം';

  @override
  String get feedbackThanksMail => 'നന്ദി! സന്ദേശം അയച്ചാൽ മതി.';

  @override
  String get feedbackNoMailApp =>
      'മെയിൽ ആപ്പ് കണ്ടെത്തിയില്ല. താഴെയുള്ള GitHub വഴി ശ്രമിക്കുക.';

  @override
  String get feedbackEmptyHint => 'ദയവായി ആദ്യം എന്തെങ്കിലും എഴുതുക.';

  @override
  String get leaderboardRefresh => 'പുതുക്കുക';

  @override
  String get leaderboardRetry => 'വീണ്ടും ശ്രമിക്കുക';

  @override
  String get feedbackHint => 'നിങ്ങളുടെ ഫീഡ്‌ബാക്ക്…';

  @override
  String get feedbackSubmit => 'ഫീഡ്‌ബാക്ക് അയയ്ക്കുക';

  @override
  String get feedbackOpenFailed =>
      'GitHub തുറക്കാനായില്ല. പിന്നീട് ശ്രമിക്കുക.';

  @override
  String get feedbackGithubNote =>
      'GitHub തുറക്കും — അവിടെ \"Submit new issue\" ടാപ്പ് ചെയ്യുക. (ഒരിക്കൽ GitHub ലോഗിൻ ആവശ്യമാണ്.)';

  @override
  String get shopTitle => 'ഷോപ്പ്';

  @override
  String get shopWebDemoNote =>
      'വാങ്ങലുകൾ Play Store ആപ്പിൽ മാത്രമേ ലഭ്യമാകൂ. ഈ വെബ് പതിപ്പ് സൗജന്യ ഡെമോയാണ് — എന്നിരുന്നാലും ഇവിടെ എല്ലാം കളിക്കാം.';

  @override
  String get shopSupporterExplainer =>
      'Qubble നിർബന്ധിത പരസ്യങ്ങൾ കാണിക്കുന്നില്ല — നിങ്ങൾ ഒന്നും വാങ്ങേണ്ടതില്ല. സപ്പോർട്ടർ പായ്ക്ക് (അറോറ തീം, ക്രിസ്റ്റൽ സ്കിൻ, 1,500 നാണയങ്ങൾ, സപ്പോർട്ടർ ബാഡ്ജ്) കളിയെ പിന്തുണച്ചതിനുള്ള നന്ദിയാണ്. വാങ്ങലുകൾ നിങ്ങളുടെ സ്റ്റോർ അക്കൗണ്ടുമായി ബന്ധിപ്പിച്ചിരിക്കുന്നു, എപ്പോൾ വേണമെങ്കിലും പുനഃസ്ഥാപിക്കാം.';

  @override
  String get shopSupporterContents =>
      'അറോറ തീം + ക്രിസ്റ്റൽ സ്കിൻ + 1,500 നാണയങ്ങൾ';

  @override
  String get themesTitle => 'തീമുകൾ';

  @override
  String get themesSupporterOnly =>
      'സപ്പോർട്ടർ പായ്ക്കിൽ മാത്രം (ഷോപ്പ് കാണുക)';

  @override
  String get skinsTitle => 'ബ്ലോക്ക് സ്കിന്നുകൾ';

  @override
  String get skinsNotEnoughCoins => 'ആവശ്യത്തിന് നാണയങ്ങളില്ല';

  @override
  String get skinsNotEnoughGold => 'ആവശ്യത്തിന് സ്വർണമില്ല.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold സ്വർണം = 1 വജ്രം. വജ്രങ്ങൾ ഏറ്റവും മനോഹരമായ സ്കിന്നുകൾ അൺലോക്ക് ചെയ്യും — സാവധാനം ശേഖരിക്കുക.';
  }

  @override
  String get statsTitle => 'സ്ഥിതിവിവരക്കണക്കുകൾ';

  @override
  String get statsAverageScore => 'ശരാശരി സ്കോർ';

  @override
  String get statsBestCombo => 'മികച്ച കോംബോ';

  @override
  String get statsGames => 'കളികൾ';

  @override
  String get statsLinesCleared => 'മായ്ച്ച വരികൾ';

  @override
  String get statsPiecesPlaced => 'വച്ച കഷണങ്ങൾ';

  @override
  String get statsCoins => 'നാണയങ്ങൾ';

  @override
  String questCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'x$countString കോംബോ നേടുക';
  }

  @override
  String questScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ഒരു കളിയിൽ $countString പോയിന്റുകൾ കടക്കുക',
      one: 'ഒരു കളിയിൽ $countString പോയിന്റ് കടക്കുക',
    );
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'നേട്ടങ്ങൾ';

  @override
  String get achievementFirstGameTitle => 'ആദ്യ കളി';

  @override
  String get achievementFirstGameBody => 'നിങ്ങളുടെ ആദ്യ കളി കളിക്കുക';

  @override
  String get achievementGames25Title => 'പതിവുകാർ';

  @override
  String get achievementGames25Body => '25 കളികൾ കളിക്കുക';

  @override
  String get achievementGames100Title => 'ആരാധകർ';

  @override
  String get achievementGames100Body => '100 കളികൾ കളിക്കുക';

  @override
  String get achievementScore1kTitle => 'കയറ്റം';

  @override
  String get achievementScore1kBody => '1,000 പോയിന്റുകൾ നേടുക';

  @override
  String get achievementScore5kTitle => 'പ്രോ';

  @override
  String get achievementScore5kBody => '5,000 പോയിന്റുകൾ നേടുക';

  @override
  String get achievementScore10kTitle => 'മാസ്റ്റർ';

  @override
  String get achievementScore10kBody => '10,000 പോയിന്റുകൾ നേടുക';

  @override
  String get achievementScore25kTitle => 'ഇതിഹാസം';

  @override
  String get achievementScore25kBody => '25,000 പോയിന്റുകൾ നേടുക';

  @override
  String get achievementLines100Title => 'ചിട്ടയായി';

  @override
  String get achievementLines100Body => 'ആകെ 100 വരികൾ മായ്ക്കുക';

  @override
  String get achievementLines1000Title => 'വലിയ വൃത്തിയാക്കൽ';

  @override
  String get achievementLines1000Body => 'ആകെ 1,000 വരികൾ മായ്ക്കുക';

  @override
  String get achievementCombo5Title => 'കോംബോ തുടക്കം';

  @override
  String get achievementCombo5Body => 'x5 കോംബോ നേടുക';

  @override
  String get achievementCombo10Title => 'കോംബോ രാജാവ്';

  @override
  String get achievementCombo10Body => 'x10 കോംബോ നേടുക';

  @override
  String get achievementLevel10Title => 'അനുഭവസമ്പന്നർ';

  @override
  String get achievementLevel10Body => 'ലെവൽ 10 എത്തുക';

  @override
  String get achievementLevel20Title => 'വെറ്ററൻ';

  @override
  String get achievementLevel20Body => 'ലെവൽ 20 എത്തുക';

  @override
  String get achievementStreak7Title => 'പ്രതിവാര സ്ട്രീക്ക്';

  @override
  String get achievementStreak7Body => '7 ദിവസത്തെ പ്രതിദിന സ്ട്രീക്ക്';

  @override
  String get achievementStreak30Title => 'പ്രതിമാസ സ്ട്രീക്ക്';

  @override
  String get achievementStreak30Body => '30 ദിവസത്തെ പ്രതിദിന സ്ട്രീക്ക്';

  @override
  String get achievementPuzzles10Title => 'പസിലർ';

  @override
  String get achievementPuzzles10Body => '10 പസിലുകൾ പരിഹരിക്കുക';

  @override
  String get achievementPieces5000Title => 'നിർമ്മാതാവ്';

  @override
  String get achievementPieces5000Body => '5,000 കഷണങ്ങൾ വയ്ക്കുക';

  @override
  String streakRepairTitle(int streak) {
    return '$streak ദിവസത്തെ സ്ട്രീക്ക് അപകടത്തിൽ!';
  }

  @override
  String get streakRepairBody =>
      'ഇന്നലെ കളിച്ചില്ല — നിങ്ങളുടെ സ്ട്രീക്ക് രക്ഷിക്കുക:';

  @override
  String get streakRepairFailed => 'പരിഹരിക്കാനാവില്ല.';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins നാണയങ്ങൾ',
      one: '$coins നാണയം',
    );
    return 'വീണ്ടും സ്വാഗതം! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'ഓർമ്മപ്പെടുത്തലുകൾ?';

  @override
  String get notificationsOptInBody =>
      'നിങ്ങളുടെ പ്രതിദിന പസിൽ ഓർമ്മിപ്പിക്കുകയും സ്ട്രീക്ക് സംരക്ഷിക്കുകയും ചെയ്യട്ടെ? ഇത് എപ്പോൾ വേണമെങ്കിലും ക്രമീകരണങ്ങളിൽ മാറ്റാം.';

  @override
  String get notificationsOptInAccept => 'അതെ, ദയവായി';

  @override
  String get notificationChannelDescription =>
      'പ്രതിദിന ഓർമ്മപ്പെടുത്തൽ, സ്ട്രീക്ക് മുന്നറിയിപ്പ്, തിരിച്ചുവരവ്';

  @override
  String get notificationDailyTitle =>
      'നിങ്ങളുടെ പ്രതിദിന പസിൽ കാത്തിരിക്കുന്നു 🧩';

  @override
  String get notificationDailyBody => 'ഇന്നത്തെ ചലഞ്ച് കളിക്കൂ!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 നിങ്ങളുടെ $streak ദിവസത്തെ സ്ട്രീക്ക് അപകടത്തിൽ!';
  }

  @override
  String get notificationStreakBody => 'അത് നിലനിർത്താൻ ഇന്ന് കളിക്കൂ.';

  @override
  String get notificationComebackTitle =>
      'നിങ്ങളുടെ ബ്ലോക്കുകൾ കാത്തിരിക്കുന്നു 🧩';

  @override
  String get notificationComebackBody => 'തിരിച്ചുവന്ന് സമ്മാനം നേടൂ!';

  @override
  String get iapSupporterPack => 'സപ്പോർട്ടർ പായ്ക്ക്';

  @override
  String get iapCoinsSmall => '500 നാണയങ്ങൾ';

  @override
  String get iapCoinsMedium => '2,000 നാണയങ്ങൾ';

  @override
  String get iapCoinsLarge => '6,000 നാണയങ്ങൾ';

  @override
  String get iapStarterPack => 'സ്റ്റാർട്ടർ പായ്ക്ക്';

  @override
  String get iapRename => 'പേര് മാറ്റം';

  @override
  String get iapNeonTheme => 'നിയോൺ തീം';

  @override
  String get settingsLeaderboardDelete => 'ലീഡർബോർഡ് എൻട്രി ഇല്ലാതാക്കുക';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'നിങ്ങളുടെ പേരും സ്കോറും പൊതു പട്ടികയിൽ നിന്ന് നീക്കം ചെയ്യും';

  @override
  String get settingsLeaderboardDeleteConfirmTitle =>
      'നിങ്ങളുടെ എൻട്രി ഇല്ലാതാക്കണോ?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'നിങ്ങളുടെ പേരും സ്കോറും ലീഡർബോർഡിൽ നിന്ന് നീക്കം ചെയ്യും. നിങ്ങളുടെ കളിയിലെ പുരോഗതി മാറില്ല. എപ്പോൾ വേണമെങ്കിലും ലീഡർബോർഡിൽ വീണ്ടും ചേരാം.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'നിങ്ങളുടെ ലീഡർബോർഡ് എൻട്രി ഇല്ലാതാക്കി.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'എൻട്രി ഇല്ലാതാക്കാനായില്ല. കണക്ഷൻ പരിശോധിച്ച് വീണ്ടും ശ്രമിക്കുക.';

  @override
  String get leaderboardReport => 'ഈ പേര് റിപ്പോർട്ട് ചെയ്യുക';

  @override
  String get leaderboardBlock => 'മറയ്ക്കുക';

  @override
  String leaderboardBlocked(String name) {
    return '$name നിങ്ങൾക്കായി മറച്ചു';
  }

  @override
  String get leaderboardUndo => 'പഴയപടിയാക്കുക';

  @override
  String leaderboardBlockedCount(int count) {
    return 'നിങ്ങൾ മറച്ച എൻട്രികൾ: $count';
  }

  @override
  String get leaderboardUnblockAll => 'വീണ്ടും കാണിക്കുക';

  @override
  String get leaderboardReportUnavailable =>
      'ഇപ്പോൾ റിപ്പോർട്ട് ചെയ്യാനാവില്ല.';

  @override
  String get leaderboardReportSent => 'നന്ദി — നിങ്ങളുടെ റിപ്പോർട്ട് അയച്ചു.';

  @override
  String get leaderboardRules =>
      'പേരുകൾ പൊതുവാണ്. അപമാനങ്ങളും അധിക്ഷേപങ്ങളും യഥാർത്ഥ വ്യക്തിയെ തിരിച്ചറിയുന്ന ഒന്നും പാടില്ല. ഈ നിയമം ലംഘിക്കുന്ന പേരുകൾ നീക്കം ചെയ്യും.';

  @override
  String get leaderboardRulesAccept => 'മനസ്സിലായി';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return 'അൺലോക്ക് ചെയ്തവ: $unlocked / $total';
  }

  @override
  String get settingsSectionData => 'സേവ് ചെയ്ത ഡാറ്റ';

  @override
  String get gameRotatePiece => 'കഷണം തിരിക്കുക';

  @override
  String get themeClassic => 'ക്ലാസിക്';

  @override
  String get themeFade => 'പാസ്റ്റൽ';

  @override
  String get themeNeon => 'നിയോൺ';

  @override
  String get themeOcean => 'സമുദ്രം';

  @override
  String get themeWood => 'തടി';

  @override
  String get themeSunset => 'സൂര്യാസ്തമയം';

  @override
  String get themeForest => 'കാട്';

  @override
  String get themeAurora => 'അറോറ';

  @override
  String get skinClassic => 'ക്ലാസിക്';

  @override
  String get skinGradient => 'ഗ്രേഡിയന്റ്';

  @override
  String get skinOutline => 'ഔട്ട്‌ലൈൻ';

  @override
  String get skinGlossy => 'തിളക്കം';

  @override
  String get skinStripe => 'വരകൾ';

  @override
  String get skinBevel => 'ചരിവ്';

  @override
  String get skinGlow => 'പ്രഭ';

  @override
  String get skinCrystal => 'ക്രിസ്റ്റൽ';

  @override
  String rewardThemeName(String name) {
    return '$name തീം';
  }

  @override
  String rewardSkinName(String name) {
    return '$name സ്കിൻ';
  }

  @override
  String get skinPulse => 'സ്പന്ദനം';

  @override
  String get skinShimmer => 'മിന്നൽ';

  @override
  String get skinWave => 'തിരമാല';

  @override
  String get skinEmber => 'കനൽ';

  @override
  String get skinPrism => 'പ്രിസം';

  @override
  String get skinStardust => 'നക്ഷത്രപ്പൊടി';

  @override
  String get skinCircuit => 'സർക്യൂട്ട്';

  @override
  String get skinRipple => 'ഓളം';

  @override
  String achievementRewardSkin(String name) {
    return 'ആനിമേറ്റഡ് സ്കിൻ: $name';
  }

  @override
  String skinsAchievementReward(String achievement) {
    return 'നേട്ടത്തിനുള്ള സമ്മാനം: $achievement';
  }

  @override
  String get achievementBackpay =>
      'നേട്ടങ്ങൾക്ക് ഇപ്പോൾ സമ്മാനങ്ങളുണ്ട് — നിങ്ങളുടേത് ചേർത്തു.';

  @override
  String get namePromptBody =>
      'ഒരു പേര് തിരഞ്ഞെടുക്കൂ, നിങ്ങളുടെ മികച്ച സ്കോർ ലീഡർബോർഡിൽ വരും. പേരില്ലാതെ നിങ്ങൾക്ക് അജ്ഞാതമായി കളിക്കുന്നത് തുടരാം.';

  @override
  String get nameTaken => 'ഈ പേര് ഇതിനകം എടുത്തിട്ടുണ്ട്. മറ്റൊന്ന് ശ്രമിക്കൂ.';

  @override
  String get nameCheckFailed =>
      'പേര് പരിശോധിക്കാനായില്ല. നിങ്ങൾ ഓൺലൈനിലാണോ? അൽപ്പസമയം കഴിഞ്ഞ് വീണ്ടും ശ്രമിക്കൂ.';

  @override
  String nameLost(String name) {
    return '$name ഇപ്പോൾ മറ്റൊരു കളിക്കാരന്റേതാണ്. സൗജന്യമായി പുതിയ പേര് തിരഞ്ഞെടുക്കൂ.';
  }

  @override
  String get themeCandy => 'കാൻഡി';

  @override
  String get themeVolcano => 'അഗ്നിപർവതം';

  @override
  String get themeGlacier => 'ഹിമാനി';

  @override
  String get skinPixel => 'പിക്സൽ';

  @override
  String get skinMarble => 'മാർബിൾ';

  @override
  String get skinJelly => 'ജെല്ലി';

  @override
  String get skinLiquid => 'ദ്രാവകം';

  @override
  String get skinFizz => 'കുമിളകൾ';

  @override
  String get skinPlasma => 'പ്ലാസ്മ';

  @override
  String get designsTitle => 'ഡിസൈനുകൾ';

  @override
  String get designsNotEnoughDiamonds => 'ആവശ്യത്തിന് വജ്രങ്ങളില്ല.';

  @override
  String get designsOwned => 'നിങ്ങളുടേത്';

  @override
  String get designsAchievementOnly => 'നേട്ടം';

  @override
  String get designsSupporterOnly => 'സപ്പോർട്ടർ';

  @override
  String get designsPreview => 'പ്രിവ്യൂ';

  @override
  String get designsGetDiamonds => 'വജ്രങ്ങൾ നേടൂ';

  @override
  String get shopDealTitle => 'ഇന്നത്തെ ഓഫർ';

  @override
  String get shopAnimatedSkins => 'ആനിമേറ്റഡ് സ്കിന്നുകൾ';

  @override
  String get shopNewDesigns => 'പുതിയ ഡിസൈനുകൾ';

  @override
  String get shopDiamonds => 'വജ്രങ്ങൾ';

  @override
  String get shopPacks => 'പായ്ക്കുകൾ';

  @override
  String get shopPopular => 'ജനപ്രിയം';

  @override
  String get shopBestValue => 'മികച്ച മൂല്യം';

  @override
  String get shopDiamondsBlurb =>
      'ആനിമേറ്റഡ് സ്കിന്നുകൾക്കും പുതിയ ഡിസൈനുകൾക്കും.';

  @override
  String get shopCoinsBlurb => 'തീമുകൾക്കും സ്കിന്നുകൾക്കും ബൂസ്റ്ററുകൾക്കും.';

  @override
  String get shopNeonBlurb => 'നിയോൺ തീം ഉടൻ അൺലോക്ക് ചെയ്യുന്നു.';

  @override
  String get shopRenameBlurb => 'ലീഡർബോർഡിലെ നിങ്ങളുടെ പേര് മാറ്റൂ.';

  @override
  String shopHoursLeft(int hours) {
    return '$hours മണിക്കൂർ ബാക്കി';
  }

  @override
  String shopNewDealIn(String time) {
    return 'പുതിയ ഓഫർ $time കഴിഞ്ഞ്';
  }

  @override
  String shopDesignUnlocked(String name) {
    return '$name അൺലോക്ക് ചെയ്തു!';
  }

  @override
  String get questsTitle => 'ക്വസ്റ്റുകൾ';

  @override
  String get questsDaily => 'ദിവസേന';

  @override
  String get questsWeekly => 'ആഴ്ചതോറും';

  @override
  String get questsMonthly => 'മാസംതോറും';

  @override
  String questsNewIn(String time) {
    return 'പുതിയ ക്വസ്റ്റുകൾ $time കഴിഞ്ഞ്';
  }

  @override
  String get questsBonus => 'എല്ലാത്തിനും ബോണസ്';

  @override
  String get questsBonusEarned => 'ബോണസ് ലഭിച്ചു';

  @override
  String get questRounds => 'റൗണ്ടുകൾ കളിക്കൂ';

  @override
  String get questLines => 'വരികൾ മായ്ക്കൂ';

  @override
  String get questPieces => 'കഷണങ്ങൾ വയ്ക്കൂ';

  @override
  String get questDailyChallenge => 'പ്രതിദിന ചലഞ്ച് കളിക്കൂ';

  @override
  String get questPuzzles => 'പുതിയ പസിലുകൾ പരിഹരിക്കൂ';

  @override
  String get questDays => 'വ്യത്യസ്ത ദിവസങ്ങളിൽ കളിക്കൂ';

  @override
  String get questDailySets => 'എല്ലാ ദിവസേന ക്വസ്റ്റുകളും പൂർത്തിയാക്കൂ';

  @override
  String get questsSetDaily => 'എല്ലാ ദിവസേന ക്വസ്റ്റുകളും പൂർത്തിയായി!';

  @override
  String get questsSetWeekly =>
      'എല്ലാ ആഴ്ചതോറുമുള്ള ക്വസ്റ്റുകളും പൂർത്തിയായി!';

  @override
  String get questsSetMonthly =>
      'എല്ലാ മാസംതോറുമുള്ള ക്വസ്റ്റുകളും പൂർത്തിയായി!';

  @override
  String get leaderboardTabScore => 'മികച്ച സ്കോർ';

  @override
  String get leaderboardTabPuzzle => 'പസിൽ നക്ഷത്രങ്ങൾ';

  @override
  String get leaderboardPuzzleAutoSubmit =>
      'നിങ്ങളുടെ പസിൽ നക്ഷത്രങ്ങൾ സ്വയം അയയ്ക്കപ്പെടും.';

  @override
  String leaderboardPuzzleSubmitting(int stars) {
    return 'നിങ്ങളുടെ പസിൽ നക്ഷത്രങ്ങൾ ($stars) അയയ്ക്കുന്നു …';
  }

  @override
  String get dailyGoalTitle => 'ഇന്നത്തെ ലക്ഷ്യം';

  @override
  String dailyGoalPoints(String points) {
    return '$points പോയിന്റ്';
  }

  @override
  String get dailyChestOpened => 'സ്ട്രീക്ക് പെട്ടി തുറന്നു!';

  @override
  String dailyNextChest(int day) {
    return 'അടുത്ത പെട്ടി: സ്ട്രീക്കിന്റെ ദിവസം $day';
  }

  @override
  String get dailyExplainer =>
      'ഇന്ന് എല്ലാവരും ഒരേ ബോർഡിലാണ് കളിക്കുന്നത്, നിങ്ങളുടെ ആദ്യ റൗണ്ടാണ് കണക്കാക്കുന്നത്. അധിക നാണയങ്ങൾക്കായി നക്ഷത്ര അടയാളങ്ങളിൽ എത്തുക, വജ്രപ്പെട്ടികൾക്കായി സ്ട്രീക്ക് നിലനിർത്തുക, ഇന്ന് നിങ്ങൾ എത്രാം സ്ഥാനത്താണെന്ന് കാണുക.';

  @override
  String dailyRank(int rank, int total) {
    return 'ഇന്ന് $total പേരിൽ സ്ഥാനം $rank';
  }

  @override
  String get dailyRankNeedsName => 'റാങ്കിംഗിൽ കാണാൻ ഒരു പേര് തിരഞ്ഞെടുക്കുക.';

  @override
  String get dailyRankingButton => 'ഇന്നത്തെ റാങ്കിംഗ്';

  @override
  String get leaderboardTabDaily => 'ഇന്നത്തെ ചലഞ്ച്';

  @override
  String get leaderboardDailyFooter =>
      'എല്ലാവർക്കും ഒരേ ബോർഡ്, ആദ്യ റൗണ്ട് കണക്കാക്കും. ദിവസവും പുതിയ റാങ്കിംഗ്.';

  @override
  String notificationChestBody(int diamonds) {
    return 'ഇന്നത്തെ ചലഞ്ച് കളിച്ച് സ്ട്രീക്ക് പെട്ടി തുറക്കൂ: $diamonds 💎';
  }

  @override
  String get themePumpkin => 'മത്തങ്ങ';

  @override
  String get skinGhost => 'പ്രേതം';

  @override
  String get halloweenTitle => 'ഹാലോവീൻ';

  @override
  String get halloweenBody => 'മത്തങ്ങ തീമും പ്രേത സ്കിനും — ഒക്ടോബറിൽ മാത്രം.';

  @override
  String get designsBackInOctober => 'ഒക്ടോബറിൽ വീണ്ടും';

  @override
  String get shopFreeTitle => 'സൗജന്യ ബോണസ്';

  @override
  String get shopFreeWatch => 'വീഡിയോ കാണുക';

  @override
  String shopFreeToday(int left, int total) {
    return 'ഇന്ന്: $left/$total';
  }

  @override
  String get shopFreeTomorrow => 'നാളെ വീണ്ടും';

  @override
  String get designsAccessories => 'ആക്‌സസറികൾ';

  @override
  String get designsBursts => 'സ്ഫോടനങ്ങൾ';

  @override
  String get accessoryNone => 'ഒന്നുമില്ല';

  @override
  String get accessoryCobweb => 'ചിലന്തിവല';

  @override
  String get accessorySnowCap => 'മഞ്ഞുതൊപ്പി';

  @override
  String get accessoryCrown => 'കിരീടം';

  @override
  String get accessoryFlower => 'പൂവ്';

  @override
  String get accessorySparkle => 'തിളക്കം';

  @override
  String get accessoryDewdrop => 'മഞ്ഞുതുള്ളി';

  @override
  String get burstClassic => 'ക്ലാസിക്';

  @override
  String get burstConfetti => 'കോൺഫെറ്റി';

  @override
  String get burstFire => 'തീ';

  @override
  String get burstPixels => 'പിക്സലുകൾ';

  @override
  String get burstStars => 'നക്ഷത്രങ്ങൾ';

  @override
  String get burstBubbles => 'കുമിളകൾ';

  @override
  String bestShareText(String score) {
    return 'Qubble-ൽ എന്റെ പുതിയ റെക്കോർഡ്: $score പോയിന്റ്! നിങ്ങൾക്ക് ഇത് മറികടക്കാനാകുമോ?';
  }
}
