import 'dart:typed_data';

import 'package:common_utils/common_utils.dart';
import 'package:common_utils/src/utils/time_util.dart';

class FileSaverUtil {

  static Future<void> saveImage(String imageUrl, {bool isAsset = false, String fileName = ""}) async {
    EasyLoading.show(status: "下载中....");
    try {
      var response = await Dio().get(imageUrl, options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data), quality: 60, name: TextUtils.isValidWith(fileName, TimeUtil.currentTimeMillis().toString()));
      printLog(StackTrace.current,result);
      EasyLoading.showToast("下载成功");
    }catch (e){
      EasyLoading.showToast("下载失败");
    }finally{
      EasyLoading.dismiss();
    }
  }
}