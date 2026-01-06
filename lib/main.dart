import 'package:flutter/material.dart';
import 'package:flutter_project_1/child_one.dart';
import 'package:flutter_project_1/child_three.dart';
import 'package:flutter_project_1/child_two.dart';
import 'package:flutter_project_1/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Poppins"
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Hello Flutter from Me",
            style: TextStyle(color: Colors.white, ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: const Home(),
      ),
    );
  }
}
