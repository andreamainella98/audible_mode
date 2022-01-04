package it.mainella.audible_mode.handler

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.media.AudioManager
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import it.mainella.audible_mode.utils.Constants

class FlutterHandler(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    private var channel: MethodChannel = MethodChannel(binding.binaryMessenger, Constants.METHOD_CHANNEL)
    private var audibleProfileChannel: EventChannel = EventChannel(binding.binaryMessenger, Constants.EVENT_CHANNEL)
    private var audibleHandler = AudibleHandler(binding.applicationContext)

    init {
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                Constants.GET_AUDIBLE_MODE -> {
                    result.success(audibleHandler.getAudibleProfile().rawValue)
                }
                Constants.GET_CURRENT_VOLUME -> {
                    result.success(audibleHandler.getCurrentVolume())
                }
                Constants.SET_VOLUME -> {
                    audibleHandler.setVolume(call.argument<Double>("volume"))
                    result.success(true)
                }
                Constants.GET_MAX_VOLUME -> {
                    result.success(audibleHandler.getMaxVolume())
                }
                else -> result.notImplemented()
            }
        }

        audibleProfileChannel.setStreamHandler(object : EventChannel.StreamHandler {
            private lateinit var receiver: BroadcastReceiver

            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                receiver = object : BroadcastReceiver() {
                    override fun onReceive(context: Context, intent: Intent) {
                        events?.success(audibleHandler.getAudibleProfile().rawValue)
                    }
                }
                val filter = IntentFilter(AudioManager.RINGER_MODE_CHANGED_ACTION)
                binding.applicationContext.registerReceiver(receiver, filter)

            }

            override fun onCancel(arguments: Any?) {
                binding.applicationContext.unregisterReceiver(receiver)
            }
        })
    }

    fun dispose() {
        channel.setMethodCallHandler(null)
        audibleProfileChannel.setStreamHandler(null)
    }
}