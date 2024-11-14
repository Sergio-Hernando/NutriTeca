# Reglas para Google Play Feature Delivery
-keep class com.google.android.play.core.splitinstall.** { *; }
-keep class com.google.android.play.core.assetpacks.** { *; }
-keep class com.google.android.play.core.review.** { *; }
-keep class com.google.android.play.core.appupdate.** { *; }
-keep class com.google.android.play.core.tasks.** { *; }

# Evitar que ProGuard elimine componentes importantes de AndroidX y AppCompat
-keep class androidx.appcompat.** { *; }
-keep interface androidx.appcompat.** { *; }

# Evitar que ProGuard elimine cualquier cosa de Flutter
-keep class io.flutter.** { *; }
-keep class io.flutter.plugin.** { *; }

# Mantener todos los anotaciones y metadatos necesarios
-keepattributes *Annotation*, Signature, EnclosingMethod

# Mantener clases de Google Play Core Tasks
-keep class com.google.android.play.core.tasks.** { *; }
-keep class com.google.android.play.core.tasks.OnFailureListener { *; }
-keep class com.google.android.play.core.tasks.OnSuccessListener { *; }
-keep class com.google.android.play.core.tasks.Task { *; }

# Mantener clases relacionadas con PlayStore Deferred Components Manager (si las usas)
-keep class io.flutter.embedding.engine.deferredcomponents.PlayStoreDeferredComponentManager { *; }

# Reglas generadas para suprimir advertencias relacionadas con Play Core Tasks
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task
