///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class FilmDetailRelatedModelDoulistsOwnerLoc {
/*
{
  "id": "108288",
  "name": "北京",
  "uid": "beijing"
} 
*/

  String id;
  String name;
  String uid;

  FilmDetailRelatedModelDoulistsOwnerLoc({
    this.id,
    this.name,
    this.uid,
  });
  FilmDetailRelatedModelDoulistsOwnerLoc.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toString();
    name = json["name"]?.toString();
    uid = json["uid"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["name"] = name;
    data["uid"] = uid;
    return data;
  }
}

class FilmDetailRelatedModelDoulistsOwner {
/*
{
  "loc": {
    "id": "108288",
    "name": "北京",
    "uid": "beijing"
  },
  "kind": "user",
  "name": "影志",
  "reg_time": "2005-07-18 14:53:53",
  "url": "https://www.douban.com/people/1005928/",
  "uri": "douban://douban.com/user/1005928",
  "avatar": "https://img1.doubanio.com/icon/up1005928-127.jpg",
  "type": "user",
  "id": "1005928",
  "uid": "tjz230"
} 
*/

  FilmDetailRelatedModelDoulistsOwnerLoc loc;
  String kind;
  String name;
  String regTime;
  String url;
  String uri;
  String avatar;
  String type;
  String id;
  String uid;

  FilmDetailRelatedModelDoulistsOwner({
    this.loc,
    this.kind,
    this.name,
    this.regTime,
    this.url,
    this.uri,
    this.avatar,
    this.type,
    this.id,
    this.uid,
  });
  FilmDetailRelatedModelDoulistsOwner.fromJson(Map<String, dynamic> json) {
    loc = json["loc"] != null ? FilmDetailRelatedModelDoulistsOwnerLoc.fromJson(json["loc"]) : null;
    kind = json["kind"]?.toString();
    name = json["name"]?.toString();
    regTime = json["reg_time"]?.toString();
    url = json["url"]?.toString();
    uri = json["uri"]?.toString();
    avatar = json["avatar"]?.toString();
    type = json["type"]?.toString();
    id = json["id"]?.toString();
    uid = json["uid"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (loc != null) {
      data["loc"] = loc.toJson();
    }
    data["kind"] = kind;
    data["name"] = name;
    data["reg_time"] = regTime;
    data["url"] = url;
    data["uri"] = uri;
    data["avatar"] = avatar;
    data["type"] = type;
    data["id"] = id;
    data["uid"] = uid;
    return data;
  }
}

class FilmDetailRelatedModelDoulists {
/*
{
  "category": "movie",
  "alg_json": "{\"model\":\"hot\",\"n_followers\":105724,\"item_kind\":\"1002\"}",
  "is_merged_cover": true,
  "sharing_url": "https://www.douban.com/doubanapp/dispatch?uri=/doulist/30299/",
  "title": "豆瓣电影【口碑榜】2019-10-19 更新",
  "url": "https://www.douban.com/doulist/30299/",
  "uri": "douban://douban.com/doulist/30299",
  "cover_url": "https://img1.doubanio.com/dae/frodo/img_handler/doulist_cover/30299/round_rec",
  "icon_text": "片单",
  "items_count": 1965,
  "followers_count": 105724,
  "owner": {
    "loc": {
      "id": "108288",
      "name": "北京",
      "uid": "beijing"
    },
    "kind": "user",
    "name": "影志",
    "reg_time": "2005-07-18 14:53:53",
    "url": "https://www.douban.com/people/1005928/",
    "uri": "douban://douban.com/user/1005928",
    "avatar": "https://img1.doubanio.com/icon/up1005928-127.jpg",
    "type": "user",
    "id": "1005928",
    "uid": "tjz230"
  },
  "type": "doulist",
  "id": "30299",
  "done_count": 0
} 
*/

  String category;
  String algJson;
  bool isMergedCover;
  String sharingUrl;
  String title;
  String url;
  String uri;
  String coverUrl;
  String iconText;
  int itemsCount;
  int followersCount;
  FilmDetailRelatedModelDoulistsOwner owner;
  String type;
  String id;
  int doneCount;

