package com.example.cpu_z_copy

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import io.flutter.plugin.common.EventChannel

class Battery(context: Context) {

    val batteryHandler = object : EventChannel.StreamHandler {
        lateinit var receiver: BroadcastReceiver
        val batteryManager = context.getSystemService(Context.BATTERY_SERVICE) as BatteryManager

        override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
            receiver = object : BroadcastReceiver() {
                override fun onReceive(context: Context?, intent: Intent?) {
                    if (intent == null || events == null) return
                    val health = getHealth(intent.getIntExtra(BatteryManager.EXTRA_HEALTH, -1))
                    val status = getStatus(intent.getIntExtra(BatteryManager.EXTRA_STATUS, -1))
                    val level =
                        batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
                    val temperature = intent.getIntExtra(BatteryManager.EXTRA_TEMPERATURE, 0) / 10
                    val powerSource = getPowerSource(intent.getIntExtra(BatteryManager.EXTRA_PLUGGED, -1))
                    val voltage = intent.getIntExtra(BatteryManager.EXTRA_VOLTAGE, 0)

                    val result = mapOf<String, Any>(
                        "type" to "battery",
                        "health" to health,
                        "status" to status,
                        "level" to level,
                        "temperature" to temperature,
                        "powerSource" to powerSource,
                        "valtage" to voltage
                    )
                    events.success(result)
                }
            }
            context.registerReceiver(receiver, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
        }

        override fun onCancel(arguments: Any?) {
            receiver.let { context.unregisterReceiver(it) }
        }

    }


    fun getHealth(health: Int): String {
        return when (health) {
            BatteryManager.BATTERY_HEALTH_GOOD -> "Good"
            BatteryManager.BATTERY_HEALTH_OVERHEAT -> "Over heat"
            BatteryManager.BATTERY_HEALTH_COLD -> "Cold"
            BatteryManager.BATTERY_HEALTH_DEAD -> "Dead"
            BatteryManager.BATTERY_HEALTH_OVER_VOLTAGE -> "Over voltage"
            BatteryManager.BATTERY_HEALTH_UNSPECIFIED_FAILURE -> "Unspecified failure"
            BatteryManager.BATTERY_HEALTH_UNKNOWN -> "Unknown"
            else -> "Error"
        }
    }

    fun getStatus(status: Int): String {
        return when (status) {
            BatteryManager.BATTERY_STATUS_CHARGING -> "Charging"
            BatteryManager.BATTERY_STATUS_FULL -> "Full"
            BatteryManager.BATTERY_STATUS_DISCHARGING -> "Discharging"
            BatteryManager.BATTERY_STATUS_NOT_CHARGING -> "Not charging"
            BatteryManager.BATTERY_STATUS_UNKNOWN -> "Unknown"
            else -> "Error"
        }
    }

    fun getPowerSource(status: Int): String {
        return when (status) {
            BatteryManager.BATTERY_PLUGGED_AC -> "ac"
            BatteryManager.BATTERY_PLUGGED_USB -> "usb"
            BatteryManager.BATTERY_PLUGGED_DOCK -> "dock"
            BatteryManager.BATTERY_PLUGGED_WIRELESS -> "wireless"
            else -> "battery"
        }
    }


}