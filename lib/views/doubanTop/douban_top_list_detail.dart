import 'package:flutter/material.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/weiget/base_loading.dart';
import 'package:flutter_douban/weiget/film_row_item.dart';

class DoubanTopListDetail extends StatefulWidget {

   // 列表数据
  final Map data;
  // 过滤列表数据
  List filterList = [];
  // 当前过滤条件索引
  int currentFilterCondition = 0;
  // 回调函数用于筛选过滤
  Function cb;
  // 筛选描述文字
  String filterDescChar = '';
  // 底部描述类型
  String footerFieldType;

  DoubanTopListDetail({
      this.footerFieldType = 'evaluate', 
      @required this.filterDescChar,
      @required this.filterList,
      @required this.data,
      @required this.currentFilterCondition,
      @required this.cb
  });

  @override
  _DoubanTopListDetailState createState() => _DoubanTopListDetailState();
}

class _DoubanTopListDetailState extends State<DoubanTopListDetail> {

   // 控制滚动
  ScrollController _innerControll =  ScrollController();
  ScrollController _otherControll =  ScrollController();

  
  // 是否展开
  bool _isExpand = true;

  @override
  void initState() { 
    super.initState();
    if(mounted){
      // 监听滚动 控制标题栏样式
      _otherControll.addListener((){
        setState(() {
          _isExpand = _otherControll.offset > 140 ? false:true;
        });
      });

      // 如果是筛选top 锚点跳转就进行控制
      double start = 0;
      _innerControll.addListener(() {
        if ((_innerControll.offset - start).abs() > 3) {
          _otherControll.jumpTo(_innerControll.offset);
          start = _innerControll.offset;
        }
      });
    }
  }

