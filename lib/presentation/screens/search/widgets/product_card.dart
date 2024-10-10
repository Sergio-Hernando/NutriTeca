import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/constants/app_theme.dart';
import 'package:food_macros/core/routes/app_paths.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/presentation/screens/search/widgets/macro_row.dart';
import 'package:go_router/go_router.dart';

class CustomCard extends StatelessWidget {
  final AlimentEntity aliment;

  const CustomCard({
    required this.aliment,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => _showMacroOverlay(context),
                child: CircleAvatar(
                  backgroundImage:
                      MemoryImage(base64Decode(aliment.imageBase64 ?? '')),
                  radius: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  onTap: () =>
                      context.go(AppRoutesPath.alimentDetail, extra: aliment),
                  child: Text(
                    aliment.name ?? '',
                    style: AppTheme.bodyTextStyle.copyWith(color: Colors.white),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () =>
                    context.go(AppRoutesPath.alimentDetail, extra: aliment),
                child: const Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                  size: 48,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMacroOverlay(BuildContext context) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: AppColors.background.withOpacity(0.9),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  aliment.name ?? '',
                  style: AppTheme.titleTextStyle
                      .copyWith(color: AppColors.foreground),
                ),
                const SizedBox(height: 10),
                MacroRow(label: 'Calories', value: '${aliment.calories} kcal'),
                MacroRow(label: 'Fats', value: '${aliment.fats}g'),
                MacroRow(
                    label: 'Carbohydrates', value: '${aliment.carbohydrates}g'),
                MacroRow(label: 'Proteins', value: '${aliment.proteins}g'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => overlayEntry.remove(),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryAccent,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(fontWeight: FontWeight.w800)),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
  }
}
