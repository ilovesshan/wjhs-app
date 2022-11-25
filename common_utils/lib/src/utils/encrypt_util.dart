import 'package:common_utils/common_utils.dart';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';

class EncryptUtil{

  /// RAS 加密工具
  static Future<String> encodeString(String content) async {
    final RSAAsymmetricKey rsaAsymmetricKey = RSAKeyParser().parse(HttpHelperConfig.publicKey);
    final encrypter = Encrypter(RSA(publicKey: rsaAsymmetricKey as RSAPublicKey));
    return await encrypter.encrypt(content).base64;
  }
}