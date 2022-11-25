import 'package:app/router/router.dart';
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
    _accountController = TextEditingController(text: "ilovesshan");
    _passwordController = TextEditingController(text: "ilovesshan!@#");
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
                Image.asset("assets/images/app_logo/logo-green.png"),
                SizedBox(height: 150.h),
                Column(
                  children: [
                    // 用户名
                    TextField(
                      controller: _accountController,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: "用户名",
                        labelStyle: TextStyle(fontSize: 14.sp),
                      ),
                    ),

                    SizedBox(height: 10.h),

                    // 密码
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        labelText: "密码",
                        labelStyle: TextStyle(fontSize: 14.sp),
                        suffix: GestureDetector(
                          child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off, size: 18),
                          onTap: (){
                            _obscureText = !_obscureText;
                            setState(() {});
                          },
                        ),
                      ),
                    ),

                    SizedBox(height: 50.h),

                    // 登录按钮
                    Column(
                      children: [
                        GestureDetector(
                          child: Container(
                            width: Get.width, height: 49.h, alignment: Alignment.center,
                            decoration: BoxDecoration(color: Get.theme.primaryColor, borderRadius: BorderRadius.circular(5.r)),
                            child: Text("账号登录", style: TextStyle(fontSize: 14.sp, color: const Color(0xFFFFFFFF))),
                          ),
                          onTap: ()=> loginByAccount(),
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          width: Get.width, height: 26.h, alignment: Alignment.center,
                          child: GestureDetector(
                            child: Text("其他登录方式", style: TextStyle(fontSize: 14.sp, color:  Get.theme.primaryColor)),
                            onTap: ()=> loginByPhone(),
                          ),
                        ),
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
  loginByAccount() {
    String account  = _accountController.text;
    String password  = _passwordController.text;
    if(TextUtils.isValid(account) || TextUtils.isValid(password)){
      EasyLoading.showToast("账户或密码不能为空");
      return;
    }
    // 去登录界面
    Get.offAndToNamed(YFRouter.menuContainer);
  }
}
