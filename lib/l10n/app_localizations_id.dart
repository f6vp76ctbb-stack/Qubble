// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class L10nId extends L10n {
  L10nId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Main';

  @override
  String get commonLater => 'Nanti';

  @override
  String get commonNotNow => 'Tidak sekarang';

  @override
  String get commonCancel => 'Batal';

  @override
  String get commonBuy => 'Beli';

  @override
  String get commonSave => 'Simpan';

  @override
  String get commonCollect => 'Ambil';

  @override
  String get nameNewName => 'Nama baru';

  @override
  String get nameFieldLabel => 'Nama';

  @override
  String get piggyFullTitle => 'Celengan sudah penuh!';

  @override
  String get piggyKeepSaving => 'Terus menabung';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$coins dari $capacity terkumpul.';
  }

  @override
  String get homeContinueRun => 'Lanjutkan';

  @override
  String get homeVideo => 'Video';

  @override
  String get commonGotIt => 'Mengerti';

  @override
  String get commonHome => 'Beranda';

  @override
  String get commonScore => 'SKOR';

  @override
  String get commonBest => 'TERBAIK';

  @override
  String commonLevelShort(int level) {
    return 'Level $level';
  }

  @override
  String get homeNewRun => 'Mulai permainan baru';

  @override
  String get homeBackToExit => 'Tekan kembali sekali lagi untuk keluar';

  @override
  String get homeEnableLeaderboard => 'Ikut papan peringkat';

  @override
  String get homeBestScore => 'SKOR TERBAIK';

  @override
  String get homeDailyChallenge => 'Tantangan Harian';

  @override
  String get homeDailyOpenToday => 'Belum dimainkan hari ini';

  @override
  String homeDailyNextIn(String time) {
    return 'Tantangan berikutnya dalam $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return 'Runtunan $streak hari';
  }

  @override
  String get homeLeaderboard => 'Peringkat';

  @override
  String get homePuzzleMode => 'Mode Teka-teki';

  @override
  String get homeMissions => 'Misi';

  @override
  String get homeThemes => 'Tema';

  @override
  String get homeSkins => 'Skin';

  @override
  String get homeHowToPlay => 'Cara bermain Qubble';

  @override
  String get homeWeekendBonus => 'Akhir pekan: koin ganda!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Level $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Ganti nama';

  @override
  String get nameChangeExplainer =>
      'Namamu adalah identitasmu di papan peringkat, jadi tidak bisa diubah. Kamu bisa membeli satu kali ganti nama.';

  @override
  String get nameChangeAfterPurchase =>
      'Setelah membeli, ketuk namamu lagi untuk menggantinya.';

  @override
  String get nameJoinedLeaderboard => 'Kamu sekarang ada di papan peringkat.';

  @override
  String get nameRenameUnavailable =>
      'Ganti nama tidak bisa dilakukan sekarang.';

  @override
  String nameProblemTooShort(int min) {
    return 'Minimal $min karakter.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'Maksimal $max karakter.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Hanya huruf (A–Z), angka, spasi, _ dan -.';

  @override
  String get nameProblemOffensive => 'Silakan pilih nama lain.';

  @override
  String get piggyTitle => 'Celengan';

  @override
  String get piggyFillingHint =>
      'Celenganmu terisi saat kamu membersihkan baris.';

  @override
  String piggyCollect(int coins) {
    return 'Ambil $coins koin — gratis.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Kalau sudah penuh, kamu bisa mengosongkannya gratis — atau membukanya lebih awal dengan video bonus.';

  @override
  String get piggyOpenNow => 'Buka sekarang';

  @override
  String get gameNewPiecesVideo => 'Keping baru (video)';

  @override
  String get gameTapBoardCell => 'Ketuk satu kotak di papan';

  @override
  String get gameDailyChallengeLabel => 'TANTANGAN HARIAN';

  @override
  String get gameOver => 'Permainan Selesai';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Kamu butuh $missing koin lagi untuk bom.';
  }

  @override
  String get gameBombNotHere => 'Bom tidak bisa dipakai di sini sekarang.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Kamu butuh $missing koin lagi untuk itu.';
  }

  @override
  String get gameNotRightNow => 'Tidak bisa sekarang.';

  @override
  String get gameRunSaved => 'Permainan disimpan — “Lanjutkan” di menu.';

  @override
  String get gameOverNoFit => 'Tidak ada kepingmu yang muat lagi di papan.';

  @override
  String get gameOverNoFitNoRotations =>
      'Tidak ada kepingmu yang muat — dan jatah putar sudah habis.';

  @override
  String get gameStarterOfferUnavailable => 'Tidak tersedia sekarang';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — ambil';
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
  String get gameBestSubmitted => 'Rekor baru — terkirim';

  @override
  String get gameReviveFor => 'Lanjut main · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Terbuka: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Paket pemula';

  @override
  String gameOverPoints(int score) {
    return '$score poin';
  }

  @override
  String get gameNewRecord => 'Rekor baru!';

  @override
  String gameStreakDays(int streak) {
    return 'Runtunan $streak hari';
  }

  @override
  String get gameDoubleCoins => 'Gandakan koin';

  @override
  String get gameDoubleDaily => 'Gandakan hadiah harian';

  @override
  String get gamePlayAgain => 'Main lagi';

  @override
  String gameLevelReached(int level) {
    return 'Mencapai level $level!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return 'Naik $count level — level $level!';
  }

  @override
  String get gameStarterOfferReward => '1200 koin + tema Kayu';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'Tinggal $hours jam — hanya sekali!';
  }

  @override
  String get boosterUndo => 'Urungkan';

  @override
  String get boosterSwap => 'Tukar';

  @override
  String get boosterBomb => 'Bom';

  @override
  String get boosterNoRotationsLeft =>
      'Jatah putar habis — bersihkan baris untuk mengisi ulang!';

  @override
  String get onboardingDragPiece => 'Seret satu balok ke papan';

  @override
  String get onboardingFillLine => 'Penuhi satu baris atau kolom';

  @override
  String get onboardingLinesClear => 'Garis penuh akan hilang — dapat poin!';

  @override
  String get coachHintCombo =>
      'Kombo! Bersihkan lagi dalam 3 langkah agar tetap berlanjut';

  @override
  String get coachHintFever => 'MEMBARA! Poin ganda selama menyala';

  @override
  String get coachHintRotation =>
      'Memutar memakai satu jatah — membersihkan garis mengisinya lagi';

  @override
  String get coachHintBooster => 'Tips: kamu bisa memakai booster di bawah';

  @override
  String get coachHintStrategy =>
      'Tips: jangan bersihkan semua garis sekaligus — sisakan ruang untuk keping besar';

  @override
  String get dailyStreakLabel => 'Runtunan';

  @override
  String get dailyBestLabel => 'Terbaik harian';

  @override
  String dailyHistoryNote(int days) {
    return '$days hari terakhir disimpan.';
  }

  @override
  String dailyDayPlayed(int day) {
    return 'Tanggal $day: dimainkan';
  }

  @override
  String dailyDayMissed(int day) {
    return 'Tanggal $day: tidak dimainkan';
  }

  @override
  String get homeDailyCalendar => 'Kalender';

  @override
  String get dailyShareButton => 'Bagikan hasil';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Tantangan Harian $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return '$score poin · kombo terbaik x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Main: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    return 'Kombo: sisa $moves langkah';
  }

  @override
  String get dailyShareCopied => 'Hasil disalin ke papan klip';

  @override
  String get adNotAvailable =>
      'Belum ada video sekarang — coba lagi sebentar lagi';

  @override
  String get howToPlaySpeedTitle => 'Bonus kecepatan';

  @override
  String get howToPlaySpeedBody =>
      'Menaruh keping dengan cepat menambah hingga 30% untuk setiap garis yang dibersihkan. Bonusnya berkurang antara 1,5 dan 4 detik dan ada batasnya — cepat itu menguntungkan tapi tidak menentukan permainan, dan permainan yang tenang dan teliti tetap bisa mengalahkan yang terburu-buru.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Bonus kecepatan $percent persen';
  }

  @override
  String get iapDiamondsSmall => '100 berlian';

  @override
  String get iapDiamondsMedium => '350 berlian';

  @override
  String get iapDiamondsLarge => '1.000 berlian';

  @override
  String get howToPlayTitle => 'Cara bermain Qubble';

  @override
  String get howToPlayIntroHeadline =>
      'Mudah dimulai.\nMenghargai yang berpikir ke depan.';

  @override
  String get howToPlayIntroBody =>
      'Jaga papan tetap lega dan kalahkan skor terbaikmu.';

  @override
  String get howToPlayIntroSemantics =>
      'Tujuan permainan. Jaga papan tetap lega dan kalahkan skor terbaikmu.';

  @override
  String get howToPlayDragTitle => 'Seret & taruh';

  @override
  String get howToPlayDragBody =>
      'Seret salah satu dari tiga keping ke kotak kosong. Setelah ketiganya terpakai, kamu otomatis mendapat tiga keping baru.';

  @override
  String get howToPlayClearTitle => 'Bersihkan garis';

  @override
  String get howToPlayClearBody =>
      'Penuhi satu baris atau kolom. Garis yang penuh akan hilang dan memberi ruang untuk langkah berikutnya.';

  @override
  String get howToPlayComboTitle => 'Rangkai kombo';

  @override
  String get howToPlayComboBody =>
      'Bersihkan garis lain dalam tiga langkah. Setiap kombo berikutnya menaikkan pengali poinmu. Kombo menghitung langkah, bukan detik, jadi tidak akan habis saat kamu berpikir.';

  @override
  String get howToPlayFeverTitle => 'Nyalakan mode membara';

  @override
  String get howToPlayFeverBody =>
      'Membersihkan garis mengisi meteran membara. Saat penuh, ledakan berikutnya bernilai dua kali lipat — rencanakan pembersihan besar.';

  @override
  String get howToPlayBoosterTitle => 'Pakai booster dengan bijak';

  @override
  String get howToPlayBoosterBody =>
      'Booster menyelamatkan permainan yang sulit. Kamu juga bisa mengetuk keping di baki untuk memutarnya.';

  @override
  String get howToPlayDailyTitle => 'Harian & runtunan';

  @override
  String get howToPlayDailyBody =>
      'Tantangan harian memakai keping yang sama untuk semua orang. Main setiap hari untuk memperpanjang runtunan dan bonusmu.';

  @override
  String get howToPlayPiggyTitle => 'Isi celengan';

  @override
  String get howToPlayPiggyBody =>
      'Setiap garis yang dibersihkan mengisi celenganmu. Saat penuh, kamu bisa mengambil koinnya gratis.';

  @override
  String get leaderboardTitle => 'Papan Peringkat';

  @override
  String get leaderboardUnreachable =>
      'Papan peringkat tidak tersedia.\nCoba lagi dengan koneksi internet.';

  @override
  String get leaderboardEmpty => 'Belum ada entri.\nJadilah yang pertama!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Skor terbaikmu ($score) sedang dikirim …';
  }

  @override
  String get leaderboardAutoSubmit => 'Skor terbaikmu dikirim otomatis.';

  @override
  String get puzzleModeTitle => 'Mode Teka-teki';

  @override
  String puzzleLevelTitle(int level) {
    return 'Teka-teki $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Langkah: $moves   •   Target: $target untuk 3 bintang';
  }

  @override
  String get puzzleSolved => 'Terpecahkan!';

  @override
  String get puzzleLeaveTitle => 'Keluar dari teka-teki?';

  @override
  String get puzzleLeaveBody => 'Progresmu di teka-teki ini akan hilang.';

  @override
  String get puzzleKeepPlaying => 'Lanjut main';

  @override
  String get puzzleLeave => 'Keluar';

  @override
  String get puzzleStuckTitle => 'Buntu';

  @override
  String get puzzleRestart => 'Ulangi';

  @override
  String get commonActive => 'Aktif';

  @override
  String get commonTapToActivate => 'Ketuk untuk memakai';

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
  String get trayRotatePiece => 'Putar keping';

  @override
  String get puzzleNextLevel => 'Level berikutnya';

  @override
  String get puzzleBackToOverview => 'Kembali ke daftar';

  @override
  String get puzzleUnsolvable =>
      'Dari sini papan sudah tidak bisa dikosongkan.';

  @override
  String get puzzleExtraMoveVideo => 'Langkah ekstra (video)';

  @override
  String puzzleSolvedCount(int solved) {
    return '$solved terpecahkan';
  }

  @override
  String get settingsTitle => 'Pengaturan';

  @override
  String get storageFailureTitle => 'Qubble tidak bisa memuat data simpananmu';

  @override
  String get storageFailureBody =>
      'Silakan mulai ulang aplikasi. Jika error berlanjut, hanya instal ulang yang bisa membantu. Kamu bisa melaporkannya lewat Pengaturan › Masukan.';

  @override
  String get iapUnavailable => 'Penawaran ini tidak tersedia sekarang.';

  @override
  String get iapFailed =>
      'Pembelian tidak berhasil. Tidak ada biaya yang ditagih.';

  @override
  String get settingsResetProgress => 'Atur ulang progres';

  @override
  String get settingsResetProgressSubtitle =>
      'Skor, koin, level, dan progres kembali ke awal. Pembelian, nama, dan kosmetik tetap ada.';

  @override
  String get settingsResetConfirmTitle => 'Atur ulang progres?';

  @override
  String get settingsResetConfirmBody =>
      'Skor terbaik, koin, level, runtunan, dan semua progres akan dihapus. Ini tidak bisa dibatalkan.\n\nPembelian, nama, serta tema dan skin yang sudah terbuka tetap ada.';

  @override
  String get settingsResetConfirmAction => 'Atur ulang';

  @override
  String get settingsResetDone => 'Progres sudah diatur ulang.';

  @override
  String get settingsSectionGame => 'Permainan';

  @override
  String get settingsSectionSoundHaptics => 'Suara & getaran';

  @override
  String get settingsSectionReminders => 'Pengingat';

  @override
  String get settingsSectionPurchases => 'Pembelian';

  @override
  String get settingsSectionHelpOut => 'Bantu kami';

  @override
  String get settingsSectionLegal => 'Legal';

  @override
  String get settingsSectionLanguage => 'Bahasa';

  @override
  String get settingsGuide => 'Cara bermain';

  @override
  String get settingsGuideSubtitle => 'Aturan, kombo, mode membara & booster';

  @override
  String get settingsSound => 'Suara';

  @override
  String get settingsMusic => 'Musik';

  @override
  String get settingsHaptics => 'Getaran';

  @override
  String get settingsHapticsOff => 'Mati';

  @override
  String get settingsHapticsLight => 'Ringan';

  @override
  String get settingsHapticsStrong => 'Kuat';

  @override
  String get settingsSectionAccessibility => 'Kenyamanan';

  @override
  String get settingsReducedEffects => 'Efek dikurangi';

  @override
  String get settingsReducedEffectsHint =>
      'Lebih sedikit partikel, tanpa guncangan layar dan cahaya';

  @override
  String get settingsNotifications => 'Notifikasi';

  @override
  String get settingsNotificationsSubtitle =>
      'Pengingat harian & perlindungan runtunan';

  @override
  String get settingsNotificationsSystemHint => 'Izinkan di pengaturan sistem.';

  @override
  String get settingsLanguageSystem => 'Bahasa sistem';

  @override
  String get settingsSupporterThanks => 'Pendukung — terima kasih!';

  @override
  String get settingsSupporterPack => 'Paket pendukung';

  @override
  String get settingsSupporterPackSubtitle =>
      'Tema & skin eksklusif + 1.500 koin';

  @override
  String get settingsRestorePurchases => 'Pulihkan pembelian';

  @override
  String get settingsRestoring => 'Memulihkan pembelian…';

  @override
  String get settingsRateApp => 'Beri nilai aplikasi';

  @override
  String get settingsRateAppSubtitle => 'Beri ulasan di toko';

  @override
  String get settingsStoreUnavailable =>
      'Toko tidak tersedia di perangkat ini.';

  @override
  String get settingsFeedback => 'Kirim masukan';

  @override
  String get settingsFeedbackSubtitle => 'Laporkan ide & bug (lewat GitHub)';

  @override
  String get settingsAdPrivacy => 'Privasi iklan';

  @override
  String get settingsAdPrivacySubtitle => 'Lihat atau ubah persetujuan iklanmu';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Tidak ada opsi iklan yang diperlukan di perangkat ini.';

  @override
  String get settingsPrivacy => 'Kebijakan privasi';

  @override
  String get settingsImprint => 'Informasi hukum';

  @override
  String get settingsPageOpenFailed => 'Halaman tidak dapat dibuka.';

  @override
  String get settingsFooter => 'Qubble • Puzzle Balok Offline';

  @override
  String get settingsAdminSection => 'Admin (uji)';

  @override
  String get settingsAdminEnabled => 'Mode admin aktif';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Ketuk $count kali lagi untuk mode admin';
  }

  @override
  String settingsAdminCoins(int coins) {
    return '$coins koin';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Hanya untuk pengujian — jangan tampilkan di tangkapan layar rilis';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount koin';
  }

  @override
  String get settingsAdminResetCoins => 'Jadikan koin 0';

  @override
  String get feedbackTitle => 'Masukan';

  @override
  String get feedbackIntroShort =>
      'Apa yang kamu suka, apa yang mengganggu, apa yang kurang? Hal kecil juga membantu — makin konkret, makin baik.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Hanya $build dan jenis perangkatmu yang dilampirkan — supaya aku tahu versi mana yang kamu maksud.';
  }

  @override
  String get feedbackSendByMail => 'Kirim lewat email';

  @override
  String get feedbackPreferGithub => 'Lebih suka issue GitHub';

  @override
  String get feedbackThanksMail => 'Terima kasih! Tinggal kirim pesannya.';

  @override
  String get feedbackNoMailApp =>
      'Aplikasi email tidak ditemukan. Coba lewat GitHub di bawah.';

  @override
  String get feedbackEmptyHint => 'Tulis sesuatu dulu.';

  @override
  String get leaderboardRefresh => 'Muat ulang';

  @override
  String get leaderboardRetry => 'Coba lagi';

  @override
  String get feedbackHint => 'Masukanmu…';

  @override
  String get feedbackSubmit => 'Kirim masukan';

  @override
  String get feedbackOpenFailed => 'GitHub tidak bisa dibuka. Coba lagi nanti.';

  @override
  String get feedbackGithubNote =>
      'GitHub akan terbuka — ketuk \"Submit new issue\" di sana. (Perlu login GitHub satu kali.)';

  @override
  String get shopTitle => 'Toko';

  @override
  String get shopWebDemoNote =>
      'Pembelian hanya tersedia di aplikasi dari Play Store. Versi web ini adalah demo gratis — kamu tetap bisa memainkan semuanya di sini.';

  @override
  String get shopSupporterExplainer =>
      'Qubble tidak menampilkan iklan paksa — kamu tidak pernah harus membeli apa pun. Paket pendukung (tema Aurora, skin Kristal, 1.500 koin, lencana pendukung) adalah ucapan terima kasih karena sudah mendukung game ini. Pembelian terhubung dengan akun tokomu dan bisa dipulihkan kapan saja.';

  @override
  String get shopSupporterContents => 'Tema Aurora + skin Kristal + 1.500 koin';

  @override
  String get themesTitle => 'Tema';

  @override
  String get themesSupporterOnly => 'Khusus paket pendukung (lihat toko)';

  @override
  String get themesInSupporterPack => 'Dalam paket pendukung';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'Koin tidak cukup (butuh $cost, punya $coins)';
  }

  @override
  String get skinsTitle => 'Skin balok';

  @override
  String get skinsNotEnoughDiamonds =>
      'Berlian tidak cukup (tukar emas di bawah)';

  @override
  String get skinsNotEnoughCoins => 'Koin tidak cukup';

  @override
  String get skinsNotEnoughGold => 'Emas tidak cukup.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold emas = 1 berlian. Berlian membuka skin terbaik — kumpulkan pelan-pelan saja.';
  }

  @override
  String get statsTitle => 'Statistik';

  @override
  String get statsAverageScore => 'Rata-rata skor';

  @override
  String get statsBestCombo => 'Kombo terbaik';

  @override
  String get statsGames => 'Permainan';

  @override
  String get statsLinesCleared => 'Baris dibersihkan';

  @override
  String get statsPiecesPlaced => 'Keping ditaruh';

  @override
  String get statsCoins => 'Koin';

  @override
  String get missionsTitle => 'Misi';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Taruh $countString keping';
  }

  @override
  String missionClearRows(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Bersihkan $countString baris';
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

    return 'Tembus $countString poin dalam satu permainan';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Mainkan $countString permainan';
  }

  @override
  String get achievementsTitle => 'Pencapaian';

  @override
  String get achievementFirstGameTitle => 'Permainan pertama';

  @override
  String get achievementFirstGameBody => 'Mainkan permainan pertamamu';

  @override
  String get achievementGames25Title => 'Pemain tetap';

  @override
  String get achievementGames25Body => 'Mainkan 25 permainan';

  @override
  String get achievementGames100Title => 'Ketagihan';

  @override
  String get achievementGames100Body => 'Mainkan 100 permainan';

  @override
  String get achievementScore1kTitle => 'Pendaki';

  @override
  String get achievementScore1kBody => 'Capai 1.000 poin';

  @override
  String get achievementScore5kTitle => 'Pro';

  @override
  String get achievementScore5kBody => 'Capai 5.000 poin';

  @override
  String get achievementScore10kTitle => 'Master';

  @override
  String get achievementScore10kBody => 'Capai 10.000 poin';

  @override
  String get achievementScore25kTitle => 'Legenda';

  @override
  String get achievementScore25kBody => 'Capai 25.000 poin';

  @override
  String get achievementLines100Title => 'Rapi';

  @override
  String get achievementLines100Body => 'Bersihkan total 100 baris';

  @override
  String get achievementLines1000Title => 'Bersih-bersih besar';

  @override
  String get achievementLines1000Body => 'Bersihkan total 1.000 baris';

  @override
  String get achievementCombo5Title => 'Pemula kombo';

  @override
  String get achievementCombo5Body => 'Capai kombo x5';

  @override
  String get achievementCombo10Title => 'Raja kombo';

  @override
  String get achievementCombo10Body => 'Capai kombo x10';

  @override
  String get achievementLevel10Title => 'Berpengalaman';

  @override
  String get achievementLevel10Body => 'Capai level 10';

  @override
  String get achievementLevel20Title => 'Veteran';

  @override
  String get achievementLevel20Body => 'Capai level 20';

  @override
  String get achievementStreak7Title => 'Seminggu penuh';

  @override
  String get achievementStreak7Body => 'Runtunan harian 7 hari';

  @override
  String get achievementStreak30Title => 'Sebulan penuh';

  @override
  String get achievementStreak30Body => 'Runtunan harian 30 hari';

  @override
  String get achievementPuzzles10Title => 'Jago teka-teki';

  @override
  String get achievementPuzzles10Body => 'Pecahkan 10 teka-teki';

  @override
  String get achievementPieces5000Title => 'Pembangun';

  @override
  String get achievementPieces5000Body => 'Taruh 5.000 keping';

  @override
  String streakRepairTitle(int streak) {
    return 'Runtunan $streak harimu dalam bahaya!';
  }

  @override
  String get streakRepairBody =>
      'Kemarin kamu tidak main — selamatkan runtunanmu:';

  @override
  String get streakRepairFailed => 'Tidak bisa diperbaiki.';

  @override
  String comebackGift(int coins) {
    return 'Selamat datang kembali! +$coins koin';
  }

  @override
  String get notificationsOptInTitle => 'Pengingat?';

  @override
  String get notificationsOptInBody =>
      'Mau kami ingatkan tantangan harianmu dan melindungi runtunanmu? Kamu bisa mengubahnya kapan saja di pengaturan.';

  @override
  String get notificationsOptInAccept => 'Ya, boleh';

  @override
  String get notificationChannelDescription =>
      'Pengingat harian, peringatan runtunan, ajakan kembali';

  @override
  String get notificationDailyTitle => 'Teka-teki harianmu menunggu 🧩';

  @override
  String get notificationDailyBody => 'Mainkan tantangan hari ini!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 Runtunan $streak harimu dalam bahaya!';
  }

  @override
  String get notificationStreakBody => 'Main hari ini supaya tetap berlanjut.';

  @override
  String get notificationComebackTitle => 'Balokmu menunggumu 🧩';

  @override
  String get notificationComebackBody => 'Kembali dan ambil hadiahmu!';

  @override
  String get iapSupporterPack => 'Paket pendukung';

  @override
  String get iapCoinsSmall => '500 koin';

  @override
  String get iapCoinsMedium => '2.000 koin';

  @override
  String get iapCoinsLarge => '6.000 koin';

  @override
  String get iapStarterPack => 'Paket pemula';

  @override
  String get iapRename => 'Ganti nama';

  @override
  String get iapNeonTheme => 'Tema Neon';

  @override
  String get settingsLeaderboardDelete => 'Hapus entri papan peringkat';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Menghapus nama dan skormu dari daftar publik';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'Hapus entrimu?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Nama dan skormu akan dihapus dari papan peringkat. Progres permainanmu tidak berubah. Kamu bisa ikut papan peringkat lagi kapan saja.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'Entri papan peringkatmu sudah dihapus.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Entri tidak bisa dihapus. Periksa koneksimu dan coba lagi.';

  @override
  String get leaderboardReport => 'Laporkan nama ini';

  @override
  String get leaderboardBlock => 'Blokir';

  @override
  String leaderboardBlocked(String name) {
    return '$name disembunyikan untukmu';
  }

  @override
  String get leaderboardUndo => 'Urungkan';

  @override
  String leaderboardBlockedCount(int count) {
    return '$count entri kamu sembunyikan';
  }

  @override
  String get leaderboardUnblockAll => 'Tampilkan lagi';

  @override
  String get leaderboardReportUnavailable =>
      'Pelaporan tidak tersedia sekarang.';

  @override
  String get leaderboardReportSent =>
      'Terima kasih — laporanmu sedang dikirim.';

  @override
  String get leaderboardRules =>
      'Nama bersifat publik. Tidak boleh ada hinaan, ujaran kebencian, atau apa pun yang mengidentifikasi orang sungguhan. Nama yang melanggar akan dihapus.';

  @override
  String get leaderboardRulesAccept => 'Saya mengerti';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked dari $total terbuka';
  }

  @override
  String get settingsSectionData => 'Data tersimpan';

  @override
  String get gameRotatePiece => 'Putar keping';

  @override
  String get themeClassic => 'Klasik';

  @override
  String get themeFade => 'Pastel';

  @override
  String get themeNeon => 'Neon';

  @override
  String get themeOcean => 'Samudra';

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
  String get skinGradient => 'Gradasi';

  @override
  String get skinOutline => 'Garis tepi';

  @override
  String get skinGlossy => 'Mengilap';

  @override
  String get skinStripe => 'Garis-garis';

  @override
  String get skinBevel => 'Timbul';

  @override
  String get skinGlow => 'Pendar';

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
