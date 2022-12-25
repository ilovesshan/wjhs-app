import 'package:app/api/apis.dart';
import 'package:app/model/account_model.dart';
import 'package:app/model/order_model.dart';
import 'package:app/utils/cache.dart';
import 'package:common_utils/common_utils.dart';

class AccountViewModel extends SimpleViewMode<AccountModel> {
  @override
  Future<AccountModel> loadData() async {
    AccountModel _accountModel = AccountModel();
    String? userId = Cache.getUserInfo().id;
    final result = await HttpHelper.getInstance().get("${Apis.balanceAndRecord}/$userId");
    if (result["code"] == 200) {
      _accountModel = AccountModel.fromJson((result["data"]));
    }
    return _accountModel;
  }
}
