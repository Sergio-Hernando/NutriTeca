import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/routes/app_paths.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/presentation/screens/recipes/bloc/recipe_bloc.dart';
import 'package:food_macros/presentation/screens/recipes/bloc/recipe_event.dart';
import 'package:food_macros/presentation/screens/recipes/bloc/recipe_state.dart';
import 'package:go_router/go_router.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RecipeBloc>().add(const RecipeEvent.getRecipes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recetas'),
        backgroundColor: AppColors.primary,
      ),
      body: BlocBuilder<RecipeBloc, RecipeState>(
        builder: (context, state) {
          if (state.screenStatus.isLoading()) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.screenStatus.isError()) {
            return const Center(child: Text('Error al cargar recetas'));
          } else {
            if (state.recipes.isEmpty) {
              return const Center(child: Text('No hay recetas disponibles'));
            }
            return ListView.builder(
              itemCount: state.recipes.length,
              itemBuilder: (context, index) {
                final recipe = state.recipes[index];
                return ListTile(
                  title: Text(recipe.name),
                  subtitle: Text('Alimentos: ${recipe.aliments?.length}'),
                  onTap: () {
                    // Lógica para ver detalles o editar la receta
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go(AppRoutesPath.addRecipe),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}
