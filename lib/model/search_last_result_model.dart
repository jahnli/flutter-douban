///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class BookMovieSearchLastResultModelContentsTarget {
/*
{
  "card_subtitle": "2233篇内容・602.1万次浏览",
  "abstract": "我们总认为父母唠叨、守旧，那如果你成为你爸妈呢？会有什么不同呢？",
  "uri": "douban://douban.com/gallery/topic/72260",
  "title": "如果让你做你自己的爸妈，你会怎样对待童年的你？"
} 
*/

  String cardSubtitle;
  String theAbstract;
  String uri;
  String title;

  BookMovieSearchLastResultModelContentsTarget({
    this.cardSubtitle,
    this.theAbstract,
    this.uri,
    this.title,
  });
  BookMovieSearchLastResultModelContentsTarget.fromJson(Map<String, dynamic> json) {
    cardSubtitle = json["card_subtitle"]?.toString();
    theAbstract = json["abstract"]?.toString();
    uri = json["uri"]?.toString();
    title = json["title"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["card_subtitle"] = cardSubtitle;
    data["abstract"] = theAbstract;
    data["uri"] = uri;
    data["title"] = title;
    return data;
  }
}

class BookMovieSearchLastResultModelContents {
/*
{
  "type_name": "话题",
  "layout": "gallery_topic",
  "target": {
    "card_subtitle": "2233篇内容・602.1万次浏览",
    "abstract": "我们总认为父母唠叨、守旧，那如果你成为你爸妈呢？会有什么不同呢？",
    "uri": "douban://douban.com/gallery/topic/72260",
    "title": "如果让你做你自己的爸妈，你会怎样对待童年的你？"
  },
  "target_type": "gallery_topic"
} 
*/

  String typeName;
  String layout;
  BookMovieSearchLastResultModelContentsTarget target;
  String targetType;

  BookMovieSearchLastResultModelContents({
    this.typeName,
    this.layout,
    this.target,
    this.targetType,
  });
  BookMovieSearchLastResultModelContents.fromJson(Map<String, dynamic> json) {
    typeName = json["type_name"]?.toString();
    layout = json["layout"]?.toString();
    target = json["target"] != null ? BookMovieSearchLastResultModelContentsTarget.fromJson(json["target"]) : null;
    targetType = json["target_type"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["type_name"] = typeName;
    data["layout"] = layout;
    if (target != null) {
      data["target"] = target.toJson();
    }
    data["target_type"] = targetType;
    return data;
  }
}

class BookMovieSearchLastResultModelSubjectsTarget {
/*
{
  "has_linewatch": false,
  "abstract": "",
  "title": "少年的你",
  "uri": "douban://douban.com/movie/30166972",
  "cover_url": "https://qnmob3.doubanio.com/view/photo/large/public/p2572166063.jpg?imageView2/0/q/80/w/9999/h/120/format/webp",
  "year": "2019",
  "card_subtitle": "8.4分 / 2019 / 中国大陆 / 剧情 爱情 犯罪 / 曾国祥 / 周冬雨 易烊千玺",
  "id": "30166972"
} 
*/

  bool hasLinewatch;
  String theAbstract;
  String title;
  String uri;
  String coverUrl;
  String year;
  String cardSubtitle;
  String id;

  BookMovieSearchLastResultModelSubjectsTarget({
    this.hasLinewatch,
    this.theAbstract,
    this.title,
    this.uri,
    this.coverUrl,
    this.year,
    this.cardSubtitle,
    this.id,
  });
  BookMovieSearchLastResultModelSubjectsTarget.fromJson(Map<String, dynamic> json) {
    hasLinewatch = json["has_linewatch"];
    theAbstract = json["abstract"]?.toString();
    title = json["title"]?.toString();
    uri = json["uri"]?.toString();
    coverUrl = json["cover_url"]?.toString();
    year = json["year"]?.toString();
    cardSubtitle = json["card_subtitle"]?.toString();
    id = json["id"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["has_linewatch"] = hasLinewatch;
    data["abstract"] = theAbstract;
    data["title"] = title;
    data["uri"] = uri;
    data["cover_url"] = coverUrl;
    data["year"] = year;
    data["card_subtitle"] = cardSubtitle;
    data["id"] = id;
    return data;
  }
}

class BookMovieSearchLastResultModelSubjects {
/*
{
  "type_name": "电影",
  "layout": "subject",
  "target": {
    "has_linewatch": false,
    "abstract": "",
    "title": "少年的你",
    "uri": "douban://douban.com/movie/30166972",
    "cover_url": "https://qnmob3.doubanio.com/view/photo/large/public/p2572166063.jpg?imageView2/0/q/80/w/9999/h/120/format/webp",
    "year": "2019",
    "card_subtitle": "8.4分 / 2019 / 中国大陆 / 剧情 爱情 犯罪 / 曾国祥 / 周冬雨 易烊千玺",
    "id": "30166972"
  },
  "target_type": "movie"
} 
*/

