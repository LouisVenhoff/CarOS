import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

void checkPermissions() {
  _checkBluetoothPermissions();
}

void _checkBluetoothPermissions() async {
  if(await Permission.bluetooth.isGranted != true){
    PermissionStatus bleGranted = await Permission.bluetooth.request();
  }

  if(await Permission.bluetoothConnect.isGranted != true){
    PermissionStatus connectGranted = await Permission.bluetoothConnect.request();

    if(connectGranted.isDenied){
      SystemNavigator.pop();
    }
  }

  if(await Permission.bluetoothScan.isGranted != true){
    PermissionStatus scanGranted = await Permission.bluetoothScan.request();

    if(scanGranted.isDenied){
      SystemNavigator.pop();
    }
  }

  
}
