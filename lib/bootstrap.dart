import 'package:flutter/widgets.dart';
import 'package:vinyl/app/app.dart';
import 'package:vinyl/core/config/app_config.dart';

void bootstrap(AppConfig config) {
  runApp(App(config: config));
}

