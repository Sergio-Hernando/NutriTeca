import 'package:flutter/material.dart';
import 'package:food_macros/core/constants/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Home',
                  style: Theme.of(context).textTheme.displayLarge,
                )
              ],
            ),
          ),
        ));
  }
}
