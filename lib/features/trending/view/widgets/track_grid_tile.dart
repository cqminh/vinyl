import 'package:flutter/material.dart';

import '../../../../data/models/track.dart';

/// A single track card in the trending grid. Pure View layer: takes a
/// [Track] and renders it — no Bloc, no network calls, no business logic.
class TrackGridTile extends StatelessWidget {
  const TrackGridTile({super.key, required this.track});

  final Track track;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: track.artworkUrl != null
                ? Image.network(
                    track.artworkUrl!,
                    fit: BoxFit.cover,
                    // Audius content nodes are decentralized and individual
                    // ones do go down (503s observed in practice) — fall
                    // back to the placeholder instead of rendering nothing.
                    errorBuilder: (context, error, stackTrace) =>
                        const _ArtworkPlaceholder(),
                    // Fade the image in once it actually arrives instead of
                    // popping in abruptly.
                    frameBuilder: (context, child, frame, wasSyncLoaded) {
                      if (wasSyncLoaded) return child;
                      return AnimatedOpacity(
                        opacity: frame == null ? 0 : 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        child: child,
                      );
                    },
                  )
                : const _ArtworkPlaceholder(),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  track.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  track.artistName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ArtworkPlaceholder extends StatelessWidget {
  const _ArtworkPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: const Icon(Icons.album, size: 48),
    );
  }
}
