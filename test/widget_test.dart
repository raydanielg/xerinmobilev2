import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:xerin_market/app.dart';

void main() {
  testWidgets('App loads smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const XerinApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
