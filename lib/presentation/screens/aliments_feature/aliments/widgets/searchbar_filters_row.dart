import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutri_teca/core/extensions/context_extension.dart';
import 'package:nutri_teca/domain/models/aliment_entity.dart';
import 'package:nutri_teca/domain/models/filters_entity.dart';
import 'package:nutri_teca/presentation/screens/aliments_feature/aliments/bloc/aliments_bloc.dart';
import 'package:nutri_teca/presentation/screens/aliments_feature/aliments/bloc/aliments_event.dart';
import 'package:nutri_teca/presentation/widgets/generic_search_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:nutri_teca/core/routes/app_paths.dart';

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
            child: GenericSearchBar<AlimentEntity>(
              allItems: allItems,
              getItemName: (AlimentEntity item) => item.name ?? '',
              onResults: (results, enteredKeyword) {
                context
                    .read<AlimentsBloc>()
                    .add(AlimentsEvent.updateSearch(results, enteredKeyword));
              },
              hintText: context.localizations.searchAliment,
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
