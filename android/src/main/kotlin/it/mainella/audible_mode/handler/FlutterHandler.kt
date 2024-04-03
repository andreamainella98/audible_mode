package it.mainella.audible_mode.handler

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import it.mainella.audible_mode.utils.Constants

class FlutterHandler(binding: FlutterPlugin.FlutterPluginBinding) {
    private var channel: MethodChannel = MethodChannel(binding.binaryMessenger, Constants.METHOD_CHANNEL)
    private var currentProfileEventChannel: EventChannel = EventChannel(binding.binaryMessenger, Constants.CURRENT_PROFILE_EVENT)
    private var currentVolumeEventChannel: EventChannel = EventChannel(binding.binaryMessenger, Constants.CURRENT_VOLUME_EVENT)
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
        currentVolumeEventChannel.setStreamHandler(
            CurrentVolumeStreamHandler(
                context = binding.applicationContext
            )
        )

        currentProfileEventChannel.setStreamHandler(
            CurrentProfileStreamHandler(
                context = binding.applicationContext,
                audibleHandler = audibleHandler
            )
        )
    }

    fun dispose() {
        channel.setMethodCallHandler(null)
        currentProfileEventChannel.setStreamHandler(null)
        currentVolumeEventChannel.setStreamHandler(null)
    }
}