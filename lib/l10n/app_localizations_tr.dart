// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class L10nTr extends L10n {
  L10nTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Oyna';

  @override
  String get commonLater => 'Sonra';

  @override
  String get commonNotNow => 'Şimdi değil';

  @override
  String get commonCancel => 'İptal';

  @override
  String get commonBuy => 'Satın al';

  @override
  String get commonSave => 'Kaydet';

  @override
  String get commonCollect => 'Topla';

  @override
  String get nameNewName => 'Yeni ad';

  @override
  String get nameFieldLabel => 'Ad';

  @override
  String get piggyFullTitle => 'Kumbara doldu!';

  @override
  String get piggyKeepSaving => 'Biriktirmeye devam et';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$coins / $capacity toplandı.';
  }

  @override
  String get homeContinueRun => 'Devam et';

  @override
  String get homeVideo => 'Video';

  @override
  String get commonGotIt => 'Anladım';

  @override
  String get commonHome => 'Ana menü';

  @override
  String get commonScore => 'PUAN';

  @override
  String get commonBest => 'REKOR';

  @override
  String commonLevelShort(int level) {
    return 'Seviye $level';
  }

  @override
  String get homeNewRun => 'Yeni oyun başlat';

  @override
  String get homeBackToExit => 'Çıkmak için tekrar geri tuşuna bas';

  @override
  String get homeEnableLeaderboard => 'Sıralamaya katıl';

  @override
  String get homeBestScore => 'REKOR';

  @override
  String get homeDailyChallenge => 'Günlük Meydan Okuma';

  @override
  String get homeDailyOpenToday => 'Bugün seni bekliyor';

  @override
  String homeDailyNextIn(String time) {
    return 'Sonraki meydan okuma: $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return '$streak günlük seri';
  }

  @override
  String get homeLeaderboard => 'Sıralama';

  @override
  String get homePuzzleMode => 'Bulmaca Modu';

  @override
  String get homeHowToPlay => 'Qubble nasıl oynanır';

  @override
  String get homeWeekendBonus => 'Hafta sonu: çifte altın!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Seviye $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Adını değiştir';

  @override
  String get nameChangeExplainer =>
      'Adın sıralamadaki kimliğin olduğu için sabittir. Tek seferlik bir ad değişikliği satın alabilirsin.';

  @override
  String get nameChangeAfterPurchase =>
      'Satın aldıktan sonra değiştirmek için adına tekrar dokun.';

  @override
  String get nameJoinedLeaderboard => 'Artık sıralamadasın.';

  @override
  String nameProblemTooShort(int min) {
    return 'En az $min karakter.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'En fazla $max karakter.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Yalnızca Latin harfleri (A–Z, Türkçe karakterler dahil), rakamlar, boşluk, _ ve -.';

  @override
  String get nameProblemOffensive => 'Lütfen başka bir ad seç.';

  @override
  String get piggyTitle => 'Kumbara';

  @override
  String get piggyFillingHint => 'Satır temizledikçe kumbaran dolar.';

  @override
  String piggyCollect(int coins) {
    return '$coins altını ücretsiz topla.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Dolunca ücretsiz boşaltabilirsin — ya da bir bonus videoyla daha erken açabilirsin.';

  @override
  String get piggyOpenNow => 'Şimdi aç';

  @override
  String get gameNewPiecesVideo => 'Yeni parçalar (video)';

  @override
  String get gameTapBoardCell => 'Tahtada bir kareye dokun';

  @override
  String get gameDailyChallengeLabel => 'GÜNLÜK MEYDAN OKUMA';

  @override
  String get gameOver => 'Oyun Bitti';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Bomba için $missing altın daha gerekiyor.';
  }

  @override
  String get gameBombNotHere => 'Bomba şu anda burada çalışmıyor.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Bunun için $missing altın daha gerekiyor.';
  }

  @override
  String get gameNotRightNow => 'Şu anda mümkün değil.';

  @override
  String get gameRunSaved => 'Oyun kaydedildi — menüde “Devam et”.';

  @override
  String get gameOverNoFit => 'Parçalarından hiçbiri artık tahtaya sığmıyor.';

  @override
  String get gameOverNoFitNoRotations =>
      'Parçalarından hiçbiri sığmıyor — ve döndürme hakların bitti.';

  @override
  String get gameStarterOfferUnavailable => 'Şu anda kullanılamıyor';

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
    return 'Başarım: $title';
  }

  @override
  String get gameBestSubmitted => 'Yeni rekor gönderildi';

  @override
  String get gameReviveFor => 'Devam et · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Açıldı: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Başlangıç paketi';

  @override
  String gameOverPoints(int score) {
    return '$score puan';
  }

  @override
  String get gameNewRecord => 'Yeni rekor!';

  @override
  String gameStreakDays(int streak) {
    return '$streak günlük seri';
  }

  @override
  String get gameDoubleCoins => 'Altını ikiye katla';

  @override
  String get gameDoubleDaily => 'Günlük ödülü ikiye katla';

  @override
  String get gamePlayAgain => 'Tekrar oyna';

  @override
  String gameLevelReached(int level) {
    return '$level. seviyeye ulaştın!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return '$count seviye atladın — seviye $level!';
  }

  @override
  String get gameStarterOfferReward => '1200 altın + Ahşap teması';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'Sadece $hours saat kaldı — tek seferlik!';
  }

  @override
  String get boosterUndo => 'Geri al';

  @override
  String get boosterSwap => 'Değiştir';

  @override
  String get boosterBomb => 'Bomba';

  @override
  String get boosterNoRotationsLeft =>
      'Döndürme hakkı kalmadı — yenilemek için satır temizle!';

  @override
  String get onboardingDragPiece => 'Bir bloğu tahtaya sürükle';

  @override
  String get onboardingFillLine => 'Bir satırı veya sütunu tamamen doldur';

  @override
  String get onboardingLinesClear => 'Dolan çizgiler kaybolur — puan!';

  @override
  String get coachHintCombo =>
      'Kombo! Korumak için 3 hamle içinde yine temizle';

  @override
  String get coachHintFever => 'ATEŞ! Parladığı sürece çifte puan';

  @override
  String get coachHintRotation =>
      'Döndürmek bir hak harcar — temizlemek hakları yeniler';

  @override
  String get coachHintBooster => 'İpucu: aşağıdan güçlendirici kullanabilirsin';

  @override
  String get coachHintStrategy =>
      'İpucu: her çizgiyi hemen temizleme — büyük parçalara yer bırak';

  @override
  String get dailyStreakLabel => 'Seri';

  @override
  String get dailyBestLabel => 'Günlük rekor';

  @override
  String dailyHistoryNote(int days) {
    return 'Son $days gün saklanır.';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day. gün: oynandı';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day. gün: oynanmadı';
  }

  @override
  String get homeDailyCalendar => 'Takvim';

  @override
  String get dailyShareButton => 'Sonucu paylaş';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Günlük Meydan Okuma $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return '$score puan · en iyi kombo x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Oyna: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    return 'Kombo: $moves hamle kaldı';
  }

  @override
  String get dailyShareCopied => 'Sonuç panoya kopyalandı';

  @override
  String get adNotAvailable => 'Şu anda video yok — birazdan tekrar dene';

  @override
  String get howToPlaySpeedTitle => 'Hız bonusu';

  @override
  String get howToPlaySpeedBody =>
      'Hızlı yerleştirmek, temizlenen her çizgiye %30’a kadar ekler. Bonus 1,5 ile 4 saniye arasında azalır ve bir üst sınırı vardır: hızlı olmak kazandırır ama oyunu belirlemez — sakin ve dikkatli bir oyun, aceleci bir oyunu yine de geçebilir.';

  @override
  String gameSpeedBonus(int percent) {
    return '+%$percent';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Yüzde $percent hız bonusu';
  }

  @override
  String get iapDiamondsSmall => '100 elmas';

  @override
  String get iapDiamondsMedium => '350 elmas';

  @override
  String get iapDiamondsLarge => '1.000 elmas';

  @override
  String get howToPlayTitle => 'Qubble nasıl oynanır';

  @override
  String get howToPlayIntroHeadline =>
      'Başlaması kolay.\nÖnceden düşünene kazandırır.';

  @override
  String get howToPlayIntroBody => 'Tahtayı boş tut ve rekorunu kır.';

  @override
  String get howToPlayIntroSemantics =>
      'Oyunun amacı. Tahtayı boş tut ve rekorunu kır.';

  @override
  String get howToPlayDragTitle => 'Sürükle ve yerleştir';

  @override
  String get howToPlayDragBody =>
      'Üç parçadan birini boş karelere sürükle. Üçünü de kullandığında otomatik olarak üç yeni parça gelir.';

  @override
  String get howToPlayClearTitle => 'Çizgileri temizle';

  @override
  String get howToPlayClearBody =>
      'Bir satırı ya da sütunu tamamen doldur. Dolan çizgiler kaybolur ve sonraki hamlen için yer açılır.';

  @override
  String get howToPlayComboTitle => 'Kombo zinciri kur';

  @override
  String get howToPlayComboBody =>
      'Üç hamle içinde bir çizgi daha temizle. Her yeni kombo puan çarpanını artırır. Kombo saniyeleri değil hamleleri sayar; düşünürken asla bitmez.';

  @override
  String get howToPlayFeverTitle => 'Ateşi yak';

  @override
  String get howToPlayFeverBody =>
      'Çizgi temizlemek ateş göstergesini doldurur. Gösterge dolunca bir sonraki patlama çift sayılır — büyük temizlikleri önceden planla.';

  @override
  String get howToPlayBoosterTitle => 'Güçlendiricileri akıllıca kullan';

  @override
  String get howToPlayBoosterBody =>
      'Güçlendiriciler zor oyunları kurtarır. Alttaki bir parçaya dokunarak onu döndürebilirsin de.';

  @override
  String get howToPlayDailyTitle => 'Günlük meydan okuma ve seri';

  @override
  String get howToPlayDailyBody =>
      'Günlük meydan okumada herkes aynı parçalarla oynar. Serini ve bonusunu büyütmek için her gün oyna.';

  @override
  String get howToPlayPiggyTitle => 'Kumbarayı doldur';

  @override
  String get howToPlayPiggyBody =>
      'Temizlenen her çizgi kumbaranı doldurur. Dolunca altınları ücretsiz toplayabilirsin.';

  @override
  String get leaderboardTitle => 'Sıralama';

  @override
  String get leaderboardUnreachable =>
      'Sıralama kullanılamıyor.\nİnternet bağlantısıyla tekrar dene.';

  @override
  String get leaderboardEmpty => 'Henüz kimse yok.\nİlk sen ol!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Rekorun ($score) gönderiliyor …';
  }

  @override
  String get leaderboardAutoSubmit => 'Rekorun otomatik olarak gönderilir.';

  @override
  String get puzzleModeTitle => 'Bulmaca Modu';

  @override
  String puzzleLevelTitle(int level) {
    return 'Bulmaca $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Hamle: $moves   •   Hedef: 3 yıldız için $target';
  }

  @override
  String get puzzleSolved => 'Çözüldü!';

  @override
  String get puzzleLeaveTitle => 'Bulmacadan çıkılsın mı?';

  @override
  String get puzzleLeaveBody => 'Bu bulmacadaki ilerlemen kaybolacak.';

  @override
  String get puzzleKeepPlaying => 'Oynamaya devam et';

  @override
  String get puzzleLeave => 'Çık';

  @override
  String get puzzleStuckTitle => 'Çıkmaz';

  @override
  String get puzzleRestart => 'Yeniden başla';

  @override
  String get commonActive => 'Etkin';

  @override
  String get commonRestore => 'Geri yükle';

  @override
  String get skinsExchangeGold => 'Altın takas et';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Parçayı döndür';

  @override
  String get puzzleNextLevel => 'Sonraki seviye';

  @override
  String get puzzleBackToOverview => 'Listeye dön';

  @override
  String get puzzleUnsolvable => 'Buradan artık tahta boşaltılamaz.';

  @override
  String get puzzleExtraMoveVideo => 'Ekstra hamle (video)';

  @override
  String puzzleSolvedCount(int solved) {
    return '$solved çözüldü';
  }

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get storageFailureTitle => 'Qubble kayıtlı oyununu yükleyemiyor';

  @override
  String get storageFailureBody =>
      'Lütfen uygulamayı yeniden başlat. Hata sürerse yalnızca yeniden yüklemek işe yarar. Hatayı Ayarlar › Geri bildirim bölümünden bildirebilirsin.';

  @override
  String get iapUnavailable => 'Bu teklif şu anda kullanılamıyor.';

  @override
  String get iapFailed => 'Satın alma tamamlanmadı. Hiçbir ücret alınmadı.';

  @override
  String get settingsResetProgress => 'İlerlemeyi sıfırla';

  @override
  String get settingsResetProgressSubtitle =>
      'Puan, altın, seviye ve ilerleme başa döner. Satın almalar, ad ve kozmetikler korunur.';

  @override
  String get settingsResetConfirmTitle => 'İlerleme sıfırlansın mı?';

  @override
  String get settingsResetConfirmBody =>
      'Rekor, altın, seviye, seri ve tüm ilerleme silinecek. Bu geri alınamaz.\n\nSatın almaların, adın ve açtığın temalar ile görünümler korunur.';

  @override
  String get settingsResetConfirmAction => 'Sıfırla';

  @override
  String get settingsResetDone => 'İlerleme sıfırlandı.';

  @override
  String get settingsSectionGame => 'Oyun';

  @override
  String get settingsSectionSoundHaptics => 'Ses ve titreşim';

  @override
  String get settingsSectionReminders => 'Hatırlatıcılar';

  @override
  String get settingsSectionPurchases => 'Satın almalar';

  @override
  String get settingsSectionHelpOut => 'Destek ol';

  @override
  String get settingsSectionLegal => 'Yasal';

  @override
  String get settingsSectionLanguage => 'Dil';

  @override
  String get settingsGuide => 'Nasıl oynanır';

  @override
  String get settingsGuideSubtitle =>
      'Kurallar, kombolar, ateş ve güçlendiriciler';

  @override
  String get settingsSound => 'Ses';

  @override
  String get settingsMusic => 'Müzik';

  @override
  String get settingsHaptics => 'Titreşim';

  @override
  String get settingsHapticsOff => 'Kapalı';

  @override
  String get settingsHapticsLight => 'Hafif';

  @override
  String get settingsHapticsStrong => 'Güçlü';

  @override
  String get settingsSectionAccessibility => 'Konfor';

  @override
  String get settingsReducedEffects => 'Azaltılmış efektler';

  @override
  String get settingsReducedEffectsHint =>
      'Daha az parçacık, ekran sarsıntısı ve parıltı yok';

  @override
  String get settingsNotifications => 'Bildirimler';

  @override
  String get settingsNotificationsSubtitle =>
      'Günlük hatırlatıcı ve seri koruması';

  @override
  String get settingsNotificationsSystemHint => 'Sistem ayarlarından izin ver.';

  @override
  String get settingsLanguageSystem => 'Sistem dili';

  @override
  String get settingsSupporterThanks => 'Destekçi — teşekkürler!';

  @override
  String get settingsSupporterPack => 'Destekçi paketi';

  @override
  String get settingsSupporterPackSubtitle =>
      'Özel tema ve görünüm + 1.500 altın';

  @override
  String get settingsRestorePurchases => 'Satın almaları geri yükle';

  @override
  String get settingsRestoring => 'Satın almalar geri yükleniyor…';

  @override
  String get settingsRateApp => 'Uygulamayı değerlendir';

  @override
  String get settingsRateAppSubtitle => 'Mağazada puan ver';

  @override
  String get settingsStoreUnavailable => 'Mağaza bu cihazda kullanılamıyor.';

  @override
  String get settingsFeedback => 'Geri bildirim gönder';

  @override
  String get settingsFeedbackSubtitle =>
      'Fikir ve hata bildir (GitHub üzerinden)';

  @override
  String get settingsAdPrivacy => 'Reklam gizliliği';

  @override
  String get settingsAdPrivacySubtitle =>
      'Reklam iznini görüntüle veya değiştir';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Bu cihazda reklam seçeneği gerekmiyor.';

  @override
  String get settingsPrivacy => 'Gizlilik politikası';

  @override
  String get settingsImprint => 'Künye';

  @override
  String get settingsPageOpenFailed => 'Sayfa açılamadı.';

  @override
  String get settingsFooter => 'Qubble • Çevrimdışı Blok Bulmaca';

  @override
  String get settingsAdminSection => 'Yönetici (test)';

  @override
  String get settingsAdminEnabled => 'Yönetici modu açıldı';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Yönetici modu için $count kez daha dokun';
  }

  @override
  String settingsAdminCoins(int coins) {
    return '$coins altın';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Yalnızca test için — sürüm ekran görüntülerinde asla gösterme';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount altın';
  }

  @override
  String get settingsAdminResetCoins => 'Altını 0 yap';

  @override
  String get feedbackTitle => 'Geri bildirim';

  @override
  String get feedbackIntroShort =>
      'Neyi seviyorsun, ne rahatsız ediyor, ne eksik? Küçük şeyler de yardımcı olur — ne kadar somut, o kadar iyi.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Yalnızca $build ve cihaz türün eklenir — hangi sürümden bahsettiğini bilmem için.';
  }

  @override
  String get feedbackSendByMail => 'E-postayla gönder';

  @override
  String get feedbackPreferGithub => 'GitHub issue tercih ederim';

  @override
  String get feedbackThanksMail =>
      'Teşekkürler! Şimdi mesajı göndermen yeterli.';

  @override
  String get feedbackNoMailApp =>
      'E-posta uygulaması bulunamadı. Aşağıdaki GitHub yolunu dene.';

  @override
  String get feedbackEmptyHint => 'Lütfen önce bir şey yaz.';

  @override
  String get leaderboardRefresh => 'Yenile';

  @override
  String get leaderboardRetry => 'Tekrar dene';

  @override
  String get feedbackHint => 'Geri bildirimin…';

  @override
  String get feedbackSubmit => 'Geri bildirim gönder';

  @override
  String get feedbackOpenFailed => 'GitHub açılamadı. Daha sonra tekrar dene.';

  @override
  String get feedbackGithubNote =>
      'GitHub açılır — orada \"Submit new issue\" düğmesine dokun. (Bir kerelik GitHub girişi gerekir.)';

  @override
  String get shopTitle => 'Mağaza';

  @override
  String get shopWebDemoNote =>
      'Satın almalar yalnızca Play Store’daki uygulamada mümkündür. Bu web sürümü ücretsiz bir demodur — yine de her şeyi burada oynayabilirsin.';

  @override
  String get shopSupporterExplainer =>
      'Qubble zorunlu reklam göstermez — hiçbir şey satın almak zorunda değilsin. Destekçi paketi (Aurora teması, Kristal görünümü, 1.500 altın, destekçi rozeti) oyunu desteklediğin için bir teşekkürdür. Satın almalar mağaza hesabına bağlıdır ve istediğin zaman geri yüklenebilir.';

  @override
  String get shopSupporterContents =>
      'Aurora teması + Kristal görünümü + 1.500 altın';

  @override
  String get themesTitle => 'Temalar';

  @override
  String get themesSupporterOnly =>
      'Yalnızca destekçi paketinde (mağazaya bak)';

  @override
  String get skinsTitle => 'Blok görünümleri';

  @override
  String get skinsNotEnoughCoins => 'Yeterli altın yok';

  @override
  String get skinsNotEnoughGold => 'Yeterli altın yok.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold altın = 1 elmas. Elmaslar en güzel görünümleri açar — biriktirmek için acele etme.';
  }

  @override
  String get statsTitle => 'İstatistikler';

  @override
  String get statsAverageScore => 'Ort. puan';

  @override
  String get statsBestCombo => 'En iyi kombo';

  @override
  String get statsGames => 'Oyunlar';

  @override
  String get statsLinesCleared => 'Temizlenen satır';

  @override
  String get statsPiecesPlaced => 'Yerleştirilen parça';

  @override
  String get statsCoins => 'Altın';

  @override
  String questCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'x$countString komboya ulaş';
  }

  @override
  String questScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Bir oyunda $countString puanı geç';
  }

  @override
  String get achievementsTitle => 'Başarımlar';

  @override
  String get achievementFirstGameTitle => 'İlk oyun';

  @override
  String get achievementFirstGameBody => 'İlk oyununu oyna';

  @override
  String get achievementGames25Title => 'Müdavim';

  @override
  String get achievementGames25Body => '25 oyun oyna';

  @override
  String get achievementGames100Title => 'Bağımlı';

  @override
  String get achievementGames100Body => '100 oyun oyna';

  @override
  String get achievementScore1kTitle => 'Tırmanıcı';

  @override
  String get achievementScore1kBody => '1.000 puana ulaş';

  @override
  String get achievementScore5kTitle => 'Profesyonel';

  @override
  String get achievementScore5kBody => '5.000 puana ulaş';

  @override
  String get achievementScore10kTitle => 'Usta';

  @override
  String get achievementScore10kBody => '10.000 puana ulaş';

  @override
  String get achievementScore25kTitle => 'Efsane';

  @override
  String get achievementScore25kBody => '25.000 puana ulaş';

  @override
  String get achievementLines100Title => 'Düzenli';

  @override
  String get achievementLines100Body => 'Toplam 100 satır temizle';

  @override
  String get achievementLines1000Title => 'Bahar temizliği';

  @override
  String get achievementLines1000Body => 'Toplam 1.000 satır temizle';

  @override
  String get achievementCombo5Title => 'Kombo çırağı';

  @override
  String get achievementCombo5Body => 'x5 komboya ulaş';

  @override
  String get achievementCombo10Title => 'Kombo kralı';

  @override
  String get achievementCombo10Body => 'x10 komboya ulaş';

  @override
  String get achievementLevel10Title => 'Deneyimli';

  @override
  String get achievementLevel10Body => '10. seviyeye ulaş';

  @override
  String get achievementLevel20Title => 'Kıdemli';

  @override
  String get achievementLevel20Body => '20. seviyeye ulaş';

  @override
  String get achievementStreak7Title => 'Haftalık seri';

  @override
  String get achievementStreak7Body => 'Günlük meydan okumada 7 günlük seri';

  @override
  String get achievementStreak30Title => 'Aylık seri';

  @override
  String get achievementStreak30Body => 'Günlük meydan okumada 30 günlük seri';

  @override
  String get achievementPuzzles10Title => 'Bulmaca ustası';

  @override
  String get achievementPuzzles10Body => '10 bulmaca çöz';

  @override
  String get achievementPieces5000Title => 'İnşaatçı';

  @override
  String get achievementPieces5000Body => '5.000 parça yerleştir';

  @override
  String streakRepairTitle(int streak) {
    return '$streak günlük serin tehlikede!';
  }

  @override
  String get streakRepairBody => 'Dün oynamadın — serini kurtar:';

  @override
  String get streakRepairFailed => 'Onarım mümkün değil.';

  @override
  String comebackGift(int coins) {
    return 'Tekrar hoş geldin! +$coins altın';
  }

  @override
  String get notificationsOptInTitle => 'Hatırlatıcılar?';

  @override
  String get notificationsOptInBody =>
      'Günlük meydan okumayı sana hatırlatalım ve serini koruyalım mı? Bunu istediğin zaman ayarlardan değiştirebilirsin.';

  @override
  String get notificationsOptInAccept => 'Evet, lütfen';

  @override
  String get notificationChannelDescription =>
      'Günlük hatırlatıcı, seri uyarısı, geri dönüş';

  @override
  String get notificationDailyTitle => 'Günlük bulmacan seni bekliyor 🧩';

  @override
  String get notificationDailyBody => 'Bugünün meydan okumasını oyna!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 $streak günlük serin tehlikede!';
  }

  @override
  String get notificationStreakBody => 'Serini korumak için bugün oyna.';

  @override
  String get notificationComebackTitle => 'Blokların seni bekliyor 🧩';

  @override
  String get notificationComebackBody => 'Geri dön ve hediyeni al!';

  @override
  String get iapSupporterPack => 'Destekçi paketi';

  @override
  String get iapCoinsSmall => '500 altın';

  @override
  String get iapCoinsMedium => '2.000 altın';

  @override
  String get iapCoinsLarge => '6.000 altın';

  @override
  String get iapStarterPack => 'Başlangıç paketi';

  @override
  String get iapRename => 'Ad değişikliği';

  @override
  String get iapNeonTheme => 'Neon teması';

  @override
  String get settingsLeaderboardDelete => 'Sıralama kaydını sil';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Adını ve puanını herkese açık listeden kaldırır';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'Kaydın silinsin mi?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Adın ve puanın sıralamadan kaldırılacak. Oyundaki ilerlemen etkilenmez. Sıralamaya istediğin zaman yeniden katılabilirsin.';

  @override
  String get settingsLeaderboardDeleteDone => 'Sıralama kaydın silindi.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Kayıt silinemedi. Bağlantını kontrol edip tekrar dene.';

  @override
  String get leaderboardReport => 'Bu adı bildir';

  @override
  String get leaderboardBlock => 'Engelle';

  @override
  String leaderboardBlocked(String name) {
    return '$name senin için gizlendi';
  }

  @override
  String get leaderboardUndo => 'Geri al';

  @override
  String leaderboardBlockedCount(int count) {
    return '$count kaydı gizledin';
  }

  @override
  String get leaderboardUnblockAll => 'Yeniden göster';

  @override
  String get leaderboardReportUnavailable => 'Şu anda bildirim yapılamıyor.';

  @override
  String get leaderboardReportSent => 'Teşekkürler — bildirimin yolda.';

  @override
  String get leaderboardRules =>
      'Adlar herkese açıktır. Hakaret, aşağılayıcı ifade ve gerçek bir kişiyi tanımlayan hiçbir şey olmamalı. Bu kurala uymayan adlar kaldırılır.';

  @override
  String get leaderboardRulesAccept => 'Anladım';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked / $total açıldı';
  }

  @override
  String get settingsSectionData => 'Kayıtlı veriler';

  @override
  String get gameRotatePiece => 'Parçayı döndür';

  @override
  String get themeClassic => 'Klasik';

  @override
  String get themeFade => 'Pastel';

  @override
  String get themeNeon => 'Neon';

  @override
  String get themeOcean => 'Okyanus';

  @override
  String get themeWood => 'Ahşap';

  @override
  String get themeSunset => 'Gün batımı';

  @override
  String get themeForest => 'Orman';

  @override
  String get themeAurora => 'Aurora';

  @override
  String get skinClassic => 'Klasik';

  @override
  String get skinGradient => 'Degrade';

  @override
  String get skinOutline => 'Kontur';

  @override
  String get skinGlossy => 'Parlak';

  @override
  String get skinStripe => 'Çizgili';

  @override
  String get skinBevel => 'Kabartma';

  @override
  String get skinGlow => 'Işıltı';

  @override
  String get skinCrystal => 'Kristal';

  @override
  String rewardThemeName(String name) {
    return '$name teması';
  }

  @override
  String rewardSkinName(String name) {
    return '$name görünümü';
  }

  @override
  String get skinPulse => 'Nabız';

  @override
  String get skinShimmer => 'Pırıltı';

  @override
  String get skinWave => 'Dalga';

  @override
  String get skinEmber => 'Kor';

  @override
  String get skinPrism => 'Prizma';

  @override
  String get skinStardust => 'Yıldız Tozu';

  @override
  String get skinCircuit => 'Devre';

  @override
  String get skinRipple => 'Dalgacık';

  @override
  String achievementRewardSkin(String name) {
    return 'Animasyonlu görünüm: $name';
  }

  @override
  String skinsAchievementReward(String achievement) {
    return 'Başarım ödülü: $achievement';
  }

  @override
  String get achievementBackpay =>
      'Başarımlar artık ödül veriyor — seninkiler eklendi.';

  @override
  String get namePromptBody =>
      'Bir ad seç, en iyi skorun sıralamaya girsin. Adsız da anonim olarak oynamaya devam edersin.';

  @override
  String get nameTaken => 'Bu ad zaten alınmış. Başka bir tane dene.';

  @override
  String get nameCheckFailed =>
      'Ad kontrol edilemedi. İnternete bağlı mısın? Birazdan tekrar dene.';

  @override
  String nameLost(String name) {
    return '$name artık başka bir oyuncuya ait. Ücretsiz olarak yeni bir ad seç.';
  }

  @override
  String get themeCandy => 'Şeker';

  @override
  String get themeVolcano => 'Volkan';

  @override
  String get themeGlacier => 'Buzul';

  @override
  String get skinPixel => 'Piksel';

  @override
  String get skinMarble => 'Mermer';

  @override
  String get skinJelly => 'Jöle';

  @override
  String get skinLiquid => 'Sıvı';

  @override
  String get skinFizz => 'Köpük';

  @override
  String get skinPlasma => 'Plazma';

  @override
  String get designsTitle => 'Tasarımlar';

  @override
  String get designsNotEnoughDiamonds => 'Yeterli elmas yok.';

  @override
  String get designsOwned => 'Sende';

  @override
  String get designsAchievementOnly => 'Başarım';

  @override
  String get designsSupporterOnly => 'Destekçi';

  @override
  String get designsPreview => 'Önizleme';

  @override
  String get designsGetDiamonds => 'Elmas al';

  @override
  String get shopDealTitle => 'Günün fırsatı';

  @override
  String get shopAnimatedSkins => 'Animasyonlu görünümler';

  @override
  String get shopNewDesigns => 'Yeni tasarımlar';

  @override
  String get shopDiamonds => 'Elmaslar';

  @override
  String get shopPacks => 'Paketler';

  @override
  String get shopPopular => 'Popüler';

  @override
  String get shopBestValue => 'En avantajlı';

  @override
  String get shopDiamondsBlurb =>
      'Animasyonlu görünümler ve yeni tasarımlar için.';

  @override
  String get shopCoinsBlurb => 'Temalar, görünümler ve güçlendiriciler için.';

  @override
  String get shopNeonBlurb => 'Neon temasının kilidini hemen açar.';

  @override
  String get shopRenameBlurb => 'Sıralamadaki adını değiştir.';

  @override
  String shopHoursLeft(int hours) {
    return '$hours sa kaldı';
  }

  @override
  String shopNewDealIn(String time) {
    return 'Yeni fırsat: $time sonra';
  }

  @override
  String shopDesignUnlocked(String name) {
    return '$name açıldı!';
  }

  @override
  String get questsTitle => 'Görevler';

  @override
  String get questsDaily => 'Günlük';

  @override
  String get questsWeekly => 'Haftalık';

  @override
  String get questsMonthly => 'Aylık';

  @override
  String questsNewIn(String time) {
    return 'Yeni görevler: $time sonra';
  }

  @override
  String get questsBonus => 'Hepsi için bonus';

  @override
  String get questsBonusEarned => 'Bonus kazanıldı';

  @override
  String get questRounds => 'Tur oyna';

  @override
  String get questLines => 'Satır temizle';

  @override
  String get questPieces => 'Parça yerleştir';

  @override
  String get questDailyChallenge => 'Günlük Meydan Okumayı oyna';

  @override
  String get questPuzzles => 'Yeni bulmacalar çöz';

  @override
  String get questDays => 'Farklı günlerde oyna';

  @override
  String get questDailySets => 'Tüm günlük görevleri bitir';

  @override
  String get questsSetDaily => 'Tüm günlük görevler tamam!';

  @override
  String get questsSetWeekly => 'Tüm haftalık görevler tamam!';

  @override
  String get questsSetMonthly => 'Tüm aylık görevler tamam!';

  @override
  String get leaderboardTabScore => 'En yüksek skor';

  @override
  String get leaderboardTabPuzzle => 'Bulmaca yıldızları';

  @override
  String get leaderboardPuzzleAutoSubmit =>
      'Bulmaca yıldızların otomatik olarak gönderilir.';

  @override
  String leaderboardPuzzleSubmitting(int stars) {
    return 'Bulmaca yıldızların ($stars) gönderiliyor …';
  }

  @override
  String get dailyGoalTitle => 'Günün hedefi';

  @override
  String dailyGoalPoints(String points) {
    return '$points puan';
  }

  @override
  String get dailyChestOpened => 'Seri sandığı açıldı!';

  @override
  String dailyNextChest(int day) {
    return 'Sonraki sandık: serinin $day. günü';
  }

  @override
  String get dailyExplainer =>
      'Bugün herkes aynı tahtada oynuyor ve ilk turun sayılıyor. Ekstra altın için yıldız eşiklerine ulaş, elmas sandıkları için serini koru ve bugün kaçıncı olduğunu gör.';

  @override
  String dailyRank(int rank, int total) {
    return 'Bugün $total kişi içinde $rank. sıra';
  }

  @override
  String get dailyRankNeedsName => 'Sıralamada görünmek için bir isim seç.';

  @override
  String get dailyRankingButton => 'Günün sıralaması';

  @override
  String get leaderboardTabDaily => 'Günün meydan okuması';

  @override
  String get leaderboardDailyFooter =>
      'Herkese aynı tahta, ilk tur sayılır. Her gün yeni bir sıralama.';

  @override
  String notificationChestBody(int diamonds) {
    return 'Bugünün meydan okumasını oyna, seri sandığını aç: $diamonds 💎';
  }

  @override
  String get themePumpkin => 'Balkabağı';

  @override
  String get skinGhost => 'Hayalet';

  @override
  String get halloweenTitle => 'Cadılar Bayramı';

  @override
  String get halloweenBody =>
      'Balkabağı teması ve hayalet görünümü – sadece ekimde.';

  @override
  String get designsBackInOctober => 'Ekimde geri dönecek';
}
