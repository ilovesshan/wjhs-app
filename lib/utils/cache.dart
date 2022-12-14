import 'dart:convert';

import 'package:app/model/system_dict_model.dart';
import 'package:app/model/user_info_model.dart';
import 'package:common_utils/common_utils.dart';

class Cache {
  static const String _userInfo = "_userInfo";
  static const String _systemDict = "_systemDict";

  ///保存用户信息
  static void saveUserInfo(UserInfoModel value) {
    SharedPreferencesUtil.sharedPreferences.setString(_userInfo, jsonEncode(value).toString());
  }

  /// 获取用户信息
  static UserInfoModel getUserInfo() {
    UserInfoModel userInfoMode = UserInfoModel();
    try {
      String? _userMode = SharedPreferencesUtil.sharedPreferences.getString(_userInfo);
      if (_userMode != null) {
        userInfoMode = UserInfoModel.fromJson(jsonDecode(_userMode));
      }
    } catch (e) {
      printLog(StackTrace.current,e);
    }
    return userInfoMode;
  }

  /// 删除用户信息
  static Future<bool> removeUserInfo() async {
    bool isSuccess = false;
    try {
      isSuccess =
      await SharedPreferencesUtil.sharedPreferences.remove(_userInfo);
    } catch (e) {
      printLog(StackTrace.current,e);
    }
    return isSuccess;
  }





  ///保存系统字典信息
  static void saveSystemDict(List<SystemDictModel> value) {
    SharedPreferencesUtil.sharedPreferences.setString(_systemDict, jsonEncode(value).toString());
  }

  /// 获取系统字典信息
  static List<SystemDictModel> getSystemDict() {
    List<SystemDictModel> systemDictModels =[];
    try {
      String? _systemDictModelList = SharedPreferencesUtil.sharedPreferences.getString(_systemDict);
      if (_systemDictModelList != null) {
        for (var json in jsonDecode(_systemDictModelList)){
          systemDictModels.add(SystemDictModel.fromJson(json));
        }
      }
    } catch (e) {
      printLog(StackTrace.current,e);
    }
    return systemDictModels;
  }

  /// 删除系统字典信息
  static Future<bool> removeSystemDict() async {
    bool isSuccess = false;
    try {
      isSuccess =
      await SharedPreferencesUtil.sharedPreferences.remove(_systemDict);
    } catch (e) {
      printLog(StackTrace.current,e);
    }
    return isSuccess;
  }
}