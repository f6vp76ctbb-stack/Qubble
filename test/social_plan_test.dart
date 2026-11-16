// The editorial plan a scheduled task hands to Buffer every night
// (store-assets/social/plan.json, owner 16.11.2026: "dass du automatisiert
// solche Prozesse machen kannst"). Nobody reads a post before it goes out,
// so what Buffer or a platform would reject, or what would post a dead link,
// fails here first.
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

const _raw = 'https://raw.githubusercontent.com/f6vp76ctbb-stack/Qubble/main/';
const _play =
    'https://play.google.com/store/apps/details?id=com.thinkube.qubble';

List<Map<String, dynamic>> _posts() {
  final plan = jsonDecode(
    File('store-assets/social/plan.json').readAsStringSync(),
  ) as Map<String, dynamic>;
  return (plan['posts'] as List).cast<Map<String, dynamic>>();
}

List<Map<String, dynamic>> _assets(Map<String, dynamic> post) =>
    (post['assets'] as List).cast<Map<String, dynamic>>();

String _url(Map<String, dynamic> asset) =>
    ((asset['video'] ?? asset['image']) as Map<String, dynamic>)['url']
        as String;

int _hashtags(String text) => RegExp(r'(^|\s)#\w').allMatches(text).length;

void main() {
  final posts = _posts();

  test('every post has an id of its own and a known channel', () {
    final ids = posts.map((p) => p['id']).toList();
    expect(ids.toSet().length, ids.length);
    for (final post in posts) {
      expect(
        ['youtube', 'instagram', 'tiktok'],
        contains(post['channel']),
        reason: '${post['id']}',
      );
    }
  });

  test('times carry the Berlin offset and never collide on a channel', () {
    final seen = <String>{};
    for (final post in posts) {
      final due = post['dueAt'] as String;
      expect(
        RegExp(r'^\d{4}-\d\d-\d\dT\d\d:\d\d:00\+0[12]:00$').hasMatch(due),
        isTrue,
        reason: '${post['id']}: $due',
      );
      expect(DateTime.tryParse(due), isNotNull, reason: due);
      // The nightly task treats "same channel, same minute" as already
      // scheduled; two plan entries there would silently drop one.
      expect(seen.add('${post['channel']} $due'), isTrue, reason: due);
    }
  });

  test('media come from the repository and exist there', () {
    for (final post in posts) {
      final assets = _assets(post);
      expect(assets, isNotEmpty, reason: '${post['id']}');
      for (final asset in assets) {
        final url = _url(asset);
        expect(url, startsWith(_raw), reason: url);
        final path = url.substring(_raw.length);
        expect(File(path).existsSync(), isTrue, reason: 'missing $path');
        if (asset.containsKey('image')) {
          final meta = (asset['image'] as Map)['metadata'] as Map?;
          expect(meta?['altText'], isNotEmpty, reason: '$url needs alt text');
        }
      }
    }
  });

  test('each platform gets what it requires', () {
    for (final post in posts) {
      final id = post['id'];
      final text = post['text'] as String;
      final meta = post['metadata'] as Map<String, dynamic>;
      final assets = _assets(post);
      switch (post['channel']) {
        case 'youtube':
          final yt = meta['youtube'] as Map<String, dynamic>;
          expect(assets.single.containsKey('video'), isTrue, reason: '$id');
          expect((yt['title'] as String).length, lessThanOrEqualTo(100));
          expect(yt['categoryId'], '20');
          expect(yt['madeForKids'], isFalse);
          // The clickable link only YouTube descriptions allow.
          expect(text, contains(_play), reason: '$id');
          expect(text.length, lessThanOrEqualTo(5000));
          // YouTube ignores every hashtag of a description above 60.
          expect(_hashtags(text), lessThanOrEqualTo(60));
        case 'instagram':
          final ig = meta['instagram'] as Map<String, dynamic>;
          expect(['reel', 'story', 'post'], contains(ig['type']));
          expect(ig['shouldShareToFeed'], isA<bool>());
          if (ig['type'] == 'reel') {
            expect(assets.single.containsKey('video'), isTrue, reason: '$id');
          }
          if (ig['type'] == 'story') {
            expect(assets, hasLength(1), reason: '$id');
            expect(ig['link'], _play, reason: '$id: the link sticker');
          } else {
            expect(text, contains('Google Play'), reason: '$id');
            expect(_hashtags(text), lessThanOrEqualTo(5), reason: '$id');
          }
          expect(assets.length, lessThanOrEqualTo(20));
          expect(text.length, lessThanOrEqualTo(2200));
        case 'tiktok':
          expect(meta.containsKey('tiktok'), isTrue, reason: '$id');
          expect(assets.length, lessThanOrEqualTo(10), reason: '$id');
          expect(text, contains('Google Play'), reason: '$id');
          expect(text.length, lessThanOrEqualTo(2200));
      }
    }
  });
}
