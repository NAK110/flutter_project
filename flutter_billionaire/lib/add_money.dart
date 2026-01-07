import 'package:flutter/material.dart';

class AddMoneyButton extends StatelessWidget {

  final Function() addMoneyFunction;

  const AddMoneyButton({super.key, required this.addMoneyFunction});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red[700],
          padding: EdgeInsets.all(20),
        ),
        onPressed: addMoneyFunction,
        child: Text("Click Here", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
