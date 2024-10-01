class FiltersEntity {
  bool highFats;
  bool highProteins;
  bool highCarbohydrates;
  bool highCalories;
  String? supermarket;

  FiltersEntity({
    required this.highFats,
    required this.highProteins,
    required this.highCarbohydrates,
    required this.highCalories,
    this.supermarket,
  });

  @override
  String toString() {
    return 'Filters{highFats: $highFats, highProteins: $highProteins, highCarbohydrates: $highCarbohydrates, highCalories: $highCalories, supermarket: $supermarket}';
  }
}
