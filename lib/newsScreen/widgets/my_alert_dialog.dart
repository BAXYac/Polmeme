import 'package:flutter/material.dart';
import 'package:polmeme/auth/login_page.dart';

class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      backgroundColor: const Color(0xff1B6569),
      title: const Text('Tylko dla zalogowanych użytkowników'),
      content: const Text('Zaloguj się, aby stworzyć mema'),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(primary: Colors.white),
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Jednak wolę przeglądać'),
        ),
        TextButton(
          style: TextButton.styleFrom(primary: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          },
          child: const Text('Zaloguj się'),
        ),
      ],
    );
  }
}
