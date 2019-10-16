import 'package:flutter_screenutil/flutter_screenutil.dart';

// 屏幕适配类

class ScreenAdapter {

  // 初始化
  static init (context){
    //假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
  }

  // 设置宽度
  static width (double val){
    return ScreenUtil.getInstance().setWidth(val);
  }

  // 设置高度
  static height (double val){
    return ScreenUtil.getInstance().setHeight(val);
  }

   // 获取设备高度 - DP
  static getScreenHeight(){
    return ScreenUtil.screenHeightDp;
  }
  // 获取设备宽度 - DP
  static getScreenWidth(){
    return ScreenUtil.screenWidthDp;
  }

}
