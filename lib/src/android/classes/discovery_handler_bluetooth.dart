/// import 'package:zebra_link_os/core.dart';

/// import '../zebra_link_os_generated_android.dart' as g;
/// import 'discovery_handler.dart';

/// /// Class which is used by discoverer classes to handle the discovery process.
/// ///
/// /// This when calling the find printers method, the discoverer class is going to use this class to
/// /// handle the discovery process.
/// ///
/// /// Use [asHandler] to get be able to pass [DiscoveryHandler] where is required.
/// class DiscoveryHandlerBluetooth extends DiscoveryHandler {
///   const DiscoveryHandlerBluetooth({
///     super.onDiscoveryFinished,
///     super.onDiscoveryError,
///     super.onFoundPrinter,
///   });

///   @override
///   void foundPrinter(g.DiscoveredPrinter discoveredPrinter) {
///     final javaPrinter =
///         g.DiscoveredPrinterBluetooth.fromReference(discoveredPrinter.reference);
///     onFoundPrinter?.call(DiscoveredPrinterBluetooth(
///       address: javaPrinter.address.toDartString(),
///       friendlyName: javaPrinter.friendlyName.toDartString(),
///     ));
///   }
/// }
