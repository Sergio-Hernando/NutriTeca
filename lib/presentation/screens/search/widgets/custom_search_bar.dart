import 'package:flutter/material.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/presentation/widgets/generic_search_bar.dart';

class AlimentSearchBar extends StatelessWidget {
  final List<AlimentEntity> allItems;
  final void Function(List<AlimentEntity>) onResults;

  const AlimentSearchBar({
    required this.allItems,
    required this.onResults,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GenericSearchBar<AlimentEntity>(
      allItems: allItems,
      getItemName: (AlimentEntity item) => item.name ?? '',
      onResults: onResults,
      hintText: 'Buscar Alimento',
    );
  }
}
