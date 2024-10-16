import 'package:flutter/material.dart';
import 'package:food_macros/core/constants/app_colors.dart';

class FloatingButtonRow extends StatelessWidget {
  final bool isEditing;
  final Function() toggleEditModeOn;
  final Function() toggleEditModeOff;
  const FloatingButtonRow(
      {super.key,
      required this.isEditing,
      required this.toggleEditModeOn,
      required this.toggleEditModeOff});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (isEditing)
          FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: toggleEditModeOff,
            backgroundColor: Colors.red,
            child: const Icon(Icons.cancel, color: AppColors.foreground),
          ),
        const SizedBox(width: 16),
        FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: toggleEditModeOn,
          backgroundColor: AppColors.secondary,
          child: Icon(
            isEditing ? Icons.save : Icons.edit,
            color: AppColors.foreground,
          ),
        ),
      ],
    );
  }
}
