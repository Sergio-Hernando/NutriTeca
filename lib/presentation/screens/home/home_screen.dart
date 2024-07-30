import 'package:flutter/material.dart';
import 'package:food_macros/core/constants/app_assets.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/presentation/widgets/app_bar.dart';
import 'package:food_macros/presentation/widgets/app_bottom_nav_bar.dart';
import 'package:food_macros/presentation/widgets/images_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBottomNav(
        appBar: const CustomAppBar(),
        background: AppColors.foreground,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      //Add navigation to aditives screen
                    },
                    child: const AutoScrollImageSlider(
                      imagePaths: [
                        AppAssets.aditive1,
                        AppAssets.aditive2
                        // Añade más URLs de imágenes aquí
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
