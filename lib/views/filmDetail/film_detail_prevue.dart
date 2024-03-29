import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/model/filmDetail/film_detail_prevue_model.dart';
import 'package:flutter_douban/netUtils/api.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/utils/configs.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';

class FilmDetailPrevue extends StatefulWidget {

  final String movieId;
  final String type;
  final Function setPrevueTotal;
  FilmDetailPrevue({this.type,this.movieId,this.setPrevueTotal});

  @override
  _FilmDetailPrevueState createState() => _FilmDetailPrevueState();
}

class _FilmDetailPrevueState extends State<FilmDetailPrevue> {

  FilmDetailPrevueModel _data;

  @override
  void initState() { 
    super.initState();
    _getPrevue();
  }

  _getPrevue()async{
    try{
      Response res = await NetUtils.ajax('get', '${ApiPath.home['baseUrl']}/${widget.type}/${widget.movieId}/photos?count=8&${ApiPath.home['baseParams']}');
      if(mounted){
        setState(() {
          _data = FilmDetailPrevueModel.fromJson(res.data); 
        });
        widget.setPrevueTotal(_data.total);
      }
    }
    catch(e){
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    return _data != null ?  Container(
      height: ScreenAdapter.height(300),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection:Axis.horizontal,
        itemBuilder: (context,index){
          return Container(
            margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child:Image.network('${_data.photos[index].image.normal.url}',height: ScreenAdapter.height(Configs.thumbHeight(size: 'xlarge')),width: index == 0 ? ScreenAdapter.width(500):ScreenAdapter.width(300),fit: BoxFit.cover),
                ),
                index == 0 ? Container(
                  alignment: Alignment.center,
                  width: ScreenAdapter.width(500),
                  child: Icon(Icons.play_circle_outline,color: Colors.white,size: 30)
                ):Container()
              ],
            ),
          );
        },
        itemCount: _data.photos.length,
      ),
    ):Container();
  }
}