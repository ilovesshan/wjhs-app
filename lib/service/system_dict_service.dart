import 'package:app/api/apis.dart';
import 'package:app/model/system_dict_model.dart';
import 'package:common_utils/common_utils.dart';

class SystemDictService {

  // 获取数据字典
  static Future<List<SystemDictModel>> requestSystemDict() async {
    List<SystemDictModel> systemDictModels = [];
    final result = await HttpHelper.getInstance().get(Apis.systemDict);
    if(result["code"] == 200){
      for(var json in result["data"]){
        systemDictModels.add(SystemDictModel.fromJson(json));
      }
    }
    return systemDictModels;
  }
}
