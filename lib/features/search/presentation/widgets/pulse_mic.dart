import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';

class PulseMic extends StatelessWidget {
  const PulseMic({
    super.key,
    required this.animation,
    required this.listening,
  });

  final Animation<double> animation;
  final bool listening;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220.r,
      height: 220.r,
      child: AnimatedBuilder(
        animation: animation,
        builder: (_, _) {
          final breath = animation.value;
          
          return Stack(
            alignment: Alignment.center,
            children: [
              _buildRing(0),
              _buildRing(.33),
              _buildRing(.66),

              Container(
                width: 104.r,
                height: 104.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.blueLightGradient,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryBlue.withValues(
                        alpha: listening ? (0.2 + breath * 0.15) : 0.15,
                      ),
                      blurRadius: listening ? (25 + breath * 15) : 15,
                      spreadRadius: listening ? (5 + breath * 5) : 2,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.mic_rounded,
                  size: 44.sp,
                  color: Colors.white,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRing(double delay) {
    if (!listening) return const SizedBox.shrink();

    final progress = (animation.value + delay) % 1;
    final size = 100.r + (110.r * progress);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primaryBlue.withValues(alpha: (1 - progress) * .22),
          width: 2,
        ),
      ),
    );
  }
}
