import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:globalchat/screens/dashboard.dart';
import 'package:globalchat/screens/splash_screen.dart';

class LoginController {
  static Future<void> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen()),
        (route) => false,
      );

      const snackbar = SnackBar(
        content: Text("Account created successfully"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      // print("Account created successfully");
    } catch (e) {
      // print(e);
      const snackBar = SnackBar(
        content: Text("Failed to create account"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
