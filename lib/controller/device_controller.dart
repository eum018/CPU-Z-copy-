import 'dart:async';

import 'package:cpu_z_copy/controller/base_controller.dart';

class DeviceController extends BaseController with Channel {
  String model = "";
  String manufacturer = "";
  String board = "";
  String hardware = "";
  double screenSize = 0;
  String screenResolution = "";
 int screenDensity = 0;
  int totalRam = 0;
  int availableRam = 0;
  int internalStorage = 0;
  int availableStorage = 0;

  Future<void> init() async {
    await loadStatic();
    loadDynamic();
  }

  void dispose() {
    _timer?.cancel();
  }

  Future<void> loadStatic() async {
    model = asMap(await deviceMethodPlatform.invokeMethod('model'))['content'];
    manufacturer = asMap(
      await deviceMethodPlatform.invokeMethod('manufacturer'),
    )['content'];
    board = asMap(await deviceMethodPlatform.invokeMethod('board'))['content'];
    hardware = asMap(
      await deviceMethodPlatform.invokeMethod('hardware'),
    )['content'];
    await deviceMethodPlatform.invokeMethod('screen').then((value) {
      screenSize = asMap(asMap(value)['content'])['size'];
      screenResolution = asMap(asMap(value)['content'])['resolution'];
      screenDensity = asMap(asMap(value)['content'])['density'];
    });
    updateScreen();
  }

  Timer? _timer;

  void loadDynamic() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) async {
      await deviceMethodPlatform.invokeMethod('ram').then((value) {
        totalRam = asMap(asMap(value)['content'])['total'];
        availableRam = asMap(asMap(value)['content'])['available'];
      });
      await deviceMethodPlatform.invokeMethod('storage').then((value) {
        internalStorage = asMap(asMap(value)['content'])['total'];
        availableStorage = asMap(asMap(value)['content'])['available'];
      });

      updateScreen();
    });
  }
}
