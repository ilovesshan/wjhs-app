import 'package:bruno/bruno.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonDialog {
  static void showConfirmDialog(BuildContext context, { required String title, required Function onConfirm, required Function onCancel, String cancelText = "取消", String confirmText = "确定"}){
    return BrnDialogManager.showConfirmDialog(context,
        themeData: BrnDialogConfig(
          titlePaddingLg: const EdgeInsets.symmetric(vertical: 8),
          titlePaddingSm: const EdgeInsets.symmetric(vertical: 8),
          titleTextStyle: BrnTextStyle(fontSize: 12),
          mainActionTextStyle: BrnTextStyle(fontSize: 10, color: Get.theme.primaryColor),
          assistActionsTextStyle: BrnTextStyle(fontSize: 10),
        ),
        title: title,
        cancel: cancelText,
        confirm: confirmText,
        onConfirm: () {
          Get.back();
          onConfirm();
        },
        onCancel : () {
          Get.back();
          onCancel();
        }
    );
  }


  static void showTipDialog(BuildContext context, {required Function onTipPressed,String label = "确定", String title = "标题", String message = "主要内容"}){
    BrnDialogManager.showSingleButtonDialog(
      context,
      themeData: BrnDialogConfig(
        titlePaddingLg: const EdgeInsets.symmetric(vertical: 8),
        titlePaddingSm: const EdgeInsets.symmetric(vertical: 8),
        titleTextStyle: BrnTextStyle(fontSize: 12),
        mainActionTextStyle: BrnTextStyle(fontSize: 10, color: Get.theme.primaryColor),
        assistActionsTextStyle: BrnTextStyle(fontSize: 10),
      ),
      barrierDismissible:false,
      label: label,
      title: title,
      messageWidget: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.centerLeft,
        child: Text(message),
      ),
      onTap: () {
        Get.back();
        onTipPressed();
      }
    );
  }

  /// 支持自定义 MessageWidget
  static void showDialogCustom(BuildContext context, { required String title, required Function onConfirm, required Function onCancel, String cancelText = "取消", String confirmText = "确定", Widget? messageWidget}){
    return BrnDialogManager.showConfirmDialog(context,
        themeData: BrnDialogConfig(
          titlePaddingLg: const EdgeInsets.symmetric(vertical: 8),
          titlePaddingSm: const EdgeInsets.symmetric(vertical: 8),
          titleTextStyle: BrnTextStyle(fontSize: 12),
          mainActionTextStyle: BrnTextStyle(fontSize: 10, color: Get.theme.primaryColor),
          assistActionsTextStyle: BrnTextStyle(fontSize: 10),
        ),
        title: title,
        cancel: cancelText,
        confirm: confirmText,
        messageWidget: messageWidget,
        onConfirm: () {
          Get.back();
          onConfirm();
        },
        onCancel : () {
          Get.back();
          onCancel();
        }
    );
  }

  static void showTipDialogCustom(BuildContext context, {required Function onTipPressed, String label = "确定",  bool barrierDismissible = true, String title = "标题",  required Widget messageWidget }){
    BrnDialogManager.showSingleButtonDialog(
        context,
        themeData: BrnDialogConfig(
          titlePaddingLg: const EdgeInsets.symmetric(vertical: 8),
          titlePaddingSm: const EdgeInsets.symmetric(vertical: 8),
          titleTextStyle: BrnTextStyle(fontSize: 14),
          mainActionTextStyle: BrnTextStyle(fontSize: 12, color: Get.theme.primaryColor),
          assistActionsTextStyle: BrnTextStyle(fontSize: 12),
        ),
        barrierDismissible: barrierDismissible,
        label: label,
        title: title,
        messageWidget: messageWidget,
        onTap: () {
          Get.back();
          onTipPressed();
        }
    );
  }
}
