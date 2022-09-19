class NotificationListModel {
  NotificationListModel({
      this.count, 
      this.next, 
      this.previous, 
      this.results, 
      this.totalUnread,});

  NotificationListModel.fromJson(dynamic json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
    totalUnread = json['total_unread'];
  }
  int? count;
  dynamic next;
  dynamic previous;
  List<Results>? results;
  int? totalUnread;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['next'] = next;
    map['previous'] = previous;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    map['total_unread'] = totalUnread;
    return map;
  }

}

class Results {
  Results({
      this.id, 
      this.verb,
      this.actionObject, 
      this.target, 
      this.unread, 
      this.timesince, 
      this.description,});

  Results.fromJson(dynamic json) {
    id = json['id'];
    verb = json['verb'];
    actionObject = json['action_object'];
    target = json['target'] != null ? Target.fromJson(json['target']) : null;
    unread = json['unread'];
    timesince = json['timesince'];
    description = json['description'];
  }
  int? id;
  String? verb;
  String? name;
  dynamic actionObject;
  Target? target;
  bool? unread;
  String? timesince;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['verb'] = verb;
    map['action_object'] = actionObject;
    if (target != null) {
      map['target'] = target?.toJson();
    }
    map['unread'] = unread;
    map['timesince'] = timesince;
    map['description'] = description;
    return map;
  }

}
class Image {
  Image({
    this.original,
    this.image_on_list,
    this.direction,
    this.base_url,
    this.low_res_url,
    this.mid_res_url,
    this.high_res_url,

  });

  Image.fromJson(dynamic json) {
    original = json['original'] != null ? Original.fromJson(json['original']) : null;
    image_on_list = json['list'] != null ? ImageOnList.fromJson(json['list']) : null;
    direction = json['direction'] ;
    base_url = json['base_url'] ;
    low_res_url = json['low_res_url'] ;
    mid_res_url = json['mid_res_url'] ;
    high_res_url = json['high_res_url'] ;
  }
  Original? original;
  ImageOnList? image_on_list;
  String? direction;
  String? base_url;
  String? low_res_url;
  String? mid_res_url;
  String? high_res_url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (original != null) {
      map['original'] = original?.toJson();
    }
    if (image_on_list != null) {
      map['list'] = image_on_list?.toJson();
    }
    map['direction'] = direction;
    map['base_url'] = base_url;
    map['low_res_url'] = low_res_url;
    map['mid_res_url'] = mid_res_url;
    map['high_res_url'] = high_res_url;
    return map;
  }

}

class ImageOnList {
  ImageOnList({
    this.src,
    this.width,
    this.height,
    this.alt,});

  ImageOnList.fromJson(dynamic json) {
    src = 'https://market.vemate.com'+json['src'];
    width = json['width'];
    height = json['height'];
    alt = json['alt'];
  }
  String? src;
  int? width;
  int? height;
  String? alt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['src'] = src;
    map['width'] = width;
    map['height'] = height;
    map['alt'] = alt;
    return map;
  }

}

class Original {
  Original({
    this.src,
    this.width,
    this.height,
    this.alt,});

  Original.fromJson(dynamic json) {
    src = 'https://market.vemate.com'+json['src'];
    width = json['width'];
    height = json['height'];
    alt = json['alt'];
  }
  String? src;
  int? width;
  int? height;
  String? alt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['src'] = src;
    map['width'] = width;
    map['height'] = height;
    map['alt'] = alt;
    return map;
  }

}


class Target {
  Target({
      this.id, 
      this.name,
    this.image,
      this.type, 
      this.rarity,});

  Target.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    type = json['type'];
    rarity = json['rarity'];
  }
  int? id;
  String? name;
  Image? image;
  int? type;
  String? rarity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    if (image != null) {
      map['image'] = image?.toJson();
    }
    map['type'] = type;
    map['rarity'] = rarity;
    return map;
  }

}