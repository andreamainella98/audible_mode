package it.mainella.audible_mode.handler

import AudibleProfile
import android.content.Context
import android.content.Context.AUDIO_SERVICE
import android.media.AudioManager


class AudibleHandler(context: Context) {
    private val audioManager = context.getSystemService(AUDIO_SERVICE) as AudioManager

    fun getAudibleProfile(): AudibleProfile {
        return when (audioManager.ringerMode) {
            AudioManager.RINGER_MODE_NORMAL -> AudibleProfile.NORMAL_MODE
            AudioManager.RINGER_MODE_SILENT -> AudibleProfile.SILENT_MODE
            AudioManager.RINGER_MODE_VIBRATE -> AudibleProfile.VIBRATE_MODE
            else -> AudibleProfile.UNDEFINED
        }
    }

    fun getCurrentVolume(): Double {
        return audioManager.getStreamVolume(AudioManager.STREAM_MUSIC).toDouble()
    }

    fun getMaxVolume(): Double {
        return audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC).toDouble()
    }

    fun setVolume(volume: Double?) {
        if (volume != null)
            audioManager.setStreamVolume(AudioManager.STREAM_MUSIC, volume.toInt(), AudioManager.FLAG_SHOW_UI)
    }
}