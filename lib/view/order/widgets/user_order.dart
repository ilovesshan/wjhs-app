import 'package:app/model/order_model.dart';
import 'package:app/model/user_info_model.dart';
import 'package:app/native_channel/notice_channel.dart';
import 'package:app/router/router.dart';
import 'package:app/service/order_service.dart';
import 'package:app/service/user_service.dart';
import 'package:app/utils/system_dict_util.dart';
import 'package:app/view/order/widgets/common_row.dart';
import 'package:app/view_model/order_view_model.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'mini_button.dart';

class userOrder extends StatefulWidget {
  const userOrder({Key? key}) : super(key: key);

  @override
  State<userOrder> createState() => _userOrderState();
}

class _userOrderState extends State<userOrder> with SingleTickerProviderStateMixin {

  List<BadgeTab> _tabs = [];
  late TabController _tabController;
  final OrderViewModel _viewModel = OrderViewModel();

  String _type = "1";
  String _status = "5";
  int _currentIndex = 0;
  final String _baseUrl = HttpHelperConfig.serviceList[HttpHelperConfig.selectIndex];

  @override
  void initState() {
    super.initState();
    _tabs.add(BadgeTab(text: "待上门"));
    _tabs.add(BadgeTab(text: "待结算"));
    _tabs.add(BadgeTab(text: "已完结"));
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BrnTabBar(
          labelColor: Get.theme.primaryColor,
          indicatorColor: Get.theme.primaryColor,
          themeData: BrnTabBarConfig(tabHeight: 39.h, labelStyle: BrnTextStyle(fontSize: 12), unselectedLabelStyle: BrnTextStyle(fontSize: 12)),
          controller: _tabController,
          tabs: _tabs,
          onTap: (state, index) {
            _currentIndex = index;
            _viewModel.type = _type;
            _viewModel.status = (index + 5).toString();
            _viewModel.initData();
          },
        ),
        Expanded(child: BaseView<OrderViewModel>(
          mode: _viewModel,
          onReady: (model){
            model.type = _type;
            model.status = _status;
            model.initData();
          },
          child: const SizedBox(),
          builder: (BuildContext context, OrderViewModel vm, Widget? child) {
            if(vm.viewState == ViewState.LOADING) return ViewLoader.loadingWidget();
            if(vm.viewState == ViewState.EEMPTY) return ViewLoader.emptyWidget();
            if(vm.viewState == ViewState.ERROR) return ViewLoader.errorWidget(vm);
            return SingleChildScrollView(
              child: Column(
                children: List.generate(vm.mode.length, (index){
                  final OrderModel orderModel = vm.mode[index];
                  // 预约时间显示
                  final String appointmentTime =  orderModel.appointmentBeginTime!.substring(0, 16) + " - " + orderModel.appointmentEndTime!.substring(11, 16);
                  // 上门地址
                  final String address = orderModel.address!.province! +  orderModel.address!.city! +  orderModel.address!.area! + orderModel.address!.detailAddress!;
                  // 计算回收价格
                  double recyclePrice = 0.0;
                  for (var recycleOrder in orderModel.recycleOrderDetails!) {
                    recyclePrice += double.parse("${recycleOrder.recycleGoods!.driverPrice}") *  double.parse("${recycleOrder.weight}");
                  }

                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: Get.width, margin: EdgeInsets.only(bottom: 10.h), padding: EdgeInsets.all(8.w), decoration: BoxDecoration(color: const Color(0xffefefef).withOpacity(0.5), borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        children: [
                          SizedBox(height: 3.h),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: 200.w, child: CommonRow(title: "订单重量", value: "${orderModel.totalWeight}")),
                                BrnTagCustom(fontSize: 10.sp, tagText: SystemDictUtil.getTextByCode("${orderModel.status}")!, backgroundColor: Get.theme.primaryColor, tagBorderRadius: const BorderRadius.only(topRight: Radius.circular(5)),)
                              ]
                          ),
                          SizedBox(height: 3.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: CommonRow(title: "订单价格", value: "${orderModel.tradingMoney}")),
                              Expanded(child: CommonRow(title: "回收价格", value: recyclePrice.toStringAsFixed(2))),
                            ]
                          ),
                          SizedBox(height: 3.h),
                          CommonRow(title: "预约时间", value: appointmentTime),
                          SizedBox(height: 3.h),
                          CommonRow(title: "上门地址", value:address),
                          SizedBox(height: 3.h),
                          CommonRow(title: "订单编号", value: "${orderModel.id}"),
                          SizedBox(height: 3.h),
                          _currentIndex == 2 ? CommonRow(title: "结算时间", value: "${orderModel.updateTime}") : const SizedBox(),
                          _currentIndex == 2 ? SizedBox(height: 3.h) : const SizedBox(),
                          _buildCommonOperationBar(orderModel, vm)
                        ],
                      ),
                    ),
                    onTap: ()=> Get.toNamed(YFRouter.orderDetail,arguments: {"orderId": orderModel.id})!.then((value){
                      vm.type = "1";
                      if( _currentIndex == 0){
                        vm.status = "5";
                      } else if (_currentIndex == 1){
                        vm.status = "6";
                      } else {
                        vm.status = "7";
                      }
                      vm.initData();
                    }),
                  );
                }),
              ),
            );
          },
        ))
      ],
    );
  }


  Widget _buildCommonOperationBar(OrderModel orderModel, OrderViewModel vm){
    if(_currentIndex == 0){
      // 待上门
      return Container(
        decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xffefefef)))), padding: EdgeInsets.only(top: 5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MiniButton(text: "联系用户", icon: Icons.phone, color: Colors.green, onPressed: () async {
              final url = "tel:${orderModel.address!.phone!}";
              if (await launch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            }),

            SizedBox(width: 10.w),

            MiniButton(text: "导航", icon: Icons.location_on, color: Colors.lightBlue, onPressed: () async {
              await MapNavigationUtil.gotoMap(orderModel.address!.longitude!, orderModel.address!.latitude!);
            }),
          ],
        ),
      );
    }else if(_currentIndex == 1){
      return Container(
        // 待结算
        decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xffefefef)))), padding: EdgeInsets.only(top: 5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MiniButton(text: "支付", icon: Icons.repeat, color: Colors.green, onPressed: () async {
              QrScannerUtil.scan(onScanSuccess: (res) async {
                String payTag = "/recycleOrders/pay/";
                if(res.toString().contains(payTag)){
                  // 处理支付逻辑
                  int subIndex = res.toString().indexOf(payTag) + payTag.length;
                  // 获取 用户ID、骑手ID、 订单ID
                  final List<String> ids = res.toString().substring(subIndex).split("/");
                  if(orderModel.submitUserId!=ids[0] || orderModel.receiveUserId !=ids[1] || orderModel.id != ids[2]){
                    // 不正确的订单支付码
                    EasyLoading.showToast("订单结算失败,不正确的订单支付码!");
                    return;
                  }
                  final isSuccess = await RecycleOrderService.orderPay(ids[2]);
                  if(isSuccess){
                    // 成功
                    NoticeChannel.notice();
                    Get.snackbar("订单信息", "订单结算成功啦, 去任务大厅逛逛吧！");
                    vm.type = "1";
                    vm.status = (_currentIndex == 0 ? "5" : "6");
                    vm.initData();
                  }else{
                    // 失败
                    EasyLoading.showToast("订单结算失败,请稍后再试，您也可以联系客服!");
                  }
                }else{
                  // 处理其他逻辑
                }
              });
            }),
          ],
        ),
      );
    }else{
      return Container(
        // 已完结
        decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xffefefef)))), padding: EdgeInsets.only(top: 5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
          TextUtils.isNotValid("${orderModel.sendToRecycleCenter}") ? const SizedBox(): MiniButton(text: "送至回收点", icon: Icons.add_to_drive, color: Colors.green, onPressed: () async {
            final List<UserInfoModel> recycleCenterUserList = await UserService.requestUserListByType();
            Get.bottomSheet(
              Container(
                height: 260.h, color: const Color.fromRGBO(255, 255, 255, 1),
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(recycleCenterUserList.length, (index){
                      return Column(
                        children:[
                          ListTile(
                            leading: ClipRRect(borderRadius: BorderRadius.circular(10.sp),
                            child: (recycleCenterUserList[index].attachment != null && TextUtils.isNotValid("${recycleCenterUserList[index].attachment!.url}"))
                              ? Image.network(_baseUrl + "${recycleCenterUserList[index].attachment!.url}", width: 35.w, height: 35.w)
                              : Image.asset("assets/images/app_logo/app-logo.png", width: 40.w, height: 40.w,fit: BoxFit.cover)),
                            title: Text("${recycleCenterUserList[index].username}", style: TextStyle(fontSize: 14.sp), textAlign: TextAlign.left),
                            subtitle: Text("${recycleCenterUserList[index].phone}", style: TextStyle(fontSize: 12.sp), textAlign: TextAlign.left),
                            onTap: () async {
                              Get.back();
                              CommonDialog.showDialogCustom(context, title: "回收订单", messageWidget: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Text("确定将订单送往回收中心负责人(${recycleCenterUserList[index].username})处吗？",style: TextStyle(fontSize: 12.sp)),
                              ),  onConfirm: () async {
                                final result = await RecycleOrderService.sendRecycleGoodsOrderToRecycleCenter("${orderModel.id}", "${recycleCenterUserList[index].id}");
                                if(result){
                                  NoticeChannel.notice();
                                  Get.snackbar("订单信息", "一条新订单创建成功啦！");
                                  vm.type = "1";
                                  vm.status = "7";
                                  vm.initData();
                                }else{
                                  EasyLoading.showToast("订单创建失败,请稍后再试");
                                }
                              }, onCancel: ()=>{});
                            },
                          ),
                          const Divider(height: 0.0, indent: 0.0, color: Color(0xFFE6E6E6))
                        ],
                      );
                    }),
                  ),
                ),
              ),
            );
            }),
          ],
        ),
      );
    }
  }
}
