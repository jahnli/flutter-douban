import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/model/home/todayPlay.dart';
import 'package:flutter_douban/netUtils/api.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/views/doubanTop/douban_top_list.dart';
import 'package:flutter_douban/views/tabs/book_movie/movie/movieRecommend/movie_recommend.dart';
import 'package:flutter_douban/views/tabs/book_movie/movie/movieShow/movie_show.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/utils/utils.dart';
import 'package:flutter_douban/weiget/base_loading.dart';
import 'package:flutter_douban/weiget/grid_view.dart';
import 'package:flutter_douban/weiget/rowTitle.dart';

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  // 首页模块数据
  List _homeData = [] ;
  TodayPlayModel _todayPlay;

  // 影片推荐 - 筛选标签
  List _recommendTagsList = [];
  // 影片推荐 - 筛选参数列表
  List _filterParamsList = [];
  // 影片推荐 - 数据列表
  List _recommendDataList = [];
  bool _loading = true;

  // 影片推荐 - 筛选参数
  Map<String,dynamic> _filterParams = {
    "s":'rexxar_new',
    "device_id":'87697746e90528f98b6ef4df57178fcab999f9fb',
    "apple":'b8b42270b55ac2d084d865dd261c154d',
    "icecream":'c780d627b64c3057222c7c6102a2d1a9',
    "mooncake":'61260adfd35182c0518f765b32c8ad4b',
    "apikey":'0dad551ec0f84ed02907ff5c42e8ec70',
    "loc_id":'108296',
    "_sig":'R0Grs%2FBOc943XTM5BEEv9uFY5Qw%3D',
    "uuid":"87697746e90528f98b6ef4df57178fcab999f9fb",
    "rom":"android",
    "sugar":"46000",
    "_ts":"1572082252",
  };

  // 影片推荐 - 当前排行
  double _currentSort = 0;


  @override
  void initState() { 
    super.initState();
    // 获取数据
    _getHomeData();
    _getTodayPlay();
    _getMovieRecommend();
  }

   // 获取主页影片推荐
  _getMovieRecommend() async {
    try {
      Response res = await NetUtils.ajax('get', ApiPath.home['movieRecommend'],params:_filterParams);

      if(mounted){
        setState(() {
          _recommendDataList = res.data['items'];
          if(res.data['bottom_recommend_tags'].length > 0){
            _recommendTagsList = res.data['bottom_recommend_tags'];
          }
          _loading = false;
        });
      }
    }
    catch (e) {
      print(e);
    }
  }

  // 获取首页数据
  _getHomeData()async{
    Response res = await NetUtils.ajax('get', ApiPath.home['home']);
    if(mounted){
      setState(() {
        _homeData = res.data['modules'];
      });
    }
  }
  // 获取今日播放
  _getTodayPlay()async{
    Response res = await NetUtils.ajax('get', ApiPath.home['todayPlay']);
    if(mounted){
      setState(() {
        _todayPlay = TodayPlayModel.fromJson(res.data);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return _homeData.length >  0 ? Container(
      key: ObjectKey("movie"),
      margin: EdgeInsets.fromLTRB(ScreenAdapter.height(30), 0, ScreenAdapter.height(30),0),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: SizedBox(height: ScreenAdapter.height(30)),
          ),
          // 分类
          SliverToBoxAdapter(
            child: _homeCategory(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: ScreenAdapter.height(30)),
          ),
          // 今日播放
          SliverToBoxAdapter(
            child: _todayPlay != null ? _homeTodayPlay():Container(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: ScreenAdapter.height(20)),
          ),
          // 影院热映
          SliverToBoxAdapter(
            child: MovieShow(_homeData[4],_homeData[5]),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: ScreenAdapter.height(20)),
          ),
          // 豆瓣热门
          SliverToBoxAdapter(
            child: _doubanHot(_homeData[7]['data']),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: ScreenAdapter.height(20)),
          ),
          // 豆瓣榜单
          SliverToBoxAdapter(
            child: _doubanTopList(_homeData[9]['data']),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: ScreenAdapter.height(30)),
          ),
          // 影片推荐
          SliverToBoxAdapter(
            child: RowTitle(
              title: '为你推荐',
              showRightAction: false,
            ),
          ),
          // 影片推荐 - 筛选区域
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverHeaderDelegate(
              PreferredSize(
                preferredSize: Size.fromHeight(ScreenAdapter.height(180)),
                child: Container(
                  color: Color.fromRGBO(250, 250, 250, 1),
                  height: ScreenAdapter.height(180),
                  padding: EdgeInsets.only(top: ScreenAdapter.width(20),bottom:ScreenAdapter.width(20)),
                  child: Column(
                    children: <Widget>[
                      _filterAction(),
                      _filterParamsList.length > 0 ? _sortAction():Container(),
                    ],
                  )
                ),
              )
            ),
          ),
          SliverToBoxAdapter(
            child: MovieRecommend(
              data:_recommendDataList,
              loading: _loading,
              tags:_filterParams['tags'],
              resetRecommend:()=>_resetRecommend()
            ),
          )
        ],
      )
    ):BaseLoading();
  }
  // 重置影片推荐
  _resetRecommend(){
    setState(() {
      _loading = true;
      _filterParamsList = [];
      _filterParams['tags'] = '';
      _currentSort = 0;
    });
    _getMovieRecommend();
  }
  // 影片推荐 - 排行区域
  _sortAction(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: ScreenAdapter.height(30)),
      child: Container(
        height: ScreenAdapter.height(55),
        width: ScreenAdapter.width(400),
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(20),
          color: Colors.grey[300],
        ),
        child: Stack(
          children: <Widget>[    
            AnimatedPositioned(
              left: ScreenAdapter.width(_currentSort * 100),
              curve: Curves.ease,
              duration: Duration(milliseconds: 500),
              child: Opacity(
                opacity: 1,
                child: Container(
                  height: ScreenAdapter.height(55),
                  width: ScreenAdapter.width(100),
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(
                      width: 0.5,
                      color: Colors.grey
                    )
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[ 
                GestureDetector(
                  onTap: (){
                    if(_currentSort == 0) return;
                    setState(() {
                      _currentSort = 0; 
                      _loading = true;
                    });
                    _getMovieRecommend();
                  },
                  child:Container(
                    alignment: Alignment.center,
                    width: ScreenAdapter.width(100),
                    child: Text('默认'),
                  )
                ),
                GestureDetector(
                  onTap: (){
                    if(_currentSort == 1) return;
                    setState(() {
                      _loading = true;
                      _currentSort = 1; 
                      _filterParams['sort'] = 'T'; 
                    });
                    _getMovieRecommend();
                  },
                  child:Container(
                    alignment: Alignment.center,
                    width: ScreenAdapter.width(100),
                    child: Text('热度'),
                  )
                ),
                GestureDetector(
                  onTap: (){
                    if(_currentSort == 2) return;
                    setState(() {
                      _loading = true;
                      _currentSort = 2; 
                      _filterParams['sort'] = 'S'; 
                    });
                    _getMovieRecommend();
                  },
                  child:Container(
                    alignment: Alignment.center,
                    width: ScreenAdapter.width(100),
                    child: Text('评分'),
                  )
                ),
                GestureDetector(
                  onTap: (){
                    if(_currentSort == 3) return;
                    setState(() {
                      _loading = true;
                      _currentSort = 3; 
                      _filterParams['sort'] = 'R'; 
                    });
                    _getMovieRecommend();
                  },
                  child:Container(
                    alignment: Alignment.center,
                    width: ScreenAdapter.width(100),
                    child: Text('时间'),
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  // 影片推荐 - 筛选区域
  Widget _filterAction(){
    return _recommendTagsList.length > 0 ? Container(
      height: ScreenAdapter.height(50),
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context,index){
                bool _isSelect = _filterParamsList.contains('${_recommendTagsList[index]}');
                String _tempParams = '';
                return GestureDetector(
                  onTap: (){
                    // 如果已选中，取消选中
                    if(_isSelect){
                      setState(() {
                        _filterParamsList.remove(_recommendTagsList[index]);
                      });
                    }else{
                      setState(() {
                        _filterParamsList.add(_recommendTagsList[index]);
                      });
                    }
                    for (int i = 0; i < _filterParamsList.length; i++) {
                      _tempParams += i == 0 ? '${_filterParamsList[i]}':',${_filterParamsList[i]}';
                    }
                    if(_filterParamsList.length == 0){
                      setState(() {
                        _currentSort = 0; 
                      });
                    }
                    setState(() {
                      _loading = true;
                      _filterParams['tags'] = _tempParams; 
                    });
                    _getMovieRecommend();
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: ScreenAdapter.width(20),right: ScreenAdapter.width(20)),
                    decoration: BoxDecoration(
                      color:_isSelect ? Color.fromRGBO(104, 203, 120, 1):Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border:!_isSelect ? Border.all(
                        width: 1,
                        color: Colors.grey
                      ):null
                    ),
                    margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      child: Text('${_recommendTagsList[index]}',style: TextStyle(color: _isSelect ? Colors.white:Colors.black)),
                    ),
                  ),
                );
              },
              itemCount: _recommendTagsList.length,
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: ScreenAdapter.width(90),
            child: Row(
              children: <Widget>[
                Image.network('http://cdn.jahnli.cn/filter.png',width: ScreenAdapter.width(25)),
                Text('筛选',style: TextStyle(fontSize: 14))
              ],
            )
          )
        ],
      )
    ):Container();
  }
  // 构建豆瓣榜单
  Widget _doubanTopList(data){
    return Column(
      children: <Widget>[
        RowTitle(title:data['title'],count:data['total'],url:'/doubanTop'),
        DoubanTopList(dataList: data['selected_collections'])
      ],
    );
  }
  // 构建豆瓣热门
  Widget _doubanHot(data){
    data = data['subject_collection_boards'][0];
    return Column(
      children: <Widget>[
        RowTitle(
          title: '豆瓣热门',
          count: data['subject_collection']['subject_count'],
          url:'/movieHotDetail'
        ),
        GridViewItems(
          data: data['items'],
          itemCount: 6,
          thumbHeight: 'large',
        )
      ],
    );
  }
  // 构建首页分类
  Widget _homeCategory(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:_homeData[0]['data']['subject_entraces'].map<Widget>((item){
        return GestureDetector(
          onTap: (){
            Application.router.navigateTo(context, '/doubanTop');
          },
          child: Column(
            children: <Widget>[
              Image.network(item['icon'],width: ScreenAdapter.width(90)),
              SizedBox(height: ScreenAdapter.height(20)),
              Text(item['title'])
            ],
          ),
        );
      }).toList(),
    );
  }

  // 构建首页今日播放
  Widget _homeTodayPlay (){
    return Container(
      margin: EdgeInsets.only(bottom: ScreenAdapter.height(30)),
      height: ScreenAdapter.height(250),
      child:  Stack(
        alignment: Alignment.bottomLeft,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ScreenAdapter.width(20)),
                color: Utils.colorTransform(_todayPlay.videos[0].colorScheme.primaryColorDark),
              ),
              width: double.infinity,
              height: ScreenAdapter.height(210),
            ),
            Positioned(
              left: ScreenAdapter.width(160),
              bottom: ScreenAdapter.height(40),
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network('${_todayPlay.videos[2].pic.normal}',fit: BoxFit.fill),
                ),
                width:ScreenAdapter.width(180),
                height: ScreenAdapter.height(180),
              ),
            ),
            Positioned(
              left: ScreenAdapter.width(100),
              bottom: ScreenAdapter.height(40),
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network('${_todayPlay.videos[1].pic.normal}',fit: BoxFit.fill),
                ),
                width:ScreenAdapter.width(180),
                height: ScreenAdapter.height(190),
              ),
            ),
            Positioned(
              left: ScreenAdapter.width(40),
              bottom: ScreenAdapter.height(40),
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network('${_todayPlay.videos[0].pic.normal}',fit: BoxFit.fill),
                ),
                width:ScreenAdapter.width(180),
                height: ScreenAdapter.height(200),
              ),
            ),
            Positioned(
              right: ScreenAdapter.width(10),
              top: ScreenAdapter.width(100),
              child: Column(
                children: <Widget>[
                  Container(
                    width: ScreenAdapter.width(280),
                    margin: EdgeInsets.only(bottom: ScreenAdapter.height(10)),
                    child: Text('${_todayPlay.title}',style: TextStyle(color: Colors.white,fontSize: 16)),
                  ),
                  Container(
                    width: ScreenAdapter.width(280),
                    child: Row(
                      children: <Widget>[
                        Text('全部 ${_todayPlay.total}',style: TextStyle(color: Colors.white,fontSize: 14)),
                        Icon(Icons.keyboard_arrow_right,size:17,color:Colors.white)
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              right: ScreenAdapter.width(15),
              bottom: ScreenAdapter.width(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.movie_filter,color: Colors.white,size: 17),
                  SizedBox(width: ScreenAdapter.width(6)),
                  Text('看电影',style: TextStyle(color: Colors.white,fontSize: 12))
                ],
              ),
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
    return true;
  }

  @override
  double get maxExtent => widget.preferredSize.height;

  @override
  double get minExtent => widget.preferredSize.height;
}
