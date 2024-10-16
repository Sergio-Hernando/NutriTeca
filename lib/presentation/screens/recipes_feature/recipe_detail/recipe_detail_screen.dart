import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/constants/app_theme.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/domain/models/recipe_entity.dart';
import 'package:food_macros/presentation/screens/recipes_feature/recipe_detail/bloc/recipe_detail_bloc.dart';
import 'package:food_macros/presentation/screens/recipes_feature/recipe_detail/bloc/recipe_detail_event.dart';
import 'package:food_macros/presentation/screens/recipes_feature/recipe_detail/bloc/recipe_detail_state.dart';
import 'package:food_macros/presentation/screens/recipes_feature/recipe_detail/widgets/aliments_table.dart';
import 'package:food_macros/presentation/screens/recipes_feature/recipe_detail/widgets/recipe_detail_header.dart';
import 'package:food_macros/presentation/widgets/floating_button_row.dart';
import 'package:go_router/go_router.dart';

class RecipeDetailScreen extends StatefulWidget {
  const RecipeDetailScreen({Key? key}) : super(key: key);

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  bool isEditing = false;
  Map<String, dynamic>? controllers;

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
    }
    setState(() {
      isEditing = !isEditing;
    });
  }

  void _toggleEditModeOff() {
    setState(() {
      isEditing = !isEditing;
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
              aliments: controllers?[
                  'aliments'], // Actualizamos la lista de alimentos
            ),
          ),
        );
  }

  void _removeAliment(AlimentEntity aliment) {
    setState(() {
      controllers?['aliments'].remove(aliment);
    });
  }

  void _addAliment() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.foreground,
      appBar: AppBar(
        title: Center(
          child: Text(
            controllers?['name'].text ?? '',
            style: AppTheme.titleTextStyle,
          ),
        ),
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        actions: [
          if (!isEditing)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.white),
              onPressed: () => context.read<RecipeDetailBloc>().add(
                  RecipeDetailEvent.deleteRecipe(
                      controllers?['recipe'].id ?? 0)),
            ),
        ],
      ),
      body: BlocBuilder<RecipeDetailBloc, RecipeDetailState>(
        builder: (context, state) {
          if (state.screenStatus.isLoading()) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.screenStatus.isError()) {
            return const Center(child: Text('Error al cargar la receta'));
          }

          if (state.recipe != null && controllers == null) {
            _initializeControllers(state.recipe as RecipeEntity);
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RecipeDetailHeader(
                  isEditing: isEditing,
                  controllers: controllers,
                ),
                const SizedBox(height: 16.0),
                if (controllers != null)
                  AlimentsTable(
                    aliments: controllers!['aliments'],
                    isEditing: isEditing,
                    onAddAliment: _addAliment,
                    onRemoveAliment: _removeAliment,
                  ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingButtonRow(
        isEditing: isEditing,
        toggleEditModeOn: _toggleEditModeOn,
        toggleEditModeOff: _toggleEditModeOff,
      ),
    );
  }
}
