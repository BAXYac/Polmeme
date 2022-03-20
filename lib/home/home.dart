import 'package:flutter/material.dart';

import 'package:polmeme/memeGenerator/meme_generator.dart';

import 'package:polmeme/auth/login_page.dart';
import 'package:polmeme/newsScreen/news_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isMeme = false;

  Color myHexColor = const Color(0xff1B6569);
  @override
  PageController _controller = PageController();
  Widget build(BuildContext context) {
    bool _isOn = true;
    return Scaffold(
      backgroundColor: const Color(0xff625D5D),
      key: scaffoldKey,
      endDrawer: Drawer(
        backgroundColor: Colors.grey,
        child: ListView(
          shrinkWrap: true,
          children: [
            const ListTile(
              title: Text('Username'),
              leading: Icon(Icons.person),
            ),
            const ListTile(
              title: Text('Twoje meme'),
            ),
            const ListTile(
              title: Text('Ustawienia'),
            ),
            ListTile(
              title: const Text('Ciemny motyw'),
              trailing: Switch(
                value: _isOn,
                onChanged: (bool _isOn) {
                  setState(() {
                    _isOn = !_isOn;
                  });
                },
              ),
            ),
            const ListTile(
              title: Text('Zmiana hasła'),
            ),
            ListTile(
              title: Text('Wyloguj'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.34),
        actions: [
          IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => scaffoldKey.currentState!.openEndDrawer()),
        ],
        title: const Center(child: Text('POLMEME')),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _controller.jumpToPage(0);
                  setState(() {
                    _isMeme = false;
                  });
                },
                child: const Text('News'),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(185, 40)),
                  backgroundColor: MaterialStateProperty.all(
                      !_isMeme ? Color(0xff1B6569) : Colors.black),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18.0),
                          bottomLeft: Radius.circular(18.0)),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _controller.jumpToPage(1);
                  setState(() {
                    _isMeme = true;
                  });
                },
                child: const Text('Meme'),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(185, 40)),
                  backgroundColor: MaterialStateProperty.all(
                      _isMeme ? Color(0xff1B6569) : Colors.black),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(18.0),
                        bottomRight: Radius.circular(18.0),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: PageView(
              onPageChanged: (page) {
                if (page == 0) {
                  setState(() {
                    _isMeme = false;
                  });
                } else {
                  setState(() {
                    _isMeme = true;
                  });
                }
              },
              controller: _controller,
              children: [
                ListOfNews(),
                Container(
                  child: const Text('Meme Page'),
                  height: 50.00,
                  width: 50.00,
                  color: Colors.red,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
