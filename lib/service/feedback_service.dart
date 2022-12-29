import 'package:app/api/apis.dart';
import 'package:common_utils/common_utils.dart';

class FeedbackService {

  // 用户授权
  static Future<bool> feedback(Map<String, String> data) async {
    bool _isSuccess = false;
    final result = await HttpHelper.getInstance().post(Apis.feedback, data:data);
    if(result["code"] == 200){
      _isSuccess = true;
    }
    return _isSuccess;
  }
}
