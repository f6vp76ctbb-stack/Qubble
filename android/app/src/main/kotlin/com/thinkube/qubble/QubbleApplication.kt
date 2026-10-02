package com.thinkube.qubble

import android.app.Application
import com.google.android.gms.games.PlayGamesSdk

// Play Games Services v2 must be initialized in Application.onCreate; the SDK
// then signs the player in automatically when the game starts.
class QubbleApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        PlayGamesSdk.initialize(this)
    }
}
