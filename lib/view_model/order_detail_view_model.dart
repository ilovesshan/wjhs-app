import 'package:app/api/apis.dart';
import 'package:app/model/order_model.dart';
import 'package:common_utils/common_utils.dart';

class OrderDetailViewModel extends SimpleViewMode<OrderModel> {
  String orderId = "";
  @override
  Future<OrderModel> loadData() async {
    OrderModel _orderModel = OrderModel();
    final result = await HttpHelper.getInstance().get("${Apis.recycleGoodsOrder}/$orderId");
    if (result["code"] == 200) {
      _orderModel = OrderModel.fromJson((result["data"]));
    }
    return _orderModel;
  }
}
