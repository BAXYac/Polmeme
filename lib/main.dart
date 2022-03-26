import 'package:flutter/material.dart';
import 'package:polmeme/auth/login_page.dart';

import 'package:polmeme/provider/theme_provider.dart';
import 'package:polmeme/provider/twitter_api_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return runApp(
    ChangeNotifierProvider(
      child: MyApp(),
      create: (BuildContext context) =>
          ThemeProvider(isDarkMode: prefs.getBool('isDarkTheme')),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
// <<<<<<< HEAD
//   Widget build(BuildContext context) {
//     return Consumer<ThemeProvider>(
//       builder: (context, themeProvider, child) {
//         return MaterialApp(
//           theme: themeProvider.getTheme,
//           home: LoginPage(),
//         );
//       },
//     );
//   }
// =======
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TwietterApiProvider()),
        ],
        child: ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
          builder: (context, _) {
            final themeProvider = Provider.of<ThemeProvider>(context);
            return Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return MaterialApp(
                  theme: themeProvider.getTheme,
                  debugShowCheckedModeBanner: false,
                  home: LoginPage(),
                );
              },
            );
          },
        ),
      );
// >>>>>>> develop
}
