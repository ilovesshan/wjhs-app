import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';

/// 通用页面底部操作按钮
class CommonBottomButtonWidget extends StatelessWidget {
  OnPressed onPressed;
  Color color;
  String text;
  CommonBottomButtonWidget({required this.text, required this.color, required this.onPressed,  Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 39.h,alignment: Alignment.center,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20.r)),
        child: Text(text, style: TextStyle(fontSize: 12.sp, color: const Color(0xffffffff))),
      ),
      onTap: () => onPressed()
    );
  }
}
