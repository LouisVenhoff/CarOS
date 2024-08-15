import 'dart:convert';
import 'dart:typed_data';

import 'package:car_os/classes/deviceMount.dart';
import 'package:car_os/components/telemetryDisplay/genericInfo/genericInfo.dart';
import 'package:car_os/components/telemetryDisplay/speedDisplay/speedDisplay.dart';
import 'package:car_os/components/telemetryDisplay/warningLights/warningLights.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TelemetryDisplay extends StatefulWidget{
  @override
  State<TelemetryDisplay> createState() => _telemetryDisplayState();
  
}

class _telemetryDisplayState extends State<TelemetryDisplay>{
  
  List<WarningLight> currentLights = [WarningLight.engineError];

  @override
  void initState(){
    startInitializing();
  }

  @override
  void didUpdateWidget(covariant TelemetryDisplay oldWidget){
    super.didUpdateWidget(oldWidget);
    startInitializing();

  }

  void startInitializing() async {
    if(DeviceMount.currentDevice != null){
      String? data = await DeviceMount.currentDevice?.initializeAdapter();
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(data!)),
    );
    }
    else{
      print("Device ist null");
    }
  }

  void message(String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        border: Border(
          right: BorderSide(
            width: 20,
            color: Colors.black,
          ),
        ),
      ),
      padding: EdgeInsets.only(top: 90),
      width: 400,
      child: Column(
        children: [
          FilledButton(child: Text("Initialize"), onPressed: () => {startInitializing()}),
          SpeedDisplay(),
          WarningLights(warnings: currentLights),
          GenericInfo(0, 0, 0, 0),
        ]
      ),
    );
  }
  
}