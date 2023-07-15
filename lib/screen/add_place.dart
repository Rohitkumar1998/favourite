import 'package:favourite/screen/providers/user_places.dart';
import 'package:favourite/widget/image_input.dart';
import 'package:favourite/widget/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});
  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenStete();
}

class _AddPlaceScreenStete extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  void _savePlace() {
    final enteredText = _titleController.text;
    if (enteredText.isEmpty || _selectedImage == null) {
      return;
    }
    ref.read(userPlaceProvider.notifier).addPlace(enteredText, _selectedImage!);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add new Place')),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          TextField(
            decoration: InputDecoration(
              label: Text("Title"),
            ),
            controller: _titleController,
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(
            height: 10,
          ),
          InputImage(
            onPickImage: (image) {
              _selectedImage = image;
            },
          ),
          SizedBox(
            height: 16,
          ),
          LocationInput(),
          SizedBox(
            height: 10,
          ),
          ElevatedButton.icon(
              onPressed: _savePlace,
              icon: Icon(Icons.add),
              label: Text('Add Place'))
        ]),
      )),
    );
  }
}
