import 'package:gridpop/services/stats_consent.dart';

/// Records what the app told the SDKs about statistics, instead of telling
/// them.
class RecordingCollection implements StatsCollection {
  final calls = <({bool enabled, bool answerChanged})>[];

  @override
  Future<void> setEnabled(bool enabled, {bool answerChanged = false}) async {
    calls.add((enabled: enabled, answerChanged: answerChanged));
  }
}
