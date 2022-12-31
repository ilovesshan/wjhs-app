import 'package:app/utils/cache.dart';
import 'package:app/utils/system_dict_util.dart';
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
    // if(SystemDictUtil.isRecyclingCenterUser()){
    //   // 回收中心用户没有订单列表权限
    //   _pageList.removeAt(2);
    //   _tabBarList.removeAt(2);
    //   setState(() {});
    // }
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
