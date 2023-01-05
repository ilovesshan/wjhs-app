import 'dart:convert';

import 'package:app/api/apis.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter_xupdate/update_entity.dart';

class AppCheckUpdateService {
  // 检查App是否有更新
  static Future<UpdateEntity> check(String versionName) async {
    UpdateEntity updateEntity = UpdateEntity(
      hasUpdate: false,
      isForce: false,
      isIgnorable: false,
      versionCode: 0,
      versionName: "",
      updateContent: "",
      downloadUrl: "",
      apkSize: 0,
      apkMd5: "",
    );

    final result = await HttpHelper.getInstance().get(Apis.newApk, params: {"versionName": versionName});
    if (result["code"] == 200) {
      updateEntity = UpdateEntity.fromJson(json.encode(result["data"]))!;
    }
    return updateEntity;
  }
}
