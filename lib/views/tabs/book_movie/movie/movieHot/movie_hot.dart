import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/api/api_config.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class MovieHot extends StatefulWidget {
  @override
  _MovieHotState createState() => _MovieHotState();
}

class _MovieHotState extends State<MovieHot> {

  // 热门电影列表
  List _movieHot  = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }
  
  // 获取数据
  _getData()async{
   try{
      Map<String,dynamic> params = {
        "type":'movie',
        "tag":'热门',
        "page_limit":6,
        "page_start":0
      };
      Response res = await ApiConfig.ajax('get', 'https://movie.douban.com/j/search_subjects', params);
      if (mounted) {
        setState(() {
          _movieHot = res.data['subjects']; 
        });        
      }

   }
   catch(e){

   }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('豆瓣热门',style: TextStyle(fontSize: 24,color:Colors.black,fontWeight: FontWeight.w600)),
            GestureDetector(
              onTap: (){
                Application.router.navigateTo(context, '/movieHotDetail');
              },
              child: Row(
                children: <Widget>[
                  Text('全部',style: TextStyle(fontSize: 17,color:Colors.black,fontWeight: FontWeight.w600)),
                  Icon(Icons.chevron_right)
                ],
              ),
            )
          ],
        ),
        SizedBox(height: ScreenAdapter.height(20)),
        GridView.builder(
          shrinkWrap: true,
          physics:NeverScrollableScrollPhysics() ,
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
            return GestureDetector(
              onTap:(){
                Application.router.navigateTo(context, '/movieDetail?id=${_movieHot[index]['id']}');
              },
              child: Container(
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      child: Image.network('${_movieHot[index]['cover']}',
                      width: double.infinity,
                      height:ScreenAdapter.height(260),fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: ScreenAdapter.height(10),bottom: ScreenAdapter.height(10)),
                      alignment: Alignment.centerLeft,
                      child: Text('${_movieHot[index]['title']}',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600)),
                    ),
                    Row(
                      children: <Widget>[
                        RatingBarIndicator(
                          rating:double.parse(_movieHot[index]['rate']) / 2,
                          alpha:0,
                          unratedColor:Colors.grey,
                          itemPadding: EdgeInsets.all(0),
                          itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 12,
                        ),
                        SizedBox(width: ScreenAdapter.width(20)),
                        Text('${_movieHot[index]['rate']}',style: TextStyle(fontSize: 12,color: Colors.grey))
                      ],
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: _movieHot.length
        ),
      ],
    );
  }
}