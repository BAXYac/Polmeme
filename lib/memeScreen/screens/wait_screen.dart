import 'package:flutter/material.dart';
import '../widgets/my_buttony.dart';

class WaitMemes extends StatelessWidget {
  WaitMemes({Key? key}) : super(key: key);

  List<String> wait = [
    "assets/img/hot1.png",
    "assets/img/hot2.png",
    "assets/img/hot3.png"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context2, int index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(wait[index]),
                    ),
                    const MyButtony(),
                  ],
                );
              },
              itemCount: wait.length,
            ),
          ),
        ],
      ),
    );
  }
}
