import 'package:flutter/material.dart';
import 'package:funfacts/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Theme Mode"), 
          Row(
            children: [
              Switch(
                value: isChecked,
                onChanged: (value) {
                  isChecked = value;
                  themeProvider.toggleTheme(darkMode: isChecked);
                },
              ),
              SizedBox(width: 8),
              Text(
                themeProvider.isDarkModeChecked ? "Dark Mode" : "Light Mode",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
