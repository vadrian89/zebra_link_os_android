/// Base exception for all exceptions thrown by the ZebraLinkOS package.
///
/// This exception is thrown when an error occurs in the ZebraLinkOS package.
class ZebraLinkOsException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const ZebraLinkOsException({required this.message, this.stackTrace});

  const ZebraLinkOsException.unknown({this.stackTrace}) : message = "An unknown error occurred";

  const ZebraLinkOsException.general({required this.message, this.stackTrace});

  const factory ZebraLinkOsException.write({required String message, StackTrace? stackTrace}) =
      _ZebraWriteException;

  const factory ZebraLinkOsException.printImage({required String message, StackTrace? stackTrace}) =
      _ZebraPrintImageException;

  @override
  String toString() => "ZebraLinkOsException: $message\n$stackTrace";
}

class _ZebraPrintImageException extends ZebraLinkOsException {
  const _ZebraPrintImageException({required super.message, super.stackTrace});
}

class _ZebraWriteException extends ZebraLinkOsException {
  const _ZebraWriteException({required super.message, super.stackTrace});
}
