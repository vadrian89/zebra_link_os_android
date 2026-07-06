import 'package:jni/jni.dart';

/// Contains utilities for working with the JNI.
class JniUtils {
  static JniUtils? _instance;

  const JniUtils._();

  factory JniUtils() => _instance ??= const JniUtils._();

  /// Get the Android application context.
  JObject get context => JObject.fromReference(Jni.getCachedApplicationContext());
}
