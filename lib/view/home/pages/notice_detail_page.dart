import 'package:app/model/notice_model.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoticeDetailPage extends StatefulWidget {
  const NoticeDetailPage({Key? key}) : super(key: key);
  @override
  State<NoticeDetailPage> createState() => _NoticeDetailPageState();
}

class _NoticeDetailPageState extends State<NoticeDetailPage> {
  NoticeModel notice = Get.arguments["notice"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar.show("${notice.title}"),
      body: Padding(padding: EdgeInsets.all(10.w), child: Text("${notice.subTitle}")),
    );
  }
}
