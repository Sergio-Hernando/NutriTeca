import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/constants/app_theme.dart';
import 'package:food_macros/core/routes/app_paths.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/domain/models/filters_entity.dart';
import 'package:food_macros/presentation/screens/search/bloc/search_bloc.dart';
import 'package:food_macros/presentation/screens/search/bloc/search_event.dart';
import 'package:food_macros/presentation/screens/search/bloc/search_state.dart';
import 'package:food_macros/presentation/screens/search/widgets/product_card.dart';
import 'package:food_macros/presentation/screens/search/widgets/search_bar.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  FiltersEntity _activeFilters = FiltersEntity(
      highFats: false,
      highProteins: false,
      highCarbohydrates: false,
      highCalories: false);

  void _applyFilters(FiltersEntity? filters) {
    if (filters != null) {
      setState(() {
        _activeFilters = filters;
      });
      context.read<SearchBloc>().add(SearchEvent.applyFilters(filters));
    }
  }

  void _removeFilter(String filterType) {
    setState(() {
      switch (filterType) {
        case "highFats":
          _activeFilters.highFats = false;
          break;
        case "highProteins":
          _activeFilters.highProteins = false;
          break;
        case "highCarbohydrates":
          _activeFilters.highCarbohydrates = false;
          break;
        case "highCalories":
          _activeFilters.highCalories = false;
          break;
        case "supermarket":
          _activeFilters.supermarket = '';
          break;
      }
    });
    context.read<SearchBloc>().add(SearchEvent.applyFilters(_activeFilters));
  }

  void _onPressed(AlimentEntity aliment) {
    // Acción al hacer clic en un alimento
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.foreground,
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state.screenStatus.isLoading()) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.screenStatus.isError()) {
            return const Center(child: Text('Error loading data'));
          }

          // La lista de alimentos se obtiene directamente del estado del BLoC
          final _foundAliments = state.aliments;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CustomSearchBar(
                        allItems: _foundAliments, // Usamos la lista filtrada
                        onResults: (results) {
                          // Manejamos los resultados de la búsqueda
                          context
                              .read<SearchBloc>()
                              .add(SearchEvent.updateSearch(results));
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        final selectedFilters = await context.push(
                            AppRoutesPath.filters,
                            extra: _foundAliments) as FiltersEntity?;
                        if (selectedFilters != null) {
                          _applyFilters(selectedFilters);
                        }
                      },
                      icon: const Icon(Icons.tune),
                      iconSize: AppTheme.titleFontSize,
                    ),
                  ],
                ),
              ),
              Wrap(
                spacing: 8.0,
                children: [
                  if (_activeFilters.highFats)
                    Chip(
                      label: const Text('High Fats'),
                      onDeleted: () {
                        _removeFilter("highFats");
                      },
                    ),
                  if (_activeFilters.highProteins)
                    Chip(
                      label: const Text('High Proteins'),
                      onDeleted: () {
                        _removeFilter("highProteins");
                      },
                    ),
                  if (_activeFilters.highCarbohydrates)
                    Chip(
                      label: const Text('High Carbohydrates'),
                      onDeleted: () {
                        _removeFilter("highCarbohydrates");
                      },
                    ),
                  if (_activeFilters.highCalories)
                    Chip(
                      label: const Text('High Calories'),
                      onDeleted: () {
                        _removeFilter("highCalories");
                      },
                    ),
                  if (_activeFilters.supermarket != null &&
                      _activeFilters.supermarket!.isNotEmpty)
                    Chip(
                      label: Text('Supermarket: ${_activeFilters.supermarket}'),
                      onDeleted: () {
                        _removeFilter("supermarket");
                      },
                    ),
                ],
              ),
              Expanded(
                child: _foundAliments.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ListView.builder(
                          itemCount: _foundAliments.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () => _onPressed(_foundAliments[index]),
                            child: CustomCard(
                              imagePath: _foundAliments[index].imageBase64,
                              text: _foundAliments[index].name,
                              icon: Icons.chevron_right,
                            ),
                          ),
                        ),
                      )
                    : Text(
                        'No results found',
                        style: AppTheme.bodyTextStyle
                            .copyWith(color: AppColors.secondary),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
