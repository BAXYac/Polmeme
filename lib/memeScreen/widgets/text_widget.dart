import 'package:flutter/material.dart';

class MyTextWidget extends StatelessWidget {
  String? text;
  // late String text; - to samo co String? - zaciągnie ta daną potem
  Color? color;
  double? size;

  MyTextWidget({
    this.text,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
        color: color!,
        fontWeight: FontWeight.bold,
        fontSize: size,
      ),
    );
  }
}
