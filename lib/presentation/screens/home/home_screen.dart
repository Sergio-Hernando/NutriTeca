import 'package:flutter/material.dart';
import 'package:food_macros/core/constants/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: AppColors.primaryBlack,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Home',
                    style:
                        TextStyle(color: AppColors.primaryWhite, fontSize: 32))
              ],
            ),
          ),
        ));
  }
}
