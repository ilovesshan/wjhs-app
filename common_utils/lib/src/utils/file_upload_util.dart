import 'package:common_utils/common_utils.dart';

/// 文件上传工具类
class FileUploadUtil {
  static final HttpHelper _httpHelper = HttpHelper.getInstance();


  /// 单文件上传
  static Future<dynamic> uploadSingle({required String filePath, required String id})  async {
    MultipartFile image = MultipartFile.fromFileSync(filePath);
    FormData formData = FormData.fromMap({"file": image});
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
    EasyLoading.show(status: "图片上传中...");
    try {
      final data = await _httpHelper.post("", params: {"orderId":id},  data: formData);
      EasyLoading.showToast("上传成功");
      Future.value(data.data);
    } catch (e) {
      EasyLoading.showToast("上传失败");
    } finally {
      EasyLoading.dismiss();
      EasyLoading.instance.maskType = EasyLoadingMaskType.none;
    }
  }



  /// 多文件上传
  static Future<dynamic> uploadMultiple({required List<String> filePathList, required String id})  async {
    FormData formData = FormData();

    for (var path in filePathList) {
      MapEntry<String,MultipartFile> mapEntry =  MapEntry("file", MultipartFile.fromFileSync(path));
      formData.files.add(mapEntry);
    }

    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
    EasyLoading.show(status: "图片上传中...");
    try {
      final data = await _httpHelper.post("", params: {"orderId":id }, data: formData);
      EasyLoading.showToast("上传成功");
      Future.value(data.data);
    } catch (e) {
      EasyLoading.showToast("上传失败");
    } finally {
      EasyLoading.dismiss();
      EasyLoading.instance.maskType = EasyLoadingMaskType.none;
    }
  }



  /// 删除文件
  static Future<dynamic> deleteFile({required String id})  async {
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
    EasyLoading.show(status: "加载中...");
    try {
      final data = await _httpHelper.delete("", params: {"id":id});
      EasyLoading.showToast("删除成功");
      Future.value(data.data);
    } catch (e) {
      EasyLoading.showToast("删除失败");
    } finally {
      EasyLoading.dismiss();
      EasyLoading.instance.maskType = EasyLoadingMaskType.none;
    }
  }
}