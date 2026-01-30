import 'package:flutter/cupertino.dart';

class BatteryController {

  int battery = 0;

  ValueNotifier<int> updateCount = ValueNotifier(0);


  void updateScreen () => updateCount.value = updateCount.value + 1;


}