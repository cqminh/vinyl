import 'package:vinyl/bootstrap.dart';
import 'package:vinyl/core/config/app_config.dart';

Future<void> main() async {
  await bootstrap(AppConfig.prod);
}