import 'package:flutter/material.dart';
import 'widgets/meme.dart';
import 'package:flutter/foundation.dart';

class MemeList extends StatefulWidget {
  MemeList({Key? key}) : super(key: key);

  @override
  State<MemeList> createState() => _MemeListState();
}

class _MemeListState extends State<MemeList> {
  var icon = Icons.abc;

  var color = Colors.white;

  var currentIndex = 1;

  int? _currentIndex;

  int? get currentIndex => _currentIndex;

  set currentIndex(int? newIndex) {
    _currentIndex = newIndex;
    notifyListeners();






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
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black45,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30.0,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("icons/house.png"),
            label: "MEME",
            activeIcon: Image.asset("icons/house-checked.png"),
          ),
          BottomNavigationBarItem(
              icon: Image.asset("icons/cloud.png"),
              label: "pogoda",
              activeIcon: Image.asset("icons/cloud-checked.png")),
        ],
      ),
    );
  }
}
