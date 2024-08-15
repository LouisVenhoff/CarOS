import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
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

  String? lastAnswer = "";

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


  Future<String> initializeAdapter() async {
    print("Initializing adapter!");
    if(_connectionState != BlState.CONNECTED){
      //TODO: Send error dialog
      throw "Error";
    }
    // await sendASCIIMessage("atz");
    // await sendASCIIMessage("at11");
    // await sendASCIIMessage("ath1");

    addBluetoothListener();

    String data = "Hello World!";
    return data;
  }

  void addBluetoothListener(){
    _blConnection.input!.listen((Uint8List data){
      lastAnswer = ascii.decode(data);
    });
  }

  Future<String> sendASCIIMessage(String message) async {
    //TODO: Send messagt to bluetooth Device
    Completer<String> completer = new Completer<String>();
    
    lastAnswer = null;

    int retryCount = 0;

    print("Hex zahlen: ");
    print(toHex(message));

    _blConnection.output.add(ascii.encode(message));

    while(lastAnswer == null){
      await Future.delayed(const Duration(seconds: 1));
      retryCount++;

      if(retryCount >= 10){
        return "";
      }
    }

    completer.complete(lastAnswer);

    return completer.future;
  }

  Uint8List toHex(String message){
    Uint8List asciiMessage = ascii.encode(message);

    List<int> hexValues = [];

    asciiMessage.forEach((int value) {
      String hexValue = value.toRadixString(16).padLeft(2, "0");
      
      hexValues.add(int.parse("0x$hexValue"));
    });

    return Uint8List.fromList(hexValues);
  }

}