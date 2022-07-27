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
    this.imageList,});

  Image.fromJson(dynamic json) {
    original = json['original'] != null ? Original.fromJson(json['original']) : null;
    imageList = json['list'] != null ? ImageOnList.fromJson(json['list']) : null;
  }
  Original? original;
  ImageOnList? imageList;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (original != null) {
      map['original'] = original?.toJson();
    }
    if (imageList != null) {
      map['list'] = imageList?.toJson();
    }
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