import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
    this.edition,
    this.series,
    this.rarity,
    this.floorPrice,
    this.priceChangePercent,
    this.new_graph,
    this.rarePoint,
    this.cpp,
  });

  Results.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    cpp = json['changed_price'];
    edition = json['edition'];
    series = json['series'];
    rarity = json['rarity'];
    floorPrice = json['floor_price'];
    priceChangePercent = json['price_change_percent'] != null
        ? PriceChangePercent.fromJson(json['price_change_percent'])
        : null;
    if (json['new_graph'] != null) {
      new_graph = [];
      json['new_graph'].forEach((v) {
        new_graph?.add(Graph.fromJson(v));
      });
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
  List<Graph>? new_graph;
  int? rarePoint;
  double? cpp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['changed_price'] = cpp;
    map['name'] = name;
    map['edition'] = edition;
    map['series'] = series;
    map['rarity'] = rarity;
    map['floor_price'] = floorPrice;
    if (priceChangePercent != null) {
      map['price_change_percent'] = priceChangePercent?.toJson();
    }
    if (new_graph != null) {
      map['new_graph'] = new_graph?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Graph {
  Graph({
    this.date,
    this.inHour,
    this.floor_price,
  });

  Graph.fromJson(dynamic json) {
    date = json['date'];
    floor_price = json['floor_price'];
    inHour = DateFormat('hh a').format(DateTime.parse(date!));
  }

  String? date;
  var inHour;
  double? floor_price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['floor_price'] = floor_price;
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
