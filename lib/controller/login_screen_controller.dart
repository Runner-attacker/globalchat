import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:globalchat/screens/dashboard_screen.dart';

class LoginScreenController {
  Future<void> LoggedUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardScreen(),
        ),
        (route) => false,
      );
      print("Logged in Sucessfully");
    } catch (e) {
      print("Error in Logging in $e");
    }
  }
}
