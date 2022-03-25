import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeData _selectedTheme;

  ThemeData light = ThemeData.light().copyWith(
    backgroundColor: Color.fromARGB(255, 142, 179, 166),
    appBarTheme: AppBarTheme(
      // color: Colors.white,
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 20.00, fontWeight: FontWeight.bold),
    ),
  );

  ThemeData dark = ThemeData.dark().copyWith(primaryColor: Colors.black);

  ThemeProvider({bool isDarkMode = false}) {
    _selectedTheme = isDarkMode ? dark : light;
  }

  Future<void> swapTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_selectedTheme == dark) {
      _selectedTheme = light;
      prefs.setBool('isDarkTheme', false);
    } else {
      _selectedTheme = dark;
      prefs.setBool('isDarkTheme', true);
    }
    notifyListeners();
  }

  ThemeData get getTheme => _selectedTheme;
}
