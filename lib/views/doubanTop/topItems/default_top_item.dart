import 'package:flutter/material.dart';
import 'package:flutter_douban/model/doubanTop/movie.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';

class DefaultTopItem extends StatelessWidget {

  final DoubanTopMovieModelGroupsSelectedCollections data;
  final bool showTrend;
  DefaultTopItem(this.data,{this.showTrend = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(int.parse('0xff' + data.backgroundColorScheme.primaryColorDark)),
      ),
      height: ScreenAdapter.height(170),
      child: Row(
        children: <Widget>[
           _title(data),
          Expanded(
            child: _content(
              data:data.items,
              bg:data.headerBgImage,
              bgColor:data.backgroundColorScheme.primaryColorDark,
              showTrend:showTrend
            ),
          ),
        ],
      ),
    );
  }

  // 左侧头部
  Widget _title(DoubanTopMovieModelGroupsSelectedCollections data){
    return Container(
      width: ScreenAdapter.width(210),
      child: data.iconFgImage.isEmpty ? Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text('${data.typeIconBgText}',style: TextStyle(color: Color(int.parse('0xff' + data.backgroundColorScheme.primaryColorLight)),fontWeight: FontWeight.bold,fontSize: 28)),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text('${data.typeText}',style: TextStyle(color: Colors.grey[200])),
                ),
                SizedBox(height: ScreenAdapter.height(10)),
                Container(
                  padding:EdgeInsets.only(left: ScreenAdapter.width(20),right: ScreenAdapter.width(20)) ,
                  child: Text('${data.mediumName}',textAlign: TextAlign.center,style: TextStyle(fontSize: 20)),
                )
              ],
            ),
          )
        ],
      ):Image.network('${data.iconFgImage}',fit: BoxFit.cover),
    );
  }

    // 中间内容
  Widget _content({data,bg,bgColor,showTrend}){
    return Container(
      child:Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius:BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            child: Image.network('$bg',fit: BoxFit.cover,width: ScreenAdapter.getScreenWidth()),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            child: Opacity(
              child: Container(
                color: Color(int.parse('0xff'+bgColor))
              ),
              opacity: 0.7,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: ScreenAdapter.width(30),right: ScreenAdapter.width(30)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:data.asMap().keys.map<Widget>((index){
                DoubanTopMovieModelGroupsSelectedCollectionsItems _item = data[index];
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: ScreenAdapter.height(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: _item.title.length > 10 ? ScreenAdapter.width(290):null,
                            child: Text('${index+1}.${_item.title}',overflow: TextOverflow.ellipsis,maxLines: 1,),
                          ),
                          SizedBox(width: ScreenAdapter.width(10)),
                          Text('${_item.rating.value}',style: TextStyle(color: Color(int.parse('0xff' + 'ffac2d')))),
                        ],
                      ),
                      Container(
                        width: ScreenAdapter.width(50),
                        child: showTrend ? Icon(_item.trendUp == true ? Icons.arrow_upward : Icons.arrow_downward,color: Colors.grey,size: 16):Container(),
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
  
}