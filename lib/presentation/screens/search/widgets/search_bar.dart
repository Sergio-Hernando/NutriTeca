import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final List<Map<String, dynamic>> allItems;
  final void Function(List<Map<String, dynamic>>) onResults;

  const CustomSearchBar(
      {required this.allItems, required this.onResults, Key? key})
      : super(key: key);

  @override
  CustomSearchBarState createState() => CustomSearchBarState();
}

class CustomSearchBarState extends State<CustomSearchBar> {
  List<Map<String, dynamic>> _foundItems = [];

  @override
  void initState() {
    super.initState();
    _foundItems = widget.allItems;
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _foundItems;
    } else {
      results = _foundItems
          .where((item) =>
              item["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
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
