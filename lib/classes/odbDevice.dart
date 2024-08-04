class OdbDevice{

  String name;
  String address;
  bool _connected = false;


  OdbDevice({required this.name, required this.address});

  get connected{
    return _connected;
  }

  void connect(){
    //TODO: Connect to the current address and set connected value to true if connection was successfull
  }

  void _sendMessage(){
    //TODO: Send messagt to bluetooth Device
  }

}