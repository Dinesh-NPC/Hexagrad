import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hexagrad/main.dart';

void main() {
  testWidgets('HexaGrad smoke test', (WidgetTester tester) async {
    // Build the HexaGrad app and trigger a frame
    await tester.pumpWidget(const HexaGrad());

    // Verify the Splash screen title appears
    expect(find.text('HexaGrad'), findsOneWidget);
  });
}
