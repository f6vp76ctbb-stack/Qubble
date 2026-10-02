// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Azerbaijani (`az`).
class L10nAz extends L10n {
  L10nAz([String locale = 'az']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Oyna';

  @override
  String get commonLater => 'Sonra';

  @override
  String get commonNotNow => 'İndi yox';

  @override
  String get commonCancel => 'Ləğv et';

  @override
  String get commonBuy => 'Satın al';

  @override
  String get commonSave => 'Yadda saxla';

  @override
  String get commonCollect => 'Topla';

  @override
  String get nameNewName => 'Yeni ad';

  @override
  String get nameFieldLabel => 'Ad';

  @override
  String get piggyFullTitle => 'Pul qutusu doldu!';

  @override
  String get piggyKeepSaving => 'Yığmağa davam et';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$capacity sikkədən $coins yığıldı.';
  }

  @override
  String get homeContinueRun => 'Davam et';

  @override
  String get homeVideo => 'Video';

  @override
  String get commonGotIt => 'Aydındır';

  @override
  String get commonHome => 'Ana səhifə';

  @override
  String get commonScore => 'XAL';

  @override
  String get commonBest => 'REKORD';

  @override
  String commonLevelShort(int level) {
    return 'Səviyyə $level';
  }

  @override
  String get homeNewRun => 'Yeni oyuna başla';

  @override
  String get homeBackToExit => 'Çıxmaq üçün yenidən geri düyməsinə bas';

  @override
  String get homeEnableLeaderboard => 'Reytinqə qoşul';

  @override
  String get homeBestScore => 'REKORD';

  @override
  String get homeDailyChallenge => 'Gündəlik çağırış';

  @override
  String get homeDailyOpenToday => 'Bu gün səni gözləyir';

  @override
  String homeDailyNextIn(String time) {
    return 'Növbəti çağırış: $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return '$streak günlük seriya';
  }

  @override
  String get homeLeaderboard => 'Reytinq';

  @override
  String get homePuzzleMode => 'Tapmaca rejimi';

  @override
  String get homeHowToPlay => 'Qubble necə oynanılır';

  @override
  String get homeWeekendBonus => 'Həftəsonu: ikiqat sikkə!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Səviyyə $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Adını dəyiş';

  @override
  String get nameChangeExplainer =>
      'Adın reytinqdəki kimliyindir, ona görə də sabitdir. Birdəfəlik ad dəyişikliyi satın ala bilərsən.';

  @override
  String get nameChangeAfterPurchase =>
      'Satın aldıqdan sonra dəyişmək üçün adına yenidən toxun.';

  @override
  String get nameJoinedLeaderboard => 'Artıq reytinqdəsən.';

  @override
  String nameProblemTooShort(int min) {
    return 'Ən azı $min simvol.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'Ən çoxu $max simvol.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Yalnız latın hərfləri (A–Z, ə, ş, ç, ğ, ı, ö, ü daxil), rəqəmlər, boşluq, _ və -.';

  @override
  String get nameProblemOffensive => 'Zəhmət olmasa, başqa ad seç.';

  @override
  String get piggyTitle => 'Pul qutusu';

  @override
  String get piggyFillingHint => 'Sətirləri təmizlədikcə pul qutun dolur.';

  @override
  String piggyCollect(int coins) {
    return '$coins sikkəni pulsuz topla.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Dolanda onu pulsuz boşalda bilərsən — ya da bonus videosu ilə daha tez aça bilərsən.';

  @override
  String get piggyOpenNow => 'İndi aç';

  @override
  String get gameNewPiecesVideo => 'Yeni fiqurlar (video)';

  @override
  String get gameTapBoardCell => 'Lövhədə bir xanaya toxun';

  @override
  String get gameDailyChallengeLabel => 'GÜNDƏLİK ÇAĞIRIŞ';

  @override
  String get gameOver => 'Oyun bitdi';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Bomba üçün daha $missing sikkə lazımdır.';
  }

  @override
  String get gameBombNotHere => 'Bomba hazırda burada işləmir.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Bunun üçün daha $missing sikkə lazımdır.';
  }

  @override
  String get gameNotRightNow => 'Hazırda mümkün deyil.';

  @override
  String get gameRunSaved => 'Oyun yadda saxlandı — menyuda “Davam et”.';

  @override
  String get gameOverNoFit => 'Fiqurlarından heç biri artıq lövhəyə sığmır.';

  @override
  String get gameOverNoFitNoRotations =>
      'Fiqurlarından heç biri sığmır — fırlatma haqların da bitdi.';

