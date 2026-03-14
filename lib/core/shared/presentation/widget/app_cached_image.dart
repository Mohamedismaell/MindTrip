import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppCachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  const AppCachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      httpHeaders: const {
        'User-Agent':
            'Mozilla/5.0 (Linux; Android 13; Mobile; rv:120.0) Gecko/120.0 Firefox/120.0',
        'Accept': 'image/avif,image/webp,image/*,*/*;q=0.8',
      },
      width: width,
      height: height,
      fit: fit,
      placeholder: (_, _) => Skeletonizer(
        effect: ShimmerEffect(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
        ),
        child: SizedBox(width: width, height: height),
      ),
      errorWidget: (BuildContext context, String url, Object error) {
        // debugPrint('❌ Image failed');
        // debugPrint('URL: $url');
        // debugPrint('ErrorImageHere: $error');
        return Image.asset(
          'assets/images/Rectangle 18.png',
          width: width,
          height: height,
          fit: fit,
        );
        // Icon(Icons.broken_image);
      },
    );
  }
}
