import 'package:flutter/material.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/presentation/screens/search/widgets/product_card.dart';

class AlimentList extends StatelessWidget {
  final List<AlimentEntity> aliments;

  const AlimentList({Key? key, required this.aliments}) : super(key: key);

  void _onPressed(AlimentEntity aliment) {
    // Acción al hacer clic en un alimento
  }

  @override
  Widget build(BuildContext context) {
    return aliments.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              itemCount: aliments.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => _onPressed(aliments[index]),
                child: CustomCard(
                  imagePath: aliments[index].imageBase64,
                  text: aliments[index].name,
                  icon: Icons.chevron_right,
                ),
              ),
            ),
          )
        : const Center(
            child:
                Text('No results found', style: TextStyle(color: Colors.grey)));
  }
}
