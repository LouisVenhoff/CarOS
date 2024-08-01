import 'package:car_os/components/contentSection/settings/bluetooth/bluetoothSettings.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {  
  @override
  State<StatefulWidget> createState() => _settingsPage();
}

class _settingsPage extends State<SettingsPage> {
  
  TextStyle titleStyle = const TextStyle(color: Colors.white, fontSize: 20);

  ListTile _buildSettingsElement(String title, IconData icon, Function onClick) {
    return ListTile(
      title: Text(title, style: titleStyle),
      leading: Icon(icon, color: Colors.white, size: 30),
      onTap: () => {onClick()}
    );
  }

  void _openSettings(){
    print("Opening Bluetooth!");
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => BluetoothSettings()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: Text("Einstellungen", style: titleStyle),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black87,
        child: ListView(
          children: [
            Divider(),
            _buildSettingsElement("Bluetooth", Icons.bluetooth, () => {_openSettings()}),
            Divider(),
          ]
        )
    ));
  }
}
