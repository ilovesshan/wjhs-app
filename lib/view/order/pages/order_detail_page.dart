import 'package:app/model/order_model.dart';
import 'package:app/utils/system_dict_util.dart';
import 'package:app/view_model/order_detail_view_model.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({Key? key}) : super(key: key);

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  String orderId = Get.arguments["orderId"];
  final String _baseUrl = HttpHelperConfig.serviceList[HttpHelperConfig.selectIndex];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar.showWidthPrimaryTheme("订单详情"),
      body:  BaseView<OrderDetailViewModel>(
        mode: OrderDetailViewModel(),
        onReady: (model){
          model.orderId = orderId;
          model.initData();
        },
        child: const SizedBox(),
        builder: (BuildContext context, OrderDetailViewModel vm, Widget? child) {
          if(vm.viewState == ViewState.LOADING) return ViewLoader.loadingWidget();
          if(vm.viewState == ViewState.EEMPTY) return ViewLoader.emptyWidget();
          if(vm.viewState == ViewState.ERROR) return ViewLoader.errorWidget(vm);
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: Column(
              children: [
                buildRow("订单编号", orderId),
                SizedBox(height: 5.h),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("订单状态：", style: TextStyle(fontSize: 13.sp)),
                    Container(
                      margin: EdgeInsets.only(top: 3.h),
                      child: BrnTagCustom(tagText: SystemDictUtil.getTextByCode("${vm.mode.status}")!, backgroundColor: Get.theme.primaryColor),
                    )
                  ]
                ),

                SizedBox(height: 5.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("商品列表：", style: TextStyle(fontSize: 13.sp)),
                      Expanded(
                        child: Column(
                          children: List.generate(vm.mode.recycleOrderDetails!.length, (index){
                            final RecycleOrderDetail orderDetail = vm.mode.recycleOrderDetails![index];
                            return Container(
                              margin: EdgeInsets.only(right: 5.w, top: 5.h), color: const Color(0xffefefef).withOpacity(0.8),
                              child: Row(
                                children: [
                                  ClipRRect(child: Image.network(_baseUrl + orderDetail.recycleGoods!.attachment!.url!, width: 50, height: 50, fit: BoxFit.cover), borderRadius: BorderRadius.circular(5.r)),
                                  SizedBox(width: 20.w),
                                  Column(
                                    children: [
                                      SizedBox(width:200.w , child: buildRow("商品名称", "${orderDetail.recycleGoods!.name}")),
                                      SizedBox(height: 3.h),
                                      SizedBox(width:200.w , child: buildRow("商品重量", "${orderDetail.weight}")),
                                    ],
                                  )
                                ],
                              )
                            );
                          }
                        ),
                      )
                    )
                  ]
                ),

                SizedBox(height: 5.h),
                buildRow("订单重量", "${vm.mode.totalWeight}"),

                SizedBox(height: 5.h),
                buildRow("订单价格", "${vm.mode.tradingMoney}"),

                SizedBox(height: 5.h),
                buildRow("预约人姓名", "${vm.mode.address!.userName}"),

                SizedBox(height: 5.h),
                buildRow("预约人电话",  "${vm.mode.address!.phone}"),

                SizedBox(height: 5.h),
                buildRow("预约人地址",  vm.mode.address!.province! +  vm.mode.address!.city! +  vm.mode.address!.area! + vm.mode.address!.detailAddress!),

                SizedBox(height: 5.h),
                buildRow("预约时间",  vm.mode.appointmentBeginTime!.substring(0, 16) + " - " + vm.mode.appointmentEndTime!.substring(11, 16)),

                SizedBox(height: 5.h),
                buildRow("下单时间",  "${vm.mode.createTime}"),

                SizedBox(height: 5.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("备注图片：", style: TextStyle(fontSize: 13.sp)),
                    Expanded(
                      child: Row(children: List.generate(vm.mode.attachments!.length, (index){
                        return Container(margin: EdgeInsets.only(right: 5.w, top: 5.h), child: ClipRRect(borderRadius: BorderRadius.circular(5.r), child: Image.network(_baseUrl + vm.mode.attachments![index].url!, width: 70, height: 70, fit: BoxFit.cover)));
                      })),
                    ),
                  ]
                ),
                SizedBox(height: 5.h),
                buildRow("备注信息", "${vm.mode.note}"),
              ],
            ),
          );
        },
      ),
    );
  }

  Row buildRow(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title +"：", style: TextStyle(fontSize: 13.sp)),
        Expanded(child: Text(TextUtils.isValidWith(value, ""), style: TextStyle(fontSize: 13.sp, height: 1.4))),
      ]
    );
  }
}
