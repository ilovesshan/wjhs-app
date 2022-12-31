import 'package:app/api/apis.dart';
import 'package:app/utils/cache.dart';
import 'package:common_utils/common_utils.dart';

class RecycleOrderService {

  // 更新订单状态
  static Future<bool> updateOrderState(String orderId, String status) async {
    bool _isSuccess = false;
    final result = await HttpHelper.getInstance().put(
      Apis.recycleGoodsOrder,
      data: {
        "id": orderId,
        "status": status,
        "receiveUserId": Cache.getUserInfo().id,
      }
    );
    if(result["code"] == 200){
      _isSuccess = true;
    }
    return _isSuccess;
  }


  // 订单支付
  static Future<bool> orderPay(String orderId) async {
    bool _isSuccess = false;
    final result = await HttpHelper.getInstance().post("${Apis.recycleGoodsPay}/$orderId");
    if(result["code"] == 200){
      _isSuccess = true;
    }
    return _isSuccess;
  }

  // 更新订单状态
  static Future<bool> sendRecycleGoodsOrderToRecycleCenter(String orderId, String receiveUserId) async {
    bool _isSuccess = false;
    final result = await HttpHelper.getInstance().put("${Apis.recycleGoodsOrder}/$orderId?receiveUserId=$receiveUserId" );
    if(result["code"] == 200){
      _isSuccess = true;
    }
    return _isSuccess;
  }
}
