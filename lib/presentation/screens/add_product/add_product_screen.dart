import 'package:flutter/material.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/presentation/screens/add_product/widgets/add_form.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.foreground,
      resizeToAvoidBottomInset: true,
      body: SafeArea(child: AddProductForm()),
    );
  }
}
