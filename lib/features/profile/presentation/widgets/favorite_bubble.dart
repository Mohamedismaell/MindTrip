import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//Todo Edit to be interactive with the sync data
class FavoriteBubble extends StatelessWidget {
  const FavoriteBubble({
    super.key,
    required this.isFavorite,
    this.small = false,
  });

  final bool isFavorite;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final size = small ? 24.w : 31.w;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.35),
        shape: BoxShape.circle,
      ),
      child: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        size: small ? 16.sp : 18.sp,
        color: Colors.red,
      ),
    );
  }
}
