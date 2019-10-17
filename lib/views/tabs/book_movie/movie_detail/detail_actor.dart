import 'package:flutter/material.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';

class DetailActor extends StatefulWidget {

  final Map _movie;
  final bool _isDark;
  DetailActor(this._movie,this._isDark);

  @override
  _DetailActorState createState() => _DetailActorState();
}

class _DetailActorState extends State<DetailActor> {

  // 演员列表
  List _actor = []; 
  Color _baseTextColor;

  @override
  void initState() { 
    super.initState();
    _baseTextColor = widget._isDark == true ? Colors.white:Colors.black;
    if(mounted){
      widget._movie['directors'].forEach((item){
        item['type'] = '导演';
        _actor.add(item);
      });
      widget._movie['casts'].forEach((item){
        item['type'] = '演员';
        _actor.add(item);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('演职员',style: TextStyle(fontSize: 20,color: _baseTextColor)),
              Row(
                children: <Widget>[
                  Text('全部',style: TextStyle(color: _baseTextColor)),
                  Icon(Icons.keyboard_arrow_right,color:_baseTextColor)
                ],
              )
            ],
          ),
          SizedBox(height: ScreenAdapter.height(30)),
          _actor.length > 0 ? Container(
            height: ScreenAdapter.height(320),
            child: ListView.builder(
              scrollDirection:Axis.horizontal,
              itemBuilder: (context,index){
                return Container(
                  margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network('${_actor[index]['avatars'] == null ? 'https://img3.doubanio.com/f/movie/8dd0c794499fe925ae2ae89ee30cd225750457b4/pics/movie/celebrity-default-medium.png':_actor[index]['avatars']['small']}',width: ScreenAdapter.width(160),fit: BoxFit.cover),
                      ),
                      SizedBox(height: ScreenAdapter.height(10)),
                      Container(
                        width: ScreenAdapter.width(160),
                        child: Text('${_actor[index]['name']}',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 14,color: _baseTextColor)),
                      ),
                      SizedBox(height: ScreenAdapter.height(10)),
                      Container(
                        width: ScreenAdapter.width(160),
                        child: Text('${_actor[index]['type']}',style: TextStyle(fontSize: 12,color: _baseTextColor)),
                      )
                    ],
                  ),
                );
              },
              itemCount: _actor.length,
            ),
          ):Center(
            child: Text('暂无演员表',style: TextStyle(color: _baseTextColor)),
          )
        ],
      ),
    );
  }
}