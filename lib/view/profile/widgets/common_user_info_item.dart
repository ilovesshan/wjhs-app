import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';

class CommonUserInfoItem {
  static Container buildUserInfoItem(String title, Widget valueWidget) {
    return Container(
      width: Get.width, height: 50.h, decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFf4f4f4)))),
      child: Row(
        children: [
          SizedBox(width: 100.w, child: Text("$title：", style: TextStyle(color: const Color(0xFF55555c), fontSize: 12.sp))),
          Expanded(child: Container(alignment:Alignment.centerRight, child: valueWidget))
        ],
      ),
    );
  }
}