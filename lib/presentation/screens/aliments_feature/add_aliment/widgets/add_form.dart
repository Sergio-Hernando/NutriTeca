import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutri_teca/core/extensions/context_extension.dart';
import 'package:nutri_teca/core/extensions/string_extensions.dart';
import 'package:nutri_teca/core/types/screen_status.dart';
import 'package:nutri_teca/domain/models/aliment_entity.dart';
import 'package:nutri_teca/domain/utils/xfile_converter.dart';
import 'package:nutri_teca/presentation/screens/aliments_feature/add_aliment/bloc/add_aliment_bloc.dart';
import 'package:nutri_teca/presentation/screens/aliments_feature/add_aliment/bloc/add_aliment_event.dart';
import 'package:nutri_teca/presentation/screens/aliments_feature/add_aliment/bloc/add_aliment_state.dart';
import 'package:nutri_teca/presentation/widgets/custom_text_field.dart';
import 'advanced_fields.dart';
import 'custom_dropdown.dart';
import 'image_picker.dart';

class AddAlimentForm extends StatefulWidget {
  const AddAlimentForm({Key? key}) : super(key: key);

  @override
  AddAlimentFormState createState() => AddAlimentFormState();
}

class AddAlimentFormState extends State<AddAlimentForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _controllers = _buildControllers();
  bool isFormValid = false;

  // Validar el formulario
  void validateForm() {
    setState(() {
      isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  // Enviar el formulario si es válido
  void submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final aliment = AlimentEntity(
        name: (_controllers['name'] as TextEditingController).text.capitalize(),
        imageBase64: _controllers['image']?.text,
        supermarket:
            (_controllers['supermarket'] as SingleSelectController<String>)
                    .value ??
                '',
        calories: (_controllers['calories'] as TextEditingController)
                .text
                .parseToInt() ??
            0,
        fats:
            (_controllers['fats'] as TextEditingController).text.parseToInt() ??
                0,
        fatsSaturated: (_controllers['fatsSaturated'] as TextEditingController)
            .text
            .parseToInt(),
        fatsPolyunsaturated:
            (_controllers['fatsPolyunsaturated'] as TextEditingController)
                .text
                .parseToInt(),
        fatsMonounsaturated:
            (_controllers['fatsMonounsaturated'] as TextEditingController)
                .text
                .parseToInt(),
        fatsTrans: (_controllers['fatsTrans'] as TextEditingController)
            .text
            .parseToInt(),
        carbohydrates: (_controllers['carbohydrates'] as TextEditingController)
                .text
                .parseToInt() ??
            0,
        fiber:
            (_controllers['fiber'] as TextEditingController).text.parseToInt(),
        sugar:
            (_controllers['sugar'] as TextEditingController).text.parseToInt(),
        proteins: (_controllers['proteins'] as TextEditingController)
                .text
                .parseToInt() ??
            0,
        salt: (_controllers['salt'] as TextEditingController).text.parseToInt(),
      );

      context.read<AddAlimentBloc>().add(AddAlimentEvent.addAliment(aliment));
    }
  }

  String? validateRequiredField(String? value, BuildContext context) {
    return value == null || value.isEmpty
        ? context.localizations.fieldRequired
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddAlimentBloc, AddAlimentState>(
      listener: (context, state) {
        if (state.screenStatus.isSuccess()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Aliment added successfully")),
          );
          _controllers.forEach((_, controller) {
            controller.clear();
          });
        } else if (state.screenStatus.isError()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to add aliment")),
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              onChanged: validateForm,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _controllers['name'],
                    label: context.localizations.alimentName,
                    validator: (value) => validateRequiredField(value, context),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.01),
                    child: CustomSupermarketDropdown(
                      controllers: _controllers,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.01),
                    child: ImageInput(
                      onImageSelected: (base64Image) async {
                        if (base64Image != null) {
                          _controllers['image'].text = await XFileConverter()
                              .convertImageToBase64(base64Image);
                        }
                      },
                    ),
                  ),
                  CustomTextField(
                    controller: _controllers['calories'],
                    label: context.localizations.calories,
                    keyboardType: TextInputType.number,
                    validator: (value) => validateRequiredField(value, context),
                  ),
                  CustomTextField(
                    controller: _controllers['fats'],
                    label: context.localizations.fats,
                    keyboardType: TextInputType.number,
                    validator: (value) => validateRequiredField(value, context),
                  ),
                  CustomTextField(
                    controller: _controllers['carbohydrates'],
                    label: context.localizations.carbohydrates,
                    keyboardType: TextInputType.number,
                    validator: (value) => validateRequiredField(value, context),
                  ),
                  CustomTextField(
                    controller: _controllers['proteins'],
                    label: context.localizations.proteins,
                    keyboardType: TextInputType.number,
                    validator: (value) => validateRequiredField(value, context),
                  ),
                  AdvancedFields(controllers: _controllers),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Map<String, dynamic> _buildControllers() {
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
}
