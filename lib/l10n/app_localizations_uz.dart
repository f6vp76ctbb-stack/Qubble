// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Uzbek (`uz`).
class L10nUz extends L10n {
  L10nUz([String locale = 'uz']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'O‘ynash';

  @override
  String get commonLater => 'Keyinroq';

  @override
  String get commonNotNow => 'Hozir emas';

  @override
  String get commonCancel => 'Bekor qilish';

  @override
  String get commonBuy => 'Sotib olish';

  @override
  String get commonSave => 'Saqlash';

  @override
  String get commonCollect => 'Olish';

  @override
  String get nameNewName => 'Yangi ism';

  @override
  String get nameFieldLabel => 'Ism';

  @override
  String get piggyFullTitle => 'Jamg‘arma qutisi to‘ldi!';

  @override
  String get piggyKeepSaving => 'Jamg‘arishda davom etish';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$capacity tadan $coins tasi yig‘ildi.';
  }

  @override
  String get homeContinueRun => 'Davom etish';

  @override
  String get homeVideo => 'Video';

  @override
  String get commonGotIt => 'Tushunarli';

  @override
  String get commonHome => 'Bosh sahifa';

  @override
  String get commonScore => 'OCHKO';

  @override
  String get commonBest => 'REKORD';

  @override
  String commonLevelShort(int level) {
    return 'Daraja $level';
  }

  @override
  String get homeNewRun => 'Yangi o‘yin boshlash';

  @override
  String get homeBackToExit => 'Chiqish uchun yana bir marta orqaga bosing';

  @override
  String get homeEnableLeaderboard => 'Reytingga qo‘shilish';

  @override
  String get homeBestScore => 'REKORD';

  @override
  String get homeDailyChallenge => 'Kunlik sinov';

  @override
  String get homeDailyOpenToday => 'Bugun ochiq';

  @override
  String homeDailyNextIn(String time) {
    return 'Keyingi sinovgacha: $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return '$streak kunlik seriya';
  }

  @override
  String get homeLeaderboard => 'Reyting';

  @override
  String get homePuzzleMode => 'Boshqotirma rejimi';

  @override
  String get homeHowToPlay => 'Qubble qanday o‘ynaladi';

  @override
  String get homeWeekendBonus => 'Dam olish kunlari: ikki barobar tanga!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Daraja $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Ismni o‘zgartirish';

  @override
  String get nameChangeExplainer =>
      'Ismingiz reytingdagi shaxsingiz, shuning uchun u o‘zgarmaydi. Bir martalik ism almashtirishni sotib olishingiz mumkin.';

  @override
  String get nameChangeAfterPurchase =>
      'Xariddan so‘ng ismingizni o‘zgartirish uchun unga yana bosing.';

  @override
  String get nameJoinedLeaderboard => 'Endi siz reytingdasiz.';

  @override
  String nameProblemTooShort(int min) {
    return 'Kamida $min ta belgi.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'Ko‘pi bilan $max ta belgi.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Faqat lotin harflari (A–Z, é kabi belgililari ham), raqamlar, bo‘sh joy, _ va -.';

  @override
  String get nameProblemOffensive => 'Iltimos, boshqa ism tanlang.';

  @override
  String get piggyTitle => 'Jamg‘arma qutisi';

  @override
  String get piggyFillingHint =>
      'Qatorlarni tozalaganingiz sari jamg‘arma qutisi to‘ladi.';

  @override
  String piggyCollect(int coins) {
    return '$coins tanga oling — bepul.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'To‘lganida uni bepul bo‘shatishingiz mumkin — yoki bonus video bilan oldinroq ochishingiz mumkin.';

  @override
  String get piggyOpenNow => 'Hozir ochish';

  @override
  String get gameNewPiecesVideo => 'Yangi shakllar (video)';

  @override
  String get gameTapBoardCell => 'Maydondagi katakka bosing';

  @override
  String get gameDailyChallengeLabel => 'KUNLIK SINOV';

  @override
  String get gameOver => 'O‘yin tugadi';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Bomba uchun yana $missing tanga kerak.';
  }

  @override
  String get gameBombNotHere => 'Bomba hozir bu yerda ishlamaydi.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Buning uchun yana $missing tanga kerak.';
  }

  @override
  String get gameNotRightNow => 'Hozir imkonsiz.';

  @override
  String get gameRunSaved => 'O‘yin saqlandi — menyuda «Davom etish».';

  @override
  String get gameOverNoFit =>
      'Shakllaringizdan hech biri endi maydonga sig‘maydi.';

