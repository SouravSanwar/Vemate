import 'package:get/get.dart';

class ComicsModel {
  ComicsModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  ComicsModel.fromJson(dynamic json) {
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
    this.series,
    this.rarity,
    this.floorPrice,
    /*this.priceChangePercent,
    this.graph,*/
    this.graphData,
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
    series = json['series'];
    rarity = json['rarity'];
    floorPrice = json['floor_price'];
    graphData = json['graph_data'] != null
        ? GraphData.fromJson(json['graph_data'])
        : null;

  /*  priceChangePercent = json['price_change_percent'] != null
        ? PriceChangePercent.fromJson(json['price_change_percent'])
        : null;
    if (json['new_graph'] != null) {
      graph = [];
      json['new_graph'].forEach((v) {
        graph?.add(Graph.fromJson(v));
      });
    }*/

  }

  int? id;
  int? type;
  String? name;
  Image? image;
  String? edition;
  String? series;
  String? rarity;
  String? floorPrice;
  /*PriceChangePercent? priceChangePercent;
  List<Graph>? graph;*/
  GraphData? graphData;
  int? rarePoint;
  double? cpp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['changed_price'] = cpp;
    map['name'] = name;
    if (image != null) {
      map['image'] = image?.toJson();
    }
    map['edition'] = edition;
    map['series'] = series;
    map['rarity'] = rarity;
    map['floor_price'] = floorPrice;
    map['graph_data'] = graphData;
    /*if (priceChangePercent != null) {
      map['price_change_percent'] = priceChangePercent?.toJson();
    }
    if (graph != null) {
      map['new_graph'] = graph?.map((v) => v.toJson()).toList();
    }*/
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
class Graph {
  Graph({
    this.floorPrice,
    this.creationTime,
    this.date,
  });

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

class GraphData {
  GraphData({
    this.priceChangePercent,
    this.graph,
  });

  GraphData.fromJson(dynamic json) {
    priceChangePercent = json['price_change_percent'] != null
        ? PriceChangePercent.fromJson(json['price_change_percent'])
        : null;

    if (json['graph'] != null) {
      graph = [];
      json['graph'].forEach((v) {
        graph?.add(Graph.fromJson(v));
      });
    }

    final Map<String, Graph> graphMap = {};
    for (var item in graph!) {
      graphMap[item.date!] = item;
    }
    graph = graphMap.values.toList();
  }

  PriceChangePercent? priceChangePercent;
  List<Graph>? graph;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (priceChangePercent != null) {
      map['price_change_percent'] = priceChangePercent?.toJson();
    }
    map['graph'] = graph;
    return map;
  }
}

class PriceChangePercent {
  PriceChangePercent({
    this.percent,
    this.changePrice,
    this.sign,
  });

  PriceChangePercent.fromJson(dynamic json) {

    percent = double.parse(json['change_percent'].toString()).toPrecision(2);
    changePrice = double.parse(json['changed_price'].toString()).toPrecision(2);
    sign = json['sign'];
  }

  var percent;

  var changePrice;
  String? sign;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['change_percent'] = percent;
    map['changed_price'] = changePrice;
    map['sign'] = sign;
    return map;
  }
}
