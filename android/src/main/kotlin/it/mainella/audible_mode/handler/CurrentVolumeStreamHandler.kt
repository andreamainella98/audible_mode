package it.mainella.audible_mode.handler

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.media.AudioManager
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.StreamHandler


class CurrentVolumeStreamHandler(private var context: Context) : StreamHandler {
    private var audioManager: AudioManager = context.getSystemService(Context.AUDIO_SERVICE) as AudioManager
    private lateinit var receiver: BroadcastReceiver
    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        receiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                events?.let {
                    val currentVolume = audioManager.getStreamVolume(AudioManager.STREAM_MUSIC)
                    it.success(currentVolume)
                }
            }
        }

        val filter = IntentFilter()
        filter.addAction("android.media.VOLUME_CHANGED_ACTION")
        context.registerReceiver(receiver, filter)
    }

    override fun onCancel(arguments: Any?) {
        context.unregisterReceiver(receiver);
    }
}