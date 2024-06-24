import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:globalchat/providers/userProvider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData = {};
  var db = FirebaseFirestore.instance;
  var authUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<Userprovider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Screen"),
      ),
      body: userData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                // ListTile(
                //   leading: Icon(Icons.person),
                //   title: Text(userData?["name"] ?? ""),
                // ),
                // ListTile(
                //   leading: Icon(Icons.email),
                //   title: Text(userData?["email"] ?? ""),
                // ),
                // ListTile(
                //   leading: Icon(Icons.flag),
                //   title: Text(userData?["country"] ?? ""),
                // ),

                Text(userProvider.userName),
                Text(userProvider.userEmail),
                Text(userProvider.userId),
              ],
            ),
    );
  }
}
