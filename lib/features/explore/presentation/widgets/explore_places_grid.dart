import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/features/explore/presentation/widgets/explore_place_card.dart';

class ExplorePlacesGrid extends StatelessWidget {
  const ExplorePlacesGrid({super.key, required this.places});

  final List<PlaceModel> places;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: places.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 32.h,
        crossAxisSpacing: 24.w,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        return ExplorePlaceCard(place: places[index]);
      },
    );
  }
}
