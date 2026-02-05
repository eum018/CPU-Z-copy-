import 'package:flutter/cupertino.dart';

abstract class BaseController {
  ValueNotifier<int> updateCount = ValueNotifier(0);

  void updateScreen() => updateCount.value = updateCount.value + 1;
}
