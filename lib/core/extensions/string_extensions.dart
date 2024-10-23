extension StringCapitalization on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  int? parseToInt() {
    try {
      return int.tryParse(this);
    } catch (e) {
      return null;
    }
  }
}
