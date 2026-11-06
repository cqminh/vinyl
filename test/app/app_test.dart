import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vinyl/app/app.dart';
import 'package:vinyl/core/config/app_config.dart';

import '../helpers/mock.dart';

void main() {
  testWidgets(
    'App dựng được với repository giả', 
    (tester) async {
      final authRepository = MockAuthRepository();
      when(() => authRepository.userChanges)
        .thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(
        App(config: AppConfig.dev, authRepository: authRepository),
      );

      expect(find.byType(MaterialApp), findsOneWidget);
    }
  );
}