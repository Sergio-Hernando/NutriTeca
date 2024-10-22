import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/extensions/context_extension.dart';
import 'package:food_macros/core/extensions/string_extensions.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/presentation/screens/aliments_feature/add_aliment/bloc/add_aliment_bloc.dart';
import 'package:food_macros/presentation/screens/aliments_feature/add_aliment/bloc/add_aliment_event.dart';
import 'package:food_macros/presentation/screens/aliments_feature/add_aliment/bloc/add_aliment_state.dart';
import 'package:food_macros/presentation/screens/aliments_feature/add_aliment/widgets/advanced_fields.dart';
import 'package:food_macros/presentation/screens/aliments_feature/add_aliment/widgets/custom_dropdown.dart';
import 'package:food_macros/presentation/screens/aliments_feature/add_aliment/widgets/image_picker.dart';
import 'package:food_macros/presentation/widgets/custom_text_field.dart';
import 'package:go_router/go_router.dart';

class AddAlimentForm extends StatelessWidget {
  const AddAlimentForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final controllers = _buildControllers();

    //TODO hacer esta lista comun a toda la app y no repetirla
    final list = ['Mercadona', 'Lidl', 'Aldi', 'Eroski', 'Dia', 'Alcampo'];

    void submitForm() {
      if (formKey.currentState?.validate() ?? false) {
        final aliment = AlimentEntity(
          name:
              (controllers['name'] as TextEditingController).text.capitalize(),
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
          fiber:
              _parseToInt((controllers['fiber'] as TextEditingController).text),
          sugar:
              _parseToInt((controllers['sugar'] as TextEditingController).text),
          proteins: _parseToInt(
                  (controllers['proteins'] as TextEditingController).text) ??
              0,
          salt:
              _parseToInt((controllers['salt'] as TextEditingController).text),
        );

        context.read<AddAlimentBloc>().add(AddAlimentEvent.addAliment(aliment));

        context.pop();
      }
    }

    return BlocConsumer<AddAlimentBloc, AddAlimentState>(
      listener: (context, state) {
        if (state.screenStatus.isSuccess()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.localizations.formSent)),
          );
          controllers.forEach((key, controller) {
            controller.clear();
          });
        } else if (state.screenStatus.isSuccess()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.localizations.formNotSent)),
          );
          controllers.forEach((key, controller) {
            controller.clear();
          });
        }
      },
      builder: (context, state) {
        //TODO revisar todas las exclamaciones
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    controller: controllers['name']!,
                    label: context.localizations.alimentName,
                    validator: (p0) => _requiredValidator(p0, context),
                  ),
                  const SizedBox(height: 16),
                  CustomSupermarketDropdown(
                    controllers: controllers,
                    list: list,
                  ),
                  const SizedBox(height: 16),
                  ImageInput(
                    onImageSelected: (base64Image) {
                      if (base64Image != null) {
                        controllers['image'].text = base64Image;
                      }
                    },
                  ),
                  CustomTextField(
                    controller: controllers['calories']!,
                    label: context.localizations.calories,
                    validator: (p0) => _requiredValidator(p0, context),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: controllers['fats']!,
                    label: context.localizations.fats,
                    validator: (p0) => _requiredValidator(p0, context),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: controllers['carbohydrates']!,
                    label: context.localizations.carbohydrates,
                    validator: (p0) => _requiredValidator(p0, context),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: controllers['proteins']!,
                    label: context.localizations.proteins,
                    validator: (p0) => _requiredValidator(p0, context),
                  ),
                  const SizedBox(height: 16),
                  AdvancedFields(controllers: controllers),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: submitForm,
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 12.0),
                        backgroundColor: AppColors.secondaryAccent,
                        foregroundColor: Colors.white),
                    child: Text(context.localizations.submit),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Map<String, dynamic> _buildControllers() {
    return {
      'name': TextEditingController(),
      'supermarket': SingleSelectController<String>(null),
      'image': TextEditingController(),
      'calories': TextEditingController(),
      'fats': TextEditingController(),
      'fatsSaturated': TextEditingController(),
      'fatsPolyunsaturated': TextEditingController(),
      'fatsMonounsaturated': TextEditingController(),
      'fatsTrans': TextEditingController(),
      'carbohydrates': TextEditingController(),
      'fiber': TextEditingController(),
      'sugar': TextEditingController(),
      'proteins': TextEditingController(),
      'salt': TextEditingController(),
    };
  }

  int? _parseToInt(String text) {
    try {
      return int.tryParse(text);
    } catch (e) {
      return null;
    }
  }

  String? _requiredValidator(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return context.localizations.mandatory;
    }
    return null;
  }
}
