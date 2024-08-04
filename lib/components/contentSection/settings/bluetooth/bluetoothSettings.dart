import 'dart:async';

import 'package:car_os/classes/blDriver.dart';
import 'package:car_os/classes/odbDevice.dart';
import 'package:flutter/material.dart';

class BluetoothSettings extends StatefulWidget{
  
  BlDriver bluetooth = new BlDriver();
  
  @override
  State<StatefulWidget> createState() => _bluetoothSettings();

}

class _bluetoothSettings extends State<BluetoothSettings>{
  
  List<OdbDevice>  foundDevices = [];

  @override
  void initState(){
    _initBluetooth();
  }
  

  void _initBluetooth() async {
    StreamController<OdbDevice> deviceStream = widget.bluetooth.discover();

    deviceStream.stream.listen((OdbDevice data) {
      String name = data.name;
      print("Found: $name");
      foundDevices.add(data);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: const Text("Bluetooth")
      ),
      body: Container(
        color: Colors.black87,
        child: Container(),
    ),
    );
  }
  
}