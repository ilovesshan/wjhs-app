import 'package:app/model/system_dict_model.dart';
import 'package:app/utils/cache.dart';
import 'package:common_utils/common_utils.dart';

class SystemDictUtil {
  static bool mobileCanLogin(String code) {
    // 只允骑手/回收中心用户登录  0:平台用户  1:微信用户  2:骑手用户  3:回收中心用户
   final String? authIdentity = getTextByCode(code);
   return authIdentity == "骑手用户" || authIdentity == "回收中心用户";
  }


  static String? getTextByCode(String code) {
    SystemDictModel dictModel = Cache.getSystemDict().firstWhere((systemDictModel) => systemDictModel.dictCode == code);
    return TextUtils.isNotValid("${dictModel.dictDescribe}") ? dictModel.dictDescribe : "未知" ;
  }

  static bool isRecyclingCenterUser() {
    return  Cache.getUserInfo().userType == "3";
  }
}
