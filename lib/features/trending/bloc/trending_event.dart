import 'package:equatable/equatable.dart';

sealed class TrendingEvent extends Equatable {
  const TrendingEvent();

  @override
  List<Object?> get props => [];
}

/// Dispatched once when the Trending screen first appears.
class TrendingRequested extends TrendingEvent {
  const TrendingRequested();
}

/// Dispatched when the user picks a different genre filter.
class TrendingGenreChanged extends TrendingEvent {
  const TrendingGenreChanged(this.genre);

  final String? genre;

  @override
  List<Object?> get props => [genre];
}
