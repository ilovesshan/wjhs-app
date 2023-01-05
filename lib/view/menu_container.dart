import 'package:app/service/app_check_update_service.dart';
import 'package:app/utils/x_update_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:common_utils/common_utils.dart';
import 'package:app/view/home/home_page.dart';
import 'package:app/view/order/order_page.dart';
import 'package:app/view/profile/profile_page.dart';
import 'package:app/view/category/category_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xupdate/flutter_xupdate.dart';
import 'package:flutter_xupdate/update_entity.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
    _tabController = TabController(vsync: this, length: _pageList.length);

    // 检查APP更新
    Future.delayed(const Duration(milliseconds: 1000),() async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
      printLog(StackTrace.current, "appName = $appName");
      printLog(StackTrace.current, "packageName = $packageName");
      printLog(StackTrace.current, "version = $version");
      printLog(StackTrace.current, "buildNumber = $buildNumber");

      final UpdateEntity updateEntity = await AppCheckUpdateService.check(version);
      ///App更新
      FlutterXUpdate.updateByInfo(updateEntity: XupdateUtil.customParseJson(updateEntity));
    });
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
