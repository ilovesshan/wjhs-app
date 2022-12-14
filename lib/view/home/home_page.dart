import 'package:app/model/notice_model.dart';
import 'package:app/model/swiper_model.dart';
import 'package:app/router/router.dart';
import 'package:app/service/notice_service.dart';
import 'package:app/service/swiper_service.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  final List<String> _bannerList = ["assets/images/banner/banner_01.png"];

  final List<String> _marqueeTextList = [
    "后端技术栈：SpringBoot + mybatis +mysql + knife4j + flyway",
    "前端技术栈：vue3 + typescript + axios + vite + pinia",
    "App技术栈：flutter + dio + getx + provider + 原生android",
    "小程序技术栈：原生小程序 + typescript",
  ];

  List<SwiperModel> swiperModels = [];
  List<NoticeModel> noticeModels = [];

  @override
  void initState() {
    super.initState();

    _requestHomeData();
  }

  _requestHomeData() async {
     swiperModels = await SwiperService.requestSwiper();
     noticeModels = await NoticeService.requestNotice();

    _bannerList.clear();
    _marqueeTextList.clear();

    for (var swiperModel in swiperModels) {
      _bannerList.add(HttpHelperConfig.serviceList[HttpHelperConfig.selectIndex]+ "${swiperModel.attachment?.url}");
    }
    for (var noticeModel in noticeModels) {
      _marqueeTextList.add("${noticeModel.subTitle}");
    }
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        elevation: 0, centerTitle: true, toolbarHeight: 49.h, backgroundColor: Get.theme.primaryColor, systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
        title: const Text("网捷回收", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF))),
        actions: [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 10.w),
              child: Image.asset("assets/common/scan.png", width: 25.w, height: 25.w,),
            ),
            onTap: ()=> QrScannerUtil.scan(onScanSuccess: (res){
               if(res.toString().startsWith("http://www.ilovesshan.com/?payId=")){
                 // 处理支付逻辑
                  EasyLoading.showToast(res.toString());
               }else{
                 // 处理其他逻辑
               }
            }),
          )
        ],
      ),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              // 背景填充
              Container(height: 200.h, width: Get.width, alignment: Alignment.topCenter, child: Container(width:Get.width, height: 80.h, color: Get.theme.primaryColor)),
              // 轮播图模块
              Positioned(
                left: 5.w, right: 5.w,
                child: ClipRRect(borderRadius: BorderRadius.circular(20.r), child: SwiperWidget.build(list: _bannerList, onItemPressed: (index)=>{
                  Get.toNamed(YFRouter.webviewPlugin, arguments: {"path": swiperModels[index].link, "title":swiperModels[index].title})
                }),
              ))
            ],
          ),

          // 公告
          Container(
            margin: EdgeInsets.only(top: 10.h), padding: EdgeInsets.symmetric(horizontal: 10.w), width:Get.width, height: 40.h, color: Colors.white,
            child: Row(
              children: [
                Image.asset("assets/common/notice.png", width: 15.w, height: 15.w,),
                SizedBox(width: 10.h,),
                Expanded(child: Container(alignment: Alignment.center, height: 20.h, child: buildMarqueeWidget(_marqueeTextList, onItemPressed: (index)=>{
                  Get.toNamed(YFRouter.noticeDetail, arguments: {"notice":noticeModels[index]}),
                }))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 保存页面状态
  @override
  bool get wantKeepAlive => true;

  ///上下轮播 安全提示
  Widget buildMarqueeWidget(List<String> loopList, {OnItemPressedWithIndex? onItemPressed}) {
    return MarqueeWidget(
      //子Item构建器
      itemBuilder: (BuildContext context, int index) {
        String itemStr = loopList[index];
        //通常可以是一个 Text文本
        return GestureDetector(
          child: Tooltip(message: itemStr, child: Text(itemStr, overflow: TextOverflow.ellipsis)),
          onTap: ()=> { if(onItemPressed != null)onItemPressed(index)}
        );
      },
      //循环的提示消息数量
      count: loopList.length,
    );
  }
}
