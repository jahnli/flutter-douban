import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/model/search_last_result_model.dart';
import 'package:flutter_douban/netUtils/api.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/utils/utils.dart';
import 'package:flutter_douban/weiget/base_components.dart';
import 'package:flutter_douban/weiget/base_loading.dart';
import 'package:flutter_douban/weiget/search/search_row.item.dart';

class BookMovieSearchResult extends StatefulWidget {

  String keyWords = '';
  BookMovieSearchResult({
    @required this.keyWords
  });
  
  @override
  _BookMovieSearchResultState createState() => _BookMovieSearchResultState();
}

class _BookMovieSearchResultState extends State<BookMovieSearchResult> with SingleTickerProviderStateMixin{

  TabController _tabController;
  BookMovieSearchLastResultModel _result;

  @override
  void initState() { 
    super.initState();
    _tabController = TabController(
      length: 5,
      vsync: this
    );
    _getResult();
  }
  // 获取最终结果
  _getResult()async{
    try {
      Response res = await NetUtils.ajax('get',ApiPath.home['bookMovieSearchLastResult'] + '&q=${widget.keyWords}');
      if(mounted){
        setState(() {
          _result = BookMovieSearchLastResultModel.fromJson(res.data); 
        });
      }
    } 
    catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerScrolled) => <Widget>[
        SliverAppBar(
          backgroundColor: Color.fromRGBO(255, 255, 255,1),
          elevation: 0,
          pinned: true,
          title: TabBar(
            isScrollable: true,
            controller: _tabController,
            labelColor:Colors.black,
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: <Widget>[
              Tab(text: '综合'),
              Tab(text: '书影音'),
              Tab(text: '小组'),
              Tab(text: '日记'),
              Tab(text: '用户')
            ],
          ),
        ),
      ],
      body:_result != null ? TabBarView(
        controller: _tabController,
        children: <Widget>[
          // 综合
          _synthesize(),
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
        ],
      ):Center(
        child: BaseLoading(),
      ),
    );
  }

  // 综合
  Widget _synthesize(){
    return Container(
      child: ListView(
        children: <Widget>[
          SizedBox(height: ScreenAdapter.height(30)),
          // 书影音
          Container(
            color: Colors.white,
            padding:EdgeInsets.only(top:ScreenAdapter.height(30),left: ScreenAdapter.width(30),right: ScreenAdapter.width(30)),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                return SearchRowItem(
                  data:_result.subjects[index],
                );
              },
              itemCount: _result.subjects.length,
            ),
          ),
          _endDesc('更多书影音搜索结果'),
          BaseComponent.septalLine(),
          // 影评
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(ScreenAdapter.width(30),ScreenAdapter.width(30),ScreenAdapter.width(30),0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                final _item = _result.reviews.items[index];
                return BaseComponent.bottomBorderContainer(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('${_item.target.title}',style: TextStyle(fontSize: ScreenAdapter.fontSize(30))),
                            SizedBox(height: ScreenAdapter.height(10)),
                            Text('${_item.target.theAbstract}',maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.grey,fontSize: ScreenAdapter.fontSize(28))),
                            SizedBox(height: ScreenAdapter.height(10)),
                            Text('${_item.target.cardSubtitle}',style: TextStyle(color: Colors.grey,fontSize: ScreenAdapter.fontSize(26))),
                          ],
                        ),
                      ),
                      SizedBox(width: ScreenAdapter.width(20)),
                      _item.target.coverUrl.isNotEmpty ? Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network('${_item.target.coverUrl}',width: ScreenAdapter.width(180),height: ScreenAdapter.height(120),fit: BoxFit.cover,),
                        ),
                      ):Container()
                    ],
                  ),
                );
              },
              itemCount: _result.reviews.items.length,
            ),
          ),
          _endDesc(_result.reviews.targetName),
          BaseComponent.septalLine(),
          // 话题
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(ScreenAdapter.width(30),ScreenAdapter.width(30),ScreenAdapter.width(30),0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                final _item = _result.contents[index];
                return BaseComponent.bottomBorderContainer(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Icon(Icons.forum,color: Color.fromRGBO(90, 187, 81, 1)),
                                SizedBox(width: ScreenAdapter.width(10)),
                                Expanded(
                                  child: Text('${_item.target.title}',style: TextStyle(fontSize: ScreenAdapter.fontSize(30))),
                                ),
                              ],
                            ),
                            SizedBox(height: ScreenAdapter.height(10)),
                            Text('${_item.target.theAbstract}',maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.grey,fontSize: ScreenAdapter.fontSize(28))),
                            SizedBox(height: ScreenAdapter.height(10)),
                            Text('${_item.target.cardSubtitle}',style: TextStyle(color: Colors.grey,fontSize: ScreenAdapter.fontSize(26))),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: _result.contents.length,
            ),
          ),
        ],
      ),
    );
  }

  // 结尾描述
  Widget _endDesc(String title){
    return Container(
      color: Colors.white,
      padding:EdgeInsets.only(bottom: ScreenAdapter.height(30),left: ScreenAdapter.width(30),right: ScreenAdapter.width(30)),
      child: Row(
        children: <Widget>[
          Text('$title',style: TextStyle(fontSize:ScreenAdapter.fontSize(30))),
          Icon(Icons.keyboard_arrow_right)
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


}
