import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nrich/src/services/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? imageFile;

  Future<void> getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);
    if (file?.path != null) {
      setState(() {
        imageFile = File(file!.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Image')),
      body: Center(
          child: Column(
        children: [
          imageFile != null
              ? Container(
                  child: Image.file(imageFile!),
                )
              : Container(
                  child: Image.asset('assets/placeholder.png'),
                ),
          const SizedBox(
            height: 8,
          ),
          imageFile != null
              ? ElevatedButton(
                  onPressed: () {
                    uploadImage(imageFile!);
                    setState(() {
                      imageFile = null;
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Image uploaded')));
                    });
                  },
                  child: const Text('Upload Image'))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () => getImage(source: ImageSource.gallery),
                        child: const Text('Select Image')),
                    ElevatedButton(
                        onPressed: () => getImage(source: ImageSource.camera),
                        child: const Text('Capture Image'))
                  ],
                )
        ],
      )),
    );
  }
}
