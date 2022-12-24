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

class MissionHall extends StatefulWidget {
  const MissionHall({Key? key}) : super(key: key);

  @override
  State<MissionHall> createState() => _MissionHallState();
}

class _MissionHallState extends State<MissionHall> {

  @override
  Widget build(BuildContext context) {
    return BaseView<OrderViewModel>(
      mode: OrderViewModel(),
      onReady: (model){
        model.type = "3";
        model.status = "";
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
                      Container(
                        decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xffefefef)))), padding: EdgeInsets.only(top: 5.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MiniButton(text: "抢单", icon: Icons.add, color: Colors.red, onPressed: (){
                              CommonDialog.showConfirmDialog(context, title: "确定要进行本单任务吗?", onConfirm: () async {
                                final isSuccess = await RecycleOrderService.updateOrderState("${orderModel.id}", "5");
                                if(isSuccess){
                                  NoticeChannel.notice();
                                  Get.snackbar("订单信息", "一条新订单创建成功啦！");
                                  // 刷新界面
                                  vm.type = "3";
                                  vm.status = "";
                                  vm.initData();
                                }else{
                                  EasyLoading.showToast("抢单失败,请稍后再试");
                                }
                              }, onCancel: ()=>{});
                            }),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                onTap: ()=> Get.toNamed(YFRouter.orderDetail,arguments: {"orderId": orderModel.id})!.then((value){
                  vm.type = "3";
                  vm.status = "";
                  vm.initData();
                }),
              );
            }),
          ),
        );
      },
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
