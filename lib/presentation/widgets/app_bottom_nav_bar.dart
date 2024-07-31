import 'package:flutter/material.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/routes/app_paths.dart';
import 'package:food_macros/presentation/widgets/app_bar.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithBottomNav extends StatefulWidget {
  final Widget child;
  final CustomAppBar appBar;
  final Color background;

  const ScaffoldWithBottomNav(
      {super.key,
      required this.child,
      required this.appBar,
      required this.background});

  @override
  _ScaffoldWithBottomNavState createState() => _ScaffoldWithBottomNavState();
}

class _ScaffoldWithBottomNavState extends State<ScaffoldWithBottomNav> {
  int _selectedIndex = 0;

  static final List<String> _routes = [
    AppRoutesPath.home,
    AppRoutesPath.search,
    AppRoutesPath.addProduct,
    AppRoutesPath.recipes,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    context.go(_routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      backgroundColor: widget.background,
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.foreground,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Principal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Añadir Producto',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Recetas',
          ),
        ],
      ),
    );
  }
}
