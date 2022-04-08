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
          Container(
            child: Center(
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
          ),
          FutureBuilder(
            future: storage.listFiles(),
            builder:
                (context, AsyncSnapshot<firebase_storage.ListResult> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ElevatedButton(
                          child: Text(snapshot.data!.items[index].name),
                          onPressed: () {},
                        );
                      }),
                );
              }
              return CircularProgressIndicator();
            },
          ),
          FutureBuilder(
              future: storage.downloadUrl("5f5b598197bcb_o_large.jpg"),
              builder: (context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    height: 100,
                    width: 200,
                    child: Image.network(
                      snapshot.data!,
                      fit: BoxFit.cover,
                    ),
                  );
                }
                return CircularProgressIndicator();
              }),
        ],
      ),
    );
  }
}
