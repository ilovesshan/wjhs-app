import 'package:app/api/apis.dart';
import 'package:app/model/notice_model.dart';
import 'package:common_utils/common_utils.dart';

class NoticeService {
  // 获取公告
  static Future<List<NoticeModel>> requestNotice() async {
    List<NoticeModel> noticeModels = [];
    final result = await HttpHelper.getInstance().get(Apis.notice+"?type=32");
    if (result["code"] == 200) {
      for (var json in result["data"]) {
        noticeModels.add(NoticeModel.fromJson(json));
      }
    }
    return noticeModels;
  }
}
