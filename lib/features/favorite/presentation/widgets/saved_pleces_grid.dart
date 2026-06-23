import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/utils/dummy_data.dart';
import 'package:mindtrip/core/shared/presentation/widget/place_card_vartical_grid.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SavedPlacesGrid extends StatelessWidget {
  const SavedPlacesGrid({
    super.key,
    required this.places,
    this.loading = false,
  });

  final List<PlaceEntity> places;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final data = loading ? DummyData.exploreCardPlaces : places;

    return Skeletonizer(
      enabled: loading,
      child: GridView.builder(
        itemCount: data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 30.h,
          crossAxisSpacing: 21.w,
          childAspectRatio: .65,
        ),
        itemBuilder: (context, index) {
          final place = data[index];
          return PlaceCardVarticalGrid(
            key: ValueKey(place.id),
            place: place,
            hasBadge: false,
            heroPrefix: loading ? 'saved_loading' : 'saved',
          );
        },
      ),
    );
  }
}
