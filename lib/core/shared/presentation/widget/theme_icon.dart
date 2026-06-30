import 'package:mindtrip/core/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/cubit/theme_cubit.dart';

class ThemeIcon extends StatelessWidget {
  const ThemeIcon({super.key, this.top, this.right});
  final double? top;
  final double? right;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Positioned(
          top: top ?? MediaQuery.sizeOf(context).height * 0.05,
          right: right ?? MediaQuery.sizeOf(context).width * 0.05,
          child: Container(
            width: 70.w,
            height: 35.h,

            color: Colors.transparent,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => context.read<ThemeCubit>().toggleTheme(),
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      backgroundColor: context.colorTheme.surface.withValues(
                        alpha: 0.7,
                      ),
                      // backgroundColor: Colors.transparent,
                      padding: EdgeInsets.all(6.r),
                    ),
                    child: AnimatedAlign(
                      duration: Duration(milliseconds: 300),
                      alignment: state.isDark
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Icon(
                        state.isDark
                            ? Icons.light_mode_outlined
                            : Icons.dark_mode_outlined,
                        color: context.colorTheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
