import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/netUtils/api.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/utils/utils.dart';
import 'package:flutter_douban/weiget/base_loading.dart';
import 'package:flutter_douban/weiget/custom_scroll_footer.dart';
import 'package:flutter_douban/weiget/custom_scroll_header.dart';
import 'package:flutter_douban/weiget/film_row_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ComingSoon extends StatefulWidget {
  @override
  _ComingSoonState createState() => _ComingSoonState();
}


class _ComingSoonState extends State<ComingSoon> with AutomaticKeepAliveClientMixin{

  // 保持状态
  bool get wantKeepAlive  => true;

  // 正在热映列表
  List _comingSoonList = [];
  List _dateList = [];
  List temp = [];
  // 分页
  int _start = 0;
  // 总数量
  int _total = 0;

  // 筛选
  String _sort = '';
  // 搜索类型切换
  AlignmentGeometry _alignment = Alignment.centerLeft;

  RefreshController _controller = RefreshController();

    @override
  void initState() { 
    super.initState();

    _getComingSoon();
  }

  // 获取即将上映列表数据
  _getComingSoon() async {
    try {
      Map<String,dynamic> params ={
        'start':_start,
        'sortby':_sort
      };
      Response res = await NetUtils.ajax('get',ApiPath.home['movieSoon'],params: params); 
      // 定义临时数组
      List temp = [];
      for(int i = 0 ; i < res.data['subjects'].length;i++){
        // 定义验证日期
        String validate = res.data['subjects'][i]['release_date'];

        // 如果日期列表里没有该日期，则添加该日期和空list待用
        if(_dateList.indexOf("$validate") == -1){
          _dateList.add(validate);
          temp.add({
            "date":validate,
            "list":[]
          });
        }else{
          // 如果有，循环旧数据列表，填充到对应日期的list中
          _comingSoonList.forEach((item){
            if(item['date'] == validate){
              item['list'].add(res.data['subjects'][i]);
            }
          });
        }
      }
      // 循环,拼接数据
      res.data['subjects'].forEach((value){
        temp.forEach((tempItem){ 
          if(tempItem['date'] == value['release_date']){
            tempItem['list'].add(value);
          }
        });
      });
      
      if(mounted){
        setState(() {
          if(_start == 0 ){
            _comingSoonList = []; 
          }
          _comingSoonList.addAll(temp); 
          _total = res.data['total'];
        });
      }
    }
    catch (e) {
      print(e);
      setState(() {
      });
    }

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  
    @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _controller,
      enablePullUp: true,
      enablePullDown: true,
      header: CustomScrollHeader(),
      footer: CustomScrollFooter(),
      onRefresh: () async {
        _controller.resetNoData();
        setState(() {
          _dateList=[];
          _start = 0;
        });
        await _getComingSoon();
        _controller.refreshCompleted();
      },
      onLoading: () async {
        if(_start + 10 < _total){
          setState(() {
            _start = _start + 10;
          });
          await _getComingSoon();
          _controller.loadComplete();
        }else{
          _controller.loadNoData();
        }
      },
      child:_comingSoonList.length > 0 ?  CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverHeaderDelegate(
              PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: Container(
                  color: Colors.white,
                  height: ScreenAdapter.height(120),
                  padding: EdgeInsets.only(left: ScreenAdapter.width(30),right:ScreenAdapter.width(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('影视 $_total'),
                      // 类型切换
                      _toggleBtn()
                    ],
                  ),
                ),
              )
            ),
          ),
          SliverToBoxAdapter(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                String _tempDate =  _comingSoonList[index]['date'];
                // 格式化日期
                if(_tempDate.length != 10){
                  _tempDate = _tempDate.replaceFirst('-', '年') + '月待定';
                }else{
                  _tempDate =  _tempDate.replaceRange(4, 5, '年');
                  _tempDate =  _tempDate.replaceRange(7, 8,'月');
                  _tempDate =  _tempDate+'日, 星期${Utils.formatWeek(DateTime.parse(_comingSoonList[index]['date']).weekday)}';
                }
                return Column(
                  children: <Widget>[
                    Container(
                      height: ScreenAdapter.height(70),
                      alignment: Alignment.centerLeft,
                      color: Colors.grey[200],
                      padding: EdgeInsets.only(left: ScreenAdapter.width(30)),
                      child: Text('$_tempDate',style: TextStyle(color: Colors.grey[600])),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: ScreenAdapter.width(30),right:ScreenAdapter.width(30)),
                      child: Column(
                        children:  _comingSoonList[index]['list'].map<Widget>((item){
                          return FilmRowItem(item,thumbHeight: 'smaller');
                        }).toList(),
                      ),
                    )
                  ],
                );
              },
              itemCount: _comingSoonList.length,
            ),
          )
        ],
      ):BaseLoading()
    );
  }

          
          
  // 类型切换
  _toggleBtn(){
    return Container(
      height: ScreenAdapter.height(50),
      width: ScreenAdapter.width(150),
      decoration: BoxDecoration(
        borderRadius:BorderRadius.circular(30),
        color: Colors.grey[300],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: ScreenAdapter.width(150),
            child: AnimatedAlign(
              alignment: _alignment,
              curve: Curves.ease,
              duration: Duration(milliseconds: 500),
              child: Opacity(
                opacity: 1,
                child: Container(
                  height: ScreenAdapter.height(50),
                  width: ScreenAdapter.width(80),
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(30),
                    color: Colors.white,
                    border: Border.all(
                      width: 0.5,
                      color: Colors.grey
                    )
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment:  MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  setState(() {
                    _alignment = Alignment.centerLeft; 
                    _start = 0;
                    _comingSoonList = [];
                    _sort = '';
                    _dateList = [];
                  });
                  _getComingSoon();
                },
                child: Text('时间',style: TextStyle(fontSize: 11,color:_alignment == Alignment.centerLeft ?  Colors.black: Colors.grey[500])),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    _start = 0;
                    _comingSoonList = [];
                    _dateList = [];
                    _sort = 'wish';
                    _alignment = Alignment.centerRight; 
                  });
                  _getComingSoon();
                },
                child: Text('热度',style: TextStyle(fontSize: 11,color:_alignment == Alignment.centerRight ?  Colors.black: Colors.grey[500])),
              ),
            ],
          ),
        ],
      ),
    );
  }
 
}


class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final widget;
  final Color color;

  const SliverHeaderDelegate(this.widget, {this.color})
      : assert(widget != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: widget,
      color: color,
    );
  }

  @override
  bool shouldRebuild(SliverHeaderDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => widget.preferredSize.height;

  @override
  double get minExtent => widget.preferredSize.height;
}
