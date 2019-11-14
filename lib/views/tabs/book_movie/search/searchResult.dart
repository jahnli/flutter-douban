import 'package:flutter/material.dart';
import 'package:flutter_douban/views/tabs/book_movie/search/book_movie.dart';
import 'package:flutter_douban/views/tabs/book_movie/search/synthesize.dart';

class BookMovieSearchResult extends StatefulWidget {

  String keyWords = '';
  BookMovieSearchResult({
    @required this.keyWords
  });
  
  @override
  _BookMovieSearchResultState createState() => _BookMovieSearchResultState();
}

class _BookMovieSearchResultState extends State<BookMovieSearchResult> with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() { 
    super.initState();
    _tabController = TabController(
      length: 5,
      vsync: this
    );
  }


  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerScrolled) => <Widget>[
        SliverAppBar(
          backgroundColor: Color.fromRGBO(255, 255, 255,1),
          elevation: 0,
          pinned: true,
          title: TabBar(
            isScrollable: true,
            controller: _tabController,
            labelColor:Colors.black,
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: <Widget>[
              Tab(text: '综合'),
              Tab(text: '书影音'),
              Tab(text: '小组'),
              Tab(text: '日记'),
              Tab(text: '用户')
            ],
          ),
        ),
      ],
      body:TabBarView(
        controller: _tabController,
        children: <Widget>[
          // 综合
          Synthesize(keyWords: widget.keyWords),
          // 书影音
          SearchBookMovie(),
          Text('data'),
          Text('data'),
          Text('data'),
        ],
      )
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


}
