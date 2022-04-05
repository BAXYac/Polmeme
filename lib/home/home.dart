import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:polmeme/auth/auth_state.dart';

import 'package:polmeme/auth/login_page.dart';
import 'package:polmeme/memeScreen/meme_screen.dart';
import 'package:polmeme/newsScreen/news_screen.dart';

import 'package:polmeme/provider/theme_provider.dart';

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
  @override
  PageController _controller = PageController();
  Widget build(BuildContext context) {
    Provider.of<TwietterApiProvider>(context, listen: false).getData();
    bool loggedIn =
        Provider.of<AuthState>(context, listen: false).auth.currentUser != null;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      key: scaffoldKey,
      endDrawer: Drawer(
        child: ListView(
          shrinkWrap: true,
          children: [
            if (loggedIn)
              ListTile(
                title: FutureBuilder(
                    future: Provider.of<AuthState>(context, listen: false)
                        .getCurrentUserEmail(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data.toString());
                      } else {
                        return Text("Szanowny kierowniku, może konto?");
                      }
                    }),
                leading: Icon(Icons.person),
              ),
            if (loggedIn)
              const ListTile(
                title: Text('Twoje meme'),
              ),
            if (loggedIn)
              const ListTile(
                title: Text('Ustawienia'),
              ),
            ListTile(
              title: const Text('Ciemny motyw?'),
              trailing: IconButton(
                  onPressed: () {
                    ThemeProvider themeProvider =
                        Provider.of<ThemeProvider>(context, listen: false);
                    themeProvider.swapTheme();
                  },
                  icon: const Icon(Icons.brightness_6)),
            ),
            if (loggedIn)
              ListTile(
                title: const Text('Zmiana hasła'),
                onTap: () {},
              ),
            ListTile(
              title:
                  loggedIn ? const Text('Wyloguj') : const Text('Zaloguj się'),
              onTap: () {
                Provider.of<AuthState>(context, listen: false)
                    .signOutWithEmail()
                    .whenComplete(
                      () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
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
