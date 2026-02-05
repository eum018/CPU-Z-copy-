package com.example.cpu_z_copy

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.hardware.Sensor
import android.hardware.SensorManager
import android.health.connect.datatypes.units.Pressure
import io.flutter.plugin.common.EventChannel


class Sensor(context: Context) {

    fun getSensorList(): List<String> {
        val sensorList = sensorManager.getSensorList(SensorManager.SENSOR_ALL)
        if (sensorList == null) return listOf()
        return sensorList.map { sensor -> sensor.name }
    }

    lateinit var receiver: BroadcastReceiver
    val sensorManager = context.getSystemService(Context.SENSOR_SERVICE) as SensorManager

    val sensorHandler = object : EventChannel.StreamHandler {

        override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
            receiver = object : BroadcastReceiver() {
                override fun onReceive(context: Context?, intent: Intent?) {
                    if (intent == null || events == null) return

                    val accelerometer = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)
                    val gyroscope = sensorManager.getDefaultSensor(Sensor.TYPE_GYROSCOPE)
                    val Pressure = sensorManager.getDefaultSensor(Sensor.TYPE_PRESSURE)
                    val gravity = sensorManager.getDefaultSensor(Sensor.TYPE_GRAVITY)
                    val rotationVector = sensorManager.getDefaultSensor(Sensor.TYPE_ROTATION_VECTOR)
                    val light = sensorManager.getDefaultSensor(Sensor.TYPE_LIGHT)
                    val orientation = sensorManager.getDefaultSensor(Sensor.TYPE_ORIENTATION)

                    TODO(
                        """
    |Cannot convert element
    |With text:
    |Accelerometer('Accelerometer'),
    |  Gyroscope('Gyroscope'),
    |  Pressure('Pressure'),
    |  gravity('gravity'),
    |  RotationVector('RotationVector'),
    |  Light('Light'),
    |  Orientation('Orientation');
    """.trimMargin()
                    )

                }
            }

        }

        override fun onCancel(arguments: Any?) {
        }

    }


}