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

/// Guards the audio assets' download cost and their format compatibility.
///
/// The music loop is the single largest asset in the app. It was 1.87 MB of
/// 22050 Hz PCM carrying content whose highest partial is 663 Hz — six times
/// more sample rate than the signal uses, paid for on every install. It is now
/// 8000 Hz and 0.68 MB, with the audible spectrum unchanged.
///
/// The format stays uncompressed PCM on purpose, and that is the part most
/// likely to be "improved" later: Ogg Vorbis is not decoded by iOS, and MP3
/// adds encoder padding at the file boundary, which would put a gap in a loop
/// that scripts/gen_music.py goes out of its way to make click-free.
void main() {
  test('the music loop is not paying for sample rate it cannot use', () {
    final music = File('assets/audio/music.wav');
    expect(music.existsSync(), isTrue);

    final header = _wavHeader(music);
    expect(header.channels, 1, reason: 'an ambient pad needs no stereo image');
    expect(header.bitsPerSample, 16);
    expect(
      header.sampleRate,
      lessThanOrEqualTo(8000),
      reason: 'the highest partial in this loop is 663 Hz; a higher rate is '
          'download size spent on silence above the content',
    );
    expect(
      header.sampleRate,
      greaterThanOrEqualTo(4000),
      reason: 'Nyquist has to stay clear of the 663 Hz content',
    );
  });

  test('the music loop stays under a megabyte', () {
    final size = File('assets/audio/music.wav').lengthSync();
    expect(
      size,
      lessThan(1024 * 1024),
      reason: 'Google measures roughly 1% fewer installs per 6 MB of download; '
          'this one asset was 1.87 MB of it',
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
