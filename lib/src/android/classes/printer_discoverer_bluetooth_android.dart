/// import 'dart:async';

/// import 'package:flutter/foundation.dart';
/// import 'package:zebra_link_os/src/android/classes/discovery_handler_bluetooth.dart';
/// import 'package:zebra_link_os/src/core/classes/discovered_printer.dart';

/// import '../../core/classes/printer_discoverer_bluetooth.dart';
/// import 'discovery_handler.dart';

/// /// {@macro PrinterDiscovererBluetooth}
/// class PrinterDiscovererBluetoothAndroid extends PrinterDiscovererBluetooth {
///   StreamController<DiscoveredPrinterBluetooth>? __printerFoundController;
///   StreamController<DiscoveredPrinterBluetooth> get _printerFoundController =>
///       __printerFoundController ??= StreamController<DiscoveredPrinterBluetooth>.broadcast();

///   @override
///   Stream<DiscoveredPrinterBluetooth> get printerFound => _printerFoundController.stream;

///   DiscoveryHandler? _handler;

///   PrinterDiscovererBluetoothAndroid({
///     super.onError,
///     super.onFinished,
///   });

///   @override
///   Future<void> findPrinters() async {
///     _handler ??= DiscoveryHandlerBluetooth(
///       onFoundPrinter: (value) =>
///           __printerFoundController?.sink.add(value as DiscoveredPrinterBluetooth),
///       onDiscoveryFinished: onFinished,
///       onDiscoveryError: (value) => onError?.call(DiscoveredPrinterError(
///         message: value,
///         stackTrace: StackTrace.current,
///       )),
///     );
///   }

///   @mustCallSuper
///   @override
///   Future<void> dispose() async => await __printerFoundController?.close();
/// }
