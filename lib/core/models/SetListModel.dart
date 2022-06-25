import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ketemaa/core/utilities/urls/urls.dart';

class SetListModel {
  SetListModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  SetListModel.fromJson(dynamic json) {
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
    this.setProductDetail,
    this.type,
    this.creationTime,
    this.user,
    this.product,
  });

  Results.fromJson(dynamic json) {
    id = json['id'];
    setProductDetail = json['product_detail'] != null
        ? SetProductDetail.fromJson(json['product_detail'])
        : null;
    type = json['type'];
    creationTime = json['creation_time'];
    user = json['user'];
    product = json['product'];

  }

  int? id;
  SetProductDetail? setProductDetail;
  int? type;
  String? creationTime;
  int? user;
  int? product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (setProductDetail != null) {
      map['product_detail'] = setProductDetail?.toJson();
    }
    map['type'] = type;
    map['creation_time'] = creationTime;
    map['user'] = user;
    map['product'] = product;
    return map;
  }
}

class ListofCollectibles {
  ListofCollectibles({
    this.id,
    this.type,
    this.name,
    this.image,
    this.edition,
    this.series,
    this.parent,
    this.brand,
    this.rarity,
    this.floorPrice,
    this.priceChangePercent,
    this.graph,
  });

  ListofCollectibles.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    edition = json['edition'];
    series = json['series'];
    parent = json['parent'];
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
  String? series;
  Brand? brand;
  dynamic parent;
  String? rarity;
  String? floorPrice;
  PriceChangePercent? priceChangePercent;
  List<Graph>? graph;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['name'] = name;
    if (image != null) {
      map['image'] = image?.toJson();
    }
    map['edition'] = edition;
    map['series'] = series;
    map['parent'] = parent;
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

class SetProductDetail {
  SetProductDetail({
    this.id,
    this.type,
    this.name,
    this.image,
    this.edition,
    this.series,
    this.parent,
    this.brand,
    this.rarity,
    this.floorPrice,
    this.priceChangePercent,
    this.graph,
  });

  SetProductDetail.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    edition = json['edition'];
    series = json['series'];
    parent = json['parent'];
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
  String? series;
  Brand? brand;
  dynamic parent;
  String? rarity;
  String? floorPrice;
  PriceChangePercent? priceChangePercent;
  List<Graph>? graph;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['name'] = name;
    if (image != null) {
      map['image'] = image?.toJson();
    }
    map['edition'] = edition;
    map['series'] = series;
    map['parent'] = parent;
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
    this.image_on_list,
  });

  Image.fromJson(dynamic json) {
    original =
        json['original'] != null ? Original.fromJson(json['original']) : null;
    image_on_list =
        json['list'] != null ? ImageOnList.fromJson(json['list']) : null;
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
    this.alt,
  });

  ImageOnList.fromJson(dynamic json) {
    src = Urls.mainUrl + json['src'];
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
    this.alt,
  });

  Original.fromJson(dynamic json) {
    src = 'https://market.vemate.com' + json['src'];
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
    this.floorPrice,
    this.creationTime,
    this.date,
    this.hourWiseTime,
    this.dayWiseTime,
  });

  Graph.fromJson(dynamic json) {
    floorPrice = json['floor_price'];
    creationTime = json['creation_time'];
    date = json['date'];
    if (date != null) {
      hourWiseTime = DateFormat('hh a').format(DateTime.parse(date!));
      // hourWiseTime = DateFormat('EE').format(DateTime.parse(date!))+":"+DateFormat('hh a').format(DateTime.parse(date!));
      //hourWiseTime = DateFormat('jm').format(DateTime.parse(creationTime!));
      // hourWiseTime = hourWiseTime.substring(5,hourWiseTime!.length);
      dayWiseTime = DateFormat('dMMM').format(DateTime.parse(date!));
      print("/*/*/*/*/*/*/*/hourwise*/*/*/*/*/*/*/*/*/*/*/*" + date.toString());
      print("/*/*/*/*/*/*/*/daywise*/*/*/*/*/*/*/*/*/*/*/*" +
          hourWiseTime.toString());
    }
  }

  double? floorPrice;
  String? creationTime;
  String? date;
  String? hourWiseTime;
  String? dayWiseTime;

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
