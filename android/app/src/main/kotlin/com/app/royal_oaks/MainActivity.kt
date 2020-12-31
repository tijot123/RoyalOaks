package com.app.royal_oaks

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity : FlutterActivity() {


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        // register plugins
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        //super.configureFlutterEngine(flutterEngine)
    }
}
