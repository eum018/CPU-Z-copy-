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
            val resultData = when (call.method) {
                DeviceRequest.MANUFACTURER.title -> resultDataPut(Build.MANUFACTURER)
                DeviceRequest.HARDWARE.title -> resultDataPut(Build.HARDWARE)
                DeviceRequest.BOARD.title -> resultDataPut(Build.BOARD)
                DeviceRequest.MODEL.title -> resultDataPut(Build.MODEL)
                DeviceRequest.SCREEN.title -> {
                    val wInch = metrics.widthPixels / metrics.xdpi
                    val hInch = metrics.heightPixels / metrics.ydpi
                    val size = sqrt(wInch.pow(2) + hInch.pow(2))
                    resultDataPut(
                        mapOf(
                            "size" to size,
                            "resolution" to "${metrics.heightPixels} x ${metrics.widthPixels} pixels",
                            "density" to metrics.densityDpi,
                        )
                    )
                }

                DeviceRequest.RAM.title -> resultDataPut(
                    mapOf(
                        "total" to runtime.totalMemory(),
                        "available" to runtime.freeMemory()
                    )
                )

                DeviceRequest.STORAGE.title -> {
                    var size = storageStat.blockSizeLong
                    var total = size * storageStat.blockCountLong
                    resultDataPut(
                        mapOf(
                            "total" to total,
                            "available" to total - (size * storageStat.availableBlocksLong)
                        )
                    )
                }

                else -> result.notImplemented()
            }

            result.success(resultData)
        }

        fun resultDataPut(content: Any): Map<String, Any> {
            var result = mapOf<String, Any>(
                "type" to "device",
                "content" to content,
            )
            return result
        }
    }

}


enum class DeviceRequest(val title: String) {
    MODEL("model"), MANUFACTURER("manufacturer"), BOARD("board"), HARDWARE("hardware"), SCREEN("screen"), RAM(
        "ram"
    ),
    STORAGE("storage");
}