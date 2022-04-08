import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:polmeme/storage_service.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:firebase_core/firebase_core.dart' as firebase_core;

class AddingMeme extends StatelessWidget {
  const AddingMeme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();

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
                final path = results.files.single.path!;
                final fileName = results.files.single.name;

                storage
                    .uploadFile(path, fileName)
                    .then((value) => print("Done"));
              },
            ),
          ),
          FutureBuilder(
              future: storage.listFiles(),
              builder: (context,
                  AsyncSnapshot<firebase_storage.ListResult> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Container(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                snapshot.data!.items[index].name,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }
                if (snapshot.connectionState == AsyncSnapshot.waiting() ||
                    !snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return Container();
              }),
        ],
      ),
    );
  }
}
