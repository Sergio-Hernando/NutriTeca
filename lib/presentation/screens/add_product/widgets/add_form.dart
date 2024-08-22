import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/constants/app_theme.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/domain/models/request/aliment_request_entity.dart';
import 'package:food_macros/presentation/screens/add_product/bloc/add_product_bloc.dart';
import 'package:food_macros/presentation/screens/add_product/bloc/add_product_event.dart';
import 'package:food_macros/presentation/screens/add_product/bloc/add_product_state.dart';
import 'package:food_macros/presentation/screens/add_product/widgets/image_picker.dart';

class AddProductForm extends StatelessWidget {
  const AddProductForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _supermarketController =
        TextEditingController();
    final TextEditingController _imageController = TextEditingController();
    final TextEditingController _caloriesController = TextEditingController();
    final TextEditingController _fatsController = TextEditingController();
    final TextEditingController _fatsSaturatedController =
        TextEditingController();
    final TextEditingController _fatsPolyunsaturatedController =
        TextEditingController();
    final TextEditingController _fatsMonounsaturatedController =
        TextEditingController();
    final TextEditingController _fatsTransController = TextEditingController();
    final TextEditingController _carbohydratesController =
        TextEditingController();
    final TextEditingController _fiberController = TextEditingController();
    final TextEditingController _sugarController = TextEditingController();
    final TextEditingController _proteinsController = TextEditingController();
    final TextEditingController _saltController = TextEditingController();

    InputDecoration _inputDecoration(String label) {
      return InputDecoration(
        hintText: label,
        hintStyle: AppTheme.descriptionTextStyle,
        filled: true,
        fillColor: AppColors.secondaryAccent,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      );
    }

    String? _requiredValidator(String? value) {
      if (value == null || value.isEmpty) {
        return 'Este campo es obligatorio';
      }
      return null;
    }

    int? _parseToInt(String text) {
      try {
        return int.tryParse(text) ?? 0;
      } catch (e) {
        return null;
      }
    }

    void _submitForm() {
      if (_formKey.currentState?.validate() ?? false) {
        final name = _nameController.text;
        final image = _imageController.text;
        final supermarket = _supermarketController.text;
        final calories = _parseToInt(_caloriesController.text);
        int? fats = _parseToInt(_fatsController.text);
        int? fatsSaturated = _parseToInt(_fatsSaturatedController.text);
        int? fatsPolyunsaturated =
            _parseToInt(_fatsPolyunsaturatedController.text);
        int? fatsMonounsaturated =
            _parseToInt(_fatsMonounsaturatedController.text);
        int? fatsTrans = _parseToInt(_fatsTransController.text);
        int? carbohydrates = _parseToInt(_carbohydratesController.text);
        int? fiber = _parseToInt(_fiberController.text);
        int? sugar = _parseToInt(_sugarController.text);
        int? proteins = _parseToInt(_proteinsController.text);
        int? salt = _parseToInt(_saltController.text);

        final aliment = AlimentRequestEntity(
            name: name,
            imageBase64: image,
            supermarket: supermarket,
            calories: calories ?? 0,
            fats: fats ?? 0,
            fatsSaturated: fatsSaturated ?? 0,
            fatsPolyunsaturated: fatsPolyunsaturated ?? 0,
            fatsMonounsaturated: fatsMonounsaturated ?? 0,
            fatsTrans: fatsTrans ?? 0,
            carbohydrates: carbohydrates ?? 0,
            fiber: fiber ?? 0,
            sugar: sugar ?? 0,
            proteins: proteins ?? 0,
            salt: salt ?? 0);

        context.read<AddProductBloc>().add(AddProductEvent.addProduct(aliment));
      }
    }

    return BlocConsumer<AddProductBloc, AddProductState>(
      listener: (context, state) {
        if (state.screenStatus.isSuccess()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Formulario enviado')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('El formulario no se ha enviado')),
          );
        }
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
                  TextFormField(
                    controller: _nameController,
                    decoration: _inputDecoration('Nombre del producto'),
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _supermarketController,
                    decoration: _inputDecoration('Supermercado'),
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: 16),
                  ImagePickerTextField(
                      validator: _requiredValidator,
                      controller: _imageController),
                  TextFormField(
                    controller: _caloriesController,
                    decoration: _inputDecoration('Calorías'),
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _fatsController,
                    decoration: _inputDecoration('Grasas'),
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _carbohydratesController,
                    decoration: _inputDecoration('Carbohidratos'),
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _proteinsController,
                    decoration: _inputDecoration('Proteínas'),
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: 16),

                  // Añadir el ExpansionTile aquí
                  ExpansionTile(
                    title: const Text('Avanzado'),
                    children: [
                      TextFormField(
                        controller: _fatsSaturatedController,
                        decoration: _inputDecoration('Grasas Saturadas'),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _fatsPolyunsaturatedController,
                        decoration: _inputDecoration('Grasas Poliinsaturadas'),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _fatsMonounsaturatedController,
                        decoration: _inputDecoration('Grasas Monoinsaturadas'),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _fatsTransController,
                        decoration: _inputDecoration('Grasas Trans'),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _fiberController,
                        decoration: _inputDecoration('Fibra'),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _sugarController,
                        decoration: _inputDecoration('Azúcares'),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _saltController,
                        decoration: _inputDecoration('Sal'),
                      ),
                    ],
                  ),

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
}
