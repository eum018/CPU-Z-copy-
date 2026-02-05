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
        _eventChannel = EventChannel(flutterEngine.dartExecutor.binaryMessenger, ChannelName.EVENT_CHANNEL_NAME)
        _methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, ChannelName.METHOD_CHANNEL_NAME)

        _eventChannel.setStreamHandler(Battery(context).batteryHandler)

        _methodChannel.setMethodCallHandler { call, result ->
            val content = when(call.method){
                MethodRequest.SENSOR_LIST -> Sensor(context).getSensorList()
                else -> result.notImplemented()
            }
            result.success(content)
        }
    }

    object MethodRequest {
        const val BATTERY = "Battery"
        const val THERMAL = "Thermal"
        const val SENSOR_LIST = "Sensor_list"
        const val SYSTEM = "System"
        const val SOC = "Soc"
        const val DEVICE = "Device"
    }

    object ChannelName {
        const val METHOD_CHANNEL_NAME: String = "com.example.spu_z_copy_method_channel"
        const val EVENT_CHANNEL_NAME: String = "com.example.spu_z_copy_event_channel"
    }

}
