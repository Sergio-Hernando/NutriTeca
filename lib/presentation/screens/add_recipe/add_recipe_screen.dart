import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/presentation/screens/add_product/widgets/custom_text_field.dart';
import 'package:food_macros/presentation/screens/recipes/bloc/recipe_bloc.dart';
import 'package:food_macros/presentation/screens/recipes/bloc/recipe_event.dart';
import 'package:food_macros/presentation/screens/recipes/bloc/recipe_state.dart';
import 'package:go_router/go_router.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({Key? key}) : super(key: key);

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final TextEditingController _recipeNameController = TextEditingController();
  final Map<int, int> _selectedAliments = {};

  @override
  void initState() {
    super.initState();
    context.read<RecipeBloc>().add(const RecipeEvent.getAliments());
  }

  void _removeAliment(int alimentId) {
    setState(() {
      _selectedAliments.remove(alimentId);
    });
  }

  void _saveRecipe() {
    if (_recipeNameController.text.isNotEmpty && _selectedAliments.isNotEmpty) {
      context.read<RecipeBloc>().add(RecipeEvent.saveRecipe(
            recipeName: _recipeNameController.text,
            aliments: _selectedAliments.entries
                .map((entry) => {'id': entry.key, 'quantity': entry.value})
                .toList(),
          ));
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
    final TextEditingController quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Seleccionar Alimento'),
          content: BlocBuilder<RecipeBloc, RecipeState>(
            builder: (context, state) {
              if (state.screenStatus.isLoading()) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.screenStatus.isError()) {
                return const Center(child: Text('Error al cargar alimentos'));
              }
              if (state.aliments.isEmpty) {
                return const Center(
                    child: Text('No hay alimentos disponibles'));
              }

              return SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Campo para ingresar la cantidad
                    TextField(
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Cantidad',
                      ),
                    ),
                    const SizedBox(
                        height: 10), // Espacio entre el campo y la lista
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.aliments.length,
                        itemBuilder: (context, index) {
                          final aliment = state.aliments[index];
                          return ListTile(
                            title: Text(aliment.name),
                            onTap: () {
                              final quantity = quantityController.text;
                              if (quantity.isNotEmpty) {
                                Navigator.of(context)
                                    .pop(); // Cierra el overlay
                                _addAliment(
                                    aliment.id!,
                                    int.parse(
                                        quantity)); // Agrega el ID y la cantidad del alimento seleccionado
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Por favor, ingresa una cantidad.')),
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void _addAliment(int alimentId, int quantity) {
    setState(() {
      _selectedAliments[alimentId] = quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Receta'),
        backgroundColor: AppColors.primary,
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
            ElevatedButton(
              onPressed: _showSelectAlimentOverlay,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text('Añadir Alimento'),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: _selectedAliments.isNotEmpty
                  ? ListView.builder(
                      itemCount: _selectedAliments.length,
                      itemBuilder: (context, index) {
                        final alimentId =
                            _selectedAliments.keys.elementAt(index);
                        final quantity = _selectedAliments[alimentId];
                        return Card(
                          color: AppColors.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: ListTile(
                            title: Text(
                              'Alimento ID: $alimentId, Cantidad: $quantity',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _removeAliment(index),
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        'No hay alimentos añadidos',
                        style: TextStyle(
                            color: AppColors.foreground, fontSize: 16),
                      ),
                    ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveRecipe,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text('Guardar Receta'),
            ),
          ],
        ),
      ),
    );
  }
}
