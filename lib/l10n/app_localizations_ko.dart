// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class L10nKo extends L10n {
  L10nKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => '플레이';

  @override
  String get commonLater => '나중에';

  @override
  String get commonNotNow => '다음에';

  @override
  String get commonCancel => '취소';

  @override
  String get commonBuy => '구매';

  @override
  String get commonSave => '저장';

  @override
  String get commonCollect => '받기';

  @override
  String get nameNewName => '새 이름';

  @override
  String get nameFieldLabel => '이름';

  @override
  String get piggyFullTitle => '돼지 저금통이 가득 찼어요!';

  @override
  String get piggyKeepSaving => '계속 모으기';

  @override
  String piggyProgress(int coins, int capacity) {
    return '$capacity개 중 $coins개를 모았어요.';
  }

  @override
  String get homeContinueRun => '이어하기';

  @override
  String get homeVideo => '동영상';

  @override
  String get commonGotIt => '확인';

  @override
  String get commonHome => '홈';

  @override
  String get commonScore => '점수';

  @override
  String get commonBest => '최고';

  @override
  String commonLevelShort(int level) {
    return '레벨 $level';
  }

  @override
  String get homeNewRun => '새 게임 시작';

  @override
  String get homeBackToExit => '한 번 더 뒤로 가기를 누르면 종료돼요';

  @override
  String get homeEnableLeaderboard => '순위표 참가하기';

  @override
  String get homeBestScore => '최고 점수';

  @override
  String get homeDailyChallenge => '일일 챌린지';

  @override
  String get homeDailyOpenToday => '오늘 아직 안 했어요';

  @override
  String homeDailyNextIn(String time) {
    return '다음 챌린지까지 $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    return '$streak일 연속';
  }

  @override
  String get homeLeaderboard => '순위표';

  @override
  String get homePuzzleMode => '퍼즐 모드';

  @override
  String get homeMissions => '미션';

  @override
  String get homeThemes => '테마';

  @override
  String get homeSkins => '스킨';

  @override
  String get homeHowToPlay => 'Qubble 플레이 방법';

  @override
  String get homeWeekendBonus => '주말: 코인 2배!';

  @override
  String homeNextUnlock(int level, String name) {
    return '레벨 $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => '이름 변경';

  @override
  String get nameChangeExplainer =>
      '이름은 순위표에서 당신을 나타내므로 고정돼요. 이름 변경권 1회를 구매할 수 있어요.';

  @override
  String get nameChangeAfterPurchase => '구매 후 이름을 다시 탭하면 변경할 수 있어요.';

  @override
  String get nameJoinedLeaderboard => '이제 순위표에 올랐어요.';

  @override
  String get nameRenameUnavailable => '지금은 이름을 변경할 수 없어요.';

  @override
  String nameProblemTooShort(int min) {
    return '$min자 이상 입력하세요.';
  }

  @override
  String nameProblemTooLong(int max) {
    return '$max자 이하로 입력하세요.';
  }

  @override
  String get nameProblemInvalidCharacters =>
      '영문자(A–Z), 숫자, 공백, _ 및 -만 사용할 수 있어요.';

  @override
  String get nameProblemOffensive => '다른 이름을 골라 주세요.';

  @override
  String get piggyTitle => '돼지 저금통';

  @override
  String get piggyFillingHint => '줄을 지울 때마다 돼지 저금통이 채워져요.';

  @override
  String piggyCollect(int coins) {
    return '$coins코인을 무료로 받으세요.';
  }

  @override
  String get piggyEarlyOpenHint =>
      '가득 차면 무료로 열 수 있어요. 보너스 동영상을 보면 미리 열 수도 있어요.';

  @override
  String get piggyOpenNow => '지금 열기';

  @override
  String get gameNewPiecesVideo => '새 블록 (동영상)';

  @override
  String get gameTapBoardCell => '보드의 칸을 탭하세요';

  @override
  String get gameDailyChallengeLabel => '일일 챌린지';

  @override
  String get gameOver => '게임 오버';

  @override
  String gameBombNeedsCoins(String missing) {
    return '폭탄을 쓰려면 코인이 $missing개 더 필요해요.';
  }

  @override
  String get gameBombNotHere => '지금은 여기서 폭탄을 쓸 수 없어요.';

  @override
  String gameNeedsCoins(String missing) {
    return '코인이 $missing개 더 필요해요.';
  }

  @override
  String get gameNotRightNow => '지금은 할 수 없어요.';

  @override
  String get gameRunSaved => '저장했어요 — 메뉴의 “이어하기”로 계속하세요.';

  @override
  String get gameOverNoFit => '더 이상 보드에 들어가는 블록이 없어요.';

  @override
  String get gameOverNoFitNoRotations => '들어가는 블록이 없어요 — 회전 횟수도 다 썼어요.';

  @override
  String get gameStarterOfferUnavailable => '지금은 이용할 수 없어요';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — 받기';
  }

  @override
  String gameComboMultiplier(int combo) {
    return '콤보 x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return '업적: $title';
  }

  @override
  String get gameBestSubmitted => '최고 기록 — 제출 완료';

  @override
  String get gameReviveFor => '계속하기 · ';

  @override
  String gameRewardUnlocked(String name) {
    return '잠금 해제: $name';
  }

  @override
  String get gameStarterOfferTitle => '스타터 팩';

  @override
  String gameOverPoints(int score) {
    return '$score점';
  }

  @override
  String get gameNewRecord => '신기록!';

  @override
  String gameStreakDays(int streak) {
    return '$streak일 연속';
  }

  @override
  String get gameDoubleCoins => '코인 2배 받기';

  @override
  String get gameDoubleDaily => '일일 보상 2배 받기';

  @override
  String get gamePlayAgain => '다시 하기';

  @override
  String gameLevelReached(int level) {
    return '레벨 $level 달성!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    return '$count레벨 상승 — 레벨 $level!';
  }

  @override
  String get gameStarterOfferReward => '1200코인 + 우드 테마';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    return '$hours시간 남음 — 단 한 번!';
  }

  @override
  String get boosterUndo => '되돌리기';

  @override
  String get boosterSwap => '교체';

  @override
  String get boosterBomb => '폭탄';

  @override
  String get boosterNoRotationsLeft => '회전 횟수가 없어요 — 줄을 지우면 충전돼요!';

  @override
  String get onboardingDragPiece => '블록을 보드로 끌어다 놓으세요';

  @override
  String get onboardingFillLine => '가로나 세로 한 줄을 가득 채우세요';

  @override
  String get onboardingLinesClear => '가득 찬 줄은 사라지고 점수가 올라요!';

  @override
  String get coachHintCombo => '콤보! 3수 안에 또 지우면 이어져요';

  @override
  String get coachHintFever => '피버! 빛나는 동안 점수 2배';

  @override
  String get coachHintRotation => '회전하면 충전이 1개 줄어요 — 줄을 지우면 다시 차요';

  @override
  String get coachHintBooster => '팁: 아래에서 부스터를 쓸 수 있어요';

  @override
  String get coachHintStrategy => '팁: 모든 줄을 바로 지우지 말고 큰 블록 자리를 남겨 두세요';

  @override
  String get dailyStreakLabel => '연속 기록';

  @override
  String get dailyBestLabel => '일일 최고';

  @override
  String dailyHistoryNote(int days) {
    return '최근 $days일이 저장돼요.';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day일: 플레이함';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day일: 안 함';
  }

  @override
  String get homeDailyCalendar => '달력';

  @override
  String get dailyShareButton => '결과 공유';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble 일일 챌린지 $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return '$score점 · 최고 콤보 x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return '플레이: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    return '콤보: $moves수 남음';
  }

  @override
  String get dailyShareCopied => '결과를 클립보드에 복사했어요';

  @override
  String get adNotAvailable => '지금은 볼 수 있는 동영상이 없어요 — 잠시 후 다시 시도하세요';

  @override
  String get howToPlaySpeedTitle => '스피드 보너스';

  @override
  String get howToPlaySpeedBody =>
      '빠르게 놓으면 지운 줄마다 점수가 최대 30% 늘어나요. 보너스는 1.5~4초 사이에 줄어들고 상한이 있어서, 빠른 게 유리하지만 승부를 가르지는 않아요. 차분하고 신중한 플레이가 서두른 플레이를 이길 수도 있어요.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return '스피드 보너스 $percent퍼센트';
  }

  @override
  String get iapDiamondsSmall => '다이아몬드 100개';

  @override
  String get iapDiamondsMedium => '다이아몬드 350개';

  @override
  String get iapDiamondsLarge => '다이아몬드 1,000개';

  @override
  String get howToPlayTitle => 'Qubble 플레이 방법';

  @override
  String get howToPlayIntroHeadline => '시작은 쉽게.\n앞을 내다볼수록 유리하게.';

  @override
  String get howToPlayIntroBody => '보드를 깔끔하게 유지하고 최고 점수를 경신하세요.';

  @override
  String get howToPlayIntroSemantics => '게임 목표. 보드를 깔끔하게 유지하고 최고 점수를 경신하세요.';

  @override
  String get howToPlayDragTitle => '끌어서 놓기';

  @override
  String get howToPlayDragBody =>
      '세 블록 중 하나를 빈칸으로 끌어다 놓으세요. 세 개를 모두 쓰면 새 블록 세 개가 자동으로 나와요.';

  @override
  String get howToPlayClearTitle => '줄 지우기';

  @override
  String get howToPlayClearBody =>
      '가로나 세로 한 줄을 모두 채우세요. 가득 찬 줄은 사라지고 다음 수를 위한 공간이 생겨요.';

  @override
  String get howToPlayComboTitle => '콤보 잇기';

  @override
  String get howToPlayComboBody =>
      '3수 안에 한 줄을 더 지우면 콤보예요. 콤보가 이어질수록 점수 배율이 올라가요. 콤보는 초가 아니라 수로 세기 때문에 생각하는 동안 끊기지 않아요.';

  @override
  String get howToPlayFeverTitle => '피버 발동';

  @override
  String get howToPlayFeverBody =>
      '줄을 지우면 피버 게이지가 차요. 가득 차면 다음 큰 폭발이 2배로 계산돼요 — 큰 한 방을 미리 계획하세요.';

  @override
  String get howToPlayBoosterTitle => '부스터를 똑똑하게';

  @override
  String get howToPlayBoosterBody =>
      '부스터는 위기의 판을 구해 줘요. 트레이의 블록을 탭하면 회전도 할 수 있어요.';

  @override
  String get howToPlayDailyTitle => '일일 챌린지와 연속 기록';

  @override
  String get howToPlayDailyBody =>
      '일일 챌린지는 모두가 같은 블록으로 플레이해요. 매일 플레이해서 연속 기록과 보너스를 늘려 보세요.';

  @override
  String get howToPlayPiggyTitle => '돼지 저금통 채우기';

  @override
  String get howToPlayPiggyBody =>
      '줄을 지울 때마다 돼지 저금통이 채워져요. 가득 차면 코인을 무료로 받을 수 있어요.';

  @override
  String get leaderboardTitle => '순위표';

  @override
  String get leaderboardUnreachable => '순위표를 불러올 수 없어요.\n인터넷에 연결한 뒤 다시 시도하세요.';

  @override
  String get leaderboardEmpty => '아직 아무도 없어요.\n첫 번째가 되어 보세요!';

  @override
  String leaderboardSubmitting(int score) {
    return '최고 점수($score)를 제출하는 중…';
  }

  @override
  String get leaderboardAutoSubmit => '최고 점수는 자동으로 제출돼요.';

  @override
  String get puzzleModeTitle => '퍼즐 모드';

  @override
  String puzzleLevelTitle(int level) {
    return '퍼즐 $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return '이동: $moves   •   목표: $target수로 별 3개';
  }

  @override
  String get puzzleSolved => '성공!';

  @override
  String get puzzleLeaveTitle => '퍼즐을 그만할까요?';

  @override
  String get puzzleLeaveBody => '이 퍼즐의 진행 상황이 사라져요.';

  @override
  String get puzzleKeepPlaying => '계속하기';

  @override
  String get puzzleLeave => '나가기';

  @override
  String get puzzleStuckTitle => '막혔어요';

  @override
  String get puzzleRestart => '다시 시작';

  @override
  String get commonActive => '사용 중';

  @override
  String get commonTapToActivate => '탭해서 사용';

  @override
  String get commonRestore => '복원';

  @override
  String unlockForCost(int cost) {
    return '$cost에 잠금 해제';
  }

  @override
  String get skinsExchangeGold => '골드 교환';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => '블록 회전';

  @override
  String get puzzleNextLevel => '다음 레벨';

  @override
  String get puzzleBackToOverview => '목록으로';

  @override
  String get puzzleUnsolvable => '여기서는 더 이상 보드를 비울 수 없어요.';

  @override
  String get puzzleExtraMoveVideo => '추가 1수 (동영상)';

  @override
  String puzzleSolvedCount(int solved) {
    return '$solved개 해결';
  }

  @override
  String get settingsTitle => '설정';

  @override
  String get storageFailureTitle => 'Qubble이 저장된 게임을 불러올 수 없어요';

  @override
  String get storageFailureBody =>
      '앱을 다시 시작하세요. 오류가 계속되면 재설치만이 방법이에요. 설정 › 의견 보내기에서 신고할 수 있어요.';

  @override
  String get iapUnavailable => '지금은 이 상품을 이용할 수 없어요.';

  @override
  String get iapFailed => '구매가 완료되지 않았어요. 요금은 청구되지 않았어요.';

  @override
  String get settingsResetProgress => '진행 상황 초기화';

  @override
  String get settingsResetProgressSubtitle =>
      '점수, 코인, 레벨, 진행 상황이 처음으로 돌아가요. 구매 항목, 이름, 꾸미기 아이템은 유지돼요.';

  @override
  String get settingsResetConfirmTitle => '진행 상황을 초기화할까요?';

  @override
  String get settingsResetConfirmBody =>
      '최고 점수, 코인, 레벨, 연속 기록과 모든 진행 상황이 삭제돼요. 되돌릴 수 없어요.\n\n구매 항목, 이름, 잠금 해제한 테마와 스킨은 유지돼요.';

  @override
  String get settingsResetConfirmAction => '초기화';

  @override
  String get settingsResetDone => '진행 상황을 초기화했어요.';

  @override
  String get settingsSectionGame => '게임';

  @override
  String get settingsSectionSoundHaptics => '소리 및 진동';

  @override
  String get settingsSectionReminders => '알림';

  @override
  String get settingsSectionPurchases => '구매';

  @override
  String get settingsSectionHelpOut => '응원하기';

  @override
  String get settingsSectionLegal => '법적 고지';

  @override
  String get settingsSectionLanguage => '언어';

  @override
  String get settingsGuide => '플레이 방법';

  @override
  String get settingsGuideSubtitle => '규칙, 콤보, 피버, 부스터';

  @override
  String get settingsSound => '효과음';

  @override
  String get settingsMusic => '음악';

  @override
  String get settingsHaptics => '진동';

  @override
  String get settingsHapticsOff => '끔';

  @override
  String get settingsHapticsLight => '약하게';

  @override
  String get settingsHapticsStrong => '강하게';

  @override
  String get settingsSectionAccessibility => '편의';

  @override
  String get settingsReducedEffects => '효과 줄이기';

  @override
  String get settingsReducedEffectsHint => '파티클 감소, 화면 흔들림과 빛 효과 없음';

  @override
  String get settingsNotifications => '알림 받기';

  @override
  String get settingsNotificationsSubtitle => '일일 알림 및 연속 기록 보호';

  @override
  String get settingsNotificationsSystemHint => '기기 설정에서 허용해 주세요.';

  @override
  String get settingsLanguageSystem => '기기 언어';

  @override
  String get settingsSupporterThanks => '서포터 — 고마워요!';

  @override
  String get settingsSupporterPack => '서포터 팩';

  @override
  String get settingsSupporterPackSubtitle => '전용 테마와 스킨 + 1,500코인';

  @override
  String get settingsRestorePurchases => '구매 복원';

  @override
  String get settingsRestoring => '구매 항목을 복원하는 중…';

  @override
  String get settingsRateApp => '앱 평가하기';

  @override
  String get settingsRateAppSubtitle => '스토어에 평가 남기기';

  @override
  String get settingsStoreUnavailable => '이 기기에서는 스토어를 이용할 수 없어요.';

  @override
  String get settingsFeedback => '의견 보내기';

  @override
  String get settingsFeedbackSubtitle => '아이디어와 버그 제보 (GitHub 이용)';

  @override
  String get settingsAdPrivacy => '광고 개인정보 설정';

  @override
  String get settingsAdPrivacySubtitle => '광고 동의 확인 또는 변경';

  @override
  String get settingsAdPrivacyUnavailable => '이 기기에서는 광고 옵션이 필요하지 않아요.';

  @override
  String get settingsPrivacy => '개인정보처리방침';

  @override
  String get settingsImprint => '사업자 정보';

  @override
  String get settingsPageOpenFailed => '페이지를 열 수 없어요.';

  @override
  String get settingsFooter => 'Qubble • 오프라인 블록 퍼즐';

  @override
  String get settingsAdminSection => '관리자 (테스트)';

  @override
  String get settingsAdminEnabled => '관리자 모드가 켜졌어요';

  @override
  String settingsAdminTapsLeft(int count) {
    return '$count번 더 탭하면 관리자 모드';
  }

  @override
  String settingsAdminCoins(int coins) {
    return '$coins코인';
  }

  @override
  String get settingsAdminCoinsSubtitle => '테스트 전용 — 출시용 스크린샷에는 절대 사용 금지';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount코인';
  }

  @override
  String get settingsAdminResetCoins => '코인을 0으로';

  @override
  String get feedbackTitle => '의견 보내기';

  @override
  String get feedbackIntroShort =>
      '좋았던 점, 불편한 점, 아쉬운 점이 있나요? 작은 것도 도움이 돼요. 구체적일수록 좋아요.';

  @override
  String feedbackAttachmentNote(String build) {
    return '$build 정보와 기기 종류만 첨부돼요. 어떤 버전 이야기인지 알기 위해서예요.';
  }

  @override
  String get feedbackSendByMail => '이메일로 보내기';

  @override
  String get feedbackPreferGithub => 'GitHub 이슈로 보내기';

  @override
  String get feedbackThanksMail => '고마워요! 메시지만 보내면 돼요.';

  @override
  String get feedbackNoMailApp => '메일 앱을 찾을 수 없어요. 아래 GitHub 방법을 이용해 보세요.';

  @override
  String get feedbackEmptyHint => '먼저 내용을 입력해 주세요.';

  @override
  String get leaderboardRefresh => '새로고침';

  @override
  String get leaderboardRetry => '다시 시도';

  @override
  String get feedbackHint => '의견…';

  @override
  String get feedbackSubmit => '의견 보내기';

  @override
  String get feedbackOpenFailed => 'GitHub를 열 수 없어요. 나중에 다시 시도하세요.';

  @override
  String get feedbackGithubNote =>
      'GitHub가 열리면 \"Submit new issue\"를 탭하세요. (GitHub 로그인이 한 번 필요해요.)';

  @override
  String get shopTitle => '상점';

  @override
  String get shopWebDemoNote =>
      '구매는 Play 스토어 앱에서만 할 수 있어요. 이 웹 버전은 무료 데모지만, 여기서도 모든 걸 플레이할 수 있어요.';

  @override
  String get shopSupporterExplainer =>
      'Qubble에는 강제 광고가 없어요 — 아무것도 살 필요가 없어요. 서포터 팩(오로라 테마, 크리스털 스킨, 1,500코인, 서포터 배지)은 게임을 응원해 준 데 대한 감사 선물이에요. 구매 항목은 스토어 계정에 연결되며 언제든 복원할 수 있어요.';

  @override
  String get shopSupporterContents => '오로라 테마 + 크리스털 스킨 + 1,500코인';

  @override
  String get themesTitle => '테마';

  @override
  String get themesSupporterOnly => '서포터 팩 전용 (상점 참고)';

  @override
  String get themesInSupporterPack => '서포터 팩에 포함';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return '코인이 부족해요 (필요: $cost, 보유: $coins)';
  }

  @override
  String get skinsTitle => '블록 스킨';

  @override
  String get skinsNotEnoughDiamonds => '다이아몬드가 부족해요 (아래에서 골드 교환)';

  @override
  String get skinsNotEnoughCoins => '코인이 부족해요';

  @override
  String get skinsNotEnoughGold => '골드가 부족해요.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold골드 = 다이아몬드 1개. 다이아몬드로 가장 멋진 스킨을 열 수 있어요 — 천천히 모아 보세요.';
  }

  @override
  String get statsTitle => '통계';

  @override
  String get statsAverageScore => '평균 점수';

  @override
  String get statsBestCombo => '최고 콤보';

  @override
  String get statsGames => '게임 수';

  @override
  String get statsLinesCleared => '지운 줄';

  @override
  String get statsPiecesPlaced => '놓은 블록';

  @override
  String get statsCoins => '코인';

  @override
  String get missionsTitle => '미션';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '블록 $countString개 놓기';
  }

  @override
  String missionClearRows(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '줄 $countString개 지우기';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString콤보 달성';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '한 게임에서 $countString점 돌파';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString판 플레이';
  }

  @override
  String get achievementsTitle => '업적';

  @override
  String get achievementFirstGameTitle => '첫 게임';

  @override
  String get achievementFirstGameBody => '첫 게임 플레이';

  @override
  String get achievementGames25Title => '단골';

  @override
  String get achievementGames25Body => '25판 플레이';

  @override
  String get achievementGames100Title => '중독';

  @override
  String get achievementGames100Body => '100판 플레이';

  @override
  String get achievementScore1kTitle => '클라이머';

  @override
  String get achievementScore1kBody => '1,000점 달성';

  @override
  String get achievementScore5kTitle => '프로';

  @override
  String get achievementScore5kBody => '5,000점 달성';

  @override
  String get achievementScore10kTitle => '마스터';

  @override
  String get achievementScore10kBody => '10,000점 달성';

  @override
  String get achievementScore25kTitle => '레전드';

  @override
  String get achievementScore25kBody => '25,000점 달성';

  @override
  String get achievementLines100Title => '깔끔쟁이';

  @override
  String get achievementLines100Body => '총 100줄 지우기';

  @override
  String get achievementLines1000Title => '대청소';

  @override
  String get achievementLines1000Body => '총 1,000줄 지우기';

  @override
  String get achievementCombo5Title => '콤보 입문';

  @override
  String get achievementCombo5Body => '5콤보 달성';

  @override
  String get achievementCombo10Title => '콤보의 왕';

  @override
  String get achievementCombo10Body => '10콤보 달성';

  @override
  String get achievementLevel10Title => '숙련자';

  @override
  String get achievementLevel10Body => '레벨 10 달성';

  @override
  String get achievementLevel20Title => '베테랑';

  @override
  String get achievementLevel20Body => '레벨 20 달성';

  @override
  String get achievementStreak7Title => '일주일 연속';

  @override
  String get achievementStreak7Body => '일일 챌린지 7일 연속';

  @override
  String get achievementStreak30Title => '한 달 연속';

  @override
  String get achievementStreak30Body => '일일 챌린지 30일 연속';

  @override
  String get achievementPuzzles10Title => '퍼즐러';

  @override
  String get achievementPuzzles10Body => '퍼즐 10개 해결';

  @override
  String get achievementPieces5000Title => '건축가';

  @override
  String get achievementPieces5000Body => '블록 5,000개 놓기';

  @override
  String streakRepairTitle(int streak) {
    return '$streak일 연속 기록이 위험해요!';
  }

  @override
  String get streakRepairBody => '어제 플레이하지 않았어요 — 연속 기록을 지키세요:';

  @override
  String get streakRepairFailed => '복구할 수 없어요.';

  @override
  String comebackGift(int coins) {
    return '돌아온 걸 환영해요! +$coins코인';
  }

  @override
  String get notificationsOptInTitle => '알림을 받을까요?';

  @override
  String get notificationsOptInBody =>
      '일일 퍼즐을 알려 드리고 연속 기록을 지켜 드릴까요? 설정에서 언제든 바꿀 수 있어요.';

  @override
  String get notificationsOptInAccept => '네, 좋아요';

  @override
  String get notificationChannelDescription => '일일 알림, 연속 기록 경고, 복귀 알림';

  @override
  String get notificationDailyTitle => '오늘의 퍼즐이 기다리고 있어요 🧩';

  @override
  String get notificationDailyBody => '오늘의 챌린지를 플레이하세요!';

  @override
  String notificationStreakTitle(int streak) {
    return '🔥 $streak일 연속 기록이 위험해요!';
  }

  @override
  String get notificationStreakBody => '오늘 플레이해서 기록을 이어 가세요.';

  @override
  String get notificationComebackTitle => '블록들이 기다리고 있어요 🧩';

  @override
  String get notificationComebackBody => '돌아와서 선물을 받아 가세요!';

  @override
  String get iapSupporterPack => '서포터 팩';

  @override
  String get iapCoinsSmall => '500코인';

  @override
  String get iapCoinsMedium => '2,000코인';

  @override
  String get iapCoinsLarge => '6,000코인';

  @override
  String get iapStarterPack => '스타터 팩';

  @override
  String get iapRename => '이름 변경';

  @override
  String get iapNeonTheme => '네온 테마';

  @override
  String get settingsLeaderboardDelete => '순위표 기록 삭제';

  @override
  String get settingsLeaderboardDeleteSubtitle => '공개 목록에서 이름과 점수를 지워요';

  @override
  String get settingsLeaderboardDeleteConfirmTitle => '기록을 삭제할까요?';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      '이름과 점수가 순위표에서 삭제돼요. 게임 진행 상황은 그대로예요. 언제든 순위표에 다시 참가할 수 있어요.';

  @override
  String get settingsLeaderboardDeleteDone => '순위표 기록을 삭제했어요.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      '기록을 삭제할 수 없어요. 연결을 확인하고 다시 시도하세요.';

  @override
  String get leaderboardReport => '이 이름 신고';

  @override
  String get leaderboardBlock => '차단';

  @override
  String leaderboardBlocked(String name) {
    return '$name님을 숨겼어요';
  }

  @override
  String get leaderboardUndo => '실행 취소';

  @override
  String leaderboardBlockedCount(int count) {
    return '$count개 항목을 숨겼어요';
  }

  @override
  String get leaderboardUnblockAll => '다시 표시';

  @override
  String get leaderboardReportUnavailable => '지금은 신고할 수 없어요.';

  @override
  String get leaderboardReportSent => '고마워요 — 신고를 보내는 중이에요.';

  @override
  String get leaderboardRules =>
      '이름은 공개돼요. 욕설, 혐오 표현, 실존 인물을 알아볼 수 있는 내용은 금지예요. 규칙을 어긴 이름은 삭제돼요.';

  @override
  String get leaderboardRulesAccept => '이해했어요';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$total개 중 $unlocked개 달성';
  }

  @override
  String get settingsSectionData => '저장된 데이터';

  @override
  String get gameRotatePiece => '블록 회전';

  @override
  String get themeClassic => '클래식';

  @override
  String get themeFade => '파스텔';

  @override
  String get themeNeon => '네온';

  @override
  String get themeOcean => '오션';

  @override
  String get themeWood => '우드';

  @override
  String get themeSunset => '선셋';

  @override
  String get themeForest => '포레스트';

  @override
  String get themeAurora => '오로라';

  @override
  String get skinClassic => '클래식';

  @override
  String get skinGradient => '그라데이션';

  @override
  String get skinOutline => '외곽선';

  @override
  String get skinGlossy => '광택';

  @override
  String get skinStripe => '줄무늬';

  @override
  String get skinBevel => '입체';

  @override
  String get skinGlow => '글로우';

  @override
  String get skinCrystal => '크리스털';

  @override
  String rewardThemeName(String name) {
    return '$name 테마';
  }

  @override
  String rewardSkinName(String name) {
    return '$name 스킨';
  }
}
