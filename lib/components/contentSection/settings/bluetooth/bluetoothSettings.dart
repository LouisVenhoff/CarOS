import 'dart:async';

import 'package:car_os/classes/blDriver.dart';
import 'package:car_os/classes/odbDevice.dart';
import 'package:flutter/material.dart';

class BluetoothSettings extends StatefulWidget {
  BlDriver bluetooth = new BlDriver();

  @override
  State<StatefulWidget> createState() => _bluetoothSettings();
}

class _bluetoothSettings extends State<BluetoothSettings> {
  List<OdbDevice> foundDevices = [];

  TextStyle textStyle = const TextStyle(color: Colors.white);

  @override
  void initState() {
    _initBluetooth();
  }

  void _initBluetooth() async {
    StreamController<OdbDevice> deviceStream = widget.bluetooth.discover();

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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Connection Successfull: $result")
      ),
    );
  }

  ListView _buildDeviceList(){
    return ListView.builder(
          itemCount: foundDevices.length,
          itemBuilder: (context, index) {
            print(foundDevices.length);
            if (index < foundDevices.length) {
              return ListTile(
                  title: Text(foundDevices[index].name, style: textStyle),
                  onTap: () {
                    _startConnection(foundDevices[index]);
                  });
            }
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
