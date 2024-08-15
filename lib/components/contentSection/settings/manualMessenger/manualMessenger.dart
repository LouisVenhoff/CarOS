import 'dart:convert';
import 'dart:typed_data';

import 'package:car_os/classes/deviceMount.dart';
import 'package:car_os/classes/odbDevice.dart';
import 'package:flutter/material.dart';

class ManualMessenger extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() => _manualMessenger();
  
}

class _manualMessenger extends State<ManualMessenger>{
  
  var answers = TextEditingController();
  

  String currentCommand = "";


  @override
  initState(){
    answers.text = "Hello World!";
  }

  _onCommandChange(String command){
    setState(() {
      currentCommand = command;
    });
  }

  _sendCommand() async {
    if(DeviceMount.currentDevice == null){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("no Device Connected!"))
      );
      return;
    }

    String result = await DeviceMount.currentDevice!.sendASCIIMessage(currentCommand);

    setState(() {
      
      Uint8List encryptedData = ascii.encode(result);

      answers.text = "Clear: $result  HEX: $encryptedData";
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manuelle Befehle", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black87,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          TextField(
            minLines: 10,
            maxLines: 10,
            controller: answers,
            readOnly: true,
          ),
          TextField(
            minLines: 1,
            maxLines: 1,
            onChanged: (text) {
              _onCommandChange(text);
            },
          ),
          FilledButton(child: Text("Send"), onPressed: _sendCommand)
        ]
      ),
    );
  }
  
}