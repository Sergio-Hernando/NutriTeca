import 'package:food_macros/data/models/aliment_remote_entity.dart';

class AlimentRequestEntity {
  final int? id;
  final String nombre;
  final String imagen_base64;
  final int calorias;
  final int grasas;
  final int carbohidratos;
  final int proteinas;

  AlimentRequestEntity({
    this.id,
    required this.nombre,
    required this.imagen_base64,
    required this.calorias,
    required this.grasas,
    required this.carbohidratos,
    required this.proteinas,
  });
}

extension AlimentRequestEntityExtension on AlimentRequestEntity {
  AlimentRemoteEntity toRemoteEntity() => AlimentRemoteEntity(
      nombre: nombre,
      imagen_base64: imagen_base64,
      calorias: calorias,
      grasas: grasas,
      carbohidratos: carbohidratos,
      proteinas: proteinas);
}
