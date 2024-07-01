/// Base class representing a discovered printer.
sealed class DiscoveredPrinter {
  // The MAC address, IP Address, or local name of printer.
  final String address;

  const DiscoveredPrinter({required this.address});

  @override
  String toString() => "DiscoveredPrinter(address: $address)";
}

/// A discovered printer over Bluetooth.
class DiscoveredPrinterBluetooth extends DiscoveredPrinter {
  /// The friendly name of the Bluetooth device.
  final String friendlyName;

  const DiscoveredPrinterBluetooth({required super.address, required this.friendlyName});

  @override
  String toString() => "DiscoveredPrinterBluetooth(address: $address, friendlyName: $friendlyName)";
}

/// An error which occurs when trying to discover printers.
class DiscoveredPrinterError extends DiscoveredPrinter {
  /// The error object if any.
  ///
  /// This can be an exception or anything else.
  final Object? error;

  /// The error message, if any.
  final String message;

  /// The [StackTrace], if any.
  final StackTrace? stackTrace;

  const DiscoveredPrinterError({
    required this.message,
    this.error,
    this.stackTrace,
  }) : super(address: "");

  @override
  String toString() {
    final effectiveMessage = "An error occurred while trying to discover printers: $message";
    return "$effectiveMessage\n$error\n$stackTrace";
  }
}
