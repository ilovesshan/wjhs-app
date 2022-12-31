import 'package:app/api/apis.dart';
import 'package:app/model/recycles_statistical_model.dart';
import 'package:common_utils/common_utils.dart';

class RecyclesStatisticalService {

  // 获取我的贡献
  static Future<RecyclesStatisticalModel> requestContribution() async {
    RecyclesStatisticalModel recyclesStatisticalModel = RecyclesStatisticalModel();
    final result = await HttpHelper.getInstance().get("${ Apis.recyclesStatistical}?orderType=11&userType=2");
    if (result["code"] == 200) {
        recyclesStatisticalModel = RecyclesStatisticalModel.fromJson(result["data"]);
    }
    return recyclesStatisticalModel;
  }

  // 获取回收统计
  static Future<RecyclesStatisticalModel> requestStatistics(String orderType, String userType) async {
    RecyclesStatisticalModel recyclesStatisticalModel = RecyclesStatisticalModel();
    final result = await HttpHelper.getInstance().get("${ Apis.recyclesStatistical}?orderType=$orderType&userType=$userType");
    if (result["code"] == 200) {
      recyclesStatisticalModel = RecyclesStatisticalModel.fromJson(result["data"]);
    }
    return recyclesStatisticalModel;
  }
}
