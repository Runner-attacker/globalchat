import 'package:flutter/material.dart';
import 'package:globalchat/screens/login_screen.dart';
import 'package:globalchat/screens/sigin_screen.dart';

class Screentoogle extends StatefulWidget {
  const Screentoogle({super.key});

  @override
  State<Screentoogle> createState() => _ScreentoogleState();
}

class _ScreentoogleState extends State<Screentoogle> {
  bool showLoginScreen = true;
  void changeScreen() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginScreen(changeScreen);
    } else {
      return SignScreen(changeScreen);
    }
  }
}
