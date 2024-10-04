import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/extensions/string_extensions.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/request/aliment_request_entity.dart';
import 'package:food_macros/presentation/screens/add_product/bloc/add_product_bloc.dart';
import 'package:food_macros/presentation/screens/add_product/bloc/add_product_event.dart';
import 'package:food_macros/presentation/screens/add_product/bloc/add_product_state.dart';
import 'package:food_macros/presentation/screens/add_product/widgets/advanced_fields.dart';
import 'package:food_macros/presentation/screens/add_product/widgets/custom_dropdown.dart';
import 'package:food_macros/presentation/screens/add_product/widgets/custom_text_field.dart';
import 'package:food_macros/presentation/screens/add_product/widgets/image_picker.dart';

class AddProductForm extends StatelessWidget {
  const AddProductForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final imagePickerKey = GlobalKey<ImagePickerTextFieldState>();
    final controllers = _buildControllers();

    final list = ['Mercadona', 'Lidl', 'Aldi', 'Eroski', 'Dia', 'Alcampo'];

    void submitForm() {
      if (formKey.currentState?.validate() ?? false) {
        final aliment = AlimentRequestEntity(
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

        context.read<AddProductBloc>().add(AddProductEvent.addProduct(aliment));

        imagePickerKey.currentState?.clearImage();
      }
    }

    return BlocConsumer<AddProductBloc, AddProductState>(
      listener: (context, state) {
        final messages = {
          const ScreenStatus.success(): 'Formulario enviado',
          const ScreenStatus.error(): 'El formulario no se ha enviado',
        };

        final message = messages[state.screenStatus];
        if (message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
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
                    controller: controllers['name']!,
                    label: 'Nombre del producto',
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: 16),
                  CustomSupermarketDropdown(
                    controllers: controllers,
                    list: list,
                  ),
                  const SizedBox(height: 16),
                  ImagePickerTextField(
                    key: imagePickerKey,
                    controller: controllers['image']!,
                  ),
                  CustomTextField(
                    controller: controllers['calories']!,
                    label: 'Calorías',
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: controllers['fats']!,
                    label: 'Grasas',
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: controllers['carbohydrates']!,
                    label: 'Carbohidratos',
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: controllers['proteins']!,
                    label: 'Proteínas',
                    validator: _requiredValidator,
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
                    child: const Text('Submit'),
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

  String? _requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es obligatorio';
    }
    return null;
  }
}
