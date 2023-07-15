import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class InputImage extends StatefulWidget {
  const InputImage({super.key, required this.onPickImage});
  final void Function(File image) onPickImage;
  State<InputImage> createState() => _InputImage();
}

class _InputImage extends State<InputImage> {
  File? _selectedImge;
  void _takePicture() async {
    final imagepicker = ImagePicker();
    final pickedImage =
        await imagepicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImge = File(pickedImage.path);
    });
    widget.onPickImage(_selectedImge!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      icon: const Icon(Icons.camera),
      label: const Text('Take Picture'),
      onPressed: _takePicture,
    );
    if (_selectedImge != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _selectedImge!,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      );
    }
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2))),
        height: 250,
        width: double.infinity,
        alignment: Alignment.center,
        child: content);
  }
}
