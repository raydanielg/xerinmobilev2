import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:xerin_market/app.dart';
import 'package:xerin_market/config/di/service_locator.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await initServiceLocator(reset: true);
  });

  testWidgets('App loads smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const XerinApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
