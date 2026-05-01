class SuggestionModel {
  final String name;
  final String mapboxId;

  SuggestionModel({required this.name, required this.mapboxId});

  factory SuggestionModel.fromMapbox(dynamic e) {
    return SuggestionModel(name: e.name, mapboxId: e.mapboxId);
  }
}
