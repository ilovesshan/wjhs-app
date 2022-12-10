import 'package:app/model/system_dict_model.dart';
import 'package:app/model/user_auth_model.dart';
import 'package:app/model/user_info_model.dart';
import 'package:app/router/router.dart';
import 'package:app/service/login_service.dart';
import 'package:app/service/system_dict_service.dart';
import 'package:app/utils/cache.dart';
import 'package:app/utils/system_dict_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:common_utils/common_utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _obscureText = true;

  late TextEditingController _accountController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _accountController = TextEditingController(text: "sunlei");
    _passwordController = TextEditingController(text: "sunlei123456!@#");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFFFFFFFF), elevation: 0),
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50.h),
                Image.asset("assets/images/app_logo/logo.png", width: 200.w, height: 200.w),
                SizedBox(height: 100.h),
                Column(
                  children: [
                    // 用户名
                    TextField(controller: _accountController, decoration: InputDecoration(border: const UnderlineInputBorder(), labelText: "用户名", labelStyle: TextStyle(fontSize: 14.sp),)),

                    SizedBox(height: 10.h),

                    // 密码
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(border: const UnderlineInputBorder(), labelText: "密码", labelStyle: TextStyle(fontSize: 14.sp), suffix: GestureDetector(
                          child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off, size: 18),
                          onTap: (){_obscureText = !_obscureText;setState(() {});},
                        ),
                      ),
                    ),

                    SizedBox(height: 50.h),

                    // 登录按钮
                    Column(
                      children: [
                        GestureDetector(
                          child: Container(width: Get.width, height: 49.h, alignment: Alignment.center, decoration: BoxDecoration(color: Get.theme.primaryColor, borderRadius: BorderRadius.circular(5.r)), child: Text("账号登录", style: TextStyle(fontSize: 14.sp, color: const Color(0xFFFFFFFF)))),
                          onTap: ()=> loginByAccount(),
                        ),

                        SizedBox(height: 20.h),

                        Container(width: Get.width, height: 26.h, alignment: Alignment.center,
                          child: GestureDetector(child: Text("其他登录方式", style: TextStyle(fontSize: 14.sp, color:  Get.theme.primaryColor)),
                          onTap: ()=> loginByPhone(),
                        )),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 手机号登录
  loginByPhone() {
    EasyLoading.showToast("功能开发中");
  }

  /// 账户登录
  loginByAccount() async {
    String account  = _accountController.text;
    String password  = _passwordController.text;
    if(TextUtils.isValid(account) || TextUtils.isValid(password)){
      EasyLoading.showToast("账户或密码不能为空");
      return;
    }

    // 用户授权
    final UserAuthModel userAuthModel = await LoginService.requestUserAuth(account, password);
    if(TextUtils.isNotValid(userAuthModel.id.toString())){
      // 获取用户信息
      CommonCache.saveToken("${userAuthModel.token}");

      final UserInfoModel userInfoModel = await LoginService.requestUserInfo("${userAuthModel.id}");
      if(TextUtils.isNotValid(userAuthModel.id.toString())){
        // 持久化信息
        Cache.saveUserInfo(userInfoModel);
        CommonCache.saveId("${userAuthModel.id}");
        CommonCache.saveUsername(account);
        CommonCache.savePassword(password);

        // 请求数据字典表
        if(Cache.getSystemDict().isEmpty){
          final List<SystemDictModel> systemDictModel = await SystemDictService.requestSystemDict();
          Cache.saveSystemDict(systemDictModel);
        }

        // 做一次权限校验 只允骑手/回收中心用户登录
        if(SystemDictUtil.mobileCanLogin("${userInfoModel.userType}")){
          // 去首页
          Get.offAndToNamed(YFRouter.menuContainer);
        }else{
          // 无权登录
          EasyLoading.showToast("抱歉，您暂无权限登录该平台");
        }
      }
    }else{
      EasyLoading.showToast("用户名或者密码错误");
    }
  }
}
