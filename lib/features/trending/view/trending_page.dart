import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/track.dart';
import '../../../data/repositories/track_repository.dart';
import '../bloc/trending_bloc.dart';
import '../bloc/trending_event.dart';
import '../bloc/trending_state.dart';
import 'widgets/track_grid_tile.dart';

class TrendingPage extends StatelessWidget {
  const TrendingPage({super.key, required this.trackRepository});

  final TrackRepository trackRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TrendingBloc(trackRepository: trackRepository)
        ..add(const TrendingRequested()),
      child: const _TrendingView(),
    );
  }
}

class _TrendingView extends StatelessWidget {
  const _TrendingView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trending on Audius')),
      body: BlocBuilder<TrendingBloc, TrendingState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: switch (state) {
              TrendingInitial() || TrendingLoading() => const Center(
                  key: ValueKey('loading'),
                  child: CircularProgressIndicator(),
                ),
              TrendingError(:final message) => Center(
                  key: const ValueKey('error'),
                  child: Text(message),
                ),
              TrendingLoaded(:final tracks) => _TrendingGrid(
                  key: const ValueKey('loaded'),
                  tracks: tracks,
                ),
            },
          );
        },
      ),
    );
  }
}

/// Responsive: the column count is derived from the available width via
/// [LayoutBuilder] rather than a fixed device-type check, so the grid
/// reflows immediately as the window is resized (desktop/web) — not just
/// once at startup.
class _TrendingGrid extends StatelessWidget {
  const _TrendingGrid({super.key, required this.tracks});

  final List<Track> tracks;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = (constraints.maxWidth / 220).floor().clamp(2, 6);
        return GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.72,
          ),
          itemCount: tracks.length,
          itemBuilder: (context, index) {
            final track = tracks[index];
            return TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: Duration(milliseconds: 250 + index * 30),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, (1 - value) * 16),
                    child: child,
                  ),
                );
              },
              child: TrackGridTile(track: track),
            );
          },
        );
      },
    );
  }
}
