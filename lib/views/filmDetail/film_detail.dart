import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/model/filmDetail/film_detail_model.dart';
import 'package:flutter_douban/netUtils/api.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/utils/configs.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/views/filmDetail/film_detail_actor.dart';
import 'package:flutter_douban/views/filmDetail/film_detail_comment.dart';
import 'package:flutter_douban/views/filmDetail/film_detail_forum.dart';
import 'package:flutter_douban/views/filmDetail/film_detail_grade.dart';
import 'package:flutter_douban/views/filmDetail/film_detail_prevue.dart';
import 'package:flutter_douban/views/filmDetail/film_detail_related.dart';
import 'package:flutter_douban/views/filmDetail/film_detail_short_comments.dart';
import 'package:flutter_douban/weiget/base_loading.dart';
import 'package:flutter_douban/weiget/honor_infos.dart';
import 'package:rubber/rubber.dart';
class FilmDetail extends StatefulWidget {

  final String movieId;
  FilmDetail({this.movieId});

  @override
  _FilmDetailState createState() => _FilmDetailState();
}

class _FilmDetailState extends State<FilmDetail> with TickerProviderStateMixin{

  // 影片数据
  FilmDetailModel _data;

  // 默认显示静态文字电影
  bool _showTitleGrade = false;

  // 滚动控制器
  ScrollController _scrollController = ScrollController();
  ScrollController _bottomSheetController = ScrollController();
  RubberAnimationController _controller;
  TabController _tabController;
  //  文字颜色
  Color _baseTextColor;
  // 剧情简介显示更多
  int _showMore = 4;
  // 演职员数量
  int _actorTotal = 0;
  // 预告片数量
  int _prevueTotal = 0 ;
  // 讨论数量
  int _forumTotal = 0;

