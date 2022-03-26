import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:polmeme/auth/login_page.dart';
import 'package:polmeme/memeScreen/meme_screen.dart';
import 'package:polmeme/newsScreen/news_screen.dart';
import 'package:polmeme/widget/change_theme_button.dart';
import 'package:provider/provider.dart';

import '../provider/twitter_api_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isMeme = false;

  @override
  PageController _controller = PageController();
  Widget build(BuildContext context) {
    Provider.of<TwietterApiProvider>(context, listen: false).listOfTweets;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      key: scaffoldKey,
      endDrawer: Drawer(
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
            const ListTile(
              leading: Text("Light mode"),
              title: ChangeThemeButtonWidget(),
              trailing: Text("Dark mode"),
            ),
            const ListTile(
              title: Text('Zmiana hasła'),
            ),
            ListTile(
              title: const Text('Wyloguj'),
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
        backgroundColor: Theme.of(context).backgroundColor,
        actions: [
          IconButton(
              icon: const Icon(Icons.settings),
              color: Theme.of(context).iconTheme.color,
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
                child: const Text(
                  'News',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(185, 40)),
                  backgroundColor: MaterialStateProperty.all(
                      !_isMeme ? const Color(0xff1B6569) : Colors.black),
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
                child: const Text(
                  'Meme',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(185, 40)),
                  backgroundColor: MaterialStateProperty.all(
                      _isMeme ? const Color(0xff1B6569) : Colors.black),
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
                MemeList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
