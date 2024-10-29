import 'package:flutter/material.dart';
import 'package:food_macros/core/constants/app_theme.dart';
import 'package:food_macros/core/extensions/context_extension.dart';
import 'package:food_macros/presentation/screens/aliments_feature/widgets/supermarket_dropdown.dart';

class SupermarketRowWidget extends StatelessWidget {
  final bool isEditing;
  final Map<String, dynamic> controllers;
  final void Function(String?) onChanged;

  const SupermarketRowWidget({
    Key? key,
    required this.isEditing,
    required this.controllers,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(context.localizations.supermarket,
              style: AppTheme.detailTextStyle),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.18,
          ),
          Expanded(
            child: isEditing
                ? SupermarketDropdown(
                    selectedValue: controllers['supermarket'].value.isEmpty
                        ? null
                        : controllers['supermarket'].value,
                    onChanged: onChanged,
                  )
                : Text(
                    controllers['supermarket'].value.isEmpty
                        ? '-'
                        : controllers['supermarket'].value,
                    style: AppTheme.detailTextStyle,
                    textAlign: TextAlign.end,
                  ),
          ),
        ],
      ),
    );
  }
}
