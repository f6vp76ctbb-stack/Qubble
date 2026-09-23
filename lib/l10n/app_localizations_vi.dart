// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class L10nVi extends L10n {
  L10nVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Chơi';

  @override
  String get commonLater => 'Để sau';

  @override
  String get commonNotNow => 'Không phải bây giờ';

  @override
  String get commonCancel => 'Hủy';

  @override
  String get commonBuy => 'Mua';

  @override
  String get commonSave => 'Lưu';

  @override
  String get commonCollect => 'Nhận';

  @override
  String get nameNewName => 'Tên mới';

  @override
  String get nameFieldLabel => 'Tên';

  @override
  String get piggyFullTitle => 'Heo đất đã đầy!';

  @override
  String get piggyKeepSaving => 'Tiếp tục tiết kiệm';

  @override
  String piggyProgress(int coins, int capacity) {
    return 'Đã gom $coins/$capacity.';
  }

  @override
  String get homeContinueRun => 'Tiếp tục';

  @override
  String get homeVideo => 'Video';

  @override
  String get commonGotIt => 'Đã hiểu';

  @override
  String get commonHome => 'Trang chủ';

  @override
  String get commonScore => 'ĐIỂM';

  @override
  String get commonBest => 'KỶ LỤC';

  @override
  String commonLevelShort(int level) {
    return 'Cấp $level';
  }

  @override
  String get homeNewRun => 'Bắt đầu ván mới';

  @override
  String get homeBackToExit => 'Nhấn quay lại lần nữa để thoát';

  @override
  String get homeEnableLeaderboard => 'Tham gia bảng xếp hạng';

  @override
  String get homeBestScore => 'ĐIỂM CAO NHẤT';

  @override
  String get homeDailyChallenge => 'Thử thách hằng ngày';

  @override
  String get homeDailyOpenToday => 'Hôm nay chưa chơi';

  @override
  String homeDailyNextIn(String time) {
    return 'Thử thách tiếp theo sau $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return 'Chuỗi $streak ngày';
  }

  @override
  String get homeLeaderboard => 'Bảng xếp hạng';

  @override
  String get homePuzzleMode => 'Chế độ giải đố';

  @override
  String get homeMissions => 'Nhiệm vụ';

  @override
  String get homeThemes => 'Chủ đề';

  @override
  String get homeSkins => 'Giao diện';

  @override
  String get homeHowToPlay => 'Cách chơi Qubble';

  @override
  String get homeWeekendBonus => 'Cuối tuần: nhân đôi xu!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Cấp $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Đổi tên';

  @override
  String get nameChangeExplainer =>
      'Tên của bạn là danh tính trên bảng xếp hạng nên sẽ được giữ cố định. Bạn có thể mua một lần đổi tên.';

  @override
  String get nameChangeAfterPurchase =>
      'Sau khi mua, hãy chạm vào tên của bạn lần nữa để đổi.';

  @override
  String get nameJoinedLeaderboard => 'Bạn đã có mặt trên bảng xếp hạng.';

  @override
  String get nameRenameUnavailable => 'Hiện chưa thể đổi tên.';

  @override
  String nameProblemTooShort(int min) {
    return 'Ít nhất $min ký tự.';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'Tối đa $max ký tự.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Chỉ dùng chữ không dấu (A–Z), số, khoảng trắng, _ và -.';

  @override
  String get nameProblemOffensive => 'Vui lòng chọn tên khác.';

  @override
  String get piggyTitle => 'Heo đất';

  @override
  String get piggyFillingHint => 'Heo đất sẽ đầy dần khi bạn xóa hàng.';

  @override
  String piggyCollect(int coins) {
    return 'Nhận $coins xu — miễn phí.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Khi đầy, bạn có thể đập heo miễn phí — hoặc mở sớm bằng một video thưởng.';

  @override
  String get piggyOpenNow => 'Mở ngay';

  @override
  String get gameNewPiecesVideo => 'Khối mới (video)';

  @override
  String get gameTapBoardCell => 'Chạm vào một ô trên bàn';

  @override
  String get gameDailyChallengeLabel => 'THỬ THÁCH HẰNG NGÀY';

  @override
  String get gameOver => 'Kết thúc';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Bạn cần thêm $missing xu để dùng bom.';
  }

  @override
  String get gameBombNotHere => 'Hiện không thể dùng bom ở đây.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Bạn cần thêm $missing xu.';
  }

  @override
  String get gameNotRightNow => 'Hiện chưa thể làm vậy.';

  @override
  String get gameRunSaved => 'Đã lưu ván — chọn “Tiếp tục” trong menu.';

  @override
  String get gameOverNoFit => 'Không còn khối nào vừa với bàn.';

  @override
  String get gameOverNoFitNoRotations =>
      'Không còn khối nào vừa — và lượt xoay đã hết.';

  @override
  String get gameStarterOfferUnavailable => 'Hiện không khả dụng';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — nhận ngay';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'COMBO x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Thành tích: $title';
  }

  @override
  String get gameBestSubmitted => 'Kỷ lục mới — đã gửi';

  @override
  String get gameReviveFor => 'Chơi tiếp · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Đã mở khóa: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Gói khởi đầu';

  @override
  String gameOverPoints(int score) {
    return '$score điểm';
  }

  @override
  String get gameNewRecord => 'Kỷ lục mới!';

  @override
  String gameStreakDays(int streak) {
    return 'Chuỗi $streak ngày';
  }

  @override
  String get gameDoubleCoins => 'Nhân đôi xu';

  @override
  String get gameDoubleDaily => 'Nhân đôi thưởng ngày';

  @override
  String get gamePlayAgain => 'Chơi lại';

  @override
  String gameLevelReached(int level) {
    return 'Đã lên cấp $level!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return 'Lên $count cấp — cấp $level!';
  }

  @override
  String get gameStarterOfferReward => '1200 xu + chủ đề Gỗ';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'Chỉ còn $hours giờ — duy nhất một lần!';
  }

  @override
  String get boosterUndo => 'Hoàn tác';

  @override
  String get boosterSwap => 'Đổi';

  @override
  String get boosterBomb => 'Bom';

  @override
  String get boosterNoRotationsLeft => 'Hết lượt xoay — xóa hàng để nạp lại!';

  @override
  String get onboardingDragPiece => 'Kéo một khối lên lưới';

  @override
  String get onboardingFillLine => 'Lấp đầy cả một hàng hoặc một cột';

  @override
  String get onboardingLinesClear => 'Hàng đầy sẽ biến mất — ghi điểm!';

  @override
  String get coachHintCombo => 'Combo! Xóa tiếp trong 3 lượt để giữ combo';

  @override
  String get coachHintFever => 'BÙNG NỔ! Nhân đôi điểm khi còn phát sáng';

  @override
  String get coachHintRotation =>
      'Xoay khối tốn một lượt — xóa hàng sẽ nạp lại';

  @override
  String get coachHintBooster =>
      'Mẹo: bạn có thể dùng vật phẩm hỗ trợ ở bên dưới';

  @override
  String get coachHintStrategy =>
      'Mẹo: đừng xóa mọi hàng ngay — chừa chỗ cho khối lớn';

  @override
  String get dailyStreakLabel => 'Chuỗi ngày';

  @override
  String get dailyBestLabel => 'Kỷ lục ngày';

  @override
  String dailyHistoryNote(int days) {
    return 'Lưu lại $days ngày gần nhất.';
  }

  @override
  String dailyDayPlayed(int day) {
    return 'Ngày $day: đã chơi';
  }

  @override
  String dailyDayMissed(int day) {
    return 'Ngày $day: chưa chơi';
  }

  @override
  String get homeDailyCalendar => 'Lịch';

  @override
  String get dailyShareButton => 'Chia sẻ kết quả';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Thử thách hằng ngày $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return '$score điểm · combo cao nhất x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Chơi: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    return 'Combo: còn $moves lượt';
  }

  @override
  String get dailyShareCopied => 'Đã sao chép kết quả';

  @override
  String get adNotAvailable => 'Hiện chưa có video — hãy thử lại sau giây lát';

  @override
  String get howToPlaySpeedTitle => 'Thưởng tốc độ';

  @override
  String get howToPlaySpeedBody =>
      'Đặt khối nhanh giúp cộng thêm tối đa 30% cho mỗi hàng được xóa. Phần thưởng giảm dần trong khoảng 1,5 đến 4 giây và có giới hạn, nên chơi nhanh có lợi nhưng không quyết định ván đấu — một ván chậm rãi, cẩn thận vẫn có thể thắng một ván vội vàng.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Thưởng tốc độ $percent phần trăm';
  }

  @override
  String get iapDiamondsSmall => '100 kim cương';

  @override
  String get iapDiamondsMedium => '350 kim cương';

  @override
  String get iapDiamondsLarge => '1.000 kim cương';

  @override
  String get howToPlayTitle => 'Cách chơi Qubble';

  @override
  String get howToPlayIntroHeadline =>
      'Dễ bắt đầu.\nThưởng cho người biết tính trước.';

  @override
  String get howToPlayIntroBody =>
      'Giữ bàn chơi thông thoáng và phá kỷ lục của bạn.';

  @override
  String get howToPlayIntroSemantics =>
      'Mục tiêu trò chơi. Giữ bàn chơi thông thoáng và phá kỷ lục của bạn.';

  @override
  String get howToPlayDragTitle => 'Kéo & đặt';

  @override
  String get howToPlayDragBody =>
      'Kéo một trong ba khối vào các ô trống. Khi dùng hết cả ba, bạn sẽ tự động nhận ba khối mới.';

  @override
  String get howToPlayClearTitle => 'Xóa hàng';

  @override
  String get howToPlayClearBody =>
      'Lấp đầy cả một hàng hoặc một cột. Hàng đầy sẽ biến mất và chừa chỗ cho lượt tiếp theo.';

  @override
  String get howToPlayComboTitle => 'Nối combo';

  @override
  String get howToPlayComboBody =>
      'Xóa thêm một hàng trong vòng ba lượt. Mỗi combo tiếp theo tăng hệ số nhân điểm. Combo tính theo lượt, không tính theo giây, nên không bao giờ hết khi bạn đang suy nghĩ.';

  @override
  String get howToPlayFeverTitle => 'Kích hoạt bùng nổ';

  @override
  String get howToPlayFeverBody =>
      'Xóa hàng sẽ làm đầy thanh bùng nổ. Khi thanh đầy, lần nổ lớn tiếp theo được tính gấp đôi — hãy tính trước những pha xóa lớn.';

  @override
  String get howToPlayBoosterTitle => 'Dùng vật phẩm hỗ trợ khéo léo';

  @override
  String get howToPlayBoosterBody =>
      'Vật phẩm hỗ trợ cứu những ván khó. Bạn cũng có thể chạm vào một khối ở khay để xoay nó.';

  @override
  String get howToPlayDailyTitle => 'Thử thách ngày & chuỗi ngày';

  @override
  String get howToPlayDailyBody =>
      'Thử thách hằng ngày dùng cùng một bộ khối cho mọi người. Chơi mỗi ngày để kéo dài chuỗi ngày và tăng thưởng.';

  @override
  String get howToPlayPiggyTitle => 'Nuôi heo đất';

  @override
  String get howToPlayPiggyBody =>
      'Mỗi hàng được xóa sẽ bỏ xu vào heo đất. Khi đầy, bạn có thể nhận xu miễn phí.';

  @override
  String get leaderboardTitle => 'Bảng xếp hạng';

  @override
  String get leaderboardUnreachable =>
      'Không tải được bảng xếp hạng.\nHãy thử lại khi có kết nối internet.';

  @override
  String get leaderboardEmpty => 'Chưa có ai.\nHãy là người đầu tiên!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Đang gửi kỷ lục của bạn ($score)…';
  }

  @override
  String get leaderboardAutoSubmit => 'Kỷ lục của bạn được gửi tự động.';

  @override
  String get puzzleModeTitle => 'Chế độ giải đố';

  @override
  String puzzleLevelTitle(int level) {
    return 'Câu đố $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Lượt: $moves   •   Mục tiêu: $target để đạt 3 sao';
  }

  @override
  String get puzzleSolved => 'Đã giải!';

  @override
  String get puzzleLeaveTitle => 'Rời câu đố?';

  @override
  String get puzzleLeaveBody => 'Tiến trình của câu đố này sẽ bị mất.';

  @override
  String get puzzleKeepPlaying => 'Chơi tiếp';

  @override
  String get puzzleLeave => 'Rời đi';

  @override
  String get puzzleStuckTitle => 'Bế tắc';

  @override
  String get puzzleRestart => 'Chơi lại';

  @override
  String get commonActive => 'Đang dùng';

  @override
  String get commonTapToActivate => 'Chạm để dùng';

  @override
  String get commonRestore => 'Khôi phục';

  @override
  String unlockForCost(int cost) {
    return '$cost để mở khóa';
  }

  @override
  String get skinsExchangeGold => 'Đổi vàng';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Xoay khối';

  @override
  String get puzzleNextLevel => 'Màn tiếp theo';

  @override
  String get puzzleBackToOverview => 'Về danh sách';

  @override
  String get puzzleUnsolvable => 'Từ đây không thể xóa sạch bàn được nữa.';

  @override
  String get puzzleExtraMoveVideo => 'Thêm lượt (video)';

  @override
  String puzzleSolvedCount(int solved) {
    return 'Đã giải $solved';
  }

  @override
  String get settingsTitle => 'Cài đặt';

  @override
  String get storageFailureTitle => 'Qubble không tải được dữ liệu đã lưu';

  @override
  String get storageFailureBody =>
      'Vui lòng khởi động lại ứng dụng. Nếu lỗi vẫn còn, chỉ có cài đặt lại mới giúp được. Bạn có thể báo lỗi tại Cài đặt › Góp ý.';

  @override
  String get iapUnavailable => 'Ưu đãi này hiện không khả dụng.';

  @override
  String get iapFailed => 'Giao dịch không thành công. Bạn chưa bị trừ tiền.';

  @override
  String get settingsResetProgress => 'Đặt lại tiến trình';

  @override
  String get settingsResetProgressSubtitle =>
      'Điểm, xu, cấp và tiến trình trở về ban đầu. Giao dịch mua, tên và vật phẩm trang trí được giữ lại.';

  @override
  String get settingsResetConfirmTitle => 'Đặt lại tiến trình?';

  @override
  String get settingsResetConfirmBody =>
      'Kỷ lục, xu, cấp, chuỗi ngày và toàn bộ tiến trình sẽ bị xóa. Không thể hoàn tác.\n\nGiao dịch mua, tên của bạn cùng các chủ đề và giao diện đã mở khóa được giữ lại.';

  @override
  String get settingsResetConfirmAction => 'Đặt lại';

  @override
  String get settingsResetDone => 'Đã đặt lại tiến trình.';

  @override
  String get settingsSectionGame => 'Trò chơi';

  @override
  String get settingsSectionSoundHaptics => 'Âm thanh & rung';

  @override
  String get settingsSectionReminders => 'Nhắc nhở';

  @override
  String get settingsSectionPurchases => 'Mua hàng';

  @override
  String get settingsSectionHelpOut => 'Ủng hộ';

  @override
  String get settingsSectionLegal => 'Pháp lý';

  @override
  String get settingsSectionLanguage => 'Ngôn ngữ';

  @override
  String get settingsGuide => 'Cách chơi';

  @override
  String get settingsGuideSubtitle =>
      'Luật chơi, combo, bùng nổ & vật phẩm hỗ trợ';

  @override
  String get settingsSound => 'Âm thanh';

  @override
  String get settingsMusic => 'Nhạc';

  @override
  String get settingsHaptics => 'Rung';

  @override
  String get settingsHapticsOff => 'Tắt';

  @override
  String get settingsHapticsLight => 'Nhẹ';

  @override
  String get settingsHapticsStrong => 'Mạnh';

  @override
  String get settingsSectionAccessibility => 'Dễ chịu';

  @override
  String get settingsReducedEffects => 'Giảm hiệu ứng';

  @override
  String get settingsReducedEffectsHint =>
      'Ít hạt hơn, không rung màn hình, không phát sáng';

  @override
  String get settingsNotifications => 'Thông báo';

  @override
  String get settingsNotificationsSubtitle =>
      'Nhắc hằng ngày & bảo vệ chuỗi ngày';

  @override
  String get settingsNotificationsSystemHint =>
      'Hãy cho phép trong cài đặt hệ thống.';

  @override
  String get settingsLanguageSystem => 'Ngôn ngữ hệ thống';

  @override
  String get settingsSupporterThanks => 'Người ủng hộ — cảm ơn bạn!';

  @override
  String get settingsSupporterPack => 'Gói ủng hộ';

  @override
  String get settingsSupporterPackSubtitle =>
      'Chủ đề & giao diện độc quyền + 1.500 xu';

  @override
  String get settingsRestorePurchases => 'Khôi phục giao dịch';

  @override
  String get settingsRestoring => 'Đang khôi phục giao dịch…';

  @override
  String get settingsRateApp => 'Đánh giá ứng dụng';

  @override
  String get settingsRateAppSubtitle => 'Để lại đánh giá trên cửa hàng';

  @override
  String get settingsStoreUnavailable =>
      'Cửa hàng không khả dụng trên thiết bị này.';

  @override
  String get settingsFeedback => 'Gửi góp ý';

  @override
  String get settingsFeedbackSubtitle => 'Báo ý tưởng & lỗi (qua GitHub)';

  @override
  String get settingsAdPrivacy => 'Quyền riêng tư quảng cáo';

  @override
  String get settingsAdPrivacySubtitle =>
      'Xem hoặc thay đổi sự đồng ý quảng cáo';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Thiết bị này không cần tùy chọn quảng cáo.';

  @override
  String get settingsPrivacy => 'Chính sách quyền riêng tư';

  @override
  String get settingsImprint => 'Thông tin pháp lý';

  @override
  String get settingsPageOpenFailed => 'Không mở được trang.';

  @override
  String get settingsFooter => 'Qubble • Xếp khối ngoại tuyến';

  @override
  String get settingsAdminSection => 'Quản trị (thử nghiệm)';

  @override
  String get settingsAdminEnabled => 'Đã bật chế độ quản trị';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Chạm thêm $count lần để bật chế độ quản trị';
  }

  @override
  String settingsAdminCoins(int coins) {
    return '$coins xu';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Chỉ để thử nghiệm — không bao giờ dùng trong ảnh chụp phát hành';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount xu';
  }

  @override
  String get settingsAdminResetCoins => 'Đặt xu về 0';

  @override
  String get feedbackTitle => 'Góp ý';

  @override
  String get feedbackIntroShort =>
      'Bạn thích gì, điều gì làm bạn khó chịu, còn thiếu gì? Chi tiết nhỏ cũng hữu ích — càng cụ thể càng tốt.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Chỉ đính kèm $build và loại thiết bị của bạn — để mình biết bạn đang nói về phiên bản nào.';
  }

  @override
  String get feedbackSendByMail => 'Gửi qua email';

  @override
  String get feedbackPreferGithub => 'Dùng GitHub issue';

  @override
  String get feedbackThanksMail => 'Cảm ơn bạn! Chỉ cần gửi tin nhắn đi.';

  @override
  String get feedbackNoMailApp =>
      'Không tìm thấy ứng dụng email. Hãy thử cách dùng GitHub bên dưới.';

  @override
  String get feedbackEmptyHint => 'Vui lòng nhập nội dung trước.';

  @override
  String get leaderboardRefresh => 'Làm mới';

  @override
  String get leaderboardRetry => 'Thử lại';

  @override
  String get feedbackHint => 'Góp ý của bạn…';

  @override
  String get feedbackSubmit => 'Gửi góp ý';

  @override
  String get feedbackOpenFailed => 'Không mở được GitHub. Hãy thử lại sau.';

  @override
  String get feedbackGithubNote =>
      'GitHub sẽ mở ra — chạm vào \"Submit new issue\" ở đó. (Cần đăng nhập GitHub một lần.)';

  @override
  String get shopTitle => 'Cửa hàng';

  @override
  String get shopWebDemoNote =>
      'Chỉ có thể mua hàng trong ứng dụng tải từ Play Store. Phiên bản web này là bản dùng thử miễn phí — bạn vẫn có thể chơi đầy đủ tại đây.';

  @override
  String get shopSupporterExplainer =>
      'Qubble không có quảng cáo bắt buộc — bạn không bao giờ phải mua gì cả. Gói ủng hộ (chủ đề Aurora, giao diện Pha lê, 1.500 xu, huy hiệu người ủng hộ) là lời cảm ơn vì bạn đã ủng hộ trò chơi. Giao dịch được gắn với tài khoản cửa hàng của bạn và có thể khôi phục bất cứ lúc nào.';

  @override
  String get shopSupporterContents =>
      'Chủ đề Aurora + giao diện Pha lê + 1.500 xu';

  @override
  String get themesTitle => 'Chủ đề';

  @override
  String get themesSupporterOnly => 'Chỉ có trong gói ủng hộ (xem cửa hàng)';

  @override
  String get themesInSupporterPack => 'Trong gói ủng hộ';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'Không đủ xu (cần $cost, đang có $coins)';
  }

  @override
  String get skinsTitle => 'Giao diện khối';

  @override
  String get skinsNotEnoughDiamonds =>
      'Không đủ kim cương (đổi vàng ở bên dưới)';

  @override
  String get skinsNotEnoughCoins => 'Không đủ xu';

  @override
  String get skinsNotEnoughGold => 'Không đủ vàng.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold vàng = 1 kim cương. Kim cương mở khóa những giao diện đẹp nhất — cứ từ từ tích lũy.';
  }

  @override
  String get statsTitle => 'Thống kê';

  @override
  String get statsAverageScore => 'Điểm TB';

  @override
  String get statsBestCombo => 'Combo cao nhất';

  @override
  String get statsGames => 'Số ván';

  @override
  String get statsLinesCleared => 'Hàng đã xóa';

  @override
  String get statsPiecesPlaced => 'Khối đã đặt';

  @override
  String get statsCoins => 'Xu';

  @override
  String get missionsTitle => 'Nhiệm vụ';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Đặt $countString khối';
  }

  @override
  String missionClearRows(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Xóa $countString hàng';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Đạt combo x$countString';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Vượt $countString điểm trong một ván';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Chơi $countString ván';
  }

  @override
  String get achievementsTitle => 'Thành tích';

  @override
  String get achievementFirstGameTitle => 'Ván đầu tiên';

  @override
  String get achievementFirstGameBody => 'Chơi ván đầu tiên';

  @override
  String get achievementGames25Title => 'Người quen';

  @override
  String get achievementGames25Body => 'Chơi 25 ván';

  @override
  String get achievementGames100Title => 'Nghiện rồi';

  @override
  String get achievementGames100Body => 'Chơi 100 ván';

  @override
  String get achievementScore1kTitle => 'Leo núi';

  @override
  String get achievementScore1kBody => 'Đạt 1.000 điểm';

  @override
  String get achievementScore5kTitle => 'Chuyên nghiệp';

  @override
  String get achievementScore5kBody => 'Đạt 5.000 điểm';

  @override
  String get achievementScore10kTitle => 'Bậc thầy';

  @override
  String get achievementScore10kBody => 'Đạt 10.000 điểm';

  @override
  String get achievementScore25kTitle => 'Huyền thoại';

  @override
  String get achievementScore25kBody => 'Đạt 25.000 điểm';

  @override
  String get achievementLines100Title => 'Ngăn nắp';

  @override
  String get achievementLines100Body => 'Xóa tổng cộng 100 hàng';

  @override
  String get achievementLines1000Title => 'Tổng vệ sinh';

  @override
  String get achievementLines1000Body => 'Xóa tổng cộng 1.000 hàng';

  @override
  String get achievementCombo5Title => 'Tập sự combo';

  @override
  String get achievementCombo5Body => 'Đạt combo x5';

  @override
  String get achievementCombo10Title => 'Vua combo';

  @override
  String get achievementCombo10Body => 'Đạt combo x10';

  @override
  String get achievementLevel10Title => 'Dày dạn';

  @override
  String get achievementLevel10Body => 'Đạt cấp 10';

  @override
  String get achievementLevel20Title => 'Kỳ cựu';

  @override
  String get achievementLevel20Body => 'Đạt cấp 20';

  @override
  String get achievementStreak7Title => 'Tròn một tuần';

  @override
  String get achievementStreak7Body => 'Chuỗi thử thách ngày 7 ngày';

  @override
  String get achievementStreak30Title => 'Tròn một tháng';

  @override
  String get achievementStreak30Body => 'Chuỗi thử thách ngày 30 ngày';

  @override
  String get achievementPuzzles10Title => 'Cao thủ giải đố';

  @override
  String get achievementPuzzles10Body => 'Giải 10 câu đố';

  @override
  String get achievementPieces5000Title => 'Thợ xây';

  @override
  String get achievementPieces5000Body => 'Đặt 5.000 khối';

  @override
  String streakRepairTitle(int streak) {
    return 'Chuỗi $streak ngày đang gặp nguy!';
  }

  @override
  String get streakRepairBody => 'Hôm qua bạn chưa chơi — hãy cứu chuỗi ngày:';

  @override
  String get streakRepairFailed => 'Không thể khôi phục.';

  @override
  String comebackGift(int coins) {
    return 'Chào mừng trở lại! +$coins xu';
  }

  @override
  String get notificationsOptInTitle => 'Nhận nhắc nhở?';

  @override
  String get notificationsOptInBody =>
      'Bạn có muốn được nhắc về thử thách hằng ngày và giữ chuỗi ngày không? Bạn có thể đổi lại bất cứ lúc nào trong cài đặt.';

  @override
  String get notificationsOptInAccept => 'Có, nhắc tôi';

  @override
  String get notificationChannelDescription =>
      'Nhắc hằng ngày, cảnh báo chuỗi ngày, mời quay lại';

  @override
  String get notificationDailyTitle => 'Câu đố hôm nay đang chờ bạn 🧩';

  @override
  String get notificationDailyBody => 'Chơi thử thách hôm nay nào!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 Chuỗi $streak ngày của bạn đang gặp nguy!';
  }

  @override
  String get notificationStreakBody => 'Chơi hôm nay để giữ chuỗi.';

  @override
  String get notificationComebackTitle => 'Các khối đang chờ bạn 🧩';

  @override
  String get notificationComebackBody => 'Quay lại và nhận quà nhé!';

  @override
  String get iapSupporterPack => 'Gói ủng hộ';

  @override
  String get iapCoinsSmall => '500 xu';

  @override
  String get iapCoinsMedium => '2.000 xu';

  @override
  String get iapCoinsLarge => '6.000 xu';

  @override
  String get iapStarterPack => 'Gói khởi đầu';

  @override
  String get iapRename => 'Đổi tên';

  @override
  String get iapNeonTheme => 'Chủ đề Neon';

  @override
  String get settingsLeaderboardDelete => 'Xóa tên khỏi bảng xếp hạng';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Gỡ tên và điểm của bạn khỏi danh sách công khai';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'Xóa mục của bạn?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Tên và điểm của bạn sẽ bị gỡ khỏi bảng xếp hạng. Tiến trình chơi không bị ảnh hưởng. Bạn có thể tham gia lại bảng xếp hạng bất cứ lúc nào.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'Đã xóa mục của bạn khỏi bảng xếp hạng.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Không xóa được. Hãy kiểm tra kết nối và thử lại.';

  @override
  String get leaderboardReport => 'Báo cáo tên này';

  @override
  String get leaderboardBlock => 'Chặn';

  @override
  String leaderboardBlocked(String name) {
    return 'Đã ẩn $name với bạn';
  }

  @override
  String get leaderboardUndo => 'Hoàn tác';

  @override
  String leaderboardBlockedCount(int count) {
    return 'Bạn đã ẩn $count mục';
  }

  @override
  String get leaderboardUnblockAll => 'Hiện lại';

  @override
  String get leaderboardReportUnavailable => 'Hiện chưa thể báo cáo.';

  @override
  String get leaderboardReportSent => 'Cảm ơn — báo cáo của bạn đang được gửi.';

  @override
  String get leaderboardRules =>
      'Tên được hiển thị công khai. Không lăng mạ, không ngôn từ thù ghét và không dùng thông tin nhận dạng người thật. Tên vi phạm sẽ bị xóa.';

  @override
  String get leaderboardRulesAccept => 'Tôi hiểu';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return 'Đã mở $unlocked/$total';
  }

  @override
  String get settingsSectionData => 'Dữ liệu đã lưu';

  @override
  String get gameRotatePiece => 'Xoay khối';

  @override
  String get themeClassic => 'Cổ điển';

  @override
  String get themeFade => 'Pastel';

  @override
  String get themeNeon => 'Neon';

  @override
  String get themeOcean => 'Đại dương';

  @override
  String get themeWood => 'Gỗ';

  @override
  String get themeSunset => 'Hoàng hôn';

  @override
  String get themeForest => 'Rừng xanh';

  @override
  String get themeAurora => 'Aurora';

  @override
  String get skinClassic => 'Cổ điển';

  @override
  String get skinGradient => 'Chuyển màu';

  @override
  String get skinOutline => 'Viền';

  @override
  String get skinGlossy => 'Bóng';

  @override
  String get skinStripe => 'Sọc';

  @override
  String get skinBevel => 'Nổi khối';

  @override
  String get skinGlow => 'Phát sáng';

  @override
  String get skinCrystal => 'Pha lê';

  @override
  String rewardThemeName(String name) {
    return 'Chủ đề $name';
  }

  @override
  String rewardSkinName(String name) {
    return 'Giao diện $name';
  }
}
