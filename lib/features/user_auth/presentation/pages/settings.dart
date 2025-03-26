import 'package:flutter/material.dart';


class SettingsPage extends StatelessWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkTheme;

  const SettingsPage({required this.onThemeChanged, required this.isDarkTheme, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Settings",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dark Theme",
                  style: TextStyle(fontSize: 18),
                ),
                Switch(
                  value: isDarkTheme,
                  onChanged: (value) {
                    onThemeChanged(value);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}