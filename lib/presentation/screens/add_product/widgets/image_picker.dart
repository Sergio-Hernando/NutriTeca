import 'package:flutter/material.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/constants/app_theme.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class ImagePickerTextField extends StatefulWidget {
  final FormFieldValidator<String> validator;
  const ImagePickerTextField({Key? key, required this.validator})
      : super(key: key);

  @override
  ImagePickerTextFieldState createState() => ImagePickerTextFieldState();
}

class ImagePickerTextFieldState extends State<ImagePickerTextField> {
  final TextEditingController _controller = TextEditingController();
  File? _image;

  Future<void> _requestPermissions() async {
    await Permission.camera.request();
    await Permission.storage.request();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
          _controller.text = pickedFile.path;
        });
      }
    } catch (e) {
      // Manejo de excepciones
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al seleccionar imagen: $e')),
      );
    }
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _requestPermissions();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _requestPermissions();
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _controller,
          validator: widget.validator,
          decoration: InputDecoration(
            labelText: 'Imagen del producto',
            labelStyle: AppTheme.descriptionTextStyle,
            filled: true,
            fillColor: AppColors.secondaryAccent,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              onPressed: () => _showBottomSheet(context),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _image != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.file(
                  _image!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
            : Container(),
      ],
    );
  }
}
