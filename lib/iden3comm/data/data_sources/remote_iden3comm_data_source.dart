import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:polygonid_flutter_sdk/common/utils/http_exceptions_handler_mixin.dart';

import '../../../common/data/exceptions/network_exceptions.dart';
import '../../../common/domain/domain_logger.dart';
import '../../../credential/data/dtos/claim_dto.dart';
import '../../domain/exceptions/iden3comm_exceptions.dart';
import '../dtos/response/fetch/fetch_claim_response_dto.dart';

class RemoteIden3commDataSource with HttpExceptionsHandlerMixin {
  final Client client;

  RemoteIden3commDataSource(this.client);

  Future<Response> authWithToken({
    required String token,
    required String url,
  }) async {
    return Future.value(Uri.parse(url))
        .then((uri) => client.post(
              uri,
              body: token,
              headers: {
                HttpHeaders.acceptHeader: '*/*',
                HttpHeaders.contentTypeHeader: 'text/plain',
              },
            ))
        .then((response) {
      if (response.statusCode != 200) {
        logger().d(
            'Auth Error: code: ${response.statusCode} msg: ${response.body}');
        throwExceptionOnStatusCode(response.statusCode, response.body);
      }
      return response;
    });
  }

  Future<ClaimDTO> fetchClaim(
      {required String authToken, required String url, required String did}) {
    return Future.value(Uri.parse(url))
        .then((uri) => client.post(
              uri,
              body: authToken,
              headers: {
                HttpHeaders.acceptHeader: '*/*',
                HttpHeaders.contentTypeHeader: 'text/plain',
              },
            ))
        .then((response) async {
      if (response.statusCode == 200) {
        FetchClaimResponseDTO fetchResponse =
            FetchClaimResponseDTO.fromJson(json.decode(response.body));

        if (fetchResponse.type == FetchClaimResponseType.issuance) {
          return ClaimDTO(
              id: fetchResponse.credential.id,
              issuer: fetchResponse.from,
              did: did,
              type: fetchResponse.credential.credentialSubject.type,
              expiration: fetchResponse.credential.expirationDate,
              // TODO expiration??
              info: fetchResponse.credential);
        } else {
          throw UnsupportedFetchClaimTypeException(response);
        }
      } else {
        logger().d(
            'fetchClaim Error: code: ${response.statusCode} msg: ${response.body}');
        throw NetworkException(response);
      }
    });
  }
}
