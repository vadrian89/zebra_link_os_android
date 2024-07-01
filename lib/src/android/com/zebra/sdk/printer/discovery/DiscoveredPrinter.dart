// Copyright 2024 Adrian Verban

// Autogenerated by jnigen. DO NOT EDIT!

// ignore_for_file: annotate_overrides
// ignore_for_file: camel_case_extensions
// ignore_for_file: camel_case_types
// ignore_for_file: constant_identifier_names
// ignore_for_file: doc_directive_unknown
// ignore_for_file: file_names
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: no_leading_underscores_for_local_identifiers
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: overridden_fields
// ignore_for_file: unnecessary_cast
// ignore_for_file: unused_element
// ignore_for_file: unused_field
// ignore_for_file: unused_import
// ignore_for_file: unused_local_variable
// ignore_for_file: unused_shown_name
// ignore_for_file: use_super_parameters

import "dart:isolate" show ReceivePort;
import "dart:ffi" as ffi;
import "package:jni/internal_helpers_for_jnigen.dart";
import "package:jni/jni.dart" as jni;

/// from: com.zebra.sdk.printer.discovery.DiscoveredPrinter
class DiscoveredPrinter extends jni.JObject {
  @override
  late final jni.JObjType<DiscoveredPrinter> $type = type;

  DiscoveredPrinter.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni.JClass.forName(r"com/zebra/sdk/printer/discovery/DiscoveredPrinter");

  /// The type which includes information such as the signature of this class.
  static const type = $DiscoveredPrinterType();
  static final _id_address = _class.instanceFieldId(
    r"address",
    r"Ljava/lang/String;",
  );

  /// from: public final java.lang.String address
  /// The returned object must be released after use, by calling the [release] method.
  jni.JString get address => _id_address.get(this, const jni.JStringType());

  static final _id_discoSettings = _class.instanceFieldId(
    r"discoSettings",
    r"Ljava/util/Map;",
  );

  /// from: protected java.util.Map discoSettings
  /// The returned object must be released after use, by calling the [release] method.
  jni.JMap<jni.JString, jni.JString> get discoSettings => _id_discoSettings.get(
      this, const jni.JMapType(jni.JStringType(), jni.JStringType()));

  /// from: protected java.util.Map discoSettings
  /// The returned object must be released after use, by calling the [release] method.
  set discoSettings(jni.JMap<jni.JString, jni.JString> value) =>
      _id_discoSettings.set(this,
          const jni.JMapType(jni.JStringType(), jni.JStringType()), value);

  static final _id_getConnection = _class.instanceMethodId(
    r"getConnection",
    r"()Lcom/zebra/sdk/comm/Connection;",
  );

  static final _getConnection = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>("globalEnv_CallObjectMethod")
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: public abstract com.zebra.sdk.comm.Connection getConnection()
  /// The returned object must be released after use, by calling the [release] method.
  jni.JObject getConnection() {
    return _getConnection(
            reference.pointer, _id_getConnection as jni.JMethodIDPtr)
        .object(const jni.JObjectType());
  }

  static final _id_new0 = _class.constructorId(
    r"(Ljava/lang/String;)V",
  );

  static final _new0 = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          "globalEnv_NewObject")
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: public void <init>(java.lang.String string)
  /// The returned object must be released after use, by calling the [release] method.
  factory DiscoveredPrinter(
    jni.JString string,
  ) {
    return DiscoveredPrinter.fromReference(_new0(_class.reference.pointer,
            _id_new0 as jni.JMethodIDPtr, string.reference.pointer)
        .reference);
  }

  static final _id_toString1 = _class.instanceMethodId(
    r"toString",
    r"()Ljava/lang/String;",
  );

  static final _toString1 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>("globalEnv_CallObjectMethod")
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: public java.lang.String toString()
  /// The returned object must be released after use, by calling the [release] method.
  jni.JString toString1() {
    return _toString1(reference.pointer, _id_toString1 as jni.JMethodIDPtr)
        .object(const jni.JStringType());
  }

  static final _id_getDiscoveryDataMap = _class.instanceMethodId(
    r"getDiscoveryDataMap",
    r"()Ljava/util/Map;",
  );

  static final _getDiscoveryDataMap = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>("globalEnv_CallObjectMethod")
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: public java.util.Map getDiscoveryDataMap()
  /// The returned object must be released after use, by calling the [release] method.
  jni.JMap<jni.JString, jni.JString> getDiscoveryDataMap() {
    return _getDiscoveryDataMap(
            reference.pointer, _id_getDiscoveryDataMap as jni.JMethodIDPtr)
        .object(const jni.JMapType(jni.JStringType(), jni.JStringType()));
  }

  static final _id_equals = _class.instanceMethodId(
    r"equals",
    r"(Ljava/lang/Object;)Z",
  );

  static final _equals = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JniResult Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          "globalEnv_CallBooleanMethod")
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: public boolean equals(java.lang.Object object)
  bool equals(
    jni.JObject object,
  ) {
    return _equals(reference.pointer, _id_equals as jni.JMethodIDPtr,
            object.reference.pointer)
        .boolean;
  }

  static final _id_hashCode1 = _class.instanceMethodId(
    r"hashCode",
    r"()I",
  );

  static final _hashCode1 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>("globalEnv_CallIntMethod")
      .asFunction<
          jni.JniResult Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: public int hashCode()
  int hashCode1() {
    return _hashCode1(reference.pointer, _id_hashCode1 as jni.JMethodIDPtr)
        .integer;
  }
}

final class $DiscoveredPrinterType extends jni.JObjType<DiscoveredPrinter> {
  const $DiscoveredPrinterType();

  @override
  String get signature =>
      r"Lcom/zebra/sdk/printer/discovery/DiscoveredPrinter;";

  @override
  DiscoveredPrinter fromReference(jni.JReference reference) =>
      DiscoveredPrinter.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($DiscoveredPrinterType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($DiscoveredPrinterType) &&
        other is $DiscoveredPrinterType;
  }
}
