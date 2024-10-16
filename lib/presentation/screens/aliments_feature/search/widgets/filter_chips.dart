import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/domain/models/filters_entity.dart';
import 'package:food_macros/presentation/screens/aliments_feature/search/bloc/search_bloc.dart';
import 'package:food_macros/presentation/screens/aliments_feature/search/bloc/search_event.dart';

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

    context.read<SearchBloc>().add(SearchEvent.updateFilters(_activeFilters));

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
          _buildStyledChip(
            'High Fats',
            'highFats',
          ),
        if (widget.activeFilters.highProteins)
          _buildStyledChip(
            'High Proteins',
            'highProteins',
          ),
        if (widget.activeFilters.highCarbohydrates)
          _buildStyledChip(
            'High Carbohydrates',
            'highCarbohydrates',
          ),
        if (widget.activeFilters.highCalories)
          _buildStyledChip(
            'High Calories',
            'highCalories',
          ),
        if (widget.activeFilters.supermarket != null &&
            widget.activeFilters.supermarket!.isNotEmpty)
          _buildStyledChip('Supermarket: ${widget.activeFilters.supermarket}',
              'supermarket'),
      ],
    );
  }

  Widget _buildStyledChip(String label, String filterType) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(
          color: AppColors.foreground,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
      deleteIcon: const Icon(Icons.cancel, color: Colors.white),
      onDeleted: () => _removeFilter(filterType),
      backgroundColor: AppColors.secondaryAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side:
            BorderSide(color: AppColors.foreground.withOpacity(0.3), width: 1),
      ),
      elevation: 8.0,
      shadowColor: Colors.black38,
    );
  }
}
