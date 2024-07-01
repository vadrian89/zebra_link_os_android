import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:jni/jni.dart';
import 'package:zebra_link_os_android/core.dart';
import 'package:zebra_link_os_android/permissions.dart';
import 'package:zebra_link_os_android/src/android/classes/jni_utils.dart';
import 'package:zebra_link_os_android/src/android/co/fieldos/zebra_link_os/DiscoveryHandlerBluetooth.dart';

import '../core/classes/discovery_handler_base.dart';
import 'co/fieldos/zebra_link_os/_package.dart' as g;
import 'com/zebra/sdk/printer/discovery/_package.dart' as z;

class ZebraLinkOsAndroid extends ZebraLinkOsPlatform {
  g.ZebraLinkOsPlugin? __plugin;
  g.ZebraLinkOsPlugin get _plugin => __plugin ??= g.ZebraLinkOsPlugin(
        JniUtils.context,
        DiscoveryHandlerBluetooth.implement(_DiscoveryHandlerBluetooth(
          onDiscoveryError: (value) => onError?.call(DiscoveredPrinterError(message: value)),
          onDiscoveryFinished: () => onFinished?.call(),
          onFoundPrinter: (value) => _printerFoundController.sink.add(
            value as DiscoveredPrinterBluetooth,
          ),
        )),
      );

  StreamController<DiscoveredPrinterBluetooth>? __printerFoundController;
  StreamController<DiscoveredPrinterBluetooth> get _printerFoundController =>
      __printerFoundController ??= StreamController<DiscoveredPrinterBluetooth>.broadcast();

  /// Called when an error occurs while trying to discover printers.
  final ValueChanged<DiscoveredPrinterError>? onError;

  /// Called when the SDK reports that it has finished discovering printers.
  final VoidCallback? onFinished;

  @override
  Stream<DiscoveredPrinterBluetooth> get printerFound => _printerFoundController.stream;

  ZebraLinkOsAndroid({
    this.onError,
    this.onFinished,
  });

  /// Check if the device is enabled and has the necessary permissions to use the bluetooth device.
  ///
  /// Returns [true] if the device is enabled and has the necessary permissions, otherwise [false].
  @override
  Future<bool> requestPermissions() async {
    final isEnabled = await BluetoothPermissions.isEnabled;
    if (!isEnabled) return false;
    final isScanGranted = await BluetoothPermissions.isScanPermissionGranted;
    if (!isScanGranted) return false;
    final isConnectGranted = await BluetoothPermissions.isConnectPermissionGranted;
    if (!isConnectGranted) return false;
    return await BluetoothPermissions.isLocationPermissionGranted;
  }

  @override
  Future<void> findPrinters() async => _plugin.findPrinters();

  @override
  Future<void> dispose() async {
    __plugin?.release();
    __plugin = null;
  }

  @override
  void write({required String string, required DiscoveredPrinter printer}) => _plugin.writeString(
        JString.fromString(printer.address),
        JString.fromString(string),
      );
}

class _DiscoveryHandlerBluetooth extends DiscoveryHandlerBase
    implements g.$DiscoveryHandlerBluetoothImpl {
  _DiscoveryHandlerBluetooth({
    super.onFoundPrinter,
    super.onDiscoveryFinished,
    super.onDiscoveryError,
  });

  @override
  void onError(JString string) => onDiscoveryError?.call(string.toDartString());
  @override
  void onFinished() => onDiscoveryFinished?.call();

  @override
  void onFound(z.DiscoveredPrinterBluetooth printer) => onFoundPrinter?.call(
        DiscoveredPrinterBluetooth(
          address: printer.address.toDartString(),
          friendlyName: printer.friendlyName.toDartString(),
        ),
      );
}
