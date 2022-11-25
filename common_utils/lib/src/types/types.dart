import 'package:amap_flutter_base/amap_flutter_base.dart';


typedef OnResult = void Function (int result);

typedef OnItemPressed = void Function (String id);

typedef OnPressed = void Function();

typedef OnValueChanged = void Function(String value);

typedef OnLocationResultChanged = void Function(LatLng latLng, dynamic result);

typedef OnResultChanged = void Function(dynamic result);


/// 网络请求成功
typedef OnSuccess = void Function(dynamic data);

/// 网络请求失败
typedef OnError = void Function(int errorCode, String errorMessage);

/// 网络请求执行完毕
typedef OnCompleted = void Function();


/// EventBus Callback
typedef EventBusCallback = void Function(dynamic data);