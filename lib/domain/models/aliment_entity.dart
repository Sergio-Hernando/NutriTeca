import 'package:food_macros/data/models/aliment_remote_entity.dart';

class AlimentEntity {
  final int? id;
  final String nombre;
  final String imagen_base64;
  final int calorias;
  final int grasas;
  final int carbohidratos;
  final int proteinas;

  AlimentEntity({
    this.id,
    required this.nombre,
    required this.imagen_base64,
    required this.calorias,
    required this.grasas,
    required this.carbohidratos,
    required this.proteinas,
  });
}

extension AlimentEntityExtension on AlimentRemoteEntity {
  AlimentEntity toEntity() => AlimentEntity(
      nombre: nombre,
      imagen_base64: imagen_base64,
      calorias: calorias,
      grasas: grasas,
      carbohidratos: carbohidratos,
      proteinas: proteinas);
}
