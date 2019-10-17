import 'package:flutter/material.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
class DetailPlot extends StatefulWidget {

  final Map _movie;
  final bool _isDark;
  DetailPlot(this._movie,this._isDark);

  @override
  _DetailPlotState createState() => _DetailPlotState();
}

class _DetailPlotState extends State<DetailPlot> {

  // 剧情简介显示更多
  int _showMore = 4;
  Color _baseTextColor;

  @override
  void initState() { 
    super.initState();
    _baseTextColor = widget._isDark == true ? Colors.white:Colors.black;
  }

  @override
  Widget build(BuildContext context) {
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
                      Text('${widget._movie['genres'][index]}',style: TextStyle(fontSize: 14,color: _baseTextColor)),
                      Icon(Icons.keyboard_arrow_right,color:widget._isDark ? Colors.grey[400]:Colors.grey[600],size: 18,)
                    ],
                  ),
                );
              },
              itemCount: widget._movie['genres'].length,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: ScreenAdapter.height(30)),
            alignment: Alignment.centerLeft,
            child: Text('剧情简介',style: TextStyle(fontSize: 20,color: _baseTextColor)),
          ),
          Container(
            margin: EdgeInsets.only(top: ScreenAdapter.height(15)),
            alignment: Alignment.centerLeft,
            child: Text('${widget._movie['summary']}',style: TextStyle(fontSize: 16,color: _baseTextColor),maxLines: _showMore,overflow: TextOverflow.ellipsis,),
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
}