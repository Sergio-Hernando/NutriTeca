import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/constants/app_theme.dart';
import 'package:food_macros/core/extensions/context_extension.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/domain/utils/xfile_converter.dart';
import 'package:food_macros/presentation/screens/aliments_feature/add_aliment/widgets/image_picker.dart';
import 'package:food_macros/presentation/screens/aliments_feature/aliment_detail/bloc/aliment_detail_bloc.dart';
import 'package:food_macros/presentation/screens/aliments_feature/aliment_detail/bloc/aliment_detail_event.dart';
import 'package:food_macros/presentation/screens/aliments_feature/aliment_detail/bloc/aliment_detail_state.dart';
import 'package:food_macros/presentation/screens/aliments_feature/widgets/supermarket_dropdown.dart';
import 'package:food_macros/presentation/widgets/common_detail_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class AlimentDetailScreen extends StatefulWidget {
  final AlimentEntity alimentEntity;

  const AlimentDetailScreen({required this.alimentEntity, Key? key})
      : super(key: key);

  @override
  State<AlimentDetailScreen> createState() => _AlimentDetailScreenState();
}

class _AlimentDetailScreenState extends State<AlimentDetailScreen> {
  bool isEditing = false;
  late AlimentEntity currentAliment;

  late Map<String, dynamic> controllers;
  XFile? _selectedImage;

  @override
  void initState() {
    super.initState();
    context
        .read<AlimentDetailBloc>()
        .add(AlimentDetailEvent.searchRecipes(widget.alimentEntity.id ?? 0));
    currentAliment = widget.alimentEntity;
    _loadAliment();
  }

  void _loadAliment() async {
    controllers = {
      'name': TextEditingController(text: currentAliment.name),
      'image': TextEditingController(text: currentAliment.imageBase64),
      'supermarket': SingleSelectController(currentAliment.supermarket),
      'calories': TextEditingController(text: '${currentAliment.calories}'),
      'fats': TextEditingController(text: '${currentAliment.fats}'),
      'fatsSaturated':
          TextEditingController(text: '${currentAliment.fatsSaturated ?? '-'}'),
      'fatsPolyunsaturated': TextEditingController(
          text: '${currentAliment.fatsPolyunsaturated ?? '-'}'),
      'fatsMonounsaturated': TextEditingController(
          text: '${currentAliment.fatsMonounsaturated ?? '-'}'),
      'fatsTrans':
          TextEditingController(text: '${currentAliment.fatsTrans ?? '-'}'),
      'carbohydrates':
          TextEditingController(text: '${currentAliment.carbohydrates}'),
      'fiber': TextEditingController(text: '${currentAliment.fiber ?? '-'}'),
      'sugar': TextEditingController(text: '${currentAliment.sugar ?? '-'}'),
      'proteins': TextEditingController(text: '${currentAliment.proteins}'),
      'salt': TextEditingController(text: '${currentAliment.salt ?? '-'}'),
    };

// TODO quitar exclamacion
    if (currentAliment.imageBase64 != null &&
        currentAliment.imageBase64!.isNotEmpty) {
      _selectedImage = await XFileConverter()
          .base64ToXFile(currentAliment.imageBase64 ?? '');
    } else {
      _selectedImage = null;
    }
    _handleImageSelection(_selectedImage);
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

      _loadAliment();
    });
  }

  void _updateAliment() {
    context.read<AlimentDetailBloc>().add(
          AlimentDetailEvent.editAliment(
            AlimentEntity(
              id: currentAliment.id,
              name: controllers['name'].text,
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

  void _handleImageSelection(XFile? image) async {
    setState(() {
      _selectedImage = image;
    });
    if (_selectedImage != null) {
      controllers['image'].text =
          await XFileConverter().convertImageToBase64(_selectedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlimentDetailBloc, AlimentDetailState>(
      builder: (context, state) {
        if (state.screenStatus.isSuccess()) {
          if (state.recipes == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.pop();
            });
          }
        }
        if (state.screenStatus.isLoading()) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.screenStatus.isError()) {
          return Center(child: Text(context.localizations.errorGetAliment));
        }
        return CommonDetailScreen(
          title: controllers['name']?.text,
          onDelete: () => context
              .read<AlimentDetailBloc>()
              .add(AlimentDetailEvent.deleteAliment(currentAliment.id ?? 0)),
          recipeList:
              state.recipes?.map((recipe) => recipe.name ?? '').toList(),
          onEditOn: _toggleEditModeOn,
          onEditOff: _toggleEditModeOff,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: currentAliment.imageBase64 != null &&
                          currentAliment.imageBase64!.isNotEmpty
                      ? ImageInput(
                          onImageSelected: (image) =>
                              _handleImageSelection(image),
                          isEditing: isEditing,
                          image: _selectedImage,
                        )
                      : !isEditing
                          ? Center(
                              child: Text(context.localizations.imageError,
                                  style: const TextStyle(
                                      fontSize: 36, color: Colors.grey)),
                            )
                          : ImageInput(
                              onImageSelected: (image) =>
                                  _handleImageSelection(image),
                              isEditing: isEditing,
                              image: _selectedImage,
                            ),
                ),
                _buildSupermarketRow(),
                _buildNutrientDataTable(),
              ],
            ),
          ),
          isEditing: isEditing,
        );
      },
    );
  }

  Widget _buildSupermarketRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(context.localizations.supermarket,
              style: AppTheme.detailTextStyle),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
          ),
          Expanded(
            child: isEditing
                ? SupermarketDropdown(
                    selectedValue: controllers['supermarket'].value.isEmpty
                        ? null
                        : controllers['supermarket'].value,
                    onChanged: (newValue) {
                      setState(() {
                        controllers['supermarket'].value = newValue;
                      });
                    },
                  )
                : Text(
                    controllers['supermarket'].value.isEmpty
                        ? '-'
                        : controllers['supermarket'].value,
                    style: AppTheme.detailTextStyle,
                    textAlign: TextAlign.end,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientDataTable() {
    return DataTable(
      columns: [
        DataColumn(
            label: Text(context.localizations.nutrient,
                style: AppTheme.detailTextStyle)),
        DataColumn(
            label: Text(context.localizations.nutrientValue,
                style: AppTheme.detailTextStyle)),
      ],
      rows: [
        _buildDataRow(context.localizations.calories, controllers['calories']),
        _buildDataRow(context.localizations.fats, controllers['fats']),
        _buildDataRow(
            context.localizations.fatsSaturated, controllers['fatsSaturated']),
        _buildDataRow(context.localizations.fatsPolyunsaturated,
            controllers['fatsPolyunsaturated']),
        _buildDataRow(context.localizations.fatsMonounsaturated,
            controllers['fatsMonounsaturated']),
        _buildDataRow(
            context.localizations.fatsTrans, controllers['fatsTrans']),
        _buildDataRow(
            context.localizations.carbohydrates, controllers['carbohydrates']),
        _buildDataRow(context.localizations.fiber, controllers['fiber']),
        _buildDataRow(context.localizations.sugar, controllers['sugar']),
        _buildDataRow(context.localizations.proteins, controllers['proteins']),
        _buildDataRow(context.localizations.salt, controllers['salt']),
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
