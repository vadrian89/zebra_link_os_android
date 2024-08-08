import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:jni/jni.dart';
import 'package:zebra_link_os_android/core.dart';
import 'package:zebra_link_os_android/permissions.dart';
import 'package:zebra_link_os_android/src/android/classes/jni_utils.dart';
import 'package:zebra_link_os_android/src/android/co/fieldos/zebra_link_os/DiscoveryHandlerBluetooth.dart';
import 'package:zebra_link_os_android/src/android/co/fieldos/zebra_link_os/ResultCallbacksInterface.dart';

import '../core/classes/discovery_handler_base.dart';
import '../core/classes/zebra_link_os_exception.dart';
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
  ValueChanged<DiscoveredPrinterError>? onError;

  /// Called when the SDK reports that it has finished discovering printers.
  VoidCallback? onFinished;

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
  Future<bool> write({required String string, required DiscoveredPrinter printer}) {
    final Completer<bool> completer = Completer<bool>();
    _plugin.writeString(
      JString.fromString(printer.address),
      JString.fromString(string),
      _resultCallback(
        (result) => completer.complete(true),
        (message) => throw ZebraWriteException(
          message: message,
          stackTrace: StackTrace.current,
        ),
      ),
    );
    return completer.future;
  }

  @override
  Future<bool> printImage({
    required DiscoveredPrinter printer,
    required String filePath,
    int width = 0,
    int height = 0,
    int x = 0,
    int y = 0,
    bool insideFormat = false,
  }) {
    final Completer<bool> completer = Completer<bool>();
    _plugin.printImage(
      JString.fromString(printer.address),
      JString.fromString(filePath),
      x,
      y,
      width,
      height,
      insideFormat ? 1 : 0,
      _resultCallback(
        (result) => completer.complete(true),
        (message) => throw ZebraPrintImageException(
          message: message,
          stackTrace: StackTrace.current,
        ),
      ),
    );
    return completer.future;
  }

  @override
  Future<void> dispose() async {
    __plugin?.close(_resultCallback());
    await __printerFoundController?.close();
    __printerFoundController = null;
  }

  ResultCallbacksInterface _resultCallback([
    void Function(String result)? onSuccessEmitted,
    void Function(String message)? onErrorEmitted,
  ]) =>
      ResultCallbacksInterface.implement(_ResultCallbacks(
        onSuccessEmitted: onSuccessEmitted,
        onErrorEmitted: onErrorEmitted,
      ));
}

class _ResultCallbacks implements g.$ResultCallbacksInterfaceImpl {
  final ValueChanged<String>? onErrorEmitted;
  final ValueChanged<String>? onSuccessEmitted;

  const _ResultCallbacks({
    this.onErrorEmitted,
    this.onSuccessEmitted,
  });

  @override
  void onError(JString string) => onErrorEmitted?.call(string.toDartString());

  @override
  void onSuccess(JString string) => onSuccessEmitted?.call(string.toDartString());
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
