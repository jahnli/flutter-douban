import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/utils/utils.dart';
import 'package:flutter_douban/views/doubanTop/topItems/default_top_item.dart';
import 'package:flutter_douban/views/doubanTop/topItems/year_top_item.dart';
import 'package:flutter_douban/weiget/base_grade.dart';
import 'package:flutter_douban/weiget/base_loading.dart';
// 数据格式
// api列表
List apiList = [
  Utils.getJsonpApiUrl('movie_love'),
  Utils.getJsonpApiUrl('movie_comedy'),
  Utils.getJsonpApiUrl('film_genre_27'),
  Utils.getJsonpApiUrl('film_genre_31'),
  Utils.getJsonpApiUrl('movie_scifi'),
  Utils.getJsonpApiUrl('film_genre_35'),
  Utils.getJsonpApiUrl('film_genre_36'),
  Utils.getJsonpApiUrl('film_genre_38'),
  Utils.getJsonpApiUrl('film_genre_39'),
  Utils.getJsonpApiUrl('film_genre_40'),
];

class DoubanTopMovie extends StatefulWidget {
  @override
  _DoubanTopMovieState createState() => _DoubanTopMovieState();
}

class _DoubanTopMovieState extends State<DoubanTopMovie> with AutomaticKeepAliveClientMixin{

  bool get wantKeepAlive => true; 

  String _requestStatus = '';
  String _requestYearTopStatus = '';

  // 榜单数据
  Map _praiseTop;
  Map _hotTop;
  Map _top250;
  // 年度榜单
  Map _yearTop = {
    'highRateChinaMovie':{},
    'highRateForeignMovie':{},
    'notInPopular':{},
  };
  // 高分榜
  // 爱情片
  Map _loveData;
  // 喜剧片
  Map _comedyData;
  // 剧情片
  Map _plotData;
  // 动画片
  Map _animateData;
  // 科幻片
  Map _scifiData;
  // 纪录片
  Map _recordData;
  // 短片
  Map _shortData;
  // 同性片
  Map _sameSexData;
  // 音乐片
  Map _musicData;
  // 歌舞片
  Map _songAndDanceData;

  @override
  void initState() { 
    super.initState();
    // 获取榜单数据
    _getTopData();
    // 获取年度榜单
    _getYearTop();
    // 获取高分榜
    _getHighMark();
  }

  // 获取高分榜
  _getHighMark()async{
    Options options = Options(
      headers: {
        HttpHeaders.refererHeader: 'https://m.douban.com/movie/beta',
      },
    );
    var res = await Future.wait([
      Dio().get(apiList[0],options:options),
      Dio().get(apiList[1],options: options),
      Dio().get(apiList[2],options: options),
      Dio().get(apiList[3],options: options),
      Dio().get(apiList[4],options: options),
      Dio().get(apiList[5],options: options),
      Dio().get(apiList[6],options: options),
      Dio().get(apiList[7],options: options),
      Dio().get(apiList[8],options: options),
      Dio().get(apiList[9],options: options),
    ]);
    if(mounted){
      setState(() {
        _loveData = json.decode(res[0].data.substring(8,res[0].data.length - 2));
        _comedyData = json.decode(res[1].data.substring(8,res[1].data.length - 2));
        _plotData = json.decode(res[2].data.substring(8,res[2].data.length - 2));
        _animateData = json.decode(res[3].data.substring(8,res[3].data.length - 2));
        _scifiData = json.decode(res[4].data.substring(8,res[4].data.length - 2));
        _recordData = json.decode(res[5].data.substring(8,res[5].data.length - 2));
        _shortData = json.decode(res[6].data.substring(8,res[6].data.length - 2));
        _sameSexData = json.decode(res[7].data.substring(8,res[7].data.length - 2));
        _musicData = json.decode(res[8].data.substring(8,res[8].data.length - 2));
        _songAndDanceData = json.decode(res[9].data.substring(8,res[9].data.length - 2));
      });
    }
  }
  
