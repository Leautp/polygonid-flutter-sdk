import 'package:injectable/injectable.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/jwz_proof_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/request/auth/auth_iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/exceptions/iden3comm_exceptions.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/authenticate_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/fetch_and_save_claims_use_case.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/use_cases/get_iden3message_use_case.dart';

import '../common/domain/entities/filter_entity.dart';
import '../credential/domain/entities/claim_entity.dart';
import '../iden3comm/domain/entities/request/offer/offer_iden3_message_entity.dart';
import '../iden3comm/domain/use_cases/get_filters_use_case.dart';
import '../iden3comm/domain/use_cases/get_iden3comm_claims_use_case.dart';
import '../iden3comm/domain/use_cases/get_iden3comm_proofs_use_case.dart';

abstract class PolygonIdSdkIden3comm {
  /// Returns a [Iden3MessageEntity] from a message string
  Future<Iden3MessageEntity> getIden3Message({required String message});

  /// Returns a list of [FilterEntity] from a message string to
  /// apply to [Credential.getClaims]
  Future<List<FilterEntity>> getFilters({required Iden3MessageEntity message});

  /// Fetch a list of [ClaimEntity] from iden3Message and store them
  Future<List<ClaimEntity>> fetchAndSaveClaims(
      {required Iden3MessageEntity message,
      required String did,
      int? profileNonce,
      required String privateKey});

  /// Get a list of [ClaimEntity] from iden3Message
  Future<List<ClaimEntity>> getClaims({
    required Iden3MessageEntity message,
    required String did,
    int? profileNonce,
    required String privateKey,
  });

  /// Get a list of [JWZProofEntity] from iden3Message
  Future<List<JWZProofEntity>> getProofs({
    required Iden3MessageEntity message,
    required String did,
    int? profileNonce,
    required String privateKey,
  });

  /// Authenticate response from iden3Message sharing the needed
  /// (if any) proofs requested by it
  Future<void> authenticate(
      {required Iden3MessageEntity message,
      required String did,
      int? profileNonce,
      required String privateKey,
      String? pushToken});
}

@injectable
class Iden3comm implements PolygonIdSdkIden3comm {
  final FetchAndSaveClaimsUseCase _fetchAndSaveClaimsUseCase;
  final GetIden3MessageUseCase _getIden3MessageUseCase;
  final AuthenticateUseCase _authenticateUseCase;
  final GetFiltersUseCase _getFiltersUseCase;
  final GetIden3commClaimsUseCase _getIden3commClaimsUseCase;
  final GetIden3commProofsUseCase _getIden3commProofsUseCase;

  Iden3comm(
    this._fetchAndSaveClaimsUseCase,
    this._getIden3MessageUseCase,
    this._authenticateUseCase,
    this._getFiltersUseCase,
    this._getIden3commClaimsUseCase,
    this._getIden3commProofsUseCase,
  );

  @override
  Future<Iden3MessageEntity> getIden3Message({required String message}) {
    return _getIden3MessageUseCase.execute(param: message);
  }

  /// Returns a list of [FilterEntity] from a message string to
  /// apply to [Credential.getClaims]
  @override
  Future<List<FilterEntity>> getFilters({required Iden3MessageEntity message}) {
    return _getFiltersUseCase.execute(
        param: GetFiltersParam(
      message: message,
    ));
  }

  /// Fetch a list of [ClaimEntity] from iden3Message and store them
  @override
  Future<List<ClaimEntity>> fetchAndSaveClaims(
      {required Iden3MessageEntity message,
      required String did,
      int? profileNonce,
      required String privateKey}) {
    if (message is! OfferIden3MessageEntity) {
      throw InvalidIden3MsgTypeException(
          Iden3MessageType.offer, message.messageType);
    }
    return _fetchAndSaveClaimsUseCase.execute(
        param: FetchAndSaveClaimsParam(
            message: message,
            did: did,
            profileNonce: profileNonce ?? 0,
            privateKey: privateKey));
  }

  /// Get a list of [ClaimEntity] from iden3Message
  @override
  Future<List<ClaimEntity>> getClaims(
      {required Iden3MessageEntity message,
      required String did,
      int? profileNonce,
      required String privateKey}) {
    return _getIden3commClaimsUseCase.execute(
        param: GetIden3commClaimsParam(
      message: message,
      did: did,
      profileNonce: profileNonce ?? 0,
      privateKey: privateKey,
    ));
  }

  /// Get a list of [JWZProofEntity] from iden3Message
  @override
  Future<List<JWZProofEntity>> getProofs(
      {required Iden3MessageEntity message,
      required String did,
      int? profileNonce,
      required String privateKey,
      String? challenge}) {
    return _getIden3commProofsUseCase.execute(
        param: GetIden3commProofsParam(
      message: message,
      did: did,
      profileNonce: profileNonce ?? 0,
      privateKey: privateKey,
      challenge: challenge,
    ));
  }

  /// Authenticate response from iden3Message sharing the needed
  /// (if any) proofs requested by it
  @override
  Future<void> authenticate(
      {required Iden3MessageEntity message,
      required String did,
      int? profileNonce,
      required String privateKey,
      String? pushToken}) {
    if (message is! AuthIden3MessageEntity) {
      throw InvalidIden3MsgTypeException(
          Iden3MessageType.auth, message.messageType);
    }

    return _authenticateUseCase.execute(
        param: AuthenticateParam(
      message: message,
      did: did,
      profileNonce: profileNonce ?? 0,
      privateKey: privateKey,
      pushToken: pushToken,
    ));
  }
}
