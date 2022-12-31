import 'package:app/model/order_model.dart';
import 'package:app/native_channel/notice_channel.dart';
import 'package:app/router/router.dart';
import 'package:app/service/order_service.dart';
import 'package:app/utils/system_dict_util.dart';
import 'package:app/view/order/widgets/common_row.dart';
import 'package:app/view/order/widgets/mini_button.dart';
import 'package:app/view_model/order_view_model.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InventoryOrder extends StatefulWidget {
  const InventoryOrder({Key? key}) : super(key: key);

  @override
  State<InventoryOrder> createState() => _InventoryOrderState();
}

class _InventoryOrderState extends State<InventoryOrder> with SingleTickerProviderStateMixin {

  List<BadgeTab> _tabs = [];
  late TabController _tabController;
  final OrderViewModel _viewModel = OrderViewModel();

  String _type = "2";
  // 6：待结算， 7：已完结
  String _status = "6";
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabs.add(BadgeTab(text: "进行中"));
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
            _viewModel.status = (index + 6).toString();
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
                    recyclePrice += double.parse("${recycleOrder.recycleGoods!.recycleCenterPrice}") *  double.parse("${recycleOrder.weight}");
                  }

                  final String _baseUrl = HttpHelperConfig.serviceList[HttpHelperConfig.selectIndex];

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
                              BrnTagCustom(fontSize: 10.sp, tagText: _currentIndex == 0 ? "进行中" : "已完结", backgroundColor: Get.theme.primaryColor, tagBorderRadius: const BorderRadius.only(topRight: Radius.circular(5)),)
                            ]
                          ),
                          SizedBox(height: 3.h),
                          CommonRow(title: "订单价格", value: "${orderModel.tradingMoney}"),
                          SizedBox(height: 3.h),
                          CommonRow(title: "订单编号", value: "${orderModel.id}"),
                          SizedBox(height: 3.h),
                          CommonRow(title: "下单时间", value: "${orderModel.createTime}"),
                          SizedBox(height: 3.h),
                          _currentIndex == 1 ? const SizedBox(): Container(
                            decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xffefefef)))), padding: EdgeInsets.only(top: 5.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                MiniButton(text: "结算", icon: Icons.check_circle, color: Colors.green, onPressed: (){
                                  CommonDialog.showTipDialogCustom(context, title: "订单收款码", messageWidget: Container(
                                    alignment: Alignment.center,
                                    child: QrImage(
                                      // 根据骑手用户ID + 回收中心用户ID + 订单ID 生成一个二维码链接 骑手扫码即可付款
                                      data: "$_baseUrl/recycleOrders/pay/${orderModel.submitUserId}/${orderModel.receiveUserId}/${orderModel.id}",
                                      version: QrVersions.auto,
                                      size: 180.0,
                                    ),
                                  ), onTipPressed: (){});
                                }),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: ()=> Get.toNamed(YFRouter.orderDetail,arguments: {"orderId": orderModel.id})!.then((value){
                      vm.type = _type;
                      vm.status = (_currentIndex == 0 ? "6" : "7");
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
  Widget buildRow(String key, String value){
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(key +"：", style: TextStyle(fontSize: 12.sp)),
          Expanded(child: Text(TextUtils.isValidWith(value, ""), style: TextStyle(fontSize: 12.sp))),
        ]
    );
  }
}
