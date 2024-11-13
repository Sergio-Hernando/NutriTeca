import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutri_teca/core/constants/app_colors.dart';
import 'package:nutri_teca/core/extensions/context_extension.dart';
import 'package:nutri_teca/presentation/screens/aliments_feature/add_aliment/widgets/add_form.dart';

class AddAlimentScreen extends StatefulWidget {
  const AddAlimentScreen({Key? key}) : super(key: key);

  @override
  State<AddAlimentScreen> createState() => AddAlimentScreenState();
}

class AddAlimentScreenState extends State<AddAlimentScreen> {
  final GlobalKey<AddAlimentFormState> _formKey =
      GlobalKey<AddAlimentFormState>();

  bool isSaving = false;

  void _submit() {
    setState(() {
      isSaving = true;
      _formKey.currentState?.submitForm();
    });

    if (_formKey.currentState?.isFormValid ?? false) {
      GoRouter.of(context).pop(true);
    } else {
      setState(() {
        isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.foreground,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.background,
        title: Text(context.localizations.addAliment),
      ),
      body: AddAlimentForm(key: _formKey),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          setState(() {
            isSaving = true;
            _formKey.currentState?.submitForm();
          });

          if (_formKey.currentState?.isFormValid ?? false) {
            GoRouter.of(context).pop(true);
          } else {
            setState(() {
              isSaving = false;
            });
          }
        },
        backgroundColor: AppColors.secondary,
        child: const Icon(
          Icons.save_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
