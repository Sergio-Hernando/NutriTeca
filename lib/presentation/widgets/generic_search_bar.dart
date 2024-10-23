import 'package:flutter/material.dart';

class GenericSearchBar<T> extends StatefulWidget {
  final List<T> allItems;
  final String Function(T) getItemName;
  final void Function(List<T>, String) onResults;
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

  @override
  void didUpdateWidget(GenericSearchBar<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.allItems != widget.allItems) {
      setState(() {
        _foundItems = widget.allItems;
      });
    }
  }

  void _runFilter(String enteredKeyword) {
    List<T> results = [];

    if (enteredKeyword.isEmpty) {
      results = widget.allItems;
    } else {
      results = _foundItems.where((item) {
        return widget
            .getItemName(item)
            .toLowerCase()
            .contains(enteredKeyword.toLowerCase());
      }).toList();
    }

    widget.onResults(results, enteredKeyword);
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
