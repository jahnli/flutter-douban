String baseUrl = 'https://frodo.douban.com/api/v2';
String baseParams = 'udid=5440f7d1721c7ec5444c588d26ec3c6b26996bbd&rom=android&apikey=0dad551ec0f84ed02907ff5c42e8ec70&s=rexxar_new&channel=Douban&device_id=5440f7d1721c7ec5444c588d26ec3c6b26996bbd&os_rom=android&apple=05a7f1aebedb438a6c6488e5a77865e8&icecream=46ab93f9ce8d30cfbecf92fef4a67cfc&mooncake=85b03e07e49eec172718cf3eb73c6bfd&loc_id=108288&_sig=zIqZvzyl6vm5%2Bwptb%2FoyURILcR8%3D&_ts=1572492978';
class ApiPath{

  static Map home  ={
    // 电影主页
    'home': '$baseUrl/movie/modules?loc_id=108288&$baseParams',
    // 今日播放
    'todayPlay':'$baseUrl/skynet/playlist/recommend/event_videos?count=3&out_skynet=true&$baseParams',
    // 院线电影 - 正在热映
    'movieIsHot':'$baseUrl/subject_collection/movie_showing/subjects?count=10&$baseParams',
    // 院线电影 - 即将上映
    'movieSoon':'$baseUrl/subject_collection/movie_soon/subjects?count=10&$baseParams',
    // 豆瓣热门
    'doubanHot':'$baseUrl/subject_collection/movie_hot_gaia/items?count=10&$baseParams',
    // 影片详情
    'filmDetail':'?$baseParams',
    // 豆瓣榜单 - 电影页
    'doubantopMovie':'$baseUrl/movie/rank_list?$baseParams',
    // 书影音 - 推荐
    'movieRecommend':'$baseUrl/movie/recommend',
    // 豆瓣榜单 - 电视页
    'doubanTopTv':'$baseUrl/tv/rank_list?$baseParams',
    // 豆瓣榜单 - 读书页
    'doubanTopBook':'$baseUrl/book/rank_list?$baseParams',
    // 豆瓣榜单 - 小说原创页
    'doubanTopFiction':'$baseUrl/ark/rank_list?$baseParams',
    // 豆瓣榜单 - 年度榜单
    'doubanYearTop':'$baseUrl/movie/year_ranks?$baseParams'
  };

}