import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/extensions/context_extension.dart';
import 'package:food_macros/core/extensions/string_extensions.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/aliment_entity.dart';
import 'package:food_macros/domain/utils/xfile_converter.dart';
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

    void submitForm() {
      if (formKey.currentState?.validate() ?? false) {
        final aliment = AlimentEntity(
          name:
              (controllers['name'] as TextEditingController).text.capitalize(),
          imageBase64: (controllers['image']).text,
          supermarket:
              (controllers['supermarket'] as SingleSelectController<String>)
                      .value ??
                  '',
          calories: (controllers['calories'] as TextEditingController)
                  .text
                  .parseToInt() ??
              0,
          fats: (controllers['fats'] as TextEditingController)
                  .text
                  .parseToInt() ??
              0,
          fatsSaturated: (controllers['fatsSaturated'] as TextEditingController)
              .text
              .parseToInt(),
          fatsPolyunsaturated:
              (controllers['fatsPolyunsaturated'] as TextEditingController)
                  .text
                  .parseToInt(),
          fatsMonounsaturated:
              (controllers['fatsMonounsaturated'] as TextEditingController)
                  .text
                  .parseToInt(),
          fatsTrans: (controllers['fatsTrans'] as TextEditingController)
              .text
              .parseToInt(),
          carbohydrates: (controllers['carbohydrates'] as TextEditingController)
                  .text
                  .parseToInt() ??
              0,
          fiber:
              (controllers['fiber'] as TextEditingController).text.parseToInt(),
          sugar:
              (controllers['sugar'] as TextEditingController).text.parseToInt(),
          proteins: (controllers['proteins'] as TextEditingController)
                  .text
                  .parseToInt() ??
              0,
          salt:
              (controllers['salt'] as TextEditingController).text.parseToInt(),
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
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    controller: controllers['name'],
                    label: context.localizations.alimentName,
                    validator: (p0) => _requiredValidator(p0, context),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.01),
                    child: CustomSupermarketDropdown(
                      controllers: controllers,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.01),
                    child: ImageInput(
                      onImageSelected: (base64Image) async {
                        if (base64Image != null) {
                          controllers['image'].text = await XFileConverter()
                              .convertImageToBase64(base64Image);
                        }
                      },
                    ),
                  ),
                  CustomTextField(
                    controller: controllers['calories'],
                    label: context.localizations.calories,
                    validator: (p0) => _requiredValidator(p0, context),
                  ),
                  CustomTextField(
                    controller: controllers['fats'],
                    label: context.localizations.fats,
                    validator: (p0) => _requiredValidator(p0, context),
                  ),
                  CustomTextField(
                    controller: controllers['carbohydrates'],
                    label: context.localizations.carbohydrates,
                    validator: (p0) => _requiredValidator(p0, context),
                  ),
                  CustomTextField(
                    controller: controllers['proteins'],
                    label: context.localizations.proteins,
                    validator: (p0) => _requiredValidator(p0, context),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.01),
                    child: AdvancedFields(controllers: controllers),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.01),
                    child: ElevatedButton(
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

  String? _requiredValidator(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return context.localizations.mandatory;
    }
    return null;
  }
}
