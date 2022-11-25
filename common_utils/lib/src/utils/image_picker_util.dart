import 'package:common_utils/common_utils.dart';
import 'package:common_utils/src/utils/permission_util.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerUtil {
  /// 图片选择 单选
  static Future<String> pick({bool isCamera = true}) async {
    var path = "";

    try {
      PickedFile? image = await ImagePicker.platform.pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
      if (image != null && image.path.isNotEmpty) {
        path = image.path;
      }else{
        EasyLoading.showToast("取消");
      }
    } catch (e) {
      if(e is PlatformException){
        if( e.code == "camera_access_denied"){
          /// 相机权限被拒绝了
          PermissionUtils.requestCameraPermission();
        }else{
          printLog(StackTrace.current, e.toString());
          EasyLoading.showToast("取消");
        }
      }else{
        printLog(StackTrace.current, e.toString());
        EasyLoading.showToast("取消");
      }
    }
    return path;
  }

  /// 图片选择 多选
  static Future<List<String>> pickMulti() async {
    final List<String> pathList = [];

    try {
      List<PickedFile>? list = await ImagePicker.platform.pickMultiImage();
      if (list != null && list.isNotEmpty) {
        list.forEach((item) => pathList.add(item.path));
      }else{
        EasyLoading.showToast("取消");
      }
    } catch (e) {
      printLog(StackTrace.current, e.toString());
      EasyLoading.showToast("取消");
    }
    return pathList;
  }
}