  // 获取年度榜单
  _getYearTop()async{
    try{
      Options option = Options(
        headers: {
          HttpHeaders.refererHeader: 'https://m.douban.com/movie/beta',
        },
      );
      Response highRateChinaMovie = await Dio().get('https://movie.douban.com/ithil_j/activity/movie_annual${DateTime.now().year - 1}/widget/1',options:option);
      Response highRateForeignMovie = await Dio().get('https://movie.douban.com/ithil_j/activity/movie_annual${DateTime.now().year - 1}/widget/2', options:option);
      Response notInPopular = await Dio().get('https://movie.douban.com/ithil_j/activity/movie_annual${DateTime.now().year - 1}/widget/3',options:option);
      if(mounted){
        setState(() {
          _yearTop['highRateChinaMovie'] = highRateChinaMovie.data['res'];
          _yearTop['highRateForeignMovie'] = highRateForeignMovie.data['res'];
          _yearTop['notInPopular'] = notInPopular.data['res'];
          _requestYearTopStatus = '获取年度豆瓣榜单成功';
        });   
      }
    }
    catch(e){
      print(e);
      if(mounted){
        setState(() {
          _requestYearTopStatus = '获取年度豆瓣榜单失败'; 
        });
      }
    }
  }
  // 获取数据
  _getTopData()async{
    try{
      Response res = await Dio().get('https://m.douban.com/rexxar/api/v2/movie/modules?for_mobile=1', options: Options(
        headers: {
          HttpHeaders.refererHeader: 'https://m.douban.com/movie/beta',
        },
      ));
      if(mounted){
        setState(() {
          _praiseTop = res.data['modules'][8]['data']['selected_collections'][0]; 
          _top250 = res.data['modules'][8]['data']['selected_collections'][1]; 
          _hotTop = res.data['modules'][8]['data']['selected_collections'][2]; 
          _requestStatus = '获取豆瓣榜单成功';
        });   
      }
    }
    catch(e){
      if(mounted){
        setState(() {
          _requestStatus = '获取豆瓣榜单失败'; 
        });
      }
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(ScreenAdapter.width(30),0,ScreenAdapter.width(30),ScreenAdapter.width(30)),
      child: ListView(
        children: <Widget>[
          // 榜单
          _requestStatus.isNotEmpty ?  Column(
            children: <Widget>[
              SizedBox(height: ScreenAdapter.height(30)),
              DefaultTopItem(_praiseTop),
              DefaultTopItem(_hotTop),
              DefaultTopItem(_top250,showTrend:false),
            ],
          ):BaseLoading(),
          // 豆瓣年度榜单
          _requestYearTopStatus.isNotEmpty ?  Column(
            children: <Widget>[
              SizedBox(height: ScreenAdapter.height(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('豆瓣年度榜单',style: TextStyle(fontSize: 24,color:Colors.black,fontWeight: FontWeight.w600)),
                  Row(
                    children: <Widget>[
                      Text('全部',style: TextStyle(color:Colors.black87,fontSize: 16)),
                      Icon(Icons.keyboard_arrow_right,color:Colors.black87)
                    ],
                  )
                ],
              ),
              SizedBox(height: ScreenAdapter.height(20)),
              YearTopItem(_yearTop['highRateChinaMovie'],'评分最高华语电影','评分最高'),
              YearTopItem(_yearTop['highRateForeignMovie'],'评分最高外语电影','评分最高'),
              YearTopItem(_yearTop['notInPopular'],'年度最佳冷片','年度电影'),
            ],
          ):BaseLoading(),
          // 高分榜
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
            child: Text('豆瓣高分榜',style: TextStyle(fontSize: 24,color: Colors.black))
          ),
          _categoryTop('爱情',_loveData),
          _categoryTop('喜剧',_comedyData),
          _categoryTop('剧情',_plotData),
          _categoryTop('动画',_animateData),
          _categoryTop('科幻',_scifiData),
          _categoryTop('纪录',_recordData),
          _categoryTop('短',_shortData),
          _categoryTop('同性',_sameSexData),
          _categoryTop('音乐',_musicData),
          _categoryTop('歌舞',_songAndDanceData),
        ],
      )
    );
  }
  // 单个分类
  Widget _categoryTop(title,data){
    return Column(
      children: <Widget>[
        data != null ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
              child: Text('$title片TOP20',style: TextStyle(fontSize: 22,color: Colors.black))
            ),
            Row(
              children: <Widget>[
                Text('全部',style: TextStyle(color:Colors.black87,fontSize: 16)),
                Icon(Icons.keyboard_arrow_right,color:Colors.black87)
              ],
            )
          ],
        ):Container(),
        data != null ? GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 3,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //横轴元素个数
            crossAxisCount: 3,
            //纵轴间距
            //横轴间距
            crossAxisSpacing: 10.0,
            //子组件宽高长度比例
            childAspectRatio: ScreenAdapter.getScreenWidth() / 3 /  ScreenAdapter.height(420)
          ),
          itemBuilder: (context,index){
            Map item = data['subject_collection_items'][index];
            return GestureDetector(
              onTap: (){
                Application.router.navigateTo(context, '/filmDetail?id=${item['id']}');
              },
              child: Container(
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      child: Image.network('${item['cover']['url']}',
                      width: double.infinity,
                      height:ScreenAdapter.height(260),fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: ScreenAdapter.height(10),bottom: ScreenAdapter.height(10)),
                      alignment: Alignment.centerLeft,
                      child: Text('${item['title']}',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600)),
                    ),
                    BaseGrade(value: item['rating']['value'])
                  ]
                ),
              ),
            );
          },
        ):Container()
      ],
    );
  }

}