import 'package:app/model/order_model.dart';
import 'package:app/router/router.dart';
import 'package:app/utils/system_dict_util.dart';
import 'package:app/view_model/order_view_model.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';

import 'common_row.dart';

class RecycleCenterDone extends StatefulWidget {
  const RecycleCenterDone({Key? key}) : super(key: key);

  @override
  State<RecycleCenterDone> createState() => _RecycleCenterDoneState();
}

class _RecycleCenterDoneState extends State<RecycleCenterDone> {
  @override
  Widget build(BuildContext context) {
    return BaseView<OrderViewModel>(
      mode: OrderViewModel(),
      onReady: (model){
        model.isReceiveCenter = true;
        model.type = "11";
        model.status = "7";
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
                      CommonRow(title: "结算时间",  value: "${orderModel.updateTime}"),
                    ],
                  ),
                ),
                onTap: ()=> Get.toNamed(YFRouter.orderDetail,arguments: {"orderId": orderModel.id})!.then((value){
                  vm.isReceiveCenter = true;
                  vm.type = "11";
                  vm.status = "7";
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
