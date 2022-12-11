import 'dart:io';

import 'package:app/router/router.dart';
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
          Card(
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
                        const Icon(Icons.chevron_right_sharp, size: 15),
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
          ),
          ElevatedButton(child: const Text("退出登录"),onPressed: () async {
            Cache.removeUserInfo();
            CommonCache.removeId();
            CommonCache.removeUsername();
            CommonCache.removePassword();
            CommonCache.removeToken();
            Get.offAndToNamed(YFRouter.login);
          }),
        ],
      ),
    );
  }
}
