package com.thinkube.qubble

import android.app.Application
import com.google.android.gms.games.PlayGamesSdk

// Play Games Services v2 must be initialized in Application.onCreate; the SDK
// then signs the player in automatically when the game starts. Behind
// res/values/play_games.xml until the Console side and the Data safety form
// are ready.
class QubbleApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        if (resources.getBoolean(R.bool.play_games_enabled)) {
            PlayGamesSdk.initialize(this)
        }
    }
}
