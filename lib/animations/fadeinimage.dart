import 'package:flutter/material.dart';

class FadeInImageAnimation extends StatelessWidget {
  final String url;
  const FadeInImageAnimation({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return Container(
        color: Colors.grey.shade200,
        alignment: Alignment.center,
        child: const Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
      );
    }
    return Image.network(
      url,
      fit: BoxFit.contain,
      width: double.infinity,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return AnimatedOpacity(opacity: 1, duration: const Duration(milliseconds: 300), child: child);
        return Container(
          color: Colors.grey.shade100,
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            value: progress.expectedTotalBytes != null
                ? progress.cumulativeBytesLoaded / (progress.expectedTotalBytes!)
                : null,
          ),
        );
      },
      errorBuilder: (_, __, ___) => Container(
        color: Colors.grey.shade100,
        alignment: Alignment.center,
        child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
      ),
    );
  }
}
