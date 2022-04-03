import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/auth_state.dart';
import '../../auth/login_page.dart';

class WaitMemes extends StatelessWidget {
  WaitMemes({Key? key}) : super(key: key);

  List<String> wait = [
    "assets/img/hot1.png",
    "assets/img/hot2.png",
    "assets/img/hot3.png"
  ];
  @override
  Widget build(BuildContext context) {
    bool loggedIn =
        Provider.of<AuthState>(context, listen: false).auth.currentUser != null;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context2, int index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(wait[index]),
                    ),
                    myButtony(
                      loggedIn
                          ? () {}
                          : () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        backgroundColor:
                                            const Color(0xff1B6569),
                                        title: const Text(
                                            'Tylko dla zalogowanych użytkowników'),
                                        content: const Text(
                                            'Zaloguj się, aby stworzyć mema'),
                                        actions: <Widget>[
                                          TextButton(
                                            style: TextButton.styleFrom(
                                                primary: Colors.white),
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: const Text(
                                                'Jednak wolę przeglądać'),
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                                primary: Colors.white),
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginPage(),
                                                ),
                                              );
                                            },
                                            child: const Text('Zaloguj się'),
                                          ),
                                        ],
                                      ));
                            },
                    ),
                  ],
                );
              },
              itemCount: wait.length,
            ),
          ),
        ],
      ),
    );
  }

  myButtony(isLoggedIn) {
    return Row(children: [
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            textStyle: TextStyle(fontSize: 25),
          ),
          onPressed: isLoggedIn,
          child: const Text(
            "+",
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            textStyle: TextStyle(fontSize: 25),
          ),
          onPressed: isLoggedIn,
          child: const Text(
            "-",
          ),
        ),
      ),
      Container(
        width: 100,
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          textStyle: TextStyle(fontSize: 20),
        ),
        onPressed: isLoggedIn,
        child: const Text(
          "Comment",
        ),
      ),
    ]);
  }
}
