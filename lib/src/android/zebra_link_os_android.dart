import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:jni/jni.dart';
import 'package:zebra_link_os_android/src/android/classes/jni_utils.dart';
import 'package:zebra_link_os_android/src/android/co/fieldos/zebra_link_os/DiscoveryHandlerBluetooth.dart';
import 'package:zebra_link_os_android/src/android/co/fieldos/zebra_link_os/ResultCallbacksInterface.dart';
import 'package:zebra_link_os_platform_core/classes.dart';
import 'package:zebra_link_os_platform_core/zebra_link_os_plugin.dart';

import '../core/classes/discovery_handler_base.dart';
import 'co/fieldos/zebra_link_os/_package.dart' as g;
import 'com/zebra/sdk/printer/discovery/_package.dart' as z;

class ZebraLinkOsAndroid extends ZebraLinkOsPluginBase {
  g.ZebraLinkOsPlugin? __plugin;
  g.ZebraLinkOsPlugin get _plugin => __plugin ??= g.ZebraLinkOsPlugin(
        JniUtils.context,
        DiscoveryHandlerBluetooth.implement(_DiscoveryHandlerBluetooth(
          onDiscoveryError: onError,
          onDiscoveryFinished: onFinished,
          onFoundPrinter: (value) => _printerFoundController.sink.add(
            value as DiscoveredPrinterBluetooth,
          ),
        )),
      );

  StreamController<DiscoveredPrinterBluetooth>? __printerFoundController;
  StreamController<DiscoveredPrinterBluetooth> get _printerFoundController =>
      __printerFoundController ??= StreamController<DiscoveredPrinterBluetooth>.broadcast();

  /// Called when an error occurs while trying to discover printers.
  ValueChanged<String>? onError;

  /// Called when the SDK reports that it has finished discovering printers.
  VoidCallback? onFinished;

  @override
  Stream<DiscoveredPrinterBluetooth> get printerFound => _printerFoundController.stream;

  ZebraLinkOsAndroid({
    this.onError,
    this.onFinished,
  });

  @override
  Future<void> startDiscovery() async => _plugin.findPrinters();

  @override
  Future<bool> connect({required String address}) {
    final Completer<bool> completer = Completer<bool>();
    _plugin.connect(
      JString.fromString(address),
      _resultCallback(
        (result) => completer.complete(true),
        (message) => completer.completeError(ZebraLinkOsException.connection(
          message: message,
          stackTrace: StackTrace.current,
        )),
      ),
    );
    return completer.future;
  }

  @override
  Future<bool> disconnect() {
    final Completer<bool> completer = Completer<bool>();
    _plugin.disconnect(
      _resultCallback(
        (result) => completer.complete(true),
        (message) => completer.completeError(ZebraLinkOsException.connection(
          message: message,
          stackTrace: StackTrace.current,
        )),
      ),
    );
    return completer.future;
  }

  @override
  Future<bool> write({required String data}) {
    final Completer<bool> completer = Completer<bool>();
    _plugin.write(
      JString.fromString(data),
      _resultCallback(
        (result) => completer.complete(true),
        (message) => completer.completeError(ZebraLinkOsException.write(
          message: message,
          stackTrace: StackTrace.current,
        )),
      ),
    );
    return completer.future;
  }

  @override
  Future<bool> printImageFile({
    required String filePath,
    int width = 0,
    int height = 0,
    int x = 0,
    int y = 0,
    bool insideFormat = false,
  }) {
    final Completer<bool> completer = Completer<bool>();
    _plugin.printImage(
      JString.fromString(filePath),
      x,
      y,
      width,
      height,
      insideFormat ? 1 : 0,
      _resultCallback(
        (result) => completer.complete(true),
        (message) => completer.completeError(ZebraLinkOsException.printImage(
          message: message,
          stackTrace: StackTrace.current,
        )),
      ),
    );
    return completer.future;
  }

  @override
  Future<void> dispose() async {
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
