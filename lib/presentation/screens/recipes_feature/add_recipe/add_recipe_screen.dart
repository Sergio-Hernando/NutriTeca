import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/extensions/context_extension.dart';
import 'package:food_macros/core/extensions/string_extensions.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/domain/models/recipe_entity.dart';
import 'package:food_macros/presentation/screens/recipes_feature/add_recipe/bloc/add_recipe_bloc.dart';
import 'package:food_macros/presentation/screens/recipes_feature/add_recipe/bloc/add_recipe_event.dart';
import 'package:food_macros/presentation/widgets/aliments_selection_dialog.dart';
import 'package:food_macros/presentation/screens/recipes_feature/add_recipe/widgets/instructions_text_input.dart';
import 'package:food_macros/presentation/screens/recipes_feature/add_recipe/widgets/select_aliments_list.dart';
import 'package:food_macros/presentation/widgets/custom_text_field.dart';
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

  @override
  void initState() {
    super.initState();
    context.read<AddRecipeBloc>().add(const AddRecipeEvent.fetchAliments());
  }

  void _removeAliment(int alimentId) {
    setState(() {
      _selectedAliments.remove(alimentId);
    });
  }

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

  void _showSelectAlimentOverlay(BuildContext context) {
    final state = context.read<AddRecipeBloc>().state;

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
      showDialog(
        context: context,
        builder: (context) => AlimentSelectionDialog(
          aliments: state.aliments,
          onSelectAliment: _addAliment,
        ),
      );
    }
  }

  void _addAliment(int alimentId, String name, int quantity) {
    setState(() {
      _selectedAliments.add(AlimentEntity(
        id: alimentId,
        name: name,
        quantity: quantity.toString(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.foreground,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.background,
        title: Text(context.localizations.addRecipe),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: _recipeNameController,
              label: context.localizations.recipeName,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.016),
              child: InstructionsTextField(controller: _instructionsController),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.01),
              child: ElevatedButton(
                onPressed: () => _showSelectAlimentOverlay(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  context.localizations.addAliment,
                  style: const TextStyle(color: AppColors.foreground),
                ),
              ),
            ),
            Expanded(
              child: SelectedAlimentsList(
                selectedAliments: _selectedAliments,
                removeAliment: _removeAliment,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: _saveRecipe,
        backgroundColor: AppColors.secondary,
        child: const Icon(
          Icons.save_outlined,
          color: AppColors.foreground,
        ),
      ),
    );
  }
}
