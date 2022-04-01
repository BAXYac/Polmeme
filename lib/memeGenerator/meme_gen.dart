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
  late File _imageFile;
  late String headerText = '';
  late String footerText = '';
  var rng = new Random();
  bool imageSelected = false;
  Offset offset = Offset(0, -50);
  Offset offsetBottom = Offset(0, 100);

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
    //  Directory('storage/emulated/0/' + 'MemeGenerator')
    //     .create(recursive: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            RepaintBoundary(
              key: globalKey,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
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
                      child: Positioned(
                        left: offset.dx,
                        top: offset.dy,
                        child: GestureDetector(
                            onPanUpdate: (details) {
                              setState(() {
                                offset = Offset(offset.dx + details.delta.dx,
                                    offset.dy + details.delta.dy);
                              });
                            },
                            child: SizedBox(
                              width: 300,
                              height: 300,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    headerText.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 26,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 3.0,
                                          color: Colors.black87,
                                        ),
                                        Shadow(
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 8.0,
                                          color: Colors.black87,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ),
                    Container(
                      child: Positioned(
                        left: offsetBottom.dx,
                        top: offsetBottom.dy,
                        child: GestureDetector(
                            onPanUpdate: (details) {
                              setState(() {
                                offsetBottom = Offset(
                                    offsetBottom.dx + details.delta.dx,
                                    offsetBottom.dy + details.delta.dy);
                              });
                            },
                            child: SizedBox(
                              width: 300,
                              height: 300,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    footerText.toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 26,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 3.0,
                                          color: Colors.black87,
                                        ),
                                        Shadow(
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 8.0,
                                          color: Colors.black87,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
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
    imgFile.writeAsBytes(pngBytes!);
    setState(() {
      _imageFile = imgFile;
    });
    _savefile(_imageFile);
    //saveFileLocal();
  }

  _savefile(File file) async {
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
