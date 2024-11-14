import 'package:nutri_teca/domain/models/aliment_entity.dart';

class AlimentAction {
  final AlimentEntity aliment;
  final bool isAdd;

  AlimentAction({required this.aliment, required this.isAdd});
}
