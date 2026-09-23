// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class L10nZh extends L10n {
  L10nZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => '开始';

  @override
  String get commonLater => '稍后';

  @override
  String get commonNotNow => '现在不要';

  @override
  String get commonCancel => '取消';

  @override
  String get commonBuy => '购买';

  @override
  String get commonSave => '保存';

  @override
  String get commonCollect => '领取';

  @override
  String get nameNewName => '新名称';

  @override
  String get nameFieldLabel => '名称';

  @override
  String get piggyFullTitle => '存钱罐存满了！';

  @override
  String get piggyKeepSaving => '继续存';

  @override
  String piggyProgress(int coins, int capacity) {
    return '已存入 $coins / $capacity。';
  }

  @override
  String get homeContinueRun => '继续';

  @override
  String get homeVideo => '视频';

  @override
  String get commonGotIt => '知道了';

  @override
  String get commonHome => '首页';

  @override
  String get commonScore => '分数';

  @override
  String get commonBest => '最高';

  @override
  String commonLevelShort(int level) {
    return '等级 $level';
  }

  @override
  String get homeNewRun => '开始新的一局';

  @override
  String get homeBackToExit => '再按一次返回键即可离开';

  @override
  String get homeEnableLeaderboard => '加入排行榜';

  @override
  String get homeBestScore => '最高分';

  @override
  String get homeDailyChallenge => '每日挑战';

  @override
  String get homeDailyOpenToday => '今天还没挑战';

  @override
  String homeDailyNextIn(String time) {
    return '下次每日挑战：$time 后';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return '连续 $streak 天';
  }

  @override
  String get homeLeaderboard => '排行榜';

  @override
  String get homePuzzleMode => '解谜模式';

  @override
  String get homeMissions => '任务';

  @override
  String get homeThemes => '主题';

  @override
  String get homeSkins => '造型';

  @override
  String get homeHowToPlay => 'Qubble 玩法';

  @override
  String get homeWeekendBonus => '周末：金币加倍！';

  @override
  String homeNextUnlock(int level, String name) {
    return '等级 $level：$name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => '更改名称';

  @override
  String get nameChangeExplainer => '你的名称就是你在排行榜上的身份，所以无法随意更改。你可以购买一次改名机会。';

  @override
  String get nameChangeAfterPurchase => '购买后，再点一次你的名称即可更改。';

  @override
  String get nameJoinedLeaderboard => '你已加入排行榜。';

  @override
  String get nameRenameUnavailable => '目前无法改名。';

  @override
  String nameProblemTooShort(int min) {
    return '至少 $min 个字符。';
  }

  @override
  String nameProblemTooLong(int max) {
    return '最多 $max 个字符。';
  }

  @override
  String get nameProblemInvalidCharacters => '只能使用英文字母（A–Z）、数字、空格、_ 和 -。';

  @override
  String get nameProblemOffensive => '请换一个名称。';

  @override
  String get piggyTitle => '存钱罐';

  @override
  String get piggyFillingHint => '每消除一条线，存钱罐就会存入金币。';

  @override
  String piggyCollect(int coins) {
    return '免费领取 $coins 金币。';
  }

  @override
  String get piggyEarlyOpenHint => '存满后可以免费取出，也可以观看奖励视频提早打开。';

  @override
  String get piggyOpenNow => '立即打开';

  @override
  String get gameNewPiecesVideo => '换新方块（视频）';

  @override
  String get gameTapBoardCell => '点击棋盘上的格子';

  @override
  String get gameDailyChallengeLabel => '每日挑战';

  @override
  String get gameOver => '游戏结束';

  @override
  String gameBombNeedsCoins(String missing) {
    return '还差 $missing 金币才能使用炸弹。';
  }

  @override
  String get gameBombNotHere => '炸弹现在不能用在这里。';

  @override
  String gameNeedsCoins(String missing) {
    return '还差 $missing 金币。';
  }

  @override
  String get gameNotRightNow => '目前无法操作。';

  @override
  String get gameRunSaved => '已保存本局 — 在菜单中点“继续”。';

  @override
  String get gameOverNoFit => '你的方块都放不进棋盘了。';

  @override
  String get gameOverNoFitNoRotations => '你的方块都放不进去 — 旋转次数也用完了。';

  @override
  String get gameStarterOfferUnavailable => '目前无法购买';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — 立即购买';
  }

  @override
  String gameComboMultiplier(int combo) {
    return '连击 x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return '成就：$title';
  }

  @override
  String get gameBestSubmitted => '新纪录 — 已上传';

  @override
  String get gameReviveFor => '继续游戏 · ';

  @override
  String gameRewardUnlocked(String name) {
    return '已解锁：$name';
  }

  @override
  String get gameStarterOfferTitle => '新手礼包';

  @override
  String gameOverPoints(int score) {
    return '$score 分';
  }

  @override
  String get gameNewRecord => '新纪录！';

  @override
  String gameStreakDays(int streak) {
    return '连续 $streak 天';
  }

  @override
  String get gameDoubleCoins => '金币加倍';

  @override
  String get gameDoubleDaily => '每日奖励加倍';

  @override
  String get gamePlayAgain => '再玩一次';

  @override
  String gameLevelReached(int level) {
    return '升到 $level 级了！';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return '连升 $count 级 — 现在是 $level 级！';
  }

  @override
  String get gameStarterOfferReward => '1200 金币 + 木纹主题';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return '只剩 $hours 小时 — 限购一次！';
  }

  @override
  String get boosterUndo => '撤销';

  @override
  String get boosterSwap => '交换';

  @override
  String get boosterBomb => '炸弹';

  @override
  String get boosterNoRotationsLeft => '旋转次数用完了 — 消除线条即可补充！';

  @override
  String get onboardingDragPiece => '把方块拖到棋盘上';

  @override
  String get onboardingFillLine => '填满一整行或一整列';

  @override
  String get onboardingLinesClear => '填满的线会消失 — 得分！';

  @override
  String get coachHintCombo => '连击！3 步内再消除一次就能延续';

  @override
  String get coachHintFever => '狂热！发光期间得分加倍';

  @override
  String get coachHintRotation => '旋转会消耗一次充能 — 消除可以补回';

  @override
  String get coachHintBooster => '提示：下方可以使用道具';

  @override
  String get coachHintStrategy => '提示：不必一次消完所有线 — 留点空间给大方块';

  @override
  String get dailyStreakLabel => '连续天数';

  @override
  String get dailyBestLabel => '每日最佳';

  @override
  String dailyHistoryNote(int days) {
    return '保留最近 $days 天的记录。';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day 日：已挑战';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day 日：未挑战';
  }

  @override
  String get homeDailyCalendar => '日历';

  @override
  String get dailyShareButton => '分享成绩';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble 每日挑战 $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return '$score 分 · 最高连击 x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return '来玩：$url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    return '连击：还剩 $moves 步';
  }

  @override
  String get dailyShareCopied => '成绩已拷贝到剪贴板';

  @override
  String get adNotAvailable => '目前没有可播放的视频 — 请稍后再试';

  @override
  String get howToPlaySpeedTitle => '速度加成';

  @override
  String get howToPlaySpeedBody =>
      '放得越快，消除得分最多可增加 30%。加成会在 1.5 到 4 秒之间逐渐减少，而且有上限，所以快有好处，却不会决定胜负 — 谨慎的慢速对局仍然可以胜过匆忙的快速对局。';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return '速度加成百分之 $percent';
  }

  @override
  String get iapDiamondsSmall => '100 钻石';

  @override
  String get iapDiamondsMedium => '350 钻石';

  @override
  String get iapDiamondsLarge => '1,000 钻石';

  @override
  String get howToPlayTitle => 'Qubble 玩法';

  @override
  String get howToPlayIntroHeadline => '上手容易，\n预先规划更有利。';

  @override
  String get howToPlayIntroBody => '保持棋盘净空，打破你的最高分。';

  @override
  String get howToPlayIntroSemantics => '游戏目标。保持棋盘净空，打破你的最高分。';

  @override
  String get howToPlayDragTitle => '拖动与放置';

  @override
  String get howToPlayDragBody => '把三个方块中的一个拖到空格上。三个都用完后，会自动给你三个新方块。';

  @override
  String get howToPlayClearTitle => '消除线条';

  @override
  String get howToPlayClearBody => '填满一整行或一整列。填满的线会消失，为下一步腾出空间。';

  @override
  String get howToPlayComboTitle => '打出连击';

  @override
  String get howToPlayComboBody =>
      '在三步内再消除一条线。每延续一次连击，得分倍率就会提高。连击计算的是步数而不是秒数，所以你思考时不会中断。';

  @override
  String get howToPlayFeverTitle => '触发狂热';

  @override
  String get howToPlayFeverBody => '消除会积累狂热槽。狂热槽满了之后，下一次消除得分加倍 — 提前规划大消除吧。';

  @override
  String get howToPlayBoosterTitle => '善用道具';

  @override
  String get howToPlayBoosterBody => '道具能拯救危急的对局。你也可以点击托盘中的方块来旋转它。';

  @override
  String get howToPlayDailyTitle => '每日挑战与连续记录';

  @override
  String get howToPlayDailyBody => '每日挑战对每个人都使用相同的方块。每天游玩，累积连续天数和奖励。';

  @override
  String get howToPlayPiggyTitle => '存满存钱罐';

  @override
  String get howToPlayPiggyBody => '每消除一条线都会往存钱罐里存钱。存满后，你可以免费领取金币。';

  @override
  String get leaderboardTitle => '排行榜';

  @override
  String get leaderboardUnreachable => '无法使用排行榜。\n请连接网络后再试一次。';

  @override
  String get leaderboardEmpty => '还没有任何记录。\n来当第一名吧！';

  @override
  String leaderboardSubmitting(int score) {
    return '正在上传你的最高分（$score）…';
  }

  @override
  String get leaderboardAutoSubmit => '你的最高分会自动上传。';

  @override
  String get puzzleModeTitle => '解谜模式';

  @override
  String puzzleLevelTitle(int level) {
    return '谜题 $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return '步数：$moves   •   目标：$target 步内得 3 颗星';
  }

  @override
  String get puzzleSolved => '解开了！';

  @override
  String get puzzleLeaveTitle => '要离开这道谜题吗？';

  @override
  String get puzzleLeaveBody => '这道谜题的进度将会遗失。';

  @override
  String get puzzleKeepPlaying => '继续玩';

  @override
  String get puzzleLeave => '离开';

  @override
  String get puzzleStuckTitle => '卡住了';

  @override
  String get puzzleRestart => '重新开始';

  @override
  String get commonActive => '使用中';

  @override
  String get commonTapToActivate => '点击启用';

  @override
  String get commonRestore => '恢复';

  @override
  String unlockForCost(int cost) {
    return '$cost 解锁';
  }

  @override
  String get skinsExchangeGold => '兑换黄金';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => '旋转方块';

  @override
  String get puzzleNextLevel => '下一关';

  @override
  String get puzzleBackToOverview => '返回总览';

  @override
  String get puzzleUnsolvable => '从这里已经无法清空棋盘了。';

  @override
  String get puzzleExtraMoveVideo => '多一步（视频）';

  @override
  String puzzleSolvedCount(int solved) {
    return '已解开 $solved 题';
  }

  @override
  String get settingsTitle => '设置';

  @override
  String get storageFailureTitle => 'Qubble 无法加载你的存档';

  @override
  String get storageFailureBody =>
      '请重新启动 App。如果错误持续发生，只能重新安装。你可以在“设置 › 发送反馈”中反馈这个问题。';

  @override
  String get iapUnavailable => '目前无法提供此优惠。';

  @override
  String get iapFailed => '购买没有完成，也没有扣款。';

  @override
  String get settingsResetProgress => '重置进度';

  @override
  String get settingsResetProgressSubtitle => '分数、金币、等级和进度会回到起点。购买项目、名称和外观会保留。';

  @override
  String get settingsResetConfirmTitle => '要重置进度吗？';

  @override
  String get settingsResetConfirmBody =>
      '最高分、金币、等级、连续记录和所有进度都会被删除，而且无法恢复。\n\n你的购买项目、名称以及已解锁的主题和造型会保留。';

  @override
  String get settingsResetConfirmAction => '重置';

  @override
  String get settingsResetDone => '进度已重置。';

  @override
  String get settingsSectionGame => '游戏';

  @override
  String get settingsSectionSoundHaptics => '音效与振动';

  @override
  String get settingsSectionReminders => '提醒';

  @override
  String get settingsSectionPurchases => '购买';

  @override
  String get settingsSectionHelpOut => '支持我们';

  @override
  String get settingsSectionLegal => '法律信息';

  @override
  String get settingsSectionLanguage => '语言';

  @override
  String get settingsGuide => '玩法说明';

  @override
  String get settingsGuideSubtitle => '规则、连击、狂热与道具';

  @override
  String get settingsSound => '音效';

  @override
  String get settingsMusic => '音乐';

  @override
  String get settingsHaptics => '振动';

  @override
  String get settingsHapticsOff => '关闭';

  @override
  String get settingsHapticsLight => '轻';

  @override
  String get settingsHapticsStrong => '强';

  @override
  String get settingsSectionAccessibility => '舒适';

  @override
  String get settingsReducedEffects => '减少特效';

  @override
  String get settingsReducedEffectsHint => '更少粒子、无画面震动、无光晕';

  @override
  String get settingsNotifications => '通知';

  @override
  String get settingsNotificationsSubtitle => '每日提醒与连续记录保护';

  @override
  String get settingsNotificationsSystemHint => '请在系统设置中允许通知。';

  @override
  String get settingsLanguageSystem => '系统语言';

  @override
  String get settingsSupporterThanks => '支持者 — 谢谢你！';

  @override
  String get settingsSupporterPack => '支持者礼包';

  @override
  String get settingsSupporterPackSubtitle => '专属主题与造型 + 1,500 金币';

  @override
  String get settingsRestorePurchases => '恢复购买';

  @override
  String get settingsRestoring => '正在恢复购买…';

  @override
  String get settingsRateApp => '为 App 评分';

  @override
  String get settingsRateAppSubtitle => '在商店留下评分';

  @override
  String get settingsStoreUnavailable => '这台设备无法使用商店。';

  @override
  String get settingsFeedback => '发送反馈';

  @override
  String get settingsFeedbackSubtitle => '反馈想法与错误（通过 GitHub）';

  @override
  String get settingsAdPrivacy => '广告隐私设置';

  @override
  String get settingsAdPrivacySubtitle => '查看或更改你的广告同意设置';

  @override
  String get settingsAdPrivacyUnavailable => '这台设备不需要广告选项。';

  @override
  String get settingsPrivacy => '隐私政策';

  @override
  String get settingsImprint => '运营者信息';

  @override
  String get settingsPageOpenFailed => '无法打开页面。';

  @override
  String get settingsFooter => 'Qubble • 离线方块拼图';

  @override
  String get settingsAdminSection => '管理员（测试）';

  @override
  String get settingsAdminEnabled => '已启用管理员模式';

  @override
  String settingsAdminTapsLeft(int count) {
    return '再点 $count 次即可进入管理员模式';
  }

  @override
  String settingsAdminCoins(int coins) {
    return '$coins 金币';
  }

  @override
  String get settingsAdminCoinsSubtitle => '仅供测试 — 切勿出现在正式版截屏中';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount 金币';
  }

  @override
  String get settingsAdminResetCoins => '金币归零';

  @override
  String get feedbackTitle => '意见反馈';

  @override
  String get feedbackIntroShort => '你喜欢什么、什么让你困扰、还缺少什么？小事也有帮助 — 越具体越好。';

  @override
  String feedbackAttachmentNote(String build) {
    return '只会附上 $build 和你的设备型号 — 让我知道你说的是哪个版本。';
  }

  @override
  String get feedbackSendByMail => '用电子邮件发送';

  @override
  String get feedbackPreferGithub => '改用 GitHub issue';

  @override
  String get feedbackThanksMail => '谢谢！直接发送邮件即可。';

  @override
  String get feedbackNoMailApp => '找不到邮件 App。请试试下方的 GitHub 方式。';

  @override
  String get feedbackEmptyHint => '请先输入内容。';

  @override
  String get leaderboardRefresh => '刷新';

  @override
  String get leaderboardRetry => '再试一次';

  @override
  String get feedbackHint => '你的意见…';

  @override
  String get feedbackSubmit => '发送反馈';

  @override
  String get feedbackOpenFailed => '无法打开 GitHub，请稍后再试。';

  @override
  String get feedbackGithubNote =>
      '即将打开 GitHub — 请在那里点“Submit new issue”。（需要登录 GitHub 一次）';

  @override
  String get shopTitle => '商店';

  @override
  String get shopWebDemoNote =>
      '只有从 Play 商店下载的 App 才能购买。这个网页版是免费试玩版 — 你仍然可以在这里玩到全部内容。';

  @override
  String get shopSupporterExplainer =>
      'Qubble 没有强制广告 — 你完全不需要购买任何东西。支持者礼包（极光主题、水晶造型、1,500 金币、支持者徽章）是对你支持这款游戏的感谢。购买项目绑定你的商店账户，随时都能恢复。';

  @override
  String get shopSupporterContents => '极光主题 + 水晶造型 + 1,500 金币';

  @override
  String get themesTitle => '主题';

  @override
  String get themesSupporterOnly => '支持者礼包专属（请见商店）';

  @override
  String get themesInSupporterPack => '包含在支持者礼包中';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return '金币不足（需要 $cost，目前 $coins）';
  }

  @override
  String get skinsTitle => '方块造型';

  @override
  String get skinsNotEnoughDiamonds => '钻石不足（可在下方兑换黄金）';

  @override
  String get skinsNotEnoughCoins => '金币不足';

  @override
  String get skinsNotEnoughGold => '黄金不足。';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold 黄金 = 1 钻石。钻石可以解锁最精致的造型 — 慢慢收集吧。';
  }

  @override
  String get statsTitle => '统计';

  @override
  String get statsAverageScore => '平均分数';

  @override
  String get statsBestCombo => '最高连击';

  @override
  String get statsGames => '局数';

  @override
  String get statsLinesCleared => '消除线数';

  @override
  String get statsPiecesPlaced => '放置方块数';

  @override
  String get statsCoins => '金币';

  @override
  String get missionsTitle => '任务';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '放置 $countString 个方块';
  }

  @override
  String missionClearRows(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '消除 $countString 条线';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '达成 x$countString 连击';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '单局突破 $countString 分';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '玩 $countString 局';
  }

  @override
  String get achievementsTitle => '成就';

  @override
  String get achievementFirstGameTitle => '第一局';

  @override
  String get achievementFirstGameBody => '玩你的第一局';

  @override
  String get achievementGames25Title => '常客';

  @override
  String get achievementGames25Body => '玩 25 局';

  @override
  String get achievementGames100Title => '上瘾了';

  @override
  String get achievementGames100Body => '玩 100 局';

  @override
  String get achievementScore1kTitle => '攀登者';

  @override
  String get achievementScore1kBody => '达到 1,000 分';

  @override
  String get achievementScore5kTitle => '高手';

  @override
  String get achievementScore5kBody => '达到 5,000 分';

  @override
  String get achievementScore10kTitle => '大师';

  @override
  String get achievementScore10kBody => '达到 10,000 分';

  @override
  String get achievementScore25kTitle => '传奇';

  @override
  String get achievementScore25kBody => '达到 25,000 分';

  @override
  String get achievementLines100Title => '井井有条';

  @override
  String get achievementLines100Body => '累计消除 100 条线';

  @override
  String get achievementLines1000Title => '大扫除';

  @override
  String get achievementLines1000Body => '累计消除 1,000 条线';

  @override
  String get achievementCombo5Title => '连击新手';

  @override
  String get achievementCombo5Body => '达成 x5 连击';

  @override
  String get achievementCombo10Title => '连击之王';

  @override
  String get achievementCombo10Body => '达成 x10 连击';

  @override
  String get achievementLevel10Title => '经验丰富';

  @override
  String get achievementLevel10Body => '达到 10 级';

  @override
  String get achievementLevel20Title => '老将';

  @override
  String get achievementLevel20Body => '达到 20 级';

  @override
  String get achievementStreak7Title => '连续一周';

  @override
  String get achievementStreak7Body => '每日挑战连续 7 天';

  @override
  String get achievementStreak30Title => '连续一个月';

  @override
  String get achievementStreak30Body => '每日挑战连续 30 天';

  @override
  String get achievementPuzzles10Title => '解谜者';

  @override
  String get achievementPuzzles10Body => '解开 10 道谜题';

  @override
  String get achievementPieces5000Title => '建筑师';

  @override
  String get achievementPieces5000Body => '放置 5,000 个方块';

  @override
  String streakRepairTitle(int streak) {
    return '连续 $streak 天的记录岌岌可危！';
  }

  @override
  String get streakRepairBody => '你昨天没有玩 — 挽救你的连续记录：';

  @override
  String get streakRepairFailed => '无法修复。';

  @override
  String comebackGift(int coins) {
    return '欢迎回来！+$coins 金币';
  }

  @override
  String get notificationsOptInTitle => '要开启提醒吗？';

  @override
  String get notificationsOptInBody => '要我们提醒你每日谜题，帮你守住连续记录吗？你随时可以在设置中更改。';

  @override
  String get notificationsOptInAccept => '好，提醒我';

  @override
  String get notificationChannelDescription => '每日提醒、连续记录警告、回归提醒';

  @override
  String get notificationDailyTitle => '你的每日谜题在等你 🧩';

  @override
  String get notificationDailyBody => '来挑战今天的关卡吧！';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 你连续 $streak 天的记录岌岌可危！';
  }

  @override
  String get notificationStreakBody => '今天玩一局就能保住。';

  @override
  String get notificationComebackTitle => '你的谜题想念你 🧩';

  @override
  String get notificationComebackBody => '回来领取礼物吧！';

  @override
  String get iapSupporterPack => '支持者礼包';

  @override
  String get iapCoinsSmall => '500 金币';

  @override
  String get iapCoinsMedium => '2,000 金币';

  @override
  String get iapCoinsLarge => '6,000 金币';

  @override
  String get iapStarterPack => '新手礼包';

  @override
  String get iapRename => '改名';

  @override
  String get iapNeonTheme => '霓虹主题';

  @override
  String get settingsLeaderboardDelete => '删除排行榜记录';

  @override
  String get settingsLeaderboardDeleteSubtitle => '从公开名单中移除你的名称和分数';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => '要删除你的记录吗？';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      '你的名称和分数将从排行榜移除。游戏进度不受影响。你随时可以再次加入排行榜。';

  @override
  String get settingsLeaderboardDeleteDone => '你的排行榜记录已删除。';

  @override
  String get settingsLeaderboardDeleteFailed => '无法删除记录。请检查网络连接后再试一次。';

  @override
  String get leaderboardReport => '举报这个名称';

  @override
  String get leaderboardBlock => '屏蔽';

  @override
  String leaderboardBlocked(String name) {
    return '已为你隐藏 $name';
  }

  @override
  String get leaderboardUndo => '撤销';

  @override
  String leaderboardBlockedCount(int count) {
    return '你已隐藏 $count 条记录';
  }

  @override
  String get leaderboardUnblockAll => '重新显示';

  @override
  String get leaderboardReportUnavailable => '目前无法举报。';

  @override
  String get leaderboardReportSent => '谢谢 — 你的举报已送出。';

  @override
  String get leaderboardRules => '名称会公开显示。禁止辱骂、歧视用语，以及任何能辨识真实人物的内容。违规的名称会被移除。';

  @override
  String get leaderboardRulesAccept => '我了解';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '已解锁 $unlocked / $total';
  }

  @override
  String get settingsSectionData => '存档数据';

  @override
  String get gameRotatePiece => '旋转方块';

  @override
  String get themeClassic => '经典';

  @override
  String get themeFade => '粉彩';

  @override
  String get themeNeon => '霓虹';

  @override
  String get themeOcean => '海洋';

  @override
  String get themeWood => '木纹';

  @override
  String get themeSunset => '夕阳';

  @override
  String get themeForest => '森林';

  @override
  String get themeAurora => '极光';

  @override
  String get skinClassic => '经典';

  @override
  String get skinGradient => '渐变';

  @override
  String get skinOutline => '描边';

  @override
  String get skinGlossy => '光泽';

  @override
  String get skinStripe => '条纹';

  @override
  String get skinBevel => '斜角';

  @override
  String get skinGlow => '发光';

  @override
  String get skinCrystal => '水晶';

  @override
  String rewardThemeName(String name) {
    return '$name主题';
  }

  @override
  String rewardSkinName(String name) {
    return '$name造型';
  }
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class L10nZhHant extends L10nZh {
  L10nZhHant() : super('zh_Hant');

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => '開始';

  @override
  String get commonLater => '稍後';

  @override
  String get commonNotNow => '現在不要';

  @override
  String get commonCancel => '取消';

  @override
  String get commonBuy => '購買';

  @override
  String get commonSave => '儲存';

  @override
  String get commonCollect => '領取';

  @override
  String get nameNewName => '新名稱';

  @override
  String get nameFieldLabel => '名稱';

  @override
  String get piggyFullTitle => '小豬撲滿存滿了！';

  @override
  String get piggyKeepSaving => '繼續存';

  @override
  String piggyProgress(int coins, int capacity) {
    return '已存入 $coins / $capacity。';
  }

  @override
  String get homeContinueRun => '繼續';

  @override
  String get homeVideo => '影片';

  @override
  String get commonGotIt => '知道了';

  @override
  String get commonHome => '首頁';

  @override
  String get commonScore => '分數';

  @override
  String get commonBest => '最高';

  @override
  String commonLevelShort(int level) {
    return '等級 $level';
  }

  @override
  String get homeNewRun => '開始新的一局';

  @override
  String get homeBackToExit => '再按一次返回鍵即可離開';

  @override
  String get homeEnableLeaderboard => '加入排行榜';

  @override
  String get homeBestScore => '最高分';

  @override
  String get homeDailyChallenge => '每日挑戰';

  @override
  String get homeDailyOpenToday => '今天還沒挑戰';

  @override
  String homeDailyNextIn(String time) {
    return '下次每日挑戰：$time 後';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return '連續 $streak 天';
  }

  @override
  String get homeLeaderboard => '排行榜';

  @override
  String get homePuzzleMode => '解謎模式';

  @override
  String get homeMissions => '任務';

  @override
  String get homeThemes => '主題';

  @override
  String get homeSkins => '造型';

  @override
  String get homeHowToPlay => 'Qubble 玩法';

  @override
  String get homeWeekendBonus => '週末：金幣加倍！';

  @override
  String homeNextUnlock(int level, String name) {
    return '等級 $level：$name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => '更改名稱';

  @override
  String get nameChangeExplainer => '你的名稱就是你在排行榜上的身分，所以無法隨意更改。你可以購買一次改名機會。';

  @override
  String get nameChangeAfterPurchase => '購買後，再點一次你的名稱即可更改。';

  @override
  String get nameJoinedLeaderboard => '你已加入排行榜。';

  @override
  String get nameRenameUnavailable => '目前無法改名。';

  @override
  String nameProblemTooShort(int min) {
    return '至少 $min 個字元。';
  }

  @override
  String nameProblemTooLong(int max) {
    return '最多 $max 個字元。';
  }

  @override
  String get nameProblemInvalidCharacters => '只能使用英文字母（A–Z）、數字、空格、_ 和 -。';

  @override
  String get nameProblemOffensive => '請換一個名稱。';

  @override
  String get piggyTitle => '小豬撲滿';

  @override
  String get piggyFillingHint => '每消除一條線，小豬撲滿就會存入金幣。';

  @override
  String piggyCollect(int coins) {
    return '免費領取 $coins 金幣。';
  }

  @override
  String get piggyEarlyOpenHint => '存滿後可以免費取出，也可以觀看獎勵影片提早打開。';

  @override
  String get piggyOpenNow => '立即打開';

  @override
  String get gameNewPiecesVideo => '換新方塊（影片）';

  @override
  String get gameTapBoardCell => '點選棋盤上的格子';

  @override
  String get gameDailyChallengeLabel => '每日挑戰';

  @override
  String get gameOver => '遊戲結束';

  @override
  String gameBombNeedsCoins(String missing) {
    return '還差 $missing 金幣才能使用炸彈。';
  }

  @override
  String get gameBombNotHere => '炸彈現在不能用在這裡。';

  @override
  String gameNeedsCoins(String missing) {
    return '還差 $missing 金幣。';
  }

  @override
  String get gameNotRightNow => '目前無法執行。';

  @override
  String get gameRunSaved => '已儲存本局 — 在選單中點「繼續」。';

  @override
  String get gameOverNoFit => '你的方塊都放不進棋盤了。';

  @override
  String get gameOverNoFitNoRotations => '你的方塊都放不進去 — 旋轉次數也用完了。';

  @override
  String get gameStarterOfferUnavailable => '目前無法購買';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — 立即購買';
  }

  @override
  String gameComboMultiplier(int combo) {
    return '連擊 x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return '成就：$title';
  }

  @override
  String get gameBestSubmitted => '新紀錄 — 已上傳';

  @override
  String get gameReviveFor => '繼續遊戲 · ';

  @override
  String gameRewardUnlocked(String name) {
    return '已解鎖：$name';
  }

  @override
  String get gameStarterOfferTitle => '新手禮包';

  @override
  String gameOverPoints(int score) {
    return '$score 分';
  }

  @override
  String get gameNewRecord => '新紀錄！';

  @override
  String gameStreakDays(int streak) {
    return '連續 $streak 天';
  }

  @override
  String get gameDoubleCoins => '金幣加倍';

  @override
  String get gameDoubleDaily => '每日獎勵加倍';

  @override
  String get gamePlayAgain => '再玩一次';

  @override
  String gameLevelReached(int level) {
    return '升到 $level 級了！';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return '連升 $count 級 — 現在是 $level 級！';
  }

  @override
  String get gameStarterOfferReward => '1200 金幣 + 木紋主題';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return '只剩 $hours 小時 — 限購一次！';
  }

  @override
  String get boosterUndo => '復原';

  @override
  String get boosterSwap => '交換';

  @override
  String get boosterBomb => '炸彈';

  @override
  String get boosterNoRotationsLeft => '旋轉次數用完了 — 消除線條即可補充！';

  @override
  String get onboardingDragPiece => '把方塊拖到棋盤上';

  @override
  String get onboardingFillLine => '填滿一整個橫列或直行';

  @override
  String get onboardingLinesClear => '填滿的線會消失 — 得分！';

  @override
  String get coachHintCombo => '連擊！3 步內再消除一次就能延續';

  @override
  String get coachHintFever => '狂熱！發光期間得分加倍';

  @override
  String get coachHintRotation => '旋轉會消耗一次充能 — 消除可以補回';

  @override
  String get coachHintBooster => '提示：下方可以使用道具';

  @override
  String get coachHintStrategy => '提示：不必一次消完所有線 — 留點空間給大方塊';

  @override
  String get dailyStreakLabel => '連續天數';

  @override
  String get dailyBestLabel => '每日最佳';

  @override
  String dailyHistoryNote(int days) {
    return '保留最近 $days 天的紀錄。';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day 日：已挑戰';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day 日：未挑戰';
  }

  @override
  String get homeDailyCalendar => '日曆';

  @override
  String get dailyShareButton => '分享成績';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble 每日挑戰 $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return '$score 分 · 最高連擊 x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return '來玩：$url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    return '連擊：還剩 $moves 步';
  }

  @override
  String get dailyShareCopied => '成績已複製到剪貼簿';

  @override
  String get adNotAvailable => '目前沒有可播放的影片 — 請稍後再試';

  @override
  String get howToPlaySpeedTitle => '速度加成';

  @override
  String get howToPlaySpeedBody =>
      '放得越快，消除得分最多可增加 30%。加成會在 1.5 到 4 秒之間逐漸減少，而且有上限，所以快有好處，卻不會決定勝負 — 謹慎的慢速對局仍然可以勝過匆忙的快速對局。';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return '速度加成百分之 $percent';
  }

  @override
  String get iapDiamondsSmall => '100 鑽石';

  @override
  String get iapDiamondsMedium => '350 鑽石';

  @override
  String get iapDiamondsLarge => '1,000 鑽石';

  @override
  String get howToPlayTitle => 'Qubble 玩法';

  @override
  String get howToPlayIntroHeadline => '上手容易，\n預先規劃更有利。';

  @override
  String get howToPlayIntroBody => '保持棋盤淨空，打破你的最高分。';

  @override
  String get howToPlayIntroSemantics => '遊戲目標。保持棋盤淨空，打破你的最高分。';

  @override
  String get howToPlayDragTitle => '拖曳與放置';

  @override
  String get howToPlayDragBody => '把三個方塊中的一個拖到空格上。三個都用完後，會自動給你三個新方塊。';

  @override
  String get howToPlayClearTitle => '消除線條';

  @override
  String get howToPlayClearBody => '填滿一整個橫列或直行。填滿的線會消失，為下一步騰出空間。';

  @override
  String get howToPlayComboTitle => '串連連擊';

  @override
  String get howToPlayComboBody =>
      '在三步內再消除一條線。每延續一次連擊，得分倍率就會提高。連擊計算的是步數而不是秒數，所以你思考時不會中斷。';

  @override
  String get howToPlayFeverTitle => '觸發狂熱';

  @override
  String get howToPlayFeverBody => '消除會累積狂熱量表。量表滿了之後，下一次消除得分加倍 — 提前規劃大消除吧。';

  @override
  String get howToPlayBoosterTitle => '善用道具';

  @override
  String get howToPlayBoosterBody => '道具能拯救危急的對局。你也可以點選托盤中的方塊來旋轉它。';

  @override
  String get howToPlayDailyTitle => '每日挑戰與連續紀錄';

  @override
  String get howToPlayDailyBody => '每日挑戰對每個人都使用相同的方塊。每天遊玩，累積連續天數和獎勵。';

  @override
  String get howToPlayPiggyTitle => '存滿小豬撲滿';

  @override
  String get howToPlayPiggyBody => '每消除一條線都會存入小豬撲滿。存滿後，你可以免費領取金幣。';

  @override
  String get leaderboardTitle => '排行榜';

  @override
  String get leaderboardUnreachable => '無法使用排行榜。\n請連上網路後再試一次。';

  @override
  String get leaderboardEmpty => '還沒有任何紀錄。\n來當第一名吧！';

  @override
  String leaderboardSubmitting(int score) {
    return '正在上傳你的最高分（$score）…';
  }

  @override
  String get leaderboardAutoSubmit => '你的最高分會自動上傳。';

  @override
  String get puzzleModeTitle => '解謎模式';

  @override
  String puzzleLevelTitle(int level) {
    return '謎題 $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return '步數：$moves   •   目標：$target 步內得 3 顆星';
  }

  @override
  String get puzzleSolved => '解開了！';

  @override
  String get puzzleLeaveTitle => '要離開這道謎題嗎？';

  @override
  String get puzzleLeaveBody => '這道謎題的進度將會遺失。';

  @override
  String get puzzleKeepPlaying => '繼續玩';

  @override
  String get puzzleLeave => '離開';

  @override
  String get puzzleStuckTitle => '卡住了';

  @override
  String get puzzleRestart => '重新開始';

  @override
  String get commonActive => '使用中';

  @override
  String get commonTapToActivate => '點選以啟用';

  @override
  String get commonRestore => '恢復';

  @override
  String unlockForCost(int cost) {
    return '$cost 解鎖';
  }

  @override
  String get skinsExchangeGold => '兌換黃金';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => '旋轉方塊';

  @override
  String get puzzleNextLevel => '下一關';

  @override
  String get puzzleBackToOverview => '返回總覽';

  @override
  String get puzzleUnsolvable => '從這裡已經無法清空棋盤了。';

  @override
  String get puzzleExtraMoveVideo => '多一步（影片）';

  @override
  String puzzleSolvedCount(int solved) {
    return '已解開 $solved 題';
  }

  @override
  String get settingsTitle => '設定';

  @override
  String get storageFailureTitle => 'Qubble 無法載入你的存檔';

  @override
  String get storageFailureBody =>
      '請重新啟動 App。如果錯誤持續發生，只能重新安裝。你可以在「設定 › 傳送意見回饋」回報這個問題。';

  @override
  String get iapUnavailable => '目前無法提供此優惠。';

  @override
  String get iapFailed => '購買沒有完成，也沒有扣款。';

  @override
  String get settingsResetProgress => '重設進度';

  @override
  String get settingsResetProgressSubtitle => '分數、金幣、等級和進度會回到起點。購買項目、名稱和外觀會保留。';

  @override
  String get settingsResetConfirmTitle => '要重設進度嗎？';

  @override
  String get settingsResetConfirmBody =>
      '最高分、金幣、等級、連續紀錄和所有進度都會被刪除，而且無法復原。\n\n你的購買項目、名稱以及已解鎖的主題和造型會保留。';

  @override
  String get settingsResetConfirmAction => '重設';

  @override
  String get settingsResetDone => '進度已重設。';

  @override
  String get settingsSectionGame => '遊戲';

  @override
  String get settingsSectionSoundHaptics => '音效與震動';

  @override
  String get settingsSectionReminders => '提醒';

  @override
  String get settingsSectionPurchases => '購買';

  @override
  String get settingsSectionHelpOut => '支持我們';

  @override
  String get settingsSectionLegal => '法律資訊';

  @override
  String get settingsSectionLanguage => '語言';

  @override
  String get settingsGuide => '玩法說明';

  @override
  String get settingsGuideSubtitle => '規則、連擊、狂熱與道具';

  @override
  String get settingsSound => '音效';

  @override
  String get settingsMusic => '音樂';

  @override
  String get settingsHaptics => '震動';

  @override
  String get settingsHapticsOff => '關閉';

  @override
  String get settingsHapticsLight => '輕';

  @override
  String get settingsHapticsStrong => '強';

  @override
  String get settingsSectionAccessibility => '舒適';

  @override
  String get settingsReducedEffects => '減少特效';

  @override
  String get settingsReducedEffectsHint => '更少粒子、無畫面震動、無光暈';

  @override
  String get settingsNotifications => '通知';

  @override
  String get settingsNotificationsSubtitle => '每日提醒與連續紀錄保護';

  @override
  String get settingsNotificationsSystemHint => '請在系統設定中允許通知。';

  @override
  String get settingsLanguageSystem => '系統語言';

  @override
  String get settingsSupporterThanks => '支持者 — 謝謝你！';

  @override
  String get settingsSupporterPack => '支持者禮包';

  @override
  String get settingsSupporterPackSubtitle => '專屬主題與造型 + 1,500 金幣';

  @override
  String get settingsRestorePurchases => '恢復購買';

  @override
  String get settingsRestoring => '正在恢復購買…';

  @override
  String get settingsRateApp => '為 App 評分';

  @override
  String get settingsRateAppSubtitle => '在商店留下評分';

  @override
  String get settingsStoreUnavailable => '這台裝置無法使用商店。';

  @override
  String get settingsFeedback => '傳送意見回饋';

  @override
  String get settingsFeedbackSubtitle => '回報點子與錯誤（透過 GitHub）';

  @override
  String get settingsAdPrivacy => '廣告隱私設定';

  @override
  String get settingsAdPrivacySubtitle => '查看或更改你的廣告同意設定';

  @override
  String get settingsAdPrivacyUnavailable => '這台裝置不需要廣告選項。';

  @override
  String get settingsPrivacy => '隱私權政策';

  @override
  String get settingsImprint => '營運者資訊';

  @override
  String get settingsPageOpenFailed => '無法開啟頁面。';

  @override
  String get settingsFooter => 'Qubble • 離線方塊拼圖';

  @override
  String get settingsAdminSection => '管理員（測試）';

  @override
  String get settingsAdminEnabled => '已啟用管理員模式';

  @override
  String settingsAdminTapsLeft(int count) {
    return '再點 $count 次即可進入管理員模式';
  }

  @override
  String settingsAdminCoins(int coins) {
    return '$coins 金幣';
  }

  @override
  String get settingsAdminCoinsSubtitle => '僅供測試 — 切勿出現在正式版截圖中';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount 金幣';
  }

  @override
  String get settingsAdminResetCoins => '金幣歸零';

  @override
  String get feedbackTitle => '意見回饋';

  @override
  String get feedbackIntroShort => '你喜歡什麼、什麼讓你困擾、還缺少什麼？小事也有幫助 — 越具體越好。';

  @override
  String feedbackAttachmentNote(String build) {
    return '只會附上 $build 和你的裝置型號 — 讓我知道你說的是哪個版本。';
  }

  @override
  String get feedbackSendByMail => '用電子郵件傳送';

  @override
  String get feedbackPreferGithub => '改用 GitHub issue';

  @override
  String get feedbackThanksMail => '謝謝！直接送出訊息即可。';

  @override
  String get feedbackNoMailApp => '找不到郵件 App。請試試下方的 GitHub 方式。';

  @override
  String get feedbackEmptyHint => '請先輸入內容。';

  @override
  String get leaderboardRefresh => '重新整理';

  @override
  String get leaderboardRetry => '再試一次';

  @override
  String get feedbackHint => '你的意見…';

  @override
  String get feedbackSubmit => '傳送意見回饋';

  @override
  String get feedbackOpenFailed => '無法開啟 GitHub，請稍後再試。';

  @override
  String get feedbackGithubNote =>
      '即將開啟 GitHub — 請在那裡點「Submit new issue」。（需要登入 GitHub 一次）';

  @override
  String get shopTitle => '商店';

  @override
  String get shopWebDemoNote =>
      '只有從 Play 商店下載的 App 才能購買。這個網頁版是免費試玩版 — 你仍然可以在這裡玩到全部內容。';

  @override
  String get shopSupporterExplainer =>
      'Qubble 沒有強制廣告 — 你完全不需要購買任何東西。支持者禮包（極光主題、水晶造型、1,500 金幣、支持者徽章）是對你支持這款遊戲的感謝。購買項目綁定你的商店帳戶，隨時都能恢復。';

  @override
  String get shopSupporterContents => '極光主題 + 水晶造型 + 1,500 金幣';

  @override
  String get themesTitle => '主題';

  @override
  String get themesSupporterOnly => '支持者禮包專屬（請見商店）';

  @override
  String get themesInSupporterPack => '包含在支持者禮包中';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return '金幣不足（需要 $cost，目前 $coins）';
  }

  @override
  String get skinsTitle => '方塊造型';

  @override
  String get skinsNotEnoughDiamonds => '鑽石不足（可在下方兌換黃金）';

  @override
  String get skinsNotEnoughCoins => '金幣不足';

  @override
  String get skinsNotEnoughGold => '黃金不足。';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold 黃金 = 1 鑽石。鑽石可以解鎖最精緻的造型 — 慢慢收集吧。';
  }

  @override
  String get statsTitle => '統計';

  @override
  String get statsAverageScore => '平均分數';

  @override
  String get statsBestCombo => '最高連擊';

  @override
  String get statsGames => '局數';

  @override
  String get statsLinesCleared => '消除線數';

  @override
  String get statsPiecesPlaced => '放置方塊數';

  @override
  String get statsCoins => '金幣';

  @override
  String get missionsTitle => '任務';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '放置 $countString 個方塊';
  }

  @override
  String missionClearRows(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '消除 $countString 條線';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '達成 x$countString 連擊';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '單局突破 $countString 分';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '玩 $countString 局';
  }

  @override
  String get achievementsTitle => '成就';

  @override
  String get achievementFirstGameTitle => '第一局';

  @override
  String get achievementFirstGameBody => '玩你的第一局';

  @override
  String get achievementGames25Title => '常客';

  @override
  String get achievementGames25Body => '玩 25 局';

  @override
  String get achievementGames100Title => '上癮了';

  @override
  String get achievementGames100Body => '玩 100 局';

  @override
  String get achievementScore1kTitle => '攀登者';

  @override
  String get achievementScore1kBody => '達到 1,000 分';

  @override
  String get achievementScore5kTitle => '高手';

  @override
  String get achievementScore5kBody => '達到 5,000 分';

  @override
  String get achievementScore10kTitle => '大師';

  @override
  String get achievementScore10kBody => '達到 10,000 分';

  @override
  String get achievementScore25kTitle => '傳奇';

  @override
  String get achievementScore25kBody => '達到 25,000 分';

  @override
  String get achievementLines100Title => '井井有條';

  @override
  String get achievementLines100Body => '累計消除 100 條線';

  @override
  String get achievementLines1000Title => '大掃除';

  @override
  String get achievementLines1000Body => '累計消除 1,000 條線';

  @override
  String get achievementCombo5Title => '連擊新手';

  @override
  String get achievementCombo5Body => '達成 x5 連擊';

  @override
  String get achievementCombo10Title => '連擊之王';

  @override
  String get achievementCombo10Body => '達成 x10 連擊';

  @override
  String get achievementLevel10Title => '經驗豐富';

  @override
  String get achievementLevel10Body => '達到 10 級';

  @override
  String get achievementLevel20Title => '老將';

  @override
  String get achievementLevel20Body => '達到 20 級';

  @override
  String get achievementStreak7Title => '連續一週';

  @override
  String get achievementStreak7Body => '每日挑戰連續 7 天';

  @override
  String get achievementStreak30Title => '連續一個月';

  @override
  String get achievementStreak30Body => '每日挑戰連續 30 天';

  @override
  String get achievementPuzzles10Title => '解謎者';

  @override
  String get achievementPuzzles10Body => '解開 10 道謎題';

  @override
  String get achievementPieces5000Title => '建築師';

  @override
  String get achievementPieces5000Body => '放置 5,000 個方塊';

  @override
  String streakRepairTitle(int streak) {
    return '連續 $streak 天的紀錄岌岌可危！';
  }

  @override
  String get streakRepairBody => '你昨天沒有玩 — 挽救你的連續紀錄：';

  @override
  String get streakRepairFailed => '無法修復。';

  @override
  String comebackGift(int coins) {
    return '歡迎回來！+$coins 金幣';
  }

  @override
  String get notificationsOptInTitle => '要開啟提醒嗎？';

  @override
  String get notificationsOptInBody => '要我們提醒你每日謎題，幫你守住連續紀錄嗎？你隨時可以在設定中更改。';

  @override
  String get notificationsOptInAccept => '好，提醒我';

  @override
  String get notificationChannelDescription => '每日提醒、連續紀錄警告、回歸提醒';

  @override
  String get notificationDailyTitle => '你的每日謎題在等你 🧩';

  @override
  String get notificationDailyBody => '來挑戰今天的關卡吧！';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 你連續 $streak 天的紀錄岌岌可危！';
  }

  @override
  String get notificationStreakBody => '今天玩一局就能保住。';

  @override
  String get notificationComebackTitle => '你的謎題想念你 🧩';

  @override
  String get notificationComebackBody => '回來領取禮物吧！';

  @override
  String get iapSupporterPack => '支持者禮包';

  @override
  String get iapCoinsSmall => '500 金幣';

  @override
  String get iapCoinsMedium => '2,000 金幣';

  @override
  String get iapCoinsLarge => '6,000 金幣';

  @override
  String get iapStarterPack => '新手禮包';

  @override
  String get iapRename => '改名';

  @override
  String get iapNeonTheme => '霓虹主題';

  @override
  String get settingsLeaderboardDelete => '刪除排行榜紀錄';

  @override
  String get settingsLeaderboardDeleteSubtitle => '從公開名單中移除你的名稱和分數';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => '要刪除你的紀錄嗎？';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      '你的名稱和分數將從排行榜移除。遊戲進度不受影響。你隨時可以再次加入排行榜。';

  @override
  String get settingsLeaderboardDeleteDone => '你的排行榜紀錄已刪除。';

  @override
  String get settingsLeaderboardDeleteFailed => '無法刪除紀錄。請檢查網路連線後再試一次。';

  @override
  String get leaderboardReport => '檢舉這個名稱';

  @override
  String get leaderboardBlock => '封鎖';

  @override
  String leaderboardBlocked(String name) {
    return '已為你隱藏 $name';
  }

  @override
  String get leaderboardUndo => '復原';

  @override
  String leaderboardBlockedCount(int count) {
    return '你已隱藏 $count 筆紀錄';
  }

  @override
  String get leaderboardUnblockAll => '重新顯示';

  @override
  String get leaderboardReportUnavailable => '目前無法檢舉。';

  @override
  String get leaderboardReportSent => '謝謝 — 你的檢舉已送出。';

  @override
  String get leaderboardRules => '名稱會公開顯示。禁止辱罵、歧視用語，以及任何能辨識真實人物的內容。違規的名稱會被移除。';

  @override
  String get leaderboardRulesAccept => '我了解';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '已解鎖 $unlocked / $total';
  }

  @override
  String get settingsSectionData => '存檔資料';

  @override
  String get gameRotatePiece => '旋轉方塊';

  @override
  String get themeClassic => '經典';

  @override
  String get themeFade => '粉彩';

  @override
  String get themeNeon => '霓虹';

  @override
  String get themeOcean => '海洋';

  @override
  String get themeWood => '木紋';

  @override
  String get themeSunset => '夕陽';

  @override
  String get themeForest => '森林';

  @override
  String get themeAurora => '極光';

  @override
  String get skinClassic => '經典';

  @override
  String get skinGradient => '漸層';

  @override
  String get skinOutline => '描邊';

  @override
  String get skinGlossy => '亮面';

  @override
  String get skinStripe => '條紋';

  @override
  String get skinBevel => '斜角';

  @override
  String get skinGlow => '發光';

  @override
  String get skinCrystal => '水晶';

  @override
  String rewardThemeName(String name) {
    return '$name主題';
  }

  @override
  String rewardSkinName(String name) {
    return '$name造型';
  }
}
