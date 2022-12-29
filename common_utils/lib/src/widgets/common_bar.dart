import 'package:flutter/material.dart';
import 'package:common_utils/common_utils.dart';
import 'package:get/get.dart';

class CommonBar {

  /// 顶部appBar
  static AppBar showAppBar(String text, { List<Widget>? actions, PreferredSizeWidget? bottom}){
    return AppBar(
      title: Text(text, style: TextStyle(fontSize: 14.sp, color: const Color(0xFF222222), fontWeight: FontWeight.bold)),backgroundColor: Colors.white, centerTitle: true, elevation: 0,
      leading: GestureDetector(
        child: Container(padding: EdgeInsets.all(20.w), child: Image.asset("assets/common/nav-back-black.png")),
        onTap: ()=> Get.back(),
      ),
      actions: actions,
      bottom: bottom,
    );
  }


  /// 带小红点的tabBar Item
  static Widget buildTabBarItemWithBadge(String iconPath, int unReadCount) {
    if( unReadCount == 0){
      // 未读数量为0 不显示小红点
      return buildTabBarItem(iconPath);
    }else{
      return Badge(
        padding: EdgeInsets.all(unReadCount >= 10 ? 2.r : 5.r),
        position: BadgePosition(top: unReadCount >= 10 ? -8 : -12, start: 15),
        badgeContent:Text("$unReadCount", style: TextStyle(color: Colors.white, fontSize: unReadCount >= 10 ? 12.sp : 14.sp)),
        child: Image.asset(iconPath, width: 21.w, height: 21.w),
      );
    }
  }


  /// 普通tabBar Item
  static Widget buildTabBarItem (String iconPath) {
    return  Image.asset(iconPath, width: 21.w, height: 21.w);
  }


  /// 通用搜索框
  static Container buildCommonSearchBar({required TextEditingController controller, required bool isShowSearch , required OnValueChanged onSubmitted, required VoidCallback onCancel, OnValueChanged? onValueChanged}) {
    return Container(
        width: Get.width, height: 39.h, padding: EdgeInsets.symmetric(horizontal: 10.w), margin: EdgeInsets.only(top: 5.h),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                style: TextStyle(fontSize: 12.sp), controller: controller, textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                    hintText: "输入关键字",
                    hintStyle: TextStyle(fontSize: 12.sp),
                    contentPadding: const EdgeInsets.only(top: 0, bottom: 0),
                    enabledBorder: OutlineInputBorder(borderSide:const BorderSide(color: Color(0XFFFFFFFF), width: 0), borderRadius: BorderRadius.circular(10.r)),
                    focusedBorder: OutlineInputBorder(borderSide:const BorderSide(color: Color(0XFFFFFFFF), width: 0), borderRadius: BorderRadius.circular(10.r)),
                    filled: true, fillColor: const Color(0XFFF2F2F2), border: OutlineInputBorder(borderSide:const BorderSide(color: Color(0XFFFFFFFF), width: 0), borderRadius: BorderRadius.circular(10.r)),
                    prefixIcon: Container(padding: EdgeInsets.all(10.r), child: Image.asset("assets/common/search-black.png", width: 20.w, height: 20.w, fit: BoxFit.fitHeight))
                ),
                onSubmitted: (kw)=> onSubmitted(kw),
                onChanged: (value)=> {if(onValueChanged!=null) onValueChanged(value)},
              ),
            ),
            GestureDetector(child: Container(margin: EdgeInsets.only(left: 10.w), child: Text(!isShowSearch ? "搜索" : "取消", style: TextStyle(fontSize: 12.sp))), onTap: ()=> onCancel())
          ],
        )
    );
  }
}