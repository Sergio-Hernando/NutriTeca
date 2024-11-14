import 'package:flutter/material.dart';
import 'package:nutri_teca/core/extensions/context_extension.dart';
import 'package:nutri_teca/presentation/widgets/custom_text_field.dart';

class AdvancedFields extends StatelessWidget {
  final Map<String, dynamic> controllers;

  const AdvancedFields({super.key, required this.controllers});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(context.localizations.advanced),
      children: [
        CustomTextField(
          controller: controllers['fatsSaturated'],
          keyboardType: const TextInputType.numberWithOptions(),
          label: context.localizations.fatsSaturated,
        ),
        CustomTextField(
          controller: controllers['fatsPolyunsaturated'],
          keyboardType: const TextInputType.numberWithOptions(),
          label: context.localizations.fatsPolyunsaturated,
        ),
        CustomTextField(
          controller: controllers['fatsMonounsaturated'],
          keyboardType: const TextInputType.numberWithOptions(),
          label: context.localizations.fatsMonounsaturated,
        ),
        CustomTextField(
          controller: controllers['fatsTrans'],
          keyboardType: const TextInputType.numberWithOptions(),
          label: context.localizations.fatsTrans,
        ),
        CustomTextField(
          controller: controllers['fiber'],
          keyboardType: const TextInputType.numberWithOptions(),
          label: context.localizations.fiber,
        ),
        CustomTextField(
          controller: controllers['sugar'],
          keyboardType: const TextInputType.numberWithOptions(),
          label: context.localizations.sugar,
        ),
        CustomTextField(
          controller: controllers['salt'],
          keyboardType: const TextInputType.numberWithOptions(),
          label: context.localizations.salt,
        ),
      ],
    );
  }
}
