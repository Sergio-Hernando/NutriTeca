import 'package:flutter/material.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';

class CustomSearchBar extends StatefulWidget {
  final List<AlimentEntity> allItems;
  final void Function(List<AlimentEntity>) onResults;

  const CustomSearchBar(
      {required this.allItems, required this.onResults, Key? key})
      : super(key: key);

  @override
  CustomSearchBarState createState() => CustomSearchBarState();
}

class CustomSearchBarState extends State<CustomSearchBar> {
  List<AlimentEntity> _foundItems = [];

  @override
  void initState() {
    super.initState();
    _foundItems = widget.allItems;
  }

  void _runFilter(String enteredKeyword) {
    List<AlimentEntity> results = [];
    if (enteredKeyword.isEmpty) {
      results = _foundItems;
    } else {
      results = _foundItems
          .where((item) =>
              item.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    widget.onResults(results);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SearchBar(
        onChanged: (value) => _runFilter(value),
        hintText: 'Search',
        leading: const Icon(Icons.search),
      ),
    );
  }
}
