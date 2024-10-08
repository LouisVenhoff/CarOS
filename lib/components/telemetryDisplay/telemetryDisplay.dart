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
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
          SpeedDisplay(),
          WarningLights(warnings: currentLights),
          GenericInfo(0, 0, 0, 0),
        ]
      ),
    );
  }
  
}