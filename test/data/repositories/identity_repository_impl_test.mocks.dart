// Mocks generated by Mockito 5.2.0 from annotations
// in polygonid_flutter_sdk/test/data/repositories/identity_repository_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;
import 'dart:typed_data' as _i7;

import 'package:mockito/mockito.dart' as _i1;
import 'package:polygonid_flutter_sdk/data/identity/data_sources/jwz_data_source.dart'
    as _i12;
import 'package:polygonid_flutter_sdk/data/identity/data_sources/lib_identity_data_source.dart'
    as _i8;
import 'package:polygonid_flutter_sdk/data/identity/data_sources/storage_identity_data_source.dart'
    as _i9;
import 'package:polygonid_flutter_sdk/data/identity/data_sources/storage_key_value_data_source.dart'
    as _i11;
import 'package:polygonid_flutter_sdk/data/identity/data_sources/wallet_data_source.dart'
    as _i5;
import 'package:polygonid_flutter_sdk/data/identity/dtos/identity_dto.dart'
    as _i3;
import 'package:polygonid_flutter_sdk/data/identity/mappers/hex_mapper.dart'
    as _i13;
import 'package:polygonid_flutter_sdk/data/identity/mappers/identity_dto_mapper.dart'
    as _i15;
import 'package:polygonid_flutter_sdk/data/identity/mappers/private_key_mapper.dart'
    as _i14;
import 'package:polygonid_flutter_sdk/domain/identity/entities/identity.dart'
    as _i4;
import 'package:polygonid_flutter_sdk/privadoid_wallet.dart' as _i2;
import 'package:sembast/sembast.dart' as _i10;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakePrivadoIdWallet_0 extends _i1.Fake implements _i2.PrivadoIdWallet {}

class _FakeIdentityDTO_1 extends _i1.Fake implements _i3.IdentityDTO {}

class _FakeIdentity_2 extends _i1.Fake implements _i4.Identity {}

