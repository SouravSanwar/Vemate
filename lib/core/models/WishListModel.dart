import 'package:get/get.dart';

class WishListModel {
  WishListModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

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
    this.alertData,
    this.creationTime,
    this.user,
    this.product,
    this.isAlert,
  });

  Results.fromJson(dynamic json) {
    id = json['id'];
    productDetail = json['product_detail'] != null
        ? ProductDetail.fromJson(json['product_detail'])
        : null;
    type = json['type'];
    alertData = json['alert_data'] != null
        ? AlertData.fromJson(json['alert_data'])
        : null;
    creationTime = json['creation_time'];
    user = json['user'];
    product = json['product'];
    alertData != null ? isAlert = true : isAlert = false;
  }

  int? id;
  ProductDetail? productDetail;
  int? type;
  AlertData? alertData;
  String? creationTime;
  int? user;
  int? product;
  bool? isAlert;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (productDetail != null) {
      map['product_detail'] = productDetail?.toJson();
    }
    if (alertData != null) {
      map['alert_data'] = alertData?.toJson();
    }
    map['type'] = type;
    map['creation_time'] = creationTime;
    map['user'] = user;
    map['product'] = product;
    return map;
  }
}

class AlertData {
  AlertData({
    this.id,
    this.type,
    this.priceType,
    this.value,
    this.frequency,
    this.creationTime,
    this.updateTime,
    this.product,
    this.user,
    this.priceValue,
    this.frequencyValue,
  });

  AlertData.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    priceType = json['price_type'];
    value = json['value'];
    frequency = json['frequency'];
    creationTime = json['creation_time'];
    updateTime = json['update_time'];
    product = json['product'];
    user = json['user'];

    if (priceType == 0) {
      priceValue = 'Price rises above';
    } else if (priceType == 1) {
      priceValue = 'Price drops under';
    } else if (priceType == 2) {
      priceValue = 'Price rises';
    } else if (priceType == 3) {
      priceValue = 'Price drops';
    } else {
      priceValue = 'none';
    }

    if (frequency == 0) {
      frequencyValue = 'Once';
    } else if (frequency == 1) {
      frequencyValue = 'Once a day';
    } else if (frequency == 2) {
      frequencyValue = 'Always';
    } else {
      frequencyValue = 'none';
    }
  }

  int? id;
  int? type;
  int? priceType;
  double? value;
  int? frequency;
  String? creationTime;
  String? updateTime;
  int? product;
  int? user;
  String? priceValue;
  String? frequencyValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['price_type'] = priceType;
    map['value'] = value;
    map['frequency'] = frequency;
    map['creation_time'] = creationTime;
    map['update_time'] = updateTime;
    map['product'] = product;
    map['user'] = user;
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
    this.series,
    this.rarity,
    this.floorPrice,
    this.priceChangePercent,
    this.graph,
  });

  ProductDetail.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    edition = json['edition'];
    parent = json['parent'];
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    series = json['series'];
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
  }

  int? id;
  int? type;
  String? name;
  String? edition;
  dynamic parent;
  Brand? brand;
  String? series;
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

class Brand {
  Brand({
    this.id,
    this.name,
  });

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

class Graph {
  Graph({
    this.hour,
    this.total,
  });

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
  });

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
