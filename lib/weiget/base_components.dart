import 'package:flutter/material.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';


class BaseComponent{

  // 灰色分割线
  static septalLine(){
    return Container(
      height: ScreenAdapter.height(20),
      color: Colors.grey[200]
    );
  }

  // 列表项分割容器
  static bottomBorderContainer({Widget child}){
    return Container(
      margin: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
      padding: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.3,
            color: Colors.grey
          )
        )
      ),
      child: child,
    );
  }

}