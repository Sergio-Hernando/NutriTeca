import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutri_teca/core/constants/app_colors.dart';
import 'package:nutri_teca/core/extensions/context_extension.dart';
import 'package:nutri_teca/core/extensions/string_extensions.dart';
import 'package:nutri_teca/core/types/screen_status.dart';
import 'package:nutri_teca/domain/models/aliment_entity.dart';
import 'package:nutri_teca/domain/models/recipe_entity.dart';
import 'package:nutri_teca/presentation/screens/recipes_feature/add_recipe/bloc/add_recipe_bloc.dart';
import 'package:nutri_teca/presentation/screens/recipes_feature/add_recipe/bloc/add_recipe_event.dart';
import 'package:nutri_teca/presentation/widgets/aliments_selection_dialog.dart';
import 'package:nutri_teca/presentation/screens/recipes_feature/add_recipe/widgets/instructions_text_input.dart';
import 'package:nutri_teca/presentation/screens/recipes_feature/add_recipe/widgets/select_aliments_list.dart';
import 'package:nutri_teca/presentation/widgets/custom_text_field.dart';

class AddRecipeForm extends StatefulWidget {
  const AddRecipeForm({
    Key? key,
  }) : super(key: key);

  @override
  State<AddRecipeForm> createState() => AddRecipeFormState();
}

class AddRecipeFormState extends State<AddRecipeForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();
  final List<AlimentEntity> _selectedAliments = [];
  bool isFormValid = false;

  void validateForm() {
    setState(() {
      isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<AddRecipeBloc>().add(const AddRecipeEvent.fetchAliments());
  }

  void _removeAliment(int alimentId) {
    setState(() {
      _selectedAliments.removeWhere((aliment) => aliment.id == alimentId);
    });
  }

  String? validateRequiredField(String? value, BuildContext context) {
    return value == null || value.isEmpty
        ? context.localizations.fieldRequired
        : null;
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

  void saveRecipe() {
    if ((_formKey.currentState?.validate() ?? false) &&
        _selectedAliments.isNotEmpty) {
      final recipeRequest = RecipeEntity(
        name: _recipeNameController.text.capitalize(),
        instructions: _instructionsController.text,
        aliments: _selectedAliments,
      );

      context.read<AddRecipeBloc>().add(
            AddRecipeEvent.addRecipe(recipe: recipeRequest),
          );
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        onChanged: validateForm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: _recipeNameController,
              label: context.localizations.recipeName,
              validator: (value) => validateRequiredField(value, context),
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
    );
  }
}
