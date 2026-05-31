import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';

class PlaceDetailsLocationSection extends StatelessWidget {
  final PlaceModel place;

  const PlaceDetailsLocationSection({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: context.textTheme.titleMedium?.copyWith(
            color: AppColors.pureBlack,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 14.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(13.r),
          child: SizedBox(
            height: 128.h,
            width: double.infinity,
            child: CustomPaint(
              painter: _MapPreviewPainter(),
              child: Center(
                child: Icon(
                  Icons.location_on_rounded,
                  size: 34.r,
                  color: AppColors.errorRed,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 14.h),
        Center(
          child: SizedBox(
            width: 230.w,
            height: 43.h,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.open_in_new_rounded, size: 16.r),
              label: const Text('Open full map'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primaryBlue,
                side: const BorderSide(color: AppColors.primaryBlue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
                textStyle: context.textTheme.titleSmall?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MapPreviewPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()..color = const Color(0xFFF4F5F7);
    canvas.drawRect(Offset.zero & size, backgroundPaint);

    final roadPaint = Paint()
      ..color = AppColors.pureWhite
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(size.width * 0.08, 0),
      Offset(size.width * 0.42, size.height),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.52, 0),
      Offset(size.width * 0.52, size.height * 0.88),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.82, 0),
      Offset(size.width * 0.82, size.height),
      roadPaint,
    );
    canvas.drawLine(
      Offset(0, size.height * 0.48),
      Offset(size.width, size.height * 0.48),
      roadPaint,
    );

    final routePaint = Paint()
      ..color = AppColors.primaryBlue
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final route = Path()
      ..moveTo(size.width * 0.46, size.height)
      ..cubicTo(
        size.width * 0.46,
        size.height * 0.78,
        size.width * 0.62,
        size.height * 0.92,
        size.width * 0.62,
        size.height * 0.68,
      )
      ..lineTo(size.width * 0.62, size.height * 0.43);
    canvas.drawPath(route, routePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
