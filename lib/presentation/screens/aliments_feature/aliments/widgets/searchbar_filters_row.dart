import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/domain/models/filters_entity.dart';
import 'package:food_macros/presentation/screens/aliments_feature/aliments/bloc/aliments_bloc.dart';
import 'package:food_macros/presentation/screens/aliments_feature/aliments/bloc/aliments_event.dart';
import 'package:food_macros/presentation/screens/aliments_feature/aliments/widgets/aliment_search_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:food_macros/core/routes/app_paths.dart';

class SearchBarWidget extends StatelessWidget {
  final List<AlimentEntity> allItems;

  const SearchBarWidget({Key? key, required this.allItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: AlimentSearchBar(
              allItems: allItems,
              onResults: (results) {
                context
                    .read<AlimentsBloc>()
                    .add(AlimentsEvent.updateSearch(results));
              },
            ),
          ),
          IconButton(
            onPressed: () async {
              final currentContext = context;

              final selectedFilters = await currentContext.push(
                  AppRoutesPath.filters,
                  extra: allItems) as FiltersEntity?;

              if (selectedFilters != null && currentContext.mounted) {
                currentContext
                    .read<AlimentsBloc>()
                    .add(AlimentsEvent.updateFilters(selectedFilters));
                currentContext
                    .read<AlimentsBloc>()
                    .add(AlimentsEvent.applyFilters(selectedFilters));
              }
            },
            icon: const Icon(Icons.tune),
            iconSize: 36.0,
          ),
        ],
      ),
    );
  }
}
