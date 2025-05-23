import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutri_teca/core/constants/app_colors.dart';
import 'package:nutri_teca/core/constants/app_theme.dart';
import 'package:nutri_teca/core/extensions/context_extension.dart';
import 'package:nutri_teca/core/types/screen_status.dart';
import 'package:nutri_teca/domain/models/aliment_entity.dart';
import 'package:nutri_teca/domain/utils/xfile_converter.dart';
import 'package:nutri_teca/presentation/screens/aliments_feature/add_aliment/widgets/image_picker.dart';
import 'package:nutri_teca/presentation/screens/aliments_feature/aliment_detail/bloc/aliment_detail_bloc.dart';
import 'package:nutri_teca/presentation/screens/aliments_feature/aliment_detail/bloc/aliment_detail_event.dart';
import 'package:nutri_teca/presentation/screens/aliments_feature/aliment_detail/bloc/aliment_detail_state.dart';
import 'package:nutri_teca/presentation/screens/aliments_feature/aliment_detail/widgets/nutrient_table.dart';
import 'package:nutri_teca/presentation/screens/aliments_feature/aliment_detail/widgets/supermarket_row.dart';
import 'package:nutri_teca/presentation/widgets/common_detail_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutri_teca/presentation/widgets/custom_text_field.dart';

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
          onDelete: () {
            context
                .read<AlimentDetailBloc>()
                .add(AlimentDetailEvent.deleteAliment(currentAliment.id ?? 0));
            context.pop();
            context.pop();
          },
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: isEditing
                      ? CustomTextField(
                          controller: controllers['name'],
                          label: context.localizations.recipeName,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              context.localizations.name,
                              style: AppTheme.detailTextStyle,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.height *
                                          0.02),
                              child: Text(
                                controllers['name'].text ?? '',
                                style: AppTheme.titleTextStyle.copyWith(
                                  color: AppColors.secondaryAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
                SupermarketRowWidget(
                  isEditing: isEditing,
                  controllers: controllers,
                  onChanged: (newValue) {
                    setState(() {
                      controllers['supermarket']!.value = newValue!;
                    });
                  },
                ),
                NutrientDataTableWidget(
                  isEditing: isEditing,
                  controllers: controllers,
                ),
              ],
            ),
          ),
          isEditing: isEditing,
        );
      },
    );
  }

  int? _parseToInt(String text) => int.tryParse(text);
}
