
import 'dart:io';

import 'package:common_utils/common_utils.dart';

class MapNavigationUtil {
  /// 百度地图
  static Future<bool> gotoBaiduMap(longitude, latitude) async {
    var url = 'baidumap://map/direction?destination=$latitude,$longitude&coord_type=bd09ll&mode=driving';
    bool canLaunchUrl = await canLaunch(url);
    if (!canLaunchUrl) {
      EasyLoading.showToast("未检测到百度地图");
      return false;
    }
    await launch(url);
    return canLaunchUrl;
  }


  /// 腾讯地图
  static Future<bool> gotoTencentMap(longitude, latitude) async {
    var url = 'qqmap://map/routeplan?type=drive&fromcoord=CurrentLocation&tocoord=$latitude,$longitude&referer=IXHBZ-QIZE4-ZQ6UP-DJYEO-HC2K2-EZBXJ';
    bool canLaunchUrl = await canLaunch(url);
    if (!canLaunchUrl) {
      EasyLoading.showToast("未检测到腾讯地图");
      return false;
    }
    await launch(url);
    return canLaunchUrl;
  }


  /// 高德地图
  static Future<bool> gotoGaoDeMap(longitude, latitude) async {
    var url = '${Platform.isAndroid ? 'android' : 'ios'}amap://navi?sourceApplication=amap&lat=$latitude&lon=$longitude&dev=0&style=2';
    bool canLaunchUrl = await canLaunch(url);
    if (!canLaunchUrl) {
      EasyLoading.showToast("未检测到高德地图");
      return false;
    }
    await launch(url);
    return true;
  }
}