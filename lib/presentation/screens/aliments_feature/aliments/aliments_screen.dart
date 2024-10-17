import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/routes/app_paths.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/presentation/screens/aliments_feature/aliments/bloc/aliments_bloc.dart';
import 'package:food_macros/presentation/screens/aliments_feature/aliments/bloc/aliments_state.dart';
import 'package:food_macros/presentation/screens/aliments_feature/aliments/widgets/filter_chips.dart';
import 'package:food_macros/presentation/screens/aliments_feature/aliments/widgets/aliment_list.dart';
import 'package:food_macros/presentation/screens/aliments_feature/aliments/widgets/searchbar_filters_row.dart';
import 'package:go_router/go_router.dart';

class AlimentsScreen extends StatelessWidget {
  const AlimentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.foreground,
      body: BlocBuilder<AlimentsBloc, AlimentsState>(
        builder: (context, state) {
          if (state.screenStatus.isLoading()) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.screenStatus.isError()) {
            return const Center(
              child: Text('Error loading data'),
            );
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
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () => context.push(AppRoutesPath.addAliment),
        backgroundColor: AppColors.secondary,
        child: const Icon(
          Icons.add,
          color: AppColors.foreground,
        ),
      ),
    );
  }
}