/// A class which mocks [WalletDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockWalletDataSource extends _i1.Mock implements _i5.WalletDataSource {
  MockWalletDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.PrivadoIdWallet> createWallet({_i7.Uint8List? privateKey}) =>
      (super.noSuchMethod(
              Invocation.method(#createWallet, [], {#privateKey: privateKey}),
              returnValue:
                  Future<_i2.PrivadoIdWallet>.value(_FakePrivadoIdWallet_0()))
          as _i6.Future<_i2.PrivadoIdWallet>);
  @override
  _i6.Future<String> signMessage(
          {_i7.Uint8List? privateKey, String? message}) =>
      (super.noSuchMethod(
          Invocation.method(
              #signMessage, [], {#privateKey: privateKey, #message: message}),
          returnValue: Future<String>.value('')) as _i6.Future<String>);
}

/// A class which mocks [LibIdentityDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockLibIdentityDataSource extends _i1.Mock
    implements _i8.LibIdentityDataSource {
  MockLibIdentityDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<String> getIdentifier({String? pubX, String? pubY}) =>
      (super.noSuchMethod(
          Invocation.method(#getIdentifier, [], {#pubX: pubX, #pubY: pubY}),
          returnValue: Future<String>.value('')) as _i6.Future<String>);
  @override
  _i6.Future<String> getAuthClaim({String? pubX, String? pubY}) =>
      (super.noSuchMethod(
          Invocation.method(#getAuthClaim, [], {#pubX: pubX, #pubY: pubY}),
          returnValue: Future<String>.value('')) as _i6.Future<String>);
}

/// A class which mocks [StorageIdentityDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockStorageIdentityDataSource extends _i1.Mock
    implements _i9.StorageIdentityDataSource {
  MockStorageIdentityDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i3.IdentityDTO> getIdentity({String? identifier}) =>
      (super.noSuchMethod(
              Invocation.method(#getIdentity, [], {#identifier: identifier}),
              returnValue: Future<_i3.IdentityDTO>.value(_FakeIdentityDTO_1()))
          as _i6.Future<_i3.IdentityDTO>);
  @override
  _i6.Future<void> storeIdentity(
          {String? identifier, _i3.IdentityDTO? identity}) =>
      (super.noSuchMethod(
          Invocation.method(#storeIdentity, [],
              {#identifier: identifier, #identity: identity}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<void> storeIdentityTransact(
          {_i10.DatabaseClient? transaction,
          String? identifier,
          _i3.IdentityDTO? identity}) =>
      (super.noSuchMethod(
          Invocation.method(#storeIdentityTransact, [], {
            #transaction: transaction,
            #identifier: identifier,
            #identity: identity
          }),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<void> removeIdentity({String? identifier}) => (super.noSuchMethod(
      Invocation.method(#removeIdentity, [], {#identifier: identifier}),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<void> removeIdentityTransact(
          {_i10.DatabaseClient? transaction, String? identifier}) =>
      (super.noSuchMethod(
          Invocation.method(#removeIdentityTransact, [],
              {#transaction: transaction, #identifier: identifier}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
}

/// A class which mocks [StorageKeyValueDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockStorageKeyValueDataSource extends _i1.Mock
    implements _i11.StorageKeyValueDataSource {
  MockStorageKeyValueDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<dynamic> get({String? key, _i10.DatabaseClient? database}) =>
      (super.noSuchMethod(
          Invocation.method(#get, [], {#key: key, #database: database}),
          returnValue: Future<dynamic>.value()) as _i6.Future<dynamic>);
  @override
  _i6.Future<void> store(
          {String? key, dynamic value, _i10.DatabaseClient? database}) =>
      (super.noSuchMethod(
          Invocation.method(
              #store, [], {#key: key, #value: value, #database: database}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<String?> remove({String? key, _i10.DatabaseClient? database}) =>
      (super.noSuchMethod(
          Invocation.method(#remove, [], {#key: key, #database: database}),
          returnValue: Future<String?>.value()) as _i6.Future<String?>);
}

/// A class which mocks [JWZDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockJWZDataSource extends _i1.Mock implements _i12.JWZDataSource {
  MockJWZDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<String> getAuthToken(
          {_i7.Uint8List? privateKey,
          String? authClaim,
          String? message,
          String? circuitId,
          _i7.Uint8List? datFile,
          _i7.Uint8List? zKeyFile}) =>
      (super.noSuchMethod(
          Invocation.method(#getAuthToken, [], {
            #privateKey: privateKey,
            #authClaim: authClaim,
            #message: message,
            #circuitId: circuitId,
            #datFile: datFile,
            #zKeyFile: zKeyFile
          }),
          returnValue: Future<String>.value('')) as _i6.Future<String>);
}

/// A class which mocks [HexMapper].
///
/// See the documentation for Mockito's code generation for more information.
class MockHexMapper extends _i1.Mock implements _i13.HexMapper {
  MockHexMapper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String mapFrom(_i7.Uint8List? from) =>
      (super.noSuchMethod(Invocation.method(#mapFrom, [from]), returnValue: '')
          as String);
  @override
  _i7.Uint8List mapTo(String? to) =>
      (super.noSuchMethod(Invocation.method(#mapTo, [to]),
          returnValue: _i7.Uint8List(0)) as _i7.Uint8List);
}

/// A class which mocks [PrivateKeyMapper].
///
/// See the documentation for Mockito's code generation for more information.
class MockPrivateKeyMapper extends _i1.Mock implements _i14.PrivateKeyMapper {
  MockPrivateKeyMapper() {
    _i1.throwOnMissingStub(this);
  }
}

/// A class which mocks [IdentityDTOMapper].
///
/// See the documentation for Mockito's code generation for more information.
class MockIdentityDTOMapper extends _i1.Mock implements _i15.IdentityDTOMapper {
  MockIdentityDTOMapper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Identity mapFrom(_i3.IdentityDTO? from) =>
      (super.noSuchMethod(Invocation.method(#mapFrom, [from]),
          returnValue: _FakeIdentity_2()) as _i4.Identity);
}
