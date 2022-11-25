import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

/// App权限工具类
class PermissionUtils {
  /// 获取全部权限
  static Future requestAllPermission() async {
    Map<Permission, PermissionStatus> permission = await [
      Permission.camera,
      Permission.photos,
      Permission.speech,
      Permission.storage,
      Permission.location,
      Permission.phone,
      Permission.notification,
    ].request();

    if (await Permission.camera.isGranted) {
      debugPrint("相机权限申请通过");
    } else {
      debugPrint("相机权限申请失败");
    }

    if (await Permission.photos.isGranted) {
      debugPrint("照片权限申请通过");
    } else {
      debugPrint("照片权限申请失败");
    }

    if (await Permission.speech.isGranted) {
      debugPrint("语音权限申请通过");
    } else {
      debugPrint("语音权限申请失败");
    }

    if (await Permission.storage.isGranted) {
      debugPrint("文件权限申请通过");
    } else {
      debugPrint("文件权限申请失败");
    }

    if (await Permission.location.isGranted) {
      debugPrint("定位权限申请通过");
    } else {
      debugPrint("定位权限申请失败");
    }

    if (await Permission.phone.isGranted) {
      debugPrint("手机权限申请通过");
    } else {
      debugPrint("手机权限申请失败");
    }

    if (await Permission.notification.isGranted) {
      debugPrint("通知权限申请通过");
    } else {
      debugPrint("通知权限申请失败");
    }
  }


  /// 相机权限
  static Future requestCameraPermission() async {
    Map<Permission, PermissionStatus> permission = await [
      Permission.camera,
    ].request();

    if ((Permission.camera.isDenied != null) ||
        (Permission.camera.isPermanentlyDenied != null)) {
      // 第一次申请被拒绝 / 第二次申请被拒绝
      unauthorizedToast("相机");
    } else if (Permission.camera.isGranted != null) {
      debugPrint('同意了访问权限。');
    }
  }


  /// 照片/存储权限
  static Future requestPhotosPermission() async {
    Map<Permission, PermissionStatus> permission = await [
      Permission.photos,
    ].request();

    if ((Permission.camera.isDenied != null) ||
        (Permission.camera.isPermanentlyDenied != null)) {
      // 第一次申请被拒绝 / 第二次申请被拒绝
      unauthorizedToast("照片/存储");
    } else {
      debugPrint("照片权限申请失败");
    }
  }


  ///  麦克风/语音权限
  static Future requestSpeechPermission() async {
    Map<Permission, PermissionStatus> permission = await [
      Permission.speech,
    ].request();

    if ((Permission.camera.isDenied != null) ||
        (Permission.camera.isPermanentlyDenied != null)) {
      // 第一次申请被拒绝 / 第二次申请被拒绝
      unauthorizedToast("麦克风/语音");
    } else {
      debugPrint("麦克风/语音权限申请失败");
    }
  }


  /// 存储/文件权限
  static Future requestStoragePermission() async {
    Map<Permission, PermissionStatus> permission = await [
      Permission.storage,
    ].request();

    if ((Permission.camera.isDenied != null) ||
        (Permission.camera.isPermanentlyDenied != null)) {
      // 第一次申请被拒绝 / 第二次申请被拒绝
      unauthorizedToast("存储/文件");
    } else {
      debugPrint("存储/文件权限申请失败");
    }
  }


  /// 定位/位置信息权限
  static Future requestLocationPermission() async {
    Map<Permission, PermissionStatus> permission = await [
      Permission.location,
    ].request();

    if ((Permission.camera.isDenied != null) ||
        (Permission.camera.isPermanentlyDenied != null)) {
      // 第一次申请被拒绝 / 第二次申请被拒绝
      unauthorizedToast("定位/位置信息");
    } else {
      debugPrint("定位/位置信息权限申请失败");
    }
  }


  /// 手机权限
  static Future requestPhonePermission() async {
    Map<Permission, PermissionStatus> permission = await [
      Permission.phone,
    ].request();

    if ((Permission.camera.isDenied != null) ||
        (Permission.camera.isPermanentlyDenied != null)) {
      // 第一次申请被拒绝 / 第二次申请被拒绝
      unauthorizedToast("手机");
    } else {
      debugPrint("手机权限申请失败");
    }
  }


  /// 通知权限
  static Future requestNotificationPermission() async {
    Map<Permission, PermissionStatus> permission = await [
      Permission.notification,
    ].request();

    if ((Permission.camera.isDenied != null) ||
        (Permission.camera.isPermanentlyDenied != null)) {
      // 第一次申请被拒绝 / 第二次申请被拒绝
      unauthorizedToast("通知");
    } else {
      debugPrint("通知权限申请失败");
    }
  }


  ///IOS用的跟踪透明度权限申请
  static Future appTrackingTransparency() async {
    await Permission.appTrackingTransparency.request();
    if (await Permission.appTrackingTransparency.isGranted) {
      debugPrint("追踪透明度权限已获得");
    } else if (await Permission.appTrackingTransparency.isDenied) {
      await Permission.appTrackingTransparency.request();
    } else if (await Permission.appTrackingTransparency.isPermanentlyDenied) {
      await unauthorizedToast("允许跟踪");
    } else {
      debugPrint("追踪透明度权限申请失败");
    }
  }


  ///  第一次申请被拒绝或者第二次申请被拒绝 提示信息
  static unauthorizedToast(String text) async {
    EasyLoading.showToast("请在设置中为App开启$text权限");
  }
}
