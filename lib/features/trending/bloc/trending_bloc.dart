import 'package:bloc/bloc.dart';

import '../../../data/repositories/track_repository.dart';
import 'trending_event.dart';
import 'trending_state.dart';

/// The ViewModel for the Trending screen. Translates [TrendingEvent]s into
/// [TrackRepository] calls and emits [TrendingState]s for the View to render.
/// Owns no widgets, no BuildContext — only knows about Events, the
/// Repository, and States.
class TrendingBloc extends Bloc<TrendingEvent, TrendingState> {
  TrendingBloc({required this.trackRepository})
      : super(const TrendingInitial()) {
    on<TrendingRequested>(_onRequested);
    on<TrendingGenreChanged>(_onGenreChanged);
  }

  final TrackRepository trackRepository;

  Future<void> _onRequested(
    TrendingRequested event,
    Emitter<TrendingState> emit,
  ) async {
    await _loadTrending(emit);
  }

  Future<void> _onGenreChanged(
    TrendingGenreChanged event,
    Emitter<TrendingState> emit,
  ) async {
    await _loadTrending(emit, genre: event.genre);
  }

  Future<void> _loadTrending(
    Emitter<TrendingState> emit, {
    String? genre,
  }) async {
    emit(const TrendingLoading());
    try {
      final tracks = await trackRepository.getTrending(genre: genre);
      emit(TrendingLoaded(tracks, genre: genre));
    } catch (error) {
      emit(TrendingError('Could not load trending tracks: $error'));
    }
  }
}
