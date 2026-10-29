import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:vinyl/app/app.dart';
import 'package:vinyl/core/config/app_config.dart';
import 'package:vinyl/firebase_options.dart';

Future<void> bootstrap(AppConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(App(config: config));
}

