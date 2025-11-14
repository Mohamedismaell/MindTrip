import 'package:flutter/material.dart';
import 'package:ttproj/core/theme/app_colors.dart';
import 'package:ttproj/core/theme/app_text_styles.dart';
import 'package:ttproj/utility.dart';

class InterestsScreen extends StatelessWidget {
  InterestsScreen({super.key});
  final List<String> categories = [
    '☕ Cafés',
    '🥐 Bakeries',
    '🎵 Music',
    '🍢 Street Food Spots',
    '🎳 Bowling',
    '🍽️ Restaurants',
    '🍷 Fine Dining',
    '🥗 Healthy Spots',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 26.5,
          vertical: 151.5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 330,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'What are your interest ?',
                    style: AppTextStyles.headLine5Medium
                        .copyWith(
                          color: AppColors.darkGray1,
                        ),
                  ),
                  addVertical(8),
                  Text(
                    'You can select multiple choices',
                    style: AppTextStyles.headLine8Regular
                        .copyWith(
                          color: AppColors.mediumLightGray,
                        ),
                  ),
                ],
              ),
            ),
            addVertical(34),
            Wrap(
              spacing: 19,
              runSpacing: 14,
              children: categories.map((category) {
                return OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(
                      10,
                      // vertical: 12,
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    category,
                    style: AppTextStyles.headLine8Regular
                        .copyWith(
                          color: AppColors.darkGray2,
                        ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
