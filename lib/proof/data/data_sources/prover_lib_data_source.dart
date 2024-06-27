import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/proof/data/dtos/prove_param.dart';
import 'package:flutter_rapidsnark/flutter_rapidsnark.dart';

const _methodChannel = MethodChannel('polygonid_flutter_sdk');

@injectable
class ProverLibWrapper {
  Future<Map<String, dynamic>?> prover(
    String zKeyPath,
    Uint8List wtnsBytes,
  ) {
    final rootIsolateToken = RootIsolateToken.instance!;

    return compute(
      _computeProve,
      ProveParam(zKeyPath, wtnsBytes, rootIsolateToken),
    );
  }
}

///
Future<Map<String, dynamic>?> _computeProve(ProveParam param) async {
  BackgroundIsolateBinaryMessenger.ensureInitialized(param.rootIsolateToken);

  final result = await Rapidsnark().groth16ProveWithZKeyFilePath(
    zkeyPath: param.zKeyPath,
    witness: param.wtns,
  );

  return {
    "proof": jsonDecode(result.proof),
    "pub_signals": jsonDecode(result.publicSignals),
  };
}

class ProverLibDataSource {
  final ProverLibWrapper _proverLibWrapper;

  ProverLibDataSource(this._proverLibWrapper);

  ///
  Future<Map<String, dynamic>?> prove(
    String zKeyPath,
    Uint8List wtnsBytes,
  ) async {
    return _proverLibWrapper.prover(zKeyPath, wtnsBytes);
  }
}
