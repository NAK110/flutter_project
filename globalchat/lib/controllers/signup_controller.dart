import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:globalchat/screens/dashboard.dart';
import 'package:globalchat/screens/splash_screen.dart';

class SignupController {
  static Future<void> createAccount({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String country,
  }) async {
    try {
      print("Starting account creation...");

      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      print("User created successfully: ${userCredential.user?.uid}");

      var userId = FirebaseAuth.instance.currentUser!.uid;
      var db = FirebaseFirestore.instance;

      Map<String, dynamic> userData = {
        "name": name,
        "country": country,
        "email": email,
        "userId": userId.toString(),
      };

      print("Attempting to save user data to Firestore...");
      try {
        await db.collection("users").doc(userId.toString()).set(userData);
        print("User data saved successfully to Firestore");
      } catch (firestoreError) {
        print("Firestore error: $firestoreError");
        rethrow;
      }

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
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Error: ${e.message}");
      SnackBar snackBar = SnackBar(
        content: Text("Error: ${e.message}"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      print("Unexpected error: $e");
      const snackBar = SnackBar(
        content: Text("Failed to create account"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
