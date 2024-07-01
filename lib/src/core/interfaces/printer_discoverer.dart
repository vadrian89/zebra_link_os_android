import 'package:zebra_link_os/core.dart';

/// Interface for classes which can discover printers.
abstract interface class PrinterDiscoverer implements Disposable {
  /// Stream of discovered printers.
  ///
  /// Whenever a printer is discovered it is added to this stream.
  Stream<DiscoveredPrinter> get printerFound;

  /// Start discovering printers.
  ///
  /// When a printer is found it will be added to the [printerFound] stream.
  Future<void> findPrinters();
}
