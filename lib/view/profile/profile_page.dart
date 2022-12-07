import 'dart:io';

import 'package:app/router/router.dart';
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
  void initState() {
    super.initState();
    _initFluwx();
  }

  Future _initFluwx() async {
    await WxUtil.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.light)),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              final wxInstalled = await WxUtil.wxIsInstalled();
              if (!wxInstalled) {
                EasyLoading.showToast("未安装微信");
                return;
              }
            },
            child: const Text("微信分享"),
          ),
          ElevatedButton(
            onPressed: () async {
              Share.share('https://www.google.com/', subject: "");
            },
            child: const Text("分享"),
          ),

          Container(
            width: 200.w, height: 200.h, color: Colors.blue,
            child: QrImage(
              data: "http://www.ilovesshan.com/?payId=w8g123!@#",
              version: QrVersions.auto,
              size: 200.0,
            ),
          ),

          ElevatedButton(child: const Text("唤起高德地图"),onPressed: () async {
            // 104.08,30.65 春熙路太古里步行街
            await MapNavigationUtil.gotoGaoDeMap("104.08","30.65");
          }),

          ElevatedButton(child: const Text("唤起百度地图"),onPressed: () async {
            // 104.086002,30.659204 春熙路太古里步行街
            await MapNavigationUtil.gotoTencentMap("104.086002","30.659204");
          }),

          ElevatedButton(child: const Text("唤起腾讯地图"),onPressed: () async {
            // 30.6555,104.07721 春熙路太古里步行街
            await MapNavigationUtil.gotoBaiduMap("104.07721","30.6555");
          }),

          ElevatedButton(child: const Text("退出登录"),onPressed: () async {
            SharedPreferencesDao.removeUserInfo();
            SharedPreferencesDao.removeId();
            SharedPreferencesDao.removeUsername();
            SharedPreferencesDao.removePassword();
            SharedPreferencesDao.removeToken();
            Get.offAndToNamed(YFRouter.login);
          }),
        ],
      ),
    );
  }
}
