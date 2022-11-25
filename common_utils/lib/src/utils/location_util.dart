import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:common_utils/src/config/config.dart';
import 'package:common_utils/src/service_utils/service_urls.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';

class LocationUtil {

  static  Map<String, Object>? _locationResult;

  static StreamSubscription<Map<String, Object>>? _locationListener;

  static final AMapFlutterLocation _locationPlugin = AMapFlutterLocation();


  /// 初始化
  static void init(OnLocationResultChanged onLocationResultChanged){

    /// [hasShow] 隐私权政策是否弹窗展示告知用户
    AMapFlutterLocation.updatePrivacyShow(true, true);

    /// [hasAgree] 隐私权政策是否已经取得用户同意
    AMapFlutterLocation.updatePrivacyAgree(true);

    /// 动态申请定位权限
    _requestPermission();

    AMapFlutterLocation.setApiKey(CommonConfig.androidKey, CommonConfig.iosKey);

    ///iOS 获取native精度类型
    if (Platform.isIOS) {
      _requestAccuracyAuthorization();
    }

    ///注册定位结果监听
    _locationListener = _locationPlugin.onLocationChanged().listen((Map<String, Object> result) {
      if(result.length > 3 && TextUtils.isNotValid(result["latitude"].toString()) && TextUtils.isNotValid(result["longitude"].toString())){
        _locationResult = result;
        _stopLocation();
        double latitude = double.parse(result["latitude"].toString());
        double longitude = double.parse(result["longitude"].toString());
        getAddressByLongitudeAndLatitude(latitude,longitude, (addressData) async {
          onLocationResultChanged(LatLng(latitude,longitude),addressData);
        });
      }
    });
    /// 开始定位
    _startLocation();
  }


  ///设置定位参数
  static void _setLocationOption() {
    AMapLocationOption locationOption =  AMapLocationOption();

    ///是否单次定位
    locationOption.onceLocation = false;

    ///是否需要返回逆地理信息
    locationOption.needAddress = true;

    ///逆地理信息的语言类型
    locationOption.geoLanguage = GeoLanguage.DEFAULT;

    locationOption.desiredLocationAccuracyAuthorizationMode = AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;

    locationOption.fullAccuracyPurposeKey = "AMapLocationScene";

    ///设置Android端连续定位的定位间隔
    locationOption.locationInterval = 2000;

    ///设置Android端的定位模式<br>
    ///可选值：<br>
    ///<li>[AMapLocationMode.Battery_Saving]</li>
    ///<li>[AMapLocationMode.Device_Sensors]</li>
    ///<li>[AMapLocationMode.Hight_Accuracy]</li>
    locationOption.locationMode = AMapLocationMode.Hight_Accuracy;

    ///设置iOS端的定位最小更新距离<br>
    locationOption.distanceFilter = -1;

    ///设置iOS端期望的定位精度
    /// 可选值：<br>
    /// <li>[DesiredAccuracy.Best] 最高精度</li>
    /// <li>[DesiredAccuracy.BestForNavigation] 适用于导航场景的高精度 </li>
    /// <li>[DesiredAccuracy.NearestTenMeters] 10米 </li>
    /// <li>[DesiredAccuracy.Kilometer] 1000米</li>
    /// <li>[DesiredAccuracy.ThreeKilometers] 3000米</li>
    locationOption.desiredAccuracy = DesiredAccuracy.Best;

    ///设置iOS端是否允许系统暂停定位
    locationOption.pausesLocationUpdatesAutomatically = false;

    ///将定位参数设置给定位插件
    _locationPlugin.setLocationOption(locationOption);
  }

  ///开始定位
  static void _startLocation() {
    ///开始定位之前设置定位参数
    _setLocationOption();
    _locationPlugin.startLocation();
  }

  ///停止定位
  static void _stopLocation() {
    _locationPlugin.stopLocation();
  }

  ///获取iOS native的accuracyAuthorization类型
  static void _requestAccuracyAuthorization() async {
    AMapAccuracyAuthorization currentAccuracyAuthorization = await _locationPlugin.getSystemAccuracyAuthorization();
    if (currentAccuracyAuthorization == AMapAccuracyAuthorization.AMapAccuracyAuthorizationFullAccuracy) {
      print("精确定位类型");
    } else if (currentAccuracyAuthorization == AMapAccuracyAuthorization.AMapAccuracyAuthorizationReducedAccuracy) {
      print("模糊定位类型");
    } else {
      print("未知定位类型");
    }
  }

  /// 动态申请定位权限
  static void _requestPermission() async {
    // 申请权限
    bool hasLocationPermission = await _requestLocationPermission();
    if (hasLocationPermission) {
      print("定位权限申请通过");
    } else {
      print("定位权限申请不通过");
    }
  }

  /// 申请定位权限
  /// 授予定位权限返回true， 否则返回false
  static  Future<bool> _requestLocationPermission() async {
    //获取当前的权限
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申请
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  ///移除定位监听
  ///销毁定位
  static void dispose() {
    ///移除定位监听
    if (null != _locationListener) {
      _locationListener?.cancel();
    }

    ///销毁定位
    _locationPlugin.destroy();
  }

  /// 根据经纬度获取当前地址信息
  static void getAddressByLongitudeAndLatitude(double latitude, double longitude, OnResultChanged onResultChanged) async {
    final requestPath = CommonServiceUrls.getAddressByLongitudeAndLatitude + "?output=json&location=$longitude,$latitude&key=${CommonConfig.webKey}&radius=1000&extensions=all";
    try {
        final result = await HttpHelper.getInstance().get(requestPath);
        if(result!=null && TextUtils.isNotValid(result.data.toString()) && result.data["status"].toString() == "1"){
          onResultChanged(result.data);
        }
        // printLog(StackTrace.current, result);
        // result.data["regeocode"]["formatted_address"];
    } catch (e) {
      printLog(StackTrace.current, e.toString());
    }
  }
}
