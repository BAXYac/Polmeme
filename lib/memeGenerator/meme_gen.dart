import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:path_provider/path_provider.dart';

class MemeGenerator extends StatefulWidget {
  MemeGenerator({Key? key}) : super(key: key);

  @override
  State<MemeGenerator> createState() => _MemeGeneratorState();
}

class _MemeGeneratorState extends State<MemeGenerator> {
  final GlobalKey globalKey = new GlobalKey();
  XFile? _image;
  late XFile _imageFile;
  late String headerText = '';
  late String footerText = '';
  var rng = new Random();
  bool imageSelected = false;

  Future getImage() async {
    XFile? image;
    try {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
    } catch (platformException) {
      print("not allowing " + platformException.toString());
    }
    setState(() {
      if (image != null) {
        imageSelected = true;
      } else {}
      _image = image;
    });
    new Directory('storage/emulated/0/' + 'MemeGenerator')
        .create(recursive: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: [
            Image.asset('assets/img/image1.jpg'),
            SizedBox(
              height: 12,
            ),
            Image.asset('assets/img/image2.jpg'),
            RepaintBoundary(
              key: globalKey,
              child: Stack(
                children: [
                  _image != null
                      ? Image.file(
                          File(_image!.path),
                          height: 300,
                          fit: BoxFit.fitHeight,
                        )
                      : Container(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          headerText.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 26),
                        ),
                        Spacer(),
                        Text(
                          footerText.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 26),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            imageSelected
                ? Column(
                    children: [
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            headerText = value;
                          });
                        },
                        decoration: InputDecoration(hintText: 'Header Text'),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            footerText = value;
                          });
                        },
                        decoration: InputDecoration(hintText: 'Footer Text'),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            takeScreenshot();
                          },
                          child: Text('Zapisz')),
                    ],
                  )
                : Container(
                    child: Text('Wybierz obraz'),
                  ),
            // _imageFile != null ? Image.file(File(_image!.path)) : Container(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImage();
        },
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  takeScreenshot() async {
    RenderRepaintBoundary? boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();
    print(pngBytes);
    File imgFile = File('$directory/screenshot${rng.nextInt(200)}.png');
    setState(() {
      _imageFile = imgFile as XFile;
    });
    _savefile(_imageFile);
    //saveFileLocal();

    imgFile.writeAsBytes(pngBytes!);
  }

  _savefile(XFile file) async {
    // await _askPermission();
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(await file.readAsBytes()));
    print(result);
  }

  // _askPermission() async {
  //   Map<PermissionGroup, ph.PermissionStatus> permissions =
  //       await PermissionHandler().requestPermissions([PermissionGroup.photos]);
  // }
}
