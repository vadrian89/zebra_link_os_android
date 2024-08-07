import 'package:flutter/foundation.dart';
import 'package:zebra_link_os_android/src/android/zebra_link_os_android.dart';

import 'core.dart';

class ZebraLinkOs {
  ZebraLinkOsPlatform get _instance => ZebraLinkOsPlatform.instance;

  /// Called when an error occurs while trying to discover printers.
  final ValueChanged<DiscoveredPrinterError>? onError;

  /// Called when the SDK reports that it has finished discovering printers.
  final VoidCallback? onFinished;

  ZebraLinkOs({this.onError, this.onFinished}) {
    final instance = ZebraLinkOsPlatform.instance;
    if (instance is ZebraLinkOsAndroid) {
      instance.onError = onError;
      instance.onFinished = onFinished;
    }
  }

  /// Register this dart class as the platform implementation
  static void registerWith() {
    ZebraLinkOsPlatform.instance = ZebraLinkOsAndroid();
  }

  Future<bool> requestPermissions() => _instance.requestPermissions();

  Future<void> findPrinters() => _instance.findPrinters();

  Future<void> dispose() => _instance.dispose();

  Stream<DiscoveredPrinter> get printerFound => _instance.printerFound;

  void write({required String string, required DiscoveredPrinter printer}) =>
      _instance.write(string: string, printer: printer);

  void printImage({
    required DiscoveredPrinter printer,
    required String filePath,
    int width = 0,
    int height = 0,
    int x = 0,
    int y = 0,
    bool insideFormat = false,
  }) =>
      _instance.printImage(
        printer: printer,
        filePath: filePath,
        width: width,
        height: height,
        x: x,
        y: y,
        insideFormat: insideFormat,
      );
}