  String typeName;
  String layout;
  BookMovieSearchLastResultModelSubjectsTarget target;
  String targetType;

  BookMovieSearchLastResultModelSubjects({
    this.typeName,
    this.layout,
    this.target,
    this.targetType,
  });
  BookMovieSearchLastResultModelSubjects.fromJson(Map<String, dynamic> json) {
    typeName = json["type_name"]?.toString();
    layout = json["layout"]?.toString();
    target = json["target"] != null ? BookMovieSearchLastResultModelSubjectsTarget.fromJson(json["target"]) : null;
    targetType = json["target_type"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["type_name"] = typeName;
    data["layout"] = layout;
    if (target != null) {
      data["target"] = target.toJson();
    }
    data["target_type"] = targetType;
    return data;
  }
}

class BookMovieSearchLastResultModelReviewsItemsTarget {
/*
{
  "is_video_cover": false,
  "title": "抄袭的你，如此作呕——这才是真正的沉睡魔咒！（1031最终说明）",
  "abstract": "（此文于10月30日作补充。因底下评论已无法控制所以过后笔者不会再理会混战，各位请尽情随意发泄情绪哈，但依然欢迎私信探讨。P.s.：对本文的修改绝不包括删除原先存在争议的语句表达，只是在保持原文意思的基础上作一定论据补充说明。）\r\n【31日最终补充：一夜之间突然多了5000个踩，以及上百条私信，我去好评帖子看到很多顶“有用”都是刚注册的小号，看来很多不知哪来的人正式涌入了豆瓣发动攻势哈。心疼豆瓣，注册不像虎扑那样存在门槛，资本公关控制也简单。我不介意，也不反对，甚至大家的评论我也没时间看...",
  "uri": "douban://douban.com/review/10599797",
  "cover_url": "https://qnmob3.doubanio.com/view/thing_review/sqs/public/3547435.jpg?imageView2/0/q/80/w/9999/h/120/format/webp",
  "card_subtitle": "刘在石的妈妈粉 · 14253赞  5269回复"
} 
*/

  bool isVideoCover;
  String title;
  String theAbstract;
  String uri;
  String coverUrl;
  String cardSubtitle;

  BookMovieSearchLastResultModelReviewsItemsTarget({
    this.isVideoCover,
    this.title,
    this.theAbstract,
    this.uri,
    this.coverUrl,
    this.cardSubtitle,
  });
  BookMovieSearchLastResultModelReviewsItemsTarget.fromJson(Map<String, dynamic> json) {
    isVideoCover = json["is_video_cover"];
    title = json["title"]?.toString();
    theAbstract = json["abstract"]?.toString();
    uri = json["uri"]?.toString();
    coverUrl = json["cover_url"]?.toString();
    cardSubtitle = json["card_subtitle"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["is_video_cover"] = isVideoCover;
    data["title"] = title;
    data["abstract"] = theAbstract;
    data["uri"] = uri;
    data["cover_url"] = coverUrl;
    data["card_subtitle"] = cardSubtitle;
    return data;
  }
}

class BookMovieSearchLastResultModelReviewsItems {
/*
{
  "type_name": "长评",
  "layout": "content",
  "target": {
    "is_video_cover": false,
    "title": "抄袭的你，如此作呕——这才是真正的沉睡魔咒！（1031最终说明）",
    "abstract": "（此文于10月30日作补充。因底下评论已无法控制所以过后笔者不会再理会混战，各位请尽情随意发泄情绪哈，但依然欢迎私信探讨。P.s.：对本文的修改绝不包括删除原先存在争议的语句表达，只是在保持原文意思的基础上作一定论据补充说明。）\r\n【31日最终补充：一夜之间突然多了5000个踩，以及上百条私信，我去好评帖子看到很多顶“有用”都是刚注册的小号，看来很多不知哪来的人正式涌入了豆瓣发动攻势哈。心疼豆瓣，注册不像虎扑那样存在门槛，资本公关控制也简单。我不介意，也不反对，甚至大家的评论我也没时间看...",
    "uri": "douban://douban.com/review/10599797",
    "cover_url": "https://qnmob3.doubanio.com/view/thing_review/sqs/public/3547435.jpg?imageView2/0/q/80/w/9999/h/120/format/webp",
    "card_subtitle": "刘在石的妈妈粉 · 14253赞  5269回复"
  },
  "target_type": "review"
} 
*/

  String typeName;
  String layout;
  BookMovieSearchLastResultModelReviewsItemsTarget target;
  String targetType;

