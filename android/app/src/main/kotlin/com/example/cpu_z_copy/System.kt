package com.example.cpu_z_copy

import android.app.ActivityManager
import android.content.Context
import android.os.Build
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class System(context: Context) {

    val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager

    val handler = object : MethodChannel.MethodCallHandler {
        override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {

            val androidVersion = Build.VERSION.SDK_INT
            val apiLevel = Build.VERSION.

        }
    }
}