  FilmDetailRelatedModelDoulists({
    this.category,
    this.algJson,
    this.isMergedCover,
    this.sharingUrl,
    this.title,
    this.url,
    this.uri,
    this.coverUrl,
    this.iconText,
    this.itemsCount,
    this.followersCount,
    this.owner,
    this.type,
    this.id,
    this.doneCount,
  });
  FilmDetailRelatedModelDoulists.fromJson(Map<String, dynamic> json) {
    category = json["category"]?.toString();
    algJson = json["alg_json"]?.toString();
    isMergedCover = json["is_merged_cover"];
    sharingUrl = json["sharing_url"]?.toString();
    title = json["title"]?.toString();
    url = json["url"]?.toString();
    uri = json["uri"]?.toString();
    coverUrl = json["cover_url"]?.toString();
    iconText = json["icon_text"]?.toString();
    itemsCount = json["items_count"]?.toInt();
    followersCount = json["followers_count"]?.toInt();
    owner = json["owner"] != null ? FilmDetailRelatedModelDoulistsOwner.fromJson(json["owner"]) : null;
    type = json["type"]?.toString();
    id = json["id"]?.toString();
    doneCount = json["done_count"]?.toInt();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["category"] = category;
    data["alg_json"] = algJson;
    data["is_merged_cover"] = isMergedCover;
    data["sharing_url"] = sharingUrl;
    data["title"] = title;
    data["url"] = url;
    data["uri"] = uri;
    data["cover_url"] = coverUrl;
    data["icon_text"] = iconText;
    data["items_count"] = itemsCount;
    data["followers_count"] = followersCount;
    if (owner != null) {
      data["owner"] = owner.toJson();
    }
    data["type"] = type;
    data["id"] = id;
    data["done_count"] = doneCount;
    return data;
  }
}

class FilmDetailRelatedModelSubjectsPic {
/*
{
  "large": "https://img1.doubanio.com/view/photo/m_ratio_poster/public/p2541901817.webp",
  "normal": "https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2541901817.webp"
} 
*/

  String large;
  String normal;

  FilmDetailRelatedModelSubjectsPic({
    this.large,
    this.normal,
  });
  FilmDetailRelatedModelSubjectsPic.fromJson(Map<String, dynamic> json) {
    large = json["large"]?.toString();
    normal = json["normal"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["large"] = large;
    data["normal"] = normal;
    return data;
  }
}

class FilmDetailRelatedModelSubjectsRating {
/*
{
  "count": 491804,
  "max": 10,
  "star_count": 3,
  "value": 6.4
} 
*/

  int count;
  int max;
  int starCount;
  double value;

  FilmDetailRelatedModelSubjectsRating({
    this.count,
    this.max,
    this.starCount,
    this.value,
  });
  FilmDetailRelatedModelSubjectsRating.fromJson(Map<String, dynamic> json) {
    count = json["count"]?.toInt();
    max = json["max"]?.toInt();
    starCount = json["star_count"]?.toInt();
    value = json["value"]?.toDouble();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["count"] = count;
    data["max"] = max;
    data["star_count"] = starCount;
    data["value"] = value;
    return data;
  }
}

class FilmDetailRelatedModelSubjects {
/*
{
  "rating": {
    "count": 491804,
    "max": 10,
    "star_count": 3,
    "value": 6.4
  },
  "alg_json": "{\"card_type\":\"movie\",\"source\":\"mf_tag\",\"group\":\"mf_tag_movie\",\"reason_data\":[[\"director\",\"1274265\",{}],[\"tag_descr\",null,{\"tags\":[\"中国大陆\",\"黑色幽默\",\"搞笑\"]}]],\"id\":\"25986662\",\"alg_strategy\":\"user_movie\"}",
  "sharing_url": "https://www.douban.com/doubanapp/dispatch/movie/25986662",
  "title": "疯狂的外星人",
  "url": "https://movie.douban.com/subject/25986662/",
  "pic": {
    "large": "https://img1.doubanio.com/view/photo/m_ratio_poster/public/p2541901817.webp",
    "normal": "https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2541901817.webp"
  },
  "uri": "douban://douban.com/movie/25986662",
  "interest": null,
  "type": "movie",
  "id": "25986662"
} 
*/

  FilmDetailRelatedModelSubjectsRating rating;
  String algJson;
  String sharingUrl;
  String title;
  String url;
  FilmDetailRelatedModelSubjectsPic pic;
  String uri;
  String interest;
  String type;
  String id;

