import 'package:flutter/material.dart';
import 'package:flutter_douban/model/doubanTop/movie.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';

class YearTopItem extends StatelessWidget {

  final DoubanTopMovieModelGroupsSelectedCollections data;
  YearTopItem(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenAdapter.getScreenWidth(),
      height: ScreenAdapter.height(180),
      margin: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(int.parse('0xff' + data.backgroundColorScheme.primaryColorDark)),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            child: ClipPath(
              clipper: CustomCliper(),
              child: Image.network('${data.headerBgImage}',fit: BoxFit.cover,width: ScreenAdapter.width(300),height: ScreenAdapter.height(180)),
            ),
          ),
          Positioned(
            child: Container(
              padding: EdgeInsets.only(
                top: ScreenAdapter.height(30),
                left: ScreenAdapter.height(30)
              ),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text('${data.typeIconBgText}',style: TextStyle(color: Color(int.parse('0xff' + data.backgroundColorScheme.primaryColorLight)),fontWeight: FontWeight.bold,fontSize: 28)),
                      ),
                      Positioned(
                        top: ScreenAdapter.height(10),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text('${data.typeText}',style: TextStyle(color: Colors.grey[300])),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: ScreenAdapter.height(10)),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text('${data.mediumName}',style: TextStyle(fontSize: 24)),
                  )
                ],
              )
            )
          )
        ],
      )
    );
  }
   

}

class CustomCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..lineTo(size.width+ScreenAdapter.width(35),0)
      ..lineTo(size.height, size.width)
      ..lineTo(0, size.height)
      ..lineTo(size.width - ScreenAdapter.width(200), 0)
      ..close();
    return path;
  }
 //是否重新裁剪
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}