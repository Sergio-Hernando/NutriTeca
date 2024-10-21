import 'dart:convert';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/constants/app_theme.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/presentation/screens/aliments_feature/aliment_detail/bloc/aliment_detail_bloc.dart';
import 'package:food_macros/presentation/screens/aliments_feature/aliment_detail/bloc/aliment_detail_event.dart';
import 'package:food_macros/presentation/screens/aliments_feature/aliment_detail/bloc/aliment_detail_state.dart';
import 'package:food_macros/presentation/widgets/common_detail_screen.dart';
import 'package:go_router/go_router.dart';

class AlimentDetailScreen extends StatefulWidget {
  final AlimentEntity aliment;

  const AlimentDetailScreen({required this.aliment, Key? key})
      : super(key: key);

  @override
  State<AlimentDetailScreen> createState() => _AlimentDetailScreenState();
}

class _AlimentDetailScreenState extends State<AlimentDetailScreen> {
  bool isEditing = false;

  late Map<String, dynamic> controllers;

  final List<String> supermarkets = [
    'Mercadona',
    'Lidl',
    'Aldi',
    'Eroski',
    'Dia',
    'Alcampo'
  ];

  @override
  void initState() {
    super.initState();
    controllers = {
      'name': TextEditingController(text: widget.aliment.name),
      'image': TextEditingController(text: widget.aliment.imageBase64),
      'supermarket': SingleSelectController(widget.aliment.supermarket),
      'calories': TextEditingController(text: '${widget.aliment.calories}'),
      'fats': TextEditingController(text: '${widget.aliment.fats}'),
      'fatsSaturated':
          TextEditingController(text: '${widget.aliment.fatsSaturated ?? '-'}'),
      'fatsPolyunsaturated': TextEditingController(
          text: '${widget.aliment.fatsPolyunsaturated ?? '-'}'),
      'fatsMonounsaturated': TextEditingController(
          text: '${widget.aliment.fatsMonounsaturated ?? '-'}'),
      'fatsTrans':
          TextEditingController(text: '${widget.aliment.fatsTrans ?? '-'}'),
      'carbohydrates':
          TextEditingController(text: '${widget.aliment.carbohydrates}'),
      'fiber': TextEditingController(text: '${widget.aliment.fiber ?? '-'}'),
      'sugar': TextEditingController(text: '${widget.aliment.sugar ?? '-'}'),
      'proteins': TextEditingController(text: '${widget.aliment.proteins}'),
      'salt': TextEditingController(text: '${widget.aliment.salt ?? '-'}'),
    };
  }

  @override
  void dispose() {
    controllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  void _toggleEditModeOn() {
    if (isEditing) {
      _updateAliment();
    }
    setState(() {
      isEditing = !isEditing;
    });
  }

  void _toggleEditModeOff() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void _updateAliment() {
    context.read<AlimentDetailBloc>().add(
          AlimentDetailEvent.editAliment(
            AlimentEntity(
              id: widget.aliment.id,
              name: controllers['name'].text.capitalize(),
              imageBase64: controllers['image'].text,
              supermarket: controllers['supermarket'].value ?? '',
              calories: _parseToInt(controllers['calories'].text) ?? 0,
              fats: _parseToInt(controllers['fats'].text) ?? 0,
              fatsSaturated: _parseToInt(controllers['fatsSaturated'].text),
              fatsPolyunsaturated:
                  _parseToInt(controllers['fatsPolyunsaturated'].text),
              fatsMonounsaturated:
                  _parseToInt(controllers['fatsMonounsaturated'].text),
              fatsTrans: _parseToInt(controllers['fatsTrans'].text),
              carbohydrates:
                  _parseToInt(controllers['carbohydrates'].text) ?? 0,
              fiber: _parseToInt(controllers['fiber'].text),
              sugar: _parseToInt(controllers['sugar'].text),
              proteins: _parseToInt(controllers['proteins'].text) ?? 0,
              salt: _parseToInt(controllers['salt'].text),
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return CommonDetailScreen(
      title: controllers['name']?.text,
      onDelete: () => context
          .read<AlimentDetailBloc>()
          .add(AlimentDetailEvent.deleteAliment(widget.aliment.id ?? 0)),
      onEditOn: _toggleEditModeOn,
      onEditOff: _toggleEditModeOff,
      body: SingleChildScrollView(
        child: BlocBuilder<AlimentDetailBloc, AlimentDetailState>(
          builder: (context, state) {
            if (state.screenStatus.isSuccess()) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.pop();
              });
            }
            if (state.screenStatus.isLoading()) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.screenStatus.isError()) {
              return const Center(child: Text('Error al cargar el alimento'));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: widget.aliment.imageBase64 != null &&
                          widget.aliment.imageBase64!.isNotEmpty
                      ? Image.memory(
                          const Base64Decoder()
                              .convert(widget.aliment.imageBase64!),
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        )
                      : const Center(
                          child: Text('Imagen no disponible',
                              style:
                                  TextStyle(fontSize: 36, color: Colors.grey)),
                        ),
                ),
                _buildSupermarketRow(),
                _buildNutrientDataTable(),
              ],
            );
          },
        ),
      ),
      isEditing: isEditing,
    );
  }

  Widget _buildSupermarketRow() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 24.0, right: 12, top: 16, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Supermarket', style: AppTheme.detailTextStyle),
          const Spacer(),
          Expanded(
            child: isEditing
                ? DropdownButtonFormField<String>(
                    value: controllers['supermarket'].value.isEmpty
                        ? null
                        : controllers['supermarket'].value,
                    onChanged: (newValue) {
                      setState(() {
                        controllers['supermarket'].value = newValue;
                      });
                    },
                    items: supermarkets
                        .map((supermarket) => DropdownMenuItem(
                            value: supermarket, child: Text(supermarket)))
                        .toList(),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: AppColors.secondaryAccent,
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0))),
                    ),
                  )
                : Text(
                    controllers['supermarket'].value.isEmpty
                        ? '-'
                        : controllers['supermarket'].value,
                    style: AppTheme.detailTextStyle,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientDataTable() {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Nutrient', style: AppTheme.detailTextStyle)),
        DataColumn(label: Text('Value', style: AppTheme.detailTextStyle)),
      ],
      rows: [
        _buildDataRow('Calories', controllers['calories']),
        _buildDataRow('Fats', controllers['fats']),
        _buildDataRow('Saturated Fats', controllers['fatsSaturated']),
        _buildDataRow(
            'Polyunsaturated Fats', controllers['fatsPolyunsaturated']),
        _buildDataRow(
            'Monounsaturated Fats', controllers['fatsMonounsaturated']),
        _buildDataRow('Trans Fats', controllers['fatsTrans']),
        _buildDataRow('Carbohydrates', controllers['carbohydrates']),
        _buildDataRow('Fiber', controllers['fiber']),
        _buildDataRow('Sugar', controllers['sugar']),
        _buildDataRow('Proteins', controllers['proteins']),
        _buildDataRow('Salt', controllers['salt']),
      ],
    );
  }

  DataRow _buildDataRow(String nutrient, TextEditingController controller) {
    return DataRow(cells: [
      DataCell(Text(nutrient, style: AppTheme.detailTextStyle, maxLines: 1)),
      DataCell(
        isEditing
            ? TextFormField(
                controller: controller, style: AppTheme.detailTextStyle)
            : Text(controller.text, style: AppTheme.detailTextStyle),
      ),
    ]);
  }

  int? _parseToInt(String text) => int.tryParse(text);
}
