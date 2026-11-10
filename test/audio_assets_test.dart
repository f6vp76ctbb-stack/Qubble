import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

/// Reads the format fields out of a canonical PCM WAV header.
({int channels, int sampleRate, int bitsPerSample, int dataBytes}) _wavHeader(
  File file,
) {
  final bytes = file.readAsBytesSync();
  final data = ByteData.sublistView(Uint8List.fromList(bytes));
  expect(String.fromCharCodes(bytes.sublist(0, 4)), 'RIFF');
  expect(String.fromCharCodes(bytes.sublist(8, 12)), 'WAVE');
  return (
    channels: data.getUint16(22, Endian.little),
    sampleRate: data.getUint32(24, Endian.little),
    bitsPerSample: data.getUint16(34, Endian.little),
    dataBytes: bytes.length - 44,
  );
}

/// Guards the audio assets' playback quality, download cost and format.
///
/// The music loop's highest partial is 663 Hz, so it was cut to 8000 Hz in
/// September 2026 to save download size. That turned out to cost sound: the
/// phone resamples the file to its 48 kHz output, and a cheap resampler left
/// mirror images of the music around 8 kHz — a faint hiss the owner heard
/// behind the loop (12.10.2026). At 24000 Hz, exactly half of 48 kHz, the
/// first image sits at 23 kHz, out of hearing whatever the resampler.
///
/// The format stays uncompressed PCM on purpose, and that is the part most
/// likely to be "improved" later: Ogg Vorbis is not decoded by iOS, and MP3
/// adds encoder padding at the file boundary, which would put a gap in a loop
/// that scripts/gen_music.py goes out of its way to make click-free.
void main() {
  test('the music loop resamples to 48 kHz without audible images', () {
    final music = File('assets/audio/music.wav');
    expect(music.existsSync(), isTrue);

    final header = _wavHeader(music);
    expect(header.channels, 1, reason: 'an ambient pad needs no stereo image');
    expect(header.bitsPerSample, 16);
    expect(
      48000 % header.sampleRate,
      0,
      reason: 'a whole fraction of the phone output rate resamples cleanly',
    );
    expect(
      header.sampleRate,
      greaterThanOrEqualTo(24000),
      reason: 'below it the resampling images fall inside hearing — the hiss '
          'of the 8000 Hz loop',
    );
    expect(
      header.sampleRate,
      lessThanOrEqualTo(24000),
      reason: 'more rate is download size spent above the 663 Hz content',
    );
  });

  test('the music loop stays near two megabytes', () {
    final size = File('assets/audio/music.wav').lengthSync();
    expect(
      size,
      lessThan((2.1 * 1024 * 1024).round()),
      reason: 'Google measures roughly 1% fewer installs per 6 MB of download',
    );
  });

  test('every audio asset is mono 16-bit PCM', () {
    // PCM in a WAV container is the one format both Android and iOS decode
    // without qualification, and the only one that loops without a gap.
    final files = Directory('assets/audio')
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.wav'));
    expect(files, isNotEmpty);

    for (final file in files) {
      final header = _wavHeader(file);
      expect(header.channels, 1, reason: file.path);
      expect(header.bitsPerSample, 16, reason: file.path);
    }
  });
}
