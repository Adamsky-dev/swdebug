import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:swdebug/main.dart';

void main() {
  testWidgets('Widget - Test stopwatch start', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MyApp(),
      ),
    );

    final startBtnWidget = find.byKey(const Key('btnStartStop'));

    await tester.tap(startBtnWidget);
    await tester.pump(const Duration(minutes: 3));
    await tester.tap(startBtnWidget);
    await tester.pumpAndSettle();

    final timerText = find.byKey(const Key('timerText'));
    expect(timerText, findsOneWidget);

    final text = timerText.evaluate().single.widget as Text;

    expect(text.data, '00:03:000');
  });
}
