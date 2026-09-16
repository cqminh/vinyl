import 'package:equatable/equatable.dart';

import '../../../data/models/track.dart';

sealed class TrendingState extends Equatable {
  const TrendingState();

  @override
  List<Object?> get props => [];
}

class TrendingInitial extends TrendingState {
  const TrendingInitial();
}

class TrendingLoading extends TrendingState {
  const TrendingLoading();
}

class TrendingLoaded extends TrendingState {
  const TrendingLoaded(this.tracks, {this.genre});

  final List<Track> tracks;
  final String? genre;

  @override
  List<Object?> get props => [tracks, genre];
}

class TrendingError extends TrendingState {
  const TrendingError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
