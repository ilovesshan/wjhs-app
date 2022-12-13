import 'package:app/api/apis.dart';
import 'package:app/model/recycle_goods_model.dart';
import 'package:common_utils/common_utils.dart';

class RecycleGoodsService {
  // 获取回收商品列表
  static Future<List<RecycleGoodsModel>> requestRecycleGoods() async {
    List<RecycleGoodsModel> recycleGoodsModels = [];
    final result = await HttpHelper.getInstance().get(Apis.recycleGoods +"/all");
    if (result["code"] == 200) {
      for (var json in result["data"]) {
        recycleGoodsModels.add(RecycleGoodsModel.fromJson(json));
      }
    }
    return recycleGoodsModels;
  }
}
