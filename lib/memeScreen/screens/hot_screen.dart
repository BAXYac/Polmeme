import 'package:flutter/material.dart';
import 'package:polmeme/newsScreen/widgets/my_alert_dialog.dart';
import 'package:provider/provider.dart';
import '../../auth/auth_state.dart';

class HotMeme extends StatelessWidget {
  HotMeme({Key? key}) : super(key: key);

  List<String> hot = [
    "assets/img/a.jpg",
    "assets/img/b.jpg",
    "assets/img/c.jpg",
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
              itemBuilder: (BuildContext context2, int index2) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(hot[index2]),
                    ),
                    myButtony(
                      loggedIn
                          ? () {}
                          : () {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) =>
                                      const MyAlertDialog());
                            },
                    ),
                  ],
                );
              },
              itemCount: hot.length,
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
