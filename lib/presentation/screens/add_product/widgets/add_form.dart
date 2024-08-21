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

    final TextEditingController _nombreController = TextEditingController();
    final TextEditingController _grasasController = TextEditingController();
    final TextEditingController _carbohidratosController =
        TextEditingController();
    final TextEditingController _proteinasController = TextEditingController();

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

    int? _parseToDouble(String text) {
      try {
        return int.tryParse(text) ??
            0; // Retorna 0.0 si el texto no es un número válido
      } catch (e) {
        return null; // Maneja el caso donde la conversión falla
      }
    }

    void _submitForm() {
      if (_formKey.currentState?.validate() ?? false) {
        final nombre = _nombreController.text;
        int? grasas = _parseToDouble(_grasasController.text);
        int? carbohidratos = _parseToDouble(_carbohidratosController.text);
        int? proteinas = _parseToDouble(_proteinasController.text);

        final aliment = AlimentRequestEntity(
            nombre: nombre,
            imagen_base64: 'imagen_base64',
            calorias: 0,
            grasas: grasas ?? 0,
            carbohidratos: carbohidratos ?? 0,
            proteinas: proteinas ?? 0);

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
                    controller: _nombreController,
                    decoration: _inputDecoration('Nombre del producto'),
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: 16),
                  // Este es un campo de texto personalizado que necesitas definir
                  // Asegúrate de que tenga un controlador si es necesario
                  ImagePickerTextField(
                    validator: _requiredValidator,
                  ),
                  TextFormField(
                    controller: _grasasController,
                    decoration: _inputDecoration('Grasas'),
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _carbohidratosController,
                    decoration: _inputDecoration('Carbohidratos'),
                    validator: _requiredValidator,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _proteinasController,
                    decoration: _inputDecoration('Proteínas'),
                    validator: _requiredValidator,
                  ),
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
}
