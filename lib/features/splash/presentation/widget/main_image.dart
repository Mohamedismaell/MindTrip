import 'package:flutter/material.dart';

class MainImage extends StatelessWidget {
  const MainImage({super.key, required this.imageAssets});
  final String imageAssets;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imageAssets,
      width: double.infinity,
      height: 544,
      fit: BoxFit.cover,
    );
  }
}