  @override
  String get gameStarterOfferUnavailable => 'Hazırda əlçatan deyil';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — al';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'KOMBO x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Nailiyyət: $title';
  }

  @override
  String get gameBestSubmitted => 'Yeni rekord göndərildi';

  @override
  String get gameReviveFor => 'Davam et · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Açıldı: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Başlanğıc paketi';

  @override
  String gameOverPoints(int score) {
    return '$score xal';
  }

  @override
  String get gameNewRecord => 'Yeni rekord!';

  @override
  String gameStreakDays(int streak) {
    return '$streak günlük seriya';
  }

  @override
  String get gameDoubleCoins => 'Sikkələri ikiqat et';

  @override
  String get gameDoubleDaily => 'Gündəlik mükafatı ikiqat et';

  @override
  String get gamePlayAgain => 'Yenidən oyna';

  @override
  String gameLevelReached(int level) {
    return 'Yeni səviyyə: $level!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return '$count səviyyə qalxdın — səviyyə $level!';
  }

  @override
  String get gameStarterOfferReward => '1200 sikkə + Taxta mövzusu';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'Cəmi $hours saat qaldı — birdəfəlik!';
  }

  @override
  String get boosterUndo => 'Geri al';

  @override
  String get boosterSwap => 'Dəyiş';

  @override
  String get boosterBomb => 'Bomba';

  @override
  String get boosterNoRotationsLeft =>
      'Fırlatma haqqı qalmadı — yeniləmək üçün sətir təmizlə!';

  @override
  String get onboardingDragPiece => 'Bir bloku lövhəyə sürüşdür';

  @override
  String get onboardingFillLine => 'Bir sətri və ya sütunu tam doldur';

  @override
  String get onboardingLinesClear => 'Dolu xətlər yox olur — xal!';

  @override
  String get coachHintCombo =>
      'Kombo! Saxlamaq üçün 3 gediş ərzində yenə təmizlə';

  @override
  String get coachHintFever => 'ALOV! Parıldadıqca ikiqat xal';

  @override
  String get coachHintRotation =>
      'Fırlatmaq bir haqq aparır — təmizləmək onu yeniləyir';

  @override
  String get coachHintBooster =>
      'İpucu: aşağıda gücləndiricilərdən istifadə edə bilərsən';

  @override
  String get coachHintStrategy =>
      'İpucu: hər xətti dərhal təmizləmə — böyük fiqurlara yer saxla';

  @override
  String get dailyStreakLabel => 'Seriya';

  @override
  String get dailyBestLabel => 'Gündəlik rekord';

  @override
  String dailyHistoryNote(int days) {
    return 'Son $days gün saxlanılır.';
  }

  @override
  String dailyDayPlayed(int day) {
    return 'Gün $day: oynanılıb';
  }

  @override
  String dailyDayMissed(int day) {
    return 'Gün $day: oynanılmayıb';
  }

  @override
  String get homeDailyCalendar => 'Təqvim';

  @override
  String get dailyShareButton => 'Nəticəni paylaş';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Gündəlik çağırış $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return '$score xal · ən yaxşı kombo x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Oyna: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    return 'Kombo: $moves gediş qaldı';
  }

  @override
  String get dailyShareCopied => 'Nəticə mübadilə buferinə kopyalandı';

  @override
  String get adNotAvailable =>
      'Hazırda video yoxdur — bir azdan yenidən cəhd et';

  @override
  String get howToPlaySpeedTitle => 'Sürət bonusu';

  @override
  String get howToPlaySpeedBody =>
      'Tez yerləşdirmək hər təmizlənən xəttə 30 %-ə qədər əlavə edir. Bonus 1,5 ilə 4 saniyə arasında azalır və yuxarı həddi var: sürətli olmaq qazandırır, amma oyunu həll etmir — sakit və diqqətli oyun tələsik oyunu yenə də keçə bilər.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return '$percent faiz sürət bonusu';
  }

  @override
  String get iapDiamondsSmall => '100 almaz';

  @override
  String get iapDiamondsMedium => '350 almaz';

  @override
  String get iapDiamondsLarge => '1.000 almaz';

  @override
  String get howToPlayTitle => 'Qubble necə oynanılır';

  @override
  String get howToPlayIntroHeadline =>
      'Başlamaq asandır.\nƏvvəlcədən düşünən qazanır.';

  @override
  String get howToPlayIntroBody => 'Lövhəni boş saxla və rekordunu yenilə.';

  @override
  String get howToPlayIntroSemantics =>
      'Oyunun məqsədi. Lövhəni boş saxla və rekordunu yenilə.';

  @override
  String get howToPlayDragTitle => 'Sürüşdür və yerləşdir';

  @override
  String get howToPlayDragBody =>
      'Üç fiqurdan birini boş xanalara sürüşdür. Üçünü də istifadə edəndə avtomatik olaraq üç yeni fiqur gəlir.';

  @override
  String get howToPlayClearTitle => 'Xətləri təmizlə';

  @override
  String get howToPlayClearBody =>
      'Bir sətri və ya sütunu tam doldur. Dolu xətlər yox olur və növbəti gedişin üçün yer açılır.';

  @override
  String get howToPlayComboTitle => 'Kombo zənciri qur';

  @override
  String get howToPlayComboBody =>
      'Üç gediş ərzində daha bir xətt təmizlə. Hər yeni kombo xal əmsalını artırır. Kombo saniyələri yox, gedişləri sayır; düşünərkən heç vaxt bitmir.';

  @override
  String get howToPlayFeverTitle => 'Alovu yandır';

  @override
  String get howToPlayFeverBody =>
      'Təmizləmələr alov göstəricisini doldurur. Göstərici dolanda növbəti partlayış ikiqat sayılır — böyük təmizləmələri əvvəlcədən planla.';

  @override
  String get howToPlayBoosterTitle => 'Gücləndiricilərdən ağılla istifadə et';

  @override
  String get howToPlayBoosterBody =>
      'Gücləndiricilər çətin oyunları xilas edir. Aşağıdakı fiqura toxunaraq onu fırlada da bilərsən.';

  @override
  String get howToPlayDailyTitle => 'Gündəlik çağırış və seriya';

  @override
  String get howToPlayDailyBody =>
      'Gündəlik çağırışda hamı eyni fiqurlarla oynayır. Seriyanı və bonusunu böyütmək üçün hər gün oyna.';

  @override
  String get howToPlayPiggyTitle => 'Pul qutusunu doldur';

  @override
  String get howToPlayPiggyBody =>
      'Təmizlənən hər xətt pul qutunu doldurur. Dolanda sikkələri pulsuz toplaya bilərsən.';

  @override
  String get leaderboardTitle => 'Reytinq';

  @override
  String get leaderboardUnreachable =>
      'Reytinq əlçatan deyil.\nİnternet bağlantısı ilə yenidən cəhd et.';

  @override
  String get leaderboardEmpty => 'Hələ heç kim yoxdur.\nBirinci sən ol!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Rekordun ($score) göndərilir …';
  }

  @override
  String get leaderboardAutoSubmit => 'Rekordun avtomatik göndərilir.';

  @override
  String get puzzleModeTitle => 'Tapmaca rejimi';

  @override
  String puzzleLevelTitle(int level) {
    return 'Tapmaca $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Gedişlər: $moves   •   Hədəf: 3 ulduz üçün $target';
  }

  @override
  String get puzzleSolved => 'Həll olundu!';

  @override
  String get puzzleLeaveTitle => 'Tapmacadan çıxılsın?';

  @override
  String get puzzleLeaveBody => 'Bu tapmacadakı irəliləyişin itəcək.';

  @override
  String get puzzleKeepPlaying => 'Oynamağa davam et';

  @override
  String get puzzleLeave => 'Çıx';

  @override
  String get puzzleStuckTitle => 'Çıxılmaz vəziyyət';

  @override
  String get puzzleRestart => 'Yenidən başla';

  @override
  String get commonActive => 'Aktiv';

  @override
  String get commonRestore => 'Bərpa et';

  @override
  String get skinsExchangeGold => 'Qızılı dəyiş';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Fiquru fırlat';

  @override
  String get puzzleNextLevel => 'Növbəti səviyyə';

  @override
  String get puzzleBackToOverview => 'Siyahıya qayıt';

  @override
  String get puzzleUnsolvable => 'Buradan lövhəni artıq boşaltmaq olmur.';

  @override
  String get puzzleExtraMoveVideo => 'Əlavə gediş (video)';

  @override
  String get puzzleHintVideo => 'İpucu (video)';

  @override
  String get puzzleHintVideoCost => 'İpucu (video, bir ulduz aparır)';

  @override
  String get puzzleNoHint =>
      'Buradan ipucu vermək mümkün deyil. Tapmacanı yenidən başla.';

  @override
  String puzzleSolvedCount(int solved) {
    return '$solved həll olunub';
  }

  @override
  String get settingsTitle => 'Parametrlər';

  @override
  String get storageFailureTitle =>
      'Qubble yadda saxlanmış oyununu yükləyə bilmir';

  @override
  String get storageFailureBody =>
      'Zəhmət olmasa, tətbiqi yenidən başlat. Xəta davam edərsə, yalnız yenidən quraşdırmaq kömək edir. Xətanı Parametrlər › Rəy bölməsindən bildirə bilərsən.';

  @override
  String get iapUnavailable => 'Bu təklif hazırda əlçatan deyil.';

  @override
  String get iapFailed => 'Satınalma tamamlanmadı. Heç bir ödəniş tutulmadı.';

  @override
  String get settingsResetProgress => 'İrəliləyişi sıfırla';

  @override
  String get settingsResetProgressSubtitle =>
      'Xal, sikkələr, səviyyə və irəliləyiş başlanğıca qayıdır. Satınalmalar, ad və kosmetika qalır.';

  @override
  String get settingsResetConfirmTitle => 'İrəliləyiş sıfırlansın?';

  @override
  String get settingsResetConfirmBody =>
      'Rekord, sikkələr, səviyyə, seriya və bütün irəliləyiş silinəcək. Bunu geri qaytarmaq olmaz.\n\nSatınalmaların, adın və açdığın mövzular ilə görünüşlər qalır.';

  @override
  String get settingsResetConfirmAction => 'Sıfırla';

  @override
  String get settingsResetDone => 'İrəliləyiş sıfırlandı.';

  @override
  String get settingsSectionGame => 'Oyun';

  @override
  String get settingsSectionSoundHaptics => 'Səs və vibrasiya';

  @override
  String get settingsSectionReminders => 'Xatırlatmalar';

  @override
  String get settingsSectionPurchases => 'Satınalmalar';

  @override
  String get settingsSectionHelpOut => 'Dəstək ol';

  @override
  String get settingsSectionLegal => 'Hüquqi';

  @override
  String get settingsSectionLanguage => 'Dil';

  @override
  String get settingsGuide => 'Necə oynanılır';

  @override
  String get settingsGuideSubtitle =>
      'Qaydalar, kombolar, alov və gücləndiricilər';

  @override
  String get settingsSound => 'Səs';

  @override
  String get settingsMusic => 'Musiqi';

  @override
  String get settingsHaptics => 'Vibrasiya';

  @override
  String get settingsHapticsOff => 'Sönülü';

  @override
  String get settingsHapticsLight => 'Yüngül';

  @override
  String get settingsHapticsStrong => 'Güclü';

  @override
  String get settingsSectionAccessibility => 'Rahatlıq';

  @override
  String get settingsReducedEffects => 'Azaldılmış effektlər';

  @override
  String get settingsReducedEffectsHint =>
      'Daha az hissəcik, ekran silkələnməsi və parıltı yoxdur';

  @override
  String get settingsNotifications => 'Bildirişlər';

  @override
  String get settingsNotificationsSubtitle =>
      'Gündəlik xatırlatma və seriyanın qorunması';

  @override
  String get settingsNotificationsSystemHint =>
      'Sistem parametrlərində icazə ver.';

  @override
  String get settingsLanguageSystem => 'Sistem dili';

  @override
  String get settingsSupporterThanks => 'Dəstəkçi — təşəkkürlər!';

  @override
  String get settingsSupporterPack => 'Dəstəkçi paketi';

  @override
  String get settingsSupporterPackSubtitle =>
      'Xüsusi mövzu və görünüş + 1.500 sikkə';

  @override
  String get settingsRestorePurchases => 'Satınalmaları bərpa et';

  @override
  String get settingsRestoring => 'Satınalmalar bərpa olunur…';

  @override
  String get settingsRateApp => 'Tətbiqi qiymətləndir';

  @override
  String get settingsRateAppSubtitle => 'Mağazada qiymət ver';

  @override
  String get settingsStoreUnavailable => 'Mağaza bu cihazda əlçatan deyil.';

  @override
  String get settingsFeedback => 'Rəy göndər';

  @override
  String get settingsFeedbackSubtitle =>
      'İdeya və xətaları bildir (GitHub vasitəsilə)';

  @override
  String get settingsAdPrivacy => 'Reklam məxfiliyi';

  @override
  String get settingsAdPrivacySubtitle =>
      'Reklam razılığına bax və ya onu dəyiş';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Bu cihazda reklam seçimləri tələb olunmur.';

  @override
  String get settingsPrivacy => 'Məxfilik siyasəti';

  @override
  String get settingsImprint => 'Hüquqi məlumat';

  @override
  String get settingsPageOpenFailed => 'Səhifəni açmaq mümkün olmadı.';

  @override
  String get settingsFooter => 'Qubble • Oflayn blok tapmacası';

  @override
  String get settingsAdminSection => 'Admin (test)';

  @override
  String get settingsAdminEnabled => 'Admin rejimi aktivdir';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Admin rejimi üçün daha $count dəfə toxun';
  }

  @override
  String settingsAdminCoins(int coins) {
    return '$coins sikkə';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Yalnız test üçün — buraxılış ekran görüntülərində heç vaxt göstərmə';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount sikkə';
  }

  @override
  String get settingsAdminResetCoins => 'Sikkələri 0-a endir';

  @override
  String get feedbackTitle => 'Rəy';

  @override
  String get feedbackIntroShort =>
      'Nəyi sevirsən, nə səni əsəbiləşdirir, nə çatışmır? Kiçik şeylər də kömək edir — nə qədər konkret, o qədər yaxşı.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Yalnız $build və cihazının növü əlavə olunur — hansı versiyadan danışdığını bilməyim üçün.';
  }

  @override
  String get feedbackSendByMail => 'E-poçtla göndər';

  @override
  String get feedbackPreferGithub => 'GitHub issue üstünlük verirəm';

  @override
  String get feedbackThanksMail => 'Təşəkkürlər! İndi sadəcə mesajı göndər.';

  @override
  String get feedbackNoMailApp =>
      'E-poçt tətbiqi tapılmadı. Aşağıdakı GitHub yolunu yoxla.';

  @override
  String get feedbackEmptyHint => 'Zəhmət olmasa, əvvəlcə nəsə yaz.';

  @override
  String get leaderboardRefresh => 'Yenilə';

  @override
  String get leaderboardRetry => 'Yenidən cəhd et';

  @override
  String get feedbackHint => 'Rəyin…';

  @override
  String get feedbackSubmit => 'Rəy göndər';

  @override
  String get feedbackOpenFailed => 'GitHub açılmadı. Sonra yenidən cəhd et.';

  @override
  String get feedbackGithubNote =>
      'GitHub açılır — orada \"Submit new issue\" düyməsinə toxun. (Birdəfəlik GitHub girişi tələb olunur.)';

  @override
  String get shopTitle => 'Mağaza';

  @override
  String get shopWebDemoNote =>
      'Satınalmalar yalnız Play Store-dakı tətbiqdə mümkündür. Bu veb versiya pulsuz demodur — yenə də hər şeyi burada oynaya bilərsən.';

  @override
  String get shopSupporterExplainer =>
      'Qubble məcburi reklam göstərmir — heç nə almağa məcbur deyilsən. Dəstəkçi paketi (Aurora mövzusu, Kristal görünüşü, 1.500 sikkə, dəstəkçi nişanı) oyunu dəstəklədiyin üçün təşəkkürdür. Satınalmalar mağaza hesabına bağlıdır və istənilən vaxt bərpa oluna bilər.';

  @override
  String get shopSupporterContents =>
      'Aurora mövzusu + Kristal görünüşü + 1.500 sikkə';

  @override
  String get themesTitle => 'Mövzular';

  @override
  String get themesSupporterOnly => 'Yalnız dəstəkçi paketində (mağazaya bax)';

  @override
  String get skinsTitle => 'Blok görünüşləri';

  @override
  String get skinsNotEnoughCoins => 'Sikkə kifayət deyil';

  @override
  String get skinsNotEnoughGold => 'Qızıl kifayət deyil.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold qızıl = 1 almaz. Almazlar ən gözəl görünüşləri açır — yığmağa tələsmə.';
  }

  @override
  String get statsTitle => 'Statistika';

  @override
  String get statsAverageScore => 'Orta xal';

  @override
  String get statsBestCombo => 'Ən yaxşı kombo';

  @override
  String get statsGames => 'Oyunlar';

  @override
  String get statsLinesCleared => 'Təmizlənən sətirlər';

  @override
  String get statsPiecesPlaced => 'Yerləşdirilən fiqurlar';

  @override
  String get statsCoins => 'Sikkələr';

  @override
  String questCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'x$countString komboya çat';
  }

  @override
  String questScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Bir oyunda $countString xalı keç';
  }

  @override
  String get achievementsTitle => 'Nailiyyətlər';

  @override
  String get achievementFirstGameTitle => 'İlk oyun';

  @override
  String get achievementFirstGameBody => 'İlk oyununu oyna';

  @override
  String get achievementGames25Title => 'Daimi oyunçu';

  @override
  String get achievementGames25Body => '25 oyun oyna';

  @override
  String get achievementGames100Title => 'Aludəçi';

  @override
  String get achievementGames100Body => '100 oyun oyna';

  @override
  String get achievementScore1kTitle => 'Yüksələn';

  @override
  String get achievementScore1kBody => '1.000 xala çat';

  @override
  String get achievementScore5kTitle => 'Peşəkar';

  @override
  String get achievementScore5kBody => '5.000 xala çat';

  @override
  String get achievementScore10kTitle => 'Usta';

  @override
  String get achievementScore10kBody => '10.000 xala çat';

  @override
  String get achievementScore25kTitle => 'Əfsanə';

  @override
  String get achievementScore25kBody => '25.000 xala çat';

  @override
  String get achievementLines100Title => 'Səliqəli';

  @override
  String get achievementLines100Body => 'Cəmi 100 sətir təmizlə';

  @override
  String get achievementLines1000Title => 'Böyük təmizlik';

  @override
  String get achievementLines1000Body => 'Cəmi 1.000 sətir təmizlə';

  @override
  String get achievementCombo5Title => 'Kombo şagirdi';

  @override
  String get achievementCombo5Body => 'x5 komboya çat';

  @override
  String get achievementCombo10Title => 'Kombo kralı';

  @override
  String get achievementCombo10Body => 'x10 komboya çat';

  @override
  String get achievementLevel10Title => 'Təcrübəli';

  @override
  String get achievementLevel10Body => '10-cu səviyyəyə çat';

  @override
  String get achievementLevel20Title => 'Veteran';

  @override
  String get achievementLevel20Body => '20-ci səviyyəyə çat';

  @override
  String get achievementStreak7Title => 'Həftəlik seriya';

  @override
  String get achievementStreak7Body => 'Gündəlik çağırışda 7 günlük seriya';

  @override
  String get achievementStreak30Title => 'Aylıq seriya';

  @override
  String get achievementStreak30Body => 'Gündəlik çağırışda 30 günlük seriya';

  @override
  String get achievementPuzzles10Title => 'Tapmaca ustası';

  @override
  String get achievementPuzzles10Body => '10 tapmaca həll et';

  @override
  String get achievementPieces5000Title => 'İnşaatçı';

  @override
  String get achievementPieces5000Body => '5.000 fiqur yerləşdir';

  @override
  String streakRepairTitle(int streak) {
    return '$streak günlük seriyan təhlükədədir!';
  }

  @override
  String get streakRepairBody => 'Dünən oynamadın — seriyanı xilas et:';

  @override
  String get streakRepairFailed => 'Bərpa mümkün deyil.';

  @override
  String comebackGift(int coins) {
    return 'Yenidən xoş gəldin! +$coins sikkə';
  }

  @override
  String get notificationsOptInTitle => 'Xatırlatmalar?';

  @override
  String get notificationsOptInBody =>
      'Gündəlik tapmacanı sənə xatırladaq və seriyanı qoruyaq? Bunu istənilən vaxt parametrlərdə dəyişə bilərsən.';

  @override
  String get notificationsOptInAccept => 'Bəli, zəhmət olmasa';

  @override
  String get notificationChannelDescription =>
      'Gündəlik xatırlatma, seriya xəbərdarlığı, geri dönüş';

  @override
  String get notificationDailyTitle => 'Gündəlik tapmacan səni gözləyir 🧩';

  @override
  String get notificationDailyBody => 'Bugünkü çağırışı oyna!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 $streak günlük seriyan təhlükədədir!';
  }

  @override
  String get notificationStreakBody => 'Seriyanı qorumaq üçün bu gün oyna.';

  @override
  String get notificationComebackTitle => 'Blokların səni gözləyir 🧩';

  @override
  String get notificationComebackBody => 'Geri qayıt və hədiyyəni götür!';

  @override
  String get iapSupporterPack => 'Dəstəkçi paketi';

  @override
  String get iapCoinsSmall => '500 sikkə';

  @override
  String get iapCoinsMedium => '2.000 sikkə';

  @override
  String get iapCoinsLarge => '6.000 sikkə';

  @override
  String get iapStarterPack => 'Başlanğıc paketi';

  @override
  String get iapRename => 'Ad dəyişikliyi';

  @override
  String get iapNeonTheme => 'Neon mövzusu';

  @override
  String get settingsLeaderboardDelete => 'Reytinq qeydini sil';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Adını və xalını ictimai siyahıdan silir';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'Qeydin silinsin?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Adın və xalın reytinqdən silinəcək. Oyundakı irəliləyişin dəyişmir. Reytinqə istənilən vaxt yenidən qoşula bilərsən.';

  @override
  String get settingsLeaderboardDeleteDone => 'Reytinq qeydin silindi.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Qeydi silmək mümkün olmadı. Bağlantını yoxla və yenidən cəhd et.';

  @override
  String get leaderboardReport => 'Bu adı şikayət et';

  @override
  String get leaderboardBlock => 'Blokla';

  @override
  String leaderboardBlocked(String name) {
    return '$name sənin üçün gizlədildi';
  }

  @override
  String get leaderboardUndo => 'Geri al';

  @override
  String leaderboardBlockedCount(int count) {
    return 'Gizlətdiyin qeydlər: $count';
  }

  @override
  String get leaderboardUnblockAll => 'Yenidən göstər';

  @override
  String get leaderboardReportUnavailable =>
      'Hazırda şikayət etmək mümkün deyil.';

  @override
  String get leaderboardReportSent => 'Təşəkkürlər — şikayətin göndərildi.';

  @override
  String get leaderboardRules =>
      'Adlar hamıya açıqdır. Təhqir, alçaldıcı ifadə və real şəxsi tanıdan heç nə olmamalıdır. Bu qaydanı pozan adlar silinir.';

  @override
  String get leaderboardRulesAccept => 'Başa düşdüm';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$total nailiyyətdən $unlocked açılıb';
  }

  @override
  String get settingsSectionData => 'Saxlanılan məlumatlar';

  @override
  String get gameRotatePiece => 'Fiquru fırlat';

  @override
  String get themeClassic => 'Klassik';

  @override
  String get themeFade => 'Pastel';

  @override
  String get themeNeon => 'Neon';

  @override
  String get themeOcean => 'Okean';

  @override
  String get themeWood => 'Taxta';

  @override
  String get themeSunset => 'Gün batımı';

  @override
  String get themeForest => 'Meşə';

  @override
  String get themeAurora => 'Aurora';

  @override
  String get skinClassic => 'Klassik';

  @override
  String get skinGradient => 'Qradiyent';

  @override
  String get skinOutline => 'Kontur';

  @override
  String get skinGlossy => 'Parlaq';

  @override
  String get skinStripe => 'Zolaqlı';

  @override
  String get skinBevel => 'Qabarıq';

  @override
  String get skinGlow => 'Işıltı';

  @override
  String get skinCrystal => 'Kristal';

  @override
  String rewardThemeName(String name) {
    return '$name mövzusu';
  }

  @override
  String rewardSkinName(String name) {
    return '$name görünüşü';
  }

  @override
  String get skinPulse => 'Nəbz';

  @override
  String get skinShimmer => 'Parıltı';

  @override
  String get skinWave => 'Dalğa';

  @override
  String get skinEmber => 'Köz';

  @override
  String get skinPrism => 'Prizma';

  @override
  String get skinStardust => 'Ulduz tozu';

  @override
  String get skinCircuit => 'Dövrə';

  @override
  String get skinRipple => 'Ləpə';

  @override
  String achievementRewardSkin(String name) {
    return 'Animasiyalı görünüş: $name';
  }

  @override
  String skinsAchievementReward(String achievement) {
    return 'Nailiyyət mükafatı: $achievement';
  }

  @override
  String get achievementBackpay =>
      'Nailiyyətlər indi mükafat verir — sənin mükafatların əlavə olundu.';

  @override
  String get namePromptBody =>
      'Ad seç, ən yaxşı nəticən reytinqə düşsün. Adsız anonim oynamağa davam edirsən.';

  @override
  String get nameTaken => 'Bu ad artıq tutulub. Başqasını yoxla.';

  @override
  String get nameCheckFailed =>
      'Adı yoxlamaq mümkün olmadı. İnternetə qoşulusan? Bir azdan yenidən cəhd et.';

  @override
  String nameLost(String name) {
    return '$name artıq başqa oyunçuya məxsusdur. Yeni ad seç – pulsuz.';
  }

  @override
  String get themeCandy => 'Konfet';

  @override
  String get themeVolcano => 'Vulkan';

  @override
  String get themeGlacier => 'Buzlaq';

  @override
  String get skinPixel => 'Piksel';

  @override
  String get skinMarble => 'Mərmər';

  @override
  String get skinJelly => 'Jele';

  @override
  String get skinLiquid => 'Maye';

  @override
  String get skinFizz => 'Köpük';

  @override
  String get skinPlasma => 'Plazma';

  @override
  String get designsTitle => 'Dizaynlar';

  @override
  String get designsNotEnoughDiamonds => 'Almaz kifayət deyil.';

  @override
  String get designsOwned => 'Səndədir';

  @override
  String get designsAchievementOnly => 'Nailiyyət';

  @override
  String get designsSupporterOnly => 'Dəstəkçi';

  @override
  String get designsPreview => 'Önizləmə';

  @override
  String get designsGetDiamonds => 'Almaz əldə et';

  @override
  String get shopDealTitle => 'Günün təklifi';

  @override
  String get shopAnimatedSkins => 'Animasiyalı görünüşlər';

  @override
  String get shopNewDesigns => 'Yeni dizaynlar';

  @override
  String get shopDiamonds => 'Almazlar';

  @override
  String get shopPacks => 'Paketlər';

  @override
  String get shopPopular => 'Populyar';

  @override
  String get shopBestValue => 'Ən sərfəli';

  @override
  String get shopDiamondsBlurb =>
      'Animasiyalı görünüşlər və yeni dizaynlar üçün.';

  @override
  String get shopCoinsBlurb => 'Mövzular, görünüşlər və gücləndiricilər üçün.';

  @override
  String get shopNeonBlurb => 'Neon mövzusunu dərhal açır.';

  @override
  String get shopRenameBlurb => 'Reytinqdəki adını dəyiş.';

  @override
  String shopHoursLeft(int hours) {
    return '$hours saat qalıb';
  }

  @override
  String shopNewDealIn(String time) {
    return 'Yeni təklif: $time sonra';
  }

  @override
  String shopDesignUnlocked(String name) {
    return '$name açıldı!';
  }

  @override
  String get questsTitle => 'Tapşırıqlar';

  @override
  String get questsDaily => 'Gündəlik';

  @override
  String get questsWeekly => 'Həftəlik';

  @override
  String get questsMonthly => 'Aylıq';

  @override
  String questsNewIn(String time) {
    return 'Yeni tapşırıqlar: $time sonra';
  }

  @override
  String get questsBonus => 'Hamısı üçün bonus';

  @override
  String get questsBonusEarned => 'Bonus qazanıldı';

  @override
  String get questRounds => 'Raundlar oyna';

  @override
  String get questLines => 'Sətirləri təmizlə';

  @override
  String get questPieces => 'Fiqurlar yerləşdir';

  @override
  String get questDailyChallenge => 'Gündəlik çağırışı oyna';

  @override
  String get questPuzzles => 'Yeni tapmacalar həll et';

  @override
  String get questDays => 'Müxtəlif günlərdə oyna';

  @override
  String get questDailySets => 'Bütün gündəlik tapşırıqları bitir';

  @override
  String get questsSetDaily => 'Bütün gündəlik tapşırıqlar bitdi!';

  @override
  String get questsSetWeekly => 'Bütün həftəlik tapşırıqlar bitdi!';

  @override
  String get questsSetMonthly => 'Bütün aylıq tapşırıqlar bitdi!';

  @override
  String get leaderboardTabScore => 'Ən yüksək xal';

  @override
  String get leaderboardTabPuzzle => 'Tapmaca ulduzları';

  @override
  String get leaderboardPuzzleAutoSubmit =>
      'Tapmaca ulduzların avtomatik göndərilir.';

  @override
  String leaderboardPuzzleSubmitting(int stars) {
    return 'Tapmaca ulduzların ($stars) göndərilir …';
  }

  @override
  String get dailyGoalTitle => 'Günün hədəfi';

  @override
  String dailyGoalPoints(String points) {
    return '$points xal';
  }

  @override
  String get dailyChestOpened => 'Seriya sandığı açıldı!';

  @override
  String dailyNextChest(int day) {
    return 'Növbəti sandıq: seriya günü $day';
  }

  @override
  String get dailyExplainer =>
      'Bu gün hamı eyni lövhədə oynayır və ilk raundun sayılır. Əlavə sikkələr üçün ulduz həddlərinə çat, almaz sandıqları üçün seriyanı qoru və bu gün neçənci olduğunu gör.';

  @override
  String dailyRank(int rank, int total) {
    return 'Bu gün yerin: $rank / $total';
  }

  @override
  String get dailyRankNeedsName => 'Reytinqdə görünmək üçün ad seç.';

  @override
  String get dailyRankingButton => 'Günün reytinqi';

  @override
  String get leaderboardTabDaily => 'Günün çağırışı';

  @override
  String get leaderboardDailyFooter =>
      'Hamı üçün eyni lövhə, ilk raund sayılır. Hər gün yeni reytinq.';

  @override
  String notificationChestBody(int diamonds) {
    return 'Bugünkü çağırışı oyna və seriya sandığını aç: $diamonds 💎';
  }

  @override
  String get themePumpkin => 'Balqabaq';

  @override
  String get skinGhost => 'Kabus';

  @override
  String get halloweenTitle => 'Halloween';

  @override
  String get halloweenBody =>
      'Balqabaq mövzusu və kabus görünüşü – yalnız oktyabrda.';

  @override
  String get designsBackInOctober => 'Oktyabrda yenidən';

  @override
  String get shopFreeTitle => 'Pulsuz bonus';

  @override
  String get shopFreeWatch => 'Videoya bax';

  @override
  String shopFreeToday(int left, int total) {
    return 'Bu gün: $left/$total';
  }

  @override
  String get shopFreeTomorrow => 'Sabah yenidən';

  @override
  String get designsAccessories => 'Aksesuarlar';

  @override
  String get designsBursts => 'Partlayışlar';

  @override
  String get accessoryNone => 'Yoxdur';

  @override
  String get accessoryCobweb => 'Hörümçək toru';

  @override
  String get accessorySnowCap => 'Qar papağı';

  @override
  String get accessoryCrown => 'Tac';

  @override
  String get accessoryFlower => 'Gül';

  @override
  String get accessorySparkle => 'Parıltı';

  @override
  String get accessoryDewdrop => 'Şeh damlası';

  @override
  String get burstClassic => 'Klassik';

  @override
  String get burstConfetti => 'Konfeti';

  @override
  String get burstFire => 'Od';

  @override
  String get burstPixels => 'Piksellər';

  @override
  String get burstStars => 'Ulduzlar';

  @override
  String get burstBubbles => 'Qabarcıqlar';

  @override
  String bestShareText(String score) {
    return 'Yeni Qubble rekordum: $score xal! Onu keçə bilərsən?';
  }
}
