# Optional R8/ProGuard keep rules. Only used when isMinifyEnabled = true in
# android/app/build.gradle.kts. Test a release build after enabling.

# Flutter engine
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**

# Google Mobile Ads (AdMob) + UMP consent
-keep class com.google.android.gms.ads.** { *; }
-keep class com.google.android.ump.** { *; }
-dontwarn com.google.android.gms.ads.**

# Google Play Billing (in_app_purchase)
-keep class com.android.billingclient.** { *; }
-dontwarn com.android.billingclient.**

# Firebase / Google Play services (if enabled later)
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# flutter_local_notifications + Gson
#
# The plugin serialises scheduled notifications to SharedPreferences with Gson
# and reads them back in ScheduledNotificationReceiver and the boot receiver.
# Gson maps JSON keys to FIELD NAMES, so renaming the model fields silently
# breaks every notification that has to survive a reboot or an app update.
#
# Two facts make this a real risk here rather than a precaution:
#   1. flutter_local_notifications 18.0.1 ships NO consumer ProGuard rules of
#      its own (there is no *.pro in its AAR), so nothing supplies these
#      automatically.
#   2. It pins com.google.code.gson:gson:2.8.9. Gson only started shipping its
#      own META-INF/proguard/gson.pro (auto-applied by R8) in versions above
#      2.10.1, so that safety net does not apply at this version either.
#
# The plugin's models rely on field names rather than @SerializedName (only
# NotificationDetails.scheduleMode carries one), which is why the whole package
# is kept rather than just its annotated members.
-keep class com.dexterous.** { *; }
-dontwarn com.dexterous.**

# Gson itself: generic signatures and annotations must survive, and anything
# extending TypeToken must keep its type argument. Taken from the rules Gson
# ships from 2.10.1 onwards, which this version predates.
-keepattributes Signature
-keepattributes RuntimeVisibleAnnotations,AnnotationDefault
-keep,allowobfuscation class com.google.gson.reflect.TypeToken
-keep,allowobfuscation class * extends com.google.gson.reflect.TypeToken
-keepclassmembers,allowobfuscation class * {
  @com.google.gson.annotations.SerializedName <fields>;
}
-keepclassmembers class * extends com.google.gson.TypeAdapter {
  <init>();
}
-keepclassmembers class * implements com.google.gson.TypeAdapterFactory {
  <init>();
}

# androidx.startup — App Startup initializers
#
# androidx.startup's InitializationProvider instantiates Initializer classes
# BY NAME, taken from <meta-data> entries the library manifests contribute:
#
#   <meta-data android:name="androidx.lifecycle.ProcessLifecycleInitializer"
#              android:value="androidx.startup" />
#
# The class name is the meta-data's NAME attribute, not a class reference AGP
# recognises, so the manifest keep rules do not protect it. R8 removes the
# class, InitializationProvider cannot construct it, and the app dies at
# startup with androidx.startup.StartupException before the first frame.
#
# This app pulls the mechanism in transitively: google_mobile_ads 9.0.0
# depends on androidx.lifecycle:lifecycle-process:2.10.0, which registers
# ProcessLifecycleInitializer this way.
-keep class * extends androidx.startup.Initializer {
    <init>();
}
-keep class androidx.startup.** { *; }
-dontwarn androidx.startup.**

# Room-Datenbanken, die über androidx.startup hochgezogen werden
#
# WorkManager kommt transitiv über den Google-Mobile-Ads-SDK herein und wird
# von androidx.startup initialisiert. Sein WorkDatabase ist eine Room-Datenbank,
# und Room findet die generierte Implementierung per Reflexion:
# Room.getGeneratedImplementation() sucht Class.forName(<Name> + "_Impl").
# Benennt R8 die Klasse um, schlägt die Suche fehl und der Initializer wirft
# eine RuntimeException, die androidx.startup in eine StartupException packt.
#
# Genau das ist im veröffentlichten Build passiert (Crashlytics, 2026-09-01:
# "Failed to create an instance of androidx.work.impl.WorkDatabase", 80 Abstürze
# bei 14 Nutzern). Die Keep-Regel für Initializer allein reicht nicht: Sie
# schützt die Initializer-Klasse, nicht die Room-Klasse, die deren create()
# anfasst.
#
# Beide Formen bewusst, statt auf die Vererbungssuche zu vertrauen: Die erste
# deckt jede Room-Datenbank ab (auch künftige), die zweite nennt die konkrete
# generierte Klasse, um die es hier geht.
-keep class * extends androidx.room.RoomDatabase { *; }
-keep class androidx.work.impl.WorkDatabase_Impl { *; }
-keep class androidx.work.** { *; }
-dontwarn androidx.work.**
