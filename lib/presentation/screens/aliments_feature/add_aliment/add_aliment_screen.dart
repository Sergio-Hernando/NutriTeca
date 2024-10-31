import 'package:flutter/material.dart';
import 'package:nutri_teca/presentation/screens/aliments_feature/add_aliment/widgets/add_form.dart';
import 'package:nutri_teca/presentation/widgets/base_add_screen.dart';

class AddAlimentScreen extends StatelessWidget {
  AddAlimentScreen({Key? key}) : super(key: key);

  final GlobalKey<AddAlimentFormState> _formKey =
      GlobalKey<AddAlimentFormState>();

  void _submit() {
    _formKey.currentState?.submitForm();
  }

  @override
  Widget build(BuildContext context) {
    return BaseAddScreen(
      title: "Add Aliment",
      body: AddAlimentForm(key: _formKey),
      onPressed: _submit,
    );
  }
}
