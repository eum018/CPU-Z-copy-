package com.example.cpu_z_copy

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

/*
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            Define.METHOD_CHANNEL_NAME
        ).setMethodCallHandler { call, result -> {

            if(call.method == "") {


                result.success();
            }



        } }
        */


    }

    /*

    fun getBattery (): Int {



    }
    */

    object Define {

        const val METHOD_CHANNEL_NAME: String = "com.example.spu_z_copy_method_channel"
        const val EVENT_CHANNEL_NAME: String = "com.example.spu_z_copy_event_channel"

    }

}
