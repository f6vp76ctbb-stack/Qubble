/// Keeps the background music out of the way of a rewarded video, and brings
/// it back afterwards.
///
/// The owner found the music stopped after watching an ad (12.10.2026). The
/// video takes the audio session; on Android the app went to the background
/// and the lifecycle resumed the loop, but on iOS a presented ad never
/// backgrounds the app, so nothing restarted it — and while it played, the
/// loop could run under the ad's own sound. This wrapper pauses the loop for
/// the video and recovers it once the video is closed, however it ended.
library;

import '../services/audio.dart';
import 'ads.dart';

class MusicAwareAds implements AdService {
  MusicAwareAds(this._inner, this._music);

  final AdService _inner;
  final MusicService _music;

  @override
  Future<void> initialize() => _inner.initialize();

  @override
  void prepare(AdPlacement placement) => _inner.prepare(placement);

  @override
  bool rewardedReadyFor(AdPlacement placement) =>
      _inner.rewardedReadyFor(placement);

  @override
  Future<bool> showRewarded(AdPlacement placement) async {
    // Nothing to show: leave the music alone instead of a pause-resume blip.
    if (!_inner.rewardedReadyFor(placement)) {
      return _inner.showRewarded(placement);
    }
    await _music.pauseForBackground();
    try {
      return await _inner.showRewarded(placement);
    } finally {
      await _music.resumeIfEnabled();
      await _music.recover();
    }
  }

  @override
  Future<bool> showPrivacyOptions() => _inner.showPrivacyOptions();
}
