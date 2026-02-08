package com.example.cpu_z_copy

import android.content.Context
import android.content.res.Resources
import android.os.Build
import android.os.StatFs
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlin.math.pow
import kotlin.math.sqrt

class Device(context: Context) {

    val storageStat = StatFs(context.filesDir.path)
    val runtime = Runtime.getRuntime()
    val metrics = Resources.getSystem().displayMetrics

    val handler = object : MethodChannel.MethodCallHandler {
        override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
            val resultData = mapOf(
                "type" to "device",
                "content" to when (call.method) {
                    DeviceRequest.MANUFACTURER.title -> Build.MANUFACTURER
                    DeviceRequest.HARDWARE.title -> Build.HARDWARE
                    DeviceRequest.BOARD.title -> Build.BOARD
                    DeviceRequest.MODEL.title -> Build.MODEL
                    DeviceRequest.SCREEN.title -> {
                        val wInch = metrics.widthPixels / metrics.xdpi
                        val hInch = metrics.heightPixels / metrics.ydpi
                        val size = sqrt(wInch.pow(2) + hInch.pow(2))
                        mapOf(
                            "size" to size,
                            "resolution" to "${metrics.heightPixels} x ${metrics.widthPixels} pixels",
                            "density" to metrics.densityDpi,
                        )
                    }

                    DeviceRequest.RAM.title -> mapOf(
                        "total" to runtime.totalMemory(),
                        "available" to runtime.freeMemory()
                    )

                    DeviceRequest.STORAGE.title -> {
                        var size = storageStat.blockSizeLong
                        var total = size * storageStat.blockCountLong
                        mapOf(
                            "total" to total,
                            "available" to total - (size * storageStat.availableBlocksLong)
                        )
                    }

                    else -> {
                        result.notImplemented()
                        return
                    }
                }
            )

            result.success(resultData)
        }
    }

}


enum class DeviceRequest(val title: String) {
    MODEL("model"), MANUFACTURER("manufacturer"), BOARD("board"), HARDWARE("hardware"), SCREEN("screen"), RAM(
        "ram"
    ),
    STORAGE("storage");
}