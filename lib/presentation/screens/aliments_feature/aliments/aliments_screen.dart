import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutri_teca/core/constants/app_colors.dart';
import 'package:nutri_teca/core/extensions/context_extension.dart';
import 'package:nutri_teca/core/types/screen_status.dart';
import 'package:nutri_teca/presentation/screens/aliments_feature/aliments/bloc/aliments_bloc.dart';
import 'package:nutri_teca/presentation/screens/aliments_feature/aliments/bloc/aliments_state.dart';
import 'package:nutri_teca/presentation/screens/aliments_feature/aliments/widgets/filter_chips.dart';
import 'package:nutri_teca/presentation/screens/aliments_feature/aliments/widgets/aliment_list.dart';
import 'package:nutri_teca/presentation/screens/aliments_feature/aliments/widgets/searchbar_filters_row.dart';

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
            return Center(
              child: Text(context.localizations.errorLoadingData),
            );
          }

          final foundAliments = state.aliments;

          return Column(
            mainAxisSize: MainAxisSize.min,
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
    );
  }
}
