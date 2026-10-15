import java.io.FileInputStream
import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Phần ký release này là SCAFFOLD: chỉ kích hoạt khi file
// `app/android/key.properties` tồn tại (gitignore ở local, CI tự ghi từ
// secret — xem .github/workflows/store-release.yml và
// docs/release-pipeline.md). Chưa có thì build release vẫn ký bằng debug
// key như cũ, nên `flutter build apk --release` và workflow Firebase App
// Distribution vẫn chạy đúng như trước, không bị ảnh hưởng.
val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()
val hasReleaseSigning = keystorePropertiesFile.exists()
if (hasReleaseSigning) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.example.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        if (hasReleaseSigning) {
            create("release") {
                storeFile = file(keystoreProperties["storeFile"] as String)
                storePassword = keystoreProperties["storePassword"] as String
                keyAlias = keystoreProperties["keyAlias"] as String
                keyPassword = keystoreProperties["keyPassword"] as String
            }
        }
    }

    buildTypes {
        release {
            // Ký release thật khi `key.properties` tồn tại (xem phía trên);
            // không có thì fallback về debug key để build test ở
            // local/CI (ví dụ Firebase App Distribution) vẫn chạy đúng như cũ.
            signingConfig = if (hasReleaseSigning) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
        }
    }

    flavorDimensions += "version"
    productFlavors {
        create("dev") {
            dimension = "version"
            resValue("string", "app_name", "Fm Expenses Dev")
            applicationIdSuffix = ".dev"
            versionNameSuffix = "-dev"
        }
        create("stag") {
            dimension = "version"
            resValue("string", "app_name", "Fm Expenses Stag")
            applicationIdSuffix = ".stag"
            versionNameSuffix = "-stag"
        }
        create("prod") {
            dimension = "version"
            resValue("string", "app_name", "Fm Expenses prod")
            applicationId = "com.fm.expense"
            versionNameSuffix = "-prod"
        }
    }
}

flutter {
    source = "../.."
}
