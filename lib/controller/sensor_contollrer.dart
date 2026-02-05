import 'package:cpu_z_copy/controller/android_controller.dart';
import 'package:cpu_z_copy/controller/base_controller.dart';

class SensorController extends BaseController {
  List<String> sensorList = [];

  Future<void> init() async {
    await loadSensorList();
  }

  Future<void> loadSensorList() async {
    sensorList = await AndroidController.loadSensorList() as List<String>;
    updateScreen();
  }
}
