// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Gujarati (`gu`).
class L10nGu extends L10n {
  L10nGu([String locale = 'gu']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'રમો';

  @override
  String get commonLater => 'પછી';

  @override
  String get commonNotNow => 'હમણાં નહીં';

  @override
  String get commonCancel => 'રદ કરો';

  @override
  String get commonBuy => 'ખરીદો';

  @override
  String get commonSave => 'સાચવો';

  @override
  String get commonCollect => 'મેળવો';

  @override
  String get nameNewName => 'નવું નામ';

  @override
  String get nameFieldLabel => 'નામ';

  @override
  String get piggyFullTitle => 'ગલ્લો ભરાઈ ગયો!';

  @override
  String get piggyKeepSaving => 'બચત ચાલુ રાખો';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$coins / $capacity એકત્ર થયા.';
  }

  @override
  String get homeContinueRun => 'ચાલુ રાખો';

  @override
  String get homeVideo => 'વીડિયો';

  @override
  String get commonGotIt => 'સમજાયું';

  @override
  String get commonHome => 'હોમ';

  @override
  String get commonScore => 'સ્કોર';

  @override
  String get commonBest => 'શ્રેષ્ઠ';

  @override
  String commonLevelShort(int level) {
    return 'લેવલ $level';
  }

  @override
  String get homeNewRun => 'નવી રમત શરૂ કરો';

  @override
  String get homeBackToExit => 'બહાર નીકળવા માટે ફરીથી પાછળ દબાવો';

  @override
  String get homeEnableLeaderboard => 'લીડરબોર્ડમાં જોડાઓ';

  @override
  String get homeBestScore => 'શ્રેષ્ઠ સ્કોર';

  @override
  String get homeDailyChallenge => 'દૈનિક પડકાર';

  @override
  String get homeDailyOpenToday => 'આજે ખુલ્લો';

  @override
  String homeDailyNextIn(String time) {
    return 'આગલો પડકાર: $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return '$streak દિવસની સ્ટ્રીક';
  }

  @override
  String get homeLeaderboard => 'લીડરબોર્ડ';

  @override
  String get homePuzzleMode => 'પઝલ મોડ';

  @override
  String get homeMissions => 'મિશન';

  @override
  String get homeThemes => 'થીમ્સ';

  @override
  String get homeSkins => 'સ્કિન્સ';

  @override
  String get homeHowToPlay => 'Qubble કેવી રીતે રમવું';

  @override
  String get homeWeekendBonus => 'વીકએન્ડ: બમણા સિક્કા!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'લેવલ $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'નામ બદલો';

  @override
  String get nameChangeExplainer =>
      'તમારું નામ લીડરબોર્ડ પર તમારી ઓળખ છે, તેથી તે નિશ્ચિત છે. તમે એક વખત નામ બદલવાની સુવિધા ખરીદી શકો છો.';

  @override
  String get nameChangeAfterPurchase =>
      'ખરીદી પછી, બદલવા માટે તમારા નામ પર ફરીથી ટૅપ કરો.';

  @override
  String get nameJoinedLeaderboard => 'હવે તમે લીડરબોર્ડ પર છો.';

  @override
  String get nameRenameUnavailable => 'હમણાં નામ બદલી શકાતું નથી.';

