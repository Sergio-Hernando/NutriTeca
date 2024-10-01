import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/presentation/screens/search/bloc/search_bloc.dart';
import 'package:food_macros/presentation/screens/search/bloc/search_state.dart';
import 'package:food_macros/presentation/screens/search/widgets/filter_chips.dart';
import 'package:food_macros/presentation/screens/search/widgets/aliment_list.dart';
import 'package:food_macros/presentation/screens/search/widgets/searchbar_filters_row.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.foreground,
      body: BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
        if (state.screenStatus.isLoading()) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.screenStatus.isError()) {
          return const Center(child: Text('Error loading data'));
        }

        final foundAliments = state.aliments;

        return Column(
          children: [
            SearchBarWidget(
              allItems: foundAliments,
            ),
            FilterChips(
              activeFilters: state.filters,
            ),
            Expanded(
              child: AlimentList(
                aliments: foundAliments,
              ),
            ),
          ],
        );
      }),
    );
  }
}
