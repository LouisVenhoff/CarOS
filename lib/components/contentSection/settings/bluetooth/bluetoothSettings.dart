import 'dart:async';

import 'package:car_os/classes/blDriver.dart';
import 'package:car_os/classes/deviceMount.dart';
import 'package:car_os/classes/odbDevice.dart';
import 'package:car_os/classes/permissions.dart';
import 'package:flutter/material.dart';

class BluetoothSettings extends StatefulWidget {
  BlDriver bluetooth = new BlDriver();

  @override
  State<StatefulWidget> createState() => _bluetoothSettings();
}

class _bluetoothSettings extends State<BluetoothSettings> {
  List<OdbDevice> foundDevices = [];

  OdbDevice? connectedDevice = null;

  TextStyle textStyle = const TextStyle(color: Colors.white);

  @override
  void initState() {
    _initBluetooth();
    checkPermissions();
  }

  void _initBluetooth() async {
    StreamController<OdbDevice> deviceStream = await widget.bluetooth.discover();

    deviceStream.stream.listen((OdbDevice data) {
      String name = data.name;
      _addToDeviceList(data);
    });
  }

  void _addToDeviceList(OdbDevice device) {
    setState(() {
      foundDevices.add(device);
    });
  }

  void _startConnection(OdbDevice device) async {
    //TODO: Return stream with map of sensor values
    bool result = await device.connect();
    
    String deviceName = device.name;

    String snackMessage = "Connection sucessfully to $deviceName";

    if(result){
      DeviceMount.currentDevice = device;
      setState((){
        connectedDevice = device;
      });
    }else{
      snackMessage = "Connection to $deviceName failed";
    }
    

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(snackMessage)),
    );
  }

  Widget? _getConnectionLogo(OdbDevice device){
    switch(device.connected){
      case BlState.CONNECTED:
        return const Icon(Icons.bluetooth_connected, color: Colors.green);
      case BlState.CONNECTING:
        return const CircularProgressIndicator();
      default: 
        return const Icon(Icons.bluetooth, color: Colors.red);
    }
  }

  ListView _buildDeviceList() {
    return ListView.builder(
      itemCount: foundDevices.length,
      itemBuilder: (context, index) { 
        return ListTile(
            title: Text(foundDevices[index].name, style: textStyle),
            leading: _getConnectionLogo(foundDevices[index]),
            onTap: () {
              _startConnection(foundDevices[index]);
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bluetooth")),
      body: Container(
        color: Colors.black87,
        child: _buildDeviceList(),
      ),
    );
  }
}