  @override
  String nameProblemTooShort(int min) {
    return 'ઓછામાં ઓછા અક્ષર: $min.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'વધુમાં વધુ અક્ષર: $max.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'માત્ર અંગ્રેજી અક્ષરો (A–Z), અંકો, જગ્યા, _ અને -.';

  @override
  String get nameProblemOffensive => 'કૃપા કરીને બીજું નામ પસંદ કરો.';

  @override
  String get piggyTitle => 'ગલ્લો';

  @override
  String get piggyFillingHint => 'તમે હરોળ સાફ કરો તેમ તમારો ગલ્લો ભરાય છે.';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins સિક્કા મફતમાં મેળવો.',
      one: '$coins સિક્કો મફતમાં મેળવો.',
    );
    return '$_temp0';
  }

  @override
  String get piggyEarlyOpenHint =>
      'ભરાઈ જાય પછી તમે તેને મફતમાં ખાલી કરી શકો છો — અથવા બોનસ વીડિયોથી વહેલો ખોલી શકો છો.';

  @override
  String get piggyOpenNow => 'હમણાં ખોલો';

  @override
  String get gameNewPiecesVideo => 'નવા ટુકડા (વીડિયો)';

  @override
  String get gameTapBoardCell => 'બોર્ડ પરના કોઈ ખાના પર ટૅપ કરો';

  @override
  String get gameDailyChallengeLabel => 'દૈનિક પડકાર';

  @override
  String get gameOver => 'રમત પૂરી';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'બૉમ્બ માટે જોઈતા વધારાના સિક્કા: $missing.';
  }

  @override
  String get gameBombNotHere => 'બૉમ્બ હમણાં અહીં કામ કરતો નથી.';

  @override
  String gameNeedsCoins(String missing) {
    return 'આ માટે જોઈતા વધારાના સિક્કા: $missing.';
  }

  @override
  String get gameNotRightNow => 'હમણાં શક્ય નથી.';

  @override
  String get gameRunSaved => 'રમત સચવાઈ — મેનૂમાં \"ચાલુ રાખો\".';

  @override
  String get gameOverNoFit => 'તમારો કોઈ ટુકડો હવે બોર્ડ પર બેસતો નથી.';

  @override
  String get gameOverNoFitNoRotations =>
      'કોઈ ટુકડો બેસતો નથી — અને ફેરવવાની તકો પણ પૂરી થઈ ગઈ.';

  @override
  String get gameStarterOfferUnavailable => 'હમણાં ઉપલબ્ધ નથી';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — મેળવો';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'કૉમ્બો x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'સિદ્ધિ: $title';
  }

  @override
  String get gameBestSubmitted => 'નવો શ્રેષ્ઠ — મોકલાયો';

  @override
  String get gameReviveFor => 'રમવાનું ચાલુ રાખો · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'અનલૉક થયું: $name';
  }

  @override
  String get gameStarterOfferTitle => 'સ્ટાર્ટર પૅક';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score પૉઇન્ટ્સ',
      one: '$score પૉઇન્ટ',
    );
    return '$_temp0';
  }

  @override
  String get gameNewRecord => 'નવો રેકોર્ડ!';

  @override
  String gameStreakDays(int streak) {
    return '$streak દિવસની સ્ટ્રીક';
  }

  @override
  String get gameDoubleCoins => 'સિક્કા બમણા કરો';

  @override
  String get gameDoubleDaily => 'દૈનિક ઇનામ બમણું કરો';

  @override
  String get gamePlayAgain => 'ફરીથી રમો';

  @override
  String gameLevelReached(int level) {
    return 'લેવલ $level પર પહોંચ્યા!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return '+$count લેવલ — લેવલ $level!';
  }

  @override
  String get gameStarterOfferReward => '1200 સિક્કા + લાકડું થીમ';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'માત્ર $hours કલાક બાકી — એક જ વાર!';
  }

  @override
  String get boosterUndo => 'પાછું';

  @override
  String get boosterSwap => 'બદલો';

  @override
  String get boosterBomb => 'બૉમ્બ';

  @override
  String get boosterNoRotationsLeft =>
      'ફેરવવાની તક બાકી નથી — ફરી મેળવવા હરોળ સાફ કરો!';

  @override
  String get onboardingDragPiece => 'એક બ્લૉકને ગ્રિડ પર ખેંચો';

  @override
  String get onboardingFillLine => 'આખી હરોળ કે સ્તંભ ભરો';

  @override
  String get onboardingLinesClear => 'ભરેલી લાઇન ગાયબ થાય છે — પૉઇન્ટ્સ!';

  @override
  String get coachHintCombo => 'કૉમ્બો! તેને જાળવવા 3 ચાલમાં ફરી સાફ કરો';

  @override
  String get coachHintFever => 'ફીવર! ચમકે ત્યાં સુધી બમણા પૉઇન્ટ્સ';

  @override
  String get coachHintRotation =>
      'ફેરવવામાં એક ચાર્જ વપરાય છે — સાફ કરવાથી તે ફરી ભરાય છે';

  @override
  String get coachHintBooster => 'ટિપ: નીચે બૂસ્ટર વાપરી શકો છો';

  @override
  String get coachHintStrategy =>
      'ટિપ: બધી લાઇન એકસાથે નહીં — મોટા ટુકડા માટે જગ્યા રાખો';

  @override
  String get dailyStreakLabel => 'સ્ટ્રીક';

  @override
  String get dailyBestLabel => 'દૈનિક શ્રેષ્ઠ';

  @override
  String dailyHistoryNote(int days) {
    return 'છેલ્લા $days દિવસ સચવાય છે.';
  }

  @override
  String dailyDayPlayed(int day) {
    return 'દિવસ $day: રમ્યા';
  }

  @override
  String dailyDayMissed(int day) {
    return 'દિવસ $day: ન રમ્યા';
  }

  @override
  String get homeDailyCalendar => 'કૅલેન્ડર';

  @override
  String get dailyShareButton => 'પરિણામ શેર કરો';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · દૈનિક પડકાર $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return 'પૉઇન્ટ્સ: $score · શ્રેષ્ઠ કૉમ્બો x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'રમો: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    return 'કૉમ્બો: હજી $moves ચાલ બાકી';
  }

  @override
  String get dailyShareCopied => 'પરિણામ ક્લિપબોર્ડ પર કૉપિ થયું';

  @override
  String get adNotAvailable =>
      'હમણાં કોઈ વીડિયો નથી — થોડી વાર પછી ફરી પ્રયાસ કરો';

  @override
  String get howToPlaySpeedTitle => 'ઝડપ બોનસ';

  @override
  String get howToPlaySpeedBody =>
      'ઝડપથી મૂકવાથી દરેક સફાઈમાં 30 % સુધી ઉમેરાય છે. બોનસ 1.5 થી 4 સેકન્ડ વચ્ચે ઘટે છે અને તેની મર્યાદા છે, તેથી ઝડપ ફાયદો આપે છે પણ રમત નક્કી નથી કરતી — ધ્યાનથી ધીમે રમાયેલી રમત ઉતાવળી ઝડપી રમતને હજી હરાવી શકે છે.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'ઝડપ બોનસ $percent ટકા';
  }

  @override
  String get iapDiamondsSmall => '100 હીરા';

  @override
  String get iapDiamondsMedium => '350 હીરા';

  @override
  String get iapDiamondsLarge => '1,000 હીરા';

  @override
  String get howToPlayTitle => 'Qubble કેવી રીતે રમવું';

  @override
  String get howToPlayIntroHeadline => 'શરૂ કરવી સરળ.\nઆગળનું વિચારનારને ઇનામ.';

  @override
  String get howToPlayIntroBody => 'બોર્ડ ખાલી રાખો અને તમારો રેકોર્ડ તોડો.';

  @override
  String get howToPlayIntroSemantics =>
      'રમતનો ઉદ્દેશ. બોર્ડ ખાલી રાખો અને તમારો રેકોર્ડ તોડો.';

  @override
  String get howToPlayDragTitle => 'ખેંચો અને મૂકો';

  @override
  String get howToPlayDragBody =>
      'ત્રણ ટુકડામાંથી એકને ખાલી ખાના પર ખેંચો. ત્રણેય વપરાઈ જાય પછી, આપમેળે ત્રણ નવા મળે છે.';

  @override
  String get howToPlayClearTitle => 'લાઇન સાફ કરો';

  @override
  String get howToPlayClearBody =>
      'આખી હરોળ કે સ્તંભ ભરો. ભરેલી લાઇન ગાયબ થઈને આગલી ચાલ માટે જગ્યા બનાવે છે.';

  @override
  String get howToPlayComboTitle => 'કૉમ્બો જોડો';

  @override
  String get howToPlayComboBody =>
      'ત્રણ ચાલમાં બીજી લાઇન સાફ કરો. દરેક વધારાનો કૉમ્બો તમારો પૉઇન્ટ ગુણક વધારે છે. કૉમ્બો સેકન્ડ નહીં, ચાલ ગણે છે, તેથી તમે વિચારતા હો ત્યારે તે ક્યારેય પૂરો થતો નથી.';

  @override
  String get howToPlayFeverTitle => 'ફીવર જગાવો';

  @override
  String get howToPlayFeverBody =>
      'સફાઈથી ફીવર મીટર ભરાય છે. તે ભરાઈ જાય ત્યારે, આગલો વિસ્ફોટ બમણો ગણાય છે — મોટી સફાઈનું અગાઉથી આયોજન કરો.';

  @override
  String get howToPlayBoosterTitle => 'બૂસ્ટર સમજદારીથી વાપરો';

  @override
  String get howToPlayBoosterBody =>
      'બૂસ્ટર મુશ્કેલ રમતો બચાવે છે. નીચેના ટુકડા પર ટૅપ કરીને તેને ફેરવી પણ શકો છો.';

  @override
  String get howToPlayDailyTitle => 'દૈનિક પડકાર અને સ્ટ્રીક';

  @override
  String get howToPlayDailyBody =>
      'દૈનિક પડકારમાં બધાને સમાન ટુકડા મળે છે. તમારી સ્ટ્રીક અને બોનસ વધારવા દરરોજ રમો.';

  @override
  String get howToPlayPiggyTitle => 'ગલ્લો ભરો';

  @override
  String get howToPlayPiggyBody =>
      'સાફ થયેલી દરેક લાઇન તમારો ગલ્લો ભરે છે. તે ભરાઈ જાય ત્યારે, સિક્કા મફતમાં મેળવી શકો છો.';

  @override
  String get leaderboardTitle => 'લીડરબોર્ડ';

  @override
  String get leaderboardUnreachable =>
      'લીડરબોર્ડ ઉપલબ્ધ નથી.\nઇન્ટરનેટ કનેક્શન સાથે ફરી પ્રયાસ કરો.';

  @override
  String get leaderboardEmpty => 'હજી કોઈ એન્ટ્રી નથી.\nપ્રથમ બનો!';

  @override
  String leaderboardSubmitting(int score) {
    return 'તમારો શ્રેષ્ઠ સ્કોર ($score) મોકલાઈ રહ્યો છે …';
  }

  @override
  String get leaderboardAutoSubmit => 'તમારો શ્રેષ્ઠ સ્કોર આપમેળે મોકલાય છે.';

  @override
  String get puzzleModeTitle => 'પઝલ મોડ';

  @override
  String puzzleLevelTitle(int level) {
    return 'પઝલ $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'ચાલ: $moves   •   લક્ષ્ય: 3 સ્ટાર માટે $target';
  }

  @override
  String get puzzleSolved => 'ઉકેલાયું!';

  @override
  String get puzzleLeaveTitle => 'પઝલ છોડવી છે?';

  @override
  String get puzzleLeaveBody => 'આ પઝલમાંની તમારી પ્રગતિ ગુમાશે.';

  @override
  String get puzzleKeepPlaying => 'રમવાનું ચાલુ રાખો';

  @override
  String get puzzleLeave => 'છોડો';

  @override
  String get puzzleStuckTitle => 'અટકી ગયા';

  @override
  String get puzzleRestart => 'ફરી શરૂ કરો';

  @override
  String get commonActive => 'સક્રિય';

  @override
  String get commonTapToActivate => 'સક્રિય કરવા ટૅપ કરો';

  @override
  String get commonRestore => 'પુનઃસ્થાપિત કરો';

  @override
  String unlockForCost(int cost) {
    return 'અનલૉક માટે $cost';
  }

  @override
  String get skinsExchangeGold => 'સોનું બદલો';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'ટુકડો ફેરવો';

  @override
  String get puzzleNextLevel => 'આગલું લેવલ';

  @override
  String get puzzleBackToOverview => 'યાદીમાં પાછા';

  @override
  String get puzzleUnsolvable => 'અહીંથી હવે બોર્ડ ખાલી કરી શકાશે નહીં.';

  @override
  String get puzzleExtraMoveVideo => 'વધારાની ચાલ (વીડિયો)';

  @override
  String puzzleSolvedCount(int solved) {
    return 'ઉકેલાયેલ: $solved';
  }

  @override
  String get settingsTitle => 'સેટિંગ્સ';

  @override
  String get storageFailureTitle => 'Qubble તમારી સાચવેલી રમત લોડ કરી શકતી નથી';

  @override
  String get storageFailureBody =>
      'કૃપા કરીને ઍપ ફરી શરૂ કરો. ભૂલ ચાલુ રહે, તો માત્ર ફરીથી ઇન્સ્ટૉલ કરવાથી મદદ મળશે. સેટિંગ્સ › પ્રતિસાદમાંથી તેની જાણ કરી શકો છો.';

  @override
  String get iapUnavailable => 'આ ઑફર હમણાં ઉપલબ્ધ નથી.';

  @override
  String get iapFailed => 'ખરીદી પૂર્ણ ન થઈ. કંઈ ચાર્જ થયું નથી.';

  @override
  String get settingsResetProgress => 'પ્રગતિ રીસેટ કરો';

  @override
  String get settingsResetProgressSubtitle =>
      'સ્કોર, સિક્કા, લેવલ અને પ્રગતિ શરૂઆતમાં પાછા. ખરીદીઓ, નામ અને સજાવટ રહે છે.';

  @override
  String get settingsResetConfirmTitle => 'પ્રગતિ રીસેટ કરવી છે?';

  @override
  String get settingsResetConfirmBody =>
      'શ્રેષ્ઠ સ્કોર, સિક્કા, લેવલ, સ્ટ્રીક અને બધી પ્રગતિ કાઢી નખાશે. આ પાછું લઈ શકાશે નહીં.\n\nતમારી ખરીદીઓ, તમારું નામ અને અનલૉક કરેલી થીમ્સ અને સ્કિન્સ રહે છે.';

  @override
  String get settingsResetConfirmAction => 'રીસેટ';

  @override
  String get settingsResetDone => 'પ્રગતિ રીસેટ થઈ.';

  @override
  String get settingsSectionGame => 'રમત';

  @override
  String get settingsSectionSoundHaptics => 'અવાજ અને વાઇબ્રેશન';

  @override
  String get settingsSectionReminders => 'રિમાઇન્ડર';

  @override
  String get settingsSectionPurchases => 'ખરીદીઓ';

  @override
  String get settingsSectionHelpOut => 'મદદ કરો';

  @override
  String get settingsSectionLegal => 'કાનૂની';

  @override
  String get settingsSectionLanguage => 'ભાષા';

  @override
  String get settingsGuide => 'કેવી રીતે રમવું';

  @override
  String get settingsGuideSubtitle => 'નિયમો, કૉમ્બો, ફીવર અને બૂસ્ટર';

  @override
  String get settingsSound => 'અવાજ';

  @override
  String get settingsMusic => 'સંગીત';

  @override
  String get settingsHaptics => 'વાઇબ્રેશન';

  @override
  String get settingsHapticsOff => 'બંધ';

  @override
  String get settingsHapticsLight => 'હળવું';

  @override
  String get settingsHapticsStrong => 'મજબૂત';

  @override
  String get settingsSectionAccessibility => 'આરામ';

  @override
  String get settingsReducedEffects => 'ઓછી ઇફેક્ટ્સ';

  @override
  String get settingsReducedEffectsHint =>
      'ઓછા કણો, સ્ક્રીન ધ્રુજારી નહીં, ચમક નહીં';

  @override
  String get settingsNotifications => 'સૂચનાઓ';

  @override
  String get settingsNotificationsSubtitle =>
      'દૈનિક રિમાઇન્ડર અને સ્ટ્રીક રક્ષણ';

  @override
  String get settingsNotificationsSystemHint =>
      'સિસ્ટમ સેટિંગ્સમાં મંજૂરી આપો.';

  @override
  String get settingsLanguageSystem => 'સિસ્ટમ ભાષા';

  @override
  String get settingsSupporterThanks => 'સમર્થક — આભાર!';

  @override
  String get settingsSupporterPack => 'સમર્થક પૅક';

  @override
  String get settingsSupporterPackSubtitle =>
      'ખાસ થીમ અને સ્કિન + 1,500 સિક્કા';

  @override
  String get settingsRestorePurchases => 'ખરીદીઓ પુનઃસ્થાપિત કરો';

  @override
  String get settingsRestoring => 'ખરીદીઓ પુનઃસ્થાપિત થઈ રહી છે…';

  @override
  String get settingsRateApp => 'ઍપને રેટ કરો';

  @override
  String get settingsRateAppSubtitle => 'સ્ટોરમાં રેટિંગ આપો';

  @override
  String get settingsStoreUnavailable => 'આ ડિવાઇસ પર સ્ટોર ઉપલબ્ધ નથી.';

  @override
  String get settingsFeedback => 'પ્રતિસાદ મોકલો';

  @override
  String get settingsFeedbackSubtitle =>
      'વિચારો અને ભૂલો જણાવો (GitHub દ્વારા)';

  @override
  String get settingsAdPrivacy => 'જાહેરાત ગોપનીયતા';

  @override
  String get settingsAdPrivacySubtitle => 'તમારી જાહેરાત સંમતિ જુઓ અથવા બદલો';

  @override
  String get settingsAdPrivacyUnavailable =>
      'આ ડિવાઇસ પર જાહેરાત વિકલ્પોની જરૂર નથી.';

  @override
  String get settingsPrivacy => 'ગોપનીયતા નીતિ';

  @override
  String get settingsImprint => 'કાનૂની માહિતી';

  @override
  String get settingsPageOpenFailed => 'પેજ ખોલી શકાયું નહીં.';

  @override
  String get settingsFooter => 'Qubble • ઑફલાઇન બ્લૉક પઝલ';

  @override
  String get settingsAdminSection => 'ઍડમિન (ટેસ્ટ)';

  @override
  String get settingsAdminEnabled => 'ઍડમિન મોડ ચાલુ';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'ઍડમિન મોડ માટે વધુ $count વાર ટૅપ કરો';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins સિક્કા',
      one: '$coins સિક્કો',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'માત્ર પરીક્ષણ માટે — રિલીઝ સ્ક્રીનશૉટમાં ક્યારેય નહીં';

  @override
  String settingsAdminAddCoins(int amount) {
    String _temp0 = intl.Intl.pluralLogic(
      amount,
      locale: localeName,
      other: '$amount સિક્કા',
      one: '$amount સિક્કો',
    );
    return '+$_temp0';
  }

  @override
  String get settingsAdminResetCoins => 'સિક્કા 0 કરો';

  @override
  String get feedbackTitle => 'પ્રતિસાદ';

  @override
  String get feedbackIntroShort =>
      'તમને શું ગમે છે, શું ખટકે છે, શું ખૂટે છે? નાની વાતો પણ મદદ કરે છે — જેટલું ચોક્કસ, એટલું સારું.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'માત્ર $build અને તમારા ડિવાઇસનો પ્રકાર જોડાય છે — જેથી મને ખબર પડે કે તમે કયા વર્ઝનની વાત કરો છો.';
  }

  @override
  String get feedbackSendByMail => 'ઇમેઇલથી મોકલો';

  @override
  String get feedbackPreferGithub => 'GitHub issue પસંદ કરું છું';

  @override
  String get feedbackThanksMail => 'આભાર! બસ સંદેશ મોકલી દો.';

  @override
  String get feedbackNoMailApp =>
      'કોઈ મેઇલ ઍપ મળી નહીં. નીચેનો GitHub રસ્તો અજમાવો.';

  @override
  String get feedbackEmptyHint => 'કૃપા કરીને પહેલાં કંઈક લખો.';

  @override
  String get leaderboardRefresh => 'રિફ્રેશ';

  @override
  String get leaderboardRetry => 'ફરી પ્રયાસ કરો';

  @override
  String get feedbackHint => 'તમારો પ્રતિસાદ…';

  @override
  String get feedbackSubmit => 'પ્રતિસાદ મોકલો';

  @override
  String get feedbackOpenFailed => 'GitHub ખોલી શકાયું નહીં. પછીથી પ્રયાસ કરો.';

  @override
  String get feedbackGithubNote =>
      'GitHub ખૂલશે — ત્યાં \"Submit new issue\" પર ટૅપ કરો. (એક વાર GitHub લૉગિન જરૂરી છે.)';

  @override
  String get shopTitle => 'શૉપ';

  @override
  String get shopWebDemoNote =>
      'ખરીદીઓ માત્ર Play Store ઍપમાં ઉપલબ્ધ છે. આ વેબ વર્ઝન મફત ડેમો છે — તેમ છતાં અહીં બધું રમી શકો છો.';

  @override
  String get shopSupporterExplainer =>
      'Qubble ફરજિયાત જાહેરાતો બતાવતી નથી — તમારે ક્યારેય કંઈ ખરીદવું પડતું નથી. સમર્થક પૅક (ઑરોરા થીમ, ક્રિસ્ટલ સ્કિન, 1,500 સિક્કા, સમર્થક બૅજ) રમતને ટેકો આપવા બદલ આભાર છે. ખરીદીઓ તમારા સ્ટોર એકાઉન્ટ સાથે જોડાયેલી છે અને ગમે ત્યારે પુનઃસ્થાપિત કરી શકાય છે.';

  @override
  String get shopSupporterContents =>
      'ઑરોરા થીમ + ક્રિસ્ટલ સ્કિન + 1,500 સિક્કા';

  @override
  String get themesTitle => 'થીમ્સ';

  @override
  String get themesSupporterOnly => 'માત્ર સમર્થક પૅકમાં (શૉપ જુઓ)';

  @override
  String get themesInSupporterPack => 'સમર્થક પૅકમાં';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'પૂરતા સિક્કા નથી ($cost જોઈએ, તમારી પાસે $coins)';
  }

  @override
  String get skinsTitle => 'બ્લૉક સ્કિન્સ';

  @override
  String get skinsNotEnoughDiamonds => 'પૂરતા હીરા નથી (નીચે સોનું બદલો)';

  @override
  String get skinsNotEnoughCoins => 'પૂરતા સિક્કા નથી';

  @override
  String get skinsNotEnoughGold => 'પૂરતું સોનું નથી.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold સોનું = 1 હીરો. હીરા સૌથી સુંદર સ્કિન્સ અનલૉક કરે છે — ધીરજથી એકત્ર કરો.';
  }

  @override
  String get statsTitle => 'આંકડા';

  @override
  String get statsAverageScore => 'સરેરાશ સ્કોર';

  @override
  String get statsBestCombo => 'શ્રેષ્ઠ કૉમ્બો';

  @override
  String get statsGames => 'રમતો';

  @override
  String get statsLinesCleared => 'સાફ કરેલી હરોળ';

  @override
  String get statsPiecesPlaced => 'મૂકેલા ટુકડા';

  @override
  String get statsCoins => 'સિક્કા';

  @override
  String get missionsTitle => 'મિશન';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString ટુકડા મૂકો',
      one: '$countString ટુકડો મૂકો',
    );
    return '$_temp0';
  }

  @override
  String missionClearRows(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString હરોળ સાફ કરો';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'x$countString કૉમ્બો મેળવો';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'એક રમતમાં $countString પૉઇન્ટ્સ પાર કરો',
      one: 'એક રમતમાં $countString પૉઇન્ટ પાર કરો',
    );
    return '$_temp0';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString રમતો રમો',
      one: '$countString રમત રમો',
    );
    return '$_temp0';
  }

  @override
  String get achievementsTitle => 'સિદ્ધિઓ';

  @override
  String get achievementFirstGameTitle => 'પહેલી રમત';

  @override
  String get achievementFirstGameBody => 'તમારી પહેલી રમત રમો';

  @override
  String get achievementGames25Title => 'નિયમિત';

  @override
  String get achievementGames25Body => '25 રમતો રમો';

  @override
  String get achievementGames100Title => 'રસિયા';

  @override
  String get achievementGames100Body => '100 રમતો રમો';

  @override
  String get achievementScore1kTitle => 'ચઢનાર';

  @override
  String get achievementScore1kBody => '1,000 પૉઇન્ટ્સ મેળવો';

  @override
  String get achievementScore5kTitle => 'પ્રો';

  @override
  String get achievementScore5kBody => '5,000 પૉઇન્ટ્સ મેળવો';

  @override
  String get achievementScore10kTitle => 'માસ્ટર';

  @override
  String get achievementScore10kBody => '10,000 પૉઇન્ટ્સ મેળવો';

  @override
  String get achievementScore25kTitle => 'દંતકથા';

  @override
  String get achievementScore25kBody => '25,000 પૉઇન્ટ્સ મેળવો';

  @override
  String get achievementLines100Title => 'વ્યવસ્થિત';

  @override
  String get achievementLines100Body => 'કુલ 100 હરોળ સાફ કરો';

  @override
  String get achievementLines1000Title => 'મોટી સફાઈ';

  @override
  String get achievementLines1000Body => 'કુલ 1,000 હરોળ સાફ કરો';

  @override
  String get achievementCombo5Title => 'કૉમ્બો શરૂઆત';

  @override
  String get achievementCombo5Body => 'x5 કૉમ્બો મેળવો';

  @override
  String get achievementCombo10Title => 'કૉમ્બો રાજા';

  @override
  String get achievementCombo10Body => 'x10 કૉમ્બો મેળવો';

  @override
  String get achievementLevel10Title => 'અનુભવી';

  @override
  String get achievementLevel10Body => 'લેવલ 10 પર પહોંચો';

  @override
  String get achievementLevel20Title => 'પીઢ';

  @override
  String get achievementLevel20Body => 'લેવલ 20 પર પહોંચો';

  @override
  String get achievementStreak7Title => 'સાપ્તાહિક સ્ટ્રીક';

  @override
  String get achievementStreak7Body => '7 દિવસની દૈનિક સ્ટ્રીક';

  @override
  String get achievementStreak30Title => 'માસિક સ્ટ્રીક';

  @override
  String get achievementStreak30Body => '30 દિવસની દૈનિક સ્ટ્રીક';

  @override
  String get achievementPuzzles10Title => 'પઝલર';

  @override
  String get achievementPuzzles10Body => '10 પઝલ ઉકેલો';

  @override
  String get achievementPieces5000Title => 'બિલ્ડર';

  @override
  String get achievementPieces5000Body => '5,000 ટુકડા મૂકો';

  @override
  String streakRepairTitle(int streak) {
    return '$streak દિવસની સ્ટ્રીક જોખમમાં!';
  }

  @override
  String get streakRepairBody => 'ગઈકાલે રમ્યા નહીં — તમારી સ્ટ્રીક બચાવો:';

  @override
  String get streakRepairFailed => 'સુધારવું શક્ય નથી.';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins સિક્કા',
      one: '$coins સિક્કો',
    );
    return 'ફરી સ્વાગત છે! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'રિમાઇન્ડર?';

  @override
  String get notificationsOptInBody =>
      'તમારી દૈનિક પઝલની યાદ અપાવીએ અને તમારી સ્ટ્રીક બચાવીએ? તમે આ ગમે ત્યારે સેટિંગ્સમાં બદલી શકો છો.';

  @override
  String get notificationsOptInAccept => 'હા, કૃપા કરીને';

  @override
  String get notificationChannelDescription =>
      'દૈનિક રિમાઇન્ડર, સ્ટ્રીક ચેતવણી, પાછા આવો';

  @override
  String get notificationDailyTitle => 'તમારી દૈનિક પઝલ રાહ જુએ છે 🧩';

  @override
  String get notificationDailyBody => 'આજનો પડકાર રમો!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 તમારી $streak દિવસની સ્ટ્રીક જોખમમાં!';
  }

  @override
  String get notificationStreakBody => 'તેને જાળવવા આજે રમો.';

  @override
  String get notificationComebackTitle => 'તમારા બ્લૉક્સ રાહ જુએ છે 🧩';

  @override
  String get notificationComebackBody => 'પાછા આવો અને ભેટ મેળવો!';

  @override
  String get iapSupporterPack => 'સમર્થક પૅક';

  @override
  String get iapCoinsSmall => '500 સિક્કા';

  @override
  String get iapCoinsMedium => '2,000 સિક્કા';

  @override
  String get iapCoinsLarge => '6,000 સિક્કા';

  @override
  String get iapStarterPack => 'સ્ટાર્ટર પૅક';

  @override
  String get iapRename => 'નામ બદલાવ';

  @override
  String get iapNeonTheme => 'નિયોન થીમ';

  @override
  String get settingsLeaderboardDelete => 'લીડરબોર્ડ એન્ટ્રી કાઢો';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'તમારું નામ અને સ્કોર જાહેર યાદીમાંથી દૂર કરે છે';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'તમારી એન્ટ્રી કાઢવી છે?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'તમારું નામ અને સ્કોર લીડરબોર્ડમાંથી દૂર થશે. તમારી રમતની પ્રગતિ બદલાશે નહીં. તમે ગમે ત્યારે લીડરબોર્ડમાં ફરી જોડાઈ શકો છો.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'તમારી લીડરબોર્ડ એન્ટ્રી કાઢી નખાઈ.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'એન્ટ્રી કાઢી શકાઈ નહીં. કનેક્શન તપાસો અને ફરી પ્રયાસ કરો.';

  @override
  String get leaderboardReport => 'આ નામની જાણ કરો';

  @override
  String get leaderboardBlock => 'છુપાવો';

  @override
  String leaderboardBlocked(String name) {
    return '$name તમારા માટે છુપાવાયું';
  }

  @override
  String get leaderboardUndo => 'પૂર્વવત્ કરો';

  @override
  String leaderboardBlockedCount(int count) {
    return 'તમે છુપાવેલી એન્ટ્રી: $count';
  }

  @override
  String get leaderboardUnblockAll => 'ફરી બતાવો';

  @override
  String get leaderboardReportUnavailable => 'હમણાં જાણ કરી શકાતી નથી.';

  @override
  String get leaderboardReportSent => 'આભાર — તમારી જાણ મોકલાઈ.';

  @override
  String get leaderboardRules =>
      'નામ જાહેર છે. અપમાન, અપશબ્દો અને કોઈ વાસ્તવિક વ્યક્તિને ઓળખાવે તેવું કંઈ નહીં. આ નિયમ તોડતાં નામ દૂર કરાય છે.';

  @override
  String get leaderboardRulesAccept => 'સમજાયું';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return 'અનલૉક: $unlocked / $total';
  }

  @override
  String get settingsSectionData => 'સાચવેલો ડેટા';

  @override
  String get gameRotatePiece => 'ટુકડો ફેરવો';

  @override
  String get themeClassic => 'ક્લાસિક';

  @override
  String get themeFade => 'પેસ્ટલ';

  @override
  String get themeNeon => 'નિયોન';

  @override
  String get themeOcean => 'સમુદ્ર';

  @override
  String get themeWood => 'લાકડું';

  @override
  String get themeSunset => 'સૂર્યાસ્ત';

  @override
  String get themeForest => 'જંગલ';

  @override
  String get themeAurora => 'ઑરોરા';

  @override
  String get skinClassic => 'ક્લાસિક';

  @override
  String get skinGradient => 'ગ્રેડિયન્ટ';

  @override
  String get skinOutline => 'આઉટલાઇન';

  @override
  String get skinGlossy => 'ચળકતું';

  @override
  String get skinStripe => 'પટ્ટા';

  @override
  String get skinBevel => 'ઢાળ';

  @override
  String get skinGlow => 'ચમક';

  @override
  String get skinCrystal => 'ક્રિસ્ટલ';

  @override
  String rewardThemeName(String name) {
    return '$name થીમ';
  }

  @override
  String rewardSkinName(String name) {
    return '$name સ્કિન';
  }

  @override
  String get skinPulse => 'ધબકાર';

  @override
  String get skinShimmer => 'ઝગમગાટ';

  @override
  String get skinWave => 'લહેર';

  @override
  String get skinEmber => 'અંગારા';

  @override
  String get skinPrism => 'પ્રિઝમ';

  @override
  String get skinStardust => 'તારાની રજ';

  @override
  String get skinCircuit => 'સર્કિટ';

  @override
  String get skinRipple => 'તરંગ';

  @override
  String achievementRewardSkin(String name) {
    return 'એનિમેટેડ સ્કિન: $name';
  }

  @override
  String skinsAchievementReward(String achievement) {
    return 'સિદ્ધિનું ઇનામ: $achievement';
  }

  @override
  String get achievementBackpay =>
      'હવે સિદ્ધિઓ ઇનામ આપે છે — તમારાં ઇનામ ઉમેરાઈ ગયાં છે.';
}
