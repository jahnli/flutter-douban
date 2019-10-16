
import 'package:flutter/material.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;
import 'package:flutter/widgets.dart';

class CustomScrollFooter extends StatefulWidget {
  @override
  _CustomScrollFooterState createState() => _CustomScrollFooterState();
}

class _CustomScrollFooterState extends State<CustomScrollFooter> with SingleTickerProviderStateMixin{

  GifController _gifController;

  @override
  void initState() { 
    super.initState();
    if(mounted){
      _gifController = GifController(
        vsync: this,
        value: 1,
      );
    }
  }

  @override
  void dispose() {
    _gifController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      height:ScreenAdapter.height(100),
      builder: (context,mode){
        return mode == LoadStatus.noMore ? Container(
          height:ScreenAdapter.height(100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 5),
                child: GifImage(
                  image: NetworkImage('http://cdn.jahnli.cn/douban_loading.gif'),
                  controller: _gifController,
                  height:ScreenAdapter.height(40),
                  width:ScreenAdapter.width(40),
                ),
              ),
              Text(' 已经触碰了我的底线 ！',style: TextStyle(color: Colors.grey),)
            ],
          ),
        ):Container(
          height:ScreenAdapter.height(100),
          child: Center(
            child: GifImage(
              image: NetworkImage('http://cdn.jahnli.cn/douban_loading.gif'),
              controller: _gifController,
              height:ScreenAdapter.height(40),
              width:ScreenAdapter.width(40),
            ),
          ),
        );
      },
      loadStyle: LoadStyle.ShowWhenLoading,
      onModeChange: (mode){
        if (mode == LoadStatus.loading) { _gifController.repeat( min: 0, max: 29, period: Duration(milliseconds: 500)); }
        if (mode == LoadStatus.idle || mode == LoadStatus.noMore) { 
           _gifController.value = 30;
           _gifController.animateTo(59, duration: Duration(milliseconds: 500));
        }
      },
      endLoading: () async {
        _gifController.value = 30;
        _gifController.animateTo(59, duration: Duration(milliseconds: 500));
      },
    );
  }
}