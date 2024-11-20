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

  FiltersEntity copyWith({
    bool? highFats,
    bool? highProteins,
    bool? highCarbohydrates,
    bool? highCalories,
    String? supermarket,
  }) {
    return FiltersEntity(
      highFats: highFats ?? this.highFats,
      highProteins: highProteins ?? this.highProteins,
      highCarbohydrates: highCarbohydrates ?? this.highCarbohydrates,
      highCalories: highCalories ?? this.highCalories,
      supermarket: supermarket ?? this.supermarket,
    );
  }

  bool isEmpty() {
    return !highFats &&
        !highProteins &&
        !highCarbohydrates &&
        !highCalories &&
        (supermarket == null || supermarket!.isEmpty);
  }
}
