import 'dart:io';
import 'dart:math';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutri_teca/core/constants/app_colors.dart';
import 'package:nutri_teca/core/extensions/context_extension.dart';
import 'package:nutri_teca/core/routes/app_paths.dart';
import 'package:nutri_teca/presentation/screens/base_screen/widgets/app_bar.dart';
import 'package:nutri_teca/presentation/widgets/common_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:nutri_teca/presentation/widgets/ad_widgets/intersticial_ad.dart';

class BaseScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const BaseScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 1;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (popDisposition) {
        _showExitConfirmation(context);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          goHome: () {
            setState(() {
              _selectedIndex = 1;
            });
            _goBranch(1);
          },
          screenIndex: _selectedIndex,
        ),
        body: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: widget.navigationShell,
              ),
            ),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          backgroundColor: AppColors.foreground,
          color: AppColors.background,
          buttonBackgroundColor: AppColors.secondary,
          height: 60,
          animationDuration: const Duration(milliseconds: 300),
          index: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
            _goBranch(_selectedIndex);
          },
          items: <Widget>[
            SvgPicture.asset('assets/icons/nutrition_icon.svg',
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                )),
            const Icon(
              Icons.home,
              size: 30,
              color: Colors.white,
            ),
            const Icon(
              Icons.book,
              size: 30,
              color: Colors.white,
            ),
          ],
        ),
        floatingActionButton: _selectedIndex == 1
            ? null
            : FloatingActionButton(
                heroTag: 'add',
                shape: const CircleBorder(),
                onPressed: () => _navigateWithAd(context),
                backgroundColor: AppColors.secondary,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  void _navigateWithAd(BuildContext context) async {
    await _showInterstitialAd(context, 0.35);
    if (context.mounted) {
      context.push(_selectedIndex == 0
          ? AppRoutesPath.addAliment
          : AppRoutesPath.addRecipe);
    }
  }

  Future<void> _showInterstitialAd(
      BuildContext context, double probability) async {
    double randomValue = Random().nextDouble();

    if (randomValue <= probability) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return const InterstitialAdWidget();
        },
      );
    }
  }
}

Future<bool> _showExitConfirmation(BuildContext context) async {
  return await showDialog(
          context: context,
          builder: (context) => ConfirmDeleteDialog(
                title: context.localizations.exitTitle,
                content: context.localizations.exitContent,
                mainButtonText: context.localizations.exit,
                onConfirm: () => exit(0),
              )) ??
      false;
}
