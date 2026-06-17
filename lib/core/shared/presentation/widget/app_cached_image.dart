import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppCacheManager {
  AppCacheManager._();

  static const String _key = 'app_image_cache';

  static final CacheManager instance = CacheManager(
    Config(
      _key,
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 150,
      repo: JsonCacheInfoRepository(databaseName: _key),
      fileService: HttpFileService(),
    ),
  );
}

class AppCachedImage extends StatelessWidget {
  final String? imagePath;
  final String? cacheKey;
  final double? width;
  final double? height;
  final BoxFit fit;
  final int? cacheWidth;
  final int? cacheHeight;

  const AppCachedImage({
    super.key,
    this.imagePath,
    this.cacheKey,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.cacheWidth,
    this.cacheHeight,
  });
  bool get _isNetworkImage {
    return imagePath?.startsWith('http') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    if (!_isNetworkImage) {
      return Image.asset(
        imagePath ?? 'assets/images/onboarding/Pyramids.webp',
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, _, _) => _errorWidget(),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final pixelRatio = MediaQuery.devicePixelRatioOf(context);

        final resolvedWidth = width ?? constraints.maxWidth;
        final resolvedHeight = height ?? constraints.maxHeight;

        final memCacheWidth =
            cacheWidth ??
            (resolvedWidth.isFinite
                ? (resolvedWidth * pixelRatio).round()
                : null);

        final memCacheHeight =
            cacheHeight ??
            (resolvedHeight.isFinite
                ? (resolvedHeight * pixelRatio).round()
                : null);

        return CachedNetworkImage(
          imageUrl: imagePath!,
          cacheKey: cacheKey,
          cacheManager: AppCacheManager.instance,
          httpHeaders: const {
            'User-Agent':
                'Mozilla/5.0 (Linux; Android 13; Mobile; rv:120.0) Gecko/120.0 Firefox/120.0',
            'Accept': 'image/avif,image/webp,image/*,*/*;q=0.8',
          },

          width: width,
          height: height,
          fit: fit,

          memCacheWidth: memCacheWidth,
          memCacheHeight: memCacheHeight,

          fadeInDuration: Duration.zero,
          fadeOutDuration: Duration.zero,

          placeholder: (_, _) => const SizedBox.shrink(),

          errorWidget: (_, _, _) => Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8.r),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.image_not_supported_outlined,
              color: Colors.grey.shade400,
              size: 28.r,
            ),
          ),
        );
      },
    );
  }

  Widget _errorWidget() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8.r),
      ),
      alignment: Alignment.center,
      child: Icon(
        Icons.image_not_supported_outlined,
        color: Colors.grey.shade400,
        size: 28.r,
      ),
    );
  }
}
