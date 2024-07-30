import 'package:flutter/material.dart';

class GenericInfo extends StatefulWidget{
  
  late Map<String, int> dto;

  GenericInfo(int odometer, int remainingFuel, int rpm, int throttle, {super.key}){
    dto = {
      "ODO": odometer,
      "FUEL": remainingFuel,
      "RPM": rpm,
      "THROTTLE": throttle,
    };
  }

  @override
  State<StatefulWidget> createState() => _genericInfo();
}

class _genericInfo extends State<GenericInfo>{

  List<Widget> data = [];

  @override
  void initState(){
    _updateDataView();
  }

  @override
  void didUpdateWidget(covariant GenericInfo oldWidget){
    super.didUpdateWidget(oldWidget);
    _updateDataView();

  }

  void _updateDataView(){
    List<Widget> dataList = [const Divider()];

    Iterable<MapEntry<String, int>> dtoEntries = widget.dto.entries;
    
    for(final entry in dtoEntries){
      dataList.add(_buildListElement(entry.key, entry.value.toString()));
      dataList.add(const Divider());
    }

    setState((){
      data = dataList;
    });
  }

  ListTile _buildListElement(String hint, String information){

    const TextStyle hintStyle = TextStyle(color: Colors.white);
    const TextStyle informationStyle = TextStyle(color: Colors.white, fontSize: 30);

    return ListTile(title: Text(hint, style: hintStyle), trailing: Text(information, style: informationStyle));
  }


  @override
  Widget build(BuildContext context) {
    return Container( 
      child: Expanded(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: data,
      ),
      )
    );
  }
  
}