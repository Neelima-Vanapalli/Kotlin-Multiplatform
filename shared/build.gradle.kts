import org.jetbrains.kotlin.gradle.dsl.JvmTarget

plugins {
    alias(libs.plugins.kotlinMultiplatform)
    alias(libs.plugins.androidLibrary)
}

kotlin {
    androidTarget {
        compilations.all {
            compileTaskProvider.configure {
                compilerOptions {
                    jvmTarget.set(JvmTarget.JVM_1_8)
                }
            }
        }
    }
    
    listOf(
        iosX64(),
        iosArm64(),
        iosSimulatorArm64()
    ).forEach {
        it.binaries.framework {
            baseName = "shared"
            isStatic = true
        }
    }

    sourceSets {
        commonMain.dependencies {
            implementation(libs.kotlinx.coroutines.core.v181) // Use the latest version
            implementation(libs.kotlinx.coroutines.core)
        }
        commonTest.dependencies {
            implementation(libs.kotlin.test)
        }
        getByName("commonMain") {
            dependencies {
            }
        }
    }

    tasks.register("assembleXCFramework") {
        dependsOn(
            "linkDebugFrameworkIosX64",
            "linkDebugFrameworkIosArm64",
            "linkDebugFrameworkIosSimulatorArm64",
            "linkReleaseFrameworkIosX64",
            "linkReleaseFrameworkIosArm64",
            "linkReleaseFrameworkIosSimulatorArm64"
        )

        doLast {
            val frameworkDir = layout.buildDirectory.dir("bin/ios").get().asFile
            println("XCFramework is ready in ${frameworkDir.absolutePath}")
        }
    }
}

android {
    namespace = "com.example.demoapp"
    compileSdk = 34
    defaultConfig {
        minSdk = 24
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
}
