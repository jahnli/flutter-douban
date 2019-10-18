import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_douban/api/api_config.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/weiget/base_loading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailAlsoLike extends StatefulWidget {

  // 类型
  String _type = '';
  final bool _isDark;
  DetailAlsoLike(this._type,this._isDark);

  @override
  _DetailAlsoLikeState createState() => _DetailAlsoLikeState();
}

class _DetailAlsoLikeState extends State<DetailAlsoLike> {

  // 可能喜欢列表
  List _alsoLikeList = [];
  Color _baseTextColor;
  // 
  String _requestStatus = '';

  @override
  void initState() { 
    super.initState();
    _baseTextColor = widget._isDark == true ? Colors.white:Colors.black;
    _getAlsoLike();
  }
  // 获取也可能喜欢
  _getAlsoLike()async{
    try {
      Map<String,dynamic> params = {
        'tag':widget._type,
        'page_start':0,
        'page_limit':8
      };
      Response res = await ApiConfig.ajax('get', 'https://movie.douban.com/j/search_subjects', params);
      if(mounted){
        if( res.data['subjects'].length > 0){
          setState(() {
            _alsoLikeList = res.data['subjects'];
          });
        }else{
          setState(() {
            _requestStatus = '暂无推荐影片'; 
          });
        }
      }
    } catch (e) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.all(0),
            title: Text('喜欢这部电影的也喜欢',style: TextStyle(color: _baseTextColor,fontSize: 20)),
            trailing: Icon(Icons.keyboard_arrow_right,color: _baseTextColor,size: 28),
          ),
          _alsoLikeList.length > 0 ? _item(_alsoLikeList):BaseLoading(),
        ],
      ),
    );
  }

  // 热映
  Widget _item(data){
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //横轴元素个数
        crossAxisCount: 4,
        //纵轴间距
        //横轴间距
        crossAxisSpacing: 8,
        //子组件宽高长度比例
        childAspectRatio: ScreenAdapter.getScreenWidth() / 6 /  ScreenAdapter.height(220)
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: (){
            Application.router.navigateTo(context, '/movieDetail?id=${data[index]['id']}');
          },
          child: Container(
            child: Column(
              children: <Widget>[
                ClipRRect(
                  child: Image.network('${data[index]['cover']}',
                  width: double.infinity,
                  height:ScreenAdapter.height(180),fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(5),
                ),
                Container(
                  margin: EdgeInsets.only(top: ScreenAdapter.height(10),bottom: ScreenAdapter.height(10)),
                  alignment: Alignment.centerLeft,
                  child: Text('${data[index]['title']}',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color:_baseTextColor,fontSize: 13,fontWeight: FontWeight.w600)),
                ),
                Row(
                  children: <Widget>[
                    RatingBarIndicator(
                      rating:double.parse(data[index]['rate']) / 2,
                      alpha:0,
                      unratedColor:Colors.grey,
                      itemPadding: EdgeInsets.all(0),
                      itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 10,
                    ),
                    SizedBox(width: ScreenAdapter.width(20)),
                    Text('${data[index]['rate']}',style: TextStyle(fontSize: 11,color: _baseTextColor))
                  ],
                )
              ],
            ),
          ),
        );
      }
    );
  }

}