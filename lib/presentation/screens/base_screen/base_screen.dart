import 'dart:io';

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
  BaseScreenState createState() => BaseScreenState();
}

class BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 1;

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.navigationShell,
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            icon: SvgPicture.asset(
              'assets/icons/nutrition_icon.svg',
              width: 24,
              height: 24,
              color: AppColors.foreground,
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/nutrition_icon.svg',
              width: 24,
              height: 24,
              color: AppColors.primary,
            ),
            label: context.localizations.alimentsScreen,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: context.localizations.mainScreen,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: context.localizations.recipesScreen,
          ),
        ],
      ),
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
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ModalRoute.of(context)?.addScopedWillPopCallback(() async {
      final shouldExit = await _showExitConfirmation(context);
      return shouldExit;
    });
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
