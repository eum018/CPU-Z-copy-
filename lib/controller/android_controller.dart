import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AndroidController {
  static final _eventChannelName = 'com.example.spu_z_copy_event_channel';
  static final _methodCannelName = 'com.example.spu_z_copy_event_channel';

  static final _eventPlatform = EventChannel(_eventChannelName);
  static final _methodPlatform = MethodChannel(_methodCannelName);

  Stream<int> getBattery() async* {
    _eventPlatform.receiveBroadcastStream().listen((event) {
      StateController.battery.value = event as int;
    });
  }
}



class StateController {

  static ValueNotifier<int> battery = ValueNotifier(0);


}