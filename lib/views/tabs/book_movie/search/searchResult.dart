import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/model/search_last_result_model.dart';
import 'package:flutter_douban/netUtils/api.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
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
    print(ApiPath.home['bookMovieSearchLastResult'] + '&q=${widget.keyWords}');
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
            controller: _tabController,
            labelColor:Colors.black,
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: TextStyle(
              fontSize: 18
            ),
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
          ListView.builder(
            itemBuilder: (context,index){
              return SearchRowItem(
                data:_result.subjects[index],
              );
            },
            itemCount: 60,
          ),
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
    return ListView(
      children: <Widget>[
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context,index){
            return Text('data');
          },
          itemCount: _result.subjects.length,
        )
      ],
    );
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


}
