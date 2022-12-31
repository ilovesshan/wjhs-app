import 'package:app/model/recycle_goods_model.dart';
import 'package:app/service/recycle_goods_service.dart';
import 'package:app/utils/cache.dart';
import 'package:app/utils/system_dict_util.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<CategoryPage> with AutomaticKeepAliveClientMixin {
  final TextEditingController _kwController = TextEditingController();
  List<RecycleGoodsModel> _recycleGoodsModels = [];
  int currentIndex = 0;
  final String _baseUrl = HttpHelperConfig.serviceList[HttpHelperConfig.selectIndex];

  bool _isSearch = false;
  List<RecycleGood> _searchResult = [];

  @override
  void initState() {
    super.initState();
    requestData();
  }

  Future<bool> requestData() async {
   final result = await RecycleGoodsService.requestRecycleGoods();
   _recycleGoodsModels = result;
   setState(() {});
   return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, toolbarHeight: 0, systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light)),
      body: EasyRefresh(
        header: CustomRefreshHeader(),
        onRefresh: ()async {
          await requestData();
        },
        child: Column(
          children: [
            // 搜索栏
            CommonBar.buildCommonSearchBar(controller: _kwController, isShowSearch: _isSearch,
              onSubmitted: (value){
                _searchHandler(value);
              }, onCancel: (){
                _cancelHandler();
              }
            ),

            SizedBox(height:10.h),

            _isSearch
              ? Container(
                child: _searchResult.isEmpty ? ViewLoader.emptyWidget() : Column(children: List.generate(_searchResult.length, (index){
                  return buildRecycleGoodsItemWidget(_searchResult[index]);
                })))
              // tabBar(49) - sizedBox(10) - searchBar(55)
              : Container(height: (Get.height - 49 - 10 - 55), width: Get.width, padding: EdgeInsets.symmetric(horizontal: 2.w), child: Row(
                children: [
                  // 分类导航
                  buildRecycleGoodsNav(),

                  // 商品列表
                  Expanded(
                    child: Column(children: List.generate(_recycleGoodsModels[currentIndex].recycleGoods!.length, (index){
                      return buildRecycleGoodsItemWidget(_recycleGoodsModels[currentIndex].recycleGoods![index]);
                    })),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  @override
  bool get wantKeepAlive => true;


  /// done搜索逻辑
  void _searchHandler(String value){
    if(TextUtils.isValid(value)){
      _isSearch = false;
      _searchResult .clear();
      setState(() {});
      return;
    }
    List<RecycleGood> searchResult = [];
    for (var recycleGoodsModel in _recycleGoodsModels) {
      if(recycleGoodsModel.name!.contains(value)){
        searchResult.addAll(recycleGoodsModel.recycleGoods as List<RecycleGood>);
      }else{
        for( var goods in recycleGoodsModel.recycleGoods as List<RecycleGood>){
          if(goods.name!.contains(value)){
            searchResult.add(goods);
          }
        }
      }
    }
    _isSearch = true;
    _searchResult = searchResult;
    setState(() {});
  }

  /// 取消/搜索逻辑
  void _cancelHandler(){
    if(!_isSearch){
      _searchHandler(_kwController.text);
      return;
    }
    _kwController.text = "";
    _isSearch = false;
    _searchResult .clear();
    setState(() {});
  }

  /// 回收商品Nav
  Container buildRecycleGoodsNav() {
    return Container(
      width: 100.w, color: const Color(0xfff6f7f9),
      child: Column(children: List.generate(_recycleGoodsModels.length, (index){
        return GestureDetector(
          child: Container(
            width: 100.w ,height: 40.h, alignment: Alignment.center, margin: EdgeInsets.only(bottom: 5.h),
            decoration: BoxDecoration(
              color: currentIndex == index ?  const Color(0xffffffff) : const Color(0xfff6f7f9),
              border:Border(left: BorderSide(color: currentIndex == index ?  Get.theme.primaryColor : const Color(0xfff6f7f9), width: 3.w)),
            ),
            child: Text("${_recycleGoodsModels[index].name}", style: TextStyle(fontSize: 12.sp)),
          ),
          onTap: (){
            currentIndex = index;
            setState(() {});
          },
        );
      })),
    );
  }

  /// 回收商品通用item
  GestureDetector buildRecycleGoodsItemWidget(RecycleGood recycleGood) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
          height: 80.h, alignment: Alignment.center, margin: EdgeInsets.only(bottom: 5.h, left: 10.w), padding: EdgeInsets.symmetric(vertical: 2.h),
          child: Row(
            children: [
              // 回收商品图片
              ClipRRect(borderRadius: BorderRadius.circular(5.r), child: FadeInImage.assetNetwork(placeholder: "assets/common/loading.png", image: _baseUrl +"${recycleGood.attachment!.url}", width: 90.w, height: 90.w, fit:BoxFit.fill)),
              SizedBox(width: 10.w),
              // 回收商品详细信息
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${recycleGood.name}", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold)),
                      Text(TextUtils.isValidWith("${recycleGood.describe}", "暂无描述信息"), style: TextStyle(fontSize: 10.sp, color: const Color(0xff828081))),
                    ],
                  ),
                  Text("￥${SystemDictUtil.isRecyclingCenterUser()  ? recycleGood.recycleCenterPrice : recycleGood.driverPrice} /kg", style: TextStyle(fontSize: 12.sp, color: const Color(0xffff0000), fontWeight: FontWeight.bold)),
                ],
              )
            ],
          )
      ),
      onTap: () => _showMessageDetailDialog(recycleGood),
    );
  }

  /// 价格详情dialog
  void _showMessageDetailDialog(RecycleGood recycleGood){
    CommonDialog.showTipDialogCustom(context, title: "${recycleGood.name}", messageWidget: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 如果是骑手用户登录 这里可以看骑手、小程序用户回收价格
          // 如果是回收中心用户登录 这里可以看回收中心、骑手、小程序用户回收价格
          Text("用户回收价：${recycleGood.userPrice} /kg", style: TextStyle(fontSize: 10.sp, color: const Color(0xff828081))),
          SizedBox(height: 5.w),
          Text("骑手回收价：${recycleGood.driverPrice} /kg", style: TextStyle(fontSize: 10.sp, color: const Color(0xff828081))),
          SizedBox(height: 5.w),
          SystemDictUtil.isRecyclingCenterUser()  ?  Text("回收中心回收价：${recycleGood.recycleCenterPrice} /kg", style: TextStyle(fontSize: 10.sp, color: const Color(0xff828081))) : const SizedBox(),
          SystemDictUtil.isRecyclingCenterUser() ?  SizedBox(height: 5.w) : const SizedBox(),
        ],
      ),
    ), onTipPressed: (){
    });
  }
}
