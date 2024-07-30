import 'package:flutter/material.dart';
import 'dart:async';

class AutoScrollImageSlider extends StatefulWidget {
  final List<String> imagePaths;

  const AutoScrollImageSlider({super.key, required this.imagePaths});

  @override
  _AutoScrollImageSliderState createState() => _AutoScrollImageSliderState();
}

class _AutoScrollImageSliderState extends State<AutoScrollImageSlider> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _timer = Timer.periodic(const Duration(seconds: 2), _autoScroll);
  }

  void _autoScroll(Timer timer) {
    if (_currentPage < widget.imagePaths.length - 1) {
      _currentPage++;
    } else {
      _currentPage = 0;
    }
    _pageController.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0, // Ajusta el tamaño según tus necesidades
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.imagePaths.length,
        itemBuilder: (context, index) {
          return Image.asset(
            widget.imagePaths[index],
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
