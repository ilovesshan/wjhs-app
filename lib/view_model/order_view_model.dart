import 'package:app/api/apis.dart';
import 'package:app/model/order_model.dart';
import 'package:common_utils/common_utils.dart';

class OrderViewModel extends SimpleViewMode<List<OrderModel>> {
  String type = "";
  String status = "";

  // 是否是回收中心用户
  bool isReceiveCenter = false;

  @override
  Future<List<OrderModel>> loadData() async {
    List<OrderModel> _list = [];
    final result = await HttpHelper.getInstance().get(isReceiveCenter ? Apis.recycleCenterRecycleGoodsOrder : Apis.driverRecycleGoodsOrder, params: { "type": type, "status": status });
    if (result["code"] == 200) {
      for(var json in result["data"]){
        _list.add(OrderModel.fromJson(json));
      }
    }
    return _list;
  }
}
