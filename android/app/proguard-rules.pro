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
