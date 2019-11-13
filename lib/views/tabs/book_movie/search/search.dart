import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/model/book_movie_search_model.dart';
import 'package:flutter_douban/model/search_hot.dart';
import 'package:flutter_douban/netUtils/api.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/utils/configs.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/views/tabs/book_movie/search/searchResult.dart';
import 'package:flutter_douban/weiget/base_grade.dart';
import 'package:flutter_douban/weiget/base_loading.dart';
import 'package:flutter_douban/weiget/search/search_row.item.dart';

class BookMovieSearch extends StatefulWidget {
  
  String searchText;
  
  BookMovieSearch({this.searchText});

  @override
  _BookMovieSearchState createState() => _BookMovieSearchState();
}

class _BookMovieSearchState extends State<BookMovieSearch> {

  // 搜索结果
  BookMovieSearchModel _searchSuggestionResult;
  // 搜索热门
  SearchHotModel _seachHotResult;
  TextEditingController _searchController = TextEditingController();
  // 显示最终搜索结果
  bool _showLastResult  = false;

  @override
  void initState() { 
    super.initState();
    _getSearchHot();
  }

  @override
  void dispose() {
    _searchController.clear();
    super.dispose();
  }

  // 获取搜索热门
  _getSearchHot()async{
    try {
      Response res = await NetUtils.ajax('get',ApiPath.home['searchHot']);
      if(mounted){
        setState(() {
          _seachHotResult = SearchHotModel.fromJson(res.data); 
        });
      }
    } 
    catch (e) {
    }
  }
  // 获取搜索建议结果
  _getSeachSuggestionResult() async{
    try {
      if(mounted){
        setState(() {
            _searchSuggestionResult = null;
        });
      }
      print(_searchController.text);
      Response res = await NetUtils.ajax('get','${ApiPath.home['bookMovieSearchResult']}&q=${_searchController.text}');
      if(mounted){
        setState(() {
          _searchSuggestionResult = BookMovieSearchModel.fromJson(res.data); 
        });
      }
    } 
    catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
        title: _appBar(),
      ),
      body:_searchController.text.isEmpty ? _seachHotResult != null ? Container(
        child: ListView(
          children: <Widget>[
            SizedBox(height: ScreenAdapter.height(30)),
            // 热门书影音
            Container(
              padding: EdgeInsets.only(left: ScreenAdapter.width(30),right: ScreenAdapter.width(30)),
              child: _hotBookMovie(),
            ),
            // 榜单
            Container(
              padding: EdgeInsets.only(left: ScreenAdapter.width(30),right: ScreenAdapter.width(30)),
              child:_hotTop(),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenAdapter.height(30)),
              height: ScreenAdapter.height(10),
              color: Colors.grey[200]
            ),
            // 热门小组
            Container(
              padding: EdgeInsets.only(left: ScreenAdapter.width(30),right: ScreenAdapter.width(30)),
              child:_hotGroup(),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenAdapter.height(20)),
              height: ScreenAdapter.height(10),
              color: Colors.grey[200]
            ),
            // 热门话题
            Container(
              padding: EdgeInsets.only(left: ScreenAdapter.width(30),right: ScreenAdapter.width(30)),
              child:_hotTopic(),
            ),
            // 描述
            Container(
              alignment: Alignment.center,
              height: ScreenAdapter.height(100),
              child: Text('- 以上内容，每日更新 -',style: TextStyle(color: Colors.grey))
            )
          ],
        ),
      ):Center(
        child: BaseLoading(),
        // 如果有数据，显示搜索推荐， 否则显示loading
        // 如果点击列表项，显示最终搜索结果组件
      ):_searchSuggestionResult != null ? _showLastResult == false ?  _seachSuggestionResultWidget():Container(
        child: BookMovieSearchResult(
          keyWords: _searchController.text,
        )
      ):Center(
        child: BaseLoading(),
      )
    );
  }

 // 搜索建议结果
  Widget _seachSuggestionResultWidget(){
    return Container(
      padding: EdgeInsets.all(ScreenAdapter.width(30)),
      child: ListView(
        children: <Widget>[
          // 卡片
          _searchSuggestionResult.cards.length > 0 ? Column(
            children: _searchSuggestionResult.cards.map((item){
              return SearchRowItem(data: item);
            }).toList(),
          ):Container(),
          // 关键词
          Column(
            children: _searchSuggestionResult.words.map((item){
              return GestureDetector(
                onTap: (){
                  setState(() {
                     _showLastResult = true;
                  });
                },
                child: Container(
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
                  child: RichText(
                    text: TextSpan(
                      style:item.substring(0,_searchController.text.length).toLowerCase() == _searchController.text ?  TextStyle(color: Color.fromRGBO(90, 187, 81,1), fontSize: 18.0):TextStyle(color: Colors.black, fontSize: 18.0),
                      text: item.substring(0,_searchController.text.length) ,
                      children: [
                        TextSpan(
                          style:TextStyle(color: Colors.black, fontSize: 18.0),
                          text: item.substring(_searchController.text.length,item.length)
                        )
                      ]
                    ),
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
  // 热门话题
  Widget _hotTopic(){
    return Container(
      margin: EdgeInsets.only(top: ScreenAdapter.height(30)),
      child: Column(
        children: <Widget>[
          _titleWidget(title: '热门话题'),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context,index){
              final _item = _seachHotResult.galleryTopics[index];
              return _item.type == 'gallery_topic' ? Container(
                margin: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
                padding: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5,
                      color: Colors.grey
                    )
                  )
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.forum,color: Color.fromRGBO(90, 187, 81, 1)),
                    SizedBox(width: ScreenAdapter.width(20)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${_item.title}',style: TextStyle(fontSize: ScreenAdapter.fontSize(35))),
                          SizedBox(height: ScreenAdapter.height(10)),
                          Text('${_item.cardSubtitle}',style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    )
                  ],
                ),
              ):Container();
            },
            itemCount: _seachHotResult.galleryTopics.length,
          )
        ],
      ),
    );
  }
  // 热搜小组
  Widget _hotGroup(){
    return Container(
      margin: EdgeInsets.only(top: ScreenAdapter.height(20)),
      child: Column(
        children: <Widget>[
          _titleWidget(title: '热搜小组'),
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(0),
            //宽高比
            childAspectRatio:ScreenAdapter.width(240) / ScreenAdapter.height(90),
            shrinkWrap: true,
            crossAxisCount: 2,
            children: _seachHotResult.groups.asMap().keys.map((index){
              final _item = _seachHotResult.groups[index];
              return GestureDetector(
                onTap: (){
                  // Application.router.navigateTo(context, '/filmDetail?id=${_item.id}');
                },
                child: Container(
                  decoration: BoxDecoration(
                    border:  Border(
                      bottom: BorderSide(
                        width: 0.5,
                        color: Colors.grey[300]
                      )
                    )
                  ),
                  padding: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
                  margin: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network('${_item.coverUrl}',width: ScreenAdapter.width(90),height: ScreenAdapter.height(90),fit: BoxFit.cover),
                      ),
                      SizedBox(
                        width: ScreenAdapter.width(20),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: ScreenAdapter.width(180) ,
                            child: Text('${_item.title}',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 20)),
                          ),
                          Text('${_item.cardSubtitle}',style: TextStyle(color: Colors.grey),),
                        ],
                      ),
                    ],
                  )
                ),
              );
            }).toList()         
          ),
        ],
      ),
    );
  }
  // 榜单
  Widget _hotTop(){
    return Container(
      height: ScreenAdapter.height(190),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){
          final _item = _seachHotResult.collections[index];
          return GestureDetector(
            onTap: (){
              Application.router.navigateTo(context, '/doubanTopDetail?id=${_item.source}');
            },
            child: Container(
              width: ScreenAdapter.width(330),
              margin: EdgeInsets.only(right: ScreenAdapter.width(30)),
              padding: EdgeInsets.only(left: ScreenAdapter.width(30)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 0.5,
                  color: Colors.grey
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('${_item.typeName}',style: TextStyle(fontSize: ScreenAdapter.fontSize(30),color: Color(int.parse('0xff' + _item.target.label.bgColor)))),
                      Text(' · ${_item.title}',style: TextStyle(fontSize: ScreenAdapter.fontSize(30),color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: ScreenAdapter.height(10)),
                  Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network('${_item.target.coverUrl}',width: ScreenAdapter.width(Configs.thumbHeight(size: 'miniWidth')),height: ScreenAdapter.height(ScreenAdapter.height(Configs.thumbHeight(size: 'miniHeight'))),fit: BoxFit.fill),
                      ),
                      SizedBox(width: ScreenAdapter.height(10)),
                      Container(
                        height: ScreenAdapter.height(110),
                        width: ScreenAdapter.width(150),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text('${_item.target.label.title}',style: TextStyle(color: Color(int.parse('0xff' + _item.target.label.bgColor)))),
                            SizedBox(height: ScreenAdapter.height(10)),
                            Text('${_item.target.title}'),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
        itemCount: _seachHotResult.collections.length
      ),
    );
  }
  // 热门书影音
  Widget _hotBookMovie(){
    return Column(
      children: <Widget>[
        _titleWidget(title: '热门书影音'),
        GridView.count(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(0),
          //宽高比
          childAspectRatio:ScreenAdapter.width(240) / ScreenAdapter.height(100),
          shrinkWrap: true,
          crossAxisCount: 2,
          children: _seachHotResult.subjects.asMap().keys.map((index){
            final _item = _seachHotResult.subjects[index];
            return GestureDetector(
              onTap: (){
                Application.router.navigateTo(context,'/filmDetail?id=${_item.id}');
              },
              child: Container(
                decoration: BoxDecoration(
                  border:  Border(
                    bottom: BorderSide(
                      width: 0.5,
                      color: Colors.grey[300]
                    )
                  )
                ),
                padding: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
                margin: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
                child:Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network('${_item.coverUrl}',width: ScreenAdapter.width(Configs.thumbHeight(size: 'miniWidth')),height: ScreenAdapter.height(ScreenAdapter.height(Configs.thumbHeight(size:'miniHeight'))),fit: BoxFit.cover),
                    ),
                    SizedBox(
                      width: ScreenAdapter.width(20),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: ScreenAdapter.width(180) ,
                          child: Text('${_item.title}',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: ScreenAdapter.fontSize(30))),
                        ),
                        BaseGrade(
                          value: _item.rating.value,
                        ),
                        Text('${_item.cardSubtitle}',style: TextStyle(color: Colors.grey),),
                      ],
                    ),
                  ],
                )
              ),
            );
          }).toList()         
        ),
        Container(
          alignment: Alignment.center,
          child: Container(
            width: ScreenAdapter.width(300),
            height: ScreenAdapter.height(60),
            child: OutlineButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)
              ),
              onPressed: () {
                Application.router.navigateTo(context, '/');
              },
              child: Row(
                children: <Widget>[
                  Text('更多书影音',style: TextStyle(fontSize: ScreenAdapter.fontSize(30))),
                  SizedBox(width: ScreenAdapter.width(20)),
                  Icon(Icons.keyboard_arrow_right)
                ],
              )
            ),
          )
        ),
        SizedBox(height: ScreenAdapter.height(30))
      ],
    );
  }
  // 标题栏
  Widget _appBar(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child:Container(
            height: ScreenAdapter.height(60),
            child:TextField(
              autofocus: true,
              controller:_searchController,
              onSubmitted: (val){
                setState(() {
                  _showLastResult = false;
                  _getSeachSuggestionResult();
                });
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
                    // 保证在组件build的第一帧时才去触发取消清空内容
                    WidgetsBinding.instance.addPostFrameCallback((s) {
                      _searchController.clear();
                      _getSeachSuggestionResult();
                    });
                  },
                  child: Icon(Icons.cancel,color: Colors.black38),
                ),
                prefixIcon: Icon(Icons.search,color: Colors.black38),
                fillColor: Colors.grey[100],
                filled: true,
                hintText: widget.searchText,
                hintStyle: TextStyle(
                  fontSize: ScreenAdapter.fontSize(32)
                )
              ),
            ),
          ),
        ),
        Container(
          width: ScreenAdapter.width(120),
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: (){
              Application.router.navigateTo(context,'/',replace: true);
            },
            child: Text('取消',style: TextStyle(fontSize: ScreenAdapter.fontSize(32),color: Color.fromRGBO(90, 187, 81,1))),
          ),
        )
      ],
    );
  }

  // 标题
  Widget _titleWidget({@required String title}){
    return  Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
      child: Text('$title',style: TextStyle(fontSize: ScreenAdapter.fontSize(30))),
    );
  }

}