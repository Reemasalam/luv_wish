plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.luve_wish"
    compileSdk = flutter.compileSdkVersion

    // 🔧 Use the latest required NDK version
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.luve_wish"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // ✅ Disable minification to avoid Razorpay R8 crash
            isMinifyEnabled = false
            isShrinkResources = false

            // If you later want to enable minify again, make sure to add keep rules in proguard-rules.pro

            // ✅ Use your release signing config when ready (right now using debug for testing)
            signingConfig = signingConfigs.getByName("debug")

            // ✅ Still include ProGuard rules for safety
            proguardFiles(
                getDefaultProguardFile("proguard-android.txt"),
                "proguard-rules.pro"
            )
        }

        debug {
            // Keep normal debug config
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
