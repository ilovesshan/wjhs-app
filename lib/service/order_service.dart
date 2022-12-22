import 'package:app/api/apis.dart';
import 'package:app/utils/cache.dart';
import 'package:common_utils/common_utils.dart';

class OrderService {

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
}
