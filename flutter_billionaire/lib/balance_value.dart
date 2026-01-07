import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BalanceValue extends StatelessWidget {
  final double balance;
  const BalanceValue({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Bank Balance"),
        Text(
            NumberFormat.currency(symbol: "\$").format(balance),
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
