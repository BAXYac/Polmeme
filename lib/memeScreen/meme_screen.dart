import 'package:flutter/material.dart';
import 'widgets/meme.dart';

class MemeList extends StatelessWidget {
  MemeList({Key? key}) : super(key: key);
  var icon = Icons.abc;
  var color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Memes(index: 0),
              Memes(index: 1),
              Memes(index: 2),
            ],
          ),
        ),
      ),

      // bottomNavigationBar: ,
    );
  }
}