  BookMovieSearchLastResultModelReviewsItems({
    this.typeName,
    this.layout,
    this.target,
    this.targetType,
  });
  BookMovieSearchLastResultModelReviewsItems.fromJson(Map<String, dynamic> json) {
    typeName = json["type_name"]?.toString();
    layout = json["layout"]?.toString();
    target = json["target"] != null ? BookMovieSearchLastResultModelReviewsItemsTarget.fromJson(json["target"]) : null;
    targetType = json["target_type"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["type_name"] = typeName;
    data["layout"] = layout;
    if (target != null) {
      data["target"] = target.toJson();
    }
    data["target_type"] = targetType;
    return data;
  }
}

class BookMovieSearchLastResultModelReviews {
/*
{
  "target_name": "少年的你的更多11825篇影评",
  "items": [
    {
      "type_name": "长评",
      "layout": "content",
      "target": {
        "is_video_cover": false,
        "title": "抄袭的你，如此作呕——这才是真正的沉睡魔咒！（1031最终说明）",
        "abstract": "（此文于10月30日作补充。因底下评论已无法控制所以过后笔者不会再理会混战，各位请尽情随意发泄情绪哈，但依然欢迎私信探讨。P.s.：对本文的修改绝不包括删除原先存在争议的语句表达，只是在保持原文意思的基础上作一定论据补充说明。）\r\n【31日最终补充：一夜之间突然多了5000个踩，以及上百条私信，我去好评帖子看到很多顶“有用”都是刚注册的小号，看来很多不知哪来的人正式涌入了豆瓣发动攻势哈。心疼豆瓣，注册不像虎扑那样存在门槛，资本公关控制也简单。我不介意，也不反对，甚至大家的评论我也没时间看...",
        "uri": "douban://douban.com/review/10599797",
        "cover_url": "https://qnmob3.doubanio.com/view/thing_review/sqs/public/3547435.jpg?imageView2/0/q/80/w/9999/h/120/format/webp",
        "card_subtitle": "刘在石的妈妈粉 · 14253赞  5269回复"
      },
      "target_type": "review"
    }
  ],
  "total": 11825,
  "target_uri": "douban://douban.com/movie/30166972?show_review=1",
  "mod_name": "《少年的你》的影评"
} 
*/

  String targetName;
  List<BookMovieSearchLastResultModelReviewsItems> items;
  int total;
  String targetUri;
  String modName;

  BookMovieSearchLastResultModelReviews({
    this.targetName,
    this.items,
    this.total,
    this.targetUri,
    this.modName,
  });
  BookMovieSearchLastResultModelReviews.fromJson(Map<String, dynamic> json) {
    targetName = json["target_name"]?.toString();
  if (json["items"] != null) {
  var v = json["items"];
  var arr0 = List<BookMovieSearchLastResultModelReviewsItems>();
  v.forEach((v) {
  arr0.add(BookMovieSearchLastResultModelReviewsItems.fromJson(v));
  });
    items = arr0;
    }
    total = json["total"]?.toInt();
    targetUri = json["target_uri"]?.toString();
    modName = json["mod_name"]?.toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["target_name"] = targetName;
    if (items != null) {
      var v = items;
      var arr0 = List();
  v.forEach((v) {
  arr0.add(v.toJson());
  });
      data["items"] = arr0;
    }
    data["total"] = total;
    data["target_uri"] = targetUri;
    data["mod_name"] = modName;
    return data;
  }
}

class BookMovieSearchLastResultModelChannelSubjects {
/*
{} 
*/


