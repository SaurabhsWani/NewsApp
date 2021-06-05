import 'package:flutter/material.dart';
import 'package:task1/Screens/Home_screen.dart';
import 'package:task1/Screens/SignIn_screen.dart';
import 'package:task1/Screens/SignUP_Screen.dart';
import 'package:task1/Screens/favs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (context) => Signup(),
        "/signin": (context) => SignIn(),
        "/home": (context) => NewsPage(
              favid: [],
            ),
        "/fav": (context) => FavsPage(
              favid: [],
            ),
      },
    );
  }
}
