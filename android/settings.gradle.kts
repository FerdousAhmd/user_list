// Fix for AGP AndroidLocationsException when both ANDROID_PREFS_ROOT and ANDROID_USER_HOME are set in environment
try {
    val pe = Class.forName("java.lang.ProcessEnvironment")
    fun cleanMap(fieldName: String) {
        try {
            val field = pe.getDeclaredField(fieldName).apply { isAccessible = true }
            val obj = field.get(null) ?: return
            if (obj is MutableMap<*, *>) {
                obj.remove("ANDROID_PREFS_ROOT")
            } else {
                try {
                    val mField = obj.javaClass.getDeclaredField("m").apply { isAccessible = true }
                    (mField.get(obj) as? MutableMap<*, *>)?.remove("ANDROID_PREFS_ROOT")
                } catch (_: Throwable) {}
            }
        } catch (_: Throwable) {}
    }
    cleanMap("theEnvironment")
    cleanMap("theUnmodifiableEnvironment")
    cleanMap("theCaseInsensitiveEnvironment")
} catch (_: Throwable) {}

pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        file("local.properties").inputStream().use { properties.load(it) }
        val flutterSdkPath = properties.getProperty("flutter.sdk")
        require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
        flutterSdkPath
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.7.3" apply false
    id("org.jetbrains.kotlin.android") version "2.1.0" apply false
}

include(":app")
