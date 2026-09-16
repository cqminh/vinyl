import '../../core/network/api_client.dart';
import '../models/track.dart';

/// The data-access boundary between the Bloc (ViewModel) and the network.
/// The Bloc never touches Dio directly — it only ever talks to this class,
/// and only ever sees [Track] models, never raw JSON.
class TrackRepository {
  TrackRepository(this._apiClient);

  final ApiClient _apiClient;

  Future<List<Track>> getTrending({String? genre}) async {
    final response = await _apiClient.dio.get<Map<String, dynamic>>(
      '/tracks/trending',
      queryParameters: {'genre': ?genre},
    );

    final data = response.data!['data'] as List<dynamic>;
    return data
        .map((json) => Track.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
