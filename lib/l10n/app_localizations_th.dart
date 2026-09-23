// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class L10nTh extends L10n {
  L10nTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'เล่น';

  @override
  String get commonLater => 'ไว้ทีหลัง';

  @override
  String get commonNotNow => 'ไม่ใช่ตอนนี้';

  @override
  String get commonCancel => 'ยกเลิก';

  @override
  String get commonBuy => 'ซื้อ';

  @override
  String get commonSave => 'บันทึก';

  @override
  String get commonCollect => 'รับ';

  @override
  String get nameNewName => 'ชื่อใหม่';

  @override
  String get nameFieldLabel => 'ชื่อ';

  @override
  String get piggyFullTitle => 'กระปุกออมสินเต็มแล้ว!';

  @override
  String get piggyKeepSaving => 'ออมต่อ';

  @override
  String piggyProgress(int coins, int capacity) {
    return 'สะสมแล้ว $coins จาก $capacity';
  }

  @override
  String get homeContinueRun => 'เล่นต่อ';

  @override
  String get homeVideo => 'วิดีโอ';

  @override
  String get commonGotIt => 'เข้าใจแล้ว';

  @override
  String get commonHome => 'หน้าหลัก';

  @override
  String get commonScore => 'คะแนน';

  @override
  String get commonBest => 'สูงสุด';

  @override
  String commonLevelShort(int level) {
    return 'เลเวล $level';
  }

  @override
  String get homeNewRun => 'เริ่มเกมใหม่';

  @override
  String get homeBackToExit => 'กดย้อนกลับอีกครั้งเพื่อออก';

  @override
  String get homeEnableLeaderboard => 'เข้าร่วมกระดานผู้นำ';

  @override
  String get homeBestScore => 'คะแนนสูงสุด';

  @override
  String get homeDailyChallenge => 'ความท้าทายรายวัน';

  @override
  String get homeDailyOpenToday => 'วันนี้ยังไม่ได้เล่น';

  @override
  String homeDailyNextIn(String time) {
    return 'ความท้าทายถัดไปใน $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return 'ต่อเนื่อง $streak วัน';
  }

  @override
  String get homeLeaderboard => 'กระดานผู้นำ';

  @override
  String get homePuzzleMode => 'โหมดปริศนา';

  @override
  String get homeMissions => 'ภารกิจ';

  @override
  String get homeThemes => 'ธีม';

  @override
  String get homeSkins => 'สกิน';

  @override
  String get homeHowToPlay => 'วิธีเล่น Qubble';

  @override
  String get homeWeekendBonus => 'สุดสัปดาห์: เหรียญ x2!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'เลเวล $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'เปลี่ยนชื่อ';

  @override
  String get nameChangeExplainer =>
      'ชื่อของคุณคือตัวตนบนกระดานผู้นำ จึงเปลี่ยนเองไม่ได้ คุณซื้อสิทธิ์เปลี่ยนชื่อได้หนึ่งครั้ง';

  @override
  String get nameChangeAfterPurchase =>
      'หลังจากซื้อแล้ว แตะที่ชื่อของคุณอีกครั้งเพื่อเปลี่ยน';

  @override
  String get nameJoinedLeaderboard => 'ตอนนี้คุณอยู่บนกระดานผู้นำแล้ว';

  @override
  String get nameRenameUnavailable => 'เปลี่ยนชื่อไม่ได้ในขณะนี้';

  @override
  String nameProblemTooShort(int min) {
    return 'อย่างน้อย $min ตัวอักษร';
  }

  @override
  String nameProblemTooLong(int max) {
    return 'ไม่เกิน $max ตัวอักษร';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'ใช้ได้เฉพาะตัวอักษรภาษาอังกฤษ (A–Z) ตัวเลข ช่องว่าง _ และ -';

  @override
  String get nameProblemOffensive => 'โปรดเลือกชื่ออื่น';

  @override
  String get piggyTitle => 'กระปุกออมสิน';

  @override
  String get piggyFillingHint =>
      'กระปุกออมสินจะเต็มขึ้นเรื่อย ๆ เมื่อคุณเคลียร์แถว';

  @override
  String piggyCollect(int coins) {
    return 'รับ $coins เหรียญ ฟรี';
  }

  @override
  String get piggyEarlyOpenHint =>
      'เมื่อเต็มแล้วคุณเทออกได้ฟรี หรือจะเปิดก่อนด้วยวิดีโอโบนัสก็ได้';

  @override
  String get piggyOpenNow => 'เปิดเลย';

  @override
  String get gameNewPiecesVideo => 'บล็อกใหม่ (วิดีโอ)';

  @override
  String get gameTapBoardCell => 'แตะช่องบนกระดาน';

  @override
  String get gameDailyChallengeLabel => 'ความท้าทายรายวัน';

  @override
  String get gameOver => 'จบเกม';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'ต้องมีอีก $missing เหรียญจึงจะใช้ระเบิดได้';
  }

  @override
  String get gameBombNotHere => 'ตอนนี้ใช้ระเบิดตรงนี้ไม่ได้';

  @override
  String gameNeedsCoins(String missing) {
    return 'ต้องมีอีก $missing เหรียญ';
  }

  @override
  String get gameNotRightNow => 'ทำไม่ได้ในขณะนี้';

  @override
  String get gameRunSaved => 'บันทึกเกมแล้ว — กด \"เล่นต่อ\" ในเมนู';

  @override
  String get gameOverNoFit => 'ไม่มีบล็อกไหนวางลงบนกระดานได้อีกแล้ว';

  @override
  String get gameOverNoFitNoRotations =>
      'ไม่มีบล็อกไหนวางได้ และใช้การหมุนหมดแล้ว';

  @override
  String get gameStarterOfferUnavailable => 'ไม่พร้อมให้บริการในขณะนี้';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — รับเลย';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'คอมโบ x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'ความสำเร็จ: $title';
  }

  @override
  String get gameBestSubmitted => 'สถิติใหม่ — ส่งแล้ว';

  @override
  String get gameReviveFor => 'เล่นต่อ · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'ปลดล็อกแล้ว: $name';
  }

  @override
  String get gameStarterOfferTitle => 'แพ็กเริ่มต้น';

  @override
  String gameOverPoints(int score) {
    return '$score คะแนน';
  }

  @override
  String get gameNewRecord => 'สถิติใหม่!';

  @override
  String gameStreakDays(int streak) {
    return 'ต่อเนื่อง $streak วัน';
  }

  @override
  String get gameDoubleCoins => 'เหรียญ x2';

  @override
  String get gameDoubleDaily => 'รางวัลรายวัน x2';

  @override
  String get gamePlayAgain => 'เล่นอีกครั้ง';

  @override
  String gameLevelReached(int level) {
    return 'ถึงเลเวล $level แล้ว!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return 'ขึ้น $count เลเวล — เลเวล $level!';
  }

  @override
  String get gameStarterOfferReward => '1200 เหรียญ + ธีมไม้';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return 'เหลืออีกเพียง $hours ชม. — ครั้งเดียวเท่านั้น!';
  }

  @override
  String get boosterUndo => 'ย้อนกลับ';

  @override
  String get boosterSwap => 'สลับ';

  @override
  String get boosterBomb => 'ระเบิด';

  @override
  String get boosterNoRotationsLeft =>
      'หมุนไม่ได้แล้ว — เคลียร์แถวเพื่อชาร์จใหม่!';

  @override
  String get onboardingDragPiece => 'ลากบล็อกไปวางบนกระดาน';

  @override
  String get onboardingFillLine => 'เติมให้เต็มทั้งแถวหรือทั้งคอลัมน์';

  @override
  String get onboardingLinesClear => 'แถวที่เต็มจะหายไป — ได้คะแนน!';

  @override
  String get coachHintCombo => 'คอมโบ! เคลียร์อีกครั้งภายใน 3 ตาเพื่อรักษาไว้';

  @override
  String get coachHintFever => 'ฟีเวอร์! คะแนน x2 ระหว่างที่เรืองแสง';

  @override
  String get coachHintRotation => 'การหมุนใช้ 1 ชาร์จ — การเคลียร์จะเติมคืนให้';

  @override
  String get coachHintBooster => 'เคล็ดลับ: ใช้ตัวช่วยได้ที่ด้านล่าง';

  @override
  String get coachHintStrategy =>
      'เคล็ดลับ: ไม่ต้องเคลียร์ทุกแถวพร้อมกัน — เว้นที่ไว้ให้บล็อกใหญ่';

  @override
  String get dailyStreakLabel => 'ต่อเนื่อง';

  @override
  String get dailyBestLabel => 'สูงสุดรายวัน';

  @override
  String dailyHistoryNote(int days) {
    return 'เก็บประวัติไว้ $days วันล่าสุด';
  }

  @override
  String dailyDayPlayed(int day) {
    return 'วันที่ $day: เล่นแล้ว';
  }

  @override
  String dailyDayMissed(int day) {
    return 'วันที่ $day: ไม่ได้เล่น';
  }

  @override
  String get homeDailyCalendar => 'ปฏิทิน';

  @override
  String get dailyShareButton => 'แชร์ผลลัพธ์';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble รายวัน $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return '$score คะแนน · คอมโบสูงสุด x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'เล่น: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    return 'คอมโบ: เหลือ $moves ตา';
  }

  @override
  String get dailyShareCopied => 'คัดลอกผลลัพธ์ไปยังคลิปบอร์ดแล้ว';

  @override
  String get adNotAvailable =>
      'ยังไม่มีวิดีโอในขณะนี้ — ลองอีกครั้งในอีกสักครู่';

  @override
  String get howToPlaySpeedTitle => 'โบนัสความเร็ว';

  @override
  String get howToPlaySpeedBody =>
      'ยิ่งวางเร็ว การเคลียร์ยิ่งได้คะแนนเพิ่มสูงสุด 30 % โบนัสจะค่อย ๆ ลดลงระหว่าง 1.5 ถึง 4 วินาทีและมีเพดานจำกัด ความเร็วจึงคุ้มค่าแต่ไม่ได้ตัดสินเกม — การเล่นช้าอย่างรอบคอบยังเอาชนะการเล่นเร็วแบบรีบร้อนได้';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'โบนัสความเร็ว $percent เปอร์เซ็นต์';
  }

  @override
  String get iapDiamondsSmall => '100 เพชร';

  @override
  String get iapDiamondsMedium => '350 เพชร';

  @override
  String get iapDiamondsLarge => '1,000 เพชร';

  @override
  String get howToPlayTitle => 'วิธีเล่น Qubble';

  @override
  String get howToPlayIntroHeadline =>
      'เริ่มเล่นง่าย\nคิดล่วงหน้าแล้วได้เปรียบ';

  @override
  String get howToPlayIntroBody => 'รักษากระดานให้โล่งและทำลายสถิติของคุณ';

  @override
  String get howToPlayIntroSemantics =>
      'เป้าหมายของเกม รักษากระดานให้โล่งและทำลายสถิติของคุณ';

  @override
  String get howToPlayDragTitle => 'ลากแล้ววาง';

  @override
  String get howToPlayDragBody =>
      'ลากหนึ่งในสามบล็อกไปวางบนช่องที่ว่าง เมื่อใช้ครบทั้งสามชิ้นแล้ว คุณจะได้บล็อกใหม่สามชิ้นโดยอัตโนมัติ';

  @override
  String get howToPlayClearTitle => 'เคลียร์แถว';

  @override
  String get howToPlayClearBody =>
      'เติมแถวหรือคอลัมน์ให้เต็ม แถวที่เต็มจะหายไปและเปิดที่ว่างให้ตาถัดไป';

  @override
  String get howToPlayComboTitle => 'ต่อคอมโบ';

  @override
  String get howToPlayComboBody =>
      'เคลียร์อีกแถวภายในสามตา ทุกคอมโบที่ต่อได้จะเพิ่มตัวคูณคะแนน คอมโบนับเป็นตา ไม่ใช่วินาที จึงไม่หมดเวลาระหว่างที่คุณคิด';

  @override
  String get howToPlayFeverTitle => 'จุดฟีเวอร์';

  @override
  String get howToPlayFeverBody =>
      'การเคลียร์จะเติมมาตรวัดฟีเวอร์ เมื่อเต็มแล้ว การเคลียร์ครั้งถัดไปจะได้คะแนนสองเท่า — วางแผนเคลียร์ครั้งใหญ่ไว้ล่วงหน้า';

  @override
  String get howToPlayBoosterTitle => 'ใช้ตัวช่วยอย่างชาญฉลาด';

  @override
  String get howToPlayBoosterBody =>
      'ตัวช่วยกู้สถานการณ์ในเกมที่คับขันได้ คุณยังแตะบล็อกในถาดเพื่อหมุนได้ด้วย';

  @override
  String get howToPlayDailyTitle => 'รายวันและการเล่นต่อเนื่อง';

  @override
  String get howToPlayDailyBody =>
      'ความท้าทายรายวันใช้บล็อกชุดเดียวกันสำหรับทุกคน เล่นทุกวันเพื่อเพิ่มจำนวนวันต่อเนื่องและโบนัส';

  @override
  String get howToPlayPiggyTitle => 'เติมกระปุกออมสิน';

  @override
  String get howToPlayPiggyBody =>
      'ทุกแถวที่เคลียร์จะเติมกระปุกออมสินของคุณ เมื่อเต็มแล้ว คุณรับเหรียญได้ฟรี';

  @override
  String get leaderboardTitle => 'กระดานผู้นำ';

  @override
  String get leaderboardUnreachable =>
      'ใช้กระดานผู้นำไม่ได้\nลองอีกครั้งเมื่อเชื่อมต่ออินเทอร์เน็ต';

  @override
  String get leaderboardEmpty => 'ยังไม่มีรายชื่อ\nมาเป็นคนแรกกัน!';

  @override
  String leaderboardSubmitting(int score) {
    return 'กำลังส่งคะแนนสูงสุดของคุณ ($score) …';
  }

  @override
  String get leaderboardAutoSubmit => 'คะแนนสูงสุดของคุณจะถูกส่งโดยอัตโนมัติ';

  @override
  String get puzzleModeTitle => 'โหมดปริศนา';

  @override
  String puzzleLevelTitle(int level) {
    return 'ปริศนา $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'ตา: $moves   •   เป้าหมาย: $target ตา ได้ 3 ดาว';
  }

  @override
  String get puzzleSolved => 'ไขได้แล้ว!';

  @override
  String get puzzleLeaveTitle => 'ออกจากปริศนา?';

  @override
  String get puzzleLeaveBody => 'ความคืบหน้าในปริศนานี้จะหายไป';

  @override
  String get puzzleKeepPlaying => 'เล่นต่อ';

  @override
  String get puzzleLeave => 'ออก';

  @override
  String get puzzleStuckTitle => 'ไปต่อไม่ได้';

  @override
  String get puzzleRestart => 'เริ่มใหม่';

  @override
  String get commonActive => 'ใช้งานอยู่';

  @override
  String get commonTapToActivate => 'แตะเพื่อใช้งาน';

  @override
  String get commonRestore => 'กู้คืน';

  @override
  String unlockForCost(int cost) {
    return 'ปลดล็อกด้วย $cost';
  }

  @override
  String get skinsExchangeGold => 'แลกทอง';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'หมุนบล็อก';

  @override
  String get puzzleNextLevel => 'ด่านถัดไป';

  @override
  String get puzzleBackToOverview => 'กลับไปหน้ารวม';

  @override
  String get puzzleUnsolvable =>
      'จากตรงนี้ไม่สามารถเคลียร์กระดานให้ว่างได้อีกแล้ว';

  @override
  String get puzzleExtraMoveVideo => 'เพิ่ม 1 ตา (วิดีโอ)';

  @override
  String puzzleSolvedCount(int solved) {
    return 'ไขแล้ว $solved';
  }

  @override
  String get settingsTitle => 'การตั้งค่า';

  @override
  String get storageFailureTitle => 'Qubble โหลดเกมที่บันทึกไว้ไม่ได้';

  @override
  String get storageFailureBody =>
      'โปรดเริ่มแอปใหม่ หากยังเกิดข้อผิดพลาด มีเพียงการติดตั้งใหม่ที่ช่วยได้ คุณแจ้งปัญหาได้ที่ การตั้งค่า › ส่งความคิดเห็น';

  @override
  String get iapUnavailable => 'ข้อเสนอนี้ไม่พร้อมให้บริการในขณะนี้';

  @override
  String get iapFailed => 'การซื้อไม่สำเร็จ ไม่มีการเรียกเก็บเงิน';

  @override
  String get settingsResetProgress => 'รีเซ็ตความคืบหน้า';

  @override
  String get settingsResetProgressSubtitle =>
      'คะแนน เหรียญ เลเวล และความคืบหน้ากลับไปเริ่มต้นใหม่ การซื้อ ชื่อ และไอเทมตกแต่งยังคงอยู่';

  @override
  String get settingsResetConfirmTitle => 'รีเซ็ตความคืบหน้า?';

  @override
  String get settingsResetConfirmBody =>
      'คะแนนสูงสุด เหรียญ เลเวล การเล่นต่อเนื่อง และความคืบหน้าทั้งหมดจะถูกลบ และย้อนกลับไม่ได้\n\nการซื้อ ชื่อ รวมถึงธีมและสกินที่ปลดล็อกแล้วจะยังคงอยู่';

  @override
  String get settingsResetConfirmAction => 'รีเซ็ต';

  @override
  String get settingsResetDone => 'รีเซ็ตความคืบหน้าแล้ว';

  @override
  String get settingsSectionGame => 'เกม';

  @override
  String get settingsSectionSoundHaptics => 'เสียงและการสั่น';

  @override
  String get settingsSectionReminders => 'การเตือน';

  @override
  String get settingsSectionPurchases => 'การซื้อ';

  @override
  String get settingsSectionHelpOut => 'ร่วมสนับสนุน';

  @override
  String get settingsSectionLegal => 'ข้อกฎหมาย';

  @override
  String get settingsSectionLanguage => 'ภาษา';

  @override
  String get settingsGuide => 'วิธีเล่น';

  @override
  String get settingsGuideSubtitle => 'กติกา คอมโบ ฟีเวอร์ และตัวช่วย';

  @override
  String get settingsSound => 'เสียง';

  @override
  String get settingsMusic => 'เพลง';

  @override
  String get settingsHaptics => 'การสั่น';

  @override
  String get settingsHapticsOff => 'ปิด';

  @override
  String get settingsHapticsLight => 'เบา';

  @override
  String get settingsHapticsStrong => 'แรง';

  @override
  String get settingsSectionAccessibility => 'ความสบาย';

  @override
  String get settingsReducedEffects => 'ลดเอฟเฟกต์';

  @override
  String get settingsReducedEffectsHint =>
      'อนุภาคน้อยลง ไม่มีจอสั่น ไม่มีแสงเรือง';

  @override
  String get settingsNotifications => 'การแจ้งเตือน';

  @override
  String get settingsNotificationsSubtitle =>
      'เตือนรายวันและรักษาการเล่นต่อเนื่อง';

  @override
  String get settingsNotificationsSystemHint => 'โปรดอนุญาตในการตั้งค่าระบบ';

  @override
  String get settingsLanguageSystem => 'ภาษาของระบบ';

  @override
  String get settingsSupporterThanks => 'ผู้สนับสนุน — ขอบคุณ!';

  @override
  String get settingsSupporterPack => 'แพ็กผู้สนับสนุน';

  @override
  String get settingsSupporterPackSubtitle => 'ธีมและสกินพิเศษ + 1,500 เหรียญ';

  @override
  String get settingsRestorePurchases => 'กู้คืนการซื้อ';

  @override
  String get settingsRestoring => 'กำลังกู้คืนการซื้อ…';

  @override
  String get settingsRateApp => 'ให้คะแนนแอป';

  @override
  String get settingsRateAppSubtitle => 'ให้คะแนนในสโตร์';

  @override
  String get settingsStoreUnavailable => 'สโตร์ไม่พร้อมใช้งานบนอุปกรณ์นี้';

  @override
  String get settingsFeedback => 'ส่งความคิดเห็น';

  @override
  String get settingsFeedbackSubtitle => 'แจ้งไอเดียและบั๊ก (ผ่าน GitHub)';

  @override
  String get settingsAdPrivacy => 'การตั้งค่าความเป็นส่วนตัวของโฆษณา';

  @override
  String get settingsAdPrivacySubtitle => 'ดูหรือเปลี่ยนความยินยอมด้านโฆษณา';

  @override
  String get settingsAdPrivacyUnavailable =>
      'อุปกรณ์นี้ไม่จำเป็นต้องตั้งค่าโฆษณา';

  @override
  String get settingsPrivacy => 'นโยบายความเป็นส่วนตัว';

  @override
  String get settingsImprint => 'ข้อมูลผู้ให้บริการ';

  @override
  String get settingsPageOpenFailed => 'เปิดหน้านี้ไม่ได้';

  @override
  String get settingsFooter => 'Qubble • เกมต่อบล็อกแบบออฟไลน์';

  @override
  String get settingsAdminSection => 'ผู้ดูแล (ทดสอบ)';

  @override
  String get settingsAdminEnabled => 'เปิดโหมดผู้ดูแลแล้ว';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'แตะอีก $count ครั้งเพื่อเข้าโหมดผู้ดูแล';
  }

  @override
  String settingsAdminCoins(int coins) {
    return '$coins เหรียญ';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'สำหรับทดสอบเท่านั้น — ห้ามแสดงในภาพหน้าจอของเวอร์ชันจริง';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount เหรียญ';
  }

  @override
  String get settingsAdminResetCoins => 'ตั้งเหรียญเป็น 0';

  @override
  String get feedbackTitle => 'ความคิดเห็น';

  @override
  String get feedbackIntroShort =>
      'ชอบอะไร อะไรที่น่ารำคาญ หรือยังขาดอะไร? เรื่องเล็ก ๆ ก็ช่วยได้ — ยิ่งเจาะจงยิ่งดี';

  @override
  String feedbackAttachmentNote(String build) {
    return 'จะแนบเพียง $build และรุ่นอุปกรณ์ของคุณ — เพื่อให้รู้ว่าคุณหมายถึงเวอร์ชันไหน';
  }

  @override
  String get feedbackSendByMail => 'ส่งทางอีเมล';

  @override
  String get feedbackPreferGithub => 'ขอเปิด issue บน GitHub แทน';

  @override
  String get feedbackThanksMail => 'ขอบคุณ! ส่งข้อความได้เลย';

  @override
  String get feedbackNoMailApp => 'ไม่พบแอปอีเมล ลองใช้ทาง GitHub ด้านล่าง';

  @override
  String get feedbackEmptyHint => 'โปรดพิมพ์ข้อความก่อน';

  @override
  String get leaderboardRefresh => 'รีเฟรช';

  @override
  String get leaderboardRetry => 'ลองอีกครั้ง';

  @override
  String get feedbackHint => 'ความคิดเห็นของคุณ…';

  @override
  String get feedbackSubmit => 'ส่งความคิดเห็น';

  @override
  String get feedbackOpenFailed => 'เปิด GitHub ไม่ได้ ลองอีกครั้งภายหลัง';

  @override
  String get feedbackGithubNote =>
      'GitHub จะเปิดขึ้น — แตะ \"Submit new issue\" ที่นั่น (ต้องเข้าสู่ระบบ GitHub หนึ่งครั้ง)';

  @override
  String get shopTitle => 'ร้านค้า';

  @override
  String get shopWebDemoNote =>
      'การซื้อมีเฉพาะในแอปจาก Play Store เวอร์ชันเว็บนี้เป็นเดโมฟรี — คุณยังเล่นได้ครบทุกอย่างที่นี่';

  @override
  String get shopSupporterExplainer =>
      'Qubble ไม่มีโฆษณาบังคับ — คุณไม่จำเป็นต้องซื้ออะไรเลย แพ็กผู้สนับสนุน (ธีมออโรร่า สกินคริสตัล 1,500 เหรียญ และตราผู้สนับสนุน) เป็นคำขอบคุณที่คุณสนับสนุนเกมนี้ การซื้อผูกกับบัญชีสโตร์ของคุณและกู้คืนได้ทุกเมื่อ';

  @override
  String get shopSupporterContents => 'ธีมออโรร่า + สกินคริสตัล + 1,500 เหรียญ';

  @override
  String get themesTitle => 'ธีม';

  @override
  String get themesSupporterOnly => 'เฉพาะในแพ็กผู้สนับสนุน (ดูในร้านค้า)';

  @override
  String get themesInSupporterPack => 'อยู่ในแพ็กผู้สนับสนุน';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'เหรียญไม่พอ (ต้องใช้ $cost มี $coins)';
  }

  @override
  String get skinsTitle => 'สกินบล็อก';

  @override
  String get skinsNotEnoughDiamonds => 'เพชรไม่พอ (แลกทองได้ด้านล่าง)';

  @override
  String get skinsNotEnoughCoins => 'เหรียญไม่พอ';

  @override
  String get skinsNotEnoughGold => 'ทองไม่พอ';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold ทอง = 1 เพชร เพชรใช้ปลดล็อกสกินที่สวยที่สุด — ค่อย ๆ สะสมไป';
  }

  @override
  String get statsTitle => 'สถิติ';

  @override
  String get statsAverageScore => 'คะแนนเฉลี่ย';

  @override
  String get statsBestCombo => 'คอมโบสูงสุด';

  @override
  String get statsGames => 'จำนวนเกม';

  @override
  String get statsLinesCleared => 'แถวที่เคลียร์';

  @override
  String get statsPiecesPlaced => 'บล็อกที่วาง';

  @override
  String get statsCoins => 'เหรียญ';

  @override
  String get missionsTitle => 'ภารกิจ';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'วางบล็อก $countString ชิ้น';
  }

  @override
  String missionClearRows(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'เคลียร์ $countString แถว';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'ทำคอมโบ x$countString';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'ทำได้ $countString คะแนนในเกมเดียว';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'เล่น $countString เกม';
  }

  @override
  String get achievementsTitle => 'ความสำเร็จ';

  @override
  String get achievementFirstGameTitle => 'เกมแรก';

  @override
  String get achievementFirstGameBody => 'เล่นเกมแรกของคุณ';

  @override
  String get achievementGames25Title => 'ขาประจำ';

  @override
  String get achievementGames25Body => 'เล่น 25 เกม';

  @override
  String get achievementGames100Title => 'ติดงอมแงม';

  @override
  String get achievementGames100Body => 'เล่น 100 เกม';

  @override
  String get achievementScore1kTitle => 'นักไต่ระดับ';

  @override
  String get achievementScore1kBody => 'ทำได้ 1,000 คะแนน';

  @override
  String get achievementScore5kTitle => 'มือโปร';

  @override
  String get achievementScore5kBody => 'ทำได้ 5,000 คะแนน';

  @override
  String get achievementScore10kTitle => 'ปรมาจารย์';

  @override
  String get achievementScore10kBody => 'ทำได้ 10,000 คะแนน';

  @override
  String get achievementScore25kTitle => 'ตำนาน';

  @override
  String get achievementScore25kBody => 'ทำได้ 25,000 คะแนน';

  @override
  String get achievementLines100Title => 'เป็นระเบียบ';

  @override
  String get achievementLines100Body => 'เคลียร์รวม 100 แถว';

  @override
  String get achievementLines1000Title => 'นักจัดบ้าน';

  @override
  String get achievementLines1000Body => 'เคลียร์รวม 1,000 แถว';

  @override
  String get achievementCombo5Title => 'เริ่มคอมโบ';

  @override
  String get achievementCombo5Body => 'ทำคอมโบ x5';

  @override
  String get achievementCombo10Title => 'ราชาคอมโบ';

  @override
  String get achievementCombo10Body => 'ทำคอมโบ x10';

  @override
  String get achievementLevel10Title => 'มีประสบการณ์';

  @override
  String get achievementLevel10Body => 'ถึงเลเวล 10';

  @override
  String get achievementLevel20Title => 'รุ่นเก๋า';

  @override
  String get achievementLevel20Body => 'ถึงเลเวล 20';

  @override
  String get achievementStreak7Title => 'ครบสัปดาห์';

  @override
  String get achievementStreak7Body => 'เล่นรายวันต่อเนื่อง 7 วัน';

  @override
  String get achievementStreak30Title => 'ครบเดือน';

  @override
  String get achievementStreak30Body => 'เล่นรายวันต่อเนื่อง 30 วัน';

  @override
  String get achievementPuzzles10Title => 'นักไขปริศนา';

  @override
  String get achievementPuzzles10Body => 'ไขปริศนา 10 ด่าน';

  @override
  String get achievementPieces5000Title => 'นักสร้าง';

  @override
  String get achievementPieces5000Body => 'วางบล็อก 5,000 ชิ้น';

  @override
  String streakRepairTitle(int streak) {
    return 'การเล่นต่อเนื่อง $streak วันกำลังจะขาด!';
  }

  @override
  String get streakRepairBody =>
      'เมื่อวานคุณไม่ได้เล่น — กู้การเล่นต่อเนื่องของคุณ:';

  @override
  String get streakRepairFailed => 'กู้คืนไม่ได้';

  @override
  String comebackGift(int coins) {
    return 'ยินดีต้อนรับกลับมา! +$coins เหรียญ';
  }

  @override
  String get notificationsOptInTitle => 'ให้เราเตือนไหม?';

  @override
  String get notificationsOptInBody =>
      'ให้เราเตือนเรื่องปริศนารายวันและช่วยรักษาการเล่นต่อเนื่องของคุณไหม? เปลี่ยนได้ทุกเมื่อในการตั้งค่า';

  @override
  String get notificationsOptInAccept => 'ตกลง';

  @override
  String get notificationChannelDescription =>
      'เตือนรายวัน เตือนการเล่นต่อเนื่อง และชวนกลับมาเล่น';

  @override
  String get notificationDailyTitle => 'ปริศนารายวันรอคุณอยู่ 🧩';

  @override
  String get notificationDailyBody => 'มาเล่นความท้าทายของวันนี้กัน!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 การเล่นต่อเนื่อง $streak วันของคุณกำลังจะขาด!';
  }

  @override
  String get notificationStreakBody => 'เล่นวันนี้เพื่อรักษาไว้';

  @override
  String get notificationComebackTitle => 'ปริศนาของคุณคิดถึงคุณ 🧩';

  @override
  String get notificationComebackBody => 'กลับมารับของขวัญกันเถอะ!';

  @override
  String get iapSupporterPack => 'แพ็กผู้สนับสนุน';

  @override
  String get iapCoinsSmall => '500 เหรียญ';

  @override
  String get iapCoinsMedium => '2,000 เหรียญ';

  @override
  String get iapCoinsLarge => '6,000 เหรียญ';

  @override
  String get iapStarterPack => 'แพ็กเริ่มต้น';

  @override
  String get iapRename => 'เปลี่ยนชื่อ';

  @override
  String get iapNeonTheme => 'ธีมนีออน';

  @override
  String get settingsLeaderboardDelete => 'ลบรายชื่อบนกระดานผู้นำ';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'ลบชื่อและคะแนนของคุณออกจากรายการสาธารณะ';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'ลบรายชื่อของคุณ?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'ชื่อและคะแนนของคุณจะถูกลบออกจากกระดานผู้นำ ความคืบหน้าในเกมจะไม่ได้รับผลกระทบ คุณกลับเข้าสู่กระดานผู้นำได้ทุกเมื่อ';

  @override
  String get settingsLeaderboardDeleteDone => 'ลบรายชื่อบนกระดานผู้นำแล้ว';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'ลบรายชื่อไม่สำเร็จ ตรวจสอบการเชื่อมต่อแล้วลองอีกครั้ง';

  @override
  String get leaderboardReport => 'รายงานชื่อนี้';

  @override
  String get leaderboardBlock => 'ซ่อน';

  @override
  String leaderboardBlocked(String name) {
    return 'ซ่อน $name แล้ว';
  }

  @override
  String get leaderboardUndo => 'เลิกทำ';

  @override
  String leaderboardBlockedCount(int count) {
    return 'คุณซ่อนไว้ $count รายการ';
  }

  @override
  String get leaderboardUnblockAll => 'แสดงอีกครั้ง';

  @override
  String get leaderboardReportUnavailable => 'รายงานไม่ได้ในขณะนี้';

  @override
  String get leaderboardReportSent => 'ขอบคุณ — ส่งรายงานของคุณแล้ว';

  @override
  String get leaderboardRules =>
      'ชื่อจะแสดงต่อสาธารณะ ห้ามดูหมิ่น ห้ามใช้คำเหยียด และห้ามใช้สิ่งที่ระบุตัวบุคคลจริง ชื่อที่ฝ่าฝืนจะถูกลบ';

  @override
  String get leaderboardRulesAccept => 'เข้าใจแล้ว';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return 'ปลดล็อกแล้ว $unlocked จาก $total';
  }

  @override
  String get settingsSectionData => 'ข้อมูลที่บันทึกไว้';

  @override
  String get gameRotatePiece => 'หมุนบล็อก';

  @override
  String get themeClassic => 'คลาสสิก';

  @override
  String get themeFade => 'พาสเทล';

  @override
  String get themeNeon => 'นีออน';

  @override
  String get themeOcean => 'มหาสมุทร';

  @override
  String get themeWood => 'ไม้';

  @override
  String get themeSunset => 'พระอาทิตย์ตก';

  @override
  String get themeForest => 'ป่าไม้';

  @override
  String get themeAurora => 'ออโรร่า';

  @override
  String get skinClassic => 'คลาสสิก';

  @override
  String get skinGradient => 'ไล่สี';

  @override
  String get skinOutline => 'เส้นขอบ';

  @override
  String get skinGlossy => 'เงางาม';

  @override
  String get skinStripe => 'ลายทาง';

  @override
  String get skinBevel => 'นูน';

  @override
  String get skinGlow => 'เรืองแสง';

  @override
  String get skinCrystal => 'คริสตัล';

  @override
  String rewardThemeName(String name) {
    return 'ธีม$name';
  }

  @override
  String rewardSkinName(String name) {
    return 'สกิน$name';
  }
}
