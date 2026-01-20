import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:globalchat/providers/user_provider.dart';
import 'package:globalchat/screens/dashboard.dart';
import 'package:globalchat/screens/login.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (user != null) {
        openDashboard();
        return;
      }
      openLogin();
    });
  }

  void openDashboard() {
    Provider.of<UserProvider>(context, listen: false).getUserData();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardPage()),
    );
  }

  void openLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: Image.asset("assets/images/appIcon.png"),
            ),
            SizedBox(height: 30),
            Text(
              'Welcome to Global Chat App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
