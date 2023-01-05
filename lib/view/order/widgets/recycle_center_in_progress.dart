import 'package:app/model/order_model.dart';
import 'package:app/native_channel/notice_channel.dart';
import 'package:app/router/router.dart';
import 'package:app/service/order_service.dart';
import 'package:app/utils/system_dict_util.dart';
import 'package:app/view_model/order_view_model.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'common_row.dart';
import 'mini_button.dart';

class RecycleCenterInProgress extends StatefulWidget {
  const RecycleCenterInProgress({Key? key}) : super(key: key);

  @override
  State<RecycleCenterInProgress> createState() => _RecycleCenterInProgressState();
}

class _RecycleCenterInProgressState extends State<RecycleCenterInProgress> {
  @override
  Widget build(BuildContext context) {
    return BaseView<OrderViewModel>(
      mode: OrderViewModel(),
      onReady: (model){
        model.isReceiveCenter = true;
        model.type = "11";
        model.status = "6";
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
                      CommonRow(title: "订单价格", value: "${orderModel.tradingMoney}"),
                      SizedBox(height: 3.h),
                      CommonRow(title: "下单时间",  value: "${orderModel.createTime}"),
                      SizedBox(height: 3.h),
                      Container(
                        decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xffefefef)))), padding: EdgeInsets.only(top: 5.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MiniButton(text: "支付", icon: Icons.repeat, color: Colors.green, onPressed: (){
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
                                    Get.snackbar("订单信息", "订单结算成功啦！");
                                    vm.isReceiveCenter = true;
                                    vm.type = "11";
                                    vm.status = "6";
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
                      )
                    ],
                  ),
                ),
                onTap: ()=> Get.toNamed(YFRouter.orderDetail,arguments: {"orderId": orderModel.id})!.then((value){
                  vm.isReceiveCenter = true;
                  vm.type = "11";
                  vm.status = "6";
                  vm.initData();
                }),
              );
            }),
          ),
        );
      },
    );
  }
}