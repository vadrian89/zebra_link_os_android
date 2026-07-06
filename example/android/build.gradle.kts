buildscript {
    val kotlin_version by extra("2.1.21")

    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath("com.android.tools.build:gradle:8.13.2")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Set the root project build directory.
val newBuildDir = file("../build")
rootProject.layout.buildDirectory.set(newBuildDir)

// Set each subproject's build directory inside the shared build folder.
subprojects {
    val subBuildDir = File(newBuildDir, project.name)
    project.layout.buildDirectory.set(subBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
