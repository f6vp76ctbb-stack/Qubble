// In a right-to-left layout (Arabic) a signed number must still read "+6",
// not "6+". Text inherits the ambient direction, and the bidi algorithm puts
// a leading "+" after the digits in an RTL paragraph — which is how the first
// Arabic screenshots showed "6+" coins and "30%+" speed bonus.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gridpop/ui/widgets/app_icons.dart';

void main() {
  testWidgets('a reward amount keeps its sign in front in an RTL layout', (
    tester,
  ) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.rtl,
        child: Center(child: CoinAmount(amount: 6, prefix: '+')),
      ),
    );

    final text = tester.widget<Text>(find.text('+6'));
    expect(text.textDirection, TextDirection.ltr);
  });
}
