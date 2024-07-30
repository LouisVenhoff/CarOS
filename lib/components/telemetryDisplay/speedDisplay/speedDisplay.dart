import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SpeedDisplay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _speedDisplay();
}

class _speedDisplay extends State<SpeedDisplay> {
  int currentSpeed = 87;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.only(right: 15),
            height: 130,
            alignment: Alignment.centerRight,
            child: Text("$currentSpeed",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 120,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
