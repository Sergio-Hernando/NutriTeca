import 'package:flutter/material.dart';
import 'package:nutri_teca/core/constants/app_colors.dart';
import 'package:nutri_teca/core/constants/app_theme.dart';

class MacroRow extends StatelessWidget {
  final String label;
  final String value;

  const MacroRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTheme.bodyTextStyle.copyWith(color: AppColors.foreground),
        ),
        Text(
          value,
          style: AppTheme.bodyTextStyle.copyWith(
              color: AppColors.foreground, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
