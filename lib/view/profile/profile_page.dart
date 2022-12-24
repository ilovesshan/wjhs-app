import 'dart:io';

import 'package:app/router/router.dart';
import 'package:app/service/user_service.dart';
import 'package:app/utils/cache.dart';
import 'package:app/utils/system_dict_util.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, toolbarHeight: 0, systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light)),
      body: Column(
        children: [
          //用户信息
          buildUserInfoCard(),

          // 账户管理
          buildProfileCommonItem(title: "账户管理", iconPath: "assets/images/profile/zhanghuguanli.png", onPressed: ()=>{}),

          // 历史订单
          buildProfileCommonItem(title: "历史订单", iconPath: "assets/images/profile/lishidingdan.png", onPressed: ()=>{}),


          // 更改密码
          buildProfileCommonItem(title: "更改密码", iconPath: "assets/images/profile/genggaimima.png", onPressed: (){
            Get.toNamed(YFRouter.updatePassword);
          }),

          // 推广应用
          buildProfileCommonItem(title: "推广应用", iconPath: "assets/images/profile/fenxiangxiao.png", onPressed: (){
            Share.share('https://www.ilovesshan/wjhsapp', subject: "");
          }),

          // 隐私政策
          buildProfileCommonItem(title: "隐私政策", iconPath: "assets/images/profile/yinsizhengce.png", onPressed: (){}),

          // 联系客服
          buildProfileCommonItem(title: "联系客服", iconPath: "assets/images/profile/lianxikefu.png", onPressed: ()=>{}),

          // 意见反馈
          buildProfileCommonItem(title: "意见反馈", iconPath: "assets/images/profile/yijianfankui.png", onPressed: ()=>{}),


          // 退出登录
          buildProfileCommonItem(title: "退出登录", iconPath: "assets/images/profile/tuichudenglu.png", onPressed: (){
            UserService.logout();
          }),
        ],
      ),
    );
  }


  // 左icon和文字 右边箭头 Widget
  Widget buildProfileCommonItem({required String title, required String iconPath, required OnPressed onPressed}) {
    return GestureDetector(
      child: Card(
        elevation: 0.2,
        child: Container(
          width: Get.width, margin: EdgeInsets.only(bottom: 5.h), height: 30.h, padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children:[
                  Image.asset(iconPath, width: 20.w, height: 20.w),
                  SizedBox(width:10.w),
                  Text(title, style: TextStyle(fontSize: 12.sp))
                ]
              ),
              Image.asset("assets/images/profile/arrow-right-grey.png", width: 10.w, height: 10.w),
            ],
          ),
        ),
      ),
      onTap: ()=> onPressed(),
    );
  }


  // 用户信息 Widget
  Widget buildUserInfoCard() {
    return Card(
      elevation: 0.3,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
            width: Get.width, height: 100.h, padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 左侧
                Row(
                  children: [
                    // 头像
                    ClipRRect(
                        borderRadius: BorderRadius.circular(40.r),
                        child:
                        (Cache.getUserInfo().attachment!=null && Cache.getUserInfo().attachment!.url!=null)
                            ? Image.network(HttpHelperConfig.serviceList[HttpHelperConfig.selectIndex]+"${Cache.getUserInfo().attachment!.url}", width: 40.w, height: 40.w, fit: BoxFit.cover)
                            : Image.asset("assets/images/app_logo/app-logo.png", width: 40.w, height: 40.w,fit: BoxFit.cover)
                    ),

                    SizedBox(width: 20.h),

                    // 用户名和角色
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                          decoration: BoxDecoration(color: Get.theme.primaryColor, borderRadius: BorderRadius.all(Radius.circular(30.r))),
                          child: Text("${SystemDictUtil.getTextByCode(Cache.getUserInfo().userType.toString())}", style: TextStyle(color: const Color(0xFFFFFFFF), fontSize: 10.sp)),
                        ),
                        SizedBox(height: 10.h),
                        Text("${TextUtils.isValid("${Cache.getUserInfo().nickName}") ? Cache.getUserInfo().username : Cache.getUserInfo().nickName}", style: const TextStyle(fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ],
                ),

                // 右侧
                Row(
                  children: [
                    Text("详情", style: TextStyle( fontSize: 10.sp)),
                    Image.asset("assets/images/profile/arrow-right-grey.png", width: 10.w, height: 10.w),
                  ],
                )
              ],
            )
        ),
        onTap: (){
          // 返回时 更新一下数据
          Get.toNamed(YFRouter.userInfoDetail)!.then((value) =>setState(() {}));
        },
      ),
    );
  }
}