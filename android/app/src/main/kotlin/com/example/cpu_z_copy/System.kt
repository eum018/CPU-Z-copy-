package com.example.cpu_z_copy

import android.app.ActivityManager
import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import android.os.SystemClock
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.lang.System
import kotlin.concurrent.thread

class System(context: Context) {

    val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager

    val handler = object : MethodChannel.MethodCallHandler {
        override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {

            val resultData = mapOf(
                "type" to "system",
                "content" to when (call.method) {
                    "android_version" -> Build.VERSION.RELEASE
                    "api_version" -> Build.VERSION.SDK_INT
                    "spl" -> Build.VERSION.SECURITY_PATCH
                    "boot_loader" -> Build.BOOTLOADER
                    "build_id" -> Build.ID
                    "java_vm" -> System.getProperty("java.vm.version")
                    "openGL_version" -> activityManager.deviceConfigurationInfo.glEsVersion
                    "kernel_arch" -> System.getProperty("os.arch")
                    "kernel_version" -> try {File("/proc/version").readText()} catch (e: Exception) {"Not Found"}
                    "root_access" -> File("/system/bin/su").exists() || File("/system/xbin/su").exists()
                    "gps" -> try {
                        context.packageManager.getPackageInfo(
                            "com.google.android.gms",
                            0
                        ).packageName
                    } catch (e: PackageManager.NameNotFoundException) {
                        "not install googlePlayService"
                    }
                    "uptime" -> SystemClock.elapsedRealtimeNanos()
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