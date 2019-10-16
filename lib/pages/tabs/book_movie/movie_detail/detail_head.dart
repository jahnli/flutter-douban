import 'package:flutter/material.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';

class DetailHead extends StatefulWidget {

  Map _movie;
  bool _isDark;
  List _honorInfo;
  DetailHead(this._movie,this._honorInfo,this._isDark);

  @override
  _DetailHeadState createState() => _DetailHeadState();
}

class _DetailHeadState extends State<DetailHead> {

  Color _baseTextColor;

  @override
  void initState() { 
    super.initState();
    _baseTextColor = widget._isDark == true ? Colors.white:Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network('${widget._movie['images']['small']}',fit: BoxFit.cover,width: ScreenAdapter.width(200),height: ScreenAdapter.height(240)),
          ),
          SizedBox(width: ScreenAdapter.width(30)),
          Expanded(
            child: Container(
              constraints: BoxConstraints(
                minHeight: ScreenAdapter.height(240)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: ScreenAdapter.height(10)),
                    child: Text('${widget._movie['title']}',style: TextStyle(color:_baseTextColor,fontSize: 24,fontWeight: FontWeight.w600)),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: ScreenAdapter.height(10)),
                    alignment: Alignment.centerLeft,
                    child: Text('${widget._movie['original_title']}',style: TextStyle(color: _baseTextColor,fontSize: 18)),
                  ),
                  // 荣誉 
                  widget._honorInfo.length > 0 ? Container(
                    margin: EdgeInsets.only(bottom: ScreenAdapter.height(10)),
                    child:Row(
                      children: <Widget>[
                        Container(
                          height: ScreenAdapter.height(30),
                          padding: EdgeInsets.only(left: ScreenAdapter.width(8),right: ScreenAdapter.width(8)),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft:Radius.circular(2),
                              bottomLeft:Radius.circular(2),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromRGBO(255, 243, 230, 1),
                                Color.fromRGBO(254, 240, 179, 1),
                              ]
                            )
                          ),
                          child:Text('No.${widget._honorInfo[0]['rank']}',style: TextStyle(fontSize: 15,color: Color.fromRGBO(157, 95, 0, 1))),
                        ),
                        Container(
                          height: ScreenAdapter.height(30),
                          padding: EdgeInsets.only(left: ScreenAdapter.width(8),right: ScreenAdapter.width(8)),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight:Radius.circular(2),
                              bottomRight:Radius.circular(2),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromRGBO(255, 197, 116, 1),
                                Color.fromRGBO(255, 197, 7, 1),
                              ]
                            )
                          ),
                          child:Text('${widget._honorInfo[0]['title']}',style: TextStyle(fontSize: 13.8,color: Color.fromRGBO(157, 95, 0, 1))),
                        )
                      ],
                    ),
                  ):Container(),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: ScreenAdapter.height(10)),
                    child: Text('${widget._movie['countries'][0]} / ${widget._movie['genres'][0]} / ${widget._movie['pubdate']}上映 / 片长${widget._movie['durations'].length != 0 ? widget._movie['durations'][0]:'暂无'}',style: TextStyle(fontSize: 12,color: widget._isDark ? Colors.grey[300]:Colors.grey[600])),
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
            ), 
          ),
        ],
      ),
    );
  }

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