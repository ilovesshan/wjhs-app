import 'dart:async';
import 'dart:io';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

/// 基于webview_flutter插件
class WebviewPage extends StatefulWidget {
  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  late WebViewController _webViewController;
  String path = "";
  String title = "";

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }

    _controller.future.then((controller) {
      _webViewController = controller;
      Map<String, String> header = {
        "Authorization": "Bearer " + TextUtils.isValidWith("", ""),
      };
      _webViewController.loadUrl(path, headers: header);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonBar.showAppBar(title),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        onPageStarted: (String url) {
          _webViewController.evaluateJavascript(""" """);
        },
        onPageFinished: (String url) {
          _webViewController.evaluateJavascript("""  """);
        },
        javascriptChannels: {
          JavascriptChannel(name: "postMessage", onMessageReceived: (message) {})
        },
      ),
    );
  }
}
