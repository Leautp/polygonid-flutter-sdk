import 'dart:ffi' as ffi;
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/common/domain/domain_logger.dart';

import 'native_polygonidcore.dart';

@injectable
class PolygonIdCore {
  static NativePolygonIdCoreLib? _nativePolygonIdCoreLib;

  static NativePolygonIdCoreLib get nativePolygonIdCoreLib {
    final instance = _nativePolygonIdCoreLib;
    if (instance != null) {
      return instance;
    }

    _nativePolygonIdCoreLib = Platform.isAndroid
        ? NativePolygonIdCoreLib(ffi.DynamicLibrary.open("libpolygonid.so"))
        : NativePolygonIdCoreLib(ffi.DynamicLibrary.process());

    return _nativePolygonIdCoreLib!;
  }

  PolygonIdCore();

  String? consumeStatus(
      ffi.Pointer<ffi.Pointer<PLGNStatus>> status, String msg) {
    if (status == ffi.nullptr || status.value == ffi.nullptr) {
      if (kDebugMode) {
        logger().e("unable to allocate status\n");
      }
      return "unable to allocate status";
    }
    String? result;

    if (status.value.ref.status >= 0) {
      if (msg.isEmpty) {
        msg = "status is not OK with code ${status.value.ref.status}";
      }

      if (status.value.ref.error_msg == ffi.nullptr) {
        if (kDebugMode) {
          logger().e("$msg: ${status.value.ref.status.toString()}");
        }
      } else {
        ffi.Pointer<ffi.Char> json = status.value.ref.error_msg;
        ffi.Pointer<Utf8> jsonString = json.cast<Utf8>();
        try {
          String errormsg = jsonString.toDartString();
          msg = "$msg: $errormsg";
          if (kDebugMode) {
            logger().e(
                "$msg: ${status.value.ref.status.toString()}. Error: $errormsg");
          }
        } catch (e) {
          if (kDebugMode) {
            logger().e("$msg: ${status.value.ref.status.toString()}");
          }
        }
      }
      result = msg;
    }
    nativePolygonIdCoreLib.PLGNFreeStatus(status.value);
    return result;
  }
}
