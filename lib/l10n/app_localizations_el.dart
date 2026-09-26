// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class L10nEl extends L10n {
  L10nEl([String locale = 'el']) : super(locale);

  @override
  String get appTitle => 'Qubble';

  @override
  String get commonPlay => 'Παίξε';

  @override
  String get commonLater => 'Αργότερα';

  @override
  String get commonNotNow => 'Όχι τώρα';

  @override
  String get commonCancel => 'Άκυρο';

  @override
  String get commonBuy => 'Αγορά';

  @override
  String get commonSave => 'Αποθήκευση';

  @override
  String get commonCollect => 'Συλλογή';

  @override
  String get nameNewName => 'Νέο όνομα';

  @override
  String get nameFieldLabel => 'Όνομα';

  @override
  String get piggyFullTitle => 'Ο κουμπαράς γέμισε!';

  @override
  String get piggyKeepSaving => 'Συνέχισε να μαζεύεις';

  @override
  String piggyProgress(int coins, int capacity) {
    return 'Μαζεύτηκαν $coins από $capacity.';
  }

  @override
  String get homeContinueRun => 'Συνέχεια';

  @override
  String get homeVideo => 'Βίντεο';

  @override
  String get commonGotIt => 'Εντάξει';

  @override
  String get commonHome => 'Αρχική';

  @override
  String get commonScore => 'ΠΟΝΤΟΙ';

  @override
  String get commonBest => 'ΡΕΚΟΡ';

  @override
  String commonLevelShort(int level) {
    return 'Επίπεδο $level';
  }

  @override
  String get homeNewRun => 'Νέο παιχνίδι';

  @override
  String get homeBackToExit => 'Πάτησε ξανά Πίσω για έξοδο';

  @override
  String get homeEnableLeaderboard => 'Μπες στην κατάταξη';

  @override
  String get homeBestScore => 'ΚΑΛΥΤΕΡΟ ΣΚΟΡ';

  @override
  String get homeDailyChallenge => 'Ημερήσια πρόκληση';

  @override
  String get homeDailyOpenToday => 'Ανοιχτή σήμερα';

  @override
  String homeDailyNextIn(String time) {
    return 'Επόμενη πρόκληση σε $time';
  }

  @override
  String homeDailyStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Σερί: $streak ημέρες',
      one: 'Σερί: $streak ημέρα',
    );
    return '$_temp0';
  }

  @override
  String get homeLeaderboard => 'Κατάταξη';

  @override
  String get homePuzzleMode => 'Γρίφοι';

  @override
  String get homeMissions => 'Αποστολές';

  @override
  String get homeThemes => 'Θέματα';

  @override
  String get homeSkins => 'Εμφανίσεις';

  @override
  String get homeHowToPlay => 'Πώς παίζεται το Qubble';

  @override
  String get homeWeekendBonus => 'Σαββατοκύριακο: διπλά νομίσματα!';

  @override
  String homeNextUnlock(int level, String name) {
    return 'Επίπεδο $level: $name';
  }

  @override
  String homeXpProgress(int xp, int goal) {
    return '$xp / $goal XP';
  }

  @override
  String get nameChangeTitle => 'Αλλαγή ονόματος';

  @override
  String get nameChangeExplainer =>
      'Το όνομά σου είναι η ταυτότητά σου στην κατάταξη, γι\' αυτό δεν αλλάζει. Μπορείς να αγοράσεις μία αλλαγή ονόματος.';

  @override
  String get nameChangeAfterPurchase =>
      'Μετά την αγορά, πάτησε ξανά το όνομά σου για να το αλλάξεις.';

  @override
  String get nameJoinedLeaderboard => 'Είσαι πλέον στην κατάταξη.';

  @override
  String get nameRenameUnavailable =>
      'Η αλλαγή ονόματος δεν είναι δυνατή αυτή τη στιγμή.';

  @override
  String nameProblemTooShort(int min) {
    String _temp0 = intl.Intl.pluralLogic(
      min,
      locale: localeName,
      other: 'Τουλάχιστον $min χαρακτήρες.',
      one: 'Τουλάχιστον $min χαρακτήρας.',
    );
    return '$_temp0';
  }

  @override
  String nameProblemTooLong(int max) {
    String _temp0 = intl.Intl.pluralLogic(
      max,
      locale: localeName,
      other: 'Το πολύ $max χαρακτήρες.',
      one: 'Το πολύ $max χαρακτήρας.',
    );
    return '$_temp0';
  }

  @override
  String get nameProblemInvalidCharacters =>
      'Μόνο λατινικά γράμματα (A–Z), αριθμοί, κενά, _ και -.';

  @override
  String get nameProblemOffensive => 'Διάλεξε άλλο όνομα.';

  @override
  String get piggyTitle => 'Κουμπαράς';

  @override
  String get piggyFillingHint => 'Ο κουμπαράς γεμίζει όσο καθαρίζεις γραμμές.';

  @override
  String piggyCollect(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins νομίσματα',
      one: '$coins νόμισμα',
    );
    return 'Πάρε $_temp0 — δωρεάν.';
  }

  @override
  String get piggyEarlyOpenHint =>
      'Όταν γεμίσει, τον αδειάζεις δωρεάν — ή τον ανοίγεις νωρίτερα με ένα βίντεο μπόνους.';

  @override
  String get piggyOpenNow => 'Άνοιξέ τον τώρα';

  @override
  String get gameNewPiecesVideo => 'Νέα κομμάτια (βίντεο)';

  @override
  String get gameTapBoardCell => 'Πάτησε ένα κελί στο ταμπλό';

  @override
  String get gameDailyChallengeLabel => 'ΗΜΕΡΗΣΙΑ ΠΡΟΚΛΗΣΗ';

  @override
  String get gameOver => 'Τέλος παιχνιδιού';

  @override
  String gameBombNeedsCoins(String missing) {
    return 'Για τη βόμβα λείπουν νομίσματα: $missing.';
  }

  @override
  String get gameBombNotHere => 'Η βόμβα δεν λειτουργεί εδώ αυτή τη στιγμή.';

  @override
  String gameNeedsCoins(String missing) {
    return 'Λείπουν νομίσματα: $missing.';
  }

  @override
  String get gameNotRightNow => 'Δεν γίνεται αυτή τη στιγμή.';

  @override
  String get gameRunSaved => 'Το παιχνίδι αποθηκεύτηκε — «Συνέχεια» στο μενού.';

  @override
  String get gameOverNoFit =>
      'Κανένα από τα κομμάτια σου δεν χωράει πια στο ταμπλό.';

  @override
  String get gameOverNoFitNoRotations =>
      'Κανένα κομμάτι δεν χωράει — και οι περιστροφές τελείωσαν.';

  @override
  String get gameStarterOfferUnavailable => 'Δεν είναι διαθέσιμο τώρα';

  @override
  String gameStarterOfferPrice(String price) {
    return '$price — πάρ\' το';
  }

  @override
  String gameComboMultiplier(int combo) {
    return 'ΣΥΝΔΥΑΣΜΟΣ x$combo';
  }

  @override
  String gameAchievementUnlocked(String title) {
    return 'Επίτευγμα: $title';
  }

  @override
  String get gameBestSubmitted => 'Νέο ρεκόρ — στάλθηκε';

  @override
  String get gameReviveFor => 'Συνέχισε να παίζεις · ';

  @override
  String gameRewardUnlocked(String name) {
    return 'Ξεκλειδώθηκε: $name';
  }

  @override
  String get gameStarterOfferTitle => 'Πακέτο εκκίνησης';

  @override
  String gameOverPoints(int score) {
    String _temp0 = intl.Intl.pluralLogic(
      score,
      locale: localeName,
      other: '$score πόντοι',
      one: '$score πόντος',
    );
    return '$_temp0';
  }

  @override
  String get gameNewRecord => 'Νέο ρεκόρ!';

  @override
  String gameStreakDays(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Σερί: $streak ημέρες',
      one: 'Σερί: $streak ημέρα',
    );
    return '$_temp0';
  }

  @override
  String get gameDoubleCoins => 'Διπλά νομίσματα';

  @override
  String get gameDoubleDaily => 'Διπλή ημερήσια ανταμοιβή';

  @override
  String get gamePlayAgain => 'Ξανά';

  @override
  String gameLevelReached(int level) {
    return 'Έφτασες στο επίπεδο $level!';
  }

  @override
  String gameLevelsGained(int count, int level) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '+$count επίπεδα — επίπεδο $level!',
      one: '+$count επίπεδο — επίπεδο $level!',
    );
    return '$_temp0';
  }

  @override
  String get gameStarterOfferReward => '1200 νομίσματα + θέμα Ξύλο';

  @override
  String gameStarterOfferTimeLeft(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: 'Μόνο $hours ώρες ακόμα — μία φορά!',
      one: 'Μόνο $hours ώρα ακόμα — μία φορά!',
    );
    return '$_temp0';
  }

  @override
  String get boosterUndo => 'Αναίρεση';

  @override
  String get boosterSwap => 'Αλλαγή';

  @override
  String get boosterBomb => 'Βόμβα';

  @override
  String get boosterNoRotationsLeft =>
      'Δεν έμειναν περιστροφές — καθάρισε γραμμές για να τις γεμίσεις!';

  @override
  String get onboardingDragPiece => 'Σύρε ένα κομμάτι στο πλέγμα';

  @override
  String get onboardingFillLine => 'Γέμισε μια ολόκληρη σειρά ή στήλη';

  @override
  String get onboardingLinesClear =>
      'Οι γεμάτες γραμμές εξαφανίζονται — πόντοι!';

  @override
  String get coachHintCombo =>
      'Συνδυασμός! Καθάρισε ξανά μέσα σε 3 κινήσεις για να τον κρατήσεις';

  @override
  String get coachHintFever => 'ΠΥΡΕΤΟΣ! Διπλοί πόντοι όσο λάμπει';

  @override
  String get coachHintRotation =>
      'Η περιστροφή κοστίζει ένα φορτίο — τα καθαρίσματα το αναπληρώνουν';

  @override
  String get coachHintBooster => 'Συμβουλή: κάτω έχεις βοηθήματα';

  @override
  String get coachHintStrategy =>
      'Συμβουλή: όχι όλες οι γραμμές μαζί — κράτα χώρο για τα μεγάλα κομμάτια';

  @override
  String get dailyStreakLabel => 'Σερί';

  @override
  String get dailyBestLabel => 'Ρεκόρ ημέρας';

  @override
  String dailyHistoryNote(int days) {
    return 'Κρατιούνται οι τελευταίες $days ημέρες.';
  }

  @override
  String dailyDayPlayed(int day) {
    return '$day: παίχτηκε';
  }

  @override
  String dailyDayMissed(int day) {
    return '$day: δεν παίχτηκε';
  }

  @override
  String get homeDailyCalendar => 'Ημερολόγιο';

  @override
  String get dailyShareButton => 'Κοινοποίηση αποτελέσματος';

  @override
  String dailyShareHeadline(String date) {
    return 'Qubble · Ημερήσια πρόκληση $date';
  }

  @override
  String dailyShareStats(String score, int combo) {
    return '$score πόντοι · καλύτερος συνδυασμός x$combo';
  }

  @override
  String dailySharePlay(String url) {
    return 'Παίξε: $url';
  }

  @override
  String gameComboMovesLeft(int moves) {
    String _temp0 = intl.Intl.pluralLogic(
      moves,
      locale: localeName,
      other: 'Συνδυασμός: απομένουν $moves κινήσεις',
      one: 'Συνδυασμός: απομένει $moves κίνηση',
    );
    return '$_temp0';
  }

  @override
  String get dailyShareCopied => 'Το αποτέλεσμα αντιγράφηκε στο πρόχειρο';

  @override
  String get adNotAvailable =>
      'Κανένα βίντεο διαθέσιμο αυτή τη στιγμή — δοκίμασε ξανά σε λίγο';

  @override
  String get howToPlaySpeedTitle => 'Μπόνους ταχύτητας';

  @override
  String get howToPlaySpeedBody =>
      'Οι γρήγορες τοποθετήσεις προσθέτουν έως 30 % σε ένα καθάρισμα. Το μπόνους μειώνεται από 1,5 έως 4 δευτερόλεπτα και έχει ανώτατο όριο, έτσι η ταχύτητα αξίζει χωρίς να κρίνει το παιχνίδι — ένα προσεκτικό, αργό παιχνίδι μπορεί ακόμα να κερδίσει ένα βιαστικό.';

  @override
  String gameSpeedBonus(int percent) {
    return '+$percent%';
  }

  @override
  String gameSpeedBonusSemantics(int percent) {
    return 'Μπόνους ταχύτητας $percent τοις εκατό';
  }

  @override
  String get iapDiamondsSmall => '100 διαμάντια';

  @override
  String get iapDiamondsMedium => '350 διαμάντια';

  @override
  String get iapDiamondsLarge => '1.000 διαμάντια';

  @override
  String get howToPlayTitle => 'Πώς παίζεται το Qubble';

  @override
  String get howToPlayIntroHeadline =>
      'Εύκολο στην αρχή.\nΑνταμείβει τον σχεδιασμό.';

  @override
  String get howToPlayIntroBody =>
      'Κράτα το ταμπλό ελεύθερο και σπάσε το ρεκόρ σου.';

  @override
  String get howToPlayIntroSemantics =>
      'Ο στόχος του παιχνιδιού. Κράτα το ταμπλό ελεύθερο και σπάσε το ρεκόρ σου.';

  @override
  String get howToPlayDragTitle => 'Σύρε και άφησε';

  @override
  String get howToPlayDragBody =>
      'Σύρε ένα από τα τρία κομμάτια σε ελεύθερα κελιά. Μόλις χρησιμοποιήσεις και τα τρία, παίρνεις αυτόματα τρία καινούργια.';

  @override
  String get howToPlayClearTitle => 'Καθάρισε γραμμές';

  @override
  String get howToPlayClearBody =>
      'Γέμισε μια ολόκληρη σειρά ή στήλη. Οι γεμάτες γραμμές εξαφανίζονται και κάνουν χώρο για την επόμενη κίνηση.';

  @override
  String get howToPlayComboTitle => 'Αλυσίδα συνδυασμών';

  @override
  String get howToPlayComboBody =>
      'Καθάρισε κι άλλη γραμμή μέσα σε τρεις κινήσεις. Κάθε επόμενος συνδυασμός ανεβάζει τον πολλαπλασιαστή πόντων. Ο συνδυασμός μετράει κινήσεις, όχι δευτερόλεπτα, οπότε δεν λήγει όσο σκέφτεσαι.';

  @override
  String get howToPlayFeverTitle => 'Άναψε τον πυρετό';

  @override
  String get howToPlayFeverBody =>
      'Τα καθαρίσματα γεμίζουν τον μετρητή πυρετού. Όταν γεμίσει, το επόμενο μεγάλο καθάρισμα μετράει διπλά — σχεδίασε από πριν τα μεγάλα καθαρίσματα.';

  @override
  String get howToPlayBoosterTitle => 'Βοηθήματα με σύνεση';

  @override
  String get howToPlayBoosterBody =>
      'Τα βοηθήματα σώζουν τα δύσκολα παιχνίδια. Μπορείς επίσης να πατήσεις ένα κομμάτι στη θήκη για να το περιστρέψεις.';

  @override
  String get howToPlayDailyTitle => 'Ημερήσια πρόκληση και σερί';

  @override
  String get howToPlayDailyBody =>
      'Η ημερήσια πρόκληση έχει τα ίδια κομμάτια για όλους. Παίζε κάθε μέρα για να μεγαλώνει το σερί και το μπόνους σου.';

  @override
  String get howToPlayPiggyTitle => 'Γέμισε τον κουμπαρά';

  @override
  String get howToPlayPiggyBody =>
      'Κάθε γραμμή που καθαρίζεις γεμίζει τον κουμπαρά σου. Όταν γεμίσει, παίρνεις τα νομίσματα δωρεάν.';

  @override
  String get leaderboardTitle => 'Κατάταξη';

  @override
  String get leaderboardUnreachable =>
      'Η κατάταξη δεν είναι διαθέσιμη.\nΔοκίμασε ξανά με σύνδεση στο διαδίκτυο.';

  @override
  String get leaderboardEmpty => 'Καμία εγγραφή ακόμα.\nΓίνε ο πρώτος!';

  @override
  String leaderboardSubmitting(int score) {
    return 'Το καλύτερο σκορ σου ($score) στέλνεται …';
  }

  @override
  String get leaderboardAutoSubmit =>
      'Το καλύτερο σκορ σου στέλνεται αυτόματα.';

  @override
  String get puzzleModeTitle => 'Γρίφοι';

  @override
  String puzzleLevelTitle(int level) {
    return 'Γρίφος $level';
  }

  @override
  String puzzleMoveCounter(int moves, int target) {
    return 'Κινήσεις: $moves   •   Στόχος: $target για 3 αστέρια';
  }

  @override
  String get puzzleSolved => 'Λύθηκε!';

  @override
  String get puzzleLeaveTitle => 'Έξοδος από τον γρίφο;';

  @override
  String get puzzleLeaveBody => 'Η πρόοδός σου σε αυτόν τον γρίφο θα χαθεί.';

  @override
  String get puzzleKeepPlaying => 'Συνέχισε';

  @override
  String get puzzleLeave => 'Έξοδος';

  @override
  String get puzzleStuckTitle => 'Αδιέξοδο';

  @override
  String get puzzleRestart => 'Από την αρχή';

  @override
  String get commonActive => 'Ενεργό';

  @override
  String get commonTapToActivate => 'Πάτησε για ενεργοποίηση';

  @override
  String get commonRestore => 'Επαναφορά';

  @override
  String unlockForCost(int cost) {
    return 'Ξεκλείδωμα με $cost';
  }

  @override
  String get skinsExchangeGold => 'Ανταλλαγή χρυσού';

  @override
  String statsAchievementsRatio(int unlocked, int total) {
    return '$unlocked / $total';
  }

  @override
  String get trayRotatePiece => 'Περιστροφή κομματιού';

  @override
  String get puzzleNextLevel => 'Επόμενο επίπεδο';

  @override
  String get puzzleBackToOverview => 'Πίσω στην επισκόπηση';

  @override
  String get puzzleUnsolvable =>
      'Από εδώ το ταμπλό δεν μπορεί πια να αδειάσει.';

  @override
  String get puzzleExtraMoveVideo => 'Επιπλέον κίνηση (βίντεο)';

  @override
  String puzzleSolvedCount(int solved) {
    return 'Λύθηκαν: $solved';
  }

  @override
  String get settingsTitle => 'Ρυθμίσεις';

  @override
  String get storageFailureTitle =>
      'Το Qubble δεν μπορεί να φορτώσει το αποθηκευμένο παιχνίδι';

  @override
  String get storageFailureBody =>
      'Κάνε επανεκκίνηση της εφαρμογής. Αν το σφάλμα επιμένει, βοηθά μόνο η επανεγκατάσταση. Μπορείς να το αναφέρεις από Ρυθμίσεις › Σχόλια.';

  @override
  String get iapUnavailable => 'Αυτή η προσφορά δεν είναι διαθέσιμη τώρα.';

  @override
  String get iapFailed => 'Η αγορά δεν ολοκληρώθηκε. Δεν έγινε καμία χρέωση.';

  @override
  String get settingsResetProgress => 'Επαναφορά προόδου';

  @override
  String get settingsResetProgressSubtitle =>
      'Σκορ, νομίσματα, επίπεδο και πρόοδος ξανά από την αρχή. Οι αγορές, το όνομα και τα διακοσμητικά μένουν.';

  @override
  String get settingsResetConfirmTitle => 'Επαναφορά προόδου;';

  @override
  String get settingsResetConfirmBody =>
      'Το καλύτερο σκορ, τα νομίσματα, το επίπεδο, το σερί και όλη η πρόοδος θα διαγραφούν. Δεν αναιρείται.\n\nΟι αγορές σου, το όνομά σου και τα ξεκλείδωτα θέματα και εμφανίσεις μένουν.';

  @override
  String get settingsResetConfirmAction => 'Επαναφορά';

  @override
  String get settingsResetDone => 'Η πρόοδος επανήλθε στην αρχή.';

  @override
  String get settingsSectionGame => 'Παιχνίδι';

  @override
  String get settingsSectionSoundHaptics => 'Ήχος και δόνηση';

  @override
  String get settingsSectionReminders => 'Υπενθυμίσεις';

  @override
  String get settingsSectionPurchases => 'Αγορές';

  @override
  String get settingsSectionHelpOut => 'Βοήθησε';

  @override
  String get settingsSectionLegal => 'Νομικά';

  @override
  String get settingsSectionLanguage => 'Γλώσσα';

  @override
  String get settingsGuide => 'Πώς παίζεται';

  @override
  String get settingsGuideSubtitle =>
      'Κανόνες, συνδυασμοί, πυρετός και βοηθήματα';

  @override
  String get settingsSound => 'Ήχος';

  @override
  String get settingsMusic => 'Μουσική';

  @override
  String get settingsHaptics => 'Δόνηση';

  @override
  String get settingsHapticsOff => 'Όχι';

  @override
  String get settingsHapticsLight => 'Ελαφριά';

  @override
  String get settingsHapticsStrong => 'Δυνατή';

  @override
  String get settingsSectionAccessibility => 'Άνεση';

  @override
  String get settingsReducedEffects => 'Λιγότερα εφέ';

  @override
  String get settingsReducedEffectsHint =>
      'Λιγότερα σωματίδια, χωρίς κούνημα οθόνης, χωρίς λάμψη';

  @override
  String get settingsNotifications => 'Ειδοποιήσεις';

  @override
  String get settingsNotificationsSubtitle =>
      'Ημερήσια υπενθύμιση και προστασία σερί';

  @override
  String get settingsNotificationsSystemHint =>
      'Επίτρεψέ τες στις ρυθμίσεις συστήματος.';

  @override
  String get settingsLanguageSystem => 'Γλώσσα συστήματος';

  @override
  String get settingsSupporterThanks => 'Υποστηρικτής — ευχαριστούμε!';

  @override
  String get settingsSupporterPack => 'Πακέτο υποστηρικτή';

  @override
  String get settingsSupporterPackSubtitle =>
      'Αποκλειστικό θέμα και εμφάνιση + 1.500 νομίσματα';

  @override
  String get settingsRestorePurchases => 'Επαναφορά αγορών';

  @override
  String get settingsRestoring => 'Επαναφορά αγορών…';

  @override
  String get settingsRateApp => 'Βαθμολόγησε την εφαρμογή';

  @override
  String get settingsRateAppSubtitle => 'Άφησε μια βαθμολογία στο κατάστημα';

  @override
  String get settingsStoreUnavailable =>
      'Το κατάστημα δεν είναι διαθέσιμο σε αυτή τη συσκευή.';

  @override
  String get settingsFeedback => 'Στείλε σχόλια';

  @override
  String get settingsFeedbackSubtitle => 'Ιδέες και σφάλματα (μέσω GitHub)';

  @override
  String get settingsAdPrivacy => 'Απόρρητο διαφημίσεων';

  @override
  String get settingsAdPrivacySubtitle =>
      'Δες ή άλλαξε τη συγκατάθεσή σου για διαφημίσεις';

  @override
  String get settingsAdPrivacyUnavailable =>
      'Σε αυτή τη συσκευή δεν χρειάζονται επιλογές διαφημίσεων.';

  @override
  String get settingsPrivacy => 'Πολιτική απορρήτου';

  @override
  String get settingsImprint => 'Στοιχεία εκδότη';

  @override
  String get settingsPageOpenFailed => 'Η σελίδα δεν άνοιξε.';

  @override
  String get settingsFooter => 'Qubble • Παζλ με τουβλάκια εκτός σύνδεσης';

  @override
  String get settingsAdminSection => 'Admin (δοκιμή)';

  @override
  String get settingsAdminEnabled => 'Η λειτουργία admin ενεργοποιήθηκε';

  @override
  String settingsAdminTapsLeft(int count) {
    return 'Πάτησε άλλες $count φορές για λειτουργία admin';
  }

  @override
  String settingsAdminCoins(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins νομίσματα',
      one: '$coins νόμισμα',
    );
    return '$_temp0';
  }

  @override
  String get settingsAdminCoinsSubtitle =>
      'Μόνο για δοκιμές — ποτέ σε στιγμιότυπα έκδοσης';

  @override
  String settingsAdminAddCoins(int amount) {
    return '+$amount νομίσματα';
  }

  @override
  String get settingsAdminResetCoins => 'Νομίσματα στο 0';

  @override
  String get feedbackTitle => 'Σχόλια';

  @override
  String get feedbackIntroShort =>
      'Τι σου αρέσει, τι σε ενοχλεί, τι λείπει; Και τα μικρά βοηθούν — όσο πιο συγκεκριμένα, τόσο καλύτερα.';

  @override
  String feedbackAttachmentNote(String build) {
    return 'Επισυνάπτονται μόνο $build και ο τύπος της συσκευής σου — για να ξέρω ποια έκδοση εννοείς.';
  }

  @override
  String get feedbackSendByMail => 'Αποστολή με email';

  @override
  String get feedbackPreferGithub => 'Προτιμώ issue στο GitHub';

  @override
  String get feedbackThanksMail => 'Ευχαριστώ! Απλώς στείλε το μήνυμα.';

  @override
  String get feedbackNoMailApp =>
      'Δεν βρέθηκε εφαρμογή email. Δοκίμασε τη διαδρομή μέσω GitHub παρακάτω.';

  @override
  String get feedbackEmptyHint => 'Γράψε κάτι πρώτα.';

  @override
  String get leaderboardRefresh => 'Ανανέωση';

  @override
  String get leaderboardRetry => 'Δοκίμασε ξανά';

  @override
  String get feedbackHint => 'Τα σχόλιά σου…';

  @override
  String get feedbackSubmit => 'Στείλε σχόλια';

  @override
  String get feedbackOpenFailed =>
      'Το GitHub δεν άνοιξε. Δοκίμασε ξανά αργότερα.';

  @override
  String get feedbackGithubNote =>
      'Ανοίγει το GitHub — πάτησε εκεί «Submit new issue». (Χρειάζεται μία σύνδεση στο GitHub.)';

  @override
  String get shopTitle => 'Κατάστημα';

  @override
  String get shopWebDemoNote =>
      'Οι αγορές υπάρχουν μόνο στην εφαρμογή από το Play Store. Αυτή η έκδοση web είναι δωρεάν demo — μπορείς όμως να την παίξεις ολόκληρη εδώ.';

  @override
  String get shopSupporterExplainer =>
      'Το Qubble δεν δείχνει αναγκαστικές διαφημίσεις — δεν χρειάζεται ποτέ να αγοράσεις κάτι. Το πακέτο υποστηρικτή (θέμα Σέλας, εμφάνιση Κρύσταλλο, 1.500 νομίσματα, σήμα υποστηρικτή) είναι ένα ευχαριστώ για την υποστήριξη του παιχνιδιού. Οι αγορές συνδέονται με τον λογαριασμό σου στο κατάστημα και επαναφέρονται οποιαδήποτε στιγμή.';

  @override
  String get shopSupporterContents =>
      'Θέμα Σέλας + εμφάνιση Κρύσταλλο + 1.500 νομίσματα';

  @override
  String get themesTitle => 'Θέματα';

  @override
  String get themesSupporterOnly =>
      'Μόνο στο πακέτο υποστηρικτή (δες το κατάστημα)';

  @override
  String get themesInSupporterPack => 'Στο πακέτο υποστηρικτή';

  @override
  String themesNotEnoughCoins(int cost, int coins) {
    return 'Δεν φτάνουν τα νομίσματα (χρειάζονται $cost, έχεις $coins)';
  }

  @override
  String get skinsTitle => 'Εμφανίσεις τουβλακιών';

  @override
  String get skinsNotEnoughDiamonds =>
      'Δεν φτάνουν τα διαμάντια (αντάλλαξε χρυσό παρακάτω)';

  @override
  String get skinsNotEnoughCoins => 'Δεν φτάνουν τα νομίσματα';

  @override
  String get skinsNotEnoughGold => 'Δεν φτάνει ο χρυσός.';

  @override
  String skinsExchangeHint(int gold) {
    return '$gold χρυσός = 1 διαμάντι. Τα διαμάντια ξεκλειδώνουν τις ωραιότερες εμφανίσεις — μάζευε με την ησυχία σου.';
  }

  @override
  String get statsTitle => 'Στατιστικά';

  @override
  String get statsAverageScore => 'Μέσο σκορ';

  @override
  String get statsBestCombo => 'Καλύτερος συνδυασμός';

  @override
  String get statsGames => 'Παιχνίδια';

  @override
  String get statsLinesCleared => 'Καθαρές σειρές';

  @override
  String get statsPiecesPlaced => 'Κομμάτια';

  @override
  String get statsCoins => 'Νομίσματα';

  @override
  String get missionsTitle => 'Αποστολές';

  @override
  String missionPlacePieces(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Τοποθέτησε $countString κομμάτια';
  }

  @override
  String missionClearRows(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Καθάρισε $countString σειρές';
  }

  @override
  String missionReachCombo(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Φτάσε συνδυασμό x$countString';
  }

  @override
  String missionBreakScore(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Ξεπέρασε τους $countString πόντους σε ένα παιχνίδι';
  }

  @override
  String missionPlayRuns(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Παίξε $countString παιχνίδια';
  }

  @override
  String get achievementsTitle => 'Επιτεύγματα';

  @override
  String get achievementFirstGameTitle => 'Πρώτο παιχνίδι';

  @override
  String get achievementFirstGameBody => 'Παίξε το πρώτο σου παιχνίδι';

  @override
  String get achievementGames25Title => 'Θαμώνας';

  @override
  String get achievementGames25Body => 'Παίξε 25 παιχνίδια';

  @override
  String get achievementGames100Title => 'Κολλημένος';

  @override
  String get achievementGames100Body => 'Παίξε 100 παιχνίδια';

  @override
  String get achievementScore1kTitle => 'Ανερχόμενος';

  @override
  String get achievementScore1kBody => 'Φτάσε τους 1.000 πόντους';

  @override
  String get achievementScore5kTitle => 'Επαγγελματίας';

  @override
  String get achievementScore5kBody => 'Φτάσε τους 5.000 πόντους';

  @override
  String get achievementScore10kTitle => 'Μάστορας';

  @override
  String get achievementScore10kBody => 'Φτάσε τους 10.000 πόντους';

  @override
  String get achievementScore25kTitle => 'Θρύλος';

  @override
  String get achievementScore25kBody => 'Φτάσε τους 25.000 πόντους';

  @override
  String get achievementLines100Title => 'Νοικοκύρης';

  @override
  String get achievementLines100Body => 'Καθάρισε 100 σειρές συνολικά';

  @override
  String get achievementLines1000Title => 'Γενική καθαριότητα';

  @override
  String get achievementLines1000Body => 'Καθάρισε 1.000 σειρές συνολικά';

  @override
  String get achievementCombo5Title => 'Πρώτοι συνδυασμοί';

  @override
  String get achievementCombo5Body => 'Φτάσε συνδυασμό x5';

  @override
  String get achievementCombo10Title => 'Βασιλιάς συνδυασμών';

  @override
  String get achievementCombo10Body => 'Φτάσε συνδυασμό x10';

  @override
  String get achievementLevel10Title => 'Έμπειρος';

  @override
  String get achievementLevel10Body => 'Φτάσε στο επίπεδο 10';

  @override
  String get achievementLevel20Title => 'Βετεράνος';

  @override
  String get achievementLevel20Body => 'Φτάσε στο επίπεδο 20';

  @override
  String get achievementStreak7Title => 'Σερί εβδομάδας';

  @override
  String get achievementStreak7Body => 'Ημερήσιο σερί 7 ημερών';

  @override
  String get achievementStreak30Title => 'Σερί μήνα';

  @override
  String get achievementStreak30Body => 'Ημερήσιο σερί 30 ημερών';

  @override
  String get achievementPuzzles10Title => 'Λύτης';

  @override
  String get achievementPuzzles10Body => 'Λύσε 10 γρίφους';

  @override
  String get achievementPieces5000Title => 'Χτίστης';

  @override
  String get achievementPieces5000Body => 'Τοποθέτησε 5.000 κομμάτια';

  @override
  String streakRepairTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Το σερί $streak ημερών κινδυνεύει!',
      one: 'Το σερί $streak ημέρας κινδυνεύει!',
    );
    return '$_temp0';
  }

  @override
  String get streakRepairBody => 'Χθες δεν έπαιξες — σώσε το σερί σου:';

  @override
  String get streakRepairFailed => 'Η επιδιόρθωση δεν είναι δυνατή.';

  @override
  String comebackGift(int coins) {
    String _temp0 = intl.Intl.pluralLogic(
      coins,
      locale: localeName,
      other: '$coins νομίσματα',
      one: '$coins νόμισμα',
    );
    return 'Καλώς ήρθες πίσω! +$_temp0';
  }

  @override
  String get notificationsOptInTitle => 'Υπενθυμίσεις;';

  @override
  String get notificationsOptInBody =>
      'Να σου θυμίζουμε τον ημερήσιο γρίφο σου και να προστατεύουμε το σερί σου; Μπορείς να το αλλάξεις όποτε θέλεις στις ρυθμίσεις.';

  @override
  String get notificationsOptInAccept => 'Ναι, παρακαλώ';

  @override
  String get notificationChannelDescription =>
      'Ημερήσια υπενθύμιση, προειδοποίηση σερί, επιστροφή';

  @override
  String get notificationDailyTitle => 'Ο ημερήσιος γρίφος σου περιμένει 🧩';

  @override
  String get notificationDailyBody => 'Παίξε τη σημερινή πρόκληση!';

  @override
  String notificationStreakTitle(int streak) {
    String _temp0 = intl.Intl.pluralLogic(
      streak,
      locale: localeName,
      other: 'Το σερί $streak ημερών κινδυνεύει!',
      one: 'Το σερί $streak ημέρας κινδυνεύει!',
    );
    return '🔥 $_temp0';
  }

  @override
  String get notificationStreakBody => 'Παίξε σήμερα για να το κρατήσεις.';

  @override
  String get notificationComebackTitle => 'Ο γρίφος σου σε αναζητά 🧩';

  @override
  String get notificationComebackBody => 'Γύρνα και πάρε ένα δώρο!';

  @override
  String get iapSupporterPack => 'Πακέτο υποστηρικτή';

  @override
  String get iapCoinsSmall => '500 νομίσματα';

  @override
  String get iapCoinsMedium => '2.000 νομίσματα';

  @override
  String get iapCoinsLarge => '6.000 νομίσματα';

  @override
  String get iapStarterPack => 'Πακέτο εκκίνησης';

  @override
  String get iapRename => 'Αλλαγή ονόματος';

  @override
  String get iapNeonTheme => 'Θέμα Νέον';

  @override
  String get settingsLeaderboardDelete => 'Διαγραφή εγγραφής κατάταξης';

  @override
  String get settingsLeaderboardDeleteSubtitle =>
      'Αφαιρεί το όνομα και το σκορ σου από τη δημόσια λίστα';

  @override
  String get settingsLeaderboardDeleteConfirmTitle =>
      'Διαγραφή της εγγραφής σου;';

  @override
  String get settingsLeaderboardDeleteConfirmBody =>
      'Το όνομα και το σκορ σου θα αφαιρεθούν από την κατάταξη. Η πρόοδός σου στο παιχνίδι μένει ανέπαφη. Μπορείς να μπεις ξανά στην κατάταξη οποιαδήποτε στιγμή.';

  @override
  String get settingsLeaderboardDeleteDone =>
      'Η εγγραφή σου στην κατάταξη διαγράφηκε.';

  @override
  String get settingsLeaderboardDeleteFailed =>
      'Η εγγραφή δεν διαγράφηκε. Έλεγξε τη σύνδεσή σου και δοκίμασε ξανά.';

  @override
  String get leaderboardReport => 'Αναφορά αυτού του ονόματος';

  @override
  String get leaderboardBlock => 'Απόκρυψη';

  @override
  String leaderboardBlocked(String name) {
    return 'Το όνομα $name είναι κρυμμένο για σένα';
  }

  @override
  String get leaderboardUndo => 'Αναίρεση';

  @override
  String leaderboardBlockedCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count εγγραφές κρυμμένες από σένα',
      one: '$count εγγραφή κρυμμένη από σένα',
    );
    return '$_temp0';
  }

  @override
  String get leaderboardUnblockAll => 'Εμφάνιση ξανά';

  @override
  String get leaderboardReportUnavailable =>
      'Η αναφορά δεν είναι διαθέσιμη αυτή τη στιγμή.';

  @override
  String get leaderboardReportSent => 'Ευχαριστούμε — η αναφορά σου στάλθηκε.';

  @override
  String get leaderboardRules =>
      'Τα ονόματα είναι δημόσια. Χωρίς προσβολές, χωρίς βρισιές και τίποτα που να αναγνωρίζει πραγματικό πρόσωπο. Όσα ονόματα παραβιάζουν τους κανόνες αφαιρούνται.';

  @override
  String get leaderboardRulesAccept => 'Κατάλαβα';

  @override
  String achievementsUnlockedCount(int unlocked, int total) {
    return '$unlocked από $total ξεκλειδωμένα';
  }

  @override
  String get settingsSectionData => 'Αποθηκευμένα δεδομένα';

  @override
  String get gameRotatePiece => 'Περιστροφή κομματιού';

  @override
  String get themeClassic => 'Κλασικό';

  @override
  String get themeFade => 'Παστέλ';

  @override
  String get themeNeon => 'Νέον';

  @override
  String get themeOcean => 'Ωκεανός';

  @override
  String get themeWood => 'Ξύλο';

  @override
  String get themeSunset => 'Ηλιοβασίλεμα';

  @override
  String get themeForest => 'Δάσος';

  @override
  String get themeAurora => 'Σέλας';

  @override
  String get skinClassic => 'Κλασική';

  @override
  String get skinGradient => 'Διαβάθμιση';

  @override
  String get skinOutline => 'Περίγραμμα';

  @override
  String get skinGlossy => 'Γυαλιστερή';

  @override
  String get skinStripe => 'Ρίγες';

  @override
  String get skinBevel => 'Ανάγλυφη';

  @override
  String get skinGlow => 'Λάμψη';

  @override
  String get skinCrystal => 'Κρύσταλλο';

  @override
  String rewardThemeName(String name) {
    return 'Θέμα $name';
  }

  @override
  String rewardSkinName(String name) {
    return 'Εμφάνιση $name';
  }
}
