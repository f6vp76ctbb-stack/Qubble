// The app links out to a hosted privacy policy and imprint. Those pages are
// files in web/ that the Pages workflow publishes under /Qubble/ — so a rename
// or a moved file breaks the link in a shipped build, silently, and a dead
// privacy link is a rejection risk for an app that is already in review.
//
// This cannot check that the site is up. It can check the two halves still
// agree, which is the failure that actually happens.
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Base the deploy workflow publishes to (`--base-href /Qubble/`).
const _base = 'https://f6vp76ctbb-stack.github.io/Qubble/';

void main() {
  final linked = <String>{};
  for (final file in Directory('lib')
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))) {
    for (final match
        in RegExp('${RegExp.escape(_base)}([A-Za-z0-9_./-]*)')
            .allMatches(file.readAsStringSync())) {
      linked.add(match.group(1)!);
    }
  }

  test('the app links to at least the policy and the imprint', () {
    // Guards the guard: a regex that silently matched nothing would make every
    // check below vacuous.
    expect(linked, contains('privacy.html'));
    expect(linked, contains('impressum.html'));
  });

  test('every linked page exists in web/, which is what gets published', () {
    for (final path in linked) {
      if (path.isEmpty) continue; // the site root, served by index.html
      expect(
        File('web/$path').existsSync(),
        isTrue,
        reason:
            'the app links to $_base$path but web/$path does not exist, so '
            'the link would 404 in a shipped build',
      );
    }
  });

  test('the deploy workflow still publishes under the linked base', () {
    // A changed --base-href would move every page and break every link above
    // without touching a single Dart file.
    final workflow = File('.github/workflows/deploy-web.yaml').readAsStringSync();
    expect(workflow, contains('--base-href /Qubble/'));
    expect(workflow, contains('path: build/web'));
  });

  test('markdown changes alone do not skip a page redeploy', () {
    // web/*.html must not be caught by paths-ignore: editing the privacy text
    // has to reach the live site.
    final workflow = File('.github/workflows/deploy-web.yaml').readAsStringSync();
    final ignore = workflow.split('paths-ignore:').last.split('jobs:').first;
    expect(ignore, isNot(contains('web/')));
    expect(ignore, isNot(contains('*.html')));
  });
}
