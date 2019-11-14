import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/model/search_last_result_model.dart';
import 'package:flutter_douban/netUtils/api.dart';
import 'package:flutter_douban/netUtils/netUtils.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/weiget/base_components.dart';
import 'package:flutter_douban/weiget/base_loading.dart';
import 'package:flutter_douban/weiget/search/search_row.item.dart';

class Synthesize extends StatefulWidget {

  String keyWords = '';
  Synthesize({@required this.keyWords});

  @override
  _SynthesizeState createState() => _SynthesizeState();
}

class _SynthesizeState extends State<Synthesize> {

  BookMovieSearchLastResultModel _result;
  List _usersData;

  // 获取最终结果
  _getResult()async{
    try {
      Response res = await NetUtils.ajax('get',ApiPath.home['bookMovieSearchLastResult'] + '&q=${widget.keyWords}');
      if(mounted){
        setState(() {
          _result = BookMovieSearchLastResultModel.fromJson(res.data); 
          _usersData = res.data['smart_box'];
        });
      }
    } 
    catch (e) {
    }
  }

  @override
  void initState() { 
    super.initState();
    _getResult();
  }


  @override
  Widget build(BuildContext context) {
    return _result != null ? Container(
      child: ListView(
        children: <Widget>[
          SizedBox(height: ScreenAdapter.height(30)),
          // 书影音
          _result.subjects.length > 0 ? Container(
            color: Colors.white,
            padding:EdgeInsets.only(top:ScreenAdapter.height(30),left: ScreenAdapter.width(30),right: ScreenAdapter.width(30)),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                return SearchRowItem(
                  data:_result.subjects[index],
                );
              },
              itemCount: _result.subjects.length,
            ),
          ):Container(),
          _result.subjects.length > 0 ? _endDesc('更多书影音搜索结果'):Container(),
          _result.subjects.length > 0 ? BaseComponent.septalLine():Container(),
          // 影评
          _result.reviews.items.length > 0 ? Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(ScreenAdapter.width(30),ScreenAdapter.width(30),ScreenAdapter.width(30),0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                final _item = _result.reviews.items[index];
                return BaseComponent.bottomBorderContainer(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('${_item.target.title}',style: TextStyle(fontSize: ScreenAdapter.fontSize(30))),
                            SizedBox(height: ScreenAdapter.height(10)),
                            Text('${_item.target.theAbstract}',maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.grey,fontSize: ScreenAdapter.fontSize(28))),
                            SizedBox(height: ScreenAdapter.height(10)),
                            Text('${_item.target.cardSubtitle}',style: TextStyle(color: Colors.grey,fontSize: ScreenAdapter.fontSize(26))),
                          ],
                        ),
                      ),
                      SizedBox(width: ScreenAdapter.width(20)),
                      _item.target.coverUrl.isNotEmpty ? Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network('${_item.target.coverUrl}',width: ScreenAdapter.width(180),height: ScreenAdapter.height(120),fit: BoxFit.cover,),
                        ),
                      ):Container()
                    ],
                  ),
                );
              },
              itemCount: _result.reviews.items.length,
            ),
          ):Container(),
          _result.reviews.items.length > 0 ? _endDesc(_result.reviews.targetName):Container(),
          _result.reviews.items.length > 0 ? BaseComponent.septalLine():Container(),
          // 话题
          _result.contents.length > 0 ? Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(ScreenAdapter.width(30),ScreenAdapter.width(30),ScreenAdapter.width(30),0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                final _item = _result.contents[index];
                return BaseComponent.bottomBorderContainer(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Icon(Icons.forum,color: Color.fromRGBO(90, 187, 81, 1)),
                                SizedBox(width: ScreenAdapter.width(10)),
                                Expanded(
                                  child: Text('${_item.target.title}',style: TextStyle(fontSize: ScreenAdapter.fontSize(30))),
                                ),
                              ],
                            ),
                            SizedBox(height: ScreenAdapter.height(10)),
                            Text('${_item.target.theAbstract}',maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.grey,fontSize: ScreenAdapter.fontSize(28))),
                            SizedBox(height: ScreenAdapter.height(10)),
                            Text('${_item.target.cardSubtitle}',style: TextStyle(color: Colors.grey,fontSize: ScreenAdapter.fontSize(26))),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: _result.contents.length,
            ),
          ):Container(),
          _usersData.length > 0 ? ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context,index){
              return Container(
                color: Colors.white,
                padding: EdgeInsets.all(ScreenAdapter.width(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        ClipOval(
                          child: Image.network('${_usersData[index]['target']['avatar']}',width: ScreenAdapter.width(100),),
                        ),
                        SizedBox(width: ScreenAdapter.width(20)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('${_usersData[index]['type_name']}'),
                            SizedBox(height: ScreenAdapter.height(10)),
                            Text('${_usersData[index]['target']['name']}'),
                            SizedBox(height: ScreenAdapter.height(10)),
                            Text('${_usersData[index]['target']['display_followers_count']}人关注'),
                          ],
                        ),
                      ],
                    ),
                    OutlineButton(
                      onPressed: (){

                      },
                      borderSide:BorderSide(
                        width: 1,
                        color: Color.fromRGBO(90, 187, 81,1)
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.add,color: Color.fromRGBO(90, 187, 81,1),size: 18,),
                          Text('关注',style: TextStyle(color: Color.fromRGBO(90, 187, 81,1)))
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
            itemCount: _usersData.length,
          ):Container()
        ],
      ),
    ):Center(
      child: BaseLoading(),
    );
  }

    // 结尾描述
  Widget _endDesc(String title){
    return Container(
      color: Colors.white,
      padding:EdgeInsets.only(bottom: ScreenAdapter.height(30),left: ScreenAdapter.width(30),right: ScreenAdapter.width(30)),
      child: Row(
        children: <Widget>[
          Text('$title',style: TextStyle(fontSize:ScreenAdapter.fontSize(30))),
          Icon(Icons.keyboard_arrow_right)
        ],
      ),
    );
  }


}