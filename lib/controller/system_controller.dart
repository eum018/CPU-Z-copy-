import 'dart:async';

import 'package:cpu_z_copy/controller/base_controller.dart';

class SystemController extends BaseController with Channel {
  String androidVersion = "";
  int apiVersion = 0;
  String spl = "";
  String bootLoader = "";
  String buildId = "";
  String javaVm = "";
  String openGLVersion = "";
  String kernelArch = "";
  String kernelVersion = "";
  bool rootAccess = false;
  String gps = "";
  Duration uptime = Duration(milliseconds: 0);

  Timer? _timer;

  Future<void> init() async {
    loadStatic();
    loadDynamic();
  }

  void dispose () {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> loadStatic() async {
    print("affer");
    androidVersion = asMap(
      await systemMethodPlatform.invokeMethod("android_version"),
    )["content"];
    apiVersion = asMap(
      await systemMethodPlatform.invokeMethod("api_version"),
    )["content"];
    spl = asMap(await systemMethodPlatform.invokeMethod("spl"))["content"];
    bootLoader = asMap(
      await systemMethodPlatform.invokeMethod("boot_loader"),
    )["content"];
    buildId = asMap(
      await systemMethodPlatform.invokeMethod("build_id"),
    )["content"];
    javaVm = asMap(
      await systemMethodPlatform.invokeMethod("java_vm"),
    )["content"];
    openGLVersion = asMap(
      await systemMethodPlatform.invokeMethod("openGL_version"),
    )["content"];
    kernelArch = asMap(
      await systemMethodPlatform.invokeMethod("kernel_arch"),
    )["content"];
    kernelVersion = asMap(
      await systemMethodPlatform.invokeMethod("kernel_version"),
    )["content"];
    rootAccess = asMap(
      await systemMethodPlatform.invokeMethod("root_access"),
    )["content"];
    gps = asMap(await systemMethodPlatform.invokeMethod("gps"))["content"];
    uptime = Duration(
      milliseconds: asMap(
        await systemMethodPlatform.invokeMethod("uptime"),
      )["content"],
    );
    updateScreen();
  }

  void loadDynamic() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      uptime = Duration(
        milliseconds: asMap(
          await systemMethodPlatform.invokeMethod("uptime"),
        )["content"],
      );
      updateScreen();
    });
  }
}
