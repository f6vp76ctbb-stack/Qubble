// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class L10nMs extends L10n {
  L10nMs([String locale = 'ms']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Main';

  @override
  String get commonLater => 'Nanti';

  @override
  String get commonNotNow => 'Bukan sekarang';

  @override
  String get commonCancel => 'Batal';

  @override
  String get commonBuy => 'Beli';

  @override
  String get commonSave => 'Simpan';

  @override
  String get commonCollect => 'Ambil';

  @override
  String get nameNewName => 'Nama baharu';

  @override
  String get nameFieldLabel => 'Nama';

  @override
  String get piggyFullTitle => 'Tabung sudah penuh!';

  @override
  String get piggyKeepSaving => 'Terus menyimpan';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$coins daripada $capacity terkumpul.';
  }

  @override
  String get homeContinueRun => 'Teruskan';

  @override
  String get homeVideo => 'Video';

  @override
  String get commonGotIt => 'Faham';

  @override
  String get commonHome => 'Laman utama';

  @override
  String get commonScore => 'SKOR';

  @override
  String get commonBest => 'TERBAIK';

  @override
  String commonLevelShort(int level) {
    return 'Tahap $level';
  }

  @override
  String get homeNewRun => 'Mulakan permainan baharu';

  @override
  String get homeBackToExit => 'Tekan kembali sekali lagi untuk keluar';

  @override
  String get homeEnableLeaderboard => 'Sertai papan pendahulu';

  @override
  String get homeBestScore => 'SKOR TERBAIK';

  @override
  String get homeDailyChallenge => 'Cabaran Harian';

  @override
  String get homeDailyOpenToday => 'Belum dimainkan hari ini';

  @override
  String homeDailyNextIn(String time) {
    return 'Cabaran seterusnya dalam $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return '$streak hari berturut-turut';
  }

  @override
  String get homeLeaderboard => 'Pendahulu';

  @override
  String get homePuzzleMode => 'Mod Teka-teki';

  @override
  String get homeMissions => 'Misi';

  @override
  String get homeThemes => 'Tema';

  @override
  String get homeSkins => 'Skin';

  @override
  String get homeHowToPlay => 'Cara bermain Qubble';

  @override
  String get homeWeekendBonus => 'Hujung minggu: syiling berganda!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Tahap $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Tukar nama';

  @override
  String get nameChangeExplainer =>
      'Nama anda ialah identiti anda di papan pendahulu, jadi ia kekal. Anda boleh membeli satu kali pertukaran nama.';

  @override
  String get nameChangeAfterPurchase =>
      'Selepas membeli, ketik nama anda sekali lagi untuk menukarnya.';

  @override
  String get nameJoinedLeaderboard => 'Anda kini berada di papan pendahulu.';

  @override
  String get nameRenameUnavailable => 'Nama tidak dapat ditukar sekarang.';

  @override
  String nameProblemTooShort(int min) {
    return 'Sekurang-kurangnya $min aksara.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'Maksimum $max aksara.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Hanya huruf (A–Z), nombor, ruang, _ dan -.';

  @override
  String get nameProblemOffensive => 'Sila pilih nama lain.';

  @override
  String get piggyTitle => 'Tabung';

  @override
  String get piggyFillingHint =>
      'Tabung anda terisi apabila anda mengosongkan baris.';

  @override
  String piggyCollect(int coins) {
    return 'Ambil $coins syiling — percuma.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Apabila penuh, anda boleh mengosongkannya secara percuma — atau membukanya lebih awal dengan video bonus.';

  @override
  String get piggyOpenNow => 'Buka sekarang';

  @override
  String get gameNewPiecesVideo => 'Kepingan baharu (video)';

  @override
  String get gameTapBoardCell => 'Ketik satu petak di papan';

  @override
  String get gameDailyChallengeLabel => 'CABARAN HARIAN';

  @override
  String get gameOver => 'Permainan Tamat';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Anda perlukan $missing syiling lagi untuk bom.';
  }

  @override
  String get gameBombNotHere => 'Bom tidak boleh digunakan di sini sekarang.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Anda perlukan $missing syiling lagi untuk itu.';
  }

  @override
  String get gameNotRightNow => 'Tidak boleh sekarang.';

  @override
  String get gameRunSaved => 'Permainan disimpan — “Teruskan” di menu.';

  @override
  String get gameOverNoFit => 'Tiada kepingan anda yang muat lagi di papan.';

  @override
  String get gameOverNoFitNoRotations =>
      'Tiada kepingan yang muat — dan putaran sudah habis.';

  @override
  String get gameStarterOfferUnavailable => 'Tidak tersedia sekarang';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — dapatkan';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'KOMBO x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Pencapaian: $title';
  }

  @override
  String get gameBestSubmitted => 'Rekod baharu — dihantar';

  @override
  String get gameReviveFor => 'Teruskan bermain · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Dibuka: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Pek pemula';

  @override
  String gameOverPoints(int score) {
    return '$score mata';
  }

  @override
  String get gameNewRecord => 'Rekod baharu!';

  @override
  String gameStreakDays(int streak) {
    return '$streak hari berturut-turut';
  }

  @override
  String get gameDoubleCoins => 'Gandakan syiling';

  @override
  String get gameDoubleDaily => 'Gandakan ganjaran harian';

  @override
  String get gamePlayAgain => 'Main lagi';

  @override
  String gameLevelReached(int level) {
    return 'Mencapai tahap $level!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return 'Naik $count tahap — tahap $level!';
  }

  @override
  String get gameStarterOfferReward => '1200 syiling + tema Kayu';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'Tinggal $hours jam — sekali sahaja!';
  }

  @override
  String get boosterUndo => 'Buat asal';

  @override
  String get boosterSwap => 'Tukar';

  @override
  String get boosterBomb => 'Bom';

  @override
  String get boosterNoRotationsLeft =>
      'Putaran sudah habis — kosongkan baris untuk mengecas semula!';

  @override
  String get onboardingDragPiece => 'Seret satu blok ke papan';

  @override
  String get onboardingFillLine => 'Penuhkan satu baris atau lajur';

  @override
  String get onboardingLinesClear => 'Garisan penuh akan hilang — mata!';

  @override
  String get coachHintCombo =>
      'Kombo! Kosongkan lagi dalam 3 langkah untuk mengekalkannya';

  @override
  String get coachHintFever => 'MEMBARA! Mata berganda selagi bercahaya';

  @override
  String get coachHintRotation =>
      'Memutar menggunakan satu cas — mengosongkan garisan mengisinya semula';

  @override
  String get coachHintBooster => 'Petua: anda boleh guna penggalak di bawah';

  @override
  String get coachHintStrategy =>
      'Petua: jangan kosongkan semua garisan sekali gus — tinggalkan ruang untuk kepingan besar';

  @override
  String get dailyStreakLabel => 'Berturut-turut';

  @override
  String get dailyBestLabel => 'Terbaik harian';

  @override
  String dailyHistoryNote(int days) {
    return '$days hari terakhir disimpan.';
  }

  @override
  String dailyDayPlayed(int day) {
    return 'Hari $day: dimainkan';
  }

  @override
  String dailyDayMissed(int day) {
    return 'Hari $day: tidak dimainkan';
  }

  @override
  String get homeDailyCalendar => 'Kalendar';

  @override
  String get dailyShareButton => 'Kongsi keputusan';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Cabaran Harian $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return '$score mata · kombo terbaik x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Main: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    return 'Kombo: tinggal $moves langkah';
  }

  @override
  String get dailyShareCopied => 'Keputusan disalin ke papan keratan';

  @override
  String get adNotAvailable =>
      'Tiada video buat masa ini — cuba lagi sebentar lagi';

  @override
  String get howToPlaySpeedTitle => 'Bonus kelajuan';

  @override
  String get howToPlaySpeedBody =>
      'Meletakkan kepingan dengan pantas menambah sehingga 30% pada setiap garisan yang dikosongkan. Bonus berkurang antara 1.5 dan 4 saat dan ada hadnya — laju itu berbaloi tetapi tidak menentukan permainan, dan permainan yang tenang dan teliti masih boleh mengalahkan yang tergesa-gesa.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Bonus kelajuan $percent peratus';
  }

  @override
  String get iapDiamondsSmall => '100 berlian';

  @override
  String get iapDiamondsMedium => '350 berlian';

  @override
  String get iapDiamondsLarge => '1,000 berlian';

  @override
  String get howToPlayTitle => 'Cara bermain Qubble';

  @override
  String get howToPlayIntroHeadline =>
      'Mudah dimulakan.\nBerbaloi merancang ke depan.';

  @override
  String get howToPlayIntroBody =>
      'Pastikan papan lapang dan kalahkan skor terbaik anda.';

  @override
  String get howToPlayIntroSemantics =>
      'Matlamat permainan. Pastikan papan lapang dan kalahkan skor terbaik anda.';

  @override
  String get howToPlayDragTitle => 'Seret & letak';

  @override
  String get howToPlayDragBody =>
      'Seret salah satu daripada tiga kepingan ke petak kosong. Apabila ketiga-tiganya digunakan, anda terus mendapat tiga kepingan baharu.';

  @override
  String get howToPlayClearTitle => 'Kosongkan garisan';

  @override
  String get howToPlayClearBody =>
      'Penuhkan satu baris atau lajur. Garisan penuh akan hilang dan memberi ruang untuk langkah seterusnya.';

  @override
  String get howToPlayComboTitle => 'Rangkaikan kombo';

  @override
  String get howToPlayComboBody =>
      'Kosongkan satu lagi garisan dalam tiga langkah. Setiap kombo seterusnya menaikkan pendarab mata anda. Kombo mengira langkah, bukan saat, jadi ia tidak tamat semasa anda berfikir.';

  @override
  String get howToPlayFeverTitle => 'Nyalakan mod membara';

  @override
  String get howToPlayFeverBody =>
      'Mengosongkan garisan mengisi meter membara. Apabila penuh, letupan seterusnya bernilai dua kali ganda — rancang pengosongan besar lebih awal.';

  @override
  String get howToPlayBoosterTitle => 'Guna penggalak dengan bijak';

  @override
  String get howToPlayBoosterBody =>
      'Penggalak menyelamatkan permainan yang sukar. Anda juga boleh mengetik kepingan di dulang untuk memutarnya.';

  @override
  String get howToPlayDailyTitle => 'Harian & berturut-turut';

  @override
  String get howToPlayDailyBody =>
      'Cabaran harian menggunakan kepingan yang sama untuk semua orang. Main setiap hari untuk memanjangkan rentetan dan bonus anda.';

  @override
  String get howToPlayPiggyTitle => 'Isi tabung';

  @override
  String get howToPlayPiggyBody =>
      'Setiap garisan yang dikosongkan mengisi tabung anda. Apabila penuh, anda boleh mengambil syilingnya secara percuma.';

  @override
  String get leaderboardTitle => 'Papan Pendahulu';

  @override
  String get leaderboardUnreachable =>
      'Papan pendahulu tidak tersedia.\nCuba lagi dengan sambungan internet.';

  @override
  String get leaderboardEmpty => 'Belum ada entri.\nJadilah yang pertama!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Skor terbaik anda ($score) sedang dihantar …';
  }

  @override
  String get leaderboardAutoSubmit =>
      'Skor terbaik anda dihantar secara automatik.';

  @override
  String get puzzleModeTitle => 'Mod Teka-teki';

  @override
  String puzzleLevelTitle(int level) {
    return 'Teka-teki $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Langkah: $moves   •   Sasaran: $target untuk 3 bintang';
  }

  @override
  String get puzzleSolved => 'Selesai!';

  @override
  String get puzzleLeaveTitle => 'Keluar dari teka-teki?';

  @override
  String get puzzleLeaveBody =>
      'Kemajuan anda dalam teka-teki ini akan hilang.';

  @override
  String get puzzleKeepPlaying => 'Teruskan bermain';

  @override
  String get puzzleLeave => 'Keluar';

  @override
  String get puzzleStuckTitle => 'Buntu';

  @override
  String get puzzleRestart => 'Mula semula';

  @override
  String get commonActive => 'Aktif';

  @override
  String get commonTapToActivate => 'Ketik untuk guna';

  @override
  String get commonRestore => 'Pulihkan';

  @override
  String unlockForCost(int cost) {
    return '$cost untuk membuka';
  }

  @override
  String get skinsExchangeGold => 'Tukar emas';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Putar kepingan';

  @override
  String get puzzleNextLevel => 'Tahap seterusnya';

  @override
  String get puzzleBackToOverview => 'Kembali ke senarai';

  @override
  String get puzzleUnsolvable =>
      'Dari sini papan tidak dapat dikosongkan lagi.';

  @override
  String get puzzleExtraMoveVideo => 'Langkah tambahan (video)';

  @override
  String puzzleSolvedCount(int solved) {
    return '$solved diselesaikan';
  }

  @override
  String get settingsTitle => 'Tetapan';

  @override
  String get storageFailureTitle =>
      'Qubble tidak dapat memuatkan permainan anda yang disimpan';

  @override
  String get storageFailureBody =>
      'Sila mulakan semula aplikasi. Jika ralat berterusan, hanya pemasangan semula yang boleh membantu. Anda boleh melaporkannya melalui Tetapan › Hantar maklum balas.';

  @override
  String get iapUnavailable => 'Tawaran ini tidak tersedia sekarang.';

  @override
  String get iapFailed => 'Pembelian tidak berjaya. Tiada caj dikenakan.';

  @override
  String get settingsResetProgress => 'Tetapkan semula kemajuan';

  @override
  String get settingsResetProgressSubtitle =>
      'Skor, syiling, tahap dan kemajuan kembali ke permulaan. Pembelian, nama dan kosmetik kekal.';

  @override
  String get settingsResetConfirmTitle => 'Tetapkan semula kemajuan?';

  @override
  String get settingsResetConfirmBody =>
      'Skor terbaik, syiling, tahap, rentetan dan semua kemajuan akan dipadam. Ini tidak boleh dibatalkan.\n\nPembelian, nama anda serta tema dan skin yang telah dibuka akan kekal.';

  @override
  String get settingsResetConfirmAction => 'Tetapkan semula';

  @override
  String get settingsResetDone => 'Kemajuan telah ditetapkan semula.';

  @override
  String get settingsSectionGame => 'Permainan';

  @override
  String get settingsSectionSoundHaptics => 'Bunyi & getaran';

  @override
  String get settingsSectionReminders => 'Peringatan';

  @override
  String get settingsSectionPurchases => 'Pembelian';

  @override
  String get settingsSectionHelpOut => 'Sokong kami';

  @override
  String get settingsSectionLegal => 'Undang-undang';

  @override
  String get settingsSectionLanguage => 'Bahasa';

  @override
  String get settingsGuide => 'Cara bermain';

  @override
  String get settingsGuideSubtitle =>
      'Peraturan, kombo, mod membara & penggalak';

  @override
  String get settingsSound => 'Bunyi';

  @override
  String get settingsMusic => 'Muzik';

  @override
  String get settingsHaptics => 'Getaran';

  @override
  String get settingsHapticsOff => 'Mati';

  @override
  String get settingsHapticsLight => 'Ringan';

  @override
  String get settingsHapticsStrong => 'Kuat';

  @override
  String get settingsSectionAccessibility => 'Keselesaan';

  @override
  String get settingsReducedEffects => 'Kurangkan kesan';

  @override
  String get settingsReducedEffectsHint =>
      'Kurang zarah, tanpa goncangan skrin, tanpa cahaya';

  @override
  String get settingsNotifications => 'Pemberitahuan';

  @override
  String get settingsNotificationsSubtitle =>
      'Peringatan harian & perlindungan rentetan';

  @override
  String get settingsNotificationsSystemHint =>
      'Benarkan dalam tetapan sistem.';

  @override
  String get settingsLanguageSystem => 'Bahasa sistem';

  @override
  String get settingsSupporterThanks => 'Penyokong — terima kasih!';

  @override
  String get settingsSupporterPack => 'Pek penyokong';

  @override
  String get settingsSupporterPackSubtitle =>
      'Tema & skin eksklusif + 1,500 syiling';

  @override
  String get settingsRestorePurchases => 'Pulihkan pembelian';

  @override
  String get settingsRestoring => 'Memulihkan pembelian…';

  @override
  String get settingsRateApp => 'Nilai aplikasi';

  @override
  String get settingsRateAppSubtitle => 'Beri penilaian di kedai';

  @override
  String get settingsStoreUnavailable =>
      'Kedai tidak tersedia pada peranti ini.';

  @override
  String get settingsFeedback => 'Hantar maklum balas';

  @override
  String get settingsFeedbackSubtitle =>
      'Laporkan idea & pepijat (melalui GitHub)';

  @override
  String get settingsAdPrivacy => 'Privasi iklan';

  @override
  String get settingsAdPrivacySubtitle =>
      'Lihat atau tukar persetujuan iklan anda';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Tiada pilihan iklan diperlukan pada peranti ini.';

  @override
  String get settingsPrivacy => 'Dasar privasi';

  @override
  String get settingsImprint => 'Maklumat penerbit';

  @override
  String get settingsPageOpenFailed => 'Halaman tidak dapat dibuka.';

  @override
  String get settingsFooter => 'Qubble • Teka-teki Blok Luar Talian';

  @override
  String get settingsAdminSection => 'Admin (ujian)';

  @override
  String get settingsAdminEnabled => 'Mod admin diaktifkan';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Ketik $count kali lagi untuk mod admin';
  }

  @override
  String settingsAdminCoins(int coins) {
    return '$coins syiling';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Untuk ujian sahaja — jangan tunjukkan dalam tangkapan skrin keluaran';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount syiling';
  }

  @override
  String get settingsAdminResetCoins => 'Jadikan syiling 0';

  @override
  String get feedbackTitle => 'Maklum balas';

  @override
  String get feedbackIntroShort =>
      'Apa yang anda suka, apa yang mengganggu, apa yang kurang? Perkara kecil pun membantu — lebih khusus, lebih baik.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Hanya $build dan jenis peranti anda dilampirkan — supaya jelas binaan mana yang dimaksudkan.';
  }

  @override
  String get feedbackSendByMail => 'Hantar melalui e-mel';

  @override
  String get feedbackPreferGithub => 'Lebih suka isu GitHub';

  @override
  String get feedbackThanksMail => 'Terima kasih! Hantar sahaja mesejnya.';

  @override
  String get feedbackNoMailApp =>
      'Aplikasi e-mel tidak ditemui. Cuba cara GitHub di bawah.';

  @override
  String get feedbackEmptyHint => 'Sila tulis sesuatu dahulu.';

  @override
  String get leaderboardRefresh => 'Muat semula';

  @override
  String get leaderboardRetry => 'Cuba lagi';

  @override
  String get feedbackHint => 'Maklum balas anda…';

  @override
  String get feedbackSubmit => 'Hantar maklum balas';

  @override
  String get feedbackOpenFailed =>
      'GitHub tidak dapat dibuka. Cuba lagi nanti.';

  @override
  String get feedbackGithubNote =>
      'GitHub akan dibuka — ketik \"Submit new issue\" di sana. (Log masuk GitHub sekali diperlukan.)';

  @override
  String get shopTitle => 'Kedai';

  @override
  String get shopWebDemoNote =>
      'Pembelian hanya tersedia dalam aplikasi dari Play Store. Versi web ini ialah demo percuma — anda masih boleh memainkan semuanya di sini.';

  @override
  String get shopSupporterExplainer =>
      'Qubble tidak memaparkan iklan paksa — anda tidak perlu membeli apa-apa. Pek penyokong (tema Aurora, skin Kristal, 1,500 syiling, lencana penyokong) ialah tanda terima kasih kerana menyokong permainan ini. Pembelian dipautkan kepada akaun kedai anda dan boleh dipulihkan pada bila-bila masa.';

  @override
  String get shopSupporterContents =>
      'Tema Aurora + skin Kristal + 1,500 syiling';

  @override
  String get themesTitle => 'Tema';

  @override
  String get themesSupporterOnly =>
      'Eksklusif untuk pek penyokong (lihat kedai)';

  @override
  String get themesInSupporterPack => 'Dalam pek penyokong';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'Syiling tidak cukup (perlu $cost, ada $coins)';
  }

  @override
  String get skinsTitle => 'Skin blok';

  @override
  String get skinsNotEnoughDiamonds =>
      'Berlian tidak cukup (tukar emas di bawah)';

  @override
  String get skinsNotEnoughCoins => 'Syiling tidak cukup';

  @override
  String get skinsNotEnoughGold => 'Emas tidak cukup.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold emas = 1 berlian. Berlian membuka skin terbaik — kumpul perlahan-lahan.';
  }

  @override
  String get statsTitle => 'Statistik';

  @override
  String get statsAverageScore => 'Purata skor';

  @override
  String get statsBestCombo => 'Kombo terbaik';

  @override
  String get statsGames => 'Permainan';

  @override
  String get statsLinesCleared => 'Baris dikosongkan';

  @override
  String get statsPiecesPlaced => 'Kepingan diletak';

  @override
  String get statsCoins => 'Syiling';

  @override
  String get missionsTitle => 'Misi';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Letak $countString kepingan';
  }

  @override
  String missionClearRows(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Kosongkan $countString baris';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Capai kombo x$countString';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Lepasi $countString mata dalam satu permainan';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Main $countString permainan';
  }

  @override
  String get achievementsTitle => 'Pencapaian';

  @override
  String get achievementFirstGameTitle => 'Permainan pertama';

  @override
  String get achievementFirstGameBody => 'Main permainan pertama anda';

  @override
  String get achievementGames25Title => 'Pemain tetap';

  @override
  String get achievementGames25Body => 'Main 25 permainan';

  @override
  String get achievementGames100Title => 'Ketagih';

  @override
  String get achievementGames100Body => 'Main 100 permainan';

  @override
  String get achievementScore1kTitle => 'Pendaki';

  @override
  String get achievementScore1kBody => 'Capai 1,000 mata';

  @override
  String get achievementScore5kTitle => 'Pro';

  @override
  String get achievementScore5kBody => 'Capai 5,000 mata';

  @override
  String get achievementScore10kTitle => 'Pakar';

  @override
  String get achievementScore10kBody => 'Capai 10,000 mata';

  @override
  String get achievementScore25kTitle => 'Legenda';

  @override
  String get achievementScore25kBody => 'Capai 25,000 mata';

  @override
  String get achievementLines100Title => 'Kemas';

  @override
  String get achievementLines100Body => 'Kosongkan 100 baris keseluruhannya';

  @override
  String get achievementLines1000Title => 'Pembersihan besar';

  @override
  String get achievementLines1000Body => 'Kosongkan 1,000 baris keseluruhannya';

  @override
  String get achievementCombo5Title => 'Permulaan kombo';

  @override
  String get achievementCombo5Body => 'Capai kombo x5';

  @override
  String get achievementCombo10Title => 'Raja kombo';

  @override
  String get achievementCombo10Body => 'Capai kombo x10';

  @override
  String get achievementLevel10Title => 'Berpengalaman';

  @override
  String get achievementLevel10Body => 'Capai tahap 10';

  @override
  String get achievementLevel20Title => 'Veteran';

  @override
  String get achievementLevel20Body => 'Capai tahap 20';

  @override
  String get achievementStreak7Title => 'Seminggu penuh';

  @override
  String get achievementStreak7Body => 'Cabaran harian 7 hari berturut-turut';

  @override
  String get achievementStreak30Title => 'Sebulan penuh';

  @override
  String get achievementStreak30Body => 'Cabaran harian 30 hari berturut-turut';

  @override
  String get achievementPuzzles10Title => 'Pakar teka-teki';

  @override
  String get achievementPuzzles10Body => 'Selesaikan 10 teka-teki';

  @override
  String get achievementPieces5000Title => 'Pembina';

  @override
  String get achievementPieces5000Body => 'Letak 5,000 kepingan';

  @override
  String streakRepairTitle(int streak) {
    return 'Rentetan $streak hari anda dalam bahaya!';
  }

  @override
  String get streakRepairBody =>
      'Anda tidak bermain semalam — selamatkan rentetan anda:';

  @override
  String get streakRepairFailed => 'Tidak dapat dibaiki.';

  @override
  String comebackGift(int coins) {
    return 'Selamat kembali! +$coins syiling';
  }

  @override
  String get notificationsOptInTitle => 'Peringatan?';

  @override
  String get notificationsOptInBody =>
      'Mahu kami ingatkan tentang teka-teki harian anda dan lindungi rentetan anda? Anda boleh menukarnya pada bila-bila masa dalam tetapan.';

  @override
  String get notificationsOptInAccept => 'Ya, boleh';

  @override
  String get notificationChannelDescription =>
      'Peringatan harian, amaran rentetan, jemputan kembali';

  @override
  String get notificationDailyTitle =>
      'Teka-teki harian anda sedang menunggu 🧩';

  @override
  String get notificationDailyBody => 'Main cabaran hari ini!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 Rentetan $streak hari anda dalam bahaya!';
  }

  @override
  String get notificationStreakBody => 'Main hari ini untuk mengekalkannya.';

  @override
  String get notificationComebackTitle => 'Teka-teki anda rindukan anda 🧩';

  @override
  String get notificationComebackBody => 'Kembali dan ambil hadiah anda!';

  @override
  String get iapSupporterPack => 'Pek penyokong';

  @override
  String get iapCoinsSmall => '500 syiling';

  @override
  String get iapCoinsMedium => '2,000 syiling';

  @override
  String get iapCoinsLarge => '6,000 syiling';

  @override
  String get iapStarterPack => 'Pek pemula';

  @override
  String get iapRename => 'Tukar nama';

  @override
  String get iapNeonTheme => 'Tema Neon';

  @override
  String get settingsLeaderboardDelete => 'Padam entri papan pendahulu';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Mengeluarkan nama dan skor anda daripada senarai awam';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'Padam entri anda?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Nama dan skor anda akan dikeluarkan daripada papan pendahulu. Kemajuan permainan anda tidak berubah. Anda boleh menyertai papan pendahulu semula pada bila-bila masa.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'Entri papan pendahulu anda telah dipadam.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Entri tidak dapat dipadam. Semak sambungan anda dan cuba lagi.';

  @override
  String get leaderboardReport => 'Laporkan nama ini';

  @override
  String get leaderboardBlock => 'Sekat';

  @override
  String leaderboardBlocked(String name) {
    return '$name disembunyikan untuk anda';
  }

  @override
  String get leaderboardUndo => 'Buat asal';

  @override
  String leaderboardBlockedCount(int count) {
    return '$count entri disembunyikan oleh anda';
  }

  @override
  String get leaderboardUnblockAll => 'Tunjukkan semula';

  @override
  String get leaderboardReportUnavailable => 'Laporan tidak tersedia sekarang.';

  @override
  String get leaderboardReportSent =>
      'Terima kasih — laporan anda sedang dihantar.';

  @override
  String get leaderboardRules =>
      'Nama adalah awam. Tiada penghinaan, tiada kata-kata kesat, dan tiada apa-apa yang mengenal pasti orang sebenar. Nama yang melanggar akan dikeluarkan.';

  @override
  String get leaderboardRulesAccept => 'Saya faham';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked daripada $total dibuka';
  }

  @override
  String get settingsSectionData => 'Data disimpan';

  @override
  String get gameRotatePiece => 'Putar kepingan';

  @override
  String get themeClassic => 'Klasik';

  @override
  String get themeFade => 'Pastel';

  @override
  String get themeNeon => 'Neon';

  @override
  String get themeOcean => 'Lautan';

  @override
  String get themeWood => 'Kayu';

  @override
  String get themeSunset => 'Senja';

  @override
  String get themeForest => 'Hutan';

  @override
  String get themeAurora => 'Aurora';

  @override
  String get skinClassic => 'Klasik';

  @override
  String get skinGradient => 'Gradien';

  @override
  String get skinOutline => 'Garis luar';

  @override
  String get skinGlossy => 'Berkilat';

  @override
  String get skinStripe => 'Berjalur';

  @override
  String get skinBevel => 'Serong';

  @override
  String get skinGlow => 'Bercahaya';

  @override
  String get skinCrystal => 'Kristal';

  @override
  String rewardThemeName(String name) {
    return 'Tema $name';
  }

  @override
  String rewardSkinName(String name) {
    return 'Skin $name';
  }
}
