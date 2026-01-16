import 'package:flutter/material.dart';
import 'package:funfacts/widgets/theme_switcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Column(
        children: [
          ThemeSwitcher(),
          ElevatedButton(onPressed: () {}, child: Text("Reset Theme")),
        ],
      ),
    );
  }
}
