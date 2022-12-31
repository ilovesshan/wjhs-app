import 'package:app/utils/system_dict_util.dart';
import 'package:app/view/order/widgets/recycle_center_done.dart';
import 'package:app/view/order/widgets/recycle_center_in_progress.dart';
import 'package:app/view/order/widgets/user_order.dart';
import 'package:app/view/order/widgets/mission_hall.dart';
import 'package:app/view/order/widgets/inventory_order.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with SingleTickerProviderStateMixin {

  List<Widget> _pages = [const MissionHall(), const userOrder(), const InventoryOrder()];

  List<Widget> _tabs = [
    Padding(padding: EdgeInsets.all(5.w), child: const Text("任务大厅")),
    Padding(padding: EdgeInsets.all(5.w), child: const Text("用户订单")),
    Padding(padding: EdgeInsets.all(5.w), child: const Text("库存订单")),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    if(SystemDictUtil.isRecyclingCenterUser()){
      _pages = [const RecycleCenterInProgress(), const RecycleCenterDone()];
      _tabs = [
        Padding(padding: EdgeInsets.all(5.w), child: const Text("进行中")),
        Padding(padding: EdgeInsets.all(5.w), child: const Text("已完成")),
      ];
    }

    _tabController = TabController(length: _pages.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0, toolbarHeight: 0, systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
        bottom: TabBar(controller: _tabController, tabs:_tabs),
      ),
      body: TabBarView(controller: _tabController, children: _pages),
    );
  }
}