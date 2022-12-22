import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';

class CommonRow extends StatelessWidget {
  String title;
  String value;
  CommonRow({required this.title, required this.value,  Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title +"：", style: TextStyle(fontSize: 12.sp)),
        Expanded(child: Text(TextUtils.isValidWith(value, ""), style: TextStyle(fontSize: 12.sp))),
      ]
    );
  }
}