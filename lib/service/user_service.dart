import 'package:app/api/apis.dart';
import 'package:app/model/user_auth_model.dart';
import 'package:app/model/user_info_model.dart';
import 'package:app/router/router.dart';
import 'package:app/utils/cache.dart';
import 'package:common_utils/common_utils.dart';

class UserService {
  // 获取用户信息
  static Future<UserInfoModel> requestUserInfo(String userId) async {
    UserInfoModel userInfoModel = UserInfoModel();
    final result = await HttpHelper.getInstance().get("${Apis.userApi}/$userId");
    if(result["code"] == 200){
      userInfoModel =  UserInfoModel.fromJson(result["data"]);
    }
    return userInfoModel;
  }

  // 获取用户信息
  static Future<List<UserInfoModel>> requestUserListByType() async {
    List<UserInfoModel> _list = [];
    final result = await HttpHelper.getInstance().get("${Apis.userApi}/?type=3");
    if(result["code"] == 200){
      for(var json in result["data"]){
        _list.add(UserInfoModel.fromJson(json));
      }
    }
    return _list;
  }

  // 更新用户信息
  static Future<dynamic> updateUserInfo(Map<String, String> data) async {
    final result = await HttpHelper.getInstance().put(Apis.userApi, data:data);
   return Future.value(result);
  }

  // 修改密码
  static Future<dynamic> updatePassword(Map<String, String> data) async {
    final result = await HttpHelper.getInstance().put(Apis.userPassword, data:data);
    return Future.value(result);
  }

  // 用户退出登录
  static void logout(){
    Cache.removeUserInfo();
    CommonCache.removeId();
    CommonCache.removeUsername();
    CommonCache.removePassword();
    CommonCache.removeToken();
    Get.offAndToNamed(YFRouter.login);
  }
}
