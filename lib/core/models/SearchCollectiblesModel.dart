import 'package:get/get.dart';

class SearchCollectiblesModel {
  SearchCollectiblesModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  SearchCollectiblesModel.fromJson(dynamic json) {
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
  String? next;
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
    this.type,
    this.name,
    this.image,
    this.edition,
    this.brand,
    this.rarity,
    this.floorPrice,
    this.priceChangePercent,
    this.graph,
    this.rarePoint,
    this.cpp,
  });

  Results.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    cpp = json['changed_price'];
    edition = json['edition'];
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    rarity = json['rarity'];
    floorPrice = json['floor_price'];
    priceChangePercent = json['price_change_percent'] != null
        ? PriceChangePercent.fromJson(json['price_change_percent'])
        : null;
    if (json['new_graph'] != null) {
      graph = [];
      json['new_graph'].forEach((v) {
        graph?.add(Graph.fromJson(v));
      });
    }

  }

  int? id;
  int? type;
  String? name;
  Image? image;
  String? edition;
  Brand? brand;
  String? rarity;
  String? floorPrice;
  PriceChangePercent? priceChangePercent;
  List<Graph>? graph;
  int? rarePoint;
  double? cpp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['name'] = name;
    if (image != null) {
      map['image'] = image?.toJson();
    }
    map['changed_price'] = cpp;
    map['edition'] = edition;
    map['brand'] = brand;
    map['rarity'] = rarity;
    map['floor_price'] = floorPrice;
    if (priceChangePercent != null) {
      map['price_change_percent'] = priceChangePercent?.toJson();
    }
    if (graph != null) {
      map['new_graph'] = graph?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Image {
  Image({
    this.original,
    this.image_on_list,});

  Image.fromJson(dynamic json) {
    original = json['original'] != null ? Original.fromJson(json['original']) : null;
    image_on_list = json['list'] != null ? ImageOnList.fromJson(json['list']) : null;
  }
  Original? original;
  ImageOnList? image_on_list;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (original != null) {
      map['original'] = original?.toJson();
    }
    if (image_on_list != null) {
      map['list'] = image_on_list?.toJson();
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


class Graph {
  Graph({
    this.floorPrice,
    this.creationTime,
    this.date,});

  Graph.fromJson(dynamic json) {
    floorPrice = json['floor_price'];
    creationTime = json['creation_time'];
    date = json['date'];
  }
  double? floorPrice;
  String? creationTime;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['floor_price'] = floorPrice;
    map['creation_time'] = creationTime;
    map['date'] = date;
    return map;
  }

}


class PriceChangePercent {
  PriceChangePercent({
    this.percent,
    this.cp,
    this.sign,
  });

  PriceChangePercent.fromJson(dynamic json) {
    percent = double.parse(json['percent'].toString()).toPrecision(2);
    cp = double.parse(json['changed_price'].toString()).toPrecision(2);
    sign = json['sign'];
  }

  var percent;
  var cp;
  String? sign;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['percent'] = percent;
    map['changed_price'] = cp;
    map['sign'] = sign;
    return map;
  }
}

class Brand {
  Brand({
    this.id,
    this.name,});

  Brand.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}
