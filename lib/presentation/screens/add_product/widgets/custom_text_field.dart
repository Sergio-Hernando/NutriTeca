import 'package:flutter/material.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/constants/app_theme.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final Widget? icon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
          hintText: label,
          hintStyle: AppTheme.descriptionTextStyle
              .copyWith(color: AppColors.foreground),
          filled: true,
          fillColor: AppColors.secondaryAccent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          suffixIcon: icon),
      validator: validator,
    );
  }
}
