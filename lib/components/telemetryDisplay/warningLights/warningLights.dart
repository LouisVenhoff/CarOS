import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum WarningLight {
  overheat,
  cold,
  lowOil,
  batteryError,
  engineError,
  reserveFuel,
}



class WarningLights extends StatefulWidget{
  
  final List<WarningLight> warnings;

  WarningLights({required this.warnings});
  
  
  @override
  State<StatefulWidget> createState() => _warningLights();
}

class _warningLights extends State<WarningLights>{
  List<Icon> lights = [];

  @override
  void initState(){
    this.updateLights(widget.warnings);
  }
  
  @override
  void didUpdateWidget(covariant WarningLights oldWidget){
    super.didUpdateWidget(oldWidget);
    this.updateLights(widget.warnings);
  }

  void updateLights(List<WarningLight> lightsInfo){
    
    List<Icon> lightList = [];
    
    for(int i = 0; i < lightsInfo.length; i++){
      switch(lightsInfo[i]){
        case WarningLight.overheat:
          lightList.add(const Icon(Icons.thermostat, color: Color.fromARGB(255, 255, 17, 0), size: 60));
          break;
        case WarningLight.cold:
          lightList.add(const Icon(Icons.thermostat, color: Color.fromARGB(255, 51, 0, 255), size: 60));
          break;
        case WarningLight.lowOil:
          lightList.add(const Icon(Icons.oil_barrel_outlined, color: Color.fromARGB(255, 255, 17, 0), size: 60));
          break;
        case WarningLight.batteryError:
          lightList.add(const Icon(Icons.battery_alert_sharp, color: Color.fromARGB(255, 255, 17, 0), size: 60));
          break;
        case WarningLight.engineError:
          lightList.add(const Icon(Icons.warning_amber, color: Colors.yellow, size: 60));
          break;
        case WarningLight.reserveFuel:
          lightList.add(const Icon(Icons.local_gas_station_outlined, color: Colors.yellow, size:60));
          break;
      }

      setState(() {
        lights = lightList;
      });
    }

  }
  
  
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child:Container(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: lights,
            ),
          ),
        )
      ]
    );
  }
  
}