import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ketemaa/core/utilities/urls/urls.dart';

class SingleProductModel {
  SingleProductModel({
    this.id,
    this.brand,
    this.graph,
    this.image,
    this.type,
    this.name,
    this.description,
    this.listing,
    this.floorPrice,
    this.owner,
    this.edition,
    this.dropDate,
    this.listPrice,
    this.editions,
    this.editionType,
    this.season,
    this.rarity,
    this.license,
    this.series,
    this.coverVariant,
    this.coverArtist,
    this.publisher,
    this.issue,
    this.pages,
    this.startYear,
    this.writers,
    this.artists,
    this.characters,
    this.creationTime,
    this.updateTime,
    this.parent,
    this.graphType,
    this.productAlertData,
    this.isProductAlert
  });

  SingleProductModel.fromJson(dynamic json) {
    id = json['id'];
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    type = json['type'];
    name = json['name'];
    description = json['description'];
    listing = json['listing'];
    floorPrice = json['floor_price'];
    owner = json['owner'];
    edition = json['edition'];
    dropDate = json['drop_date'];
    listPrice = json['list_price'];
    editions = json['editions'];
    editionType = json['edition_type'] ?? '';
    season = json['season'];
    rarity = json['rarity'];
    license = json['license'];
    series = json['series'];
    coverVariant = json['cover_variant'];
    coverArtist = json['cover_artist'];
    publisher = json['publisher'];
    issue = json['issue'];
    pages = json['pages'];
    startYear = json['start_year'];
    writers = json['writers'];
    artists = json['artists'];
    characters = json['characters'];
    creationTime = json['creation_time'];
    updateTime = json['update_time'];
    parent = json['parent'];
    graphType = json['graph_type'];
    if (json['alert_data'] != null) {
      productAlertData  = [];
      json['alert_data'].forEach((v) {
        productAlertData ?.add(ProductAlertData.fromJson(v));
      });
    }
    productAlertData != null ? isProductAlert = true : isProductAlert = false;

    // if (json['graph'] != null) {
    //   graph = [];
    //   json['graph'].forEach((v) {
    //     graph?.add(SingleProductGraph.fromJson(v));
    //   });
    // }
    //
    // final Map<String, SingleProductGraph> graphMap = {};
    // for (var item in graph!) {
    //   graphMap[item.date!] = item;
    // }
    // graph = graphMap.values.toList();
  }

