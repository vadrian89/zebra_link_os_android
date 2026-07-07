## 0.0.7
* Updated ZebraLinkOsPlugin (Kotlin) to use executer for running functions
* Updated Dart callbacks to enable them to work async 
* Increased Flutter SDK requirement, to 3.32.0, to match the jni/jnigen packages requirements

## 0.0.6
* Upgraded Android Gradle plugin version to 8.13.2
* Upgraded Android compileSdk version to 36
* Upgraded Android Kotlin version to 2.1.21
* Updated example permissions_handler version to 12.0.1
* Updated example path_provider version to 2.1.5

## 0.0.5
* Updated zebra_link_os_platform_core version to 0.0.2
* PrinterDiscovererBluetooth.findPrinters will no longer use a try-catch because it's already in a try-catch block inside ZebraLinkOsPlugin.startDiscovery
* Updated ZebraLinkOsPlugin.startDiscovery to use a thread instead of a coroutine
* ZebraLinkOsPlugin.startDiscovery will call onError if the method is called while already in progress

## 0.0.4
* Changed compileSdk to 35 in both package and example
* Changed Java version used in both package and example to 17
* Updated jni/jnigen version to 0.12.2
* Added android.permission.BLUETOOTH_ADMIN permission to example
* Regenerated code and updated changes in the implementations
* Changed androidx.activity:activity-ktx version to 1.10.1
* Changed androidx.core plugins versions to 1.16.0

## 0.0.3
* Changed Gradle version used to 8.9.3 in both package and example
* Changed minSdkVersion to 29 in both package and example
* Changed compileSdk to 34 in both package and example
* Changed mockito-core to 5.19.0
* Changed androidx.activity:activity-ktx to 1.8.2 
* Changed Kotlin version used in example to 1.8.22
* Changed Java version used in example to 11
* Updated ZebraLinkOsPlugin.startDiscovery to use a coroutine
 
## 0.0.2
* Forgot what I implemented here
## 0.0.1
* Initial release
