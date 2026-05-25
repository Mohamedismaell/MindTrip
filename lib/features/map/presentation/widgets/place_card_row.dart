import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import '../cubit/map_cubit.dart';
import '../cubit/map_state.dart';

class PlaceCardRow extends StatefulWidget {
  const PlaceCardRow({super.key});

  @override
  State<PlaceCardRow> createState() => _PlaceCardRowState();
}

class _PlaceCardRowState extends State<PlaceCardRow> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToIndex(int index) {
    if (!_scrollController.hasClients) return;
    const itemWidth = 240.0;
    final targetOffset = index * itemWidth;
    if (targetOffset <= _scrollController.position.maxScrollExtent) {
       _scrollController.animateTo(
         targetOffset,
         duration: const Duration(milliseconds: 300),
         curve: Curves.easeInOut,
       );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCubit, MapState>(
      listenWhen: (previous, current) => previous.selectedPlace != current.selectedPlace,
      listener: (context, state) {
        if (state.selectedPlace != null) {
           final index = state.annotations.indexWhere((a) => a.place.id == state.selectedPlace!.id);
           if (index != -1) {
             _scrollToIndex(index);
           }
        }
      },
      buildWhen: (previous, current) =>
          previous.annotations != current.annotations ||
          previous.selectedPlace != current.selectedPlace,
      builder: (context, state) {
        if (state.annotations.isEmpty) return const SizedBox.shrink();

        return SizedBox(
          height: 100.h,
          child: ListView.separated(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            scrollDirection: Axis.horizontal,
            itemCount: state.annotations.length,
            separatorBuilder: (context, index) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              final entry = state.annotations[index];
              final place = entry.place;
              final isSelected = state.selectedPlace?.id == place.id;
              
              return GestureDetector(
                onTap: () {
                   context.read<MapCubit>().selectPlace(place.id);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 220.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: isSelected ? Colors.blue : Colors.transparent,
                      width: 2.w,
                    ),
                    boxShadow: [AppShadows.mainElevationButton],
                  ),
                  padding: EdgeInsets.all(12.r),
                  child: Row(
                    children: [
                      // Badge/Color
                      Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: entry.periodColor ?? Colors.grey.shade200,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          entry.sequenceNumber.toString(),
                          style: AppTextStyles.h8Bold.copyWith(color: Colors.black87),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      // Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              place.name,
                              style: AppTextStyles.h8Bold,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              entry.periodLabel ?? place.category.name,
                              style: AppTextStyles.h9Medium.copyWith(color: Colors.grey.shade600),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
