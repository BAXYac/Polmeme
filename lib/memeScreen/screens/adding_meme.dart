import 'package:flutter/material.dart';

class AddingMeme extends StatelessWidget {
  const AddingMeme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              child: Text("Zaladuj zdjęcie"),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
