import 'package:common_utils/common_utils.dart';
import 'package:flutter/services.dart';

class JPushUtil {
  static final JPush _jPush = JPush();

  static void initJPush() {
    _jPush.setup(appKey: "ebded315f07e269dc00e5fa1", channel: "theChannel", production: false, debug: true);

    // onReceiveMessage ->  onReceiveNotification ->  onOpenNotification
    try {
      _jPush.addEventHandler(
        onReceiveNotification: (Map<String, dynamic> message) async {
          printLog(StackTrace.current, "flutter onReceiveNotification: $message");
        },

        onOpenNotification: (Map<String, dynamic> message) async {
          printLog(StackTrace.current, "flutter onOpenNotification: $message");
        },

        onReceiveMessage: (Map<String, dynamic> message) async {
          printLog(StackTrace.current, "flutter onReceiveMessage: $message");
        },

        onReceiveNotificationAuthorization: (Map<String, dynamic> message) async {
          printLog(StackTrace.current, "flutter onReceiveNotificationAuthorization: $message");
        },

        onNotifyMessageUnShow: (Map<String, dynamic> message) async {
          printLog(StackTrace.current, "flutter onNotifyMessageUnShow: $message");
        });
    } on PlatformException {
      printLog(StackTrace.current, "flutter PlatformException");
    }
  }
}