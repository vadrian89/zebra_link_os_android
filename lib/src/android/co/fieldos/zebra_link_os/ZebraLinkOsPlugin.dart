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

import "DiscoveryHandlerBluetooth.dart" as discoveryhandlerbluetooth_;

import "ResultCallbacksInterface.dart" as resultcallbacksinterface_;

/// from: co.fieldos.zebra_link_os.ZebraLinkOsPlugin
class ZebraLinkOsPlugin extends jni.JObject {
  @override
  late final jni.JObjType<ZebraLinkOsPlugin> $type = type;

  ZebraLinkOsPlugin.fromReference(
    jni.JReference reference,
  ) : super.fromReference(reference);

  static final _class =
      jni.JClass.forName(r"co/fieldos/zebra_link_os/ZebraLinkOsPlugin");

  /// The type which includes information such as the signature of this class.
  static const type = $ZebraLinkOsPluginType();
  static final _id_new0 = _class.constructorId(
    r"(Landroid/content/Context;Lco/fieldos/zebra_link_os/DiscoveryHandlerBluetooth;)V",
  );

  static final _new0 = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JniResult Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>("globalEnv_NewObject")
      .asFunction<
          jni.JniResult Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>, ffi.Pointer<ffi.Void>)>();

  /// from: public void <init>(android.content.Context context, co.fieldos.zebra_link_os.DiscoveryHandlerBluetooth discoveryHandlerBluetooth)
  /// The returned object must be released after use, by calling the [release] method.
  factory ZebraLinkOsPlugin(
    jni.JObject context,
    discoveryhandlerbluetooth_.DiscoveryHandlerBluetooth
        discoveryHandlerBluetooth,
  ) {
    return ZebraLinkOsPlugin.fromReference(_new0(
            _class.reference.pointer,
            _id_new0 as jni.JMethodIDPtr,
            context.reference.pointer,
            discoveryHandlerBluetooth.reference.pointer)
        .reference);
  }

  static final _id_disconnect = _class.instanceMethodId(
    r"disconnect",
    r"(Lco/fieldos/zebra_link_os/ResultCallbacksInterface;)V",
  );

  static final _disconnect = ProtectedJniExtensions.lookup<
              ffi.NativeFunction<
                  jni.JThrowablePtr Function(
                      ffi.Pointer<ffi.Void>,
                      jni.JMethodIDPtr,
                      ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>)>>(
          "globalEnv_CallVoidMethod")
      .asFunction<
          jni.JThrowablePtr Function(ffi.Pointer<ffi.Void>, jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>)>();

  /// from: public final void disconnect(co.fieldos.zebra_link_os.ResultCallbacksInterface resultCallbacksInterface)
  void disconnect(
    resultcallbacksinterface_.ResultCallbacksInterface resultCallbacksInterface,
  ) {
    _disconnect(reference.pointer, _id_disconnect as jni.JMethodIDPtr,
            resultCallbacksInterface.reference.pointer)
        .check();
  }

  static final _id_findPrinters = _class.instanceMethodId(
    r"findPrinters",
    r"()V",
  );

  static final _findPrinters = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                ffi.Pointer<ffi.Void>,
                jni.JMethodIDPtr,
              )>>("globalEnv_CallVoidMethod")
      .asFunction<
          jni.JThrowablePtr Function(
            ffi.Pointer<ffi.Void>,
            jni.JMethodIDPtr,
          )>();

  /// from: public final void findPrinters()
  void findPrinters() {
    _findPrinters(reference.pointer, _id_findPrinters as jni.JMethodIDPtr)
        .check();
  }

  static final _id_printImage = _class.instanceMethodId(
    r"printImage",
    r"(Ljava/lang/String;Ljava/lang/String;IIIIILco/fieldos/zebra_link_os/ResultCallbacksInterface;)V",
  );

  static final _printImage = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        ffi.Int32,
                        ffi.Int32,
                        ffi.Int32,
                        ffi.Int32,
                        ffi.Int32,
                        ffi.Pointer<ffi.Void>
                      )>)>>("globalEnv_CallVoidMethod")
      .asFunction<
          jni.JThrowablePtr Function(
              ffi.Pointer<ffi.Void>,
              jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              int,
              int,
              int,
              int,
              int,
              ffi.Pointer<ffi.Void>)>();

  /// from: public final void printImage(java.lang.String string, java.lang.String string1, int i, int i1, int i2, int i3, int i4, co.fieldos.zebra_link_os.ResultCallbacksInterface resultCallbacksInterface)
  void printImage(
    jni.JString string,
    jni.JString string1,
    int i,
    int i1,
    int i2,
    int i3,
    int i4,
    resultcallbacksinterface_.ResultCallbacksInterface resultCallbacksInterface,
  ) {
    _printImage(
            reference.pointer,
            _id_printImage as jni.JMethodIDPtr,
            string.reference.pointer,
            string1.reference.pointer,
            i,
            i1,
            i2,
            i3,
            i4,
            resultCallbacksInterface.reference.pointer)
        .check();
  }

  static final _id_writeString = _class.instanceMethodId(
    r"writeString",
    r"(Ljava/lang/String;Ljava/lang/String;Lco/fieldos/zebra_link_os/ResultCallbacksInterface;)V",
  );

  static final _writeString = ProtectedJniExtensions.lookup<
          ffi.NativeFunction<
              jni.JThrowablePtr Function(
                  ffi.Pointer<ffi.Void>,
                  jni.JMethodIDPtr,
                  ffi.VarArgs<
                      (
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>,
                        ffi.Pointer<ffi.Void>
                      )>)>>("globalEnv_CallVoidMethod")
      .asFunction<
          jni.JThrowablePtr Function(
              ffi.Pointer<ffi.Void>,
              jni.JMethodIDPtr,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>,
              ffi.Pointer<ffi.Void>)>();

  /// from: public final void writeString(java.lang.String string, java.lang.String string1, co.fieldos.zebra_link_os.ResultCallbacksInterface resultCallbacksInterface)
  void writeString(
    jni.JString string,
    jni.JString string1,
    resultcallbacksinterface_.ResultCallbacksInterface resultCallbacksInterface,
  ) {
    _writeString(
            reference.pointer,
            _id_writeString as jni.JMethodIDPtr,
            string.reference.pointer,
            string1.reference.pointer,
            resultCallbacksInterface.reference.pointer)
        .check();
  }
}

final class $ZebraLinkOsPluginType extends jni.JObjType<ZebraLinkOsPlugin> {
  const $ZebraLinkOsPluginType();

  @override
  String get signature => r"Lco/fieldos/zebra_link_os/ZebraLinkOsPlugin;";

  @override
  ZebraLinkOsPlugin fromReference(jni.JReference reference) =>
      ZebraLinkOsPlugin.fromReference(reference);

  @override
  jni.JObjType get superType => const jni.JObjectType();

  @override
  final superCount = 1;

  @override
  int get hashCode => ($ZebraLinkOsPluginType).hashCode;

  @override
  bool operator ==(Object other) {
    return other.runtimeType == ($ZebraLinkOsPluginType) &&
        other is $ZebraLinkOsPluginType;
  }
}
