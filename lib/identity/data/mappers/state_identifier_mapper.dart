import 'package:polygonid_flutter_sdk/common/mappers/to_mapper.dart';
import 'package:polygonid_flutter_sdk/common/utils/uint8_list_utils.dart';
import 'package:web3dart/crypto.dart';

class StateIdentifierMapper extends ToMapper<String, String> {
  @override
  String mapTo(String to) {
    final result = BigInt.parse(to).toRadixString(16);
    return result.startsWith('0') ? result : '0$result';
  }
}
