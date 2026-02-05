import 'package:cpu_z_copy/controller/battery_controller.dart';
import 'package:flutter/services.dart';

abstract class AndroidController {
  static final _eventChannelName = 'com.example.spu_z_copy_event_channel';
  static final _methodCannelName = 'com.example.spu_z_copy_method_channel';

  static final _eventPlatform = EventChannel(_eventChannelName);
  static final _methodPlatform = MethodChannel(_methodCannelName);

  static Future<List<String>> loadSensorList() async {
    final List<String> list = await _methodPlatform.invokeMethod(
      '${SystemType.SENSOR.title}_list',
    );
    list.forEach((value) => print("${value} : ${value == null}"),);
    return list;

  }

  static Future<Map> loadBattery() async {
    final Map data = await _methodPlatform.invokeMethod(SystemType.BATTERY.title);
    data.forEach((key, value) => print("${key} : ${value} : ${value == null}"),);
    return data;
  }

  static Future<Map> loadThermal() async {
    final Map data = await _methodPlatform.invokeMethod(SystemType.THERMAL.title);
    data.forEach((key, value) => print("${key} : ${value} : ${value == null}"),);
    return data;
  }
}


enum SystemType {
  BATTERY('Battery'),
  THERMAL('Thermal'),
  SENSOR('Sensor'),
  SYSTEM('System'),
  DEVICE('Device'),
  SOC('Soc');

  final String title;

  const SystemType(this.title);
}

enum StateSensorType {
  Accelerometer('Accelerometer'),
  Gyroscope('Gyroscope'),
  Pressure('Pressure'),
  gravity('gravity'),
  RotationVector('RotationVector'),
  Light('Light'),
  Orientation('Orientation');

  final String type;

  const StateSensorType(this.type);
}
