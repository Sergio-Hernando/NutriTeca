import 'package:flutter/material.dart';
import 'package:food_macros/core/constants/app_assets.dart';
import 'package:food_macros/core/constants/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      leading: IconButton(
        icon: const Image(
          image: AssetImage(AppAssets.mainLogo),
        ),
        onPressed: () {
          //Add logic to navigate to home
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.shopping_bag_outlined,
            color: AppColors.foreground,
          ),
          onPressed: () {
            //Add logic to go new groceries
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
