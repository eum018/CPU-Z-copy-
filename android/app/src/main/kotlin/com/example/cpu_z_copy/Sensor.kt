package com.example.cpu_z_copy

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import io.flutter.plugin.common.EventChannel


class Sensor(context: Context) {
    val sensorManager = context.getSystemService(Context.SENSOR_SERVICE) as SensorManager
    lateinit var listener: SensorEventListener

    val sensorHandler = object : EventChannel.StreamHandler {

        override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
            if (events == null) return

            listener = object : SensorEventListener {
                override fun onSensorChanged(event: SensorEvent?) {
                    if (event == null) return
                    val result = mapOf(
                        "type" to "sensor",
                        "sensor_type" to event.sensor.stringType,
                        "id" to event.sensor.id,
                        "name" to event.sensor.name,
                        "content" to getValue(event)
                    )
                    events.success(result)
                }

                override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {}
            }
            sensorList.forEach { type ->
                sensorManager.registerListener(
                    listener, sensorManager.getDefaultSensor(type),
                    SensorManager.SENSOR_DELAY_NORMAL
                )
            }
        }

        override fun onCancel(arguments: Any?) {
            sensorManager.unregisterListener(listener)
        }

        val sensorList = listOf<Int>(
            Sensor.TYPE_ACCELEROMETER,
            Sensor.TYPE_GYROSCOPE_UNCALIBRATED,
            Sensor.TYPE_GYROSCOPE,
            Sensor.TYPE_PRESSURE,
            Sensor.TYPE_GRAVITY,
            Sensor.TYPE_ROTATION_VECTOR,
            Sensor.TYPE_PROXIMITY,
            Sensor.TYPE_MAGNETIC_FIELD,
            Sensor.TYPE_LIGHT,
            Sensor.TYPE_AMBIENT_TEMPERATURE
        )
    }

    fun getValue(event: SensorEvent): Map<String, Any> {
        val sensor = event.sensor
        return when (sensor.type) {
            Sensor.TYPE_LIGHT -> mapOf(
                "lux" to event.values[0]
            )
            Sensor.TYPE_GRAVITY, Sensor.TYPE_ACCELEROMETER, Sensor.TYPE_MAGNETIC_FIELD, Sensor.TYPE_GYROSCOPE, Sensor.TYPE_ROTATION_VECTOR -> mapOf(
                "x=" to event.values[0],
                "y=" to event.values[1],
                "z=" to event.values[2],
                "unit" to when (sensor.type) {
                    Sensor.TYPE_GRAVITY, Sensor.TYPE_ACCELEROMETER -> "m/s²"
                    Sensor.TYPE_MAGNETIC_FIELD -> "μT"
                    Sensor.TYPE_GYROSCOPE -> "rad/s"
                    Sensor.TYPE_ROTATION_VECTOR -> ""
                    else -> "error"
                }
            )
            Sensor.TYPE_AMBIENT_TEMPERATURE -> mapOf(
                "°C" to event.values[0]
            )
            Sensor.TYPE_PRESSURE -> mapOf(
                "hPa" to event.values[0]
            )
            Sensor.TYPE_PROXIMITY -> mapOf(
                "cm" to event.values[0]
            )
            else -> mapOf()
        }
    }

    fun getSensorList(): Map<String, Any> {
        val sensorList = sensorManager.getSensorList(SensorManager.SENSOR_ALL)
        if (sensorList == null) return mapOf<String, Any>("type" to "error")
        var result: Map<String, Any>
        result = mapOf(
            "type" to "sensor",
            "content" to sensorList.map { sensor -> sensor.name }
        )
        return result
    }


}