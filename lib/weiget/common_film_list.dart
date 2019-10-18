import 'package:flutter/material.dart';
import 'package:flutter_douban/weiget/base_loading.dart';
import 'package:flutter_douban/weiget/custom_scroll_footer.dart';
import 'package:flutter_douban/weiget/custom_scroll_header.dart';
import 'package:flutter_douban/weiget/film_row_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommonFilmList extends StatefulWidget {

  List dataList;
  Function onRefresh;
  Function onLoading;
  bool enablePullUp;
  bool enablePullDown;
  int dataType;
  Widget headWidget;
  CommonFilmList({
    @required this.dataList,
    this.onRefresh,
    this.onLoading,
    this.enablePullDown = true,
    this.enablePullUp = true,
    this.dataType = 1,
    this.headWidget
  });


  @override
  _CommonFilmListState createState() => _CommonFilmListState();
}

class _CommonFilmListState extends State<CommonFilmList> {

  RefreshController _controller = RefreshController();


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SmartRefresher(
        controller: _controller,
        enablePullUp: widget.enablePullUp,
        enablePullDown: widget.enablePullDown,
        header: CustomScrollHeader(),
        footer: CustomScrollFooter(),
        onRefresh: () async {
          _controller.resetNoData();
          await widget.onRefresh();
          _controller.refreshCompleted();
        },
        onLoading: () async {
          String res =  await widget.onLoading();
          if(res == 'ok'){
            _controller.loadComplete();
          }else{
            _controller.loadNoData();
          }
        },
        child: widget.dataList.length > 0 ? ListView(
          children: <Widget>[
            widget.headWidget != null ? widget.headWidget:Container(),
            ListView.builder(
              shrinkWrap: true, 
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                return FilmRowItem(widget.dataList[index],dataType:widget.dataType);
              },
              itemCount: widget.dataList.length,
            )
          ],
        ):BaseLoading(),
      ),
    );
  }
}