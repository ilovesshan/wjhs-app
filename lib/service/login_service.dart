import 'package:app/api/apis.dart';
import 'package:app/model/user_auth_model.dart';
import 'package:app/model/user_info_model.dart';
import 'package:common_utils/common_utils.dart';

class LoginService {

  // 用户授权
  static Future<UserAuthModel> requestUserAuth(String username, String password) async {
    UserAuthModel userAuthModel = UserAuthModel();
    final result = await HttpHelper.getInstance().post(Apis.userAuth, data:{"username":username, "password": password});
    if(result["code"] == 200){
      userAuthModel = UserAuthModel.fromJson(result["data"]);
    }
    return userAuthModel;
  }
}
