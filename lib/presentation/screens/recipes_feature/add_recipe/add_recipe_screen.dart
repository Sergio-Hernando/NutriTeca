import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutri_teca/core/constants/app_colors.dart';
import 'package:nutri_teca/core/extensions/context_extension.dart';
import 'package:nutri_teca/presentation/screens/recipes_feature/add_recipe/widgets/add_recipe_form.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({Key? key}) : super(key: key);

  @override
  State<AddRecipeScreen> createState() => AddRecipeScreenState();
}

class AddRecipeScreenState extends State<AddRecipeScreen> {
  final GlobalKey<AddRecipeFormState> _formKey =
      GlobalKey<AddRecipeFormState>();
  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.foreground,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.background,
        title: Text(context.localizations.addRecipe),
      ),
      body: AddRecipeForm(key: _formKey),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          setState(() {
            isSaving = true;
            _formKey.currentState?.saveRecipe();
          });
          if (_formKey.currentState?.isFormValid ?? false) {
            GoRouter.of(context).pop(true);
          } else {
            setState(() {
              isSaving = false;
            });
          }
        },
        backgroundColor: AppColors.secondary,
        child: const Icon(
          Icons.save_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
