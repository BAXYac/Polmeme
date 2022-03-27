import 'package:flutter/material.dart';

class HotMemeScreen extends StatelessWidget {
  HotMemeScreen({Key? key}) : super(key: key);

  List<String> hot = [
    "assets/img/a.jpg",
    "assets/img/b.jpg",
    "assets/img/c.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context2, int index2) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(hot[index2]),
                    ),
                    myButtony(),
                  ],
                );
              },
              itemCount: hot.length,
            ),
          ),
        ],
      ),
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