  FilmDetailRelatedModelSubjects({
    this.rating,
    this.algJson,
    this.sharingUrl,
    this.title,
    this.url,
    this.pic,
    this.uri,
    this.interest,
    this.type,
    this.id,
  });
  FilmDetailRelatedModelSubjects.fromJson(Map<String, dynamic> json) {
    rating = json["rating"] != null ? FilmDetailRelatedModelSubjectsRating.fromJson(json["rating"]) : null;
    algJson = json["alg_json"]?.toString();
    sharingUrl = json["sharing_url"]?.toString();
    title = json["title"]?.toString();
    url = json["url"]?.toString();
    pic = json["pic"] != null ? FilmDetailRelatedModelSubjectsPic.fromJson(json["pic"]) : null;
    uri = json["uri"]?.toString();
    interest = json["interest"]?.toString();
    type = json["type"]?.toString();
    id = json["id"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (rating != null) {
      data["rating"] = rating.toJson();
    }
    data["alg_json"] = algJson;
    data["sharing_url"] = sharingUrl;
    data["title"] = title;
    data["url"] = url;
    if (pic != null) {
      data["pic"] = pic.toJson();
    }
    data["uri"] = uri;
    data["interest"] = interest;
    data["type"] = type;
    data["id"] = id;
    return data;
  }
}

class FilmDetailRelatedModel {
/*
{
  "subjects": [
    {
      "rating": {
        "count": 491804,
        "max": 10,
        "star_count": 3,
        "value": 6.4
      },
      "alg_json": "{\"card_type\":\"movie\",\"source\":\"mf_tag\",\"group\":\"mf_tag_movie\",\"reason_data\":[[\"director\",\"1274265\",{}],[\"tag_descr\",null,{\"tags\":[\"中国大陆\",\"黑色幽默\",\"搞笑\"]}]],\"id\":\"25986662\",\"alg_strategy\":\"user_movie\"}",
      "sharing_url": "https://www.douban.com/doubanapp/dispatch/movie/25986662",
      "title": "疯狂的外星人",
      "url": "https://movie.douban.com/subject/25986662/",
      "pic": {
        "large": "https://img1.doubanio.com/view/photo/m_ratio_poster/public/p2541901817.webp",
        "normal": "https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2541901817.webp"
      },
      "uri": "douban://douban.com/movie/25986662",
      "interest": null,
      "type": "movie",
      "id": "25986662"
    }
  ],
  "uri": "douban://douban.com/movie/recommend_tag?from_subject=1&type=like_like&id=32659890",
  "doulists": [
    {
      "category": "movie",
      "alg_json": "{\"model\":\"hot\",\"n_followers\":105724,\"item_kind\":\"1002\"}",
      "is_merged_cover": true,
      "sharing_url": "https://www.douban.com/doubanapp/dispatch?uri=/doulist/30299/",
      "title": "豆瓣电影【口碑榜】2019-10-19 更新",
      "url": "https://www.douban.com/doulist/30299/",
      "uri": "douban://douban.com/doulist/30299",
      "cover_url": "https://img1.doubanio.com/dae/frodo/img_handler/doulist_cover/30299/round_rec",
      "icon_text": "片单",
      "items_count": 1965,
      "followers_count": 105724,
      "owner": {
        "loc": {
          "id": "108288",
          "name": "北京",
          "uid": "beijing"
        },
        "kind": "user",
        "name": "影志",
        "reg_time": "2005-07-18 14:53:53",
        "url": "https://www.douban.com/people/1005928/",
        "uri": "douban://douban.com/user/1005928",
        "avatar": "https://img1.doubanio.com/icon/up1005928-127.jpg",
        "type": "user",
        "id": "1005928",
        "uid": "tjz230"
      },
      "type": "doulist",
      "id": "30299",
      "done_count": 0
    }
  ]
} 
*/

  List<FilmDetailRelatedModelSubjects> subjects;
  String uri;
  List<FilmDetailRelatedModelDoulists> doulists;

  FilmDetailRelatedModel({
    this.subjects,
    this.uri,
    this.doulists,
  });
  FilmDetailRelatedModel.fromJson(Map<String, dynamic> json) {
  if (json["subjects"] != null) {
  var v = json["subjects"];
  var arr0 = List<FilmDetailRelatedModelSubjects>();
  v.forEach((v) {
  arr0.add(FilmDetailRelatedModelSubjects.fromJson(v));
  });
    subjects = arr0;
    }
    uri = json["uri"]?.toString();
  if (json["doulists"] != null) {
  var v = json["doulists"];
  var arr0 = List<FilmDetailRelatedModelDoulists>();
  v.forEach((v) {
  arr0.add(FilmDetailRelatedModelDoulists.fromJson(v));
  });
    doulists = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (subjects != null) {
      var v = subjects;
      var arr0 = List();
  v.forEach((v) {
  arr0.add(v.toJson());
  });
      data["subjects"] = arr0;
    }
    data["uri"] = uri;
    if (doulists != null) {
      var v = doulists;
      var arr0 = List();
  v.forEach((v) {
  arr0.add(v.toJson());
  });
      data["doulists"] = arr0;
    }
    return data;
  }
}
