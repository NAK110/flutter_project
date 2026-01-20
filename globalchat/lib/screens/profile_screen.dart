import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:globalchat/providers/user_provider.dart';
import 'package:globalchat/screens/edit_profile.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? userData = {};
  var db = FirebaseFirestore.instance;
  var authUser = FirebaseAuth.instance.currentUser!.uid;

  void getUserData() async {
    var docSnapshot = await db.collection("users").doc(authUser).get();
    if (docSnapshot.exists) {
      setState(() {
        userData = docSnapshot.data();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: Text(userProvider.userName[0].toUpperCase()),
            ),
            SizedBox(height: 8),
            Text(
              userProvider.userName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(userProvider.userEmail),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfile()),
                );
              },
              child: Text("Edit Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
