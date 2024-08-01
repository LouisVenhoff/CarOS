import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _settingsPage();
}

class _settingsPage extends State<SettingsPage> {
  
  TextStyle titleStyle = const TextStyle(color: Colors.white, fontSize: 20);

  ListTile _buildSettingsElement(String title, IconData icon) {
    return ListTile(
      title: Text(title, style: titleStyle),
      leading: Icon(icon, color: Colors.white, size: 30)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black87,
        child: ListView(
          children: [
            Divider(),
            _buildSettingsElement("Bluetooth", Icons.bluetooth),
            Divider(),
          ]
        )
    );
  }
}
