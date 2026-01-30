package com.example.cpu_z_copy

import android.os.BatteryManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)


        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            ChannelName.METHOD_CHANNEL_NAME
        ).setMethodCallHandler { call, result ->

            val info = when (call.method) {
                CallRequest.BATTERY -> getBattery()
                else -> {
                    result.notImplemented()
                    return@setMethodCallHandler
                }
            }

            result.success(info)

        }


    }


    fun getBattery(): Int {
        val batteryManager = getSystemService(BATTERY_SERVICE) as BatteryManager
        return batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    }


    object CallRequest {
        const val BATTERY = "battery"
    }

    object ChannelName {
        const val METHOD_CHANNEL_NAME: String = "com.example.spu_z_copy_method_channel"
        const val EVENT_CHANNEL_NAME: String = "com.example.spu_z_copy_event_channel"

    }

}
