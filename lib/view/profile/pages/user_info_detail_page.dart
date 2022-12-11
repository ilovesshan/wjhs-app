import 'dart:convert';

import 'package:app/api/apis.dart';
import 'package:app/model/user_info_model.dart';
import 'package:app/service/user_service.dart';
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

  final List<CommonBottomSheetResultModel> _pickerOptions = [
    CommonBottomSheetResultModel(name: "拍照上传", value: "0"),
    CommonBottomSheetResultModel(name: "相册选取", value: "1"),
    CommonBottomSheetResultModel(name: "取消", value: "2")
  ];

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _gender =Cache.getUserInfo().gender!;
  String _attachmentId = "";
  String _avatarUrl = "";

  @override
  void initState() {
    super.initState();
    _usernameController.text = Cache.getUserInfo().username!;
    _nickNameController.text = Cache.getUserInfo().nickName!;
    _phoneController.text = Cache.getUserInfo().phone!;
    _avatarUrl = ((Cache.getUserInfo().attachment !=null && Cache.getUserInfo().attachment!.url !=null) ?  Cache.getUserInfo().attachment!.url : "")!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar.showWidthPrimaryTheme("个人信息"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Column(children: [ buildUserInfoItem("用户名", TextField(
             textAlign: TextAlign.end,
             controller: _usernameController,
             decoration: InputDecoration(hintText: "请输入用户名", hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey), border: InputBorder.none,),
           )),
             buildUserInfoItem("昵称", TextField(
               textAlign: TextAlign.end,
               controller: _nickNameController,
               decoration: InputDecoration(hintText: "请输入昵称", hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey), border: InputBorder.none,),
             )),
             buildUserInfoItem("头像",buildUserAvatar(),
             ),
             buildUserInfoItem("性别", Row(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 BrnRadioButton(
                   radioIndex: 20,
                   isSelected: _gender == "20",
                   child: const Padding(padding: EdgeInsets.only(left: 5), child: Text("男")),
                   onValueChangedAtIndex: (index, value) {
                     _gender = index.toString();
                     setState(() {});
                   },
                 ),
                 BrnRadioButton(
                   radioIndex: 21,
                   isSelected:  _gender == "21",
                   child: const Padding(padding: EdgeInsets.only(left: 5), child: Text("女")),
                   onValueChangedAtIndex: (index, value) {
                     _gender = index.toString();
                     setState(() {});
                   },
                 ),
               ],
             )),
             buildUserInfoItem("手机号", TextField(
               textAlign: TextAlign.end,
               controller: _phoneController,
               decoration: InputDecoration(hintText: "请输入手机号", hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey), border: InputBorder.none,),
             )),],
           ),
            Container(margin: EdgeInsets.only(bottom: 30.h), child: BrnBigMainButton(
                title: '更新', bgColor:Get.theme.primaryColor,
                onTap: () async {
                  final Map<String,String> submitData = {
                    "id": "${Cache.getUserInfo().id}",
                    "userType":"${Cache.getUserInfo().userType}",
                    "username": _usernameController.text,
                    "nickName": _nickNameController.text,
                    "phone": _phoneController.text,
                    "gender": _gender,
                    "attachmentId":_attachmentId,
                  };
                  final updateResult = await UserService.updateUserInfo(submitData);
                  if(updateResult["code"] == 200){
                    final UserInfoModel userInfoModel = await UserService.requestUserInfo("${Cache.getUserInfo().id}");
                    // 持久化信息
                    Cache.saveUserInfo(userInfoModel);
                    EasyLoading.showToast(updateResult["message"]);
                  } else {
                    EasyLoading.showToast(updateResult["message"]);
                  }
                },
              ),
            ),
          ],
        ),
      )
    );
  }

  // 头像上传Widget
  Widget buildUserAvatar() {
    return GestureDetector(
      child: ClipRRect(borderRadius: BorderRadius.circular(35.r),
         child:
         (TextUtils.isNotValid(_avatarUrl))
             ? Image.network(HttpHelperConfig.serviceList[HttpHelperConfig.selectIndex]+_avatarUrl, width: 35.w, height: 35.w, fit: BoxFit.fill)
             : Image.asset("assets/images/app_logo/app-logo.png", width: 35.w, height: 35.w,fit: BoxFit.fill)
      ),
      onTap: () async {

        CommonBottomSheetSelector.show(data: _pickerOptions, onResult: ((index) async {
          if(index ==2){
            return;
          }else{
            final path = await ImagePickerUtil.pick(isCamera: index == 0);
            if(TextUtils.isNotValid(path)){
              final uploadResult = await FileUploadUtil.uploadSingle(uploadPath: Apis.attachment, filePath: path);
              if(uploadResult["code"] ==200 && uploadResult["data"]!=null ){
                _attachmentId =  uploadResult["data"]["id"];
                _avatarUrl =  uploadResult["data"]["url"];
                setState(() {});
              }
            }
          }
        }));
      },
    );
  }

  // 用户信息项Widget
  Container buildUserInfoItem(String title, Widget valueWidget) {
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
