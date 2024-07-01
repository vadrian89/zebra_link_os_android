import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:zebra_link_os_android/core.dart';

/// {@template PrinterDiscovererBluetooth}
/// Class used to discover Bluetooth printers.
///
/// This class should be extended by platform specific implementations.
/// {@endtemplate}
abstract class PrinterDiscovererBluetooth implements PrinterDiscoverer {
  /// Called when an error occurs while trying to discover printers.
  final ValueChanged<DiscoveredPrinterError>? onError;

  /// Called when the SDK reports that it has finished discovering printers.
  final VoidCallback? onFinished;

  PrinterDiscovererBluetooth({this.onError, this.onFinished});

  @override
  Future<void> findPrinters();
}
