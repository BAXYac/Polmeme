import 'dart:io';

import 'package:flutter/material.dart';
import 'package:polmeme/provider/meme_gen_provider.dart';
import 'package:provider/provider.dart';

class MemeGen extends StatefulWidget {
  const MemeGen({Key? key}) : super(key: key);

  @override
  State<MemeGen> createState() => _MemeGenState();
}

class _MemeGenState extends State<MemeGen> {
  late File _image;
  late File _imageFile;
  String _tekst = '';

  var top = 100.0;
  var left = 100.0;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    int _index = Provider.of<MemeGenProvider>(
      context,
    ).indexOfTemp;
    return Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.black,
        body: Center(
            child: ListView(
          shrinkWrap: true,
          children: [
            _index < 0
                ? SizedBox(
                    height: 150,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return item(context, index);
                        }),
                  )
                : item(context, -1),
            ..._listOfText,
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _listOfText.add(_input(index));
                  index = index + 1;
                });
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('+dodaj tekst'),
              ),
              style: ElevatedButton.styleFrom(primary: Color(0xff1B6569)),
            ),
            ElevatedButton(
              onPressed: () {
                // takeScreenshot();
              },
              child: Text('Zapisz'),
            ),
          ],
        )));
  }

  // Widget item(context, index) {
  //   return Container(
  //     width: 250,
  //     height: 250,
  //     child: Column(
  //       children: [
  //         InkWell(
  //           onTap: () {
  //             Provider.of<MemeGenProvider>(context, listen: false).indexOfTemp =
  //                 index;
  //           },
  //           // child: _image != null ? Image.file(_image) : FlutterLogo()),
  //           child: FlutterLogo(),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  List<Widget> _listOfText = [];

  Widget _input(_index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        child: TextFormField(
          onChanged: (val) {
            setState(() {
              _tekst = val;
            });
          },
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.text_fields,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    _listOfText.removeAt(_index);
                    index = index - 1;
                  });
                },
              )),
        ),
      ),
    );
  }

  Widget item(context, index) {
    return Container(
      width: 250,
      height: 250,
      child: Column(
        children: [
          GestureDetector(
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    color: Colors.yellow,
                    height: 20,
                    width: 20,
                  ),

                  // child: Text(
                  //   _tekst,
                  //   style: TextStyle(color: Colors.yellow),
                  // ),
                  left: left,
                  top: top,
                ),
                InkWell(
                  onTap: () {
                    Provider.of<MemeGenProvider>(context, listen: false)
                        .indexOfTemp = index;
                  },
                  // child: _image != null ? Image.file(_image) : FlutterLogo()),
                  child: FlutterLogo(),
                ),
              ],
            ),
          ),
          // Draggable(
          //   feedback: Text(' '),
          //   child: Text(
          //     _tekst,
          //     style: TextStyle(color: Colors.yellow),
          //   ),
          //   childWhenDragging: Text(
          //     _tekst,
          //     style: TextStyle(color: Colors.yellow),
          //   ),
          // ),
          // DragTarget(
          //   builder: (
          //     BuildContext context,
          //     List<dynamic> accepted,
          //     List<dynamic> rejected,
          //   ) {
          //     return Text(
          //       '',
          //       style: TextStyle(color: Colors.yellow),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
