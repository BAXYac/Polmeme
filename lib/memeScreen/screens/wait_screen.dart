import 'package:flutter/material.dart';

class WaitMemes extends StatelessWidget {
  final int? index;
  WaitMemes({Key? key, this.index}) : super(key: key);

  get currentIndex => null;

  @override
  Widget build(BuildContext context) {
    return wait_meme();
  }

  List<String> wait = [
    "assets/img/hot1.png",
    "assets/img/hot2.png",
    "assets/img/hot3.png"
  ];

  Widget wait_meme() {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(wait[0]),
          ),
        ),
        myButtony(),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(wait[1]),
          ),
        ),
        myButtony(),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(wait[2]),
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
