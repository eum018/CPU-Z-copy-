import 'package:cpu_z_copy/controller/battery_controller.dart';
import 'package:cpu_z_copy/controller/device_controller.dart';
import 'package:cpu_z_copy/controller/sensor_contollrer.dart';
import 'package:cpu_z_copy/controller/system_controller.dart';
import 'package:cpu_z_copy/main.dart';
import 'package:cpu_z_copy/widget/info_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SOC extends StatelessWidget {
  SOC({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          InfoItem(title: 'Model', infos: ['dfagdsfg']),
          InfoItem(title: 'Cores', infos: ['dfagdsfg']),
          InfoItem(title: 'big.LITTLE', infos: ['sadfasfds']),
          InfoItem(title: 'Topology', infos: ['dfagdsfg']),
          InfoItem(title: 'Revision', infos: ['dfagdsfg']),
          InfoItem(title: 'Clock Speed', infos: ['dfagdsfg']),
          ...List.generate(
            8,
            (index) => Padding(
              padding: const EdgeInsets.only(left: 12),
              child: InfoItem(title: 'CPU $index', infos: ['ddfg']),
            ),
          ),
          InfoItem(title: 'GPU Load', infos: ['%']),
          InfoItem(title: 'Scaling Governor', infos: ['dfsgdf']),
        ],
      ),
    );
  }
}

class Device extends StatefulWidget {
  const Device({super.key});

  @override
  State<Device> createState() => _DeviceState();
}

class _DeviceState extends State<Device> {
  late DeviceController _deviceController;

  @override
  void initState() {
    _deviceController = DeviceController();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _deviceController.init();
    });
  }

  @override
  void dispose() {
    _deviceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _deviceController.updateCount,
      builder: (context, value, child) {
        return Column(
          children: [
            InfoItem(title: 'Model', infos: [_deviceController.model]),
            InfoItem(
              title: 'Manufacturer',
              infos: [_deviceController.manufacturer],
            ),
            InfoItem(title: 'Board', infos: [_deviceController.board]),
            InfoItem(title: 'Hardware', infos: [_deviceController.hardware]),
            InfoItem(
              title: 'Screen Size',
              infos: [
                Global.floatDot2.format(_deviceController.screenSize) +
                    " inches",
              ],
            ),
            InfoItem(
              title: 'Screen Resolution',
              infos: [_deviceController.screenResolution],
            ),
            InfoItem(
              title: 'Screen Density',
              infos: ["${_deviceController.screenDensity}" + " dpi"],
            ),
            InfoItem(
              title: 'Total RAM',
              infos: [
                Global.floatDot2.format(_deviceController.totalRam / 1e6) +
                    " MB",
              ],
            ),
            InfoItem(
              title: 'Available',
              infos: [
                Global.floatDot2.format(_deviceController.availableRam / 1e6) +
                    " MB",
              ],
            ),
            InfoItem(
              title: 'Internal Storage',
              infos: [
                Global.floatDot2.format(
                      _deviceController.internalStorage / 1e6,
                    ) +
                    " MB",
              ],
            ),
            InfoItem(
              title: 'Available Storage',
              infos: [
                Global.floatDot2.format(
                      _deviceController.availableStorage / 1e9,
                    ) +
                    " GB",
              ],
            ),
          ],
        );
      },
    );
  }
}

class System extends StatefulWidget {
  const System({super.key});

  @override
  State<System> createState() => _SystemState();
}

class _SystemState extends State<System> {
  late SystemController _systemController;

  @override
  void initState() {
    _systemController = SystemController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _systemController.init();
    });
    super.initState();
  }

  String durationFormat(Duration d) {
    final days = d.inDays;
    final hours = d.inHours % 24;
    final minutes = d.inMinutes % 60;
    final seconds = d.inSeconds % 60;

    return '${days.toString()}. '
        '${hours.toString()}:'
        '${minutes.toString()}:'
        '${seconds.toString()}';
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _systemController.updateCount,
      builder: (context, value, child) {
        return Column(
          children: [
            InfoItem(
              title: 'Android Version',
              infos: [_systemController.androidVersion],
            ),
            InfoItem(
              title: 'API Level',
              infos: ["${_systemController.apiVersion}"],
            ),
            InfoItem(
              title: 'Security Patch Level',
              infos: [_systemController.spl],
            ),
            InfoItem(
              title: 'Bootloader',
              infos: [_systemController.bootLoader],
            ),
            InfoItem(title: 'Build ID', infos: [_systemController.buildId]),
            InfoItem(title: 'Java VM', infos: [_systemController.javaVm]),
            InfoItem(
              title: 'OpenGL Version',
              infos: [_systemController.openGLVersion],
            ),
            InfoItem(
              title: 'Kernel Architecture',
              infos: [_systemController.kernelArch],
            ),
            InfoItem(
              title: 'Kernel Version',
              infos: [_systemController.kernelVersion],
            ),
            InfoItem(
              title: 'Root Access',
              infos: [_systemController.rootAccess ? "Yes" : "No"],
            ),
            InfoItem(
              title: 'Google Play Services',
              infos: [_systemController.gps],
            ),
            InfoItem(
              title: 'System Uptime',
              infos: [durationFormat(_systemController.uptime)],
            ),
          ],
        );
      },
    );
  }
}

