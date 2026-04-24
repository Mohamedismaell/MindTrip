import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class PlaceInfoBottomSheet extends StatefulWidget {
  final String? placeName;
  const PlaceInfoBottomSheet({super.key, this.placeName});

  // static Future<void> show(BuildContext context, {String? placeName}) {
  //   return showModalBottomSheet<void>(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //     builder: (_) => PlaceInfoBottomSheet(placeName: placeName),
  //   );
  // }

  @override
  State<PlaceInfoBottomSheet> createState() => _PlaceInfoBottomSheetState();
}

class _PlaceInfoBottomSheetState extends State<PlaceInfoBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.15,
      minChildSize: 0.15,
      maxChildSize: 0.4,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: context.colorTheme.surface,
            borderRadius: BorderRadius.all(Radius.circular(24.r)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                // Drag handle
                Padding(
                  padding: EdgeInsets.only(top: 30.h, bottom: 8.h),
                  child: Container(
                    width: 90.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: context.colorTheme.outline,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),

                //  Header

                // content
                Expanded(
                  child: Scrollbar(
                    controller: scrollController,
                    thumbVisibility: false,
                    interactive: true,
                    trackVisibility: false,
                    radius: Radius.circular(12.r),
                    thickness: 4.w,
                    child: ListView(
                      controller: scrollController,
                      children: [
                        if (widget.placeName != null)
                          Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: Text(
                              widget.placeName!,
                              style: context.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        Text('dsadasdas'),
                        Text('dsadasdas'),
                        Text('dsadasdas'),
                      ],
                    ),
                  ),
                ),

                // Bottom bar
              ],
            ),
          ),
        );
      },
    );
  }
}
