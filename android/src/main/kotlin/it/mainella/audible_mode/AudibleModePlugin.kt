package it.mainella.audible_mode

import AudibleProfile
import android.content.Context
import android.media.AudioManager
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import it.mainella.audible_mode.utils.Constants

/** AudibleModePlugin */
class AudibleModePlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private var context: Context? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext;
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, Constants.METHOD_CHANNEL)
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            Constants.GET_AUDIBLE_MODE -> {
                val audio = context?.getSystemService(Context.AUDIO_SERVICE) as AudioManager
                when (audio.ringerMode) {
                    AudioManager.RINGER_MODE_NORMAL -> result.success(AudibleProfile.NORMAL_MODE.rawValue)
                    AudioManager.RINGER_MODE_SILENT -> result.success(AudibleProfile.SILENT_MODE.rawValue)
                    AudioManager.RINGER_MODE_VIBRATE -> result.success(AudibleProfile.VIBRATE_MODE.rawValue)
                }
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
