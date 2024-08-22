import 'package:flutter/material.dart';
import 'package:food_macros/presentation/screens/add_product/widgets/custom_text_field.dart';

class AdvancedFields extends StatelessWidget {
  final Map<String, TextEditingController> controllers;

  const AdvancedFields({super.key, required this.controllers});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('Avanzado'),
      children: [
        CustomTextField(
          controller: controllers['fatsSaturated']!,
          label: 'Grasas Saturadas',
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: controllers['fatsPolyunsaturated']!,
          label: 'Grasas Poliinsaturadas',
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: controllers['fatsMonounsaturated']!,
          label: 'Grasas Monoinsaturadas',
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: controllers['fatsTrans']!,
          label: 'Grasas Trans',
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: controllers['fiber']!,
          label: 'Fibra',
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: controllers['sugar']!,
          label: 'Azúcares',
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: controllers['salt']!,
          label: 'Sal',
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
