import 'package:flutter/material.dart';
import 'package:food_macros/core/extensions/context_extension.dart';
import 'package:food_macros/presentation/widgets/custom_text_field.dart';

class AdvancedFields extends StatelessWidget {
  final Map<String, dynamic> controllers;

  const AdvancedFields({super.key, required this.controllers});

  @override
  Widget build(BuildContext context) {
    //TODO delete sizedbox
    return ExpansionTile(
      title: Text(context.localizations.advanced),
      children: [
        CustomTextField(
          controller: controllers['fatsSaturated']!,
          label: context.localizations.fatsSaturated,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: controllers['fatsPolyunsaturated']!,
          label: context.localizations.fatsPolyunsaturated,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: controllers['fatsMonounsaturated']!,
          label: context.localizations.fatsMonounsaturated,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: controllers['fatsTrans']!,
          label: context.localizations.fatsTrans,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: controllers['fiber']!,
          label: context.localizations.fiber,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: controllers['sugar']!,
          label: context.localizations.sugar,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: controllers['salt']!,
          label: context.localizations.salt,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
