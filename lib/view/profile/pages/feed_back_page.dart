import 'package:app/api/apis.dart';
import 'package:app/service/feedback_service.dart';
import 'package:app/view/profile/widgets/common_user_info_item.dart';
import 'package:app/widget/common_bottom_button.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedBackPage extends StatefulWidget {
  const FeedBackPage({Key? key}) : super(key: key);

  @override
  State<FeedBackPage> createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {

  final TextEditingController _feedbackTitleController = TextEditingController();
  final TextEditingController _feedbackDetailController = TextEditingController();
  String _attachmentId = "";
  String _attachmentUrl = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar.show("新增反馈"),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [

                CommonUserInfoItem.buildUserInfoItem("反馈标题", TextField(
                  textAlign: TextAlign.end,
                  controller: _feedbackTitleController,
                  style: TextStyle(fontSize: 12.sp),
                  decoration: InputDecoration(hintText: "输入反馈标题", hintStyle: TextStyle(fontSize: 10.sp, color: Colors.grey), border: InputBorder.none,),
                )),

                CommonUserInfoItem.buildUserInfoItem("反馈详情", TextField(
                  textAlign: TextAlign.end,
                  maxLines:4,
                  controller: _feedbackDetailController,
                  style: TextStyle(fontSize: 12.sp),
                  decoration: InputDecoration(hintText: "输入反馈详情", hintStyle: TextStyle(fontSize: 10.sp, color: Colors.grey), border: InputBorder.none,),
                )),

                CommonUserInfoItem.buildUserInfoItem("反馈图片", buildAttachmentWidget()),

              ],
            ),

            Container(
              margin: EdgeInsets.only(bottom: 20.h),
              child: CommonBottomButtonWidget(text: "提交", color: Get.theme.primaryColor, onPressed: () async {
                final result = await FeedbackService.feedback({
                  "feedbackTitle": _feedbackTitleController.text,
                  "feedbackDetail": _feedbackDetailController.text,
                  "attachmentId": _attachmentId,
                });
                if(result){
                    BrnToast.show("感谢您的反馈，我们会尽快处理", context, duration: const Duration(milliseconds: 500));
                    Future.delayed(const Duration(milliseconds: 800), ()=> Get.back());
                }else{
                  BrnToast.show("反馈失败，请稍后再试", context);
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  // 附件上传Widget
  Widget buildAttachmentWidget() {
    return GestureDetector(
      child: ClipRRect(borderRadius: BorderRadius.circular(35.r),
          child:
          (TextUtils.isNotValid(_attachmentUrl))
              ? Image.network(HttpHelperConfig.serviceList[HttpHelperConfig.selectIndex]+_attachmentUrl, width: 35.w, height: 35.w, fit: BoxFit.fill)
              : Image.asset("assets/common/upload.png", width: 15.w, height: 15.w,fit: BoxFit.fill)
      ),
      onTap: () async {
        CommonBottomSheetSelector.show(data: FileUploadUtil.pickerOptions, onResult: ((index) async {
          if(index ==2){
            return;
          }else{
            final path = await ImagePickerUtil.pick(isCamera: index == 0);
            if(TextUtils.isNotValid(path)){
              final uploadResult = await FileUploadUtil.uploadSingle(uploadPath: Apis.attachment, filePath: path);
              if(uploadResult["code"] ==200 && uploadResult["data"]!=null ){
                _attachmentId =  uploadResult["data"]["id"];
                _attachmentUrl =  uploadResult["data"]["url"];
                setState(() {});
              }
            }
          }
        }));
      },
    );
  }
}
