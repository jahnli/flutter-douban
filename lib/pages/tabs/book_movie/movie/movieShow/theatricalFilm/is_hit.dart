import 'package:flutter/material.dart';
import 'package:flutter_douban/api/api_config.dart';
import 'package:flutter_douban/routes/application.dart';
import 'package:flutter_douban/utils/screenAdapter/screen_adapter.dart';
import 'package:flutter_douban/weiget/base_grade.dart';
import 'package:flutter_douban/weiget/base_loading.dart';
import 'package:flutter_douban/weiget/custom_scroll_footer.dart';
import 'package:flutter_douban/weiget/custom_scroll_header.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class IsHit extends StatefulWidget {
  @override
  _IsHitState createState() => _IsHitState();
}

class _IsHitState extends State<IsHit> with SingleTickerProviderStateMixin , AutomaticKeepAliveClientMixin{

  // 保持状态
  bool get wantKeepAlive => true;

  // 正在热映列表
  List _isHitList = [];
  // 分页
  int _start = 0;
  // 总数量
  int _total = 0;
  String _requestStatus = '';

  RefreshController _controller = RefreshController();


  @override
  void initState() { 
    super.initState();

    _getIsHit();
  }

  // 获取正在热映列表数据
  _getIsHit() async {

    try {
      Map<String,dynamic> params ={
        'apikey':ApiConfig.apiKey,
        'count':10,
        'start':_start
      };
      var res = await ApiConfig.ajax('get',ApiConfig.baseUrl +  '/v2/movie/in_theaters', params);
      if(mounted){
        setState(() {
          _isHitList.addAll(res.data['subjects']);
          _total = res.data['total'];
        });
      }
    }
    catch (e) {
      print(e);
    }

  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  SmartRefresher(
      controller: _controller,
      enablePullUp: true,
      enablePullDown: true,
      header: CustomScrollHeader(),
      footer: CustomScrollFooter(),
      onRefresh: () async {
        _controller.resetNoData();
        setState(() {
          _isHitList = [];
          _start = 0;
        });
        await _getIsHit();
        _controller.refreshCompleted();
      },
      onLoading: () async {
        if(_start + 10 < _total){
          setState(() {
            _start = _start + 10;
          });
          await _getIsHit();
          _controller.loadComplete();
        }else{
          _controller.loadNoData();
        }
      },
      child: _isHitList.length > 0 ? ListView.builder(
          itemBuilder: (context,index){
            return Container(
              margin: EdgeInsets.only(top:index == 0 ? ScreenAdapter.height(40):ScreenAdapter.height(20)),
              padding: EdgeInsets.only(bottom: ScreenAdapter.height(20)),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.5,
                    color: Colors.grey[300],
                  )
                )
              ),
              child: GestureDetector(
                onTap: (){
                  Application.router.navigateTo(context, '/movieDetail?id=${_isHitList[index]['id']}');
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // 缩略图
                    _thumb(_isHitList[index]), 
                    // 中间信息区域
                    SizedBox(width: ScreenAdapter.width(30)),
                    _info(_isHitList[index]),
                    SizedBox(width: ScreenAdapter.width(30)),
                    // 右侧操作区域
                    _actions(_isHitList[index])
                  ],
                ),
              )
            );
          },
          itemCount: _isHitList.length,
        ):BaseLoading(type: _requestStatus),
    );
  }
  // 右侧操作区域
  Widget _actions(item){
    return Container(
      height: ScreenAdapter.height(240),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: (){

            },
            child: Container(
              padding: EdgeInsets.only(left: ScreenAdapter.width(30),right: ScreenAdapter.width(30),top: ScreenAdapter.width(8),bottom: ScreenAdapter.width(8)),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,color: Colors.pink
                ),
                borderRadius: BorderRadius.circular(3)
              ),
              child: Text('购票',style: TextStyle(fontSize: 13,color: Colors.pink)),
            ),
          ),
          SizedBox(height: ScreenAdapter.height(10)),
          Text('${item['collect_count']}人看过',style: TextStyle(fontSize: 10,color: Colors.grey))
        ],
      )
    );
  }
  // 左侧缩略图
  Widget _thumb(item){
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network('${item['images']['small']}',width: ScreenAdapter.width(200),height: ScreenAdapter.height(220),fit: BoxFit.cover,),
    );
  }

  // 中间信息区域
  Widget _info(item){
    return Expanded(
      child: DefaultTextStyle(
        style: TextStyle(fontSize: 13,color: Colors.grey),
        child: Container(
          constraints: BoxConstraints(
            minHeight: ScreenAdapter.height(220)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(bottom: ScreenAdapter.height(10)),
                child: Text('${item['title']}',maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color:Colors.black)),
              ),
              BaseGrade(item['rating']['stars'], item['rating']['average'], item['mainland_pubdate'],charSize: 13,),
              Container(
                alignment: Alignment.centerLeft,
                child: Text('${item['year']} ${item['directors'].length > 0 ? ' / ' + item['directors'][0]['name']:''}',maxLines: 1,overflow: TextOverflow.ellipsis),
              ),
              Container(
                height: ScreenAdapter.height(35),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: item['genres'].asMap().keys.map<Widget>((index){
                    return Text('${item['genres'][index]} ${index == item['genres'].length - 1 ? '':' / '}');
                  }).toList(),
                ),
              ),
              Container(
                height: ScreenAdapter.height(35),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: item['casts'].asMap().keys.map<Widget>((index){
                    return Text('${item['casts'][index]['name']} ${index == item['casts'].length - 1 ? '':' / '}');
                  }).toList(),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}