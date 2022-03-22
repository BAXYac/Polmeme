import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    drawerTheme: DrawerThemeData(backgroundColor: Color(0xFFE0E0E12)),
    backgroundColor: Color(0xFFE0E0E12),
    textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white)),
    scaffoldBackgroundColor: Color(0xFFE0E0E12),
    colorScheme: ColorScheme.dark(),
    primaryColor: Colors.black,
    iconTheme: IconThemeData(color: Color(0xff1B6569)),
  );
  static final lightTheme = ThemeData(
    drawerTheme: DrawerThemeData(backgroundColor: Colors.white10),
    backgroundColor: Color(0xff1B6569),
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
    primaryColor: Colors.white,
    iconTheme: IconThemeData(color: Color(0xff1B6569)),
  );
}
