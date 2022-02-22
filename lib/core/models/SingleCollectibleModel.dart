class SingleCollectibleModel {
  SingleCollectibleModel({
    this.details,
    this.floorPrice,
  });

  SingleCollectibleModel.fromJson(dynamic json) {
    details =
        json['details'] != null ? Details.fromJson(json['details']) : null;
    floorPrice = json['floor_price'] != null
        ? FloorPrice.fromJson(json['floorPrice'])
        : null;
  }

  Details? details;
  FloorPrice? floorPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (details != null) {
      map['details'] = details?.toJson();
    }
    if (floorPrice != null) {
      map['floor_price'] = floorPrice?.toJson();
    }
    return map;
  }
}

class FloorPrice {
  FloorPrice({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  FloorPrice.fromJson(dynamic json) {
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
    this.date,
    this.time,
    this.floorPrice,
    this.collectible,
  });

  Results.fromJson(dynamic json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
    floorPrice = json['floor_price'];
    collectible = json['collectible'];
  }

  int? id;
  String? date;
  String? time;
  String? floorPrice;
  int? collectible;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['date'] = date;
    map['time'] = time;
    map['floor_price'] = floorPrice;
    map['collectible'] = collectible;
    return map;
  }
}

class Details {
  Details({
    this.id,
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
    this.brand,
    this.series,
  });

  Details.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    listing = json['listing'];
    floorPrice = json['floor_price'];
    owner = json['owner'];
    edition = json['edition'];
    dropDate = json['drop_date'];
    listPrice = json['list_price'];
    editions = json['editions'];
    editionType = json['edition_type'];
    season = json['season'];
    rarity = json['rarity'];
    license = json['license'];
    brand = json['brand'];
    series = json['series'];
  }

  int? id;
  String? name;
  String? description;
  int? listing;
  String? floorPrice;
  String? owner;
  String? edition;
  String? dropDate;
  String? listPrice;
  String? editions;
  String? editionType;
  String? season;
  String? rarity;
  String? license;
  String? brand;
  String? series;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
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
    map['brand'] = brand;
    map['series'] = series;
    return map;
  }
}
