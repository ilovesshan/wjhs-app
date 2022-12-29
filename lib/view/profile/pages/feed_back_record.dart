import 'package:app/model/feedback_record_view_model.dart';
import 'package:app/router/router.dart';
import 'package:app/utils/system_dict_util.dart';
import 'package:app/view_model/feedback_record_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/widget/common_bottom_button.dart';
import 'package:common_utils/common_utils.dart';

class FeedBackRecordPage extends StatefulWidget {
  const FeedBackRecordPage({Key? key}) : super(key: key);

  @override
  State<FeedBackRecordPage> createState() => _FeedBackRecordPageState();
}

class _FeedBackRecordPageState extends State<FeedBackRecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar.show("用户反馈"),
      body: BaseView<FeedbackRecordViewModel>(
        mode: FeedbackRecordViewModel(),
        onReady: (model){
          model.initData();
        },
        child: const SizedBox(),
        builder: (BuildContext context, FeedbackRecordViewModel vm, Widget? child) {
          if(vm.viewState == ViewState.LOADING) return ViewLoader.loadingWidget();
          if(vm.viewState == ViewState.EEMPTY) return ViewLoader.emptyWidget();
          if(vm.viewState == ViewState.ERROR) return ViewLoader.errorWidget(vm);
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: List.generate(vm.mode.length, (index){
                      final FeedbackRecordModel feedbackRecordModel = vm.mode[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 5.h), padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h), width: Get.width, decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Color(0xffefefef))),  color: Colors.white,
                      ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              SizedBox(width:280.sp, child: Text("${feedbackRecordModel.feedbackTitle}", style: TextStyle(fontSize: 12.sp))),
                              Expanded(child: BrnTagCustom( backgroundColor: feedbackRecordModel.isSolve == '38' ? Get.theme.primaryColor : const Color(0xffff6c37), tagText: feedbackRecordModel.isSolve == '38' ? '已处理' : '待处理'))
                            ]),
                            SizedBox(height: 5.h),
                            !TextUtils.isValid("${feedbackRecordModel.feedbackDetail}")
                              ? Text("${feedbackRecordModel.feedbackDetail}", style: TextStyle(color: const Color(0xffa1a2a3), fontSize: 10.sp))
                              : const SizedBox(),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20.h),
                  child: CommonBottomButtonWidget(text: "新增反馈", color: Get.theme.primaryColor, onPressed: (){
                    Get.toNamed(YFRouter.feedBack)!.then((value) => vm.initData());
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
