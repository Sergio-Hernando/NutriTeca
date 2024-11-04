import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nutri_teca/core/constants/app_assets.dart';
import 'package:nutri_teca/core/constants/app_colors.dart';
import 'package:nutri_teca/core/constants/app_theme.dart';
import 'package:nutri_teca/core/extensions/context_extension.dart';
import 'package:nutri_teca/core/routes/app_paths.dart';
import 'package:nutri_teca/domain/models/aliment_entity.dart';
import 'package:nutri_teca/presentation/screens/aliments_feature/aliments/widgets/macro_row.dart';
import 'package:go_router/go_router.dart';
import 'package:nutri_teca/presentation/widgets/ad_widgets/intersticial_ad.dart';

class CustomCard extends StatelessWidget {
  final AlimentEntity aliment;
  final InterstitialAdWidget interstitialAdWidget;

  CustomCard({
    required this.aliment,
    Key? key,
  })  : interstitialAdWidget = InterstitialAdWidget(),
        super(key: key);

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
                child: ClipOval(
                  child: Image(
                    image: _getImageProvider(),
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.height * 0.02),
                child: Expanded(
                  child: GestureDetector(
                    onTap: () => _navigateWithAd(context),
                    child: Text(
                      aliment.name ?? '',
                      style:
                          AppTheme.bodyTextStyle.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => _navigateWithAd(context),
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

  ImageProvider<Object> _getImageProvider() {
    if (aliment.imageBase64 != null && aliment.imageBase64!.isNotEmpty) {
      return MemoryImage(base64Decode(aliment.imageBase64 ?? ''));
    } else {
      return const AssetImage(AppAssets.mainLogo);
    }
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
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.01),
                  child: Text(
                    aliment.name ?? '',
                    style: AppTheme.titleTextStyle
                        .copyWith(color: AppColors.foreground),
                  ),
                ),
                MacroRow(
                    label: context.localizations.calories,
                    value: '${aliment.calories} kcal'),
                MacroRow(
                    label: context.localizations.fats,
                    value: '${aliment.fats}g'),
                MacroRow(
                    label: context.localizations.carbohydrates,
                    value: '${aliment.carbohydrates}g'),
                MacroRow(
                    label: context.localizations.proteins,
                    value: '${aliment.proteins}g'),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.01),
                  child: ElevatedButton(
                    onPressed: () => overlayEntry.remove(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryAccent,
                        foregroundColor: Colors.white,
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.w800)),
                    child: Text(context.localizations.close),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
  }

  void _navigateWithAd(BuildContext context) {
    final interstitialAdWidget = InterstitialAdWidgetState();
    interstitialAdWidget.loadAd();
    // Navegar al detalle de alimento después de un corto retraso para permitir que el anuncio se muestre.
    Future.delayed(const Duration(seconds: 2), () {
      context.go(AppRoutesPath.alimentDetail, extra: aliment);
    });
  }
}
