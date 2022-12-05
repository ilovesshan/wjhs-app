import 'package:common_utils/common_utils.dart';
import 'package:flutter/widgets.dart';

class SwiperWidget{

  /// 构建轮播图
  static Widget build({required List<String> list, double width = 375, double height = 200, OnItemPressedWithIndex ? onItemPressed}) {
    return SizedBox(
      height: (height - 10).h, width: width.w,
      child: Swiper(
        autoplay: true, itemCount: list.length,
        pagination: const SwiperPagination(alignment: Alignment.bottomCenter, builder: SwiperPagination.dots),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: list[index].startsWith("http")
              ? FadeInImage.assetNetwork(placeholder: "assets/common/loading.png", image: list[index], width: width.w, height: height, fit: BoxFit.fill)
              : Image.asset(list[index], width: width.w, height: height, fit: BoxFit.fill),
            onTap: ()=> {if(onItemPressed!=null) onItemPressed(index)},
          );
        },
      ),
    );
  }
}