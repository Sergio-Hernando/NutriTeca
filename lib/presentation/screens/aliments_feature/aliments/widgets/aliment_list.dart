import 'package:flutter/material.dart';
import 'package:nutri_teca/core/extensions/context_extension.dart';
import 'package:nutri_teca/domain/models/aliment_entity.dart';
import 'package:nutri_teca/presentation/screens/aliments_feature/aliments/widgets/aliment_card.dart';

class AlimentList extends StatelessWidget {
  final List<AlimentEntity> aliments;

  const AlimentList({Key? key, required this.aliments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return aliments.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              itemCount: aliments.length,
              itemBuilder: (context, index) => CustomCard(
                aliment: aliments[index],
              ),
            ),
          )
        : Center(
            child: Text(
              context.localizations.noResults,
              style: const TextStyle(color: Colors.grey),
            ),
          );
  }
}
