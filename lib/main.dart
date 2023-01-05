import 'package:app/native_channel/notice_channel.dart';
import 'package:app/router/router.dart';
import 'package:app/utils/jpush_util.dart';
import 'package:app/utils/x_update_util.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const Application());
}

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {

  @override
  void initState() {
    super.initState();
    // 初始化 flutter和原生Android端通信通道
    NoticeChannel.initChannels();

    // 初始化 极光推送
    JPushUtil.initJPush();

    // 初始化 xupdate
    XupdateUtil.initXUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppInitialize.appTheme(),
      initialRoute: YFRouter.splash,
      getPages: YFRouter.routes(),
      debugShowCheckedModeBanner: false,
      builder: (_, c) {
        AppInitialize.setSystemUiOverlayStyle();
        AppInitialize.initScreenUtil(_);
        return FlutterEasyLoading(
          child: GestureDetector(
            child: c!,
            onTap: ()=> AppInitialize.closeKeyBord(context)
          ),
        );
      },
    );
  }
}
