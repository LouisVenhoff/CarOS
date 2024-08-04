import 'dart:async';

import 'package:car_os/classes/odbDevice.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BlDriver{

  StreamSubscription<BluetoothDiscoveryResult>? _streamSubscription;
  List<BluetoothDiscoveryResult> results = List<BluetoothDiscoveryResult>.empty(growable: true);
  bool _isDiscovering = false;
  bool _hasDiscovered = false;

  Future<List<BluetoothDiscoveryResult>> getRawResults() async {
    
    if(!_hasDiscovered) throw Exception("blDriver: Please discover first before loading raw results!");
    
    Completer<List<BluetoothDiscoveryResult>> completer = new Completer<List<BluetoothDiscoveryResult>>();
    while(_isDiscovering){
      await Future.delayed(const Duration(seconds: 2));
    }
    completer.complete(results);
    return completer.future;
  }

  
  
  StreamController<OdbDevice> discover(){
    _isDiscovering = true;
    _hasDiscovered = true;
    
    StreamController<OdbDevice> deviceStream = new StreamController<OdbDevice>();

    _streamSubscription = FlutterBluetoothSerial.instance.startDiscovery().listen((result){
      _process(result, deviceStream);
    });

    _streamSubscription!.onDone(() {
      print("Stream is closing!");
      _isDiscovering = false;
      deviceStream.close();
    });

    return deviceStream;
  }

  void _process(BluetoothDiscoveryResult result, StreamController<OdbDevice> stream){
    final resultIndex = results.indexWhere((element) => element.device.address == result.device.address);
    
    if(resultIndex >= 0){
      results[resultIndex] = result;
    }
    else{
      results.add(result);
      
      String deviceName = result.device.name?? "Unbekannt";
      String deviceAddress = result.device.address;

      stream.add(new OdbDevice(name: deviceName, address: deviceAddress));
    }
  }
}