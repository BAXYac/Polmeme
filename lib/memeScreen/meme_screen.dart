import 'package:flutter/material.dart';
import 'package:polmeme/memeScreen/screens/hot_screen.dart';
import 'package:polmeme/memeScreen/screens/wait_screen.dart';

class MemeList extends StatefulWidget {
  MemeList({Key? key}) : super(key: key);

  @override
  State<MemeList> createState() => _MemeListState();
}

class _MemeListState extends State<MemeList> {
  var _selectedIndex = 0;
  List<Widget> _screens = [
    HotMeme(),
    WaitMemes(),
  ];

  @override
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _screens.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black45,
        backgroundColor: Theme.of(context).backgroundColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        iconSize: 30.0,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/hot.png"),
            label: "MEMY",
            activeIcon: Image.asset("assets/icons/hot.png"),
          ),
          BottomNavigationBarItem(
              icon: Image.asset("assets/icons/wait.png"),
              label: "POCZEKALNIA",
              activeIcon: Image.asset("assets/icons/wait.png")),
        ],
      ),
    );
  }
}
