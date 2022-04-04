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
  String? previous;
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
      this.priceChangePercent, 
      this.graph,});

  Results.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    edition = json['edition'];
    parent = json['parent'];
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    rarity = json['rarity'];
    floorPrice = json['floor_price'];
    priceChangePercent = json['price_change_percent'] != null ? PriceChangePercent.fromJson(json['price_change_percent']) : null;
    if (json['graph'] != null) {
      graph = [];
      json['graph'].forEach((v) {
        graph?.add(Graph.fromJson(v));
      });
    }
  }
  int? id;
  int? type;
  String? name;
  String? edition;
  dynamic parent;
  Brand? brand;
  String? rarity;
  String? floorPrice;
  PriceChangePercent? priceChangePercent;
  List<Graph>? graph;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['name'] = name;
    map['edition'] = edition;
    map['parent'] = parent;
    if (brand != null) {
      map['brand'] = brand?.toJson();
    }
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
      this.sign,});

  PriceChangePercent.fromJson(dynamic json) {
    percent = json['percent'];
    sign = json['sign'];
  }
  int? percent;
  String? sign;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['percent'] = percent;
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