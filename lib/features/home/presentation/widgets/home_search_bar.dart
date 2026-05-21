import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/utils/extension.dart';

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({super.key});

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  final TextEditingController _searchTextEditController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 46.h,
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              decoration: BoxDecoration(
                color: context.colorTheme.surface,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                  color: context.colorTheme.outline.withValues(alpha: 0.55),
                  width: 0.8,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search_rounded,
                    size: 20.sp,
                    color: context.colorTheme.outline,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
