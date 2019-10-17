class ApiPath{

  static Map home  ={
    // 电影主页
    'home': 'https://frodo.douban.com/api/v2/movie/modules?loc_id=108288&udid=b176e8889c7eb022716e7c4195eceada4be0be40&rom=android&apikey=0dad551ec0f84ed02907ff5c42e8ec70&s=rexxar_new&channel=Douban&device_id=b176e8889c7eb022716e7c4195eceada4be0be40&os_rom=android&apple=f177f7210511568811cc414dd5ed6f50&icecream=7a77f8513a214ec8aaabf90e4ca99089&mooncake=3117c7243ba057a6c140fe27cee889a8&sugar=46000&_sig=2dcg1ysS3J5b9xNZDVRFcsKJ8zI%3D&_ts=1571195046',
    // 今日播放
    'todayPlay':'https://frodo.douban.com/api/v2/skynet/playlist/recommend/event_videos?count=3&out_skynet=true&udid=b176e8889c7eb022716e7c4195eceada4be0be40&rom=android&apikey=0dad551ec0f84ed02907ff5c42e8ec70&s=rexxar_new&channel=Douban&device_id=b176e8889c7eb022716e7c4195eceada4be0be40&os_rom=android&apple=f177f7210511568811cc414dd5ed6f50&icecream=7a77f8513a214ec8aaabf90e4ca99089&mooncake=3117c7243ba057a6c140fe27cee889a8&sugar=46000&loc_id=108288&_sig=tgGcHejGvKS%2Fmx88IKR1e%2BC2Ft0%3D&_ts=1571195046',
    // 院线电影 - 正在热映
    'movieIsHot':'https://frodo.douban.com/api/v2/subject_collection/movie_showing/subjects?count=10&loc_id=108288&os_rom=android&apikey=0dad551ec0f84ed02907ff5c42e8ec70&channel=Douban&udid=b176e8889c7eb022716e7c4195eceada4be0be40&_sig=1dd1SGnPNGeRHECPIA6FEviVmLY%3D&_ts=1571293796',
    // 原先电影 - 即将上映
    'movieSoon':'https://frodo.douban.com/api/v2/subject_collection/movie_soon/subjects?count=10&loc_id=108288&os_rom=android&apikey=0dad551ec0f84ed02907ff5c42e8ec70&channel=Douban&udid=b176e8889c7eb022716e7c4195eceada4be0be40&_sig=CpRjJ8iYI833wFTfAm6fLQn%2FfXU%3D&_ts=1571298747',
  };

}