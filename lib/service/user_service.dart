import 'package:app/api/apis.dart';
import 'package:app/model/user_auth_model.dart';
import 'package:app/model/user_info_model.dart';
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

  // 更新用户信息
  static Future<dynamic> updateUserInfo(Map<String, String> data) async {
    final result = await HttpHelper.getInstance().put(Apis.userApi, data:data);
   return Future.value(result);
  }
}
