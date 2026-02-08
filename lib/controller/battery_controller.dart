import 'dart:async';

import 'package:cpu_z_copy/controller/base_controller.dart';

class BatteryController extends BaseController with Channel {
  int level = 0;
  String health = '';
  String PowerSource = '';
  String status = '';
  String Technology = '';
  int Temperature = 0;
  int Voltage = 0;

  late StreamSubscription? sub;


  Stream<Map<String, dynamic>> batteryStream() {
    return batteryEventPlatform.receiveBroadcastStream().where(
          (event) { print(event); return event != null && event['type']?.toString() == 'battery';},
    ).map((event) => Map<String, dynamic>.from(event),);
  }

  BatteryController() {
    subscribe();
  }

  void dispose () {
    sub?.cancel();
  }

  void subscribe() {
    final stream = batteryStream();
    sub = stream.listen((data) {
      level = data['level'];
      health = data['health'];
      PowerSource = data['powerSource'];
      Technology = data['technology'];
      status = data['status'];
      Temperature = data['temperature'];
      Voltage = data['voltage'];
      updateScreen();
    });
  }
}
