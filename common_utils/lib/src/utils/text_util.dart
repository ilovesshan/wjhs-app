class TextUtils {
  /// 判断数据是否是无效的数据
  static bool isValid(String text) {
    text = text.trim();
    return (text.isEmpty || text == null || text == "null");
  }

  /// 判断数据是否不是无效的数据
  static bool isNotValid(String text) {
    return !isValid(text);
  }

  /// 判断数据是否是无效的数据 如果无效 则给予一个默认值返回
  static String isValidWith(String text, String defaultValue) {
    text = text.trim();
    return ( text.isEmpty || text == null || text == "null") ? defaultValue : text ;
  }
}
