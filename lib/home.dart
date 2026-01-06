import 'package:flutter/material.dart';
import 'package:flutter_project_1/child_one.dart';
import 'package:flutter_project_1/child_three.dart';
import 'package:flutter_project_1/child_two.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.blue[50]),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [ChildOne(), ChildTwo(), ChildThree()],
      ),
    );
  }
}
