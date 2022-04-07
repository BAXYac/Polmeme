import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AddingMeme extends StatelessWidget {
  const AddingMeme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
                child: const Text("Zaladuj zdjęcie"),
                onPressed: () async {
                  final results = await FilePicker.platform.pickFiles(
                    allowMultiple: false,
                    type: FileType.custom,
                    allowedExtensions: ['jpg', 'pdf'],
                  );
                  if (results == null) {
                    return;
                  }
                  ;
                }),
          ),
        ],
      ),
    );
  }
}
