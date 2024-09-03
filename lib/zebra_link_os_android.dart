import 'package:flutter/foundation.dart';
import 'package:zebra_link_os_android/src/android/zebra_link_os_android.dart';
import 'package:zebra_link_os_platform_core/classes.dart';
import 'package:zebra_link_os_platform_core/interfaces.dart';
import 'package:zebra_link_os_platform_core/zebra_link_os_plugin.dart';

export 'core.dart';

class ZebraLinkOs implements ZebraLinkOsPluginInterface {
  ZebraLinkOsPluginBase get _instance => ZebraLinkOsPluginBase.instance;

  /// Called when an error occurs while trying to discover printers.
  final ValueChanged<String>? onError;

  /// Called when the SDK reports that it has finished discovering printers.
  final VoidCallback? onFinished;

  ZebraLinkOs({this.onError, this.onFinished}) {
    final instance = ZebraLinkOsPluginBase.instance;
    if (instance is ZebraLinkOsAndroid) {
      instance.onError = onError;
      instance.onFinished = onFinished;
    }
  }

  /// Register this dart class as the platform implementation
  static void registerWith() => ZebraLinkOsPluginBase.instance = ZebraLinkOsAndroid();

  @override
  Stream<DiscoveredPrinter> get printerFound => _instance.printerFound;

  @override
  Future<void> startDiscovery() => _instance.startDiscovery();

  @override
  Future<void> dispose() => _instance.dispose();

  @override
  Future<bool> connect({required String address}) => _instance.connect(address: address);

  @override
  Future<bool> disconnect() => _instance.disconnect();

  @override
  Future<bool> write({required String data}) => _instance.write(data: data);

  @override
  Future<bool> printImageFile({
    required String filePath,
    int width = 0,
    int height = 0,
    int x = 0,
    int y = 0,
    bool insideFormat = false,
  }) =>
      _instance.printImageFile(
        filePath: filePath,
        width: width,
        height: height,
        x: x,
        y: y,
        insideFormat: insideFormat,
      );
}
