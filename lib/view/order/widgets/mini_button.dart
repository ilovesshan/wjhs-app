import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:common_utils/common_utils.dart';

class MiniButton extends StatelessWidget {
  String text;
  OnPressed onPressed;
  Color color;
  IconData icon;
  MiniButton({ required this.text, required this.color, required this.icon,  required this.onPressed,  Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h), alignment: Alignment.center,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2.r)),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xffffffff), size: 12),
            SizedBox(width: 3.w),
            Text(text,style: TextStyle(fontSize: 10.sp, color: const Color(0xffffffff)))
          ],
        ),
      ),
      onTap: ()=> onPressed(),
    );
  }
}
