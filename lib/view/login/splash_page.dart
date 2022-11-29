import 'package:app/router/router.dart';
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

     Future.delayed( const Duration(milliseconds: 2000),()=>{
       Get.offAndToNamed(YFRouter.login)
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
