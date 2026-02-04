import 'package:cpu_z_copy/controller/battery_controller.dart';
import 'package:flutter/services.dart';

abstract class AndroidController {
  static final _eventChannelName = 'com.example.spu_z_copy_event_channel';
  static final _methodCannelName = 'com.example.spu_z_copy_method_channel';

  static final _eventPlatform = EventChannel(_eventChannelName);
  static final _methodPlatform = MethodChannel(_methodCannelName);


  static Future<int> loadBatteryLevel () async {
    return await _methodPlatform.invokeMethod('battery');
  }

}



extension StateController on AndroidController {

  static BatteryController _batteryController = BatteryController();


}