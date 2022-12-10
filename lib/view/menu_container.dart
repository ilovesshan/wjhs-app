import 'package:app/utils/cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:common_utils/common_utils.dart';
import 'package:app/view/home/home_page.dart';
import 'package:app/view/order/order_page.dart';
import 'package:app/view/profile/profile_page.dart';
import 'package:app/view/category/category_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MenuContainer extends StatefulWidget {
  const MenuContainer({Key? key}) : super(key: key);

  @override
  State<MenuContainer> createState() => _MenuContainerState();
}

class _MenuContainerState extends State<MenuContainer> with SingleTickerProviderStateMixin{

  late TabController _tabController;

  final List<Widget> _pageList = [
    const HomePage(),
    const CategoryPage(),
    const OrderPage(),
    const ProfilePage(),
  ];

  final List<Icon> _tabBarList = [
    const Icon(Icons.home_outlined, size: 16),
    const Icon(Icons.category_outlined, size: 16),
    const Icon(Icons.list_outlined, size: 16),
    const Icon(Icons.person_outline_outlined, size: 16),
  ];

  @override
  void initState() {
    super.initState();

    if(Cache.getUserInfo().userType == "3"){
      // 回收中心用户没有订单列表权限
      _pageList.removeAt(2);
      _tabBarList.removeAt(2);
      setState(() {});
    }

    ///创建 JPush
    JPush jpush = new JPush();
    ///配置应用 Key
    jpush.setup(
      appKey: "替换成你自己的 appKey",
      channel: "theChannel",
      production: false,
      /// 设置是否打印 debug 日志
      debug: true,
    );

    try {
      jpush.addEventHandler(
        onReceiveNotification: (Map<String, dynamic> message) async {
          print("flutter onReceiveNotification: $message");
        },

        onOpenNotification: (Map<String, dynamic> message) async {
          print("flutter onOpenNotification: $message");
        },

        onReceiveMessage: (Map<String, dynamic> message) async {
          print("flutter onReceiveMessage: $message");
        },

        onReceiveNotificationAuthorization: (Map<String, dynamic> message) async {
          print("flutter onReceiveNotificationAuthorization: $message");
        },

        onNotifyMessageUnShow: (Map<String, dynamic> message) async {
          print("flutter onNotifyMessageUnShow: $message");
        });
      } on PlatformException {}

    _tabController = TabController(vsync: this, length: _pageList.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Get.theme.primaryColor,
        height: 49.0,
        items: _tabBarList,
        onTap: (index) => _tabController.animateTo(index),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller:_tabController,
        children: _pageList,
      ),
    );
  }
}
