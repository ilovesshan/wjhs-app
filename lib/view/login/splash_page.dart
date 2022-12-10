import 'dart:math';

import 'package:app/model/user_auth_model.dart';
import 'package:app/model/user_info_model.dart';
import 'package:app/router/router.dart';
import 'package:app/service/login_service.dart';
import 'package:app/utils/cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:common_utils/common_utils.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    // 初始化 本地存储工具
    SharedPreferencesUtil.initSharedPreferences();

     Future.delayed( const Duration(milliseconds: 2000),() async {
       // 判断是否能自动登录
       String username = CommonCache.getUsername();
       String password = CommonCache.getPassWord();
       if(TextUtils.isNotValid(username) && TextUtils.isNotValid(password)){
         // 实现自动登录功能
         try {
           // 用户授权
           final UserAuthModel userAuthModel = await LoginService.requestUserAuth(username, password);
           if(TextUtils.isNotValid(userAuthModel.id.toString())){
             // 获取用户信息
             final UserInfoModel userInfoModel = await LoginService.requestUserInfo("${userAuthModel.id}");
             if(TextUtils.isNotValid(userAuthModel.id.toString())){
               // 持久化信息
               Cache.saveUserInfo(userInfoModel);
               CommonCache.saveId("${userAuthModel.id}");
               CommonCache.saveUsername(username);
               CommonCache.savePassword(password);
               CommonCache.saveToken("${userAuthModel.token}");
               // 去首页
               Get.offAndToNamed(YFRouter.menuContainer);
             }
           }else{
             Get.offAndToNamed(YFRouter.login);
           }
         } catch (e) {
           Get.offAndToNamed(YFRouter.login);
         }
       }else{
          // 去登录
          Get.offAndToNamed(YFRouter.login);
       }
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFFFFFFFF), elevation: 0),
      backgroundColor: const Color(0xFFFFFFFF),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child:Image.asset("assets/images/app_logo/app-logo.png"),),
            const Text("POWER BY FLUTTER APP", style: TextStyle(color: Color(0xFFb2bec3))),
            SizedBox(height: 100.h)
          ],
        ),
      ),
    );
  }
}
