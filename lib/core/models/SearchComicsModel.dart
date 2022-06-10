import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SearchComicsModel {
  SearchComicsModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  SearchComicsModel.fromJson(dynamic json) {
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
    this.edition,
    this.series,
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
    edition = json['edition'];
    series= json['series'];
    rarity = json['rarity'];
    floorPrice = json['floor_price'];
    priceChangePercent = json['price_change_percent'] != null
        ? PriceChangePercent.fromJson(json['price_change_percent'])
        : null;
    if (json['graph'] != null) {
      graph = [];
      json['graph'].forEach((v) {
        graph?.add(Graph.fromJson(v));
      });
    }
    if (rarity == 'Rare') {
      rarePoint = 2;
      cpp = (double.parse(floorPrice!) / rarePoint!).toPrecision(2);
    } else if (rarity == 'Ultra Rare') {
      rarePoint = 3;
      cpp = (double.parse(floorPrice!) / rarePoint!).toPrecision(2);
    } else {
      rarePoint = 1;
      cpp = (double.parse(floorPrice!) / rarePoint!).toPrecision(2);
    }
  }

  int? id;
  int? type;
  String? name;
  String? edition;
  String? series;
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
    map['edition'] = edition;
    map['series'] = series;
    map['rarity'] = rarity;
    map['floor_price'] = floorPrice;
    if (priceChangePercent != null) {
      map['price_change_percent'] = priceChangePercent?.toJson();
    }
    if (graph != null) {
      map['graph'] = graph?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Graph {
  Graph({
    this.hour,
    this.inHour,
    this.total,
  });

  Graph.fromJson(dynamic json) {
    hour = json['hour'];
    total = json['total'];
    inHour = DateFormat('hh a').format(DateTime.parse(hour!));
  }

  String? hour;
  var inHour;
  double? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hour'] = hour;
    map['total'] = total;
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
    percent = double.parse(json['percent'].toString()).toPrecision(2);
    changePrice = double.parse(json['changed_price'].toString()).toPrecision(2);
    sign = json['sign'];
  }

  var percent;
  var changePrice;
  String? sign;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['percent'] = percent;
    map['changed_price'] = changePrice;
    map['sign'] = sign;
    return map;
  }
}
