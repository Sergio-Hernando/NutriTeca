import 'package:flutter/material.dart';
import 'package:food_macros/presentation/screens/add_product/widgets/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

import 'package:permission_handler/permission_handler.dart';

class ImagePickerTextField extends StatefulWidget {
  final TextEditingController controller;
  const ImagePickerTextField({Key? key, required this.controller})
      : super(key: key);

  @override
  ImagePickerTextFieldState createState() => ImagePickerTextFieldState();
}

class ImagePickerTextFieldState extends State<ImagePickerTextField> {
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
        });

        final bytes = await _image!.readAsBytes();
        final base64Image = base64Encode(bytes);

        widget.controller.text = base64Image;
      }
    } catch (e) {
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
                title: const Text('Cámara'),
                onTap: () {
                  Navigator.of(context).pop();
                  _requestPermissions();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Galería'),
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

  void clearImage() {
    setState(() {
      _image = null;
    });
    widget.controller.clear(); // Esto también vacía el controlador
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          controller: widget.controller,
          label: 'Imagen del producto',
          icon: IconButton(
            icon: const Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
            onPressed: () => _showBottomSheet(context),
          ),
        ),
        _image != null
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.file(
                    _image!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Container(),
              ),
      ],
    );
  }
}
