import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

/// ──────────────────────────────────────────────────────────────────────────────
/// [PRESENTATION LAYER] — Widget
///
/// [AuthOptionsButton] renders a social login option (Google, Facebook, etc.)
/// as an outlined button with an SVG icon.
/// ──────────────────────────────────────────────────────────────────────────────
class AuthOptionsButton extends StatelessWidget {
  const AuthOptionsButton({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
  });

  final String text;
  final String icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: onTap ?? () {},
        icon: SvgPicture.asset(icon, width: 20.w),
        label: Text(
          text,
          style: context.textTheme.labelLarge,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