  @override
  String get gameOverNoFitNoRotations =>
      'Shakllaringizdan hech biri sig‘maydi — burishlar ham tugadi.';

  @override
  String get gameStarterOfferUnavailable => 'Hozir mavjud emas';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — olish';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'KOMBO x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Yutuq: $title';
  }

  @override
  String get gameBestSubmitted => 'Yangi rekord — yuborildi';

  @override
  String get gameReviveFor => 'O‘yinni davom ettirish · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Ochildi: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Boshlang‘ich to‘plam';

  @override
  String gameOverPoints(int score) {
    return '$score ochko';
  }

  @override
  String get gameNewRecord => 'Yangi rekord!';

  @override
  String gameStreakDays(int streak) {
    return '$streak kunlik seriya';
  }

  @override
  String get gameDoubleCoins => 'Tangalarni ikki barobar qilish';

  @override
  String get gameDoubleDaily => 'Kunlik mukofotni ikki barobar qilish';

  @override
  String get gamePlayAgain => 'Yana o‘ynash';

  @override
  String gameLevelReached(int level) {
    return '$level-darajaga yetdingiz!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return '$count daraja ko‘tarildingiz — $level-daraja!';
  }

  @override
  String get gameStarterOfferReward => '1200 tanga + Yog‘och mavzusi';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'Faqat $hours soat qoldi — bir martalik!';
  }

  @override
  String get boosterUndo => 'Qaytar';

  @override
  String get boosterSwap => 'Almashtir';

  @override
  String get boosterBomb => 'Bomba';

  @override
  String get boosterNoRotationsLeft =>
      'Burishlar qolmadi — to‘ldirish uchun qatorlarni tozalang!';

  @override
  String get onboardingDragPiece => 'Blokni katak maydonga suring';

  @override
  String get onboardingFillLine => 'Butun qator yoki ustunni to‘ldiring';

  @override
  String get onboardingLinesClear => 'To‘la qatorlar yo‘qoladi — ochko!';

  @override
  String get coachHintCombo =>
      'Kombo! Saqlash uchun 3 yurish ichida yana tozalang';

  @override
  String get coachHintFever => 'QIZISH! Yonib turganda ikki barobar ochko';

  @override
  String get coachHintRotation =>
      'Burish bitta zaryad oladi — tozalash uni to‘ldiradi';

  @override
  String get coachHintBooster => 'Maslahat: pastda kuchaytirgichlar bor';

  @override
  String get coachHintStrategy =>
      'Maslahat: hamma qatorni birdan emas — katta shakllarga joy qoldiring';

  @override
  String get dailyStreakLabel => 'Seriya';

  @override
  String get dailyBestLabel => 'Kunlik rekord';

  @override
  String dailyHistoryNote(int days) {
    return 'Oxirgi $days kun saqlanadi.';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day-kun: o‘ynalgan';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day-kun: o‘ynalmagan';
  }

  @override
  String get homeDailyCalendar => 'Taqvim';

  @override
  String get dailyShareButton => 'Natijani ulashish';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Kunlik sinov $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return '$score ochko · eng yaxshi kombo x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'O‘ynang: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    return 'Kombo: $moves ta yurish qoldi';
  }

  @override
  String get dailyShareCopied => 'Natija almashuv buferiga nusxalandi';

  @override
  String get adNotAvailable =>
      'Hozir video yo‘q — birozdan keyin qayta urinib ko‘ring';

  @override
  String get howToPlaySpeedTitle => 'Tezlik bonusi';

  @override
  String get howToPlaySpeedBody =>
      'Tez joylashtirish har bir tozalashga 30 % gacha qo‘shadi. Bonus 1,5 dan 4 soniyagacha kamayib boradi va chegaralangan, shuning uchun tezlik o‘yinni hal qilmasdan foyda beradi — sekin va puxta o‘yin shoshqaloq tez o‘yindan baribir yutishi mumkin.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Tezlik bonusi $percent foiz';
  }

  @override
  String get iapDiamondsSmall => '100 olmos';

  @override
  String get iapDiamondsMedium => '350 olmos';

  @override
  String get iapDiamondsLarge => '1 000 olmos';

  @override
  String get howToPlayTitle => 'Qubble qanday o‘ynaladi';

  @override
  String get howToPlayIntroHeadline =>
      'Boshlash oson.\nOldindan o‘ylaganga mukofot.';

  @override
  String get howToPlayIntroBody =>
      'Maydonni bo‘sh saqlang va rekordingizni yangilang.';

  @override
  String get howToPlayIntroSemantics =>
      'O‘yin maqsadi. Maydonni bo‘sh saqlang va rekordingizni yangilang.';

  @override
  String get howToPlayDragTitle => 'Suring va joylang';

  @override
  String get howToPlayDragBody =>
      'Uchta shakldan birini bo‘sh kataklarga suring. Uchalasi ham ishlatilgach, avtomatik ravishda uchta yangisini olasiz.';

  @override
  String get howToPlayClearTitle => 'Qatorlarni tozalang';

  @override
  String get howToPlayClearBody =>
      'Butun qator yoki ustunni to‘ldiring. To‘la qatorlar yo‘qoladi va keyingi yurishingizga joy ochadi.';

  @override
  String get howToPlayComboTitle => 'Kombolarni ulang';

  @override
  String get howToPlayComboBody =>
      'Uch yurish ichida yana bir qatorni tozalang. Har bir keyingi kombo ochko koeffitsientini oshiradi. Kombo soniyalarni emas, yurishlarni sanaydi, shuning uchun o‘ylayotganingizda u hech qachon tugamaydi.';

  @override
  String get howToPlayFeverTitle => 'Qizishni yoqing';

  @override
  String get howToPlayFeverBody =>
      'Tozalashlar qizish o‘lchagichini to‘ldiradi. U to‘lganda keyingi portlash ikki barobar hisoblanadi — katta tozalashlarni oldindan rejalang.';

  @override
  String get howToPlayBoosterTitle => 'Kuchaytirgichlardan oqilona foydalaning';

  @override
  String get howToPlayBoosterBody =>
      'Kuchaytirgichlar qiyin o‘yinlarni qutqaradi. Shaklni burish uchun lotokdagi shaklga bosishingiz ham mumkin.';

  @override
  String get howToPlayDailyTitle => 'Kunlik sinov va seriya';

  @override
  String get howToPlayDailyBody =>
      'Kunlik sinovda hamma uchun bir xil shakllar bo‘ladi. Seriya va bonusingizni oshirish uchun har kuni o‘ynang.';

  @override
  String get howToPlayPiggyTitle => 'Jamg‘arma qutisini to‘ldiring';

  @override
  String get howToPlayPiggyBody =>
      'Har bir tozalangan qator jamg‘arma qutingizni to‘ldiradi. U to‘lganda tangalarni bepul olishingiz mumkin.';

  @override
  String get leaderboardTitle => 'Reyting';

  @override
  String get leaderboardUnreachable =>
      'Reyting mavjud emas.\nInternetga ulanib qayta urinib ko‘ring.';

  @override
  String get leaderboardEmpty => 'Hali yozuvlar yo‘q.\nBirinchi bo‘ling!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Rekordingiz ($score) yuborilmoqda …';
  }

  @override
  String get leaderboardAutoSubmit => 'Rekordingiz avtomatik yuboriladi.';

  @override
  String get puzzleModeTitle => 'Boshqotirma rejimi';

  @override
  String puzzleLevelTitle(int level) {
    return 'Boshqotirma $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Yurishlar: $moves   •   Maqsad: 3 yulduz uchun $target';
  }

  @override
  String get puzzleSolved => 'Yechildi!';

  @override
  String get puzzleLeaveTitle => 'Boshqotirmadan chiqasizmi?';

  @override
  String get puzzleLeaveBody => 'Bu boshqotirmadagi natijangiz yo‘qoladi.';

  @override
  String get puzzleKeepPlaying => 'O‘yinni davom ettirish';

  @override
  String get puzzleLeave => 'Chiqish';

  @override
  String get puzzleStuckTitle => 'Boshi berk';

  @override
  String get puzzleRestart => 'Qaytadan boshlash';

  @override
  String get commonActive => 'Faol';

  @override
  String get commonRestore => 'Tiklash';

  @override
  String get skinsExchangeGold => 'Oltinni almashtirish';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Shaklni burish';

  @override
  String get puzzleNextLevel => 'Keyingi daraja';

  @override
  String get puzzleBackToOverview => 'Ro‘yxatga qaytish';

  @override
  String get puzzleUnsolvable => 'Bu yerdan maydonni endi bo‘shatib bo‘lmaydi.';

  @override
  String get puzzleExtraMoveVideo => 'Qo‘shimcha yurish (video)';

  @override
  String puzzleSolvedCount(int solved) {
    return '$solved ta yechildi';
  }

  @override
  String get settingsTitle => 'Sozlamalar';

  @override
  String get storageFailureTitle =>
      'Qubble saqlangan o‘yiningizni yuklay olmayapti';

  @override
  String get storageFailureBody =>
      'Iltimos, ilovani qayta ishga tushiring. Xato takrorlansa, faqat qayta o‘rnatish yordam beradi. Bu haqda Sozlamalar › Fikr-mulohaza orqali xabar berishingiz mumkin.';

  @override
  String get iapUnavailable => 'Bu taklif hozir mavjud emas.';

  @override
  String get iapFailed => 'Xarid amalga oshmadi. Hech narsa yechilmadi.';

  @override
  String get settingsResetProgress => 'Natijalarni tiklash';

  @override
  String get settingsResetProgressSubtitle =>
      'Ochko, tangalar, daraja va natijalar boshiga qaytadi. Xaridlar, ism va bezaklar saqlanadi.';

  @override
  String get settingsResetConfirmTitle => 'Natijalar tiklansinmi?';

  @override
  String get settingsResetConfirmBody =>
      'Rekord, tangalar, daraja, seriya va barcha natijalar o‘chiriladi. Buni qaytarib bo‘lmaydi.\n\nXaridlaringiz, ismingiz hamda ochilgan mavzu va skinlar saqlanadi.';

  @override
  String get settingsResetConfirmAction => 'Tiklash';

  @override
  String get settingsResetDone => 'Natijalar tiklandi.';

  @override
  String get settingsSectionGame => 'O‘yin';

  @override
  String get settingsSectionSoundHaptics => 'Ovoz va tebranish';

  @override
  String get settingsSectionReminders => 'Eslatmalar';

  @override
  String get settingsSectionPurchases => 'Xaridlar';

  @override
  String get settingsSectionHelpOut => 'Yordam berish';

  @override
  String get settingsSectionLegal => 'Huquqiy';

  @override
  String get settingsSectionLanguage => 'Til';

  @override
  String get settingsGuide => 'Qanday o‘ynaladi';

  @override
  String get settingsGuideSubtitle =>
      'Qoidalar, kombolar, qizish va kuchaytirgichlar';

  @override
  String get settingsSound => 'Ovoz';

  @override
  String get settingsMusic => 'Musiqa';

  @override
  String get settingsHaptics => 'Tebranish';

  @override
  String get settingsHapticsOff => 'O‘chiq';

  @override
  String get settingsHapticsLight => 'Yengil';

  @override
  String get settingsHapticsStrong => 'Kuchli';

  @override
  String get settingsSectionAccessibility => 'Qulaylik';

  @override
  String get settingsReducedEffects => 'Kamaytirilgan effektlar';

  @override
  String get settingsReducedEffectsHint =>
      'Kamroq zarrachalar, ekran silkinmaydi, yorqin nur yo‘q';

  @override
  String get settingsNotifications => 'Bildirishnomalar';

  @override
  String get settingsNotificationsSubtitle =>
      'Kunlik eslatma va seriyani himoya qilish';

  @override
  String get settingsNotificationsSystemHint =>
      'Buni tizim sozlamalarida ruxsat bering.';

  @override
  String get settingsLanguageSystem => 'Tizim tili';

  @override
  String get settingsSupporterThanks => 'Qo‘llab-quvvatlovchi — rahmat!';

  @override
  String get settingsSupporterPack => 'Qo‘llab-quvvatlovchi to‘plami';

  @override
  String get settingsSupporterPackSubtitle =>
      'Eksklyuziv mavzu va skin + 1 500 tanga';

  @override
  String get settingsRestorePurchases => 'Xaridlarni tiklash';

  @override
  String get settingsRestoring => 'Xaridlar tiklanmoqda…';

  @override
  String get settingsRateApp => 'Ilovani baholash';

  @override
  String get settingsRateAppSubtitle => 'Do‘konda baho qoldiring';

  @override
  String get settingsStoreUnavailable => 'Bu qurilmada do‘kon mavjud emas.';

  @override
  String get settingsFeedback => 'Fikr yuborish';

  @override
  String get settingsFeedbackSubtitle =>
      'G‘oya va xatolar haqida xabar bering (GitHub orqali)';

  @override
  String get settingsAdPrivacy => 'Reklama maxfiyligi';

  @override
  String get settingsAdPrivacySubtitle =>
      'Reklama roziligingizni ko‘rish yoki o‘zgartirish';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Bu qurilmada reklama sozlamalari talab qilinmaydi.';

  @override
  String get settingsPrivacy => 'Maxfiylik siyosati';

  @override
  String get settingsImprint => 'Huquqiy ma’lumot';

  @override
  String get settingsPageOpenFailed => 'Sahifani ochib bo‘lmadi.';

  @override
  String get settingsFooter => 'Qubble • Oflayn blok boshqotirma';

  @override
  String get settingsAdminSection => 'Admin (test)';

  @override
  String get settingsAdminEnabled => 'Admin rejimi yoqildi';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Admin rejimi uchun yana $count marta bosing';
  }

  @override
  String settingsAdminCoins(int coins) {
    return '$coins tanga';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Faqat sinov uchun — reliz skrinshotlarida hech qachon';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount tanga';
  }

  @override
  String get settingsAdminResetCoins => 'Tangalarni 0 ga tushirish';

  @override
  String get feedbackTitle => 'Fikr-mulohaza';

  @override
  String get feedbackIntroShort =>
      'Nima yoqadi, nima g‘ashingizga tegadi, nima yetishmaydi? Kichik narsalar ham yordam beradi — qanchalik aniq bo‘lsa, shunchalik yaxshi.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Faqat $build va qurilmangiz turi ilova qilinadi — qaysi versiya haqida gapirayotganingizni bilishim uchun.';
  }

  @override
  String get feedbackSendByMail => 'Pochta orqali yuborish';

  @override
  String get feedbackPreferGithub => 'GitHub issue afzal';

  @override
  String get feedbackThanksMail => 'Rahmat! Xabarni yuborsangiz bo‘ldi.';

  @override
  String get feedbackNoMailApp =>
      'Pochta ilovasi topilmadi. Quyidagi GitHub yo‘lini sinab ko‘ring.';

  @override
  String get feedbackEmptyHint => 'Iltimos, avval biror narsa yozing.';

  @override
  String get leaderboardRefresh => 'Yangilash';

  @override
  String get leaderboardRetry => 'Qayta urinish';

  @override
  String get feedbackHint => 'Fikringiz…';

  @override
  String get feedbackSubmit => 'Fikr yuborish';

  @override
  String get feedbackOpenFailed =>
      'GitHubni ochib bo‘lmadi. Keyinroq qayta urinib ko‘ring.';

  @override
  String get feedbackGithubNote =>
      'GitHub ochiladi — u yerda \"Submit new issue\" ni bosing. (GitHubga bir marta kirish talab qilinadi.)';

  @override
  String get shopTitle => 'Do‘kon';

  @override
  String get shopWebDemoNote =>
      'Xaridlar faqat Play Store\'dagi ilovada mavjud. Bu veb-versiya bepul demo — baribir uni shu yerda to‘liq o‘ynashingiz mumkin.';

  @override
  String get shopSupporterExplainer =>
      'Qubble majburiy reklama ko‘rsatmaydi — hech qachon hech narsa sotib olishingiz shart emas. Qo‘llab-quvvatlovchi to‘plami (Aurora mavzusi, Kristall skini, 1 500 tanga, qo‘llab-quvvatlovchi nishoni) o‘yinni qo‘llab-quvvatlaganingiz uchun minnatdorchilikdir. Xaridlar do‘kon hisobingizga bog‘langan va istalgan vaqtda tiklanishi mumkin.';

  @override
  String get shopSupporterContents =>
      'Aurora mavzusi + Kristall skini + 1 500 tanga';

  @override
  String get themesTitle => 'Mavzular';

  @override
  String get themesSupporterOnly =>
      'Faqat qo‘llab-quvvatlovchi to‘plamida (do‘konga qarang)';

  @override
  String get skinsTitle => 'Blok skinlari';

  @override
  String get skinsNotEnoughCoins => 'Tanga yetarli emas';

  @override
  String get skinsNotEnoughGold => 'Oltin yetarli emas.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold oltin = 1 olmos. Olmoslar eng chiroyli skinlarni ochadi — shoshilmasdan yig‘ing.';
  }

  @override
  String get statsTitle => 'Statistika';

  @override
  String get statsAverageScore => 'O‘rtacha ochko';

  @override
  String get statsBestCombo => 'Eng yaxshi kombo';

  @override
  String get statsGames => 'O‘yinlar';

  @override
  String get statsLinesCleared => 'Tozalangan qatorlar';

  @override
  String get statsPiecesPlaced => 'Joylangan shakllar';

  @override
  String get statsCoins => 'Tangalar';

  @override
  String questCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'x$countString komboga erishing';
  }

  @override
  String questScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Bitta o‘yinda $countString ochkodan oshing';
  }

  @override
  String get achievementsTitle => 'Yutuqlar';

  @override
  String get achievementFirstGameTitle => 'Birinchi o‘yin';

  @override
  String get achievementFirstGameBody => 'Birinchi o‘yiningizni o‘ynang';

  @override
  String get achievementGames25Title => 'Doimiy o‘yinchi';

  @override
  String get achievementGames25Body => '25 ta o‘yin o‘ynang';

  @override
  String get achievementGames100Title => 'Berilib ketgan';

  @override
  String get achievementGames100Body => '100 ta o‘yin o‘ynang';

  @override
  String get achievementScore1kTitle => 'Yuksalayotgan';

  @override
  String get achievementScore1kBody => '1 000 ochkoga yeting';

  @override
  String get achievementScore5kTitle => 'Professional';

  @override
  String get achievementScore5kBody => '5 000 ochkoga yeting';

  @override
  String get achievementScore10kTitle => 'Usta';

  @override
  String get achievementScore10kBody => '10 000 ochkoga yeting';

  @override
  String get achievementScore25kTitle => 'Afsona';

  @override
  String get achievementScore25kBody => '25 000 ochkoga yeting';

  @override
  String get achievementLines100Title => 'Ozoda';

  @override
  String get achievementLines100Body => 'Jami 100 ta qatorni tozalang';

  @override
  String get achievementLines1000Title => 'Katta tozalovchi';

  @override
  String get achievementLines1000Body => 'Jami 1 000 ta qatorni tozalang';

  @override
  String get achievementCombo5Title => 'Kombo havaskori';

  @override
  String get achievementCombo5Body => 'x5 komboga erishing';

  @override
  String get achievementCombo10Title => 'Kombo qiroli';

  @override
  String get achievementCombo10Body => 'x10 komboga erishing';

  @override
  String get achievementLevel10Title => 'Tajribali';

  @override
  String get achievementLevel10Body => '10-darajaga yeting';

  @override
  String get achievementLevel20Title => 'Faxriy';

  @override
  String get achievementLevel20Body => '20-darajaga yeting';

  @override
  String get achievementStreak7Title => 'Haftalik seriya';

  @override
  String get achievementStreak7Body => '7 kunlik kunlik seriya';

  @override
  String get achievementStreak30Title => 'Oylik seriya';

  @override
  String get achievementStreak30Body => '30 kunlik kunlik seriya';

  @override
  String get achievementPuzzles10Title => 'Mantiqchi';

  @override
  String get achievementPuzzles10Body => '10 ta boshqotirmani yeching';

  @override
  String get achievementPieces5000Title => 'Quruvchi';

  @override
  String get achievementPieces5000Body => '5 000 ta shakl joylang';

  @override
  String streakRepairTitle(int streak) {
    return '$streak kunlik seriya xavf ostida!';
  }

  @override
  String get streakRepairBody =>
      'Kecha o‘ynamadingiz — seriyangizni qutqaring:';

  @override
  String get streakRepairFailed => 'Tiklab bo‘lmaydi.';

  @override
  String comebackGift(int coins) {
    return 'Xush kelibsiz! +$coins tanga';
  }

  @override
  String get notificationsOptInTitle => 'Eslatmalar?';

  @override
  String get notificationsOptInBody =>
      'Kunlik boshqotirmangizni eslatib, seriyangizni himoya qilaylikmi? Buni istalgan vaqtda sozlamalarda o‘zgartirishingiz mumkin.';

  @override
  String get notificationsOptInAccept => 'Ha, iltimos';

  @override
  String get notificationChannelDescription =>
      'Kunlik eslatma, seriya ogohlantirishi, qaytish';

  @override
  String get notificationDailyTitle => 'Kunlik boshqotirmangiz kutmoqda 🧩';

  @override
  String get notificationDailyBody => 'Bugungi sinovni o‘ynang!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 $streak kunlik seriyangiz xavf ostida!';
  }

  @override
  String get notificationStreakBody => 'Uni saqlab qolish uchun bugun o‘ynang.';

  @override
  String get notificationComebackTitle => 'Boshqotirmangiz sizni sog‘indi 🧩';

  @override
  String get notificationComebackBody => 'Qayting va sovg‘angizni oling!';

  @override
  String get iapSupporterPack => 'Qo‘llab-quvvatlovchi to‘plami';

  @override
  String get iapCoinsSmall => '500 tanga';

  @override
  String get iapCoinsMedium => '2 000 tanga';

  @override
  String get iapCoinsLarge => '6 000 tanga';

  @override
  String get iapStarterPack => 'Boshlang‘ich to‘plam';

  @override
  String get iapRename => 'Ism almashtirish';

  @override
  String get iapNeonTheme => 'Neon mavzusi';

  @override
  String get settingsLeaderboardDelete => 'Reytingdagi yozuvni o‘chirish';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Ismingiz va ochkongizni ommaviy ro‘yxatdan olib tashlaydi';

  @override
  String get settingsLeaderboardDeleteConfirmTitle =>
      'Yozuvingiz o‘chirilsinmi?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Ismingiz va ochkongiz reytingdan olib tashlanadi. O‘yindagi natijalaringiz o‘zgarmaydi. Reytingga istalgan vaqtda qayta qo‘shilishingiz mumkin.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'Reytingdagi yozuvingiz o‘chirildi.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Yozuvni o‘chirib bo‘lmadi. Ulanishni tekshiring va qayta urinib ko‘ring.';

  @override
  String get leaderboardReport => 'Bu ism ustidan shikoyat qilish';

  @override
  String get leaderboardBlock => 'Bloklash';

  @override
  String leaderboardBlocked(String name) {
    return '$name siz uchun yashirildi';
  }

  @override
  String get leaderboardUndo => 'Qaytarish';

  @override
  String leaderboardBlockedCount(int count) {
    return 'Siz yashirgan yozuvlar: $count';
  }

  @override
  String get leaderboardUnblockAll => 'Yana ko‘rsatish';

  @override
  String get leaderboardReportUnavailable => 'Hozir shikoyat qilib bo‘lmaydi.';

  @override
  String get leaderboardReportSent => 'Rahmat — shikoyatingiz yuborildi.';

  @override
  String get leaderboardRules =>
      'Ismlar ommaviy. Haqorat, kamsituvchi so‘zlar va haqiqiy shaxsni aniqlaydigan hech narsa bo‘lmasin. Bu qoidani buzgan ismlar olib tashlanadi.';

  @override
  String get leaderboardRulesAccept => 'Tushundim';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$total tadan $unlocked tasi ochildi';
  }

  @override
  String get settingsSectionData => 'Saqlangan ma’lumotlar';

  @override
  String get gameRotatePiece => 'Shaklni burish';

  @override
  String get themeClassic => 'Klassik';

  @override
  String get themeFade => 'Pastel';

  @override
  String get themeNeon => 'Neon';

  @override
  String get themeOcean => 'Okean';

  @override
  String get themeWood => 'Yog‘och';

  @override
  String get themeSunset => 'Quyosh botishi';

  @override
  String get themeForest => 'O‘rmon';

  @override
  String get themeAurora => 'Aurora';

  @override
  String get skinClassic => 'Klassik';

  @override
  String get skinGradient => 'Gradiyent';

  @override
  String get skinOutline => 'Kontur';

  @override
  String get skinGlossy => 'Yaltiroq';

  @override
  String get skinStripe => 'Chiziqli';

  @override
  String get skinBevel => 'Qirrali';

  @override
  String get skinGlow => 'Nurli';

  @override
  String get skinCrystal => 'Kristall';

  @override
  String rewardThemeName(String name) {
    return '$name mavzusi';
  }

  @override
  String rewardSkinName(String name) {
    return '$name skini';
  }

  @override
  String get skinPulse => 'Puls';

  @override
  String get skinShimmer => 'Yiltillash';

  @override
  String get skinWave => 'To‘lqin';

  @override
  String get skinEmber => 'Cho‘g‘';

  @override
  String get skinPrism => 'Prizma';

  @override
  String get skinStardust => 'Yulduz changi';

  @override
  String get skinCircuit => 'Zanjir';

  @override
  String get skinRipple => 'Mayda to‘lqin';

  @override
  String achievementRewardSkin(String name) {
    return 'Animatsiyali skin: $name';
  }

  @override
  String skinsAchievementReward(String achievement) {
    return 'Yutuq mukofoti: $achievement';
  }

  @override
  String get achievementBackpay =>
      'Endi yutuqlar mukofot beradi — siznikilar qo‘shildi.';

  @override
  String get namePromptBody =>
      'Ism tanlang, eng yaxshi natijangiz reytingga chiqadi. Ismsiz anonim o‘ynashda davom etasiz.';

  @override
  String get nameTaken => 'Bu ism allaqachon band. Boshqasini sinab ko‘ring.';

  @override
  String get nameCheckFailed =>
      'Ismni tekshirib bo‘lmadi. Internetga ulanganmisiz? Birozdan so‘ng qayta urinib ko‘ring.';

  @override
  String nameLost(String name) {
    return '$name endi boshqa o‘yinchiga tegishli. Yangi ismni bepul tanlang.';
  }

  @override
  String get themeCandy => 'Konfet';

  @override
  String get themeVolcano => 'Vulqon';

  @override
  String get themeGlacier => 'Muzlik';

  @override
  String get skinPixel => 'Piksel';

  @override
  String get skinMarble => 'Marmar';

  @override
  String get skinJelly => 'Jele';

  @override
  String get skinLiquid => 'Suyuqlik';

  @override
  String get skinFizz => 'Pufakchalar';

  @override
  String get skinPlasma => 'Plazma';

  @override
  String get designsTitle => 'Dizaynlar';

  @override
  String get designsNotEnoughDiamonds => 'Olmos yetarli emas.';

  @override
  String get designsOwned => 'Sizda bor';

  @override
  String get designsAchievementOnly => 'Yutuq';

  @override
  String get designsSupporterOnly => 'Qo‘llovchi';

  @override
  String get designsPreview => 'Oldindan ko‘rish';

  @override
  String get designsGetDiamonds => 'Olmos olish';

  @override
  String get shopDealTitle => 'Kun taklifi';

  @override
  String get shopAnimatedSkins => 'Animatsiyali skinlar';

  @override
  String get shopNewDesigns => 'Yangi dizaynlar';

  @override
  String get shopDiamonds => 'Olmoslar';

  @override
  String get shopPacks => 'To‘plamlar';

  @override
  String get shopPopular => 'Mashhur';

  @override
  String get shopBestValue => 'Eng foydali';

  @override
  String get shopDiamondsBlurb =>
      'Animatsiyali skinlar va yangi dizaynlar uchun.';

  @override
  String get shopCoinsBlurb => 'Mavzular, skinlar va kuchaytirgichlar uchun.';

  @override
  String get shopNeonBlurb => 'Neon mavzusini darhol ochadi.';

  @override
  String get shopRenameBlurb => 'Reytingdagi ismingizni o‘zgartiring.';

  @override
  String shopHoursLeft(int hours) {
    return '$hours soat qoldi';
  }

  @override
  String shopNewDealIn(String time) {
    return 'Yangi taklif $time dan keyin';
  }

  @override
  String shopDesignUnlocked(String name) {
    return '$name ochildi!';
  }

  @override
  String get questsTitle => 'Topshiriqlar';

  @override
  String get questsDaily => 'Kunlik';

  @override
  String get questsWeekly => 'Haftalik';

  @override
  String get questsMonthly => 'Oylik';

  @override
  String questsNewIn(String time) {
    return 'Yangi topshiriqlar $time dan keyin';
  }

  @override
  String get questsBonus => 'Hammasi uchun bonus';

  @override
  String get questsBonusEarned => 'Bonus olindi';

  @override
  String get questRounds => 'Raundlar o‘yna';

  @override
  String get questLines => 'Qatorlarni tozala';

  @override
  String get questPieces => 'Shakllarni joyla';

  @override
  String get questDailyChallenge => 'Kunlik sinovni o‘yna';

  @override
  String get questPuzzles => 'Yangi jumboqlarni yech';

  @override
  String get questDays => 'Turli kunlarda o‘yna';

  @override
  String get questDailySets => 'Barcha kunlik topshiriqlarni bajar';

  @override
  String get questsSetDaily => 'Barcha kunlik topshiriqlar bajarildi!';

  @override
  String get questsSetWeekly => 'Barcha haftalik topshiriqlar bajarildi!';

  @override
  String get questsSetMonthly => 'Barcha oylik topshiriqlar bajarildi!';

  @override
  String get leaderboardTabScore => 'Eng yaxshi natija';

  @override
  String get leaderboardTabPuzzle => 'Jumboq yulduzlari';

  @override
  String get leaderboardPuzzleAutoSubmit =>
      'Jumboq yulduzlaring avtomatik yuboriladi.';

  @override
  String leaderboardPuzzleSubmitting(int stars) {
    return 'Jumboq yulduzlaring ($stars) yuborilmoqda …';
  }
}
