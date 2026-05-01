import 'package:equatable/equatable.dart';

class SearchSuggestion extends Equatable {
  final String mapboxId;
  final String name;
  final String? fullAddress;

  const SearchSuggestion({
    required this.mapboxId,
    required this.name,
    this.fullAddress,
  });

  @override
  List<Object?> get props => [mapboxId, name, fullAddress];
}
