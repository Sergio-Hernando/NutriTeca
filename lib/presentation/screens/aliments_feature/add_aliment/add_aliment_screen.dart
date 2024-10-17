import 'package:flutter/material.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/presentation/screens/aliments_feature/add_aliment/widgets/add_form.dart';

class AddAlimentScreen extends StatelessWidget {
  const AddAlimentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.background,
        title: const Text('Añadir Alimento'),
      ),
      backgroundColor: AppColors.foreground,
      resizeToAvoidBottomInset: true,
      body: const SafeArea(child: AddAlimentForm()),
    );
  }
}
