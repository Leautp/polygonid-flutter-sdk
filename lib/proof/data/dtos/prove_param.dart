import 'dart:typed_data';

import 'package:flutter/services.dart';

class ProveParam {
  final String zKeyPath;
  final Uint8List wtns;
  final RootIsolateToken rootIsolateToken;

  ProveParam(
    this.zKeyPath,
    this.wtns,
    this.rootIsolateToken,
  );
}
