import 'package:flutter/material.dart';
import 'package:nutri_teca/core/constants/app_colors.dart';
import 'package:nutri_teca/core/extensions/context_extension.dart';
import 'package:nutri_teca/presentation/widgets/common_dialog.dart';
import 'package:go_router/go_router.dart';

class BaseAddScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    Future<void> showExitConfirmation() {
      return (showDialog(
        context: context,
        builder: (context) => ConfirmDeleteDialog(
          title: context.localizations.cancelTitle,
          content: context.localizations.cancelContent,
          mainButtonText: context.localizations.exit,
          onConfirm: () => context.pop(),
        ),
      ));
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => showExitConfirmation(),
      child: Scaffold(
        backgroundColor: AppColors.foreground,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.background,
          title: Text(title),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: showExitConfirmation,
          ),
        ),
        body: body,
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: onPressed,
          backgroundColor: AppColors.secondary,
          child: const Icon(
            Icons.save_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
