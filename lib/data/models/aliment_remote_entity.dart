class AlimentRemoteEntity {
  final int? id;
  final String nombre;
  final String imagen_base64;
  final int calorias;
  final int grasas;
  final int carbohidratos;
  final int proteinas;

  AlimentRemoteEntity({
    this.id,
    required this.nombre,
    required this.imagen_base64,
    required this.calorias,
    required this.grasas,
    required this.carbohidratos,
    required this.proteinas,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'imagen_base64': imagen_base64,
      'calorias': calorias,
      'grasas': grasas,
      'carbohidratos': carbohidratos,
      'proteinas': proteinas,
    };
  }

  factory AlimentRemoteEntity.fromMap(Map<String, dynamic> map) {
    return AlimentRemoteEntity(
      id: map['id'],
      nombre: map['nombre'],
      imagen_base64: map['id'],
      calorias: map['calorias'],
      grasas: map['grasas'],
      carbohidratos: map['carbohidratos'],
      proteinas: map['proteinas'],
    );
  }
}
