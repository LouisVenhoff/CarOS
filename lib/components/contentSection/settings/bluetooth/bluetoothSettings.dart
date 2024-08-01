import 'package:flutter/material.dart';

class BluetoothSettings extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _bluetoothSettings();

}

class _bluetoothSettings extends State<BluetoothSettings>{
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: const Text("Bluetooth")
      ),
      body: Container(
        color: Colors.black87,
        child: Container(),
    ),);
  }
  
}