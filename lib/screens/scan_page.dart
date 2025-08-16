import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:virtual_visiting_card/utils/constant.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});
  static final String name = '/scan-page';

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  bool isScanOver = false;
  List<String> lines = [];

  String name = '',
      mobile = '',
      website = '',
      designtaion = '',
      email = '',
      address = '',
      image = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Page'),
        actions: [
          IconButton(
            onPressed: image.isEmpty ? null : () {},
            icon: Icon(Icons.arrow_forward),
          ),
        ],
      ),
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
          if (isScanOver)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    DropTargetItem(
                      property: ContactProperties.name,
                      onDrop: getPropertyValue,
                    ),
                    DropTargetItem(
                      property: ContactProperties.mobile,
                      onDrop: getPropertyValue,
                    ),
                    DropTargetItem(
                      property: ContactProperties.website,
                      onDrop: getPropertyValue,
                    ),
                    DropTargetItem(
                      property: ContactProperties.designation,
                      onDrop: getPropertyValue,
                    ),
                    DropTargetItem(
                      property: ContactProperties.email,
                      onDrop: getPropertyValue,
                    ),
                    DropTargetItem(
                      property: ContactProperties.address,
                      onDrop: getPropertyValue,
                    ),
                  ],
                ),
              ),
            ),
          Wrap(children: lines.map((e) => LineItem(line: e)).toList()),
        ],
      ),
    );
  }

  void getImage(ImageSource camera) async {
    final xFile = await ImagePicker().pickImage(source: camera);
    if (xFile != null) {
      setState(() {
        image = xFile.path;
      });
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
      setState(() {
        lines = tempList;
        isScanOver = true;
      });
    }
  }

  getPropertyValue(String property, String value) {}
}

class LineItem extends StatelessWidget {
  const LineItem({super.key, required this.line});
  final String line;
  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      dragAnchorStrategy: childDragAnchorStrategy,
      feedback: Container(
        key: GlobalKey(),
        decoration: BoxDecoration(color: Colors.black45),
        child: Text(
          line,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(color: Colors.white),
        ),
      ),
      data: line,
      child: Center(child: Chip(label: Text(line))),
    );
  }
}

class DropTargetItem extends StatefulWidget {
  const DropTargetItem({
    super.key,
    required this.property,
    required this.onDrop,
  });
  final String property;
  final Function(String, String) onDrop;

  @override
  State<DropTargetItem> createState() => _DropTargetItemState();
}

class _DropTargetItemState extends State<DropTargetItem> {
  String dragItem = '';
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text(widget.property)),
        Expanded(
          child: DragTarget<String>(
            builder: (context, candidateData, rejectedData) => Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: candidateData.isNotEmpty
                    ? Border.all(color: Colors.red, width: 2)
                    : null,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(dragItem.isEmpty ? 'Drop Here' : dragItem),
                  ),
                  if (dragItem.isNotEmpty)
                    InkWell(
                      onTap: () {
                        setState(() {
                          dragItem = '';
                        });
                      },
                      child: Icon(Icons.clear),
                    ),
                ],
              ),
            ),
            onAccept: (data) {
              setState(() {
                if (dragItem.isEmpty) {
                  dragItem = data;
                } else {
                  dragItem += '   $data';
                }
              });
              widget.onDrop(widget.property, dragItem);
            },
          ),
        ),
      ],
    );
  }
}
