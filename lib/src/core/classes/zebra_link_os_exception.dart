/// Base exception for all exceptions thrown by the ZebraLinkOS package.
///
/// This exception is thrown when an error occurs in the ZebraLinkOS package.
sealed class ZebraLinkOsException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const ZebraLinkOsException({required this.message, this.stackTrace});

  const ZebraLinkOsException.unknown({this.stackTrace}) : message = "An unknown error occurred";

  @override
  String toString() => "ZebraLinkOsException: $message\n$stackTrace";
}

class ZebraPrintImageException extends ZebraLinkOsException {
  const ZebraPrintImageException({required super.message, super.stackTrace});

  const ZebraPrintImageException.unknown({super.stackTrace}) : super.unknown();
}

class ZebraWriteException extends ZebraLinkOsException {
  const ZebraWriteException({required super.message, super.stackTrace});

  const ZebraWriteException.unknown({super.stackTrace}) : super.unknown();
}
