import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final _formKey = GlobalKey<FormState>();
    final _controllers = _buildControllers();

    void _submitForm() {
      if (_formKey.currentState?.validate() ?? false) {
        final aliment = AlimentRequestEntity(
          name: _controllers['name']!.text,
          imageBase64: _controllers['image']!.text,
          supermarket: _controllers['supermarket']!.text,
          calories: _parseToInt(_controllers['calories']!.text) ?? 0,
          fats: _parseToInt(_controllers['fats']!.text) ?? 0,
          fatsSaturated: _parseToInt(_controllers['fatsSaturated']!.text) ?? 0,
          fatsPolyunsaturated:
              _parseToInt(_controllers['fatsPolyunsaturated']!.text) ?? 0,
          fatsMonounsaturated:
              _parseToInt(_controllers['fatsMonounsaturated']!.text) ?? 0,
          fatsTrans: _parseToInt(_controllers['fatsTrans']!.text) ?? 0,
          carbohydrates: _parseToInt(_controllers['carbohydrates']!.text) ?? 0,
          fiber: _parseToInt(_controllers['fiber']!.text) ?? 0,
          sugar: _parseToInt(_controllers['sugar']!.text) ?? 0,
          proteins: _parseToInt(_controllers['proteins']!.text) ?? 0,
          salt: _parseToInt(_controllers['salt']!.text) ?? 0,
        );

        context.read<AddProductBloc>().add(AddProductEvent.addProduct(aliment));
      }
    }

    return BlocConsumer<AddProductBloc, AddProductState>(
      listener: (context, state) {
        final message = state.screenStatus.isSuccess()
            ? 'Formulario enviado'
            : 'El formulario no se ha enviado';
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    controller: _controllers['name']!,
                    label: 'Nombre del producto',
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _controllers['supermarket']!,
                    label: 'Supermercado',
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: 16),
                  ImagePickerTextField(
                    validator: _requiredValidator,
                    controller: _controllers['image']!,
                  ),
                  CustomTextField(
                    controller: _controllers['calories']!,
                    label: 'Calorías',
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _controllers['fats']!,
                    label: 'Grasas',
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _controllers['carbohydrates']!,
                    label: 'Carbohidratos',
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _controllers['proteins']!,
                    label: 'Proteínas',
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: 16),
                  AdvancedFields(controllers: _controllers),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 12.0),
                    ),
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
