import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/services/review.dart';
import 'package:gridpop/services/storage.dart';
import 'package:gridpop/ui/screens/settings_screen.dart';
import 'package:gridpop/ui/state/game_controller.dart';
import 'package:gridpop/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _RecordingReview implements ReviewService {
  _RecordingReview({this.listingOpens = true});

  final bool listingOpens;
  int listings = 0;

  @override
  Future<bool> requestReview() async => false;

  @override
  Future<bool> openStoreListing() async {
    listings++;
    return listingOpens;
  }
}

/// The settings list is long and lazily built — give the test a tall viewport
/// so the entry near the bottom is actually laid out.
void _useTallViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(600, 2400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

Future<Widget> _app(Storage storage, ReviewService review) async {
  return ProviderScope(
    overrides: [
      storageProvider.overrideWithValue(storage),
      reviewServiceProvider.overrideWithValue(review),
    ],
    child: MaterialApp(theme: buildGridTheme(), home: const SettingsScreen()),
  );
}

void main() {
  testWidgets('settings offers a rate-the-app entry that opens the store', (
    tester,
  ) async {
    _useTallViewport(tester);
    SharedPreferences.setMockInitialValues({});
    final storage = await Storage.create();
    final review = _RecordingReview();

    await tester.pumpWidget(await _app(storage, review));
    await tester.pump();

    final entry = find.text('App bewerten');
    expect(entry, findsOneWidget);

    await tester.ensureVisible(entry);
    await tester.tap(entry);
    await tester.pumpAndSettle();

    expect(review.listings, 1);
    expect(storage.reviewRated, isTrue);
  });

  testWidgets('explains it when no store listing can be opened', (
    tester,
  ) async {
    _useTallViewport(tester);
    SharedPreferences.setMockInitialValues({});
    final storage = await Storage.create();
    final review = _RecordingReview(listingOpens: false);

    await tester.pumpWidget(await _app(storage, review));
    await tester.pump();

    final entry = find.text('App bewerten');
    await tester.ensureVisible(entry);
    await tester.tap(entry);
    await tester.pumpAndSettle();

    expect(find.textContaining('nicht verfügbar'), findsOneWidget);
    expect(storage.reviewRated, isFalse);
  });
}
