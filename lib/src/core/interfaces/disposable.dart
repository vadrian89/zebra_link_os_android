/// Interface for objects that can be disposed.
abstract interface class Disposable {
  /// Dispose resources used by the implementing class.
  Future<void> dispose();
}
