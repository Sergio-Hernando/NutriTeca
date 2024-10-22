import 'package:flutter/widgets.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/constants/app_theme.dart';
import 'package:food_macros/core/extensions/context_extension.dart';
import 'package:food_macros/presentation/widgets/custom_text_field.dart';

class RecipeDetailHeader extends StatelessWidget {
  final bool isEditing;
  final Map<String, dynamic>? controllers;

  const RecipeDetailHeader({
    Key? key,
    required this.isEditing,
    required this.controllers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isEditing
              ? CustomTextField(
                  controller: controllers?['name'],
                  label: context.localizations.recipeName,
                )
              : Row(
                  children: [
                    Text(
                      context.localizations.name,
                      style: AppTheme.titleTextStyle.copyWith(
                          color: AppColors.secondaryAccent,
                          fontFamily: 'Roboto'),
                    ),
                    Text(
                      controllers?['name'].text ?? '',
                      style: AppTheme.titleTextStyle.copyWith(
                        color: AppColors.secondaryAccent,
                      ),
                    ),
                  ],
                ),
          const SizedBox(height: 16.0),
          isEditing
              ? CustomTextField(
                  controller: controllers?['instructions'],
                  label: context.localizations.instructions,
                )
              : Column(
                  children: [
                    Text(
                      context.localizations.instructions,
                      style: AppTheme.detailTextStyle
                          .copyWith(fontFamily: 'Roboto'),
                    ),
                    SingleChildScrollView(
                      child: Text(
                        controllers?['instructions'].text ?? '',
                        style: AppTheme.detailTextStyle,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
