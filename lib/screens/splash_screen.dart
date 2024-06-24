import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:globalchat/providers/userProvider.dart';
import 'package:globalchat/screens/dashboard_screen.dart';
import 'package:globalchat/screens/login_screen.dart';
import 'package:globalchat/screentoogle.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    var user = FirebaseAuth.instance.currentUser;
    Future.delayed(Duration(seconds: 2), () {
      if (user == null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Screentoogle(),
            ));
      } else {
        OpenDashboard();
      }
    });
    // TODO: implement initState
    super.initState();
  }

  void OpenDashboard() {
    Provider.of<Userprovider>(context, listen: false).getUserDetails();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => DashboardScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/chatlogo.png",
              height: 120,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
