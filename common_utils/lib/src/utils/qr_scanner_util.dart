import 'package:barcode_scan2/model/scan_options.dart';
import 'package:barcode_scan2/platform_wrapper.dart';

typedef OnScanSuccess = void Function(dynamic data);

/// 扫码插件 工具类
class QrScannerUtil {
  static void scan({String iosCancelText ="取消", String flashOn ="打开闪光", String flashOff ="关闭闪光",  required OnScanSuccess onScanSuccess}) async {
    var options = ScanOptions(strings: {
      'cancel': iosCancelText,
      'flash_on': flashOn,
      'flash_off': flashOff,
    });
    final  result = await BarcodeScanner.scan(options: options);
    onScanSuccess(result.rawContent);
  }
}
