import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/model/filmDetail/film_detail_related_model.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/utils/configs.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/weiget/base_grade.dart';
class FilmDetailRelated extends StatefulWidget {
  
  String movieId;
  bool isDark;
  FilmDetailRelated({this.movieId,this.isDark});

  @override
  _FilmDetailRelatedState createState() => _FilmDetailRelatedState();
}

class _FilmDetailRelatedState extends State<FilmDetailRelated> {

  FilmDetailRelatedModel _data;
  @override
  void initState() { 
    super.initState();
    _getRelated();
  }

  _getRelated()async{
    try{
      Response res = await NetUtils.ajax('get', 'https://frodo.douban.com/api/v2/movie/${widget.movieId}/related_items?count=10&os_rom=android&apikey=0dad551ec0f84ed02907ff5c42e8ec70&channel=Douban&udid=b176e8889c7eb022716e7c4195eceada4be0be40&_sig=Kky3YAnQsoS7Ij9odRF%2Ftbotpe4%3D&_ts=1571732274');
      if(mounted){
        setState(() {
          _data = FilmDetailRelatedModel.fromJson(res.data); 
        });
      }
    }
    catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _data!= null ? Container(
      height: _data.subjects.length > 0 && _data.doulists.length > 0 ? ScreenAdapter.height(640):ScreenAdapter.height(320),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){
          return Column(
            children: <Widget>[
              _data.subjects.length > 0 ? _film(_data.subjects[index]):Container(),
              SizedBox(height: ScreenAdapter.height(20)),
              _data.doulists.length > 0 ? _gather(_data.doulists[index]):Container(),
            ],
          );
        },
        itemCount: _data.subjects.length,
      )
    ):Container();
  }
  // 片单
  Widget _gather(FilmDetailRelatedModelDoulists item){
    return Container(
      width:ScreenAdapter.width(170),
      margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                child: Image.network('${item.coverUrl}',width: double.infinity,height:ScreenAdapter.height(Configs.thumbHeight(size: 'small')),fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(5),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.only(left: ScreenAdapter.width(5),right: ScreenAdapter.width(10)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Color.fromRGBO(255, 64, 85, 1),
                  ),
                  height: ScreenAdapter.height(30),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.play_arrow,size: 16,),
                      Text('片单',style: TextStyle(fontSize: 12))
                    ],
                  ),
                ),
              )
            ],
          ),
          Container(
            height: ScreenAdapter.height(60),
            margin: EdgeInsets.only(top: ScreenAdapter.height(10)),
            alignment: Alignment.topLeft,
            child: Text('${item.title}',maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          Container(
            margin: EdgeInsets.only(bottom: ScreenAdapter.height(10)),
            alignment: Alignment.centerLeft,
            child: Text('看过 ${item.doneCount} / ${item.itemsCount}',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12)),
          ),
        ],
      )
    );
  }
  // 喜欢的影片
  Widget _film(FilmDetailRelatedModelSubjects item){
    return  GestureDetector(
      onTap: (){
        Application.router.navigateTo(context, '/filmDetail?id=${item.id}');
      },
      child: Container(
        width:ScreenAdapter.width(170),
        margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
        child: Column(
          children: <Widget>[
            ClipRRect(
              child: Image.network('${item.pic.normal}',width: double.infinity,height:ScreenAdapter.height(Configs.thumbHeight(size: 'small')),fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(5),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenAdapter.height(10),bottom: ScreenAdapter.height(10)),
              alignment: Alignment.centerLeft,
              child: Text('${item.title}',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w600)),
            ),
            BaseGrade(nullRatingReason:'',value:item.rating?.value)
          ],
        )
      ),
    );
  }

}