class ExploreTab {
  final String label;
  final bool isSelected;

  const ExploreTab({required this.label, this.isSelected = false});

  ExploreTab copyWith({bool? isSelected}) =>
      ExploreTab(label: label, isSelected: isSelected ?? this.isSelected);
}
