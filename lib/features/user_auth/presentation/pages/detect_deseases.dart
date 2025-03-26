import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DetectDiseasesPage extends StatefulWidget {
  const DetectDiseasesPage({super.key});

  @override
  State<DetectDiseasesPage> createState() => _DetectDiseasesPageState();
}

class _DetectDiseasesPageState extends State<DetectDiseasesPage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();


  Future<void> captureImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to simulate scanning the image
  void scanImage() {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please capture an image first!")),
      );
      return;
    }
    // Simulate scanning process
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Scanning image...")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detect Diseases'),

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: _image == null
                ? const Text("No image captured", style: TextStyle(fontSize: 18))
                : Image.file(_image!, height: 300), // Display captured image
          ),
          SizedBox(height: 20),

          // Scan Image Button
          ElevatedButton.icon(
            onPressed: scanImage,
            icon: Icon(Icons.scanner),
            label: Text("Scan Image"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              textStyle: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: captureImage,
        child: const Icon(Icons.camera_alt),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
