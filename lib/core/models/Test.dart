class Test {
  Test({
      this.count, 
      this.next, 
      this.previous, 
      this.results,});

  Test.fromJson(dynamic json) {
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
      this.parent, 
      this.brand, 
      this.rarity, 
      this.floorPrice, 
      this.series, 
      this.priceChangePercent, 
      this.graph, 
      this.newGraph,});

  Results.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    edition = json['edition'];
    parent = json['parent'];
    brand = json['brand'];
    rarity = json['rarity'];
    floorPrice = json['floor_price'];
    series = json['series'];
    priceChangePercent = json['price_change_percent'] != null ? PriceChangePercent.fromJson(json['price_change_percent']) : null;
    if (json['graph'] != null) {
      graph = [];
      json['graph'].forEach((v) {
        graph?.add(Graph.fromJson(v));
      });
    }
    if (json['new_graph'] != null) {
      newGraph = [];
      json['new_graph'].forEach((v) {
        newGraph?.add(NewGraph.fromJson(v));
      });
    }
  }
  int? id;
  int? type;
  String? name;
  String? edition;
  int? parent;
  dynamic brand;
  String? rarity;
  String? floorPrice;
  String? series;
  PriceChangePercent? priceChangePercent;
  List<Graph>? graph;
  List<NewGraph>? newGraph;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['name'] = name;
    map['edition'] = edition;
    map['parent'] = parent;
    map['brand'] = brand;
    map['rarity'] = rarity;
    map['floor_price'] = floorPrice;
    map['series'] = series;
    if (priceChangePercent != null) {
      map['price_change_percent'] = priceChangePercent?.toJson();
    }
    if (graph != null) {
      map['graph'] = graph?.map((v) => v.toJson()).toList();
    }
    if (newGraph != null) {
      map['new_graph'] = newGraph?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class NewGraph {
  NewGraph({
      this.floorPrice, 
      this.creationTime, 
      this.date,});

  NewGraph.fromJson(dynamic json) {
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

class Graph {
  Graph({
      this.hour, 
      this.total,});

  Graph.fromJson(dynamic json) {
    hour = json['hour'];
    total = json['total'];
  }
  String? hour;
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
      this.sign, 
      this.changedPrice,});

  PriceChangePercent.fromJson(dynamic json) {
    percent = json['percent'];
    sign = json['sign'];
    changedPrice = json['changed_price'];
  }
  double? percent;
  String? sign;
  double? changedPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['percent'] = percent;
    map['sign'] = sign;
    map['changed_price'] = changedPrice;
    return map;
  }

}