import 'package:flutter/material.dart';
import 'package:food_macros/domain/models/recipe_entity.dart';
import 'package:food_macros/presentation/widgets/generic_search_bar.dart';

class RecipeSearchBar extends StatelessWidget {
  final List<RecipeEntity> allItems;
  final void Function(List<RecipeEntity>) onResults;

  const RecipeSearchBar({
    required this.allItems,
    required this.onResults,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GenericSearchBar<RecipeEntity>(
      allItems: allItems,
      getItemName: (RecipeEntity item) => item.name,
      onResults: onResults,
      hintText: 'Buscar Receta',
    );
  }
}
