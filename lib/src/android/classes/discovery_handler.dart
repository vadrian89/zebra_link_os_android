/// import 'package:jni/jni.dart';

/// import '../../core/classes/discovery_handler_base.dart';
/// import '../zebra_link_os_generated_android.dart' as g;

/// /// Class which is used by discoverer classes to handle the discovery process.
/// ///
/// /// This when calling the find printers method, the discoverer class is going to use this class to
/// /// handle the discover
/// /// y process.
/// ///
/// /// Use [asHandler] to get be able to pass [DiscoveryHandler] where is required.
/// abstract class DiscoveryHandler extends DiscoveryHandlerBase
///     implements g.$DiscoveryHandlerImpl {
///   /// Return [this] as a [DiscoveryHandler].
///   g.DiscoveryHandler get asHandler => g.DiscoveryHandler.implement(this);

///   const DiscoveryHandler({
///     super.onDiscoveryFinished,
///     super.onDiscoveryError,
///     super.onFoundPrinter,
///   });

///   @override
///   void discoveryError(JString string) => onDiscoveryError?.call(
///         string.toDartString(releaseOriginal: true),
///       );

///   @override
///   void discoveryFinished() => onDiscoveryFinished?.call();

///   @override
///   void foundPrinter(g.DiscoveredPrinter discoveredPrinter);
/// }
