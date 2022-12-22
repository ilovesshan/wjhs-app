import 'package:app/model/order_model.dart';
import 'package:app/router/router.dart';
import 'package:app/utils/system_dict_util.dart';
import 'package:app/view/order/widgets/common_row.dart';
import 'package:app/view_model/order_view_model.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'mini_button.dart';

class InProgress extends StatefulWidget {
  const InProgress({Key? key}) : super(key: key);

  @override
  State<InProgress> createState() => _InProgressState();
}

class _InProgressState extends State<InProgress> with SingleTickerProviderStateMixin {

  List<BadgeTab> _tabs = [];
  late TabController _tabController;
  final OrderViewModel _viewModel = OrderViewModel();

  String _type = "1";
  String _status = "5";
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabs.add(BadgeTab(text: "待上门"));
    _tabs.add(BadgeTab(text: "待结算"));
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BrnTabBar(
          themeData: BrnTabBarConfig(tabHeight: 39.h, labelStyle: BrnTextStyle(fontSize: 12), unselectedLabelStyle: BrnTextStyle(fontSize: 12)),
          controller: _tabController,
          tabs: _tabs,
          onTap: (state, index) {
            _currentIndex = index;
            _viewModel.type = _type;
            _viewModel.status = index == 0 ? "5" : "6";
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
            return Column(
              children: List.generate(vm.mode.length, (index){
                final OrderModel orderModel = vm.mode[index];
                // 预约时间显示
                final String appointmentTime =  orderModel.appointmentBeginTime!.substring(0, 16) + " - " + orderModel.appointmentEndTime!.substring(11, 16);
                // 上门地址
                final String address = orderModel.address!.province! +  orderModel.address!.city! +  orderModel.address!.area! + orderModel.address!.detailAddress!;

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
                              SizedBox(width: 200.w, child: CommonRow(title: "商品重量", value: "${orderModel.totalWeight}")),
                              BrnTagCustom(tagText: SystemDictUtil.getTextByCode("${orderModel.status}")!, backgroundColor: Get.theme.primaryColor, tagBorderRadius: const BorderRadius.only(topRight: Radius.circular(5)),)
                            ]
                        ),
                        SizedBox(height: 3.h),
                        CommonRow(title: "商品价格", value: "${orderModel.tradingMoney}"),
                        SizedBox(height: 3.h),
                        CommonRow(title: "预约时间", value: appointmentTime),
                        SizedBox(height: 3.h),
                        CommonRow(title: "上门地址", value:address),
                        SizedBox(height: 3.h),
                        _currentIndex == 0 ? Container(
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
                        ) : const SizedBox()
                      ],
                    ),
                  ),
                  onTap: ()=> Get.toNamed(YFRouter.orderDetail,arguments: {"orderId": orderModel.id})!.then((value){
                    vm.type = "1";
                    vm.status = "5";
                    vm.initData();
                  }),
                );
              }),
            );
          },
        ))
      ],
    );
  }
}
