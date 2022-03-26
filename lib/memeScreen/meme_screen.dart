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
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black45,
        backgroundColor: Theme.of(context).backgroundColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        // currentIndex: _currentIndex,
        // onTap: (index) => setState(() => _currentIndex = index),
        iconSize: 30.0,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/hot.png"),
            label: "MEME",
            activeIcon: Image.asset("assets/icons/hot.png"),
          ),
          BottomNavigationBarItem(
              icon: Image.asset("assets/icons/wait.png"),
              label: "pogoda",
              activeIcon: Image.asset("assets/icons/wait.png")),
        ],
      ),
    );
  }
}
