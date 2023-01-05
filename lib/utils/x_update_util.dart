import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:flutter_xupdate/flutter_xupdate.dart';

class XupdateUtil {
  // static const String _baseUrl =  "https://7242ff89.r2.cpolar.cn/";
  static final String _baseUrl = HttpHelperConfig.serviceList[HttpHelperConfig.selectIndex];

  /// 初始化
  static void initXUpdate() {
    if (Platform.isAndroid) {
      FlutterXUpdate.init(
        ///是否输出日志
        debug: true,

        ///是否使用post请求
        isPost: false,

        ///post请求是否是上传json
        isPostJson: false,

        ///请求响应超时时间
        timeout: 25000,

        ///是否开启自动模式
        isWifiOnly: false,

        ///是否开启自动模式
        isAutoMode: false,

        ///需要设置的公共参数
        supportSilentInstall: false,

        ///在下载过程中，如果点击了取消的话，是否弹出切换下载方式的重试提示弹窗
        enableRetry: false
      ).then((value) {
        printLog(StackTrace.current, "Xupdate初始化成功: $value");
      }).catchError((error) {
        printLog(StackTrace.current, "Xupdate初始化失败: $error");
      });

      FlutterXUpdate.setErrorHandler(onUpdateError: (Map<String, dynamic>? message) async {
        printLog(StackTrace.current, "Xupdate初始化失败: $message");
      });
    } else {
      printLog(StackTrace.current, "ios暂不支持XUpdate更新");
    }
  }

  /// json解析
  static UpdateEntity customParseJson(UpdateEntity updateEntity) {
    return UpdateEntity(
        isForce: updateEntity.isForce,
        isIgnorable: updateEntity.isIgnorable,
        hasUpdate: updateEntity.hasUpdate,
        versionCode: updateEntity.versionCode,
        versionName: updateEntity.versionName,
        updateContent: updateEntity.updateContent,
        downloadUrl: _baseUrl + "${updateEntity.downloadUrl}",
        apkSize: updateEntity.apkSize
    );
  }
}
