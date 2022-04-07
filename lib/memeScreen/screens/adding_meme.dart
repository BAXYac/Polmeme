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
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles(
                      type: FileType.custom
                      allowedExtensions: ['jpg','pdf'],
                    );
                if (result == null) 
                  return ; // if user don't pick any thing then do nothing just return.
                PlatformFile file = result.files.first;
                  print('File Name: ${file.name}');
       print('File Size: ${file.size}');
       print('File Extension: ${file.extension}');
       print('File Path: ${file.path}');
              },
            ),
          ),
        ],
      ),
    );
  }
}
