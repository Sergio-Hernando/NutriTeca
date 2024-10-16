import 'package:food_macros/data/models/recipe_data_entity.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';

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

  // Método para convertir a modelo de datos
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

  // Método para convertir de modelo de datos a entidad de dominio
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
