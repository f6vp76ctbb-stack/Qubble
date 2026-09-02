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
# und Room holt die generierte Implementierung per Reflexion:
# Class.forName(<Name> + "_Impl"), dann newInstance().
#
# Der vollständige Stacktrace (Crashlytics, 2026-09-01) benennt die Ursache
# genauer, als es "Reflexion schlägt fehl" täte:
#
#   java.lang.RuntimeException: Failed to create an instance of
#       androidx.work.impl.WorkDatabase
#     at androidx.room.Room.getGeneratedImplementation(Room.java:100)
#     at androidx.work.WorkManagerInitializer.create(WorkManagerInitializer:39)
#
# Room wirft dort drei verschiedene Meldungen, je nach Ausnahme:
#   ClassNotFoundException -> "cannot find implementation for ..."
#   IllegalAccessException -> "Cannot access the constructor ..."
#   InstantiationException -> "Failed to create an instance of ..."
#
# Wir haben die dritte. Die Klasse wurde also GEFUNDEN — ihr Name hat überlebt.
# Was fehlte, war der parameterlose Konstruktor. Genau das beschreibt Google
# für R8 Full Mode: "removes the no-args/default constructor even when the
# class itself is retained". Deshalb hat auch die Consumer-Regel von
# WorkManager/Room nicht gerettet: Einen Namen zu behalten genügt hier nicht.
#
# Folglich muss die Regel Member mitnehmen ({ *; }), nicht nur den Klassennamen.
# Beide Formen bewusst: Die erste deckt jede Room-Datenbank ab (auch künftige,
# und über die Vererbungskette auch die _Impl-Klassen), die zweite nennt die
# konkrete generierte Klasse, um die es hier ging.
#
# 142 Abstürze bei 23 Nutzern in der veröffentlichten Fassung.
-keep class * extends androidx.room.RoomDatabase { *; }
-keep class androidx.work.impl.WorkDatabase_Impl { *; }
-keep class androidx.work.** { *; }
-dontwarn androidx.work.**
-dontwarn androidx.room.**

# Berichte, mit denen der Release-Build seine eigenen Regeln nachweist
#
# mapping.txt taugt dafür nicht: Es verzeichnet Umbenennungen, nicht Verbleib.
# Ein Konstruktor, der erhalten UND nicht umbenannt wurde, steht dort schlicht
# nicht drin — eine Prüfung darauf meldet Fehlalarm (Build 24, 2026-09-02).
#
# seeds.txt listet, was die Keep-Regeln tatsächlich getroffen haben.
# usage.txt listet, was R8 entfernt hat. Zusammen beantworten sie die Frage,
# an der der ausgelieferte Absturz hing: Hat der parameterlose Konstruktor
# überlebt?
-printseeds seeds.txt
-printusage usage.txt
