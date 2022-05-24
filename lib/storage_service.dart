import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/cupertino.dart';

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final storageRef = firebase_storage.FirebaseStorage.instance.ref();

  Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);

    try {
      await storage.ref("test/$fileName").putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult result = await storage.ref("test").listAll();
    result.items.forEach((firebase_storage.Reference ref) {
      print("Found file: $ref");
    });
    return result;
  }

  Future<String> downloadUrl(String imageName) async {
    String downloadUrl = await storage.ref("test/$imageName").getDownloadURL();
    return downloadUrl;
  }
}
