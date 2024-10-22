import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_macros/core/extensions/context_extension.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function(XFile?) onImageSelected;
  final bool isSingleImage;
  final bool isEditing;
  final XFile? image;

  const ImageInput({
    super.key,
    required this.onImageSelected,
    this.isSingleImage = true,
    this.isEditing = true,
    this.image,
  });

  @override
  ImageInputState createState() => ImageInputState();
}

class ImageInputState extends State<ImageInput> {
  XFile? _selectedImage;

  @override
  void initState() {
    super.initState();
    _initializeImage();
  }

  void _initializeImage() {
    _selectedImage = widget.image;
  }

  void resetImage(XFile? newImage) {
    setState(() {
      _selectedImage = newImage;
    });
    widget.onImageSelected(_selectedImage);
  }

  @override
  void didUpdateWidget(covariant ImageInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.image != oldWidget.image) {
      _initializeImage();
    }
  }

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final selectedSource = await _showImageSourceDialog(context);

    if (selectedSource != null) {
      XFile? image;
      if (widget.isSingleImage) {
        image = await picker.pickImage(source: selectedSource);
      } else {
        final List<XFile> images = await picker.pickMultiImage();
        image = images.isNotEmpty ? images.first : null;
      }

      setState(() {
        _selectedImage = image;
      });
      widget.onImageSelected(image);
    }
  }

  Future<ImageSource?> _showImageSourceDialog(BuildContext context) {
    return showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          content: SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImageSourceOption(
                  context,
                  Icons.camera_alt,
                  context.localizations.camera,
                  ImageSource.camera,
                ),
                _buildImageSourceOption(
                  context,
                  Icons.photo,
                  context.localizations.gallery,
                  ImageSource.gallery,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageSourceOption(
      BuildContext context, IconData icon, String label, ImageSource source) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(icon, size: 40),
          onPressed: () => Navigator.of(context).pop(source),
        ),
        Text(label),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: widget.isEditing ? () => _pickImage(context) : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            height: _selectedImage == null ? 100 : 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: appTheme.inputDecorationTheme.fillColor,
              image: _selectedImage != null
                  ? DecorationImage(
                      image: FileImage(File(_selectedImage!.path)),
                      fit: BoxFit.cover,
                    )
                  : null,
              border: Border.all(
                color: appTheme
                        .inputDecorationTheme.enabledBorder?.borderSide.color ??
                    appTheme.colorScheme.onSurface,
              ),
            ),
            child: _selectedImage == null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_a_photo,
                            color: Theme.of(context).unselectedWidgetColor,
                            size: 50),
                        const SizedBox(height: 10),
                        Text(
                          context.localizations.selectOne,
                          style: appTheme.textTheme.bodyMedium?.copyWith(
                              color: appTheme.colorScheme.onSurfaceVariant),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: widget.isEditing
                            ? IconButton(
                                icon: Icon(
                                  Icons.clear,
                                  color: appTheme.colorScheme.onSurface
                                      .withOpacity(0.7),
                                ),
                                onPressed: () {
                                  resetImage(null);
                                },
                              )
                            : const SizedBox.shrink(),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
