import 'package:permission_handler/permission_handler.dart';

/// Class used to manage the permissions and state of the bluetooth device
///
/// It's using [permission_handler](https://pub.dev/packages/permission_handler) package because
/// it's easier than to manually implement the permission handling for each platform natively.
class BluetoothPermissions {
  static PermissionWithService get _locationService => Permission.location;
  static PermissionWithService get _btPermission => Permission.bluetooth;
  static Permission get _btScanPermission => Permission.bluetoothScan;
  static Permission get _btConnectPermission => Permission.bluetoothConnect;

  /// Checks if bluetooth device is enabled
  static Future<bool> get isEnabled => _btPermission.serviceStatus.isEnabled;

  /// Checks if the app has permission to use location service.
  ///
  /// Returns [true] if the permission is granted, otherwise it tries to request the permission and
  /// returns the request's result.
  static Future<bool> get isLocationPermissionGranted async =>
      (await _locationService.isGranted) || (await _locationService.request().isGranted);

  /// Checks if the app has permission to use bluetooth scanner.
  ///
  /// Returns [true] if the permission is granted, otherwise it tries to request the permission and
  /// returns the request's result.
  static Future<bool> get isScanPermissionGranted async =>
      (await _btScanPermission.isGranted) || (await _btScanPermission.request().isGranted);

  /// Checks if the app has permission to use bluetooth to connect to other devices.
  ///
  /// Returns [true] if the permission is granted, otherwise it tries to request the permission and
  /// returns the request's result.
  static Future<bool> get isConnectPermissionGranted async =>
      (await _btConnectPermission.isGranted) || (await _btConnectPermission.request().isGranted);
}
