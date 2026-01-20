import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:globalchat/providers/user_provider.dart';
import 'package:globalchat/screens/chatroom_page.dart';
import 'package:globalchat/screens/profile_screen.dart';
import 'package:globalchat/screens/splash_screen.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var user = FirebaseAuth.instance.currentUser;
  var db = FirebaseFirestore.instance;
  var key = GlobalKey<ScaffoldState>();

  List<Map<String, dynamic>> chatRooms = [];
  List<String> chatRoomsIds = [];

  void getChatRooms() {
    db.collection("chatrooms").get().then((dataSnapshot) {
      for (var singleChatRoomData in dataSnapshot.docs) {
        chatRooms.add(singleChatRoomData.data());
        chatRoomsIds.add(singleChatRoomData.id);
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    getChatRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      key: key,
      appBar: AppBar(
        title: const Text('Dashboard'),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => key.currentState!.openDrawer(),
            child: CircleAvatar(
              radius: 20,
              child: Text(
                userProvider.userName.isNotEmpty
                    ? userProvider.userName[0].toUpperCase()
                    : "?",
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(height: 50),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
              leading: CircleAvatar(
                child: Text(
                  userProvider.userName.isNotEmpty
                      ? userProvider.userName[0].toUpperCase()
                      : "?",
                ),
              ),
              title: Text(
                userProvider.userName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(userProvider.userEmail),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
              leading: Icon(Icons.person),
              title: Text("Profile"),
            ),
            ListTile(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SplashScreen()),
                  (route) => false,
                );
              },
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Logout"),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: chatRooms.length,
        itemBuilder: (BuildContext context, int index) {
          var roomName = chatRooms[index]["chatroom_name"] ?? "No Name";
          var roomDesc = chatRooms[index]["desc"] ?? "No description";

          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatroomPage(
                    chatroomName: roomName,
                    chatroomId: chatRoomsIds[index],
                  ),
                ),
              );
            },
            leading: CircleAvatar(child: Text(roomName[0].toUpperCase())),
            title: Text(roomName),
            subtitle: Text(roomDesc),
          );
        },
      ),
    );
  }
}
