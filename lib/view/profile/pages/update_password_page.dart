import 'package:app/service/user_service.dart';
import 'package:app/utils/cache.dart';
import 'package:app/view/profile/widgets/common_user_info_item.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({Key? key}) : super(key: key);

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}


class _UpdatePasswordPageState extends State<UpdatePasswordPage> {

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar.show("修改密码"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 表单项
            Column(
              children: [
                CommonUserInfoItem.buildUserInfoItem("旧密码", TextField(
                  textAlign: TextAlign.end,
                  controller: _oldPasswordController,
                  style: TextStyle(fontSize: 14.sp),
                  decoration: InputDecoration(hintText: "输入旧密码", hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey), border: InputBorder.none,),
                )),

                CommonUserInfoItem.buildUserInfoItem("新密码", TextField(
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 14.sp),
                  controller: _newPasswordController,
                  decoration: InputDecoration(hintText: "输入新密码", hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey), border: InputBorder.none,),
                )),

                CommonUserInfoItem.buildUserInfoItem("确认密码", TextField(
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 14.sp),
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(hintText: "输入确认密码", hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey), border: InputBorder.none,),
                )),
              ],
            ),

            // 更新按钮
            GestureDetector(
              child: Container(
                width: Get.width,height: 49.h, margin: EdgeInsets.only(bottom: 30.h), alignment: Alignment.center,
                decoration: BoxDecoration(color: Get.theme.primaryColor, borderRadius: BorderRadius.circular(6.r)),
                child: const Text('更新', style: TextStyle(color:Color(0xFFFFFFFF))),
              ),
              onTap: () async {
                final String _oldPassword = _oldPasswordController.text;
                final String _newPassword = _newPasswordController.text;
                final String _confirmPassword = _confirmPasswordController.text;
                if(TextUtils.isValid(_oldPassword) || TextUtils.isValid(_newPassword) || TextUtils.isValid(_confirmPassword)){
                  BrnToast.show("表单项未填写完", context);
                  return;
                }
                if(_newPassword != _confirmPassword){
                  BrnToast.show("两次密码输入不一致", context);
                  return;
                }

                final Map<String, String> requestData = {
                  "id": CommonCache.getId(),
                  "oldPassword": _oldPassword,
                  "newPassword": _newPassword,
                };

                final updateResult = await  UserService.updatePassword(requestData);
                if(updateResult["code"] == 200){
                  EasyLoading.showToast("更新成功，即将跳转登录页");
                  Future.delayed(const Duration(seconds: 2), ()=> UserService.logout());
                }else{
                  EasyLoading.showToast(updateResult["message"]);
                }
              },
            ),
          ],
        ),
      )
    );
  }
}
