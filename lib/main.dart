import 'package:app/router/router.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

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
