import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class Meme2 extends StatefulWidget {
  final Image? image2;
  Meme2({Key? key, this.image2}) : super(key: key);

  @override
  State<Meme2> createState() => _Meme2State();
}

class _Meme2State extends State<Meme2> {
  final GlobalKey globalKey = new GlobalKey();
  late File _imageFile;
  late String headerText = '';
  late String footerText = '';
  var rng = new Random();
  bool imageSelected = false;
  Offset offset = Offset(0, -50);
  Offset offsetBottom = Offset(0, 100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            RepaintBoundary(
              key: globalKey,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Stack(
                  children: [
                    widget.image2!,
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
            Column(
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
                    child: Text('Zapisz w telefonie')),
                ElevatedButton(
                    onPressed: () {}, child: Text('Zapisz w poczekalni'))
              ],
            )
          ],
        ),
      ),
    );
  }

  takeScreenshot() async {
    RenderRepaintBoundary? boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image2 = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData? byteData =
        await image2.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();
    print(pngBytes);
    File imgFile = File('$directory/screenshot${rng.nextInt(200)}.png');
    imgFile.writeAsBytes(pngBytes!);
    setState(() {
      _imageFile = imgFile;
    });
    _savefile(_imageFile);
  }

  _savefile(File file) async {
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(await file.readAsBytes()));
    print(result);
  }
}
