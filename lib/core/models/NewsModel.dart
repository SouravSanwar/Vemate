class NewsModel {
  NewsModel({
      this.count, 
      this.next, 
      this.previous, 
      this.results,});

  NewsModel.fromJson(dynamic json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
  }
  int? count;
  dynamic next;
  dynamic previous;
  List<Results>? results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['next'] = next;
    map['previous'] = previous;
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Results {
  Results({
      this.id, 
      this.backgroundImage, 
      this.title, 
      this.text, 
      this.btnLabel, 
      this.btnLink, 
      this.creationTime,});

  Results.fromJson(dynamic json) {
    id = json['id'];
    backgroundImage = json['background_image'] != null ? BackgroundImage.fromJson(json['background_image']) : null;
    title = json['title'];
    text = json['text'];
    btnLabel = json['btn_label'];
    btnLink = json['btn_link'];
    creationTime = json['creation_time'];
  }
  int? id;
  BackgroundImage? backgroundImage;
  String? title;
  String? text;
  String? btnLabel;
  String? btnLink;
  String? creationTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (backgroundImage != null) {
      map['background_image'] = backgroundImage?.toJson();
    }
    map['title'] = title;
    map['text'] = text;
    map['btn_label'] = btnLabel;
    map['btn_link'] = btnLink;
    map['creation_time'] = creationTime;
    return map;
  }

}

class BackgroundImage {
  BackgroundImage({
      this.original,});

  BackgroundImage.fromJson(dynamic json) {
    original = json['original'] != null ? Original.fromJson(json['original']) : null;
  }
  Original? original;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (original != null) {
      map['original'] = original?.toJson();
    }
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
    src = json['src'];
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