import 'package:flutter/material.dart';
import 'package:flutter_douban/model/doubanTop/movie.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/utils/configs.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/weiget/base_grade.dart';

class CategoryTop20 extends StatelessWidget {

  DoubanTopMovieModelGroupsSelectedCollections data;
  CategoryTop20(this.data);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        data != null ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
              child: Text('${data.mediumName}${data.typeIconBgText}',style: TextStyle(fontSize: 22,color: Colors.black))
            ),
            Row(
              children: <Widget>[
                Text('全部',style: TextStyle(color:Colors.black87,fontSize: 16)),
                Icon(Icons.keyboard_arrow_right,color:Colors.black87)
              ],
            )
          ],
        ):Container(),
        data != null ? GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 3,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //横轴元素个数
            crossAxisCount: 3,
            //纵轴间距
            //横轴间距
            crossAxisSpacing: 10.0,
            //子组件宽高长度比例
            childAspectRatio: ScreenAdapter.getScreenWidth() / 3 /  ScreenAdapter.height(420)
          ),
          itemBuilder: (context,index){
            DoubanTopMovieModelGroupsSelectedCollectionsItems item = data.items[index];
            return GestureDetector(
              onTap: (){
                Application.router.navigateTo(context, '/filmDetail?id=${item.id}&type=${item.type}');
              },
              child: Container(
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      child: Image.network('${item.pic.normal}',
                      width: double.infinity,
                      height:ScreenAdapter.height(Configs.thumbHeight(size: 'large')),fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: ScreenAdapter.height(10),bottom: ScreenAdapter.height(10)),
                      alignment: Alignment.centerLeft,
                      child: Text('${item.title}',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600)),
                    ),
                    BaseGrade(value: item.rating.value,nullRatingReason: item.nullRatingReason,)
                  ]
                ),
              ),
            );
          },
        ):Container()
      ],
    );
  }
}