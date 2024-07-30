import 'package:flutter/material.dart';
import 'package:food_macros/core/constants/app_assets.dart';
import 'package:food_macros/core/constants/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(AppAssets.mainLogo),
              ),
              Text(
                'FOODMACROS',
                style: TextStyle(color: AppColors.primaryWhite, fontSize: 32),
              ),
              Text(
                'La aplicación perfecta para controlar lo que comes y mucho más',
                style: TextStyle(color: AppColors.primaryWhite, fontSize: 24),
              )
            ],
          ),
        ),
      ),
    );
  }
}
