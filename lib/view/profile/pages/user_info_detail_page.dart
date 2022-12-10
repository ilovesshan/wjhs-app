import 'package:app/utils/cache.dart';
import 'package:app/utils/system_dict_util.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInfoDetailPage extends StatefulWidget {
  const UserInfoDetailPage({Key? key}) : super(key: key);

  @override
  State<UserInfoDetailPage> createState() => _UserInfoDetailPageState();
}

class _UserInfoDetailPageState extends State<UserInfoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar.showWidthPrimaryTheme("个人信息"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Column(
          children: [
            buildUserInfoItem("用户名", Text("${Cache.getUserInfo().username}")),
            buildUserInfoItem("昵称", Text("${Cache.getUserInfo().nickName}")),
            buildUserInfoItem("头像",  ClipRRect(borderRadius: BorderRadius.circular(35.r),
                child:
                (Cache.getUserInfo().attachment!=null && Cache.getUserInfo().attachment!.url!=null)
                    ? Image.network(HttpHelperConfig.serviceList[HttpHelperConfig.selectIndex]+"${Cache.getUserInfo().attachment!.url}", width: 35.w, height: 35.w, fit: BoxFit.fitHeight)
                    : Image.asset("assets/images/app_logo/app-logo.png", width: 35.w, height: 35.w,fit: BoxFit.fitHeight)
            ),),
            buildUserInfoItem("性别", Row(
              children: [
                BrnRadioButton(
                  radioIndex: 20,
                  isSelected: SystemDictUtil.getTextByCode("${Cache.getUserInfo().gender}") == "男",
                  child: const Padding(padding: EdgeInsets.only(left: 5), child: Text("男")),
                  onValueChangedAtIndex: (index, value) {
                     printLog(StackTrace.current, value);
                     printLog(StackTrace.current, index);
                  },
                ),
                BrnRadioButton(
                  radioIndex: 21,
                  isSelected: SystemDictUtil.getTextByCode("${Cache.getUserInfo().gender}") == "女",
                  child: const Padding(padding: EdgeInsets.only(left: 5), child: Text("女")),
                  onValueChangedAtIndex: (index, value) {
                    printLog(StackTrace.current, value);
                    printLog(StackTrace.current, index);
                  },
                ),
              ],
            )),
            buildUserInfoItem("手机号", Text("${Cache.getUserInfo().phone}")),
          ],
        ),
      )
    );
  }

  Container buildUserInfoItem(String title, Widget valueWidget) {
    return Container(
      width: Get.width, height: 50.h, decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFFf4f4f4)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 100.w, child: Text("$title：", style: const TextStyle(color: Color(0xFF55555c)))),
          valueWidget
        ],
      ),
    );
  }
}