  BookMovieSearchLastResultModelChannelSubjects();
  BookMovieSearchLastResultModelChannelSubjects.fromJson(Map<String, dynamic> json) {
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    return data;
  }
}

class BookMovieSearchLastResultModel {
/*
{
  "count": 20,
  "show_more_subjects": true,
  "channel_subjects": {},
  "banned": "",
  "reviews": {
    "target_name": "少年的你的更多11825篇影评",
    "items": [
      {
        "type_name": "长评",
        "layout": "content",
        "target": {
          "is_video_cover": false,
          "title": "抄袭的你，如此作呕——这才是真正的沉睡魔咒！（1031最终说明）",
          "abstract": "（此文于10月30日作补充。因底下评论已无法控制所以过后笔者不会再理会混战，各位请尽情随意发泄情绪哈，但依然欢迎私信探讨。P.s.：对本文的修改绝不包括删除原先存在争议的语句表达，只是在保持原文意思的基础上作一定论据补充说明。）\r\n【31日最终补充：一夜之间突然多了5000个踩，以及上百条私信，我去好评帖子看到很多顶“有用”都是刚注册的小号，看来很多不知哪来的人正式涌入了豆瓣发动攻势哈。心疼豆瓣，注册不像虎扑那样存在门槛，资本公关控制也简单。我不介意，也不反对，甚至大家的评论我也没时间看...",
          "uri": "douban://douban.com/review/10599797",
          "cover_url": "https://qnmob3.doubanio.com/view/thing_review/sqs/public/3547435.jpg?imageView2/0/q/80/w/9999/h/120/format/webp",
          "card_subtitle": "刘在石的妈妈粉 · 14253赞  5269回复"
        },
        "target_type": "review"
      }
    ],
    "total": 11825,
    "target_uri": "douban://douban.com/movie/30166972?show_review=1",
    "mod_name": "《少年的你》的影评"
  },
  "start": 0,
  "subjects": [
    {
      "type_name": "电影",
      "layout": "subject",
      "target": {
        "has_linewatch": false,
        "abstract": "",
        "title": "少年的你",
        "uri": "douban://douban.com/movie/30166972",
        "cover_url": "https://qnmob3.doubanio.com/view/photo/large/public/p2572166063.jpg?imageView2/0/q/80/w/9999/h/120/format/webp",
        "year": "2019",
        "card_subtitle": "8.4分 / 2019 / 中国大陆 / 剧情 爱情 犯罪 / 曾国祥 / 周冬雨 易烊千玺",
        "id": "30166972"
      },
      "target_type": "movie"
    }
  ],
  "smart_box": [
    null
  ],
  "fuzzy": "",
  "promotion": [
    null
  ],
  "total": 20879,
  "contents": [
    {
      "type_name": "话题",
      "layout": "gallery_topic",
      "target": {
        "card_subtitle": "2233篇内容・602.1万次浏览",
        "abstract": "我们总认为父母唠叨、守旧，那如果你成为你爸妈呢？会有什么不同呢？",
        "uri": "douban://douban.com/gallery/topic/72260",
        "title": "如果让你做你自己的爸妈，你会怎样对待童年的你？"
      },
      "target_type": "gallery_topic"
    }
  ]
} 
*/

  int count;
  bool showMoreSubjects;
  BookMovieSearchLastResultModelChannelSubjects channelSubjects;
  String banned;
  BookMovieSearchLastResultModelReviews reviews;
  int start;
  List<BookMovieSearchLastResultModelSubjects> subjects;
  List smartBox;
  String fuzzy;
  List promotion;
  int total;
  List<BookMovieSearchLastResultModelContents> contents;

  BookMovieSearchLastResultModel({
    this.count,
    this.showMoreSubjects,
    this.channelSubjects,
    this.banned,
    this.reviews,
    this.start,
    this.subjects,
    this.smartBox,
    this.fuzzy,
    this.promotion,
    this.total,
    this.contents,
  });
  BookMovieSearchLastResultModel.fromJson(Map<String, dynamic> json) {
    count = json["count"]?.toInt();
    showMoreSubjects = json["show_more_subjects"];
    channelSubjects = json["channel_subjects"] != null ? BookMovieSearchLastResultModelChannelSubjects.fromJson(json["channel_subjects"]) : null;
    banned = json["banned"]?.toString();
    reviews = json["reviews"] != null ? BookMovieSearchLastResultModelReviews.fromJson(json["reviews"]) : null;
    start = json["start"]?.toInt();
  if (json["subjects"] != null) {
  var v = json["subjects"];
  var arr0 = List<BookMovieSearchLastResultModelSubjects>();
  v.forEach((v) {
  arr0.add(BookMovieSearchLastResultModelSubjects.fromJson(v));
  });
    subjects = arr0;
    }
    fuzzy = json["fuzzy"]?.toString();
    total = json["total"]?.toInt();
  if (json["contents"] != null) {
  var v = json["contents"];
  var arr0 = List<BookMovieSearchLastResultModelContents>();
  v.forEach((v) {
  arr0.add(BookMovieSearchLastResultModelContents.fromJson(v));
  });
    contents = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["count"] = count;
    data["show_more_subjects"] = showMoreSubjects;
    if (channelSubjects != null) {
      data["channel_subjects"] = channelSubjects.toJson();
    }
    data["banned"] = banned;
    if (reviews != null) {
      data["reviews"] = reviews.toJson();
    }
    data["start"] = start;
    if (subjects != null) {
      var v = subjects;
      var arr0 = List();
  v.forEach((v) {
  arr0.add(v.toJson());
  });
      data["subjects"] = arr0;
    }
    data["fuzzy"] = fuzzy;
    data["total"] = total;
    if (contents != null) {
      var v = contents;
      var arr0 = List();
  v.forEach((v) {
  arr0.add(v.toJson());
  });
      data["contents"] = arr0;
    }
    return data;
  }
}
