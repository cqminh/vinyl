import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vinyl/core/network/api_client.dart';
import 'package:vinyl/core/theme/app_theme.dart';
import 'package:vinyl/data/models/track.dart';
import 'package:vinyl/data/repositories/track_repository.dart';
import 'package:vinyl/features/trending/view/trending_page.dart';

/// A fake repository that never touches the network, so widget tests stay
/// fast and hermetic instead of racing a real HTTP call.
class _FakeTrackRepository extends TrackRepository {
  _FakeTrackRepository() : super(ApiClient());

  @override
  Future<List<Track>> getTrending({String? genre}) async => const [];
}

void main() {
  testWidgets('Trending page shows the app bar and an empty grid', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: TrendingPage(trackRepository: _FakeTrackRepository()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Trending on Audius'), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);
  });
}
