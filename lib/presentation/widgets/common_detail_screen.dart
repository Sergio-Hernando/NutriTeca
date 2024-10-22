import 'package:flutter/material.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/constants/app_theme.dart';
import 'package:food_macros/presentation/widgets/common_dialog.dart';
import 'package:food_macros/presentation/widgets/floating_button_row.dart';
import 'package:go_router/go_router.dart';

class CommonDetailScreen extends StatefulWidget {
  final String title;
  final Function() onDelete;
  final List<String>? recipeList;
  final Function() onEditOn;
  final Function() onEditOff;
  final Widget body;
  final bool isEditing;
  const CommonDetailScreen({
    super.key,
    required this.title,
    required this.onDelete,
    required this.onEditOn,
    required this.onEditOff,
    required this.body,
    required this.isEditing,
    this.recipeList,
  });

  @override
  State<CommonDetailScreen> createState() => _CommonDetailScreenState();
}

class _CommonDetailScreenState extends State<CommonDetailScreen> {
  Future<void> _confirmDelete() async {
    await showDialog(
      context: context,
      builder: (context) => ConfirmDeleteDialog(
        onConfirm: widget.onDelete,
        moreContent: widget.recipeList ?? [],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.foreground,
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.title,
            style: AppTheme.titleTextStyle,
          ),
        ),
        backgroundColor: AppColors.background,
        leading: widget.isEditing
            ? const SizedBox()
            : IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => context.pop(),
              ),
        actions: [
          if (!widget.isEditing)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.white),
              onPressed: _confirmDelete,
            ),
        ],
      ),
      body: widget.body,
      floatingActionButton: FloatingButtonRow(
        isEditing: widget.isEditing,
        toggleEditModeOn: widget.onEditOn,
        toggleEditModeOff: widget.onEditOff,
      ),
    );
  }
}
