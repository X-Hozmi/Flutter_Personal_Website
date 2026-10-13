import 'package:flutter/material.dart';

/// Network image with a fallback shown while loading and on failure.
///
/// Uses Flutter's built-in [Image.network] rather than
/// `cached_network_image`: on web that package decodes through its own path,
/// which left avatars black after navigating away and back, and failed to
/// decode Discord avatars. The browser's HTTP cache plus Flutter's in-memory
/// `ImageCache` already keep images across route changes.
class RemoteImage extends StatelessWidget {
  const RemoteImage({
    super.key,
    required this.url,
    required this.fallback,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.semanticLabel,
  });

  final String url;

  /// Shown when [url] is empty, while loading, and when loading fails.
  final Widget fallback;
  final double? width;
  final double? height;
  final BoxFit fit;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) return _sized(fallback);

    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      semanticLabel: semanticLabel,
      gaplessPlayback: true,
      frameBuilder:
          (context, child, frame, wasSynchronouslyLoaded) =>
              wasSynchronouslyLoaded || frame != null
                  ? child
                  : _sized(fallback),
      errorBuilder: (context, error, stackTrace) => _sized(fallback),
    );
  }

  Widget _sized(Widget child) =>
      SizedBox(width: width, height: height, child: child);
}
