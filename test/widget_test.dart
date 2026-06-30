import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:xerin_market/app.dart';
import 'package:xerin_market/config/di/service_locator.dart';

const _secureStorageChannel = MethodChannel(
  'plugins.it_nomads.com/flutter_secure_storage',
);

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    SharedPreferences.setMockInitialValues({});

    final secureStore = <String, String>{};
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_secureStorageChannel, (call) async {
      final arguments = (call.arguments as Map?)?.cast<String, dynamic>() ??
          <String, dynamic>{};
      final key = arguments['key'] as String?;

      switch (call.method) {
        case 'read':
          return key == null ? null : secureStore[key];
        case 'write':
          if (key != null) {
            secureStore[key] = (arguments['value'] as String?) ?? '';
          }
          return null;
        case 'delete':
          if (key != null) {
            secureStore.remove(key);
          }
          return null;
        case 'deleteAll':
          secureStore.clear();
          return null;
        case 'containsKey':
          return key != null && secureStore.containsKey(key);
        case 'readAll':
          return secureStore;
      }

      return null;
    });

    await initServiceLocator(reset: true);
  });

  tearDownAll(() async {
    await TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_secureStorageChannel, null);
  });

  testWidgets('App loads smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const XerinApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
