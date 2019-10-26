
import 'dart:convert' show json;

class MovieRecommentModel {

  int count;
  bool show_rating_filter;
  List<Tags> tags;
  List<Items> items;
  int start;
  List<Filters> filters;
  List<String> bottom_recommend_tags;
  List<String> recommend_tags;
  Quick_mark quick_mark;
  List<Sorts> sorts;
  int total;

    MovieRecommentModel({
this.count,
this.show_rating_filter,
this.tags,
this.items,
this.start,
this.filters,
this.bottom_recommend_tags,
this.recommend_tags,
this.quick_mark,
this.sorts,
this.total,
    });

  factory MovieRecommentModel.fromJson(jsonRes){ if(jsonRes == null) return null;


    List<Tags> tags = jsonRes['tags'] is List ? []: null; 
    if(tags!=null) {
 for (var item in jsonRes['tags']) { if (item != null) { tags.add(Tags.fromJson(item));  }
    }
    }


    List<Items> items = jsonRes['items'] is List ? []: null; 
    if(items!=null) {
 for (var item in jsonRes['items']) { if (item != null) { items.add(Items.fromJson(item));  }
    }
    }


    List<Filters> filters = jsonRes['filters'] is List ? []: null; 
    if(filters!=null) {
 for (var item in jsonRes['filters']) { if (item != null) { filters.add(Filters.fromJson(item));  }
    }
    }


    List<String> bottom_recommend_tags = jsonRes['bottom_recommend_tags'] is List ? []: null; 
    if(bottom_recommend_tags!=null) {
 for (var item in jsonRes['bottom_recommend_tags']) { if (item != null) { bottom_recommend_tags.add(item);  }
    }
    }


    List<String> recommend_tags = jsonRes['recommend_tags'] is List ? []: null; 
    if(recommend_tags!=null) {
 for (var item in jsonRes['recommend_tags']) { if (item != null) { recommend_tags.add(item);  }
    }
    }


    List<Sorts> sorts = jsonRes['sorts'] is List ? []: null; 
    if(sorts!=null) {
 for (var item in jsonRes['sorts']) { if (item != null) { sorts.add(Sorts.fromJson(item));  }
    }
    }
return MovieRecommentModel(
    count : jsonRes['count'],
    show_rating_filter : jsonRes['show_rating_filter'],
 tags:tags,
 items:items,
    start : jsonRes['start'],
 filters:filters,
 bottom_recommend_tags:bottom_recommend_tags,
 recommend_tags:recommend_tags,
    quick_mark : Quick_mark.fromJson(jsonRes['quick_mark']),
 sorts:sorts,
    total : jsonRes['total'],);}

  Map<String, dynamic> toJson() => {
        'count': count,
        'show_rating_filter': show_rating_filter,
        'tags': tags,
        'items': items,
        'start': start,
        'filters': filters,
        'bottom_recommend_tags': bottom_recommend_tags,
        'recommend_tags': recommend_tags,
        'quick_mark': quick_mark,
        'sorts': sorts,
        'total': total,
};
  @override
String  toString() {
    return json.encode(this);
  }
}

class Tags {

  bool editable;
  List<String> data;
  String type;

    Tags({
this.editable,
this.data,
this.type,
    });

  factory Tags.fromJson(jsonRes){ if(jsonRes == null) return null;


    List<String> data = jsonRes['data'] is List ? []: null; 
    if(data!=null) {
 for (var item in jsonRes['data']) { if (item != null) { data.add(item);  }
    }
    }
return Tags(
    editable : jsonRes['editable'],
 data:data,
    type : jsonRes['type'],);}

  Map<String, dynamic> toJson() => {
        'editable': editable,
        'data': data,
        'type': type,
};
  @override
String  toString() {
    return json.encode(this);
  }
}

class Items {

  String alg_json;
  String subtitle;
  String title;
  String uri;
  String cover_url;
  int items_count;
  Color_scheme color_scheme;
  bool playable;
  String type;
  bool tile_cover;

    Items({
this.alg_json,
this.subtitle,
this.title,
this.uri,
this.cover_url,
this.items_count,
this.color_scheme,
this.playable,
this.type,
this.tile_cover,
    });

  factory Items.fromJson(jsonRes)=>jsonRes == null? null:Items(
    alg_json : jsonRes['alg_json'],
    subtitle : jsonRes['subtitle'],
    title : jsonRes['title'],
    uri : jsonRes['uri'],
    cover_url : jsonRes['cover_url'],
    items_count : jsonRes['items_count'],
    color_scheme : Color_scheme.fromJson(jsonRes['color_scheme']),
    playable : jsonRes['playable'],
    type : jsonRes['type'],
    tile_cover : jsonRes['tile_cover'],);

  Map<String, dynamic> toJson() => {
        'alg_json': alg_json,
        'subtitle': subtitle,
        'title': title,
        'uri': uri,
        'cover_url': cover_url,
        'items_count': items_count,
        'color_scheme': color_scheme,
        'playable': playable,
        'type': type,
        'tile_cover': tile_cover,
};
  @override
String  toString() {
    return json.encode(this);
  }
}

class Color_scheme {

  bool is_dark;
  String primary_color_light;
  String secondary_color;
  String primary_color_dark;

    Color_scheme({
this.is_dark,
this.primary_color_light,
this.secondary_color,
this.primary_color_dark,
    });

  factory Color_scheme.fromJson(jsonRes)=>jsonRes == null? null:Color_scheme(
    is_dark : jsonRes['is_dark'],
    primary_color_light : jsonRes['primary_color_light'],
    secondary_color : jsonRes['secondary_color'],
    primary_color_dark : jsonRes['primary_color_dark'],);

  Map<String, dynamic> toJson() => {
        'is_dark': is_dark,
        'primary_color_light': primary_color_light,
        'secondary_color': secondary_color,
        'primary_color_dark': primary_color_dark,
};
  @override
String  toString() {
    return json.encode(this);
  }
}

class Filters {

  String text;
  bool checked;
  String name;
  String desc;

    Filters({
this.text,
this.checked,
this.name,
this.desc,
    });

  factory Filters.fromJson(jsonRes)=>jsonRes == null? null:Filters(
    text : jsonRes['text'],
    checked : jsonRes['checked'],
    name : jsonRes['name'],
    desc : jsonRes['desc'],);

  Map<String, dynamic> toJson() => {
        'text': text,
        'checked': checked,
        'name': name,
        'desc': desc,
};
  @override
String  toString() {
    return json.encode(this);
  }
}

class Quick_mark {

  String uri;
  String desc;

    Quick_mark({
this.uri,
this.desc,
    });

  factory Quick_mark.fromJson(jsonRes)=>jsonRes == null? null:Quick_mark(
    uri : jsonRes['uri'],
    desc : jsonRes['desc'],);

  Map<String, dynamic> toJson() => {
        'uri': uri,
        'desc': desc,
};
  @override
String  toString() {
    return json.encode(this);
  }
}

class Sorts {

  String text;
  bool checked;
  String name;

    Sorts({
this.text,
this.checked,
this.name,
    });

  factory Sorts.fromJson(jsonRes)=>jsonRes == null? null:Sorts(
    text : jsonRes['text'],
    checked : jsonRes['checked'],
    name : jsonRes['name'],);

  Map<String, dynamic> toJson() => {
        'text': text,
        'checked': checked,
        'name': name,
};
  @override
String  toString() {
    return json.encode(this);
  }
}