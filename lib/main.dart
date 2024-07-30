import 'package:car_os/components/telemetryDisplay/telemetryDisplay.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: TelemetryDisplay(),
      ),
    );
  }
}
