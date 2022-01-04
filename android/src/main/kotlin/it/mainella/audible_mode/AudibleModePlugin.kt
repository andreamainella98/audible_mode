package it.mainella.audible_mode

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import it.mainella.audible_mode.handler.FlutterHandler

class AudibleModePlugin : FlutterPlugin {
    private lateinit var flutterHandler: FlutterHandler

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        flutterHandler = FlutterHandler(binding)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        flutterHandler.dispose()
    }
}
