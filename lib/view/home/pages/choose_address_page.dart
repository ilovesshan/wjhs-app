import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:common_utils/common_utils.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';

class ChooseAddressPage extends StatefulWidget {
  const ChooseAddressPage({Key? key}) : super(key: key);

  @override
  State<ChooseAddressPage> createState() => _ChooseAddressPageState();
}

class _ChooseAddressPageState extends State<ChooseAddressPage> {

  late LatLng _latLng;

  List<GaodePoisModel> _posiList = [];

  @override
  void initState() {
    super.initState();
    if(Get.arguments != null && TextUtils.isNotValid(Get.arguments["latLng"].toString())){
      _latLng = Get.arguments["latLng"];
      setState(() {});
    }
    _getPoisByLongitudeAndLatitude(LatLng(_latLng.latitude, _latLng.longitude));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar.showWidthPrimaryTheme("地址选择"),
      body: Stack(
        children: [
          // 地图
          GaoDeMapWidget(_latLng, (CameraPosition cameraPosition){
             _getPoisByLongitudeAndLatitude(cameraPosition.target);
          }),

          // 搜索框
          Positioned(
            top: 20.h, right: 10.w, left: 10.w,
            child: Container(
              width: Get.width, height: 30.h, padding: EdgeInsets.symmetric(horizontal: 5.w),
              decoration: BoxDecoration(color: const Color(0xFFFFFFFF), borderRadius: BorderRadius.circular(5.r)),
              child: Row(
                children: [
                  Image.asset("assets/common/search.png", width: 20.w, height: 20.w),
                  SizedBox(width: 10.w),
                  Expanded(child: TypeAheadField<Map<String, dynamic>>(
                    loadingBuilder: (BuildContext context) => ViewLoader.loadingWidget(),
                    textFieldConfiguration: TextFieldConfiguration(
                      autofocus: false,
                      decoration: const InputDecoration(border: InputBorder.none),
                      style: TextStyle(fontSize: 14.sp),
                      textAlignVertical: TextAlignVertical.center,
                    ),
                    suggestionsCallback: (pattern) async {
                      if(TextUtils.isValid(pattern)){
                        return [];
                      }
                      List<Map<String, dynamic>> _poisList = [];
                      final String requestPath = CommonServiceUrls.getPosiByKeyword +"?keywords=$pattern&offset=20&page=1&key=${CommonConfig.webKey}&extensions=all";
                      try {
                        final result = await HttpHelper.getInstance().get(requestPath);
                        if(result!=null && TextUtils.isNotValid(result.data.toString()) && result.data["status"].toString() == "1"){
                          if(result.data["pois"] != null && result.data["pois"].length > 0){
                            for(var json in result.data["pois"]){
                              _poisList.add(json);
                            }
                          }
                        }
                        return _poisList;
                      } catch (e) {
                        printLog(StackTrace.current, e.toString());
                        return [];
                      }
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text("${suggestion["name"]}"),
                        subtitle:  Text("${suggestion["address"]}"),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      LatLng latLng = locationStr2LatLng(suggestion["location"].toString());
                      EventBusUtil.$emit("moveCamera", latLng);
                    },
                  ))
                ],
              ),
            ),
          ),

          // posi 地址信息列表
          Positioned(
            bottom: 0, right: 0, left: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(20.r), right:Radius.circular(20.r)),
              child: Container(
                width: Get.width, height: 290.h, color: const Color(0xFFFFFFFF),
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(_posiList.length, (index){
                      return ListTile(
                        title: Tooltip(message: "${_posiList[index].name}", child: Text("${_posiList[index].name}", overflow: TextOverflow.ellipsis)),
                        subtitle: Tooltip(message: "${_posiList[index].address}", child: Text("${_posiList[index].address}", overflow: TextOverflow.ellipsis)),
                        onTap: (){
                          LatLng latLng = locationStr2LatLng(_posiList[index].location.toString());
                          EventBusUtil.$emit("moveCamera", latLng);
                        },
                      );
                    }),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// 将经纬度字符串转换成LatLng类型
  LatLng locationStr2LatLng(String location) {
     final List<String> locations = location.split(",");
      double longitude= double.parse(locations[0]);
      double latitude = double.parse(locations[1]);
      LatLng latLng = LatLng(latitude,longitude);
      return latLng;
  }

  ///  根据经纬度获取Pois信息
  void _getPoisByLongitudeAndLatitude(LatLng latLng) {
    LocationUtil.getAddressByLongitudeAndLatitude(latLng.latitude, latLng.longitude, (result) {
      if(result["regeocode"]["pois"]!=null && TextUtils.isNotValid(result["regeocode"]["pois"].toString())){
        _posiList.clear();
         for(var json in result["regeocode"]["pois"]){
           _posiList.add(GaodePoisModel.fromJson(json));
         }
      }
      setState(() {});
    });
  }
}
