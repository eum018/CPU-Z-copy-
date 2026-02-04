import 'package:cpu_z_copy/controller/android_controller.dart';
import 'package:flutter/cupertino.dart';

class BatteryController {

  int level = 0;

  ValueNotifier<int> updateCount = ValueNotifier(0);

  void _updateScreen () => updateCount.value = updateCount.value + 1;


  Future<void> init () async {
    await getLevel();
  }


  Future<void> getLevel () async {
    level = await AndroidController.loadBatteryLevel();
    _updateScreen();
  }

}