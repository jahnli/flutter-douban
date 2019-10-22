import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/model/filmDetail/film_detail_actor_model.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/utils/configs.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';


class FilmDetailActor extends StatefulWidget {

  String movieId;
  Function setActorTotal;
  FilmDetailActor({this.movieId,this.setActorTotal});

  @override
  _FilmDetailActorState createState() => _FilmDetailActorState();
}

class _FilmDetailActorState extends State<FilmDetailActor> {

  FilmDetailActorModel _data;
  int _showActorCount = 8;
  List _res = [];

  @override
  void initState() { 
    super.initState();
    _getActor();
  }

  _getActor()async{
    try{
      Response res = await NetUtils.ajax('get', 'https://frodo.douban.com/api/v2/movie/${widget.movieId}/celebrities?os_rom=android&apikey=0dad551ec0f84ed02907ff5c42e8ec70&channel=Douban&udid=5440f7d1721c7ec5444c588d26ec3c6b26996bbd&_sig=siDiVxUb%2B%2Bda0ZHtvOe2WIY91cg%3D&_ts=1571710231');
      if(mounted){
        setState(() {
          _data = FilmDetailActorModel.fromJson(res.data); 
        });
        widget.setActorTotal(_data.total);
        List _directors = _data.directors.length > 2 ? _data.directors.sublist(0,2):_data.directors;
        _directors.forEach((item){
          _res.add({
            "character":item.character,
            "name":item.name,
            'url':item.coverUrl
          });
        });

        List _actors = _data.actors.length > _showActorCount - _directors.length  ? _data.actors.sublist(0,_showActorCount - _directors.length):_data.actors;
        _actors.forEach((item){
          _res.add({
            "character":item.character,
            "name":item.name,
            'url':item.coverUrl
          });
        });
      }
    }
    catch(e){
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenAdapter.height(320),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){
          return Container(
            margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
            child: Column(
              children: <Widget>[
                ClipRRect(
                  child: Image.network('${_res[index]['url']}',width: ScreenAdapter.width(160),height:ScreenAdapter.height(Configs.thumbHeight(size: 'small')),fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(5),
                ),
                Container(
                  width: ScreenAdapter.width(160),
                  margin: EdgeInsets.only(top: ScreenAdapter.height(10),bottom: ScreenAdapter.height(10)),
                  alignment: Alignment.centerLeft,
                  child: Text('${_res[index]['name']}',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 16)),
                ),
                Container(
                  width: ScreenAdapter.width(160),
                  alignment: Alignment.centerLeft,
                  child: Text('${_res[index]['character']}',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.grey)),
                )
              ],
            ),
          );
        },
        itemCount: _res.length,
      ),
    );
  }
}