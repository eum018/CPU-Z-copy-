import 'package:cpu_z_copy/controller/base_controller.dart';

class SystemController extends BaseController with Channel {
  String androidVersion = "";
  int apiVersion = 0;
  String buildId = "";
  String bootLoader = "";
  String securityPatchLevel = "";
  String javaVmVer = "";
  String openGLVer = "";
  String kernelVer = "";
  String kernelArch = "";
  String rootAccess = "";
  String googlePlayService = "";
  int uptime = 0;

  Future<void> init() async {
    print("init");
    await loadStatic();
  }

  Future<void> loadStatic() async {
    print("load");
    await systemMethodPlatform.invokeMethod('system_info').then((value) {
      print('connet');
      androidVersion = asMap(value)['android_version'];
      apiVersion = asMap(value)['api_level'];
      securityPatchLevel = asMap(value)['security_patch_level'];
      bootLoader = asMap(value)['bootLoader'];
      buildId = asMap(value)['build_id'];
      javaVmVer = asMap(value)['java_vm_version'];
      openGLVer = asMap(value)['openGL_version'];
      kernelArch = asMap(value)['kernel_version'];
      kernelArch = asMap(value)['kernel_arch'];
      rootAccess = asMap(value)['root_access'];
      rootAccess = asMap(value)['root_access'];
      uptime = asMap(value)['uptime'];
      updateScreen();
    });
  }
}
