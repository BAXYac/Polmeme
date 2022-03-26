import 'package:flutter/material.dart';

class Memes extends StatelessWidget {
  final int? index;
  Memes({Key? key, this.index}) : super(key: key);

  get currentIndex => null;

  @override
  Widget build(BuildContext context) {
    return currentIndex == 1 ? hot_meme(index) : wait_meme(index);
  }

  List<String> hot = [
    "assets/img/a.jpg",
    "assets/img/b.jpg",
    "assets/img/c.jpg"
  ];

  List<String> wait = [
    "assets/img/hot1.png",
    "assets/img/hot2.png",
    "assets/img/hot3.png"
  ];

  Widget hot_meme(index) {
    return Column(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(hot[index]),
          ),
        ),
        myButtony(),
      ],
    );
  }

  Widget wait_meme(index) {
    return Column(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(wait[index]),
          ),
        ),
        myButtony(),
      ],
    );
  }

  myButtony() {
    return Row(children: [
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            textStyle: TextStyle(fontSize: 25),
          ),
          onPressed: () {},
          child: const Text(
            "+",
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            textStyle: TextStyle(fontSize: 25),
          ),
          onPressed: () {},
          child: const Text(
            "-",
          ),
        ),
      ),
      Container(
        width: 100,
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          textStyle: TextStyle(fontSize: 20),
        ),
        onPressed: () {},
        child: const Text(
          "Comment",
        ),
      ),
    ]);
  }
}
