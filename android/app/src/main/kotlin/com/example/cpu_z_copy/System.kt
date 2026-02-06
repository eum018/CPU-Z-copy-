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

class System(context: Context) {

    val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager

    val handler = MethodChannel.MethodCallHandler { call, result ->

        val resultData = when (call.method) {
            "system_info" -> getResult()
            else -> return@MethodCallHandler
        }
        result.success(resultData)
    }

    fun getResult () : Map<String, Any> {
        val androidVersion = Build.VERSION.RELEASE
        val apiLevel = Build.VERSION.SDK_INT
        val securityPatchVersion = Build.VERSION.SECURITY_PATCH
        val bootLoader = Build.BOOTLOADER
        val buildId = Build.ID
        val javaVm = System.getProperty("java.vm.version")
        val openGlVersion = activityManager.deviceConfigurationInfo.glEsVersion
        val kernelVer = File("/proc/version").readText()
        val kernelArch = System.getProperty("os.arch")
        val googlePlayService = try {
            val info = context.packageManager.getPackageInfo("com.google.android.gms", 0)
            info.versionName!!
        } catch (e: PackageManager.NameNotFoundException) {
            "Not Install GooglePlay"
        }

        val rootAccess = File("/system/bin/su").exists() || File("/system/xbin/su").exists()
        val upTime = SystemClock.elapsedRealtime()

        return mapOf<String, Any>(
            "type" to "system",
            "android_version" to androidVersion,
            "api_level" to apiLevel,
            "google_play_service" to googlePlayService,
            "kernel_version" to kernelVer,
            "kernel_arch" to kernelArch,
            "root_access" to rootAccess,
            "security_patch_level" to securityPatchVersion,
            "bootLoader" to bootLoader,
            "build_id" to buildId,
            "java_vm_version" to javaVm,
            "openGL_version" to openGlVersion,
            "uptime" to upTime,
        )
    }

}