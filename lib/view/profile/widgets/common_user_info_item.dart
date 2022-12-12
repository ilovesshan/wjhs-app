import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';

class CommonUserInfoItem {
  static Container buildUserInfoItem(String title, Widget valueWidget) {
    return Container(
      width: Get.width, height: 50.h, decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFf4f4f4)))),
      child: Row(
        children: [
          SizedBox(width: 100.w, child: Text("$title：", style: const TextStyle(color: Color(0xFF55555c)))),
          Expanded(child: Container(alignment:Alignment.centerRight, child: valueWidget))
        ],
      ),
    );
  }
}