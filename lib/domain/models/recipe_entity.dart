import 'package:food_macros/data/models/recipe_remote_entity.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';

class RecipeEntity {
  final int id;
  final String name;
  final List<AlimentEntity>? aliments;

  RecipeEntity({
    required this.id,
    required this.name,
    required this.aliments,
  });
}

extension RecipeEntityExtension on RecipeRemoteEntity {
  RecipeEntity toEntity() => RecipeEntity(
      id: id,
      name: name,
      aliments: aliments
          .map(
            (e) => e.toEntity(),
          )
          .toList());
}
