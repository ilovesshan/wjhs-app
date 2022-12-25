import 'package:app/model/account_model.dart';
import 'package:app/utils/cache.dart';
import 'package:app/view_model/account_view_model.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class AccountManagementPage extends StatefulWidget {
  const AccountManagementPage({Key? key}) : super(key: key);

  @override
  State<AccountManagementPage> createState() => _AccountManagementPageState();
}

class _AccountManagementPageState extends State<AccountManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar.show("我的账户"),
      body: BaseView<AccountViewModel>(
        mode: AccountViewModel(),
        onReady: (model){
          model.initData();
        },
        child: const SizedBox(),
        builder: (BuildContext context, AccountViewModel vm, Widget? child) {
          if(vm.viewState == ViewState.LOADING) return ViewLoader.loadingWidget();
          if(vm.viewState == ViewState.EEMPTY) return ViewLoader.emptyWidget();
          if(vm.viewState == ViewState.ERROR) return ViewLoader.errorWidget(vm);
          return Column(
            children: [
              // 当前余额
              Container(
                height: 120.h, width: Get.width,
                decoration: BoxDecoration(gradient: LinearGradient(colors: [Get.theme.primaryColor, const Color(0xff07c160)], begin: Alignment.topCenter, end: Alignment.bottomCenter,)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${vm.mode.balance}", style: TextStyle(fontSize: 32.sp, color: Color(0xffffffff), fontWeight: FontWeight.bold)),
                    SizedBox(height: 8.h),
                    Text("当前余额", style: TextStyle(fontSize: 12.sp, color: Color(0xffffffff))),
                  ],

                ),
              ),

              // 余额流水
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(vm.mode.accountRecords!.length, (index){
                      final AccountRecord accountRecord = vm.mode.accountRecords![index];
                      final bool isIncome = accountRecord.userIdFrom == Cache.getUserInfo().id;
                      return Container(
                        padding: EdgeInsets.all(5.w), margin: EdgeInsets.only(bottom: 5.h),
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffefefef).withOpacity(0.5)))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    isIncome ? (TextUtils.isValid("${accountRecord.tradingNote}") ? "回收商品支入" : "${accountRecord.tradingNote}" "(平台交易)") : "回收商品支出(平台交易)",
                                    style: TextStyle(fontSize: 12.sp, color: isIncome ? Get.theme.primaryColor : const Color(0xff222222)),
                                ),
                                Text(isIncome ? "+${accountRecord.tradingMoney}" : "-${accountRecord.tradingMoney}", style: TextStyle(color: isIncome ? Get.theme.primaryColor : const Color(0xff222222), fontSize: 12.sp, fontWeight: FontWeight.bold)),
                              ]
                            ),
                            SizedBox(height: 5.h),
                            Text("2022-12-24 18:25:45", style: TextStyle(fontSize: 12.sp, color: Color(0xffcccccc))),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),

              // 提现充值
              Container(
                height: 60.h, width: Get.width, padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          height: 39.h, margin: EdgeInsets.only(right: 10.w), alignment: Alignment.center,
                          decoration: BoxDecoration(color: Get.theme.primaryColor, borderRadius: BorderRadius.circular(20.r)),
                          child: Text("充值", style: TextStyle(fontSize: 12.sp, color: const Color(0xffffffff))),
                        ),
                        onTap: ()=> BrnToast.show("功能还未上线，敬请期待！", context),
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          height: 39.h, margin: EdgeInsets.only(right: 10.w), alignment: Alignment.center,
                          decoration: BoxDecoration(color: const Color(0xff07c160), borderRadius: BorderRadius.circular(20.r)),
                          child: Text("提现", style: TextStyle(fontSize: 12.sp, color: const Color(0xffffffff))),
                        ),
                      onTap: ()=> BrnToast.show("功能还未上线，敬请期待！", context),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
