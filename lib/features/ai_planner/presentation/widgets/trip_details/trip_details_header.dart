import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/widget/custom_head_line.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';

class TripDetailsHeader extends StatelessWidget {
  final Trip trip;

  const TripDetailsHeader({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go(AppRoutes.myTrips),
        ),
        CustomHeadLine(firstTitle: "Trip ", secondTitle: "Details"),
        IconButton(
          icon: const Icon(Icons.share_outlined, color: Colors.white),
          onPressed: () {
            //Todo search for shearing
          },
        ),
      ],
    );
  }
}
