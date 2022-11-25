import 'dart:io';
import 'dart:typed_data';
import 'package:common_utils/common_utils.dart';
import 'package:fluwx_no_pay/fluwx_no_pay.dart' as fluwx;

class WxUtil {
  // static bool wxIsInstalled;
  static Future init() async {
    fluwx.registerWxApi(
        appId: "wx141a10bbea0f1313",
        doOnAndroid: true,
        doOnIOS: true,
        universalLink: "你的universalLink");

  }

  static Future<bool> wxIsInstalled() async {
    return await fluwx.isWeChatInstalled;
  }



  /**
   * 分享图片到微信，
   * file=本地路径
   * url=网络地址
   * asset=内置在app的资源图片
   * scene=分享场景，1好友会话，2朋友圈，3收藏
   */
  static void ShareImage(
      {required String title,
        required String decs,
        required String file,
        required String url,
        required String asset,
        int scene = 1}) async {
    fluwx.WeChatScene wxScene = fluwx.WeChatScene.SESSION;
    if (scene == 2) {
      wxScene = fluwx.WeChatScene.TIMELINE;
    } else if (scene == 3) {
      wxScene = fluwx.WeChatScene.FAVORITE;
    }
    fluwx.WeChatShareImageModel model;

    if (file != null) {
      model = fluwx.WeChatShareImageModel(fluwx.WeChatImage.file(File(file)),
          title: title, description: decs, scene: wxScene);
    } else if (url != null) {
      model = fluwx.WeChatShareImageModel(fluwx.WeChatImage.network(url),
          title: title, description: decs, scene: wxScene);
    } else if (asset != null) {
      model = fluwx.WeChatShareImageModel(fluwx.WeChatImage.asset(asset),
          title: title, description: decs, scene: wxScene);
    } else {
      throw Exception("缺少图片资源信息");
    }
    fluwx.shareToWeChat(model);
  }

  /**
   * 分享文本
   * content=分享内容
   * scene=分享场景，1好友会话，2朋友圈，3收藏
   */
  static void ShareText(String content, {required String title, int scene = 1}) {
    fluwx.WeChatScene wxScene = fluwx.WeChatScene.SESSION;
    if (scene == 2) {
      wxScene = fluwx.WeChatScene.TIMELINE;
    } else if (scene == 3) {
      wxScene = fluwx.WeChatScene.FAVORITE;
    }
    fluwx.WeChatShareTextModel model =
    fluwx.WeChatShareTextModel(content, title: title, scene: wxScene);
    fluwx.shareToWeChat(model);
  }

  /***
   * 分享视频
   * videoUrl=视频网上地址
   * thumbFile=缩略图本地路径
   * scene=分享场景，1好友会话，2朋友圈，3收藏
   */
  static void ShareVideo(String videoUrl, {required String thumbFile, required String title, required String desc, int scene = 1}) {
    fluwx.WeChatScene wxScene = fluwx.WeChatScene.SESSION;
    if (scene == 2) {
      wxScene = fluwx.WeChatScene.TIMELINE;
    } else if (scene == 3) {
      wxScene = fluwx.WeChatScene.FAVORITE;
    }
    late fluwx.WeChatImage image;
    if (thumbFile != null) {
      image = fluwx.WeChatImage.file(File(thumbFile));
    }
    var model = fluwx.WeChatShareVideoModel(
        videoUrl: videoUrl,
        thumbnail: image,
        title: title,
        description: desc,
        scene: wxScene);
    fluwx.shareToWeChat(model);
  }

  /**
   * 分享链接
   * url=链接
   * thumbFile=缩略图本地路径
   * scene=分享场景，1好友会话，2朋友圈，3收藏
   */
  static void ShareUrl(String url,
      {required String thumbFile,
        required Uint8List thumbBytes,
        required String title,
        required String desc,
        int scene = 1,
        required String networkThumb,
        required String assetThumb}) {
    desc = desc  == "" ? "" : desc;
    title = title  == "" ? "" : title;

    if (desc.length > 54) {
      desc = desc.substring(0, 54) + "...";
    }
    if (title.length > 20) {
      title = title.substring(0, 20) + "...";
    }
    fluwx.WeChatScene wxScene = fluwx.WeChatScene.SESSION;
    if (scene == 2) {
      wxScene = fluwx.WeChatScene.TIMELINE;
    } else if (scene == 3) {
      wxScene = fluwx.WeChatScene.FAVORITE;
    }
   late fluwx.WeChatImage image ;
    if (thumbFile != null) {
      image = fluwx.WeChatImage.file(File(thumbFile));
    } else if (thumbBytes != null) {
      image = fluwx.WeChatImage.binary(thumbBytes);
    } else if (TextUtils.isNotValid(networkThumb)) {
      image = fluwx.WeChatImage.network(Uri.encodeFull(networkThumb));
    } else if (TextUtils.isNotValid(assetThumb)) {
      image = fluwx.WeChatImage.asset(assetThumb, suffix: ".png");
    }
    var model = fluwx.WeChatShareWebPageModel(
      url,
      thumbnail: image,
      title: title,
      description: desc,
      scene: wxScene,
    );
    fluwx.shareToWeChat(model);
  }
}