class Battery extends StatefulWidget {
  const Battery({super.key});

  @override
  State<Battery> createState() => _BatteryState();
}

class _BatteryState extends State<Battery> {
  late BatteryController _batteryController;

  @override
  void initState() {
    _batteryController = BatteryController();
    super.initState();
  }

  @override
  void dispose() {
    _batteryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _batteryController.updateCount,
      builder: (context, value, child) {
        return Column(
          children: [
            InfoItem(title: 'Health', infos: [_batteryController.health]),
            InfoItem(title: 'Level', infos: ['${_batteryController.level} %']),
            InfoItem(
              title: 'Power Source',
              infos: [_batteryController.PowerSource],
            ),
            InfoItem(title: 'Status', infos: [_batteryController.status]),
            InfoItem(
              title: 'Technology',
              infos: [_batteryController.Technology],
            ),
            InfoItem(
              title: 'Temperature',
              infos: ['${_batteryController.Temperature} °C'],
            ),
            InfoItem(
              title: 'Voltage',
              infos: ['${_batteryController.Voltage} mV'],
            ),
          ],
        );
      },
    );
  }
}

class Thermal extends StatelessWidget {
  const Thermal({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoItem(title: 'Battery', infos: ['C']),
        InfoItem(title: 'ac', infos: ['C']),
        InfoItem(title: 'battery', infos: ['C']),
      ],
    );
  }
}

class Sensors extends StatefulWidget {
  const Sensors({super.key});

  @override
  State<Sensors> createState() => _SensorsState();
}

class _SensorsState extends State<Sensors> {
  late SensorController _sensorController;

  @override
  void initState() {
    _sensorController = SensorController();
    super.initState();
  }

  @override
  void dispose() {
    _sensorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _sensorController.updateCount,
      builder: (context, value, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              ...List.generate(
                _sensorController.sensorList.length,
                (index) => SensorItem(
                  title: _sensorController.sensorList[index].name,
                  info: SensorController.getSensorInfo(
                    _sensorController.sensorList[index],
                  ),
                ),
              ),

              SizedBox(height: 100),
            ],
          ),
        );
      },
    );
  }
}

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 24),

        Text(
          'CPU-Z',
          style: TextStyle(
            color: Global.mainColorDark,
            fontSize: 26,
            fontWeight: .w700,
          ),
        ),
        _subTip('for Android'),
        _subTip('Version 1.54'),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: _subSubTip('CPUID DPU-Z is a free software.'),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 74, vertical: 54),
          child: Column(
            spacing: 12,
            children: [
              _button(() {}, 'ONLINE VALIDATION'),
              _button(() {}, 'CPU-Z SETTINGS'),
              _button(() {}, 'HELP AND FAQ'),
              _button(() {}, 'REMOVE ADS'),
            ],
          ),
        ),

        Spacer(),

        Column(
          children: [
            _link('CPUID Web Page'),
            _link('Validation Web Page'),
            SizedBox(height: 6),
            _subSubTip('Copyright 2025 - CPUID - All Rights Reserved'),
          ],
        ),
      ],
    );
  }

  Widget _subTip(String text) {
    return Text(
      text,
      style: TextStyle(color: Global.grey, fontWeight: .w600),
    );
  }

  Widget _subSubTip(String text) {
    return Text(
      text,
      style: TextStyle(fontWeight: .w400, color: Global.grey),
    );
  }

  Widget _button(VoidCallback onTap, String text) {
    return SizedBox(
      height: 34,
      width: double.infinity,
      child: TextButton(
        onPressed: onTap,
        child: Text(text, style: TextStyle(color: Colors.white)),
        style: TextButton.styleFrom(
          backgroundColor: Global.mainColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _link(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Global.linkBlue,
        decoration: TextDecoration.underline,
        decorationThickness: 1,
        decorationColor: Global.linkBlue,
      ),
    );
  }
}
