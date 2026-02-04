import 'dart:io';

import 'package:cpu_z_copy/controller/battery_controller.dart';
import 'package:cpu_z_copy/main.dart';
import 'package:cpu_z_copy/widget/info_item.dart';
import 'package:flutter/material.dart';

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

class Device extends StatelessWidget {
  const Device({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoItem(title: 'Model', infos: ['dd']),
        InfoItem(title: 'Manufacturer', infos: ['dd']),
        InfoItem(title: 'Board', infos: ['dd']),
        InfoItem(title: 'Hardware', infos: ['dd']),
        InfoItem(title: 'Screen Size', infos: ['dd']),
        InfoItem(title: 'Screen Resolution', infos: ['dd']),
        InfoItem(title: 'Screen Density', infos: ['dd']),
        InfoItem(title: 'Total RAM', infos: ['dd']),
        InfoItem(title: 'Available', infos: ['dd']),
        InfoItem(title: 'Internal Storage', infos: ['dd']),
        InfoItem(title: 'Available Storage', infos: ['dd']),
      ],
    );
  }
}

class System extends StatelessWidget {
  const System({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoItem(title: 'Android Version', infos: ['']),
        InfoItem(title: 'API Level', infos: ['']),
        InfoItem(title: 'Security Patch Level', infos: ['']),
        InfoItem(title: 'Bootloader', infos: ['']),
        InfoItem(title: 'Build ID', infos: ['']),
        InfoItem(title: 'Java VM', infos: ['']),
        InfoItem(title: 'Kernel Architecture', infos: ['']),
        InfoItem(title: 'Kernel Version', infos: ['']),
        InfoItem(title: 'Root Access', infos: ['']),
        InfoItem(title: 'Google Play Services', infos: ['']),
        InfoItem(title: 'System Uptime', infos: ['']),
      ],
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

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _batteryController.init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _batteryController.updateCount,
      builder: (context, value, child) {
        return Column(
          children: [
            InfoItem(title: 'Health', infos: []),
            InfoItem(title: 'Level', infos: ['${_batteryController.level}']),
            InfoItem(title: 'Power Source', infos: []),
            InfoItem(title: 'Technology', infos: []),
            InfoItem(title: 'Temperature', infos: []),
            InfoItem(title: 'Voltage', infos: []),
          ],
        );
      }
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

class Sensors extends StatelessWidget {
  const Sensors({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SensorItem(title: 'LSM6DSO Accelerometer', info: ''),
          SensorItem(title: 'AK09918 Magnetometer', info: ''),
          SensorItem(title: 'LSM6DSO Gyroscope', info: ''),
          SensorItem(
            title: 'TMD4907 Light Ambient Light Sensor Non-wakeup',
            info: '',
          ),
          SensorItem(title: 'Ips22hh Pressure Sensor Non-wakeup', info: ''),
          SensorItem(title: 'gravity Non-wakeup', info: ''),
          SensorItem(title: 'linear_acceleration', info: ''),
          SensorItem(title: 'Rotation Vector Non-wakeup', info: ''),
          SensorItem(title: 'AL09918 Magnetometer', info: ''),
          SensorItem(title: 'Game Rotation Vector Non-wakeup', info: ''),
          SensorItem(title: 'Rotation Vector Non-wakeup', info: ''),
          SensorItem(title: 'LSM6DSO Gyroscope-Uncalibrated', info: ''),
          SensorItem(title: 'sdm Wakeup', info: ''),
          SensorItem(title: 'step_detector Non-wakeup', info: ''),
          SensorItem(title: 'step_counter Non-wakeup', info: ''),
          SensorItem(title: 'Tilt Detector Wakeup', info: ''),
          SensorItem(title: 'Pick Up Gesture Wakeup', info: ''),
          SensorItem(title: 'Screen Orientation Sensor', info: ''),
          SensorItem(title: 'motion_detect', info: ''),
          SensorItem(title: 'LSM6DSO Accelerometer_Uncalibrated', info: ''),
          SensorItem(title: 'WideIR ALS', info: ''),
          SensorItem(title: 'interrupt_gyro Non-wakeup', info: ''),
          SensorItem(title: 'Proximity strm', info: ''),
          SensorItem(title: 'SensorHub type', info: ''),
          SensorItem(title: 'TMD4907 Light CCT Non-wakeup', info: ''),
          SensorItem(title: 'Wake Up Motion Wakeup', info: ''),
          SensorItem(
            title: 'TMD4907 Proximity Proximity Sensor Wakeup',
            info: '',
          ),
          SensorItem(title: 'call_gesture Wakeup', info: ''),
          SensorItem(
            title: 'TMD4907 Light Auto Brightness Non-wakeup',
            info: '',
          ),
          SensorItem(title: 'Pocket mode Wakeup', info: ''),
          SensorItem(title: 'Led Cover Event Wakeup', info: ''),
          SensorItem(title: 'Shake to Share Wakeup', info: ''),
          SensorItem(title: 'Sar BackOff Motion Wakeup', info: ''),
          SensorItem(title: 'Pocket Position Mode Wakeup', info: ''),
          SensorItem(title: 'SX9360 Grip sensor', info: ''),
          SensorItem(title: 'Touch Proximity Sensor', info: ''),
          SensorItem(title: 'Hall IC', info: ''),
          SensorItem(title: 'TCS3407 Rear ALS', info: ''),
          SensorItem(title: 'Palm Proximity Sensor version 2', info: ''),
          SensorItem(title: 'Motion Sensor', info: ''),
          SensorItem(title: 'Orientation Sensor', info: ''),
          //Wake Up Motion WakeUp
        ],
      ),
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
