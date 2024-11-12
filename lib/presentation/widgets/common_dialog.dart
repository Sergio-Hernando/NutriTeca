import 'package:flutter/material.dart';
import 'package:nutri_teca/core/constants/app_colors.dart';
import 'package:nutri_teca/core/extensions/context_extension.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final String? title;
  final String? content;
  final String? mainButtonText;
  final Function() onConfirm;
  final List<String> moreContent;

  const ConfirmDeleteDialog({
    Key? key,
    this.title,
    this.content,
    this.mainButtonText,
    required this.onConfirm,
    this.moreContent = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return AlertDialog(
      backgroundColor: AppColors.foreground,
      title: Text(
        title ?? context.localizations.confirmDelete,
        style: const TextStyle(color: AppColors.background),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                content ?? context.localizations.confirmDeleteMessage,
                style: const TextStyle(color: AppColors.secondaryAccent),
              ),
              moreContent.isNotEmpty
                  ? Text(context.localizations.alimentsInRecipe,
                      style: const TextStyle(color: AppColors.background))
                  : const SizedBox(),
              moreContent.isNotEmpty
                  ? SizedBox(
                      height: 80,
                      child: Scrollbar(
                        thumbVisibility: true,
                        controller: scrollController,
                        child: ListView.builder(
                          controller: scrollController,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: moreContent.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: Text(
                                moreContent[index],
                                style: const TextStyle(
                                    color: AppColors.secondaryAccent),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(
            context.localizations.cancel,
            style: const TextStyle(color: AppColors.background),
          ),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.background,
          ),
          child: Text(
            mainButtonText ?? context.localizations.delete,
            style: const TextStyle(color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
