import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/extensions/context_extension.dart';
import 'package:food_macros/core/routes/app_paths.dart';
import 'package:food_macros/presentation/screens/base_screen/widgets/app_bar.dart';
import 'package:food_macros/presentation/widgets/common_dialog.dart';
import 'package:go_router/go_router.dart';

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
        body: widget.navigationShell,
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: AppColors.foreground,
          color: AppColors.background,
          buttonBackgroundColor:
              AppColors.secondary, // Color del botón seleccionado
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
            SvgPicture.asset(
              'assets/icons/nutrition_icon.svg',
              width: 24,
              height: 24,
              color: Colors.white,
            ),
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

        /*  CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          animationDuration: const Duration(milliseconds: 300),
          color: Colors.white,
          height: 70,
          items: const [
            Icon(Icons.tv, size: 30),
            Icon(Icons.search, size: 30),
            Icon(Icons.bookmark_outline, size: 30),
          ],
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
            _goBranch(_selectedIndex);
          },
        ), */
        /* BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          backgroundColor: AppColors.background,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.foreground,
          selectedLabelStyle: const TextStyle(fontSize: 18),
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
            _goBranch(_selectedIndex);
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/nutrition_icon.svg',
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.foreground,
                    BlendMode.srcIn,
                  )),
              activeIcon: SvgPicture.asset('assets/icons/nutrition_icon.svg',
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  )),
              label: context.localizations.alimentsScreen,
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.home,
                size: 30,
              ),
              label: context.localizations.mainScreen,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.book),
              label: context.localizations.recipesScreen,
            ),
          ],
        ), */
        floatingActionButton: _selectedIndex == 1
            ? null
            : FloatingActionButton(
                heroTag: 'añadir',
                shape: const CircleBorder(),
                onPressed: () => context.push(_selectedIndex == 0
                    ? AppRoutesPath.addAliment
                    : AppRoutesPath.addRecipe),
                backgroundColor: AppColors.secondary,
                child: const Icon(
                  Icons.add,
                  color: AppColors.foreground,
                ),
              ),
      ),
    );
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
