import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/extensions/string_extensions.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/domain/models/recipe_entity.dart';
import 'package:food_macros/presentation/screens/add_product/widgets/custom_text_field.dart';
import 'package:food_macros/presentation/screens/add_recipe/bloc/add_recipe_bloc.dart';
import 'package:food_macros/presentation/screens/add_recipe/bloc/add_recipe_event.dart';
import 'package:food_macros/presentation/screens/add_recipe/widgets/aliments_selection_dialog.dart';
import 'package:food_macros/presentation/screens/add_recipe/widgets/instructions_text_input.dart';
import 'package:food_macros/presentation/screens/add_recipe/widgets/select_aliments_list.dart';
import 'package:go_router/go_router.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({Key? key}) : super(key: key);

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
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
        const SnackBar(
          content: Text(
              'Por favor, completa el nombre y añade al menos un alimento.'),
        ),
      );
    }
  }

  void _showSelectAlimentOverlay() {
    final state = context.read<AddRecipeBloc>().state;

    if (state.screenStatus.isLoading()) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          content: Text('Cargando alimentos...'),
        ),
      );
    } else if (state.screenStatus.isError()) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          content: Text('Error al cargar alimentos'),
        ),
      );
    } else if (state.aliments.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          content: Text('No hay alimentos disponibles'),
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
        title: const Text('Añadir Receta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: _recipeNameController,
              label: 'Nombre de la receta',
            ),
            const SizedBox(height: 16.0),
            InstructionsTextField(controller: _instructionsController),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _showSelectAlimentOverlay,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text(
                'Añadir Alimento',
                style: TextStyle(color: AppColors.foreground),
              ),
            ),
            const SizedBox(height: 16.0),
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
