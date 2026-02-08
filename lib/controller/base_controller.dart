import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

abstract class BaseController {
  ValueNotifier<int> updateCount = ValueNotifier(0);

  void updateScreen() => updateCount.value = updateCount.value + 1;

  Map<String, dynamic> asMap (Map map) {
    return Map<String, dynamic>.from(map);
  }


}


mixin Channel {

  final String _baseEventChannelName = "com.example.spu_z_copy_event_channel";
  final String _baseMethodChannelName = "com.example.spu_z_copy_method_channel";

  late final batteryEventPlatform = EventChannel(_baseEventChannelName + '_battery');
  late final sensorEventPlatform = EventChannel(_baseEventChannelName + '_sensor');
  late final deviceMethodPlatform = MethodChannel(_baseMethodChannelName + '_device');
  late final systemMethodPlatform = MethodChannel(_baseMethodChannelName + '_system');

}