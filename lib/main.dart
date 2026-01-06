import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Hello Flutter from Me",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: Container(
          // padding: const EdgeInsets.all(20),
          // margin: const EdgeInsets.all(20),
          // width: double.infinity,
          // decoration: BoxDecoration(
          //   color: Colors.blue[100],
          //   borderRadius: BorderRadius.circular(20),
          // ),
          // child: const Text(
          //   "A Whole New World",
          //   textAlign: TextAlign.center,
          //   style: TextStyle(fontStyle: FontStyle.italic),
          // ),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.blue[50]),
        ),
      ),
    );
  }
}
