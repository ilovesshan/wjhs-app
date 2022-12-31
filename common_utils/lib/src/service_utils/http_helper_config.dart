class HttpHelperConfig {
  static int selectIndex = 0;
  static List<String> serviceList = ["http://192.168.1.107"];

  static void checkSelectedIndex(int index) {
    selectIndex = index;
  }

  static const String defaultMethod = "GET";

  /// 请求超时时间
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;

  /// 公钥
  static String publicKey = "-----BEGIN PUBLIC KEY-----\n" +
      "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCXhZdxMwd3C6h0HJKFM9G3wWrJnQaAd29RYevgUhcqjjwnCsMeZ4YB0V762Q2NUP/IulTnbj0NPY4ZCV+dCp6zATAlJfY/2JxSE2jUO8OyvJBjP1IpzTYJg7zL+T+YNlUVqk0oyd1HSLM9K6YKMhq4mjK8UZFJejxbCfKN8OtZSwIDAQAB" +
      "\n-----END PUBLIC KEY-----";

  /// 需要 application/x-www-form-urlencoded 格式的请求URL
  static List<String> needXWwwFormUrlencodedTypeList = [];

  /// 需要特殊处理 uaa格式的请求
  static List<String> needAddUuaPrefixList = [];

  /// 过滤掉 不需要token的接口
  static List<String> notNeedTokenList = [];
}
