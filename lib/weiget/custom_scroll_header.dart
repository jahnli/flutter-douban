import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;
import 'package:flutter/widgets.dart';

class CustomScrollHeader extends RefreshIndicator {
  CustomScrollHeader() : super(height: 60.0, refreshStyle: RefreshStyle.Follow);
  @override
  State<StatefulWidget> createState() {return CustomScrollHeaderState();}
}

class CustomScrollHeaderState extends RefreshIndicatorState<CustomScrollHeader>with SingleTickerProviderStateMixin {
  GifController _gifController;

  @override
  void initState() {
    // TODO: implement initState
    // init frame is 2
    super.initState();
    if(mounted){
      _gifController = GifController(
        vsync: this,
        value: 1,
      );
    }
  }




  @override
  void onModeChange(RefreshStatus mode) {
    // TODO: implement onModeChange
    if (mode == RefreshStatus.refreshing) {
      _gifController.repeat(
          min: 0, max: 29, period: Duration(milliseconds: 500));
    }
    super.onModeChange(mode);
  }

  @override
  Future<void> endRefresh() {
    // TODO: implement endRefresh
    _gifController.value = 30;
    return _gifController.animateTo(59, duration: Duration(milliseconds: 500));
  }

  @override
  void resetValue() {
    // TODO: implement resetValue
    // reset not ok , the plugin need to update lowwer
    _gifController.value = 0;
    super.resetValue();
  }

  @override
  Widget buildContent(BuildContext context, RefreshStatus mode) {
    return Container(
      height: ScreenAdapter.height(80),
      margin: EdgeInsets.only(top: ScreenAdapter.height(40)),
      child: Center(
        child: GifImage(
          image: NetworkImage('http://cdn.jahnli.cn/douban_loading.gif'),
          controller: _gifController,
          height:ScreenAdapter.height(40),
          width:ScreenAdapter.width(40),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _gifController.dispose();
    super.dispose();
  }
}