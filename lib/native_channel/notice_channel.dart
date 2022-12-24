import 'package:common_utils/common_utils.dart';
import 'package:flutter/services.dart';

class NoticeChannel {

  static const String _noticeChannelName = "wjhs/noticeChannel";

  static MethodChannel? _batteryChannel;

  static void initChannels() {
    _batteryChannel = const MethodChannel(_noticeChannelName);
  }

  static void notice() async {
    try {
      await _batteryChannel!.invokeMethod("showNotice");
    } on PlatformException catch (e) {
      printLog(StackTrace.current, e);
    }
  }
}
