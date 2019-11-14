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
    'doubanYearTop':'$baseUrl/movie/year_ranks?$baseParams',
    // 首页搜索文字
    'bookMovieSearchText':'https://frodo.douban.com/api/v2/search/hot_topic?apple=f177f7210511568811cc414dd5ed6f50&icecream=7a77f8513a214ec8aaabf90e4ca99089&mooncake=3117c7243ba057a6c140fe27cee889a8&webview_ua=Mozilla%2F5.0%20%28Linux%3B%20Android%205.1.1%3B%20mi-4c%20Build%2FLMY47I%3B%20wv%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Version%2F4.0%20Chrome%2F52.0.2743.100%20Mobile%20Safari%2F537.36&screen_width=540&screen_height=960&sugar=46000&source=subject&os_rom=android&apikey=0dad551ec0f84ed02907ff5c42e8ec70&channel=Douban&udid=b176e8889c7eb022716e7c4195eceada4be0be40&_sig=JRTGiYn0IzxVJyw7nvoH8m6nTyw%3D&_ts=1573001577',
    // 书影音搜索推荐结果
    'bookMovieSearchResult':'$baseUrl/search/suggestion?$baseParams',
    // 书影音搜索最终结果
    'bookMovieSearchLastResult':'$baseUrl/search?$baseParams',
    // 书影音搜索最终结果 - 书影音
    'bookMovieSearchTabResult':'$baseUrl/search/subject_tab?$baseParams',
     // 书影音热门搜索推荐
    'searchHot':'$baseUrl/search/hots?$baseParams',
  };

}