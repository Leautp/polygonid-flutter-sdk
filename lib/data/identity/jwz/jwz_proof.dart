import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:polygonid_flutter_sdk/utils/base_64.dart';

part 'jwz_proof.g.dart';

/// Sample
/// ```
///       {
///         "pi_a": [
///             "10412436197494479587396667385707368282568055118269864457927476990636419702451",
///             "10781739095445201996467414817941805879982410676386176845296376344985187663334",
///             "1"
///         ],
///         "pi_b": [
///             [
///                 "18067868740006225615447194471370658980999926369695293115712951366707744064606",
///                 "21599241570547731234304039989166406415899717659171760043899509152011479663757"
///             ],
///             [
///                 "6699540705074924997967275186324755442260607671536434403065529164769702477398",
///                 "11257643293201627450293185164288482420559806649937371568160742601386671659800"
///             ],
///             [
///                 "1",
///                 "0"
///             ]
///         ],
///         "pi_c": [
///             "6216423503289496292944052032190353625422411483383378979029667243785319208095",
///             "14816218045158388758567608605576384994339714390370300963580658386534158603711",
///             "1"
///         ],
///         "protocol": "groth16"
///     }
/// ```
@JsonSerializable()
class JWZBaseProof extends Equatable {
  @JsonKey(name: 'pi_a')
  final List<String> piA;

  @JsonKey(name: 'pi_b')
  final List<List<String>> piB;

  @JsonKey(name: 'pi_c')
  final List<String> piC;

  final String protocol;

  const JWZBaseProof(
      {required this.piA,
      required this.piB,
      required this.piC,
      required this.protocol});

  factory JWZBaseProof.fromJson(Map<String, dynamic> json) =>
      _$JWZBaseProofFromJson(json);

  Map<String, dynamic> toJson() => _$JWZBaseProofToJson(this);

  @override
  List<Object?> get props => [piA, piB, piC, protocol];
}

/// Sample
/// ```
///   {
///     "proof": {
///         "pi_a": [
///             "10412436197494479587396667385707368282568055118269864457927476990636419702451",
///             "10781739095445201996467414817941805879982410676386176845296376344985187663334",
///             "1"
///         ],
///         "pi_b": [
///             [
///                 "18067868740006225615447194471370658980999926369695293115712951366707744064606",
///                 "21599241570547731234304039989166406415899717659171760043899509152011479663757"
///             ],
///             [
///                 "6699540705074924997967275186324755442260607671536434403065529164769702477398",
///                 "11257643293201627450293185164288482420559806649937371568160742601386671659800"
///             ],
///             [
///                 "1",
///                 "0"
///             ]
///         ],
///         "pi_c": [
///             "6216423503289496292944052032190353625422411483383378979029667243785319208095",
///             "14816218045158388758567608605576384994339714390370300963580658386534158603711",
///             "1"
///         ],
///         "protocol": "groth16"
///     },
///     "pub_signals": [
///         "4976943943966365062123221999838013171228156495366270377261380449787871898672",
///         "18656147546666944484453899241916469544090258810192803949522794490493271005313",
///         "379949150130214723420589610911161895495647789006649785264738141299135414272"
///     ]
///   }
/// ```
@JsonSerializable(explicitToJson: true)
class JWZProof extends Equatable with Base64Encoder {
  final JWZBaseProof proof;

  @JsonKey(name: 'pub_signals')
  final List<String> pubSignals;

  JWZProof({required this.proof, required this.pubSignals});

  factory JWZProof.fromBase64(String data) =>
      JWZProof.fromJson(jsonDecode(Base64Util.decode(data)));

  factory JWZProof.fromJson(Map<String, dynamic> json) =>
      _$JWZProofFromJson(json);

  Map<String, dynamic> toJson() => _$JWZProofToJson(this);

  @override
  List<Object?> get props => [proof, pubSignals];
}