import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/constants/app_assets.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/monthly_spent_entity.dart';
import 'package:food_macros/presentation/screens/recipes_feature/add_recipe/widgets/aliments_selection_dialog.dart';
import 'package:food_macros/presentation/screens/base_screen/bloc/base_screen_bloc.dart';
import 'package:food_macros/presentation/screens/base_screen/bloc/base_screen_event.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function() goHome;
  const CustomAppBar({
    super.key,
    required this.goHome,
  });

  void _showSelectAlimentDialog(BuildContext builContext) {
    final state = builContext.read<BaseScreenBloc>().state;

    if (state.screenStatus.isLoading()) {
      showDialog(
        context: builContext,
        builder: (context) => const AlertDialog(
          content: Text('Cargando alimentos...'),
        ),
      );
    } else if (state.screenStatus.isError()) {
      showDialog(
        context: builContext,
        builder: (context) => const AlertDialog(
          content: Text('Error al cargar alimentos'),
        ),
      );
    } else if (state.aliments.isEmpty) {
      showDialog(
        context: builContext,
        builder: (context) => const AlertDialog(
          content: Text('No hay alimentos disponibles'),
        ),
      );
    } else {
      showDialog(
        context: builContext,
        builder: (context) => AlimentSelectionDialog(
          aliments: state.aliments,
          onSelectAliment: (int alimentId, String name, int quantity) {
            builContext.read<BaseScreenBloc>().add(
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
        IconButton(
          icon: const Icon(
            Icons.shopping_bag_outlined,
            color: AppColors.foreground,
          ),
          onPressed: () => _showSelectAlimentDialog(context),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
