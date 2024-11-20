import 'package:flutter/material.dart';
import 'package:nutri_teca/core/constants/app_assets.dart';
import 'package:nutri_teca/core/constants/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function() goHome;
  final int screenIndex;
  final Function() logOut;
  const CustomAppBar({
    super.key,
    required this.goHome,
    required this.screenIndex,
    required this.logOut,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      leading: IconButton(
        icon: const Image(
          image: AssetImage(AppAssets.mainLogo),
        ),
        onPressed: goHome,
      ),
      actions: <Widget>[
        screenIndex == 1
            ? IconButton(
                icon: const Icon(
                  Icons.logout_outlined,
                  color: AppColors.foreground,
                ),
                onPressed: logOut,
              )
            : const SizedBox(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
