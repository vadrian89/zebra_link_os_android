import 'package:jni/jni.dart';

/// Contains utilities for working with the JNI.
class JniUtils {
  /// Get the Android application context.
  static JObject get context =>
      JObject.fromReference(Jni.getCachedApplicationContext());

  /// Get the Android current activity.
  static JObject get activity =>
      JObject.fromReference(Jni.getCurrentActivity());
}
