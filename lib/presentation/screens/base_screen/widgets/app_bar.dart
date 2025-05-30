import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutri_teca/core/constants/app_assets.dart';
import 'package:nutri_teca/core/constants/app_colors.dart';
import 'package:nutri_teca/core/extensions/context_extension.dart';
import 'package:nutri_teca/core/types/screen_status.dart';
import 'package:nutri_teca/domain/models/monthly_spent_entity.dart';
import 'package:nutri_teca/presentation/widgets/aliments_selection_dialog.dart';
import 'package:nutri_teca/presentation/screens/base_screen/bloc/base_screen_bloc.dart';
import 'package:nutri_teca/presentation/screens/base_screen/bloc/base_screen_event.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function() goHome;
  final int screenIndex;
  const CustomAppBar({
    super.key,
    required this.goHome,
    required this.screenIndex,
  });

  void _showSelectAlimentDialog(BuildContext buildContext) {
    final state = buildContext.read<BaseScreenBloc>().state;

    if (state.screenStatus.isLoading()) {
      showDialog(
        context: buildContext,
        builder: (context) => AlertDialog(
          content: Text(context.localizations.alimentsLoading),
        ),
      );
    } else if (state.screenStatus.isError()) {
      showDialog(
        context: buildContext,
        builder: (context) => AlertDialog(
          content: Text(context.localizations.alimentsError),
        ),
      );
    } else if (state.aliments.isEmpty) {
      showDialog(
        context: buildContext,
        builder: (context) => AlertDialog(
          content: Text(context.localizations.alimentsNotAvailable),
        ),
      );
    } else {
      showDialog(
        context: buildContext,
        builder: (context) => AlimentSelectionDialog(
          aliments: state.aliments,
          onSelectAliment: (int alimentId, String name, int quantity) {
            buildContext.read<BaseScreenBloc>().add(
                  BaseScreenEvent.addMonthlySpent(MonthlySpentEntity(
                    alimentId: alimentId,
                    alimentName: name,
                    date: DateTime.now().toIso8601String(),
                    quantity: quantity,
                  )),
                );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      leading: IconButton(
        icon: const Image(
          image: AssetImage(AppAssets.mainLogo),
        ),
        onPressed: goHome,
      ),
      actions: <Widget>[
        screenIndex == 1
            ? IconButton(
                icon: const Icon(
                  Icons.shopping_bag_outlined,
                  color: AppColors.foreground,
                ),
                onPressed: () => _showSelectAlimentDialog(context),
              )
            : const SizedBox(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
