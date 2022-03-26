import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polmeme/auth/auth_state.dart';
import 'package:polmeme/auth/login_page.dart';
import 'package:polmeme/home/home.dart';
import 'package:polmeme/newsScreen/news_screen.dart';
import 'package:polmeme/provider/theme_provider.dart';
import 'package:polmeme/provider/twitter_api_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        child: ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
            builder: (context, _) {
              final themeProvider = Provider.of<ThemeProvider>(context);
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Polmeme',
                themeMode: themeProvider.themeMode,
                theme: MyThemes.lightTheme,
                darkTheme: MyThemes.darkTheme,

                // theme: ThemeData(
                //   primarySwatch: Colors.blue,
                //   scaffoldBackgroundColor: const Color(0xFFE0E0E12),
                // ),
                home: LoginHandler(),
              );
            }),
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