  int? id;
  Brand? brand;
  List<SingleProductGraph>? graph;
  Image? image;
  int? type;
  String? name;
  String? description;
  int? listing;
  String? floorPrice;
  String? owner;
  String? edition;
  dynamic dropDate;
  dynamic listPrice;
  dynamic editions;
  dynamic editionType;
  dynamic season;
  String? rarity;
  dynamic license;
  dynamic series;
  String? coverVariant;
  String? coverArtist;
  String? publisher;
  String? issue;
  String? pages;
  String? startYear;
  String? writers;
  String? artists;
  String? characters;
  String? creationTime;
  String? updateTime;
  String? graphType;
  dynamic parent;
  List<ProductAlertData>? productAlertData;
  bool? isProductAlert;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['brand'] = brand;
    if (graph != null) {
      map['graph'] = graph?.map((v) => v.toJson()).toList();
    }
    if (image != null) {
      map['image'] = image?.toJson();
    }
    map['type'] = type;
    map['name'] = name;
    map['description'] = description;
    map['listing'] = listing;
    map['floor_price'] = floorPrice;
    map['owner'] = owner;
    map['edition'] = edition;
    map['drop_date'] = dropDate;
    map['list_price'] = listPrice;
    map['editions'] = editions;
    map['edition_type'] = editionType;
    map['season'] = season;
    map['rarity'] = rarity;
    map['license'] = license;
    map['series'] = series;
    map['cover_variant'] = coverVariant;
    map['cover_artist'] = coverArtist;
    map['publisher'] = publisher;
    map['issue'] = issue;
    map['pages'] = pages;
    map['start_year'] = startYear;
    map['writers'] = writers;
    map['artists'] = artists;
    map['characters'] = characters;
    map['creation_time'] = creationTime;
    map['update_time'] = updateTime;
    map['graph_type'] = graphType;
    map['parent'] = parent;
    if (productAlertData != null) {
      map['alert_data'] = productAlertData?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
class ProductAlertData {
  ProductAlertData({
    this.id,
    this.type,
    this.priceType,
    this.value,
    this.frequency,
    this.mintLow,
    this.mintUpper,
    this.product,
    this.user,
    this.typeValue,
    this.frequencyValue,
  });

  ProductAlertData.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    priceType = json['price_type'];
    value = json['value'];
    frequency = json['frequency'];
    mintLow = json['mint_low'];
    mintUpper = json['mint_upper'];
    product = json['product'];
    user = json['user'];

    if (priceType == 0) {
      typeValue = 'Price rises above';
    } else if (priceType == 1) {
      typeValue = 'Price drops under';
    } else if (priceType == 2) {
      typeValue = 'Price rises';
    } else if (priceType == 3) {
      typeValue = 'Price drops';
    }else if (priceType == 4) {
      typeValue = 'Below';
    }else if (priceType == 5) {
      typeValue = 'Above';
    }else if (priceType == 6) {
      typeValue = 'Between';
    }else if (priceType == 8) {
      typeValue = 'Is';
    } else {
      typeValue = 'none';
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
  int? mintLow;
  int? mintUpper;
  int? product;
  int? user;
  String? typeValue;
  String? frequencyValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['price_type'] = priceType;
    map['value'] = value;
    map['frequency'] = frequency;
    map['mint_low'] = mintLow;
    map['mint_upper'] = mintUpper;
    map['product'] = product;
    map['user'] = user;
    return map;
  }
}

class Image {
  Image({
    this.original,
    this.detail,
    this.direction,
    this.base_url,
    this.low_res_url,
    this.mid_res_url,
    this.high_res_url,
  });

  Image.fromJson(dynamic json) {
    original =
        json['original'] != null ? Original.fromJson(json['original']) : null;
    detail = json['detail'] != null ? Detail.fromJson(json['detail']) : null;
    direction = json['direction'];
    base_url = json['base_url'];
    low_res_url = json['low_res_url'];
    mid_res_url = json['mid_res_url'];
    high_res_url = json['high_res_url'];
  }

  Original? original;
  Detail? detail;
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
    if (detail != null) {
      map['detail'] = detail?.toJson();
    }
    map['direction'] = direction;
    map['base_url'] = base_url;
    map['low_res_url'] = low_res_url;
    map['mid_res_url'] = mid_res_url;
    map['high_res_url'] = high_res_url;
    return map;
  }
}

class Detail {
  Detail({
    this.src,
    this.width,
    this.height,
    this.alt,
  });

  Detail.fromJson(dynamic json) {
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

class SingleProductGraph {
  SingleProductGraph({
    this.floorPrice,
    this.creationTime,
    this.date,
    this.hourWiseTime,
    this.dayWiseTime,
    this.dayWiseTimeWithDate,
    this.monthWiseTime,
  });

  SingleProductGraph.fromJson(dynamic json) {
    floorPrice = json['floor_price'];
    creationTime = json['creation_time'];
    date = json['date'];
    if (date != null) {
      hourWiseTime = DateFormat('hh a').format(DateTime.parse(date!));
      dayWiseTime = DateFormat('EE').format(DateTime.parse(date!));
      dayWiseTimeWithDate = DateFormat('dd MMM').format(DateTime.parse(date!));
      monthWiseTime = DateFormat('MMM').format(DateTime.parse(date!));
    }
  }

  double? floorPrice;
  String? creationTime;
  String? date;
  String? hourWiseTime;
  String? dayWiseTime;
  String? dayWiseTimeWithDate;
  String? monthWiseTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['floor_price'] = floorPrice;
    map['creation_time'] = creationTime;
    map['date'] = date;
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
    this.priceChangePercent,
    this.graph,
  });

  Graph.fromJson(dynamic json) {
    priceChangePercent = json['priceChangePercent'];

    if (json['graph'] != null) {
      graph = [];
      json['graph'].forEach((v) {
        graph?.add(SingleProductGraph.fromJson(v));
      });
    }

    final Map<String, SingleProductGraph> graphMap = {};
    for (var item in graph!) {
      graphMap[item.date!] = item;
    }
    graph = graphMap.values.toList();
  }

  PriceChangePercent? priceChangePercent;
  List<SingleProductGraph>? graph;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['priceChangePercent'] = priceChangePercent;
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
