import 'package:get/get.dart';

class WishListModel {
  WishListModel({
      this.count, 
      this.next, 
      this.previous, 
      this.results,});

  WishListModel.fromJson(dynamic json) {
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
      this.productDetail, 
      this.type, 
      this.creationTime, 
      this.user, 
      this.product,});

  Results.fromJson(dynamic json) {
    id = json['id'];
    productDetail = json['product_detail'] != null ? ProductDetail.fromJson(json['product_detail']) : null;
    type = json['type'];
    creationTime = json['creation_time'];
    user = json['user'];
    product = json['product'];
  }
  int? id;
  ProductDetail? productDetail;
  int? type;
  String? creationTime;
  int? user;
  int? product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (productDetail != null) {
      map['product_detail'] = productDetail?.toJson();
    }
    map['type'] = type;
    map['creation_time'] = creationTime;
    map['user'] = user;
    map['product'] = product;
    return map;
  }

}

class ProductDetail {
  ProductDetail({
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

  ProductDetail.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    edition = json['edition'];
    parent = json['parent'];
    brand = json['brand'];
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
  dynamic brand;
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
    map['brand'] = brand;
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
    percent = double.parse(json['percent'].toString()).toPrecision(2);
    sign = json['sign'];
  }
  var percent;
  String? sign;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['percent'] = percent;
    map['sign'] = sign;
    return map;
  }

}