import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polmeme/auth/auth_state.dart';
import 'package:polmeme/auth/login_page.dart';
import 'package:polmeme/home/home.dart';
import 'package:polmeme/provider/theme_provider.dart';
import 'package:polmeme/provider/twitter_api_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();

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
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TwietterApiProvider()),
          ChangeNotifierProvider(
            create: (context) => AuthState(FirebaseAuth.instance),
          ),
          StreamProvider(
              create: (context) => context.read<AuthState>().userChanges,
              initialData: null),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              theme: themeProvider.getTheme,
              debugShowCheckedModeBanner: false,
              home: LoginHandler(),
            );
          },
        ),
      );
}

class LoginHandler extends StatelessWidget {
  const LoginHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _firebaseUser = context.watch<User?>();
    return _firebaseUser == null ? LoginPage() : Home();
  }
}
