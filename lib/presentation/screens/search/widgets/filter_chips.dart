import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/domain/models/filters_entity.dart';
import 'package:food_macros/presentation/screens/search/bloc/search_bloc.dart';
import 'package:food_macros/presentation/screens/search/bloc/search_event.dart';

class FilterChips extends StatefulWidget {
  final FiltersEntity activeFilters;

  const FilterChips({Key? key, required this.activeFilters}) : super(key: key);

  @override
  State<FilterChips> createState() => _FilterChipsState();
}

class _FilterChipsState extends State<FilterChips> {
  FiltersEntity _activeFilters = FiltersEntity(
      highFats: false,
      highProteins: false,
      highCarbohydrates: false,
      highCalories: false);

  void _removeFilter(String filterType) {
    setState(() {
      switch (filterType) {
        case "highFats":
          _activeFilters = _activeFilters.copyWith(highFats: false);
          break;
        case "highProteins":
          _activeFilters = _activeFilters.copyWith(highProteins: false);
          break;
        case "highCarbohydrates":
          _activeFilters = _activeFilters.copyWith(highCarbohydrates: false);
          break;
        case "highCalories":
          _activeFilters = _activeFilters.copyWith(highCalories: false);
          break;
        case "supermarket":
          _activeFilters = _activeFilters.copyWith(supermarket: null);
          break;
      }
    });

    // Actualiza el estado del BLoC con los filtros modificados
    context.read<SearchBloc>().add(SearchEvent.updateFilters(_activeFilters));

    // Vuelve a aplicar los filtros o reinicia si están todos desactivados
    if (_activeFilters.isEmpty()) {
      context.read<SearchBloc>().add(const SearchEvent.resetFilters());
    } else {
      context.read<SearchBloc>().add(SearchEvent.applyFilters(_activeFilters));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: [
        if (widget.activeFilters.highFats)
          Chip(
            label: const Text('High Fats'),
            onDeleted: () => _removeFilter("highFats"),
          ),
        if (widget.activeFilters.highProteins)
          Chip(
            label: const Text('High Proteins'),
            onDeleted: () => _removeFilter("highProteins"),
          ),
        if (widget.activeFilters.highCarbohydrates)
          Chip(
            label: const Text('High Carbohydrates'),
            onDeleted: () => _removeFilter("highCarbohydrates"),
          ),
        if (widget.activeFilters.highCalories)
          Chip(
            label: const Text('High Calories'),
            onDeleted: () => _removeFilter("highCalories"),
          ),
        if (widget.activeFilters.supermarket != null &&
            widget.activeFilters.supermarket!.isNotEmpty)
          Chip(
            label: Text('Supermarket: ${widget.activeFilters.supermarket}'),
            onDeleted: () => _removeFilter("supermarket"),
          ),
      ],
    );
  }
}
