import 'package:flutter/material.dart';

class ChildOne extends StatelessWidget {
  const ChildOne({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Welcome to A Whole New World",
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
