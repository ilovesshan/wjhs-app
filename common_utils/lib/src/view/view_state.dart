import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../view_model/base_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 页面状态
enum ViewState {
  LOADING,
  SUCCESS,
  EEMPTY,
  ERROR,
}

class ViewLoader {
  /// 加载中
  static Widget loadingWidget() {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox( width: 30.w, height: 30.w,child: const CircularProgressIndicator(strokeWidth: 1,)),
          SizedBox(height: 20.h),
          Text("正在加载中...", style: TextStyle(fontSize: 12.sp, color: const Color(0xFF666666))),
        ],
      ),
    );
  }

  /// 数据为空
  static Widget emptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Image.asset("assets/common/empty-data.png", width: 150.w, height: 150.h),
          Text("数据一片空白...", style: TextStyle(fontSize: 12.sp, color: const Color(0xFF666666))),
        ],
      )
    );
  }

  /// 加载失败
  static Widget errorWidget(BaseViewModel vm) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: GestureDetector(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/common/loaderror.png", width: 100.w, height: 100.w),
            SizedBox(height: 5.h),
            Text("加载失败，轻触重试", style: TextStyle(fontSize: 12.sp, color: const Color(0xFF666666))),
          ],
        ),
        onTap: (){
          vm.retry();
        },
      ),
    );
  }
}
