///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class FilmDetailGradeModelTypeRanks {
/*
{
  "type": "动作片",
  "rank": 0.66
} 
*/

  String type;
  double rank;

  FilmDetailGradeModelTypeRanks({
    this.type,
    this.rank,
  });
  FilmDetailGradeModelTypeRanks.fromJson(Map<String, dynamic> json) {
    type = json["type"]?.toString();
    rank = json["rank"]?.toDouble();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["type"] = type;
    data["rank"] = rank;
    return data;
  }
}

class FilmDetailGradeModelWishFriends {
/*
{
  "total": 0,
  "users": [
    null
  ]
} 
*/

  int total;
  List users;

  FilmDetailGradeModelWishFriends({
    this.total,
    this.users,
  });
  FilmDetailGradeModelWishFriends.fromJson(Map<String, dynamic> json) {
    total = json["total"]?.toInt();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["total"] = total;
    return data;
  }
}

class FilmDetailGradeModel {
/*
{
  "stats": [
    0.0056328313599264285
  ],
  "doing_count": 0,
  "wish_count": 78123,
  "wish_friends": {
    "total": 0,
    "users": [
      null
    ]
  },
  "type_ranks": [
    {
      "type": "动作片",
      "rank": 0.66
    }
  ],
  "following": null,
  "done_count": 88503
} 
*/

  List<double> stats;
  int doingCount;
  int wishCount;
  FilmDetailGradeModelWishFriends wishFriends;
  List<FilmDetailGradeModelTypeRanks> typeRanks;
  String following;
  int doneCount;

  FilmDetailGradeModel({
    this.stats,
    this.doingCount,
    this.wishCount,
    this.wishFriends,
    this.typeRanks,
    this.following,
    this.doneCount,
  });
  FilmDetailGradeModel.fromJson(Map<String, dynamic> json) {
  if (json["stats"] != null) {
  var v = json["stats"];
  var arr0 = List<double>();
  v.forEach((v) {
  arr0.add(v.toDouble());
  });
    stats = arr0;
    }
    doingCount = json["doing_count"]?.toInt();
    wishCount = json["wish_count"]?.toInt();
    wishFriends = json["wish_friends"] != null ? FilmDetailGradeModelWishFriends.fromJson(json["wish_friends"]) : null;
  if (json["type_ranks"] != null) {
  var v = json["type_ranks"];
  var arr0 = List<FilmDetailGradeModelTypeRanks>();
  v.forEach((v) {
  arr0.add(FilmDetailGradeModelTypeRanks.fromJson(v));
  });
    typeRanks = arr0;
    }
    following = json["following"]?.toString();
    doneCount = json["done_count"]?.toInt();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (stats != null) {
      var v = stats;
      var arr0 = List();
  v.forEach((v) {
  arr0.add(v);
  });
      data["stats"] = arr0;
    }
    data["doing_count"] = doingCount;
    data["wish_count"] = wishCount;
    if (wishFriends != null) {
      data["wish_friends"] = wishFriends.toJson();
    }
    if (typeRanks != null) {
      var v = typeRanks;
      var arr0 = List();
  v.forEach((v) {
  arr0.add(v.toJson());
  });
      data["type_ranks"] = arr0;
    }
    data["following"] = following;
    data["done_count"] = doneCount;
    return data;
  }
}