package it.mainella.audible_mode

import io.flutter.embedding.engine.plugins.FlutterPlugin
import it.mainella.audible_mode.handler.FlutterHandler

class AudibleModePlugin : FlutterPlugin {
    private lateinit var flutterHandler: FlutterHandler

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        flutterHandler = FlutterHandler(binding)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        flutterHandler.dispose()
    }
}
