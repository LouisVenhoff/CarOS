import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

enum BlState{
  NOT_CONNECTED,
  CONNECTING,
  CONNECTED
}


class OdbDevice{

  String name;
  String address;
  BlState _connectionState = BlState.NOT_CONNECTED;

  late BluetoothConnection _blConnection;

  Function? _onStateChange = null;

  OdbDevice({required this.name, required this.address});

  get connected{
    return _connectionState;
  }

  set onStateChange(Function handler){
    _onStateChange = handler;
  }

  Future<bool> connect() async {
    //TODO: Connect to the current address and set connected value to true if connection was successfull
    Completer<bool> completer = new Completer<bool>();
    _updateState(BlState.CONNECTING);
    try{
      _blConnection = await BluetoothConnection.toAddress(address);
      _updateState(BlState.CONNECTED);
      completer.complete(true);
    }
    catch(exception)
    {
      _updateState(BlState.NOT_CONNECTED); 
      completer.complete(false);
    }

    return completer.future;
    
  }

  void _updateState(BlState state){
    _connectionState = state;
    if(_onStateChange != null){
      _onStateChange!(state);
    }
  }


  void _initializeAdapter(){

  }

  Future<String> sendASCIIMessage(String message) async {
    //TODO: Send messagt to bluetooth Device
    Completer<String> completer = new Completer<String>();

    // _blConnection.output.add(ascii.encode(message));

    // _blConnection.input!.listen((Uint8List data){
    //   completer.complete(ascii.decode(data));
    // });

    completer.complete("It works!");

    return completer.future;
  }

}