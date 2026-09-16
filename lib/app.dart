import 'package:flutter/material.dart';

import 'core/network/api_client.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/track_repository.dart';
import 'features/trending/view/trending_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vinyl',
      theme: AppTheme.light,
      home: TrendingPage(trackRepository: TrackRepository(ApiClient())),
    );
  }
}
