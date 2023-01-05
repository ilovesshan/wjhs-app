
import 'dart:async';
import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/services.dart';

typedef OnSmsReceived = void Function(Map<String, String> payload);

class SmsReceivedListener {
  OnSmsReceived onSmsReceived;

  SmsReceivedListener({required this.onSmsReceived});
}

class SmsReceiveUtil {
  static const MethodChannel _channel = MethodChannel("wjhs/smsReceiveChannel");
  static const String _channelTag = "wjhs/smsReceiveChannel";
  static late SmsReceivedListener _smsReceivedListener;

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static init() {
    printLog(StackTrace.current, "flutter 注册回调, 开始监听短信验证码发送...");
    const MethodChannel(_channelTag).setMethodCallHandler(_platformCallHandler);
  }

  static Future<dynamic> _platformCallHandler(MethodCall call) async {
    try {
      if (_smsReceivedListener != null) {
        Map<String, String> smsMap = {
          "senderPhone": jsonDecode(call.arguments)["senderPhone"],
          "receiveMessage": jsonDecode(call.arguments)["receiveMessage"],
        };
        _smsReceivedListener.onSmsReceived(smsMap);
      }
    } catch (e) {
       printLog(StackTrace.current, e);
    }
  }

  static void setListener(SmsReceivedListener smsReceivedListener) {
    _smsReceivedListener = smsReceivedListener;
  }
}
