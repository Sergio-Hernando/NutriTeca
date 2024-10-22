import 'package:flutter/material.dart';

class GenericSearchBar<T> extends StatefulWidget {
  final List<T> allItems;
  final String Function(T) getItemName;
  final void Function(List<T>) onResults;
  final String hintText;

  const GenericSearchBar({
    required this.allItems,
    required this.getItemName,
    required this.onResults,
    required this.hintText,
    Key? key,
  }) : super(key: key);

  @override
  State<GenericSearchBar<T>> createState() => _GenericSearchBarState<T>();
}

class _GenericSearchBarState<T> extends State<GenericSearchBar<T>> {
  List<T> _foundItems = [];

  @override
  void initState() {
    super.initState();
    _foundItems = widget.allItems;
  }

  void _runFilter(String enteredKeyword) {
    List<T> results = [];
    if (enteredKeyword.isEmpty) {
      results = _foundItems;
    } else {
      results = _foundItems
          .where((item) => widget
              .getItemName(item)
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
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
        hintText: widget.hintText,
        leading: const Icon(Icons.search),
      ),
    );
  }
}
