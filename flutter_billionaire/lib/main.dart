import 'package:flutter/material.dart';
import 'package:flutter_billionaire/add_money.dart';
import 'package:flutter_billionaire/balance_value.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double balance = 0;

  @override
  void initState() {
    super.initState();
    loadMoney();
  }

  void loadMoney() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      balance = prefs.getDouble('balance') ?? 0;
    });
  }

  void buttonClicked() async {
    setState(() {
      balance += 500;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('balance', balance);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: Text("Billionaire App"), centerTitle: true),
        body: Container(
          padding: EdgeInsets.all(20),
          color: Colors.blueGrey,
          height: double.infinity,
          width: double.infinity,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Column(children: [BalanceValue(balance: balance)]),
              Spacer(),
              AddMoneyButton(addMoneyFunction: buttonClicked),
            ],
          ),
        ),
      ),
    );
  }
}
