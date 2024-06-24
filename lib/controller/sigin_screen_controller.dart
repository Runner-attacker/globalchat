import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:globalchat/screens/dashboard_screen.dart';

class SignupController {
  static Future<void> createAccount({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String country,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      var userId = FirebaseAuth.instance.currentUser!.uid;
      var db = FirebaseFirestore.instance;
      Map<String, dynamic> data = {
        "name": name,
        "email": email,
        "country": country,
        "id": userId
      };

      try {
        db.collection("users").doc(userId.toString()).set(data);
        print("Data Entered Sucessfully in Database");
      } catch (e) {
        print("Error in Database $e");
      }
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardScreen(),
        ),
        (route) => false,
      );
      print("Account Created Sucessfully");
    } catch (e) {
      print("Error in Creating Account : $e");
    }
  }
}
