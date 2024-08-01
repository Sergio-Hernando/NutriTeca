import 'package:flutter/material.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/constants/app_theme.dart';
import 'package:food_macros/presentation/screens/add_product/widgets/image_picker.dart';

class AddProductForm extends StatelessWidget {
  const AddProductForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

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

    void _submitForm() {
      if (_formKey.currentState?.validate() ?? false) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Formulario enviado')),
        );
      }
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dos campos que ocupan todo el ancho arriba
              TextFormField(
                decoration: _inputDecoration('Nombre del producto'),
                validator: _requiredValidator,
              ),
              const SizedBox(height: 16),
              ImagePickerTextField(
                validator: _requiredValidator,
              ),
              TextFormField(
                decoration: _inputDecoration('Grasas'),
                validator: _requiredValidator,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: _inputDecoration('Carbohidratos'),
                validator: _requiredValidator,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: _inputDecoration('Proteinas'),
                validator: _requiredValidator,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 12.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
