class MySetsModel {
  MySetsModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  MySetsModel.fromJson(dynamic json) {
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

  num? count;
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
    this.statsDetail,
    this.type,
    this.mintNumber,
    this.ap,
    this.ad,
    this.creationTime,
    this.user,
    this.product,
  });

  Results.fromJson(dynamic json) {
    id = json['id'];
    productDetail = json['product_detail'] != null ? ProductDetail.fromJson(json['product_detail']) : null;
    statsDetail = json['stats_detail'] != null ? StatsDetail.fromJson(json['stats_detail']) : null;
    type = json['type'];
    mintNumber = json['mint_number'];
    ap = double.parse(json['ap']).toStringAsFixed(2);
    ad = json['ad'];
    creationTime = json['creation_time'];
    user = json['user'];
    product = json['product'];
  }

  num? id;
  ProductDetail? productDetail;
  StatsDetail? statsDetail;
  num? type;
  num? mintNumber;
  String? ap;
  String? ad;
  String? creationTime;
  num? user;
  num? product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (productDetail != null) {
      map['product_detail'] = productDetail?.toJson();
    }
    if (statsDetail != null) {
      map['stats_detail'] = statsDetail?.toJson();
    }
    map['type'] = type;
    map['mint_number'] = mintNumber;
    map['ap'] = ap;
    map['ad'] = ad;
    map['creation_time'] = creationTime;
    map['user'] = user;
    map['product'] = product;
    return map;
  }
}

class StatsDetail {
  StatsDetail({
    this.totalItem,
    this.sign,
    this.priceChange,
    this.changePercent,
    this.totalAp,
    this.graph,
  });

  StatsDetail.fromJson(dynamic json) {
    totalItem = json['total_item'];
    sign = json['sign'];
    priceChange = json['price_change'];
    changePercent = json['change_percent'];
    totalAp = json['total_ap'];
    if (json['graph'] != null) {
      graph = [];
      json['graph'].forEach((v) {
        graph?.add(Graph.fromJson(v));
      });
    }
  }

  num? totalItem;
  String? sign;
  double? priceChange;
  double? changePercent;
  num? totalAp;
  List<Graph>? graph;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_item'] = totalItem;
    map['sign'] = sign;
    map['price_change'] = priceChange;
    map['change_percent'] = changePercent;
    map['total_ap'] = totalAp;
    if (graph != null) {
      map['graph'] = graph;
    }
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

  num? floorPrice;
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

class ProductDetail {
  ProductDetail({
    this.id,
    this.mintNumber,
    this.type,
    this.name,
    this.edition,
    this.editions,
    this.parent,
    this.brand,
    this.rarity,
    this.floorPrice,
    this.series,
    this.image,
  });

  ProductDetail.fromJson(dynamic json) {
    id = json['id'];
    mintNumber = json['mint_number'];
    type = json['type'];
    name = json['name'];
    edition = json['edition'];
    editions = json['editions'];
    parent = json['parent'];
    brand = json['brand'];
    rarity = json['rarity'];
    floorPrice = json['floor_price'];
    series = json['series'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
  }

  int? id;
  num? mintNumber;
  int? type;
  String? name;
  String? edition;
  String? editions;
  dynamic parent;
  num? brand;
  String? rarity;
  String? floorPrice;
  String? series;
  Image? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['mint_number'] = mintNumber;
    map['type'] = type;
    map['name'] = name;
    map['edition'] = edition;
    map['editions'] = editions;
    map['parent'] = parent;
    map['brand'] = brand;
    map['rarity'] = rarity;
    map['floor_price'] = floorPrice;
    map['series'] = series;
    if (image != null) {
      map['image'] = image?.toJson();
    }
    return map;
  }
}

class Image {
  Image({
    this.direction,
    this.baseUrl,
    this.lowResUrl,
    this.midResUrl,
    this.highResUrl,
  });

  Image.fromJson(dynamic json) {
    direction = json['direction'];
    baseUrl = json['base_url'];
    lowResUrl = json['low_res_url'];
    midResUrl = json['mid_res_url'];
    highResUrl = json['high_res_url'];
  }

  String? direction;
  String? baseUrl;
  String? lowResUrl;
  String? midResUrl;
  String? highResUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['direction'] = direction;
    map['base_url'] = baseUrl;
    map['low_res_url'] = lowResUrl;
    map['mid_res_url'] = midResUrl;
    map['high_res_url'] = highResUrl;
    return map;
  }
}
