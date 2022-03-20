import 'package:flutter/material.dart';
import 'package:polmeme/memeGenerator/meme_generator.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Center(
          child: ElevatedButton(
            child: Text('Gennerate Meme'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return MemeGen();
              }));
            },
          ),
        ),
      ),
    );
  }
}
