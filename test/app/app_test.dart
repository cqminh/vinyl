import 'package:flutter_test/flutter_test.dart';
import 'package:vinyl/app/app.dart';
import 'package:vinyl/core/config/app_config.dart';

void main() {
  testWidgets(
    'bootstrap app dev', 
    (WidgetTester tester) async {
      await tester.pumpWidget(App(config: AppConfig.dev));
      expect(find.text('Vinyl - dev'), findsOneWidget);
    }
  );

  testWidgets(
    'bootstrap app prod', 
    (WidgetTester tester) async {
      await tester.pumpWidget(App(config: AppConfig.prod));
      expect(find.text('Vinyl - prod'), findsOneWidget);
    }
  );
}