  @override
  void initState() { 
    super.initState();
    if(mounted){
      _controller = RubberAnimationController(
        vsync: this,
        halfBoundValue: AnimationControllerValue(percentage: 0.5),
        duration: Duration(milliseconds: 200)
      );
    }
    _tabController = TabController(length: 2,vsync: this);
    _getDetail();
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _scrollController.dispose();
    _tabController.dispose();
    _bottomSheetController.dispose();
    super.dispose();
  }
  // 获取评论数量
  _getFilmForum()async{
    try{
      Response res = await NetUtils.ajax('get','https://frodo.douban.com/api/v2/subject/${_data.id}/forum_topic/topics?start=0&count=10&os_rom=android&apikey=0dad551ec0f84ed02907ff5c42e8ec70&channel=Douban&udid=5440f7d1721c7ec5444c588d26ec3c6b26996bbd&_sig=HApqGiSWyuoJD%2FmeeL2pAWOQerE%3D&_ts=1571799819');
      if(mounted){
        setState(() {
          _forumTotal = res.data['total']; 
        });
      }
    }
    catch(e){
      print(e);
    }
  }
  _getDetail()async{
    try{
      Response res = await NetUtils.ajax('get', 'https://frodo.douban.com/api/v2/movie/${widget.movieId}'+ApiPath.home['filmDetail']);
      if(mounted){
        setState(() {
          _data = FilmDetailModel.fromJson(res.data); 
          _baseTextColor = _data.colorScheme.isDark ? Colors.white:Colors.black;
        });
        _getFilmForum();
      }
    }
    catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _data != null ? Theme(
      data:ThemeData(
        textTheme:TextTheme(
          body1: TextStyle(color:_baseTextColor)
        ),
        iconTheme: IconThemeData(
          color: _baseTextColor
        )
      ),
      child: Scaffold(
        backgroundColor:Color(int.parse('0xff' + _data.headerBgColor)),
        appBar: AppBar(
          centerTitle: true,
          title: _showTitleGrade ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text('${_data.title}',style: TextStyle(fontSize: 14)),
              ),
              // BaseGrade(value:_movie['rating']['average'], nullRatingReason:_movie['mainland_pubdate'])
            ],
          ) : Text('电影') ,
          backgroundColor: Color(int.parse('0xff' +  _data.headerBgColor))
        ),
        body: Container(
          child: RubberBottomSheet(
            scrollController: _bottomSheetController,
            lowerLayer: _content(),
            header: Container(
              decoration: BoxDecoration(
                color:Color.fromRGBO(246, 246, 246, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )
              ),
              child: Stack(
                children: <Widget>[
                  _striping(),
                  TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    labelStyle: TextStyle(fontSize: 16),
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: <Widget>[
                      Tab(text: '影评 ${_data.reviewCount}'),
                      Tab(text: '讨论 $_forumTotal'),
                    ],
                  )
                ],
              )
            ),
            upperLayer: _bottomSheet(),
            animationController: _controller,
          )
        ),
        ),
    ):Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
      ),
      body: BaseLoading(),
    );
  }


  // 内容区域
  Widget _content() {
    return Container(
      padding: EdgeInsets.fromLTRB(ScreenAdapter.width(30),0,ScreenAdapter.width(30),ScreenAdapter.width(30)),
      child: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: SizedBox(height: ScreenAdapter.height(30)),
          ),
          // 头部信息
          SliverToBoxAdapter(
            child:  _headInfo(),
          ),
          // 评分
          SliverToBoxAdapter(
            child: FilmDetailGrade(
              movieId:_data.id,
              nullRatingReason:_data.nullRatingReason,
              isDark:_data.colorScheme.isDark,
              rating:_data.rating.value.toInt(),
              rateCount: _data.rating.count,
            ),
          ),
          // 选座购票 剧情简介
          SliverToBoxAdapter(
            child: _plot(),
          ),
          // 演职员
          SliverToBoxAdapter(
            child: _actor()
          ),
          // 预告片
          SliverToBoxAdapter(
            child:_prevue(),
          ),
          // 短评
          SliverToBoxAdapter(
            child:FilmDetailShortComments(
              movieId:_data.id,
              isDark:_data.colorScheme.isDark,
            ),
          ),
          // 喜欢这部电影的人也喜欢
          SliverToBoxAdapter(
            child:_related(),
          ),
          SliverToBoxAdapter(
            child:SizedBox(height: ScreenAdapter.height(80)),
          )
        ],
      )
    );
  }
  // 喜欢大这部电影的人也喜欢
  Widget _related(){
    return Container(
      child: Column(
        children: <Widget>[
          _rowTitle(
            title: '喜欢这部电影的人也喜欢',
            rightDesc:'全部'
          ),
          FilmDetailRelated(
            movieId: _data.id,
            isDark:_data.colorScheme.isDark,
          )
        ],
      ),
    ); 
  }
  // bottomSheet
  Widget _bottomSheet() {
    return DefaultTextStyle(
      style: TextStyle(color: Colors.black),
      child: Container(
        color: Colors.white,
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            FilmDetailComment(
              movieId: _data.id,
              bottomSheetController: _bottomSheetController,
            ),  
            FilmDetailForum(
              movieId: _data.id,
              bottomSheetController: _bottomSheetController,
              setForumTotal:(total){
                setState(() {
                  _forumTotal = total; 
                });
              }
            )
          ],
        ),
      ),
    );
  }


  // 预告片
  Widget _prevue(){
    return Container(
      child: Column(
        children: <Widget>[
          _rowTitle(
            title: '预告片 / 剧照',
            rightDesc:'全部 $_prevueTotal'
          ),
          FilmDetailPrevue(
            movieId: _data.id,
            setPrevueTotal:(total){
              setState(() {
               _prevueTotal = total; 
              });
            }
          )
        ],
      ),
    );
  }
  // 演职员
  Widget _actor(){
    return Container(
      child: Column(
        children: <Widget>[
          _rowTitle(
            title: '演职员',
            rightDesc:'全部 $_actorTotal'
          ),
          FilmDetailActor(
            movieId: _data.id,
            setActorTotal:(total){
              setState(() {
               _actorTotal = total; 
              });
            }
          )
        ],
      ),
    );
  }
  // 选座购票  所属频道
  Widget _plot(){
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding:EdgeInsets.all(0),
            leading: Icon(Icons.card_giftcard,color: Color.fromRGBO(252, 166, 118, 1)),
            title: Text('选座购票',style: TextStyle(color: _baseTextColor,fontSize: 18)),
            trailing: Icon(Icons.keyboard_arrow_right,color: _baseTextColor),
          ),
          Container(
            height: ScreenAdapter.height(50),
            child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context,index){
              return Container(
                padding: EdgeInsets.only(left:ScreenAdapter.width(20),right:ScreenAdapter.width(10)),
                margin: EdgeInsets.only(right: ScreenAdapter.width(10)),
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(15),
                  color:Color.fromRGBO(0, 0, 0, 0.1)
                ),
                child: Row(
                  children: <Widget>[
                      Text('${_data.tags[index].name}',style: TextStyle(fontSize: 14,color: _baseTextColor)),
                      Icon(Icons.keyboard_arrow_right,color:_data.colorScheme.isDark ? Colors.grey[400]:Colors.grey[600],size: 18,)
                    ],
                  ),
                );
              },
              itemCount: _data.tags.length,
            ),
          ),
          _rowTitle(title: '剧情简介'),
          Container(
            alignment: Alignment.centerLeft,
            child: Text('${_data.intro}',style: TextStyle(fontSize: 16,color: _baseTextColor),maxLines: _showMore,overflow: TextOverflow.ellipsis,),
          ),
          Container(
            margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: (){
                setState(() {
                  _showMore = _showMore == 4 ? 15:4;
                });
              },
              child: Text('${_showMore == 4 ? '展开':'收起'}',style: TextStyle(color:Colors.grey,fontSize: 14)),
              ),
            )
          ],
        ),
      );
  }
  // 头部
  Widget _headInfo(){
    return Container(
      margin: EdgeInsets.only(bottom: ScreenAdapter.height(30)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
            child: ClipRRect(
              child: Image.network('${_data.pic.normal}',height:ScreenAdapter.height(Configs.thumbHeight()),width: ScreenAdapter.width(170),fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(bottom: ScreenAdapter.height(10)),
                  child: Text('${_data.title}',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600)),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(bottom: ScreenAdapter.height(10)),
                  child: Text('${ _data.originalTitle} (${_data.year})',style: TextStyle(fontSize: 18)),
                ),
                _data.honorInfos.length > 0 ? HonorInfos(rankText: _data.honorInfos.first.rank,title: _data.honorInfos.first.title):Container(),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(bottom: ScreenAdapter.height(10)),
                  child: Text('${_data.countries.first} / ${_data.genres.first} 上映时间：${_data.pubdate.first} / 片长：${_data.durations.first}',style: TextStyle(color: _data.colorScheme.isDark ? Colors.grey[300]:Colors.grey[600])),
                ),
                Row(
                  children: <Widget>[
                    _iconbtn(Icons.favorite_border,'想看'),
                    SizedBox(width: ScreenAdapter.width(30)),
                    _iconbtn(Icons.star_border,'看过')
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  // 头部标题
  Widget _rowTitle({String title,String rightDesc}){
    return Container(
      margin: EdgeInsets.only(top: ScreenAdapter.height(30),bottom: ScreenAdapter.height(30)),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('$title',style: TextStyle(fontSize: 20,color: _baseTextColor)),
          rightDesc != null ? Row(
            children: <Widget>[
              Text('$rightDesc',style: TextStyle(color:Colors.grey)),
              Icon(Icons.keyboard_arrow_right,color:Colors.grey)
            ],
          ):Container()
        ],
      ),
    );
  }
  // 底部菜单条纹
  Widget _striping(){
    return Container(
      margin: EdgeInsets.only(top: ScreenAdapter.height(15)),
      alignment: Alignment.topCenter,
      child: Container(
        width: ScreenAdapter.width(70),
        height: ScreenAdapter.height(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color.fromRGBO(216, 216, 216, 1)
        ),
      ),
    );
  }
  // 想看 看过 按钮
  Widget _iconbtn(icon,text){
    return Expanded(
      child: Container(
        height: ScreenAdapter.height(60),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: GestureDetector(
          onTap: (){
            
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(icon,color: Colors.orange,size: 15,),
              SizedBox(width: ScreenAdapter.width(15)),
              Text(text,style: TextStyle(color: Colors.black),)
            ],
          ),
        ),
      ),
    );
  }  

}