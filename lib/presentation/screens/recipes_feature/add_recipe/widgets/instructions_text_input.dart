import 'package:flutter/material.dart';
import 'package:food_macros/core/constants/app_colors.dart';

class InstructionsTextField extends StatelessWidget {
  final TextEditingController controller;

  const InstructionsTextField({required this.controller, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: AppColors.secondaryAccent),
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Instrucciones',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondaryAccent),
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        fillColor: AppColors.secondaryAccent,
        labelStyle: TextStyle(color: AppColors.secondaryAccent),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondaryAccent),
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
      ),
    );
  }
}
