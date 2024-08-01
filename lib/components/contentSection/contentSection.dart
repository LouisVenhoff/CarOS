import 'package:car_os/components/contentSection/settings/settingsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContentSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _contentSection();
}

class _contentSection extends State<ContentSection> {
  
  Widget currentPage = Container();

  void _pushSettings(){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => SettingsPage())
    );
  }


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "CarOS",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [
            InkWell(
              child: const Icon(Icons.settings, size: 50, color: Colors.white),
              onTap: _pushSettings,
            )
          ],
        ),
        body: currentPage,
      ),
    );
  }
}
