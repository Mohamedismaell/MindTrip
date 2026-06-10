class PlannerStopEntity {
  final String time;
  final String label;

  const PlannerStopEntity({required this.time, required this.label});
}

class PlannerPreviewEntity {
  final String title;
  final String imageUrl;
  final List<PlannerStopEntity> stops;
  final String badge;

  const PlannerPreviewEntity({
    required this.title,
    required this.imageUrl,
    required this.stops,
    required this.badge,
  });
}
