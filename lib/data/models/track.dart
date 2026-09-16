/// Model layer: a plain data class mirroring one item of the Audius
/// `GET /v1/tracks/trending` response `data` array. No Flutter/Bloc/Dio
/// imports here — the Model layer only knows about shape and parsing.
class Track {
  const Track({
    required this.id,
    required this.title,
    required this.artistName,
    required this.artworkUrl,
    required this.duration,
    required this.playCount,
    required this.genre,
    required this.mood,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    final artwork = json['artwork'] as Map<String, dynamic>?;
    return Track(
      id: json['id'] as String,
      title: json['title'] as String? ?? 'Untitled',
      artistName: (json['user'] as Map<String, dynamic>?)?['name'] as String? ?? 'Unknown artist',
      artworkUrl: artwork?['480x480'] as String?,
      duration: json['duration'] as int? ?? 0,
      playCount: json['play_count'] as int? ?? 0,
      genre: json['genre'] as String?,
      mood: json['mood'] as String?,
    );
  }

  final String id;
  final String title;
  final String artistName;
  final String? artworkUrl;
  final int duration;
  final int playCount;
  final String? genre;
  final String? mood;
}
