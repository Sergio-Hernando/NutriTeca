import 'dart:convert';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/constants/app_theme.dart';
import 'package:food_macros/core/extensions/string_extensions.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/presentation/screens/aliments_feature/aliment_detail/bloc/aliment_detail_bloc.dart';
import 'package:food_macros/presentation/screens/aliments_feature/aliment_detail/bloc/aliment_detail_event.dart';
import 'package:food_macros/presentation/screens/aliments_feature/aliment_detail/bloc/aliment_detail_state.dart';
import 'package:go_router/go_router.dart';

class AlimentDetailScreen extends StatefulWidget {
  final AlimentEntity aliment;

  const AlimentDetailScreen({
    required this.aliment,
    Key? key,
  }) : super(key: key);

  @override
  State<AlimentDetailScreen> createState() => _AlimentDetailScreenState();
}

class _AlimentDetailScreenState extends State<AlimentDetailScreen> {
  bool isEditing = false;

  late Map<String, dynamic> controllers;
  final list = ['Mercadona', 'Lidl', 'Aldi', 'Eroski', 'Dia', 'Alcampo'];

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
          AlimentDetailEvent.editAliment(AlimentEntity(
            id: widget.aliment.id,
            name: (controllers['name'] as TextEditingController)
                .text
                .capitalize(),
            imageBase64: (controllers['image'] as TextEditingController).text,
            supermarket:
                (controllers['supermarket'] as SingleSelectController<String>)
                        .value ??
                    '',
            calories: _parseToInt(
                    (controllers['calories'] as TextEditingController).text) ??
                0,
            fats: _parseToInt(
                    (controllers['fats'] as TextEditingController).text) ??
                0,
            fatsSaturated: _parseToInt(
                (controllers['fatsSaturated'] as TextEditingController).text),
            fatsPolyunsaturated: _parseToInt(
                (controllers['fatsPolyunsaturated'] as TextEditingController)
                    .text),
            fatsMonounsaturated: _parseToInt(
                (controllers['fatsMonounsaturated'] as TextEditingController)
                    .text),
            fatsTrans: _parseToInt(
                (controllers['fatsTrans'] as TextEditingController).text),
            carbohydrates: _parseToInt(
                    (controllers['carbohydrates'] as TextEditingController)
                        .text) ??
                0,
            fiber: _parseToInt(
                (controllers['fiber'] as TextEditingController).text),
            sugar: _parseToInt(
                (controllers['sugar'] as TextEditingController).text),
            proteins: _parseToInt(
                    (controllers['proteins'] as TextEditingController).text) ??
                0,
            salt: _parseToInt(
                (controllers['salt'] as TextEditingController).text),
          )),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.foreground,
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.aliment.name?.capitalize() ?? '',
            style: AppTheme.titleTextStyle,
          ),
        ),
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        actions: [
          if (!isEditing)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.white),
              onPressed: () => context.read<AlimentDetailBloc>().add(
                  AlimentDetailEvent.deleteAliment(widget.aliment.id ?? 0)),
            ),
        ],
      ),
      body: BlocBuilder<AlimentDetailBloc, AlimentDetailState>(
        builder: (context, state) {
          if (state.screenStatus.isSuccess()) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.pop();
            });
          }

          if (state.screenStatus.isLoading()) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.screenStatus.isError()) {
            return const Center(
              child: Text('Error al cargar los alimentos'),
            );
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.memory(
                    const Base64Decoder()
                        .convert(widget.aliment.imageBase64 ?? ''),
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24.0, right: 12, top: 16, bottom: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Supermarket',
                        style: AppTheme.detailTextStyle,
                        maxLines: 1,
                      ),
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
                                items: list.map((String supermarket) {
                                  return DropdownMenuItem<String>(
                                    value: supermarket,
                                    child: Text(supermarket),
                                  );
                                }).toList(),
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.secondaryAccent,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                ),
                              )
                            : Text(
                                controllers['supermarket'].value,
                                style: AppTheme.detailTextStyle,
                              ),
                      ),
                    ],
                  ),
                ),
                _buildDataTable(),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (isEditing)
            FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: _toggleEditModeOff,
              backgroundColor: Colors.red,
              child: const Icon(
                Icons.cancel,
                color: AppColors.foreground,
              ),
            ),
          const SizedBox(width: 16),
          FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: _toggleEditModeOn,
            backgroundColor: AppColors.secondary,
            child: Icon(
              isEditing ? Icons.save : Icons.edit,
              color: AppColors.foreground,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataTable() {
    return DataTable(
      columns: const [
        DataColumn(
          label: Text('Nutrient', style: AppTheme.detailTextStyle),
        ),
        DataColumn(
          label: Text('Value', style: AppTheme.detailTextStyle),
        ),
      ],
      rows: [
        //_buildDataRow('Supermarket', controllers['supermarket']!),
        _buildDataRow('Calories', controllers['calories']!),
        _buildDataRow('Fats', controllers['fats']!),
        _buildDataRow('Saturated Fats', controllers['fatsSaturated']!),
        _buildDataRow(
            'Polyunsaturated Fats', controllers['fatsPolyunsaturated']!),
        _buildDataRow(
            'Monounsaturated Fats', controllers['fatsMonounsaturated']!),
        _buildDataRow('Trans Fats', controllers['fatsTrans']!),
        _buildDataRow('Carbohydrates', controllers['carbohydrates']!),
        _buildDataRow('Fiber', controllers['fiber']!),
        _buildDataRow('Sugar', controllers['sugar']!),
        _buildDataRow('Proteins', controllers['proteins']!),
        _buildDataRow('Salt', controllers['salt']!),
      ],
    );
  }

  DataRow _buildDataRow(String nutrient, TextEditingController controller) {
    return DataRow(cells: [
      DataCell(Text(
        nutrient,
        style: AppTheme.detailTextStyle,
        maxLines: 1,
      )),
      DataCell(
        isEditing
            ? TextFormField(
                controller: controller,
                style: AppTheme.detailTextStyle,
              )
            : Text(
                controller.text,
                style: AppTheme.detailTextStyle,
              ),
      ),
    ]);
  }

  int? _parseToInt(String text) {
    try {
      return int.tryParse(text);
    } catch (e) {
      return null;
    }
  }
}
