import 'package:flutter/material.dart';
import 'package:nutri_teca/core/constants/app_colors.dart';

class BaseAddScreen extends StatefulWidget {
  final Widget body;
  final Function() onPressed;
  final String title;

  const BaseAddScreen({
    super.key,
    required this.body,
    required this.onPressed,
    required this.title,
  });

  @override
  State<BaseAddScreen> createState() => _BaseAddScreenState();
}

class _BaseAddScreenState extends State<BaseAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.foreground,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.background,
        title: Text(widget.title),
      ),
      body: widget.body,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: widget.onPressed,
        backgroundColor: AppColors.secondary,
        child: const Icon(
          Icons.save_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
