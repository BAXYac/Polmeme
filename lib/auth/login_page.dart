// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:polmeme/auth/auth_state.dart';
import 'package:polmeme/auth/style.dart';
import 'package:polmeme/home/home.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _signUp = false;
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(backgroundColor: Colors.black, actions: <Widget>[
            OutlinedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              child: Text(
                "POMIŃ",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: BorderSide(
                  width: 2,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            )
          ]),
          body: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 40, 8, 20),
                        child: Image.asset(
                          "assets/3657586_print_1.png",
                          scale: 3,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 90),
                        child: MyTextWidget(
                          color: Colors.white,
                          size: 55,
                          text: "Polmem",
                        ),
                      ),
                      completeLogin(),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      completePassword(),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                      ),
                      Center(
                        child: TextButton(
                          child: Text(
                            _signUp ? "Zarejestruj" : "Zaloguj",
                            style: TextStyle(
                                fontSize: 24,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          onPressed: _signUp
                              ? () {
                                  if (_formKey.currentState!.validate()) {
                                    Provider.of<AuthState>(
                                      context,
                                      listen: false,
                                    )
                                        .signOnWithEmail(
                                            email: _emailController.text.trim(),
                                            password: _passwordController.text)
                                        .whenComplete(() {
                                      if (context.read<User?>() != null) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Home(),
                                            ));
                                      }
                                    });
                                  }
                                }
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    Provider.of<AuthState>(
                                      context,
                                      listen: false,
                                    )
                                        .signInWithEmail(
                                            email: _emailController.text.trim(),
                                            password: _passwordController.text)
                                        .whenComplete(() {
                                      if (context.read<User?>() != null) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Home(),
                                            ));
                                      }
                                    });
                                  }
                                },
                        ),
                      ),
                      Center(
                        child: TextButton(
                          child: Text(
                            !_signUp ? "Zarejestruj" : "Zaloguj",
                            style: TextStyle(
                              color: Color(0xFF1B6569),
                              fontSize: 24,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _signUp = !_signUp;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget completeLogin() {
    return Column(
      children: [
        Container(
          width: 320,
          height: 40,
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
          child: MyTextWidget(
            color: Colors.white,
            size: 24,
            text: "Login",
          ),
          decoration: BoxDecoration(
            color: Color(0xFF1B6569),
            border: Border.all(color: Colors.white, width: 1.5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
        ),
        Container(
          width: 320,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter your e-mail";
              } else if (!RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
                  .hasMatch(_emailController.text)) {
                return "Please enter a valid e-mail";
              }
              return null;
            },
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(10),
              filled: true,
              fillColor: Colors.black,
              errorStyle: TextStyle(
                  fontSize: 17,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500),
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
              focusedBorder: loginBorder(),
              enabledBorder: loginBorder(),
              errorBorder: loginBorder(),
              focusedErrorBorder: loginBorder(),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
        ),
      ],
    );
  }

  Widget completePassword() {
    return Column(
      children: [
        Container(
          width: 320,
          height: 40,
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
          child: MyTextWidget(
            color: Colors.white,
            size: 24,
            text: "Hasło",
          ),
          decoration: BoxDecoration(
            color: Color(0xFF1B6569),
            border: Border.all(color: Colors.white, width: 1.5),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
        ),
        Container(
          width: 320,
          child: TextFormField(
            keyboardType: TextInputType.visiblePassword,
            controller: _passwordController,
            obscureText: !_showPassword,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter your password";
              } else if (value.length < 8) {
                return "Password need to be 8 characters long";
              }
              return null;
            },
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(10),
              filled: true,
              fillColor: Colors.black,
              errorStyle: TextStyle(
                  fontSize: 17,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500),
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
              focusedBorder: loginBorder(),
              enabledBorder: loginBorder(),
              errorBorder: loginBorder(),
              focusedErrorBorder: loginBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
                icon: Icon(
                  _showPassword ? Icons.visibility : Icons.visibility_off,
                ),
                color: Color(0xFF1B6569),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
        ),
      ],
    );
  }

  loginBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 1.5),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
    );
  }
}
