import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:jni/jni.dart';
import 'package:zebra_link_os_platform_core/classes.dart';
import 'package:zebra_link_os_platform_core/zebra_link_os_plugin.dart';

import 'src/android/classes/jni_utils.dart';
import 'src/android/co/fieldos/zebra_link_os/_package.dart';
import 'src/android/com/zebra/sdk/printer/discovery/_package.dart' as z;
import 'src/core/classes/discovery_handler_base.dart';

export 'core.dart';

class ZebraLinkOsAndroid extends ZebraLinkOsPluginBase {
  ZebraLinkOsPlugin? __plugin;
  ZebraLinkOsPlugin get _plugin => __plugin ??= ZebraLinkOsPlugin(JniUtils.context);

  StreamController<DiscoveredPrinterBluetooth>? __printerFoundController;
  StreamController<DiscoveredPrinterBluetooth> get _printerFoundController =>
      __printerFoundController ??= StreamController<DiscoveredPrinterBluetooth>.broadcast();

  @override
  Stream<DiscoveredPrinterBluetooth> get printerFound => _printerFoundController.stream;

  ZebraLinkOsAndroid();

  /// Register this dart class as the platform implementation
  static void registerWith() => ZebraLinkOsPluginBase.instance = ZebraLinkOsAndroid();

  @override
  Future<List<DiscoveredPrinterBluetooth>?> startDiscovery() {
    final list = <DiscoveredPrinterBluetooth>[];
    final completer = Completer<List<DiscoveredPrinterBluetooth>?>();
    _plugin.startDiscovery(
      DiscoveryHandlerBluetooth.implement(
        _DiscoveryHandlerBluetooth(
          onDiscoveryError: (value) => completer.completeError(ZebraLinkOsException(
            message: value,
            stackTrace: StackTrace.current,
          )),
          onDiscoveryFinished: () => completer.complete(list),
          onFoundPrinter: (value) {
            final printer = value as DiscoveredPrinterBluetooth;
            _printerFoundController.sink.add(printer);
            list.add(printer);
          },
        ),
      ),
    );
    return completer.future;
  }

  @override
  Future<bool> connect({required String address}) {
    final completer = Completer<bool>();
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
    final completer = Completer<bool>();
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
    final completer = Completer<bool>();
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
    final completer = Completer<bool>();
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

class _ResultCallbacks implements $ResultCallbacksInterfaceImpl {
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
    implements $DiscoveryHandlerBluetoothImpl {
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
