package it.mainella.audible_mode.handler

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.media.AudioManager
import io.flutter.plugin.common.EventChannel

class CurrentProfileStreamHandler(private var context: Context, private var audibleHandler: AudibleHandler) : EventChannel.StreamHandler {
    private lateinit var receiver: BroadcastReceiver
    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        receiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                events?.success(audibleHandler.getAudibleProfile().rawValue)
            }
        }
        val filter = IntentFilter(AudioManager.RINGER_MODE_CHANGED_ACTION)
        context.registerReceiver(receiver, filter)
    }

    override fun onCancel(arguments: Any?) {
        context.unregisterReceiver(receiver)
    }
}