import 'package:app/api/apis.dart';
import 'package:app/model/swiper_model.dart';
import 'package:common_utils/common_utils.dart';

class SwiperService {
  // 获取轮播图
  static Future<List<SwiperModel>> requestSwiper() async {
    List<SwiperModel> swiperModels = [];
    final result = await HttpHelper.getInstance().get(Apis.swiper +"?type=32");
    if (result["code"] == 200) {
      for (var json in result["data"]) {
        swiperModels.add(SwiperModel.fromJson(json));
      }
    }
    return swiperModels;
  }
}
