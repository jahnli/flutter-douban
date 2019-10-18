import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';

class BaseLoading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network('http://cdn.jahnli.cn/douban_loading.gif?imageslim',width: ScreenAdapter.width(60)),
    );
  }
}