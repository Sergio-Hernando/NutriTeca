import 'package:flutter/material.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/extensions/context_extension.dart';

class InstructionsTextField extends StatelessWidget {
  final TextEditingController controller;

  const InstructionsTextField({required this.controller, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: AppColors.secondaryAccent),
      controller: controller,
      decoration: InputDecoration(
        labelText: context.localizations.instructions,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondaryAccent),
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        fillColor: AppColors.secondaryAccent,
        labelStyle: const TextStyle(color: AppColors.secondaryAccent),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondaryAccent),
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
      ),
    );
  }
}
