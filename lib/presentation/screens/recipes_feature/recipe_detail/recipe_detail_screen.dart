import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/extensions/context_extension.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/domain/models/recipe_entity.dart';
import 'package:food_macros/presentation/widgets/aliments_selection_dialog.dart';
import 'package:food_macros/presentation/screens/recipes_feature/recipe_detail/bloc/recipe_detail_bloc.dart';
import 'package:food_macros/presentation/screens/recipes_feature/recipe_detail/bloc/recipe_detail_event.dart';
import 'package:food_macros/presentation/screens/recipes_feature/recipe_detail/bloc/recipe_detail_state.dart';
import 'package:food_macros/presentation/screens/recipes_feature/recipe_detail/widgets/aliments_table.dart';
import 'package:food_macros/presentation/screens/recipes_feature/recipe_detail/widgets/recipe_detail_header.dart';
import 'package:food_macros/presentation/widgets/common_detail_screen.dart';

class RecipeDetailScreen extends StatefulWidget {
  const RecipeDetailScreen({Key? key}) : super(key: key);

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  bool isEditing = false;
  Map<String, dynamic>? controllers;
  List<AlimentEntity>? _originalAliments;

  void _initializeControllers(RecipeEntity recipe) {
    controllers = {
      'recipe': recipe,
      'name': TextEditingController(text: recipe.name),
      'instructions': TextEditingController(text: recipe.instructions),
      'aliments': List<AlimentEntity>.from(recipe.aliments ?? []),
    };
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _disposeControllers() {
    if (controllers != null) {
      controllers?.forEach((key, controller) {
        if (controller is TextEditingController) {
          controller.dispose();
        }
      });
    }
  }

  void _toggleEditModeOn() {
    if (isEditing) {
      _updateRecipe();
    } else {
      _originalAliments = List<AlimentEntity>.from(controllers?['aliments']);
    }
    setState(() {
      isEditing = !isEditing;
    });
  }

  void _toggleEditModeOff() {
    if (isEditing) {
      setState(() {
        controllers?['aliments'] =
            List<AlimentEntity>.from(_originalAliments ?? []);
      });
    }
    setState(() {
      isEditing = false;
    });
  }

  void _updateRecipe() {
    context.read<RecipeDetailBloc>().add(
          RecipeDetailEvent.editRecipe(
            RecipeEntity(
              id: controllers?['recipe'].id,
              name: (controllers?['name'] as TextEditingController).text,
              instructions:
                  (controllers?['instructions'] as TextEditingController).text,
              aliments: controllers?['aliments'],
            ),
          ),
        );
  }

  void _removeAliment(AlimentEntity aliment) {
    setState(() {
      controllers?['aliments'].remove(aliment);
    });
  }

  void _showSelectAlimentOverlay() {
    final state = context.read<RecipeDetailBloc>().state;

    if (state.screenStatus.isLoading()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(context.localizations.alimentsLoading),
        ),
      );
    } else if (state.screenStatus.isError()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(context.localizations.alimentsError),
        ),
      );
    } else if (state.aliments.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(context.localizations.alimentsNotAvailable),
        ),
      );
    } else {
      final List<AlimentEntity> addedAliments = controllers?['aliments'] ?? [];

      final List<AlimentEntity> availableAliments =
          state.aliments.where((aliment) {
        return !addedAliments
            .any((addedAliment) => addedAliment.id == aliment.id);
      }).toList();

      showDialog(
        context: context,
        builder: (context) => AlimentSelectionDialog(
          aliments: availableAliments,
          onSelectAliment: _addAlimentFromSelection,
        ),
      );
    }
  }

  void _addAlimentFromSelection(int alimentId, String name, int quantity) {
    setState(() {
      controllers?['aliments'].add(AlimentEntity(
        id: alimentId,
        name: name,
        quantity: quantity.toString(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeDetailBloc, RecipeDetailState>(
      builder: (context, state) {
        if (state.screenStatus.isLoading()) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.screenStatus.isError()) {
          return Center(child: Text(context.localizations.recipeError));
        }

        if (state.recipe != null && controllers == null) {
          _initializeControllers(state.recipe as RecipeEntity);
        }

        if (controllers == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return CommonDetailScreen(
          title: controllers?['name']?.text ?? context.localizations.recipe,
          onDelete: () => context.read<RecipeDetailBloc>().add(
              RecipeDetailEvent.deleteRecipe(controllers?['recipe'].id ?? 0)),
          onEditOn: _toggleEditModeOn,
          onEditOff: _toggleEditModeOff,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RecipeDetailHeader(
                  isEditing: isEditing,
                  controllers: controllers,
                ),
                AlimentsTable(
                  aliments: controllers?['aliments'],
                  isEditing: isEditing,
                  onAddAliment: _showSelectAlimentOverlay,
                  onRemoveAliment: _removeAliment,
                ),
              ],
            ),
          ),
          isEditing: isEditing,
        );
      },
    );
  }
}
