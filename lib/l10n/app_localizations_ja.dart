// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class L10nJa extends L10n {
  L10nJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'プレイ';

  @override
  String get commonLater => 'あとで';

  @override
  String get commonNotNow => '今はしない';

  @override
  String get commonCancel => 'キャンセル';

  @override
  String get commonBuy => '購入';

  @override
  String get commonSave => '保存';

  @override
  String get commonCollect => '受け取る';

  @override
  String get nameNewName => '新しい名前';

  @override
  String get nameFieldLabel => '名前';

  @override
  String get piggyFullTitle => '貯金箱がいっぱい！';

  @override
  String get piggyKeepSaving => '貯め続ける';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$capacity枚中$coins枚たまりました。';
  }

  @override
  String get homeContinueRun => '続きから';

  @override
  String get homeVideo => '動画';

  @override
  String get commonGotIt => 'OK';

  @override
  String get commonHome => 'ホーム';

  @override
  String get commonScore => 'スコア';

  @override
  String get commonBest => 'ベスト';

  @override
  String commonLevelShort(int level) {
    return 'レベル$level';
  }

  @override
  String get homeNewRun => '新しいゲームを始める';

  @override
  String get homeBackToExit => 'もう一度「戻る」で終了';

  @override
  String get homeEnableLeaderboard => 'ランキングに参加';

  @override
  String get homeBestScore => 'ベストスコア';

  @override
  String get homeDailyChallenge => 'デイリーチャレンジ';

  @override
  String get homeDailyOpenToday => '今日はまだ未プレイ';

  @override
  String homeDailyNextIn(String time) {
    return '次のチャレンジまで $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return '$streak日連続';
  }

  @override
  String get homeLeaderboard => 'ランキング';

  @override
  String get homePuzzleMode => 'パズルモード';

  @override
  String get homeHowToPlay => 'Qubbleの遊び方';

  @override
  String get homeWeekendBonus => '週末はコイン2倍！';

  @override
  String homeNextUnlock(int level, String name) {
    return 'レベル$level：$name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => '名前を変更';

  @override
  String get nameChangeExplainer => '名前はランキングでのあなたの証なので固定です。名前の変更を1回分購入できます。';

  @override
  String get nameChangeAfterPurchase => '購入後、もう一度名前をタップすると変更できます。';

  @override
  String get nameJoinedLeaderboard => 'ランキングに参加しました。';

  @override
  String nameProblemTooShort(int min) {
    return '$min文字以上にしてください。';
  }

  @override
  String nameProblemTooLong(int max) {
    return '$max文字以内にしてください。';
  }

  @override
  String get nameProblemInvalidCharacters =>
      '使えるのはラテン文字（A–Z、éなどのアクセント付きも可）、数字、スペース、_ と - だけです。';

  @override
  String get nameProblemOffensive => '別の名前を選んでください。';

  @override
  String get piggyTitle => '貯金箱';

  @override
  String get piggyFillingHint => 'ラインを消すと貯金箱にコインがたまります。';

  @override
  String piggyCollect(int coins) {
    return '$coinsコインを無料で受け取る。';
  }

  @override
  String get piggyEarlyOpenHint =>
      'いっぱいになったら無料で開けられます。ボーナス動画を見れば早めに開けることもできます。';

  @override
  String get piggyOpenNow => '今すぐ開ける';

  @override
  String get gameNewPiecesVideo => '新しいブロック（動画）';

  @override
  String get gameTapBoardCell => '盤面のマスをタップ';

  @override
  String get gameDailyChallengeLabel => 'デイリーチャレンジ';

  @override
  String get gameOver => 'ゲームオーバー';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'ボムにはあと$missingコイン必要です。';
  }

  @override
  String get gameBombNotHere => '今はここでボムを使えません。';

  @override
  String gameNeedsCoins(String missing) {
    return 'あと$missingコイン必要です。';
  }

  @override
  String get gameNotRightNow => '今はできません。';

  @override
  String get gameRunSaved => '保存しました — メニューの「続きから」で再開できます。';

  @override
  String get gameOverNoFit => 'どのブロックも盤面に置けなくなりました。';

  @override
  String get gameOverNoFitNoRotations => 'どのブロックも置けません — 回転の回数も残っていません。';

  @override
  String get gameStarterOfferUnavailable => '現在ご利用いただけません';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — 手に入れる';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'コンボ x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return '実績：$title';
  }

  @override
  String get gameBestSubmitted => 'ベスト更新 — 送信しました';

  @override
  String get gameReviveFor => '続ける · ';

  @override
  String gameRewardUnlocked(String name) {
    return '解放：$name';
  }

  @override
  String get gameStarterOfferTitle => 'スターターパック';

  @override
  String gameOverPoints(int score) {
    return '$score点';
  }

  @override
  String get gameNewRecord => '新記録！';

  @override
  String gameStreakDays(int streak) {
    return '$streak日連続';
  }

  @override
  String get gameDoubleCoins => 'コイン2倍';

  @override
  String get gameDoubleDaily => 'デイリー報酬2倍';

  @override
  String get gamePlayAgain => 'もう一度';

  @override
  String gameLevelReached(int level) {
    return 'レベル$levelに到達！';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return '$countレベルアップ — レベル$level！';
  }

  @override
  String get gameStarterOfferReward => '1200コイン＋テーマ「ウッド」';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return '残り$hours時間 — 1回限り！';
  }

  @override
  String get boosterUndo => '戻す';

  @override
  String get boosterSwap => '交換';

  @override
  String get boosterBomb => 'ボム';

  @override
  String get boosterNoRotationsLeft => '回転の回数がありません — ラインを消すと回復します！';

  @override
  String get onboardingDragPiece => 'ブロックを盤面にドラッグ';

  @override
  String get onboardingFillLine => '横か縦の1列をそろえよう';

  @override
  String get onboardingLinesClear => 'そろった列は消えてポイントに！';

  @override
  String get coachHintCombo => 'コンボ！3手以内にまた消すと続きます';

  @override
  String get coachHintFever => 'フィーバー！光っている間は得点2倍';

  @override
  String get coachHintRotation => '回転すると1回分減ります — ラインを消すと回復';

  @override
  String get coachHintBooster => 'ヒント：下のブースターが使えます';

  @override
  String get coachHintStrategy => 'ヒント：すぐに全部消さず、大きなブロック用の場所を残そう';

  @override
  String get dailyStreakLabel => '連続日数';

  @override
  String get dailyBestLabel => 'デイリーベスト';

  @override
  String dailyHistoryNote(int days) {
    return '直近$days日分が保存されます。';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day日：プレイ済み';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day日：未プレイ';
  }

  @override
  String get homeDailyCalendar => 'カレンダー';

  @override
  String get dailyShareButton => '結果をシェア';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble デイリー $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return '$score点 · 最大コンボ x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'プレイ：$url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    return 'コンボ：残り$moves手';
  }

  @override
  String get dailyShareCopied => '結果をクリップボードにコピーしました';

  @override
  String get adNotAvailable => '今は視聴できる動画がありません — 少し待ってからお試しください';

  @override
  String get howToPlaySpeedTitle => 'スピードボーナス';

  @override
  String get howToPlaySpeedBody =>
      '素早く置くと、消したラインの得点が最大30%アップします。ボーナスは1.5〜4秒の間に減っていき、上限もあります。速さは有利ですが勝敗を決めるほどではなく、じっくり考えたプレイが慌てたプレイに勝つことも十分あります。';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'スピードボーナス $percentパーセント';
  }

  @override
  String get iapDiamondsSmall => '100ダイヤ';

  @override
  String get iapDiamondsMedium => '350ダイヤ';

  @override
  String get iapDiamondsLarge => '1,000ダイヤ';

  @override
  String get howToPlayTitle => 'Qubbleの遊び方';

  @override
  String get howToPlayIntroHeadline => 'はじめるのは簡単。\n先を読むほど強くなる。';

  @override
  String get howToPlayIntroBody => '盤面をすっきり保って、ベストスコアを更新しよう。';

  @override
  String get howToPlayIntroSemantics => 'ゲームの目的。盤面をすっきり保って、ベストスコアを更新しよう。';

  @override
  String get howToPlayDragTitle => 'ドラッグして置く';

  @override
  String get howToPlayDragBody =>
      '3つのブロックのうち1つを空いているマスにドラッグします。3つとも使うと、自動で新しい3つが届きます。';

  @override
  String get howToPlayClearTitle => 'ラインを消す';

  @override
  String get howToPlayClearBody => '横か縦の1列をすべて埋めましょう。そろった列は消えて、次の手のための場所が空きます。';

  @override
  String get howToPlayComboTitle => 'コンボをつなぐ';

  @override
  String get howToPlayComboBody =>
      '3手以内にもう1列消すとコンボ。コンボが続くほど得点倍率が上がります。コンボは秒数ではなく手数で数えるので、考えている間に切れることはありません。';

  @override
  String get howToPlayFeverTitle => 'フィーバーを起こす';

  @override
  String get howToPlayFeverBody =>
      'ラインを消すとフィーバーゲージがたまります。満タンになると次の大消しが2倍に。大きな消し方を計画しよう。';

  @override
  String get howToPlayBoosterTitle => 'ブースターを上手に使う';

  @override
  String get howToPlayBoosterBody => 'ブースターはピンチを救います。トレイのブロックをタップすると回転もできます。';

  @override
  String get howToPlayDailyTitle => 'デイリーと連続記録';

  @override
  String get howToPlayDailyBody =>
      'デイリーチャレンジは全員が同じブロックで遊びます。毎日プレイして連続記録とボーナスを伸ばそう。';

  @override
  String get howToPlayPiggyTitle => '貯金箱をためる';

  @override
  String get howToPlayPiggyBody => 'ラインを消すたびに貯金箱にコインがたまります。いっぱいになったら無料で受け取れます。';

  @override
  String get leaderboardTitle => 'ランキング';

  @override
  String get leaderboardUnreachable => 'ランキングを表示できません。\nインターネットに接続して再度お試しください。';

  @override
  String get leaderboardEmpty => 'まだ誰もいません。\n一番乗りしよう！';

  @override
  String leaderboardSubmitting(int score) {
    return 'ベストスコア（$score）を送信中…';
  }

  @override
  String get leaderboardAutoSubmit => 'ベストスコアは自動で送信されます。';

  @override
  String get puzzleModeTitle => 'パズルモード';

  @override
  String puzzleLevelTitle(int level) {
    return 'パズル $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return '手数：$moves   •   目標：$target手で星3つ';
  }

  @override
  String get puzzleSolved => 'クリア！';

  @override
  String get puzzleLeaveTitle => 'パズルをやめますか？';

  @override
  String get puzzleLeaveBody => 'このパズルの進行状況は失われます。';

  @override
  String get puzzleKeepPlaying => '続ける';

  @override
  String get puzzleLeave => 'やめる';

  @override
  String get puzzleStuckTitle => '手詰まり';

  @override
  String get puzzleRestart => 'やり直す';

  @override
  String get commonActive => '使用中';

  @override
  String get commonRestore => '復元';

  @override
  String get skinsExchangeGold => 'ゴールドを交換';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'ブロックを回転';

  @override
  String get puzzleNextLevel => '次のレベル';

  @override
  String get puzzleBackToOverview => '一覧に戻る';

  @override
  String get puzzleUnsolvable => 'ここからは盤面を空にできません。';

  @override
  String get puzzleExtraMoveVideo => '追加の1手（動画）';

  @override
  String get puzzleHintVideo => 'ヒント（動画）';

  @override
  String get puzzleHintVideoCost => 'ヒント（動画・星が1つ減ります）';

  @override
  String get puzzleNoHint => 'ここからはヒントを出せません。パズルをやり直してください。';

  @override
  String puzzleSolvedCount(int solved) {
    return '$solved問クリア';
  }

  @override
  String get settingsTitle => '設定';

  @override
  String get storageFailureTitle => 'Qubbleがセーブデータを読み込めません';

  @override
  String get storageFailureBody =>
      'アプリを再起動してください。エラーが続く場合は、再インストールするしかありません。設定 › フィードバック から報告できます。';

  @override
  String get iapUnavailable => 'このオファーは現在ご利用いただけません。';

  @override
  String get iapFailed => '購入が完了しませんでした。料金は請求されていません。';

  @override
  String get settingsResetProgress => '進行状況をリセット';

  @override
  String get settingsResetProgressSubtitle =>
      'スコア、コイン、レベル、進行状況が最初に戻ります。購入、名前、見た目のアイテムは残ります。';

  @override
  String get settingsResetConfirmTitle => '進行状況をリセットしますか？';

  @override
  String get settingsResetConfirmBody =>
      'ベストスコア、コイン、レベル、連続記録、すべての進行状況が削除されます。元に戻すことはできません。\n\n購入、名前、解放済みのテーマとスキンは残ります。';

  @override
  String get settingsResetConfirmAction => 'リセット';

  @override
  String get settingsResetDone => '進行状況をリセットしました。';

  @override
  String get settingsSectionGame => 'ゲーム';

  @override
  String get settingsSectionSoundHaptics => 'サウンドと振動';

  @override
  String get settingsSectionReminders => 'リマインダー';

  @override
  String get settingsSectionPurchases => '購入';

  @override
  String get settingsSectionHelpOut => '応援する';

  @override
  String get settingsSectionLegal => '法的情報';

  @override
  String get settingsSectionLanguage => '言語';

  @override
  String get settingsGuide => '遊び方';

  @override
  String get settingsGuideSubtitle => 'ルール、コンボ、フィーバー、ブースター';

  @override
  String get settingsSound => '効果音';

  @override
  String get settingsMusic => '音楽';

  @override
  String get settingsHaptics => '振動';

  @override
  String get settingsHapticsOff => 'オフ';

  @override
  String get settingsHapticsLight => '弱';

  @override
  String get settingsHapticsStrong => '強';

  @override
  String get settingsSectionAccessibility => '快適さ';

  @override
  String get settingsReducedEffects => '演出を控えめに';

  @override
  String get settingsReducedEffectsHint => 'パーティクルを減らし、画面の揺れと発光をなくします';

  @override
  String get settingsNotifications => '通知';

  @override
  String get settingsNotificationsSubtitle => '毎日のリマインダーと連続記録の保護';

  @override
  String get settingsNotificationsSystemHint => '端末の設定で許可してください。';

  @override
  String get settingsLanguageSystem => '端末の言語';

  @override
  String get settingsSupporterThanks => 'サポーター — ありがとう！';

  @override
  String get settingsSupporterPack => 'サポーターパック';

  @override
  String get settingsSupporterPackSubtitle => '限定テーマ＆スキン＋1,500コイン';

  @override
  String get settingsRestorePurchases => '購入を復元';

  @override
  String get settingsRestoring => '購入を復元しています…';

  @override
  String get settingsRateApp => 'アプリを評価';

  @override
  String get settingsRateAppSubtitle => 'ストアで評価を残す';

  @override
  String get settingsStoreUnavailable => 'この端末ではストアを利用できません。';

  @override
  String get settingsFeedback => 'フィードバックを送る';

  @override
  String get settingsFeedbackSubtitle => 'アイデアや不具合を報告（GitHub経由）';

  @override
  String get settingsAdPrivacy => '広告のプライバシー';

  @override
  String get settingsAdPrivacySubtitle => '広告に関する同意を確認・変更';

  @override
  String get settingsAdPrivacyUnavailable => 'この端末では広告の設定は不要です。';

  @override
  String get settingsPrivacy => 'プライバシーポリシー';

  @override
  String get settingsImprint => '運営者情報';

  @override
  String get settingsPageOpenFailed => 'ページを開けませんでした。';

  @override
  String get settingsFooter => 'Qubble • オフライン ブロックパズル';

  @override
  String get settingsAdminSection => '管理者（テスト）';

  @override
  String get settingsAdminEnabled => '管理者モードを有効にしました';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'あと$count回タップで管理者モード';
  }

  @override
  String settingsAdminCoins(int coins) {
    return '$coinsコイン';
  }

  @override
  String get settingsAdminCoinsSubtitle => 'テスト専用 — リリース用スクリーンショットには使わないこと';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amountコイン';
  }

  @override
  String get settingsAdminResetCoins => 'コインを0にする';

  @override
  String get feedbackTitle => 'フィードバック';

  @override
  String get feedbackIntroShort =>
      '気に入った点、困った点、足りない点は？小さなことでも助かります。具体的なほど役立ちます。';

  @override
  String feedbackAttachmentNote(String build) {
    return '添付されるのは $build と端末の種類だけです。どのバージョンの話かを知るためです。';
  }

  @override
  String get feedbackSendByMail => 'メールで送る';

  @override
  String get feedbackPreferGithub => 'GitHubのissueで送る';

  @override
  String get feedbackThanksMail => 'ありがとうございます！あとはメッセージを送信するだけです。';

  @override
  String get feedbackNoMailApp => 'メールアプリが見つかりません。下のGitHubの方法をお試しください。';

  @override
  String get feedbackEmptyHint => 'まず内容を入力してください。';

  @override
  String get leaderboardRefresh => '更新';

  @override
  String get leaderboardRetry => '再試行';

  @override
  String get feedbackHint => 'フィードバック…';

  @override
  String get feedbackSubmit => 'フィードバックを送る';

  @override
  String get feedbackOpenFailed => 'GitHubを開けませんでした。あとでもう一度お試しください。';

  @override
  String get feedbackGithubNote =>
      'GitHubが開きます — そこで「Submit new issue」をタップしてください。（GitHubへのログインが1回必要です）';

  @override
  String get shopTitle => 'ショップ';

  @override
  String get shopWebDemoNote =>
      '購入はPlayストア版アプリでのみ可能です。このウェブ版は無料のデモですが、ここですべて遊べます。';

  @override
  String get shopSupporterExplainer =>
      'Qubbleには強制広告はありません — 何も買う必要はありません。サポーターパック（テーマ「オーロラ」、スキン「クリスタル」、1,500コイン、サポーターバッジ）は、ゲームを応援してくれたお礼です。購入はストアのアカウントにひもづき、いつでも復元できます。';

  @override
  String get shopSupporterContents => 'テーマ「オーロラ」＋スキン「クリスタル」＋1,500コイン';

  @override
  String get themesTitle => 'テーマ';

  @override
  String get themesSupporterOnly => 'サポーターパック限定（ショップを見る）';

  @override
  String get skinsTitle => 'ブロックスキン';

  @override
  String get skinsNotEnoughCoins => 'コインが足りません';

  @override
  String get skinsNotEnoughGold => 'ゴールドが足りません。';

  @override
  String skinsExchangeHint(int gold) {
    return '$goldゴールド＝1ダイヤ。ダイヤで最高のスキンを解放できます — のんびり集めよう。';
  }

  @override
  String get statsTitle => '統計';

  @override
  String get statsAverageScore => '平均スコア';

  @override
  String get statsBestCombo => '最大コンボ';

  @override
  String get statsGames => 'プレイ回数';

  @override
  String get statsLinesCleared => '消したライン';

  @override
  String get statsPiecesPlaced => '置いたブロック';

  @override
  String get statsCoins => 'コイン';

  @override
  String questCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countStringコンボを達成';
  }

  @override
  String questScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '1ゲームで$countString点を突破';
  }

  @override
  String get achievementsTitle => '実績';

  @override
  String get achievementFirstGameTitle => 'はじめの一歩';

  @override
  String get achievementFirstGameBody => '初めてプレイする';

  @override
  String get achievementGames25Title => '常連';

  @override
  String get achievementGames25Body => '25回プレイする';

  @override
  String get achievementGames100Title => 'やみつき';

  @override
  String get achievementGames100Body => '100回プレイする';

  @override
  String get achievementScore1kTitle => 'クライマー';

  @override
  String get achievementScore1kBody => '1,000点に到達';

  @override
  String get achievementScore5kTitle => 'プロ';

  @override
  String get achievementScore5kBody => '5,000点に到達';

  @override
  String get achievementScore10kTitle => 'マスター';

  @override
  String get achievementScore10kBody => '10,000点に到達';

  @override
  String get achievementScore25kTitle => 'レジェンド';

  @override
  String get achievementScore25kBody => '25,000点に到達';

  @override
  String get achievementLines100Title => 'きれい好き';

  @override
  String get achievementLines100Body => '合計100本のラインを消す';

  @override
  String get achievementLines1000Title => '大掃除';

  @override
  String get achievementLines1000Body => '合計1,000本のラインを消す';

  @override
  String get achievementCombo5Title => 'コンボ見習い';

  @override
  String get achievementCombo5Body => '5コンボを達成';

  @override
  String get achievementCombo10Title => 'コンボ王';

  @override
  String get achievementCombo10Body => '10コンボを達成';

  @override
  String get achievementLevel10Title => '経験者';

  @override
  String get achievementLevel10Body => 'レベル10に到達';

  @override
  String get achievementLevel20Title => 'ベテラン';

  @override
  String get achievementLevel20Body => 'レベル20に到達';

  @override
  String get achievementStreak7Title => '1週間連続';

  @override
  String get achievementStreak7Body => 'デイリーを7日連続でプレイ';

  @override
  String get achievementStreak30Title => '1か月連続';

  @override
  String get achievementStreak30Body => 'デイリーを30日連続でプレイ';

  @override
  String get achievementPuzzles10Title => 'パズル好き';

  @override
  String get achievementPuzzles10Body => 'パズルを10問クリア';

  @override
  String get achievementPieces5000Title => '建築家';

  @override
  String get achievementPieces5000Body => 'ブロックを5,000個置く';

  @override
  String streakRepairTitle(int streak) {
    return '$streak日連続の記録がピンチ！';
  }

  @override
  String get streakRepairBody => '昨日はプレイしていません — 連続記録を守ろう：';

  @override
  String get streakRepairFailed => '修復できません。';

  @override
  String comebackGift(int coins) {
    return 'おかえりなさい！ +$coinsコイン';
  }

  @override
  String get notificationsOptInTitle => 'リマインダーを受け取りますか？';

  @override
  String get notificationsOptInBody =>
      'デイリーチャレンジをお知らせして、連続記録を守りますか？設定でいつでも変更できます。';

  @override
  String get notificationsOptInAccept => 'はい、お願いします';

  @override
  String get notificationChannelDescription => '毎日のリマインダー、連続記録の警告、おかえり通知';

  @override
  String get notificationDailyTitle => '今日のパズルが待っています 🧩';

  @override
  String get notificationDailyBody => '今日のチャレンジをプレイしよう！';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 $streak日連続の記録がピンチ！';
  }

  @override
  String get notificationStreakBody => '今日プレイして記録をつなごう。';

  @override
  String get notificationComebackTitle => 'ブロックが待っています 🧩';

  @override
  String get notificationComebackBody => '戻ってきてプレゼントを受け取ろう！';

  @override
  String get iapSupporterPack => 'サポーターパック';

  @override
  String get iapCoinsSmall => '500コイン';

  @override
  String get iapCoinsMedium => '2,000コイン';

  @override
  String get iapCoinsLarge => '6,000コイン';

  @override
  String get iapStarterPack => 'スターターパック';

  @override
  String get iapRename => '名前の変更';

  @override
  String get iapNeonTheme => 'テーマ「ネオン」';

  @override
  String get settingsLeaderboardDelete => 'ランキングから削除';

  @override
  String get settingsLeaderboardDeleteSubtitle => '公開リストから名前とスコアを消します';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => 'エントリーを削除しますか？';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      '名前とスコアがランキングから削除されます。ゲームの進行状況はそのままです。いつでもランキングに再参加できます。';

  @override
  String get settingsLeaderboardDeleteDone => 'ランキングのエントリーを削除しました。';

  @override
  String get settingsLeaderboardDeleteFailed =>
      '削除できませんでした。接続を確認してもう一度お試しください。';

  @override
  String get leaderboardReport => 'この名前を報告';

  @override
  String get leaderboardBlock => 'ブロック';

  @override
  String leaderboardBlocked(String name) {
    return '$nameを非表示にしました';
  }

  @override
  String get leaderboardUndo => '元に戻す';

  @override
  String leaderboardBlockedCount(int count) {
    return '$count件を非表示にしています';
  }

  @override
  String get leaderboardUnblockAll => '再表示';

  @override
  String get leaderboardReportUnavailable => '現在は報告できません。';

  @override
  String get leaderboardReportSent => 'ありがとうございます — 報告を送信しています。';

  @override
  String get leaderboardRules =>
      '名前は公開されます。侮辱、差別的な言葉、実在の人物を特定できる内容は禁止です。違反する名前は削除されます。';

  @override
  String get leaderboardRulesAccept => '了解しました';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$total件中$unlocked件を解放';
  }

  @override
  String get settingsSectionData => '保存データ';

  @override
  String get gameRotatePiece => 'ブロックを回転';

  @override
  String get themeClassic => 'クラシック';

  @override
  String get themeFade => 'パステル';

  @override
  String get themeNeon => 'ネオン';

  @override
  String get themeOcean => 'オーシャン';

  @override
  String get themeWood => 'ウッド';

  @override
  String get themeSunset => 'サンセット';

  @override
  String get themeForest => 'フォレスト';

  @override
  String get themeAurora => 'オーロラ';

  @override
  String get skinClassic => 'クラシック';

  @override
  String get skinGradient => 'グラデーション';

  @override
  String get skinOutline => 'アウトライン';

  @override
  String get skinGlossy => 'グロッシー';

  @override
  String get skinStripe => 'ストライプ';

  @override
  String get skinBevel => 'ベベル';

  @override
  String get skinGlow => 'グロー';

  @override
  String get skinCrystal => 'クリスタル';

  @override
  String rewardThemeName(String name) {
    return 'テーマ「$name」';
  }

  @override
  String rewardSkinName(String name) {
    return 'スキン「$name」';
  }

  @override
  String get skinPulse => 'パルス';

  @override
  String get skinShimmer => 'シマー';

  @override
  String get skinWave => 'ウェーブ';

  @override
  String get skinEmber => 'エンバー';

  @override
  String get skinPrism => 'プリズム';

  @override
  String get skinStardust => 'スターダスト';

  @override
  String get skinCircuit => 'サーキット';

  @override
  String get skinRipple => 'リップル';

  @override
  String achievementRewardSkin(String name) {
    return 'アニメーションスキン「$name」';
  }

  @override
  String skinsAchievementReward(String achievement) {
    return '実績の報酬：$achievement';
  }

  @override
  String get achievementBackpay => '実績に報酬がつくようになりました。あなたの報酬は付与済みです。';

  @override
  String get namePromptBody => '名前を決めると、ベストスコアがランキングに載ります。名前なしでも匿名のまま遊べます。';

  @override
  String get nameTaken => 'この名前はすでに使われています。別の名前を試してください。';

  @override
  String get nameCheckFailed => '名前を確認できませんでした。オンラインですか？少ししてからもう一度お試しください。';

  @override
  String nameLost(String name) {
    return '$nameは別のプレイヤーの名前になりました。新しい名前を無料で選べます。';
  }

  @override
  String get themeCandy => 'キャンディ';

  @override
  String get themeVolcano => 'ボルケーノ';

  @override
  String get themeGlacier => 'グレイシャー';

  @override
  String get skinPixel => 'ピクセル';

  @override
  String get skinMarble => 'マーブル';

  @override
  String get skinJelly => 'ゼリー';

  @override
  String get skinLiquid => 'リキッド';

  @override
  String get skinFizz => 'ソーダ';

  @override
  String get skinPlasma => 'プラズマ';

  @override
  String get designsTitle => 'デザイン';

  @override
  String get designsNotEnoughDiamonds => 'ダイヤが足りません。';

  @override
  String get designsOwned => '所持';

  @override
  String get designsAchievementOnly => '実績';

  @override
  String get designsSupporterOnly => 'サポーター';

  @override
  String get designsPreview => 'プレビュー';

  @override
  String get designsGetDiamonds => 'ダイヤを入手';

  @override
  String get shopDealTitle => '本日のセール';

  @override
  String get shopAnimatedSkins => 'アニメーションスキン';

  @override
  String get shopNewDesigns => '新デザイン';

  @override
  String get shopDiamonds => 'ダイヤ';

  @override
  String get shopPacks => 'パック';

  @override
  String get shopPopular => '人気';

  @override
  String get shopBestValue => 'お得';

  @override
  String get shopDiamondsBlurb => 'アニメーションスキンと新デザインに。';

  @override
  String get shopCoinsBlurb => 'テーマ・スキン・ブースターに。';

  @override
  String get shopNeonBlurb => 'テーマ「ネオン」をすぐに解放します。';

  @override
  String get shopRenameBlurb => 'ランキングの名前を変更します。';

  @override
  String shopHoursLeft(int hours) {
    return '残り$hours時間';
  }

  @override
  String shopNewDealIn(String time) {
    return '次のセールまで$time';
  }

  @override
  String shopDesignUnlocked(String name) {
    return '$nameを解放しました！';
  }

  @override
  String get questsTitle => 'クエスト';

  @override
  String get questsDaily => 'デイリー';

  @override
  String get questsWeekly => 'ウィークリー';

  @override
  String get questsMonthly => 'マンスリー';

  @override
  String questsNewIn(String time) {
    return '新しいクエストまで$time';
  }

  @override
  String get questsBonus => '全達成ボーナス';

  @override
  String get questsBonusEarned => 'ボーナス獲得済み';

  @override
  String get questRounds => 'ラウンドをプレイ';

  @override
  String get questLines => 'ラインを消す';

  @override
  String get questPieces => 'ブロックを置く';

  @override
  String get questDailyChallenge => 'デイリーチャレンジをプレイ';

  @override
  String get questPuzzles => '新しいパズルを解く';

  @override
  String get questDays => '別々の日にプレイ';

  @override
  String get questDailySets => 'デイリークエストをすべて達成';

  @override
  String get questsSetDaily => 'デイリークエストをすべて達成！';

  @override
  String get questsSetWeekly => 'ウィークリークエストをすべて達成！';

  @override
  String get questsSetMonthly => 'マンスリークエストをすべて達成！';

  @override
  String get leaderboardTabScore => 'ハイスコア';

  @override
  String get leaderboardTabPuzzle => 'パズルの星';

  @override
  String get leaderboardPuzzleAutoSubmit => 'パズルの星は自動で送信されます。';

  @override
  String leaderboardPuzzleSubmitting(int stars) {
    return 'パズルの星（$stars）を送信中…';
  }

  @override
  String get dailyGoalTitle => '今日の目標';

  @override
  String dailyGoalPoints(String points) {
    return '$points点';
  }

  @override
  String get dailyChestOpened => '連続記録の宝箱を開けた！';

  @override
  String dailyNextChest(int day) {
    return '次の宝箱：連続$day日目';
  }

  @override
  String get dailyExplainer =>
      '今日は全員が同じ盤面で遊び、最初の1回が記録になります。星の目標に届けばコインを追加でもらえ、連続記録を続ければダイヤの宝箱がもらえます。今日の順位もチェックしよう。';

  @override
  String dailyRank(int rank, int total) {
    return '今日$total人中$rank位';
  }

  @override
  String get dailyRankNeedsName => '名前を決めるとランキングに載ります。';

  @override
  String get dailyRankingButton => '今日のランキング';

  @override
  String get leaderboardTabDaily => '今日のチャレンジ';

  @override
  String get leaderboardDailyFooter => '全員同じ盤面、最初の1回が記録になります。ランキングは毎日新しくなります。';

  @override
  String notificationChestBody(int diamonds) {
    return '今日のチャレンジで連続記録の宝箱を開けよう：$diamonds 💎';
  }

  @override
  String get themePumpkin => 'かぼちゃ';

  @override
  String get skinGhost => 'おばけ';

  @override
  String get halloweenTitle => 'ハロウィン';

  @override
  String get halloweenBody => 'かぼちゃテーマとおばけスキン。10月だけ！';

  @override
  String get designsBackInOctober => 'また10月に';

  @override
  String get shopFreeTitle => '無料ボーナス';

  @override
  String get shopFreeWatch => '動画を見る';

  @override
  String shopFreeToday(int left, int total) {
    return '今日：$left/$total';
  }

  @override
  String get shopFreeTomorrow => 'また明日';

  @override
  String get designsAccessories => 'アクセサリー';

  @override
  String get designsBursts => '爆発エフェクト';

  @override
  String get accessoryNone => 'なし';

  @override
  String get accessoryCobweb => 'クモの巣';

  @override
  String get accessorySnowCap => '雪帽子';

  @override
  String get accessoryCrown => '王冠';

  @override
  String get accessoryFlower => 'お花';

  @override
  String get accessorySparkle => 'きらめき';

  @override
  String get accessoryDewdrop => 'しずく';

  @override
  String get burstClassic => 'クラシック';

  @override
  String get burstConfetti => '紙吹雪';

  @override
  String get burstFire => '炎';

  @override
  String get burstPixels => 'ピクセル';

  @override
  String get burstStars => '星';

  @override
  String get burstBubbles => 'シャボン玉';

  @override
  String bestShareText(String score) {
    return 'Qubbleで自己ベスト更新：$score点！ これを超えられる？';
  }
}
