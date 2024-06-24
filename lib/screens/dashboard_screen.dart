import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:globalchat/screens/profile_screen.dart';
import 'package:globalchat/screens/splash_screen.dart';
import 'package:globalchat/screentoogle.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var user = FirebaseAuth.instance.currentUser;
  var db = FirebaseFirestore.instance;
  List<Map<String, dynamic>> chatroomsList = [];

  void getChatrooms() {
    db.collection("chatrooms").get().then(
      (dataSnapshot) {
        for (var singleChatRoomData in dataSnapshot.docs) {
          chatroomsList.add(singleChatRoomData.data());
        }
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    getChatrooms();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dashboard Screen"),
        ),
        drawer: Drawer(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(),
                        ));
                  },
                  leading: Icon(Icons.person),
                  title: Text("P R O F I L E"),
                ),
                ListTile(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SplashScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  leading: Icon(Icons.logout_outlined),
                  title: Text("L O G O U T"),
                )
              ],
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: chatroomsList.length,
          itemBuilder: (context, index) {
            String chatRoom_name = chatroomsList[index]["chatroom_name"] ?? "";
            return ListTile(
              leading: CircleAvatar(
                child: Text(chatRoom_name[0]),
              ),
              title: Text(chatRoom_name),
              subtitle: Text(chatroomsList[index]["desc"]),
            );
          },
        ));
  }
}
