import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path_provider/path_provider.dart';
import 'package:polmeme/newsScreen/news_screen.dart';
import 'package:polmeme/newsScreen/widgets/one_news_screen.dart';

class MemeGenerator extends StatefulWidget {
  final XFile? image;

  final currentIndex;
  final screenName;
  final tweetTxt;
  final tweetUrl;
  final userName;
  final String profileUrl;
  final image2;
  MemeGenerator(
      {Key? key,
      this.image,
      required this.currentIndex,
      required this.screenName,
      required this.tweetTxt,
      required this.tweetUrl,
      required this.userName,
      required this.profileUrl,
      this.image2})
      : super(key: key);

  @override
  State<MemeGenerator> createState() => _MemeGeneratorState();
}

class _MemeGeneratorState extends State<MemeGenerator> {
  final GlobalKey globalKey = new GlobalKey();
  late File _imageFile;
  late String headerText = '';
  late String footerText = '';
  var rng = new Random();
  bool imageSelected = false;
  bool isNew = true;
  bool backColor = false;
  Offset offset = Offset(0, -50);
  Offset offsetBottom = Offset(0, 100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            RepaintBoundary(
              key: globalKey,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Stack(
                  children: [
                    widget.image != null
                        ? Image.file(
                            File(widget.image!.path),
                            height: 300,
                            fit: BoxFit.fitHeight,
                          )
                        : widget.image2,
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
                                    style: TextStyle(
                                      backgroundColor: backColor == true
                                          ? Colors.black
                                          : Colors.transparent,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 26,
                                      shadows: const <Shadow>[
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
                                    style: TextStyle(
                                      backgroundColor: backColor == true
                                          ? Colors.black
                                          : Colors.transparent,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 26,
                                      shadows: const <Shadow>[
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
            Column(
              children: [
                Row(children: [
                  Checkbox(
                      value: backColor,
                      onChanged: (value) {
                        setState(() {
                          backColor = value!;
                        });
                      }),
                  Text('Tło tekstu'),
                ]),
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
                OneNews(
                  currentIndex: widget.currentIndex,
                  screenName: widget.screenName,
                  tweetTxt: widget.tweetTxt,
                  tweetUrl: widget.tweetUrl,
                  userName: widget.userName,
                  isMeme: true,
                  profileUrl: widget.profileUrl,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          takeScreenshot();
                        },
                        child: Text('Zapisz w telefonie')),
                    ElevatedButton(
                        onPressed: () {}, child: Text('Zapisz w poczekalni')),
                    ElevatedButton(
                        onPressed: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => ListOfNews()));
                        },
                        child: Text('Anuluj')),
                  ],
                ),
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
  }

  _savefile(File file) async {
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(await file.readAsBytes()));
    print(result);
  }
}
