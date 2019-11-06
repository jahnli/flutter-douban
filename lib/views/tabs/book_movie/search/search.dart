import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/model/book_movie_search_model.dart';
import 'package:flutter_douban/netUtils/api.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/utils/configs.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/weiget/base_loading.dart';

class BookMovieSearch extends StatefulWidget {
  
  String searchText;
  
  BookMovieSearch({this.searchText});

  @override
  _BookMovieSearchState createState() => _BookMovieSearchState();
}

class _BookMovieSearchState extends State<BookMovieSearch> {

  // 当前搜索文字
  String _currentSearchText;
  // 搜索结果
  BookMovieSearchModel _searchResult;

  @override
  void initState() { 
    super.initState();
  }
  // 获取搜索结果
  _getSeachResult() async{
    try {
      Response res = await NetUtils.ajax('get','${ApiPath.home['bookMovieSearchResult']}&q=$_currentSearchText');
      setState(() {
        _searchResult = BookMovieSearchModel.fromJson(res.data); 
      });
    } 
    catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(ScreenAdapter.height(80)),
        child:Container(
          padding: EdgeInsets.only(left: ScreenAdapter.width(30),right: ScreenAdapter.width(30)),
          margin:EdgeInsets.only(top:ScreenAdapter.height(30)),
          child:  _appBar(),
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.5,
              color: Colors.grey[300]
            )
          ),
        )
      ),
      body:_searchResult != null ? Container(
        padding: EdgeInsets.all(ScreenAdapter.width(30)),
        child: ListView(
          children: <Widget>[
            // 卡片
            Column(
              children: _searchResult.cards.map((item){
                return Container(
                  margin: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
                  child: Row(
                    children: <Widget>[
                      ClipRRect(
                        child: Image.network(item.target.coverUrl,height:ScreenAdapter.height(Configs.thumbHeight(size: 'smaller')),width: ScreenAdapter.width(170),fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      SizedBox(width: ScreenAdapter.width(20)),
                      Expanded(
                        child: Container(
                          height:ScreenAdapter.height(Configs.thumbHeight(size: 'smaller')),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text('${item.typeName}',style: TextStyle(color: Colors.grey)),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child:Text('${item.target.title}(${item.target.year})',style: TextStyle(fontSize: 18)),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child:Text('${item.target.cardSubtitle}',style: TextStyle(color: Colors.grey)),
                              ),
                            ],
                          ),
                        )
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
            // 关键词
            Column(
              children: _searchResult.words.map((item){
                return Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 0.5,
                        color: Colors.grey[500]
                      )
                    )
                  ),
                  height: ScreenAdapter.height(100),
                  child: Text('$item',style: TextStyle(fontSize: 18),),
                );
              }).toList(),
            )
          ],
        ),
      ):Center(
        child: BaseLoading(),
      )
    );
  }


  // 标题栏
  Widget _appBar(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: ScreenAdapter.getScreenWidth() - ScreenAdapter.width(140),
          height: ScreenAdapter.height(60),
          child:TextField(
            autofocus: true,
            controller: TextEditingController(
              text: _currentSearchText
            ),
            onChanged: (val){
              setState(() {
                _currentSearchText = val; 
              });
              _getSeachResult();
            },
            cursorColor: Color.fromRGBO(90, 187, 81, 1),
            decoration: InputDecoration(
              contentPadding:  EdgeInsets.symmetric(vertical: ScreenAdapter.height(12)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none
              ),
              suffixIcon: GestureDetector(
                onTap: (){
                  setState(() {
                    _currentSearchText = ''; 
                  });
                  _getSeachResult();
                },
                child: Icon(Icons.cancel,color: Colors.black38),
              ),
              prefixIcon: Icon(Icons.search,color: Colors.black38),
              fillColor: Colors.grey[100],
              filled: true,
              hintText: widget.searchText,
              hintStyle: TextStyle(
                fontSize: 20
              )
            ),
          ),
        ),
        Expanded(
          flex:1,
          child: Container(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Text('取消',style: TextStyle(fontSize: 20,color: Color.fromRGBO(90, 187, 81,1))),
            ),
          )
        )
      ],
    );
  }

}