import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';

class Configs{

  // 缩略图高度

  static thumbHeight ({size:'default'}){
    switch (size) {
      // 影片详情 - 预告片
      case 'xlarge':
        return 300.0;
        break;
      // 影院热映
      case 'large':
        return 240.0;
        break;
     // 详情页
      case 'middle':
        return 220.0;
        break;
      case 'default':
        return 210.0;
        break;
      case 'small':
        return 200.0;
      // 影院热映列表和豆瓣热门列表
      case 'smaller':
        return 190.0;
        break;
      // 迷你缩略图
      case 'miniWidth':
        return 90.0;
        break;
      case 'miniHeight':
        return 160.0;
        break;
      default:
    }
  }




}