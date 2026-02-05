import 'package:cpu_z_copy/controller/android_controller.dart';
import 'package:cpu_z_copy/controller/base_controller.dart';


class BatteryController extends BaseController {
  int level = 0;
  String health = '';
  String PowerSource = '';
  String status = '';
  String Technology = '';
  int Temperature = 0;
  int Voltage = 0;

  Future<void> init() async {
    await load();
  }

  Future<void> load() async {
    final data = await AndroidController.loadBattery();

    level = data['level'];
    health = data['health'];
    PowerSource = data['power_source'];
    Technology = data['technology'];
    status = data['status'];
    Temperature = data['temperature'];
    Voltage = data['voltage'];

    updateScreen();
  }
}
