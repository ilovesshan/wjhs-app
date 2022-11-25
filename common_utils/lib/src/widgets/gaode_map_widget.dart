import 'package:common_utils/common_utils.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:common_utils/src/config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GaoDeMapWidget extends StatefulWidget {
  ArgumentCallback<CameraPosition> onCameraMoveEnd;
  LatLng latLng;
  GaoDeMapWidget(this.latLng,this.onCameraMoveEnd, {Key? key}) : super(key: key);

  @override
  State<GaoDeMapWidget> createState() => _GaoDeMapWidgetState();
}

class _GaoDeMapWidgetState extends State<GaoDeMapWidget> {

  late AMapController _mapController;

  // 默认经纬度
  late final LatLng _defaultLatLng = widget.latLng;

  // 当前最新的经纬度
  late LatLng _currentLatLng = _defaultLatLng;

  @override
  void initState() {
    super.initState();
    // 监听相机移动的事件
    EventBusUtil.$on("moveCamera", (data) {
      _mapController.moveCamera(CameraUpdate.newLatLng(data));
    });
  }

  @override
  void dispose() {
    super.dispose();
    // 销毁 事件监听事件
    EventBusUtil.$remove("moveCamera");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: Get.width, height: Get.height,
          child: AMapWidget(
            // 隐私政策合规
              privacyStatement: const AMapPrivacyStatement(hasContains: true, hasShow: true, hasAgree: true),

              // key
              apiKey: const AMapApiKey(androidKey: CommonConfig.androidKey, iosKey: CommonConfig.iosKey),

              // 初始化地址
              initialCameraPosition: CameraPosition(target: _currentLatLng, zoom: 15),

              // 当前位置marker
              markers: {
                Marker(
                  infoWindow: const InfoWindow(title: "当前位置", snippet: ""),
                  position: _currentLatLng,icon: BitmapDescriptor.defaultMarkerWithHue(0.0),
                )
              },

              // 地图创建完成回调 成功后会返回AMapController对象
              onMapCreated: (AMapController controller){
                _mapController = controller;
                getApprovalNumber();
                setState(() {});
              },

              // 点击地图回调
              onTap: (LatLng latLng){
                printLog(StackTrace.current, latLng.toString());
                _currentLatLng = latLng;
                setState(() {});
              },

              // 地图移动回调
              onCameraMove:(CameraPosition cameraPosition){
                printLog(StackTrace.current, cameraPosition.toString());
                _currentLatLng = cameraPosition.target;
                setState(() {});
              },

              // 地图移动结束回调
              onCameraMoveEnd:(CameraPosition cameraPosition){
                printLog(StackTrace.current, cameraPosition.toString());
                _currentLatLng = cameraPosition.target;
                setState(() {});

                // 通知外界
                widget.onCameraMoveEnd(cameraPosition);
              }
          ),
        ),

        // 回到当前位置
        Positioned(bottom: 320.h, right: 20.w,
          child: GestureDetector(
            child: Container(
              width: 40.w, height: 40.w, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.r)), padding: EdgeInsets.all(7.w),
              child: Image.asset("assets/common/location_current_address.png", width: 30.w, height: 30.w),
            ),
            onTap: (){
              _mapController.moveCamera(CameraUpdate.newLatLng(_defaultLatLng));
            },
          )
        )
      ],
    );
  }

  /// 获取审图号
  void getApprovalNumber() async {
    //普通地图审图号
    await _mapController.getMapContentApprovalNumber();
    //卫星地图审图号
    await _mapController.getSatelliteImageApprovalNumber();
  }
}
