import 'package:dio/dio.dart';

/// Thin wrapper around the Audius REST API base configuration.
///
/// Audius requires an `app_name` query param on every request (no auth
/// needed for public reads), so it's added once here instead of at every
/// call site.
class ApiClient {
  ApiClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: 'https://api.audius.co/v1',
            queryParameters: {'app_name': 'vinyl'},
          ),
        );

  final Dio dio;
}
