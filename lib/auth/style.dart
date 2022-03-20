// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyTextWidget extends StatelessWidget {
  String? text;
  Color? color = Colors.black;
  double? size = 20;

  MyTextWidget({
    this.text,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text!,
        style: TextStyle(
          color: color,
          fontSize: size,
        ),
        textAlign: TextAlign.start);
  }
}
