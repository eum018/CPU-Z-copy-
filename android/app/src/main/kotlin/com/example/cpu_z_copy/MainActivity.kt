package com.example.cpu_z_copy

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    lateinit var _eventChannel: EventChannel
    lateinit var _methodChannel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            Channel.EVENT_CHANNEL_NAME.title + RequestApp.BATTERY.title
        ).setStreamHandler(Battery(context).batteryHandler)

        EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            Channel.EVENT_CHANNEL_NAME.title + RequestApp.SENSOR.title
        ).setStreamHandler(Sensor(context).sensorHandler)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            Channel.METHOD_CHANNEL_NAME.title + RequestApp.DEVICE.title
        ).setMethodCallHandler(Device(context).handler)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, Channel.METHOD_CHANNEL_NAME.title + RequestApp.SYSTEM.title
        ).setMethodCallHandler(System(context).handler)


    }


    enum class RequestApp(val title: String) {
        BATTERY("_battery"), THERMAL("_thermal"), SENSOR("_sensor"), SYSTEM("_system"), SOC("_soc"), DEVICE(
            "_device"
        );
    }

    enum class Channel(val title: String) {
        METHOD_CHANNEL_NAME("com.example.spu_z_copy_method_channel"),
        EVENT_CHANNEL_NAME("com.example.spu_z_copy_event_channel");
    }

}
