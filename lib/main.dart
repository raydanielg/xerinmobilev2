import 'package:flutter/material.dart';

import 'app.dart';
import 'config/di/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initServiceLocator();

  runApp(const XerinApp());
}
