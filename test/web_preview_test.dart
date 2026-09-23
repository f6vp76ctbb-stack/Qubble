// The daily share text ends in a link to the web build, and whoever receives
// it sees whatever preview their chat app builds from web/index.html. Without
// Open Graph tags that was a bare URL. The tags are only useful if they point
// at real, absolute URLs — crawlers ignore <base> — so this ties them to the
// same address the app shares and to an image that is actually published.
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/ui/screens/game_screen.dart' show kQubbleWebUrl;

String? _meta(String html, String property) {
  final match = RegExp(
    '<meta (?:property|name)="${RegExp.escape(property)}" content="([^"]*)"',
  ).firstMatch(html);
  return match?.group(1);
}

void main() {
  final html = File('web/index.html').readAsStringSync();

  test('the preview carries a title, description, image and card type', () {
    for (final tag in [
      'og:title',
      'og:description',
      'og:image',
      'og:url',
      'twitter:card',
    ]) {
      expect(_meta(html, tag), isNotNull, reason: '$tag is missing');
      expect(_meta(html, tag)!.trim(), isNotEmpty, reason: '$tag is empty');
    }
    expect(_meta(html, 'twitter:card'), 'summary_large_image');
  });

  test('the preview URL is the one the share text links to', () {
    expect(_meta(html, 'og:url'), kQubbleWebUrl);
  });

  test('the preview image is published and has the size it declares', () {
    final image = _meta(html, 'og:image')!;
    expect(image, startsWith(kQubbleWebUrl), reason: 'must be absolute');
    final file = File('web/${image.substring(kQubbleWebUrl.length)}');
    expect(file.existsSync(), isTrue, reason: '${file.path} is not in web/');

    // PNG: width and height are the first two big-endian words of IHDR.
    final bytes = file.readAsBytesSync();
    final header = ByteData.sublistView(bytes, 16, 24);
    expect(header.getUint32(0), int.parse(_meta(html, 'og:image:width')!));
    expect(header.getUint32(4), int.parse(_meta(html, 'og:image:height')!));
    // Small enough that chat apps fetch it rather than skip it.
    expect(bytes.length, lessThan(300 * 1024));
  });

  test('the preview makes no claim the store listing does not make', () {
    // Same rule as test/store_claims_test.dart: a preview is marketing copy.
    final text = [
      _meta(html, 'description'),
      _meta(html, 'og:description'),
      _meta(html, 'og:image:alt'),
    ].join(' ').toLowerCase();
    for (final claim in ['no server', 'no ads', 'ad-free', 'ad free']) {
      expect(text, isNot(contains(claim)), reason: claim);
    }
  });
}
