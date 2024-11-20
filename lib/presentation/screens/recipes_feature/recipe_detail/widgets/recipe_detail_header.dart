import 'package:flutter/widgets.dart';
import 'package:nutri_teca/core/constants/app_colors.dart';
import 'package:nutri_teca/core/constants/app_theme.dart';
import 'package:nutri_teca/core/extensions/context_extension.dart';
import 'package:nutri_teca/presentation/widgets/custom_text_field.dart';

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
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.height * 0.02),
                      child: Text(
                        controllers?['name'].text ?? '',
                        style: AppTheme.titleTextStyle.copyWith(
                          color: AppColors.secondaryAccent,
                        ),
                      ),
                    ),
                  ],
                ),
          isEditing
              ? CustomTextField(
                  controller: controllers?['instructions'],
                  label: context.localizations.instructions,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.localizations.instructions,
                      style: AppTheme.titleTextStyle.copyWith(
                          color: AppColors.secondaryAccent,
                          fontFamily: 'Roboto'),
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
