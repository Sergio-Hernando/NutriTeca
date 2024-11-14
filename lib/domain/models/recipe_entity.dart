import 'package:nutri_teca/data/models/recipe_data_entity.dart';
import 'package:nutri_teca/domain/models/aliment_entity.dart';

class RecipeEntity {
  final int? id;
  final String? name;
  final String? instructions;
  final List<AlimentEntity>? aliments;

  RecipeEntity({
    this.id,
    this.name,
    this.instructions,
    this.aliments,
  });

  RecipeDataEntity toDataModel() {
    return RecipeDataEntity(
      id: id,
      name: name,
      instructions: instructions,
      aliments: aliments
          ?.map(
            (e) => e.toDataModel(),
          )
          .toList(),
    );
  }

  static RecipeEntity toDomain(RecipeDataEntity? dataModel) {
    return RecipeEntity(
      id: dataModel?.id ?? 0,
      name: dataModel?.name ?? '',
      instructions: dataModel?.instructions ?? '',
      aliments: dataModel?.aliments
          ?.map(
            (e) => AlimentEntity.toDomain(e),
          )
          .toList(),
    );
  }
}
