import 'dart:async';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class OdbDevice{

  String name;
  String address;
  bool _connected = false;

  late BluetoothConnection _blConnection;


  OdbDevice({required this.name, required this.address});

  get connected{
    return _connected;
  }

  Future<bool> connect() async {
    //TODO: Connect to the current address and set connected value to true if connection was successfull
    Completer<bool> completer = new Completer<bool>();
    
    try{
      _blConnection = await BluetoothConnection.toAddress(address);
      completer.complete(true);
    }
    catch(exception)
    {
      completer.complete(false);
    }

    return completer.future;
    
  }

  void _sendMessage(){
    //TODO: Send messagt to bluetooth Device
  }

}