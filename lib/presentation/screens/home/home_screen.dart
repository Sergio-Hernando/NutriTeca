import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:food_macros/core/constants/app_assets.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/presentation/widgets/app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final additivesList = [AppAssets.additive1, AppAssets.additive2];

    return Scaffold(
        appBar: const CustomAppBar(),
        backgroundColor: AppColors.foreground,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CarouselSlider(
                    items: additivesList
                        .map((e) => Image.asset(
                              e,
                              fit: BoxFit.cover,
                            ))
                        .toList(),
                    options: CarouselOptions(
                      height: 200,
                      viewportFraction: 0.7,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      enlargeCenterPage: true,
                    )),
              ],
            ),
          ),
        ));
  }
}
