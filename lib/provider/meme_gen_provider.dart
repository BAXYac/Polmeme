import 'package:flutter/material.dart';

class MemeGenProvider extends ChangeNotifier {
  int _indexOfTemp = -1;

  int get indexOfTemp => _indexOfTemp;

  set indexOfTemp(int newIndex) {
    _indexOfTemp = newIndex;
    notifyListeners();
  }
}
