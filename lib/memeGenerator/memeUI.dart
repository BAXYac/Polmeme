import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polmeme/memeGenerator/meme_gen.dart';
import 'package:polmeme/memeGenerator/meme_gen2.dart';
import 'package:polmeme/newsScreen/one_news_screen.dart';
import 'package:polmeme/provider/twitter_api_provider.dart';
import 'package:provider/provider.dart';

class MemeUI extends StatefulWidget {
  const MemeUI(
      {Key? key,
      this.currentIndex,
      this.screenName,
      this.tweetTxt,
      this.tweetUrl,
      this.userName})
      : super(key: key);
  final currentIndex;
  final screenName;
  final tweetTxt;
  final tweetUrl;
  final userName;
  @override
  State<MemeUI> createState() => _MemeUIState();
}

class _MemeUIState extends State<MemeUI> {
  XFile? _image;
  late File _imageFile;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            height: 30,
            child:
                Text('Dodaj zdjęcie z galerii lub wybierz jedno z dostępnych'),
          ),
          Center(
            child: Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent)),
                    child: InkWell(
                      child: Icon(Icons.add_a_photo),
                      onTap: () {
                        getImage().whenComplete(
                            () => Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MemeGenerator(
                                      image: _image,
                                    ))));
                      },
                    ),
                  ),
                  Container(
                    child: InkWell(
                      child: Image.asset('assets/img/image1.jpg'),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Meme2(
                            image2: Image.asset('assets/img/image1.jpg'),
                          ),
                        ));
                      },
                    ),
                  ),
                  Container(
                    child: InkWell(
                      child: Image.asset('assets/img/image2.jpg'),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Meme2(
                            image2: Image.asset('assets/img/image2.jpg'),
                          ),
                        ));
                      },
                    ),
                  ),
                  Container(
                    child: InkWell(
                      child: Image.asset('assets/img/image3.jpg'),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Meme2(
                            image2: Image.asset('assets/img/image3.jpg'),
                          ),
                        ));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: OneNews(
              currentIndex: widget.currentIndex,
              screenName: widget.screenName,
              tweetTxt: widget.tweetTxt,
              tweetUrl: widget.tweetUrl,
              userName: widget.userName,
              isMeme: true,
            ),
          ),
        ],
      ),
    );
  }
}