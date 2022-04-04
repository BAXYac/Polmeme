import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/auth_state.dart';
import '../../newsScreen/widgets/my_alert_dialog.dart';

class MyButtony extends StatelessWidget {
  const MyButtony({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool loggedIn =
        Provider.of<AuthState>(context, listen: false).auth.currentUser != null;
    var isLoggedIn = loggedIn
        ? () {}
        : () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) => const MyAlertDialog());
          };
    return Row(children: [
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: loggedIn ? Colors.green : Colors.grey,
            textStyle: const TextStyle(fontSize: 25),
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
            primary: loggedIn ? Colors.red : Colors.grey,
            textStyle: const TextStyle(fontSize: 25),
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
          primary: loggedIn ? Colors.blue : Colors.grey,
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: isLoggedIn,
        child: const Text(
          "Comment",
        ),
      ),
    ]);
  }
}
