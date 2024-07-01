import 'package:flutter/foundation.dart';
import 'package:zebra_link_os/core.dart';

/// Base class used to handle for the discovery process.
///
/// It provides callbacks necessary for the discovery process.
abstract class DiscoveryHandlerBase {
  /// Called when the discovery process is finished.
  ///
  /// Is called by [discoveryFinished].
  final VoidCallback? onDiscoveryFinished;

  /// Called when an error occurs during the discovery process.
  final ValueChanged<String>? onDiscoveryError;

  /// Called when a printer is found.
  final ValueChanged<DiscoveredPrinter>? onFoundPrinter;

  const DiscoveryHandlerBase({
    this.onDiscoveryFinished,
    this.onDiscoveryError,
    this.onFoundPrinter,
  });
}
