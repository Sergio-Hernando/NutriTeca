import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutri_teca/core/extensions/context_extension.dart';
import 'package:nutri_teca/core/extensions/string_extensions.dart';
import 'package:nutri_teca/domain/models/aliment_entity.dart';
import 'package:nutri_teca/domain/models/recipe_entity.dart';
import 'package:nutri_teca/presentation/screens/recipes_feature/add_recipe/bloc/add_recipe_bloc.dart';
import 'package:nutri_teca/presentation/screens/recipes_feature/add_recipe/bloc/add_recipe_event.dart';
import 'package:nutri_teca/presentation/screens/recipes_feature/add_recipe/widgets/add_recipe_form.dart';
import 'package:nutri_teca/presentation/widgets/base_add_screen.dart';
import 'package:go_router/go_router.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({Key? key}) : super(key: key);

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();
  final List<AlimentEntity> _selectedAliments = [];

  void _saveRecipe() {
    if (_recipeNameController.text.isNotEmpty && _selectedAliments.isNotEmpty) {
      final recipeRequest = RecipeEntity(
          name: _recipeNameController.text.capitalize(),
          instructions: _instructionsController.text,
          aliments: _selectedAliments);

      context.read<AddRecipeBloc>().add(
            AddRecipeEvent.addRecipe(recipe: recipeRequest),
          );
      context.pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.localizations.addOneAliment),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseAddScreen(
        body: AddRecipeForm(
          recipeNameController: _recipeNameController,
          instructionsController: _instructionsController,
          selectedAliments: _selectedAliments,
        ),
        onPressed: _saveRecipe,
        title: context.localizations.addRecipe);
  }
}
