import 'package:flutter/material.dart';
import '../widgets/my_buttony.dart';

class HotMeme extends StatelessWidget {
  HotMeme({Key? key}) : super(key: key);

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
                    const MyButtony(),
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
}
