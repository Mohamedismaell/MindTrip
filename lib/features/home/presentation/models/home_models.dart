
class PlannerStop {
  final String time;
  final String label;

  const PlannerStop({
    required this.time,
    required this.label,
  });
}

class PlannerPreview {
  final String title;
  final String imageUrl;
  final List<PlannerStop> stops;
  final String badge;

  const PlannerPreview({
    required this.title,
    required this.imageUrl,
    required this.stops,
    required this.badge,
  });
}