  @override
  void dispose() { 
    _innerControll.dispose();
    _otherControll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.data != null ? NestedScrollView(
        controller: _otherControll,
        headerSliverBuilder: (context,isScroll){  
          return [
            SliverAppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(
                color:_isExpand ? Colors.white: Colors.black
              ),
              brightness: Brightness.light,
              elevation: 0,
              pinned: true,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                title: AnimatedDefaultTextStyle(
                  duration: Duration(seconds:1),
                  style: TextStyle(color: _isExpand ? Colors.white:Colors.black,fontSize: 20),
                  child: Text('${widget.data['subject_collection']['name']}'),
                ),
                background: Container(
                  child: Stack(
                    children: <Widget>[
                      Opacity(
                        opacity: 0.7,
                        child: Image.network('${widget.data['subject_collection']['header_bg_image']}',width: ScreenAdapter.getScreenWidth(),fit: BoxFit.cover,height: 200 +  MediaQuery.of(context).padding.top),
                      ),
                      Positioned(
                        top: 100,
                        left: 30,
                        child: Text('${widget.data['subject_collection']['description']}',style: TextStyle(color: Colors.white,fontSize: 15)),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverBarDelegate(
                PreferredSize(
                  preferredSize: Size.fromHeight(ScreenAdapter.height(80)),
                  child:_headActions()
                ),
              ),
            ),
          ];
        },
        body:CustomScrollView(
          controller: _innerControll,
          slivers: <Widget>[
            SliverFixedExtentList(
              itemExtent: ScreenAdapter.height(500),
              delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                  return  Column(
                    children: <Widget>[
                      // 头部排名
                      Container(
                        margin: EdgeInsets.only(left:ScreenAdapter.width(30),right:ScreenAdapter.width(30),top: ScreenAdapter.height(30)),
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.only(left: 10,right: 10,top: 3,bottom: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: index == 0 ? Color.fromRGBO(225, 102, 119, 1):index == 1 ? Colors.orange :index == 2 ?  Color.fromRGBO(255, 193, 93, 1):Color.fromRGBO(209, 206, 201, 1)
                          ),
                          child: Text('No.${index+1}',style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      // 具体内容
                      Container(
                        margin: EdgeInsets.only(left: ScreenAdapter.width(30),right: ScreenAdapter.width(30)),
                        child:FilmRowItem(widget.data['subject_collection_items'][index],dataType: 2),
                      ) ,
                      // 底部描述
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Color.fromRGBO(243, 243, 243, 1),
                        ),
                        height: ScreenAdapter.height(60),
                        padding: EdgeInsets.only(left: ScreenAdapter.width(15)),
                        margin: EdgeInsets.only(left:ScreenAdapter.width(30),right:ScreenAdapter.width(30),bottom: ScreenAdapter.height(30)),
                        alignment: Alignment.centerLeft,
                        child: Text(_footerDesc(widget.data['subject_collection_items'][index]),style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5),fontSize: 12)),
                      ),
                      Container(
                        height: ScreenAdapter.height(20),
                        color: Color.fromRGBO(235, 235, 235, 1),
                      )
                    ],
                  );
                },
                childCount: widget.data['subject_collection_items'].length,
              ),
            ),
          ],
        )
      ):Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[300],
          brightness: Brightness.light,
          iconTheme: IconThemeData(
            color: Colors.black
          )
        ),
        body: BaseLoading(),
      )
    ); 
  }

  // 头部操作
  Widget _headActions(){
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      height: ScreenAdapter.height(100),
      padding: EdgeInsets.only(left:ScreenAdapter.width(30),right:ScreenAdapter.width(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('片单列表 · 共${widget.data['total']}部'),
          Container(
            padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey
              ),
              borderRadius: BorderRadius.circular(11)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('${widget.filterDescChar}',style: TextStyle(fontSize: 11)),
                SizedBox(width: ScreenAdapter.width(8)),
                Text('${widget.filterList.length > 0 ? widget.filterList[widget.currentFilterCondition]:''}',style: TextStyle(fontSize: 11))
              ],
            ),
          ),
          GestureDetector(
            onTap:(){
              _timeFilter();
            },
            child: Row(
              crossAxisAlignment:CrossAxisAlignment.end,
              children: <Widget>[
                Image.network('http://cdn.jahnli.cn/filter.png',width: ScreenAdapter.width(30)),
                Text('筛选',style: TextStyle(fontSize: 14))
              ],  
            ),
          )
        ]
      ),
    );
  }
  // 时间筛选
  _timeFilter(){
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        )
      ),
      context:context, 
      builder: (context) {
        return StatefulBuilder(
          builder: (context,state){
            return Container(
              height: 300,
              padding: EdgeInsets.fromLTRB(ScreenAdapter.width(30),0,ScreenAdapter.width(30),0),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.black26,
                    ),
                    alignment: Alignment.center,
                    margin:EdgeInsets.only(top:ScreenAdapter.height(16),bottom:ScreenAdapter.height(40)),
                    width: ScreenAdapter.width(60),
                    height: ScreenAdapter.width(8),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin:EdgeInsets.only(bottom:ScreenAdapter.height(20)),
                    child: Text('${DateTime.now().year}',style: TextStyle(fontSize: 18)),
                  ),
                  Container(
                    width: double.infinity,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //横轴元素个数
                        crossAxisCount: 4,
                        //纵轴间距
                        mainAxisSpacing: 8,
                        //横轴间距
                        crossAxisSpacing: 10.0,
                        //子组件宽高长度比例
                        childAspectRatio: 2.7 / 1
                      ),
                      itemBuilder: (context,index){
                        return GestureDetector(
                          onTap:(){
                            state(() {
                              widget.cb(index);
                            });
                            Navigator.pop(context);
                            if(widget.footerFieldType == 'desc'){
                              _innerControll.animateTo(double.parse((ScreenAdapter.height(460)*index*49.5).toString()),duration: Duration(milliseconds: 800),curve: Curves.linear);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color:widget.currentFilterCondition == index ? Color.fromRGBO(66, 189, 86, 1):Colors.grey[200],
                            ),
                            alignment: Alignment.center,
                            padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                            // :
                            child: Text('${widget.filterList[index]}',style: TextStyle(fontSize: 12,color:widget.currentFilterCondition == index ? Colors.white:Colors.black)),
                          ),
                        );
                      },  
                      itemCount: widget.filterList.length,
                    )
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
  // 底部描述
  _footerDesc(item){
    switch (widget.footerFieldType) {
      case 'evaluate':
        return '${item['rating']['count']}评价';
        break;
      case 'desc':
        return '${item['description']}';
        break;
      default:
    }
  }

}


class SliverBarDelegate extends SliverPersistentHeaderDelegate {
  final  widget;

  SliverBarDelegate(this.widget);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: widget,
    );
  }

  @override
  //如果传递的这几个参数变化了，那就重写创建
  bool shouldRebuild(SliverBarDelegate oldDelegate) {
    return true;
  }

  @override
  double get maxExtent => widget.preferredSize.height;

  @override
  double get minExtent => widget.preferredSize.height;
}
