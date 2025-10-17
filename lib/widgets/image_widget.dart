import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String imagePath;
  final bool isImageAsset;
  final double? width;
  final double? height;
  final BoxFit fit;
  final String fallbackAsset;

  const ImageWidget({
    super.key,
    required this.imagePath,
    required this.isImageAsset,
    this.width = 50,
    this.height = 50,
    this.fit = BoxFit.cover,
    this.fallbackAsset = 'assets/images/fallback.png',
  });

  @override
  Widget build(BuildContext context) {
    if (isImageAsset) {
      return Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          debugPrint("Asset loading failed for $imagePath: $error");
          return _errorPlaceholder();
        },
      );
    } else {
      return Image.network(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: progress.expectedTotalBytes != null
                  ? progress.cumulativeBytesLoaded /
                      (progress.expectedTotalBytes ?? 1)
                  : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          debugPrint("Network image failed: $error for $imagePath");
          return _errorPlaceholder();
        },
      );
    }
  }

  Widget _errorPlaceholder() {
    return Image.asset(
      fallbackAsset,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
