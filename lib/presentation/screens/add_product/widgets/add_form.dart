import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/request/aliment_request_entity.dart';
import 'package:food_macros/presentation/screens/add_product/bloc/add_product_bloc.dart';
import 'package:food_macros/presentation/screens/add_product/bloc/add_product_event.dart';
import 'package:food_macros/presentation/screens/add_product/bloc/add_product_state.dart';
import 'package:food_macros/presentation/screens/add_product/widgets/advanced_fields.dart';
import 'package:food_macros/presentation/screens/add_product/widgets/custom_text_field.dart';
import 'package:food_macros/presentation/screens/add_product/widgets/image_picker.dart';

class AddProductForm extends StatelessWidget {
  const AddProductForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final controllers = _buildControllers();

    void submitForm() {
      if (formKey.currentState?.validate() ?? false) {
        final aliment = AlimentRequestEntity(
          name: controllers['name']!.text,
          imageBase64: controllers['image']!.text,
          supermarket: controllers['supermarket']!.text,
          calories: _parseToInt(controllers['calories']!.text) ?? 0,
          fats: _parseToInt(controllers['fats']!.text) ?? 0,
          fatsSaturated: _parseToInt(controllers['fatsSaturated']!.text) ?? 0,
          fatsPolyunsaturated:
              _parseToInt(controllers['fatsPolyunsaturated']!.text) ?? 0,
          fatsMonounsaturated:
              _parseToInt(controllers['fatsMonounsaturated']!.text) ?? 0,
          fatsTrans: _parseToInt(controllers['fatsTrans']!.text) ?? 0,
          carbohydrates: _parseToInt(controllers['carbohydrates']!.text) ?? 0,
          fiber: _parseToInt(controllers['fiber']!.text) ?? 0,
          sugar: _parseToInt(controllers['sugar']!.text) ?? 0,
          proteins: _parseToInt(controllers['proteins']!.text) ?? 0,
          salt: _parseToInt(controllers['salt']!.text) ?? 0,
        );

        context.read<AddProductBloc>().add(AddProductEvent.addProduct(aliment));
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
                  CustomTextField(
                    controller: controllers['supermarket']!,
                    label: 'Supermercado',
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: 16),
                  ImagePickerTextField(
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

  Map<String, TextEditingController> _buildControllers() {
    return {
      'name': TextEditingController(),
      'supermarket': TextEditingController(),
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
      return int.tryParse(text) ?? 0;
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
