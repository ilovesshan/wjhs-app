import 'package:app/api/apis.dart';
import 'package:app/model/feedback_record_view_model.dart';
import 'package:app/utils/cache.dart';
import 'package:common_utils/common_utils.dart';

class FeedbackRecordViewModel extends SimpleViewMode<List<FeedbackRecordModel>> {
  String type = "";
  String status = "";
  @override
  Future<List<FeedbackRecordModel>> loadData() async {
    List<FeedbackRecordModel> _list = [];
    final result = await HttpHelper.getInstance().get("${Apis.feedback}/${Cache.getUserInfo().id}",);
    if (result["code"] == 200) {
      for(var json in result["data"]){
        _list.add(FeedbackRecordModel.fromJson(json));
      }
    }
    return _list;
  }
}
