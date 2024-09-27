import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/constants/app_theme.dart';
import 'package:food_macros/core/routes/app_paths.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/presentation/screens/search/bloc/search_bloc.dart';
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
  List<AlimentEntity> _foundAliments = []; // Lista de resultados de búsqueda
  List<AlimentEntity> _allAliments = []; // Lista completa de alimentos

  // Actualizar los resultados de la barra de búsqueda
  void _updateResults(List<AlimentEntity> results) {
    setState(() {
      _foundAliments = results;
    });
  }

  // Inicializa la lista de alimentos cuando se cargan por primera vez
  void _initializeAliments(List<AlimentEntity> aliments) {
    if (_allAliments.isEmpty) {
      _allAliments = aliments;
      _foundAliments = aliments; // Mostrar todos inicialmente
    }
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
          } else {
            // Inicializar la lista de alimentos si no se ha hecho
            _initializeAliments(state.aliments);

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomSearchBar(
                          allItems:
                              _allAliments, // Pasa la lista completa a la barra de búsqueda
                          onResults: (results) => _updateResults(
                              results), // Actualiza los resultados
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          final filteredAliments = await context.push(
                            AppRoutesPath.filters,
                            extra:
                                _allAliments, // Pasar la lista completa al filtro
                          ) as List<AlimentEntity>?;

                          if (filteredAliments != null) {
                            setState(() {
                              _foundAliments = filteredAliments;
                              _allAliments =
                                  filteredAliments; // Actualizar la lista completa para buscar sobre ella
                            });
                          }
                        },
                        icon: const Icon(Icons.tune),
                        iconSize: AppTheme.titleFontSize,
                      ),
                    ],
                  ),
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
          }
        },
      ),
    );
  }
}
