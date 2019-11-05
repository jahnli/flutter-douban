import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/model/doubanTop/movie.dart';
import 'package:flutter_douban/netUtils/api.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/views/doubanTop/topItems/year_top_item.dart';
import 'package:flutter_douban/weiget/base_loading.dart';
import 'package:flutter_douban/weiget/rowTitle.dart';

class DoubanYearTop extends StatefulWidget {
  @override
  _DoubanYearTopState createState() => _DoubanYearTopState();
}

class _DoubanYearTopState extends State<DoubanYearTop> {


  DoubanTopMovieModel _data;

  @override
  void initState() { 
    super.initState();
    _getData();
  }

  _getData()async{
    Response res = await NetUtils.ajax('get',ApiPath.home['doubanYearTop']);
    if(mounted){
      setState(() {
        _data = DoubanTopMovieModel.fromJson(res.data); 
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        textTheme:TextTheme(
          body1:  TextStyle(color: Colors.white)
        )
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('豆瓣榜单',style: TextStyle(fontSize: 20)),
          backgroundColor: Colors.white,
          textTheme: TextTheme(
            title:TextStyle(color: Colors.black)
          ),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          brightness: Brightness.light,
        ),
        body: _data !=null ? Container(
          padding: EdgeInsets.only(left:ScreenAdapter.width(30),right: ScreenAdapter.width(30)),
          child: ListView.builder(
            itemBuilder: (context,index){
              return Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top:ScreenAdapter.height(20),bottom: ScreenAdapter.height(20)),
                      child: Text('${_data.groups[index].title}',style: TextStyle(fontSize: 24,color:Colors.black,fontWeight: FontWeight.w600)),
                    ),
                    Column(
                      children: _data.groups[index].selectedCollections.map((DoubanTopMovieModelGroupsSelectedCollections item){
                        return GestureDetector(
                          child: YearTopItem(item),
                          onTap: (){
                            Application.router.navigateTo(context, '/doubanTopDetail?id=${item.id}&showFilter=false');
                          },
                        );
                      }).toList(),
                    )
                  ],
                ),
              );
            },  
            itemCount: _data.groups.length,
          ),
        ):Center(
          child: BaseLoading(),
        )
      )
    ); 
  }
}