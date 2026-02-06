import 'dart:async';

import 'package:cpu_z_copy/controller/base_controller.dart';
import 'package:cpu_z_copy/model/sensor_model.dart';

class SensorController extends BaseController with Channel {
  List<SensorModel> sensorList = [];

  late StreamSubscription? sub;

  Stream<Map<String, dynamic>> sensorStream() {
    return sensorEventPlatform.receiveBroadcastStream().where(
          (event) => event != null && event['type']?.toString() == 'sensor',
    ).map((event) => Map<String, dynamic>.from(event),);
  }


  SensorController() {
    subscribe();
  }

  void dispose () {
    sub?.cancel();
  }


  void subscribe() {
    final stream = sensorStream();
    sub = stream.listen((data) {
      final matchSensor = sensorList
          .where((sensor) => sensor.type == data['sensor_type'])
          .firstOrNull;

      if (matchSensor != null) sensorList.remove(matchSensor);
      sensorList.add(SensorModel.fromJson(data));
      sensorList.sort((a, b) => a.type.compareTo(b.type));
      updateScreen();
    });
  }

  static String getSensorInfo(SensorModel sensor) {
    bool reverse = false;
    sensor.content.keys.forEach(
      (unit) => !reverse ? reverse = unit.contains('=') : null,
    );

    if (reverse) {
      return sensor.content.entries
          .map(
            (content) => !content.key.contains('unit')
                ? "${content.key} ${content.value.toStringAsFixed(6)} ${sensor.content['unit']}"
                : "",
          )
          .join(" ");
    }
    return sensor.content.entries
        .map((content) => "${content.value.toStringAsFixed(6)} ${content.key}")
        .join(" ");
  }
}
