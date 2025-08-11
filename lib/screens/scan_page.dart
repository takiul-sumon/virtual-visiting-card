import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});
  static final String name = '/scan-page';

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scan Page')),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                label: Text('Capture'),
                icon: Icon(Icons.camera),
              ),
              TextButton.icon(
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
                label: Text('Gallery'),
                icon: Icon(Icons.photo_album),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void getImage(ImageSource camera) async {
    final xFile = await ImagePicker().pickImage(source: camera);
    if (xFile != null) {
      EasyLoading.show(status: 'Please wait');
      final textRecognizer = TextRecognizer(
        script: TextRecognitionScript.latin,
      );
      final recognizeText = await textRecognizer.processImage(
        InputImage.fromFile(File(xFile.path)),
      );
      EasyLoading.dismiss();
      final List<String> tempList = [];
      for (var line in recognizeText.blocks) {
        tempList.add(line.text);
      }
    }
  }
}
