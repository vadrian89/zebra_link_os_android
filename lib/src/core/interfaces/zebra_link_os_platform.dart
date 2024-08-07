import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../classes/discovered_printer.dart';
import 'printer_discoverer.dart';

/// Base class for the Zebra Link-OS plugin.
abstract class ZebraLinkOsPlatform extends PlatformInterface implements PrinterDiscoverer {
  ZebraLinkOsPlatform() : super(token: _token);

  static final Object _token = Object();

  static ZebraLinkOsPlatform _instance = _ZebraLinkOsDefault();

  static ZebraLinkOsPlatform get instance => _instance;

  static set instance(ZebraLinkOsPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Check if the device is enabled and has the necessary permissions to use the bluetooth device.
  ///
  /// It will request permissions for bluetooth scanning, connecting and device location.
  /// Aswell it will try to check if the bluetooth/location modules are enabled.
  ///
  /// Returns [true] if the device is enabled and has the necessary permissions, otherwise [false].
  Future<bool> requestPermissions();

  void write({required String string, required DiscoveredPrinter printer});

  void printImage({
    required DiscoveredPrinter printer,
    required String filePath,
    int width = 0,
    int height = 0,
    int x = 0,
    int y = 0,
  });
}

/// Default implementation of the ZebraLinkOsPlatform.
class _ZebraLinkOsDefault extends ZebraLinkOsPlatform {
  @override
  Future<bool> requestPermissions() => throw UnimplementedError();

  @override
  Future<void> findPrinters() => throw UnimplementedError();

  @override
  Future<void> dispose() => throw UnimplementedError();

  @override
  Stream<DiscoveredPrinter> get printerFound => throw UnimplementedError();

  @override
  void write({required String string, required DiscoveredPrinter printer}) =>
      throw UnimplementedError();

  @override
  void printImage({
    required DiscoveredPrinter printer,
    required String filePath,
    int width = 0,
    int height = 0,
    int x = 0,
    int y = 0,
  }) =>
      throw UnimplementedError();
}
